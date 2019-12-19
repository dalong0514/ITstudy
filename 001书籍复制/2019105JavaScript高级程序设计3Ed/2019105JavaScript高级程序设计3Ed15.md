RelatedElementsExample01.htm

这个例子为 <div> 元素的 mouseout 事件注册了一个事件处理程序。当事件触发时，会有一个警告框显示鼠标移出和移入的元素信息。

6. 鼠标按钮

只有在主鼠标按钮被单击（或键盘回车键被按下）时才会触发 click 事件，因此检测按钮的信息并不是必要的。但对于 mousedown 和 mouseup 事件来说，则在其 event 对象存在一个 button 属性，表示按下或释放的按钮。DOM 的 button 属性可能有如下 3 个值：0 表示主鼠标按钮，1 表示中间的鼠标按钮（鼠标滚轮按钮），2 表示次鼠标按钮。在常规的设置中，主鼠标按钮就是鼠标左键，而次鼠标按钮就是鼠标右键。

IE8 及之前版本也提供了 button 属性，但这个属性的值与 DOM 的 button 属性有很大差异。

0：表示没有按下按钮。

1：表示按下了主鼠标按钮。

2：表示按下了次鼠标按钮。

3：表示同时按下了主、次鼠标按钮。

4：表示按下了中间的鼠标按钮。

5：表示同时按下了主鼠标按钮和中间的鼠标按钮。

6：表示同时按下了次鼠标按钮和中间的鼠标按钮。

7：表示同时按下了三个鼠标按钮。

不难想见，DOM 模型下的 button 属性比 IE 模型下的 button 属性更简单也更为实用，因为同时按下多个鼠标按钮的情形十分罕见。最常见的做法就是将 IE 模型规范化为 DOM 方式，毕竟除 IE8 及更早版本之外的其他浏览器都原生支持 DOM 模型。而对主、中、次按钮的映射并不困难，只要将 IE 的其他选项分别转换成如同按下这三个按键中的一个即可（同时将主按钮作为优先选取的对象）。换句话说，IE 中返回的 5 和 7 会被转换成 DOM 模型中的 0。

由于单独使用能力检测无法确定差异（两种模型有同名的 button 属性），因此必须另辟蹊径。我们知道，支持 DOM 版鼠标事件的浏览器可以通过 hasFeature () 方法来检测，所以可以再为 EventUtil 对象添加如下 getButton () 方法。

var EventUtil = {// 省略了其他代码 getButton: function (event){if (document.implementation.hasFeature ("MouseEvents", "2.0")){return event.button;} else {switch (event.button){case 0: case 1: case 3: case 5: case 7: return 0; case 2: case 6: return 2; case 4: return 1;} } }, // 省略了其他代码 };

EventUtil.js

通过检测 "MouseEvents" 这个特性，就可以确定 event 对象中存在的 button 属性中是否包含正确的值。如果测试失败，说明是 IE，就必须对相应的值进行规范化。以下是使用该方法的示例。

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "mousedown", function(event){ event = EventUtil.getEvent(event); alert(EventUtil.getButton(event)); });

ButtonExample01.htm

在这个例子中，我们为一个 <div> 元素添加了一个 onmousedown 事件处理程序。当在这个元素上按下鼠标按钮时，会有警告框显示按钮的代码。

在使用 onmouseup 事件处理程序时，button 的值表示释放的是哪个按钮。此外，如果不是按下或释放了主鼠标按钮，Opera 不会触发 mouseup 或 mousedown 事件。

7. 更多的事件信息

「DOM2 级事件」规范在 event 对象中还提供了 detail 属性，用于给出有关事件的更多信息。对于鼠标事件来说，detail 中包含了一个数值，表示在给定位置上发生了多少次单击。在同一个像素上相继地发生一次 mousedown 和一次 mouseup 事件算作一次单击。detail 属性从 1 开始计数，每次单击发生后都会递增。如果鼠标在 mousedown 和 mouseup 之间移动了位置，则 detail 会被重置为 0。

IE 也通过下列属性为鼠标事件提供了更多信息。

altLeft：布尔值，表示是否按下了 Alt 键。如果 altLeft 的值为 true，则 altKey 的值也为 true。

ctrlLeft：布尔值，表示是否按下了 Ctrl 键。如果 ctrlLeft 的值为 true，则 ctrlKey 的值也为 true。

offsetX：光标相对于目标元素边界的 x 坐标。

offsetY：光标相对于目标元素边界的 y 坐标。

shiftLeft：布尔值，表示是否按下了 Shift 键。如果 shiftLeft 的值为 true，则 shiftKey 的值也为 true。

这些属性的用处并不大，原因一方面是只有 IE 支持它们，另一方是它们提供的信息要么没有什么价值，要么可以通过其他方式计算得来。

8. 鼠标滚轮事件

IE 6.0 首先实现了 mousewheel 事件。此后，Opera、Chrome 和 Safari 也都实现了这个事件。当用户通过鼠标滚轮与页面交互、在垂直方向上滚动页面时（无论向上还是向下），就会触发 mousewheel 事件。这个事件可以在任何元素上面触发，最终会冒泡到 document（IE8）或 window（IE9、Opera、Chrome 及 Safari）对象。与 mousewheel 事件对应的 event 对象除包含鼠标事件的所有标准信息外，还包含一个特殊的 wheelDelta 属性。当用户向前滚动鼠标滚轮时，wheelDelta 是 120 的倍数；当用户向后滚动鼠标滚轮时，wheelDelta 是 - 120 的倍数。图 13-6 展示了这个属性。

图　13-6

将 mousewheel 事件处理程序指定给页面中的任何元素或 document 对象，即可处理鼠标滚轮的交互操作。来看下面的例子。

EventUtil.addHandler(document, "mousewheel", function(event){ event = EventUtil.getEvent(event); alert(event.wheelDelta); });

这个例子会在发生 mousewheel 事件时显示 wheelDelta 的值。多数情况下，只要知道鼠标滚轮滚动的方向就够了，而这通过检测 wheelDelta 的正负号就可以确定。

有一点要注意：在 Opera 9.5 之前的版本中，wheelDelta 值的正负号是颠倒的。如果你打算支持早期的 Opera 版本，就需要使用浏览器检测技术来确定实际的值，如下面的例子所示。

EventUtil.addHandler(document, "mousewheel", function(event){ event = EventUtil.getEvent(event); var delta = (client.engine.opera && client.engine.opera -event.wheelDelta : event.wheelDelta); alert(delta); });

MouseWheelEventExample01.htm

以上代码使用第 9 章创建的 client 对象检测了浏览器是不是早期版本的 Opera。

由于 mousewheel 事件非常流行，而且所有浏览器都支持它，所以 HTML 5 也加入了该事件。

Firefox 支持一个名为 DOMMouseScroll 的类似事件，也是在鼠标滚轮滚动时触发。与 mousewheel 事件一样，DOMMouseScroll 也被视为鼠标事件，因而包含与鼠标事件有关的所有属性。而有关鼠标滚轮的信息则保存在 detail 属性中，当向前滚动鼠标滚轮时，这个属性的值是 - 3 的倍数，当向后滚动鼠标滚轮时，这个属性的值是 3 的倍数。图 13-7 展示了这个属性。

图　13-7

可以将 DOMMouseScroll 事件添加到页面中的任何元素，而且该事件会冒泡到 window 对象。因此，可以像下面这样针对这个事件来添加事件处理程序。

EventUtil.addHandler(window, "DOMMouseScroll", function(event){ event = EventUtil.getEvent(event); alert(event.detail); });

DOMMouseScrollEventExample01.htm

这个简单的事件处理程序会在鼠标滚轮滚动时显示 detail 属性的值。

若要给出跨浏览器环境下的解决方案，第一步就是创建一个能够取得鼠标滚轮增量值（delta）的方法。下面是我们添加到 EventUtil 对象中的这个方法。

var EventUtil = {// 省略了其他代码 getWheelDelta: function (event){if (event.wheelDelta){return (client.engine.opera && client.engine.opera -event.wheelDelta : event.wheelDelta); } else {return -event.detail * 40;} }, // 省略了其他代码 };

EventUtil.js

这里，getWheelDelta () 方法首先检测了事件对象是否包含 wheelDelta 属性，如果是则通过浏览器检测代码确定正确的值。如果 wheelDelta 不存在，则假设相应的值保存在 detail 属性中。由于 Firefox 的值有所不同，因此首先要将这个值的符号反向，然后再乘以 40，就可以保证与其他浏览器的值相同了。有了这个方法之后，就可以将相同的事件处理程序指定给 mousewheel 和 DOMMouseScroll 事件了，例如：

(function(){ function handleMouseWheel(event){ event = EventUtil.getEvent(event); var delta = EventUtil.getWheelDelta(event); alert(delta); } EventUtil.addHandler(document, "mousewheel", handleMouseWheel); EventUtil.addHandler(document, "DOMMouseScroll", handleMouseWheel); })();

CrossBrowserMouseWheelExample01.htm

我们将相关代码放在了一个私有作用域中，从而不会让新定义的函数干扰全局作用域。这里定义的 handleMouseWheel () 函数可以用作两个事件的处理程序（如果指定的事件不存在，则为该事件指定处理程序的代码就会静默地失败）。由于使用了 EventUtil.getWheelDelta () 方法，我们定义的这个事件处理程序函数可以适用于任何一种情况。

9. 触摸设备

iOS 和 Android 设备的实现非常特别，因为这些设备没有鼠标。在面向 iPhone 和 iPod 中的 Safari 开发时，要记住以下几点。

不支持 dblclick 事件。双击浏览器窗口会放大画面，而且没有办法改变该行为。

轻击可单击元素会触发 mousemove 事件。如果此操作会导致内容变化，将不再有其他事件发生；如果屏幕没有因此变化，那么会依次发生 mousedown、mouseup 和 click 事件。轻击不可单击的元素不会触发任何事件。可单击的元素是指那些单击可产生默认操作的元素（如链接），或者那些已经被指定了 onclick 事件处理程序的元素。

mousemove 事件也会触发 mouseover 和 mouseout 事件。

两个手指放在屏幕上且页面随手指移动而滚动时会触发 mousewheel 和 scroll 事件。

10. 无障碍性问题

如果你的 Web 应用程序或网站要确保残疾人特别是那些使用屏幕阅读器的人都能访问，那么在使用鼠标事件时就要格外小心。前面提到过，可以通过键盘上的回车键来触发 click 事件，但其他鼠标事件却无法通过键盘来触发。为此，我们不建议使用 click 之外的其他鼠标事件来展示功能或引发代码执行。因为这样会给盲人或视障用户造成极大不便。以下是在使用鼠标事件时应当注意的几个易访问性问题。

使用 click 事件执行代码。有人指出通过 onmousedown 执行代码会让人觉得速度更快，对视力正常的人来说这是没错的。但是，在屏幕阅读器中，由于无法触发 mousedown 事件，结果就会造成代码无法执行。

不要使用 onmouseover 向用户显示新的选项。原因同上，屏幕阅读器无法触发这个事件。如果确实非要通过这种方式来显示新选项，可以考虑添加显示相同信息的键盘快捷方式。

不要使用 dblclick 执行重要的操作。键盘无法触发这个事件。

遵照以上提示可以极大地提升残疾人在访问你的 Web 应用程序或网站时的易访问性。

要了解如何在网页中实现无障碍访问的内容，请访问 www.webaim.org 和 http://yaccessibilityblog.com/。

13.4.4　键盘与文本事件

用户在使用键盘时会触发键盘事件。「DOM2 级事件」最初规定了键盘事件，但在最终定稿之前又删除了相应的内容。结果，对键盘事件的支持主要遵循的是 DOM0 级。

「DOM3 级事件」为键盘事件制定了规范，IE9 率先完全实现了该规范。其他浏览器也在着手实现这一标准，但仍然有很多遗留的问题。

有 3 个键盘事件，简述如下。

keydown：当用户按下键盘上的任意键时触发，而且如果按住不放的话，会重复触发此事件。

keypress：当用户按下键盘上的字符键时触发，而且如果按住不放的话，会重复触发此事件。按下 Esc 键也会触发这个事件。Safari 3.1 之前的版本也会在用户按下非字符键时触发 keypress 事件。

keyup：当用户释放键盘上的键时触发。

虽然所有元素都支持以上 3 个事件，但只有在用户通过文本框输入文本时才最常用到。

只有一个文本事件：textInput。这个事件是对 keypress 的补充，用意是在将文本显示给用户之前更容易拦截文本。在文本插入文本框之前会触发 textInput 事件。

在用户按了一下键盘上的字符键时，首先会触发 keydown 事件，然后紧跟着是 keypress 事件，最后会触发 keyup 事件。其中，keydown 和 keypress 都是在文本框发生变化之前被触发的；而 keyup 事件则是在文本框已经发生变化之后被触发的。如果用户按下了一个字符键不放，就会重复触发 keydown 和 keypress 事件，直到用户松开该键为止。

如果用户按下的是一个非字符键，那么首先会触发 keydown 事件，然后就是 keyup 事件。如果按住这个非字符键不放，那么就会一直重复触发 keydown 事件，直到用户松开这个键，此时会触发 keyup 事件。

键盘事件与鼠标事件一样，都支持相同的修改键。而且，键盘事件的事件对象中也有 shiftKey、ctrlKey、altKey 和 metaKey 属性。IE 不支持 metaKey。

1. 键码

在发生 keydown 和 keyup 事件时，event 对象的 keyCode 属性中会包含一个代码，与键盘上一个特定的键对应。对数字字母字符键，keyCode 属性的值与 ASCII 码中对应小写字母或数字的编码相同。因此，数字键 7 的 keyCode 值为 55，而字母 A 键的 keyCode 值为 65—— 与 Shift 键的状态无关。DOM 和 IE 的 event 对象都支持 keyCode 属性。请看下面这个例子：

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "keyup", function(event){ event = EventUtil.getEvent(event); alert(event.keyCode); });

KeyUpEventExample01.htm

在这个例子中，用户每次在文本框中按键触发 keyup 事件时，都会显示 keyCode 的值。下表列出了所有非字符键的键码。

键 键　　码

退格（Backspace） 8

制表（Tab） 9

回车（Enter） 13

上档（Shift） 16

控制（Ctrl） 17

Alt 18

暂停 / 中断（Pause/Break） 19

大写锁定（Caps Lock） 20

退出（Esc） 27

上翻页（Page Up） 33

下翻页（Page Down） 34

结尾（End） 35

开头（Home） 36

左箭头（Left Arrow） 37

上箭头（Up Arrow） 38

右箭头（Right Arrow） 39

下箭头（Down Arrow） 40

插入（Ins） 45

删除（Del） 46

左 Windows 键 91

右 Windows 键 92

上下文菜单键 93

数字小键盘 0 96

数字小键盘 1 97

数字小键盘 2 98

数字小键盘 3 99

数字小键盘 4 100

数字小键盘 5 101

数字小键盘 6 102

数字小键盘 7 103

数字小键盘 8 104

数字小键盘 9 105

数字小键盘 + 107

数字小键盘及大键盘上的 - 109

数字小键盘 . 110

数字小键盘 / 111

F1 112

F2 113

F3 114

F4 115

F5 116

F6 117

F7 118

F8 119

F9 120

F10 121

F11 122

F12 123

数字锁（Num Lock） 144

滚动锁（Scroll Lock） 145

分号（IE/Safari/Chrome 中） 186

分号（Opera/FF 中） 59

小于 188

大于 190

正斜杠 191

沉音符（`） 192

等于 61

左方括号 219

反斜杠（\） 220

右方括号 221

单引号 222

无论 keydown 或 keyup 事件都会存在的一些特殊情况。在 Firefox 和 Opera 中，按分号键时 keyCode 值为 59，也就是 ASCII 中分号的编码；但 IE 和 Safari 返回 186，即键盘中按键的键码。

2. 字符编码

发生 keypress 事件意味着按下的键会影响到屏幕中文本的显示。在所有浏览器中，按下能够插入或删除字符的键都会触发 keypress 事件；按下其他键能否触发此事件因浏览器而异。由于截止到 2008 年，尚无浏览器实现「DOM3 级事件」规范，所以浏览器之间的键盘事件并没有多大的差异。

IE9、Firefox、Chrome 和 Safari 的 event 对象都支持一个 charCode 属性，这个属性只有在发生 keypress 事件时才包含值，而且这个值是按下的那个键所代表字符的 ASCII 编码。此时的 keyCode 通常等于 0 或者也可能等于所按键的键码。IE8 及之前版本和 Opera 则是在 keyCode 中保存字符的 ASCII 编码。要想以跨浏览器的方式取得字符编码，必须首先检测 charCode 属性是否可用，如果不可用则使用 keyCode，如下面的例子所示。

var EventUtil = {// 省略的代码 getCharCode: function (event){if (typeof event.charCode == "number"){return event.charCode;} else {return event.keyCode;} }, // 省略的代码 };

EventUtil.js

这个方法首先检测 charCode 属性是否包含数值（在不支持这个属性的浏览器中，值为 undefined），如果是，则返回该值。否则，就返回 keyCode 属性值。下面是使用这个方法的示例。

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); alert(EventUtil.getCharCode(event)); });

KeyPressEventExample01.htm

在取得了字符编码之后，就可以使用 String.fromCharCode () 将其转换成实际的字符。

3. DOM3 级变化

尽管所有浏览器都实现了某种形式的键盘事件，DOM3 级事件还是做出了一些改变。比如，DOM3 级事件中的键盘事件，不再包含 charCode 属性，而是包含两个新属性：key 和 char。

其中，key 属性是为了取代 keyCode 而新增的，它的值是一个字符串。在按下某个字符键时，key 的值就是相应的文本字符（如「k」或「M」）；在按下非字符键时，key 的值是相应键的名（如「Shift」或「Down」）。而 char 属性在按下字符键时的行为与 key 相同，但在按下非字符键时值为 null。

IE9 支持 key 属性，但不支持 char 属性。Safari 5 和 Chrome 支持名为 keyIdentifier 的属性，在按下非字符键（例如 Shift）的情况下与 key 的值相同。对于字符键，keyIdentifier 返回一个格式类似「U+0000」的字符串，表示 Unicode 值。

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); var identifier = event.key || event.keyIdentifier; if (identifier){ alert(identifi er); } });

DOMLevel3KeyPropertyExample01.htm

由于存在跨浏览器问题，因此本书不推荐使用 key、keyIdentifier 或 char。

DOM3 级事件还添加了一个名为 location 的属性，这是一个数值，表示按下了什么位置上的键：0 表示默认键盘，1 表示左侧位置（例如左位的 Alt 键），2 表示右侧位置（例如右侧的 Shift 键），3 表示数字小键盘，4 表示移动设备键盘（也就是虚拟键盘），5 表示手柄（如任天堂 Wii 控制器）。IE9 支持这个属性。Safari 和 Chrome 支持名为 keyLocation 的等价属性，但即有 bug—— 值始终是 0，除非按下了数字键盘（此时，值 为 3）；否则，不会是 1、2、4、5。

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); var loc = event.location || event.keyLocation; if (loc){ alert(loc); } });

DOMLevel3LocationPropertyExample01.htm

与 key 属性一样，支持 location 的浏览器也不多，所以在跨浏览器开发中不推荐使用。

最后是给 event 对象添加了 getModifierState () 方法。这个方法接收一个参数，即等于 Shift、Control、AltGraph 或 Meta 的字符串，表示要检测的修改键。如果指定的修改键是活动的（也就是处于被按下的状态），这个方法返回 true，否则返回 false。

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); if (event.getModifierState){ alert(event.getModifierState("Shift")); } });

DOMLevel3LocationGetModifierStateExample01.htm

实际上，通过 event 对象的 shiftKey、altKey、ctrlKey 和 metaKey 属性已经可以取得类似的属性了。IE9 是唯一支持 getModifierState () 方法的浏览器。

4. textInput 事件

「DOM3 级事件」规范中引入了一个新事件，名叫 textInput。根据规范，当用户在可编辑区域中输入字符时，就会触发这个事件。这个用于替代 keypress 的 textInput 事件的行为稍有不同。区别之一就是任何可以获得焦点的元素都可以触发 keypress 事件，但只有可编辑区域才能触发 textInput 事件。区别之二是 textInput 事件只会在用户按下能够输入实际字符的键时才会被触发，而 keypress 事件则在按下那些能够影响文本显示的键时也会触发（例如退格键）。

由于 textInput 事件主要考虑的是字符，因此它的 event 对象中还包含一个 data 属性，这个属性的值就是用户输入的字符（而非字符编码）。换句话说，用户在没有按上档键的情况下按下了 S 键，data 的值就是 "s"，而如果在按住上档键时按下该键，data 的值就是 "S"。

以下是一个使用 textInput 事件的例子：

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "textInput", function(event){ event = EventUtil.getEvent(event); alert(event.data); });

TextInputEventExample01.htm

在这个例子中，插入到文本框中的字符会通过一个警告框显示出来。

另外，event 对象上还有一个属性，叫 inputMethod，表示把文本输入到文本框中的方式。

0，表示浏览器不确定是怎么输入的。

1，表示是使用键盘输入的。

2，表示文本是粘贴进来的。

3，表示文本是拖放进来的。

4，表示文本是使用 IME 输入的。

5，表示文本是通过在表单中选择某一项输入的。

6，表示文本是通过手写输入的（比如使用手写笔）。

7，表示文本是通过语音输入的。

8，表示文本是通过几种方法组合输入的。

9，表示文本是通过脚本输入的。

使用这个属性可以确定文本是如何输入到控件中的，从而可以验证其有效性。支持 textInput 属性的浏览器有 IE9+、Safari 和 Chrome。只有 IE 支持 inputMethod 属性。

5. 设备中的键盘事件

任天堂 Wii 会在用户按下 Wii 遥控器上的按键时触发键盘事件。尽管没有办法访问 Wii 遥控器中的所有按键，但还是有一些键可以触发键盘事件。图 13-6 展示了一些键的键码，通过这些键码可以知道用户按下了哪个键。

图　13-8

当用户按下十字键盘（键码为 175～178）、减号（170）、加号（174）、1（172）或 2（173）键时就会触发键盘事件。但没有办法得知用户是否按下了电源开关、A、B 或主页键。

iOS 版 Safari 和 Android 版 WebKit 在使用屏幕键盘时会触发键盘事件。

13.4.5　复合事件

复合事件（composition event）是 DOM3 级事件中新添加的一类事件，用于处理 IME 的输入序列。IME（Input Method Editor，输入法编辑器）可以让用户输入在物理键盘上找不到的字符。例如，使用拉丁文键盘的用户通过 IME 照样能输入日文字符。IME 通常需要同时按住多个键，但最终只输入一个字符。复合事件就是针对检测和处理这种输入而设计的。有以下三种复合事件。

compositionstart：在 IME 的文本复合系统打开时触发，表示要开始输入了。

compositionupdate：在向输入字段中插入新字符时触发。

compositionend：在 IME 的文本复合系统关闭时触发，表示返回正常键盘输入状态。

复合事件与文本事件在很多方面都很相似。在触发复合事件时，目标是接收文本的输入字段。但它比文本事件的事件对象多一个属性 data，其中包含以下几个值中的一个：

如果在 compositionstart 事件发生时访问，包含正在编辑的文本（例如，已经选中的需要马上替换的文本）；

如果在 compositionupdate 事件发生时访问，包含正插入的新字符；

如果在 compositionend 事件发生时访问，包含此次输入会话中插入的所有字符。

与文本事件一样，必要时可以利用复合事件来筛选输入。可以像下面这样使用它们：

var textbox = document.getElementById("myText"); EventUtil.addHandler(textbox, "compositionstart", function(event){ event = EventUtil.getEvent(event); alert(event.data); }); EventUtil.addHandler(textbox, "compositionupdate", function(event){ event = EventUtil.getEvent(event); alert(event.data); }); EventUtil.addHandler(textbox, "compositionend", function(event){ event = EventUtil.getEvent(event); alert(event.data); });

CompositionEventsExample01.htm

IE9 + 是到 2011 年唯一支持复合事件的浏览器。由于缺少支持，对于需要开发跨浏览器应用的开发人员，它的用处不大。要确定浏览器是否支持复合事件，可以使用以下代码：

var isSupported = document.implementation.hasFeature("CompositionEvent", "3.0");

13.4.6　变动事件

DOM2 级的变动（mutation）事件能在 DOM 中的某一部分发生变化时给出提示。变动事件是为 XML 或 HTML DOM 设计的，并不特定于某种语言。DOM2 级定义了如下变动事件。

DOMSubtreeModified：在 DOM 结构中发生任何变化时触发。这个事件在其他任何事件触发后都会触发。

DOMNodeInserted：在一个节点作为子节点被插入到另一个节点中时触发。

DOMNodeRemoved：在节点从其父节点中被移除时触发。

DOMNodeInsertedIntoDocument：在一个节点被直接插入文档或通过子树间接插入文档之后触发。这个事件在 DOMNodeInserted 之后触发。

DOMNodeRemovedFromDocument：在一个节点被直接从文档中移除或通过子树间接从文档中移除之前触发。这个事件在 DOMNodeRemoved 之后触发。

DOMAttrModified：在特性被修改之后触发。

DOMCharacterDataModified：在文本节点的值发生变化时触发。

使用下列代码可以检测出浏览器是否支持变动事件：

var isSupported = document.implementation.hasFeature("MutationEvents", "2.0");

IE8 及更早版本不支持任何变动事件。下表列出了不同浏览器对不同变动事件的支持情况。

事　　件 Opera 9+ Firefox 3+ Safari 3 + 及 Chrome IE9+

DOMSubtreeModified － 支持 支持 支持

DOMNodeInserted 支持 支持 支持 支持

DOMNodeRemoved 支持 支持 支持 支持

由于 DOM3 级事件模块作废了很多变动事件，所以本节只介绍那些将来仍然会得到支持的事件。

1. 删除节点

在使用 removeChild () 或 replaceChild () 从 DOM 中删除节点时，首先会触发 DOMNodeRemoved 事件。这个事件的目标（event.target）是被删除的节点，而 event.relatedNode 属性中包含着对目标节点父节点的引用。在这个事件触发时，节点尚未从其父节点删除，因此其 parentNode 属性仍然指向父节点（与 event.relatedNode 相同）。这个事件会冒泡，因而可以在 DOM 的任何层次上面处理它。

如果被移除的节点包含子节点，那么在其所有子节点以及这个被移除的节点上会相继触发 DOMNodeRemovedFromDocument 事件。但这个事件不会冒泡，所以只有直接指定给其中一个子节点的事件处理程序才会被调用。这个事件的目标是相应的子节点或者那个被移除的节点，除此之外 event 对象中不包含其他信息。

紧随其后触发的是 DOMSubtreeModified 事件。这个事件的目标是被移除节点的父节点；此时的 event 对象也不会提供与事件相关的其他信息。

为了理解上述事件的触发过程，下面我们就以一个简单的 HTML 页面为例。

<! DOCTYPE html> <html> <head> <title>Node Removal Events Example</title> </head> <body> <ul id="myList"> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul> </body> </html>

在这个例子中，我们假设要移除 <ul> 元素。此时，就会依次触发以下事件。

在 <ul> 元素上触发 DOMNodeRemoved 事件。relatedNode 属性等于 document.body。

在 <ul> 元素上触发 DOMNodeRemovedFromDocument 事件。

在身为 <ul> 元素子节点的每个 <li> 元素及文本节点上触发 DOMNodeRemovedFromDocument 事件。

在 document.body 上触发 DOMSubtreeModified 事件，因为 <ul> 元素是 document.body 的直接子元素。

运行下列代码可以验证以上事件发生的顺序。

EventUtil.addHandler(window, "load", function(event){ var list = document.getElementById("myList"); EventUtil.addHandler(document, "DOMSubtreeModified", function(event){ alert(event.type); alert(event.target); }); EventUtil.addHandler(document, "DOMNodeRemoved", function(event){ alert(event.type); alert(event.target); alert(event.relatedNode); }); EventUtil.addHandler(list.firstChild, "DOMNodeRemovedFromDocument", function(event){ alert(event.type); alert(event.target); }); list.parentNode.removeChild(list); });

以上代码为 document 添加了针对 DOMSubtreeModified 和 DOMNodeRemoved 事件的处理程序，以便在页面上处理这些事件。由于 DOMNodeRemovedFromDocument 不会冒泡，所以我们将针对它的事件处理程序直接添加给了 <ul> 元素的第一个子节点（在兼容 DOM 的浏览器中是一个文本节点）。在设置了以上事件处理程序后，代码从文档中移除了 <ul> 元素。

2. 插入节点

在使用 appendChild ()、replaceChild () 或 insertBefore () 向 DOM 中插入节点时，首先会触发 DOMNodeInserted 事件。这个事件的目标是被插入的节点，而 event.relatedNode 属性中包含一个对父节点的引用。在这个事件触发时，节点已经被插入到了新的父节点中。这个事件是冒泡的，因此可以在 DOM 的各个层次上处理它。

紧接着，会在新插入的节点上面触发 DOMNodeInsertedIntoDocument 事件。这个事件不冒泡，因此必须在插入节点之前为它添加这个事件处理程序。这个事件的目标是被插入的节点，除此之外 event 对象中不包含其他信息。

最后一个触发的事件是 DOMSubtreeModified，触发于新插入节点的父节点。

我们仍以前面的 HTML 文档为例，可以通过下列 JavaScript 代码来验证上述事件的触发顺序。

EventUtil.addHandler(window, "load", function(event){ var list = document.getElementById("myList"); var item = document.createElement("li"); item.appendChild(document.createTextNode("Item 4")); EventUtil.addHandler(document, "DOMSubtreeModified", function(event){ alert(event.type); alert(event.target); }); EventUtil.addHandler(document, "DOMNodeInserted", function(event){ alert(event.type); alert(event.target); alert(event.relatedNode); }); EventUtil.addHandler(item, "DOMNodeInsertedIntoDocument", function(event){ alert(event.type); alert(event.target); }); list.appendChild(item); });

以上代码首先创建了一个包含文本 "Item 4" 的新 <li> 元素。由于 DOMSubtreeModified 和 DOMNodeInserted 事件是冒泡的，所以把它们的事件处理程序添加到了文档中。在将列表项插入到其父节点之前，先将 DOMNodeInsertedIntoDocument 事件的事件处理程序添加给它。最后一步就是使用 appendChild () 来添加这个列表项；此时，事件开始依次被触发。首先是在新 < li> 元素项上触发 DOMNodeInserted 事件，其 relatedNode 是 <ul> 元素。然后是触发新 <li> 元素上的 DOMNodeInsertedIntoDocument 事件，最后触发的是 <ul> 元素上的 DOMSubtreeModified 事件。

13.4.7　HTML5 事件

DOM 规范没有涵盖所有浏览器支持的所有事件。很多浏览器出于不同的目的 —— 满足用户需求或解决特殊问题，还实现了一些自定义的事件。HTML5 详尽列出了浏览器应该支持的所有事件。本节只讨论其中得到浏览器完善支持的事件，但并非全部事件。（其他事件会在本书其他章节讨论。）

1. contextmenu 事件

Windows 95 在 PC 中引入了上下文菜单的概念，即通过单击鼠标右键可以调出上下文菜单。不久，这个概念也被引入了 Web 领域。为了实现上下文菜单，开发人员面临的主要问题是如何确定应该显示上下文菜单（在 Windows 中，是右键单击；在 Mac 中，是 Ctrl + 单击），以及如何屏蔽与该操作关联的默认上下文菜单。为解决这个问题，就出现了 contextmenu 这个事件，用以表示何时应该显示上下文菜单，以便开发人员取消默认的上下文菜单而提供自定义的菜单。

由于 contextmenu 事件是冒泡的，因此可以为 document 指定一个事件处理程序，用以处理页面中发生的所有此类事件。这个事件的目标是发生用户操作的元素。在所有浏览器中都可以取消这个事件：在兼容 DOM 的浏览器中，使用 event.preventDefalut ()；在 IE 中，将 event.returnValue 的值设置为 false。因为 contextmenu 事件属于鼠标事件，所以其事件对象中包含与光标位置有关的所有属性。通常使用 contextmenu 事件来显示自定义的上下文菜单，而使用 onclick 事件处理程序来隐藏该菜单。以下面的 HTML 页面为例。

<!DOCTYPE html> <html> <head> <title>ContextMenu Event Example</title> </head> <body> <div id="myDiv">Right click or Ctrl+click me to get a custom context menu. Click anywhere else to get the default context menu.</div> <ul id="myMenu" style="position:absolute;visibility:hidden;background-color: silver"> <li><a href="http://www.nczonline.net">Nicholas’ site</a></li> <li><a href="http://www.wrox.com">Wrox site</a></li> <li><a href="http://www.yahoo.com">Yahoo!</a></li> </ul> </body> </html>

ContextMenuEventExample01.htm

这里的 <div> 元素包含一个自定义的上下文菜单。其中，<ul> 元素作为自定义上下文菜单，并且在初始时是隐藏的。实现这个例子的 JavaScript 代码如下所示。

EventUtil.addHandler(window, "load", function(event){ var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "contextmenu", function(event){ event = EventUtil.getEvent(event); EventUtil.preventDefault(event); var menu = document.getElementById("myMenu"); menu.style.left = event.clientX + "px"; menu.style.top = event.clientY + "px"; menu.style.visibility = "visible"; }); EventUtil.addHandler(document, "click", function(event){ document.getElementById("myMenu").style.visibility = "hidden"; }); });

ContextMenuEventExample01.htm

在这个例子中，我们为 <div> 元素添加了 oncontextmenu 事件的处理程序。这个事件处理程序首先会取消默认行为，以保证不显示浏览器默认的上下文菜单。然后，再根据 event 对象 clientX 和 clientY 属性的值，来确定放置 <ul> 元素的位置。最后一步就是通过将 visibility 属性设置为 "visible" 来显示自定义上下文菜单。另外，还为 document 添加了一个 onclick 事件处理程序，以便用户能够通过鼠标单击来隐藏菜单（单击也是隐藏系统上下文菜单的默认操作）。

虽然这个例子很简单，但它却展示了 Web 上所有自定义上下文菜单的基本结构。只需为这个例子中的上下文菜单添加一些 CSS 样式，就可以得到非常棒的效果。

支持 contextmenu 事件的浏览器有 IE、Firefox、Safari、Chrome 和 Opera 11+。

2.beforeunload 事件

之所以有发生在 window 对象上的 beforeunload 事件，是为了让开发人员有可能在页面卸载前阻止这一操作。这个事件会在浏览器卸载页面之前触发，可以通过它来取消卸载并继续使用原有页面。但是，不能彻底取消这个事件，因为那就相当于让用户无法离开当前页面了。为此，这个事件的意图是将控制权交给用户。显示的消息会告知用户页面行将被卸载（正因为如此才会显示这个消息），询问用户是否真的要关闭页面，还是希望继续留下来（见图 13-9）。

图　13-9

为了显示这个弹出对话框，必须将 event.returnValue 的值设置为要显示给用户的字符串（对 IE 及 Fiefox 而言），同时作为函数的值返回（对 Safari 和 Chrome 而言），如下面的例子所示。

EventUtil.addHandler(window, "beforeunload", function(event){ event = EventUtil.getEvent(event); var message = "I'm really going to miss you if you go."; event.returnValue = message; return message; });

BeforeUnloadEventExample01.htm

IE 和 Firefox、Safari 和 Chrome 都支持 beforeunload 事件，也都会弹出这个对话框询问用户是否真想离开。Opera 11 及之前的版本不支持 beforeunload 事件。

3. DOMContentLoaded 事件

如前所述，window 的 load 事件会在页面中的一切都加载完毕时触发，但这个过程可能会因为要加载的外部资源过多而颇费周折。而 DOMContentLoaded 事件则在形成完整的 DOM 树之后就会触发，不理会图像、JavaScript 文件、CSS 文件或其他资源是否已经下载完毕。与 load 事件不同，DOMContentLoaded 支持在页面下载的早期添加事件处理程序，这也就意味着用户能够尽早地与页面进行交互。

要处理 DOMContentLoaded 事件，可以为 document 或 window 添加相应的事件处理程序（尽管这个事件会冒泡到 window，但它的目标实际上是 document）。来看下面的例子。

EventUtil.addHandler(document, "DOMContentLoaded", function(event){ alert("Content loaded"); });

DOMContentLoadedEventExample01.htm

DOMContentLoaded 事件对象不会提供任何额外的信息（其 target 属性是 document）。

IE9+、Firefox、Chrome、Safari 3.1 + 和 Opera 9 + 都支持 DOMContentLoaded 事件，通常这个事件既可以添加事件处理程序，也可以执行其他 DOM 操作。这个事件始终都会在 load 事件之前触发。

对于不支持 DOMContentLoaded 的浏览器，我们建议在页面加载期间设置一个时间为 0 毫秒的超时调用，如下面的例子所示。

setTimeout (function (){// 在此添加事件处理程序}, 0);

这段代码的实际意思就是：「在当前 JavaScript 处理完成后立即运行这个函数。」在页面下载和构建期间，只有一个 JavaScript 处理过程，因此超时调用会在该过程结束时立即触发。至于这个时间与 DOMContentLoaded 被触发的时间能否同步，主要还是取决于用户使用的浏览器和页面中的其他代码。为了确保这个方法有效，必须将其作为页面中的第一个超时调用；即便如此，也还是无法保证在所有环境中该超时调用一定会早于 load 事件被触发。

4. readystatechange 事件

IE 为 DOM 文档中的某些部分提供了 readystatechange 事件。这个事件的目的是提供与文档或元素的加载状态有关的信息，但这个事件的行为有时候也很难预料。支持 readystatechange 事件的每个对象都有一个 readyState 属性，可能包含下列 5 个值中的一个。

uninitialized（未初始化）：对象存在但尚未初始化。

loading（正在加载）：对象正在加载数据。

loaded（加载完毕）：对象加载数据完成。

interactive（交互）：可以操作对象了，但还没有完全加载。

complete（完成）：对象已经加载完毕。

这些状态看起来很直观，但并非所有对象都会经历 readyState 的这几个阶段。换句话说，如果某个阶段不适用某个对象，则该对象完全可能跳过该阶段；并没有规定哪个阶段适用于哪个对象。显然，这意味着 readystatechange 事件经常会少于 4 次，而 readyState 属性的值也不总是连续的。

对于 document 而言，值为 "interactive" 的 readyState 会在与 DOMContentLoaded 大致相同的时刻触发 readystatechange 事件。此时，DOM 树已经加载完毕，可以安全地操作它了，因此就会进入交互（interactive）阶段。但与此同时，图像及其他外部文件不一定可用。下面来看一段处理 readystatechange 事件的代码。

EventUtil.addHandler(document, "readystatechange", function(event){ if (document.readyState == "interactive"){ alert("Content loaded"); } });

这个事件的 event 对象不会提供任何信息，也没有目标对象。

在与 load 事件一起使用时，无法预测两个事件触发的先后顺序。在包含较多或较大的外部资源的页面中，会在 load 事件触发之前先进入交互阶段；而在包含较少或较小的外部资源的页面中，则很难说 readystatechange 事件会发生在 load 事件前面。

让问题变得更复杂的是，交互阶段可能会早于也可能会晚于完成阶段出现，无法确保顺序。在包含较多外部资源的页面中，交互阶段更有可能早于完成阶段出现；而在页面中包含较少外部资源的情况下，完成阶段先于交互阶段出现的可能性更大。因此，为了尽可能抢到先机，有必要同时检测交互和完成阶段，如下面的例子所示。

EventUtil.addHandler(document, "readystatechange", function(event){ if (document.readyState == "interactive" || document.readyState == "complete"){ EventUtil.removeHandler(document, "readystatechange", arguments.callee); alert("Content loaded"); } });

对于上面的代码来说，当 readystatechange 事件触发时，会检测 document.readyState 的值，看当前是否已经进入交互阶段或完成阶段。如果是，则移除相应的事件处理程序以免在其他阶段再执行。注意，由于事件处理程序使用的是匿名函数，因此这里使用了 arguments.callee 来引用该函数。然后，会显示一个警告框，说明内容已经加载完毕。这样编写代码可以达到与使用 DOMContentLoaded 十分相近的效果。

支持 readystatechange 事件的浏览器有 IE、Firfox 4 + 和 Opera。

虽然使用 readystatechange 可以十分近似地模拟 DOMContentLoaded 事件，但它们本质上还是不同的。在不同页面中，load 事件与 readystatechange 事件并不能保证以相同的顺序触发。

另外，<script>（在 IE 和 Opera 中）和 <link>（仅 IE 中）元素也会触发 readystatechange 事件，可以用来确定外部的 JavaScript 和 CSS 文件是否已经加载完成。与在其他浏览器中一样，除非把动态创建的元素添加到页面中，否则浏览器不会开始下载外部资源。基于元素触发的 readystatechange 事件也存在同样的问题，即 readyState 属性无论等于 "loaded" 还是 "complete" 都可以表示资源已经可用。有时候，readyState 会停在 "loaded" 阶段而永远不会「完成」；有时候，又会跳过 "loaded" 阶段而直接「完成」。于是，还需要像对待 document 一样采取相同的编码方式。例如，下面展示了一段加载外部 JavaScript 文件的代码。

EventUtil.addHandler(window, "load", function(){ var script = document.createElement("script"); EventUtil.addHandler(script, "readystatechange", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (target.readyState == "loaded" || target.readyState == "complete"){ EventUtil.removeHandler(target, "readystatechange", arguments. callee); alert("Script Loaded"); } }); script.src = "example.js"; document.body.appendChild(script); });

ReadyStateChangeEventExample01.htm

这个例子为新创建的 <script> 节点指定了一个事件处理程序。事件的目标是该节点本身，因此当触发 readystatechange 事件时，要检测目标的 readyState 属性是不是等于 "loaded" 或 "complete"。如果进入了其中任何一个阶段，则移除事件处理程序（以防止被执行两次），并显示一个警告框。与此同时，就可以执行已经加载完毕的外部文件中的函数了。

同样的编码方式也适用于通过 <link> 元素加载 CSS 文件的情况，如下面的例子所示。

EventUtil.addHandler(window, "load", function(){ var link = document.createElement("link"); link.type = "text/css"; link.rel= "stylesheet"; EventUtil.addHandler(script, "readystatechange", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (target.readyState == "loaded" || target.readyState == "complete"){ EventUtil.removeHandler(target, "readystatechange", arguments. callee); alert("CSS Loaded"); } }); link.href = "example.css"; document.getElementsByTagName("head")[0].appendChild(link); });

ReadyStateChangeEventExample02.htm

同样，最重要的是要一并检测 readyState 的两个状态，并在调用了一次事件处理程序后就将其移除。

5. pageshow 和 pagehide 事件

Firefox 和 Opera 有一个特性，名叫「往返缓存」（back-forward cache，或 bfcache），可以在用户使用浏览器的「后退」和「前进」按钮时加快页面的转换速度。这个缓存中不仅保存着页面数据，还保存了 DOM 和 JavaScript 的状态；实际上是将整个页面都保存在了内存里。如果页面位于 bfcache 中，那么再次打开该页面时就不会触发 load 事件。尽管由于内存中保存了整个页面的状态，不触发 load 事件也不应该会导致什么问题，但为了更形象地说明 bfcache 的行为，Firefox 还是提供了一些新事件。

第一个事件就是 pageshow，这个事件在页面显示时触发，无论该页面是否来自 bfcache。在重新加载的页面中，pageshow 会在 load 事件触发后触发；而对于 bfcache 中的页面，pageshow 会在页面状态完全恢复的那一刻触发。另外要注意的是，虽然这个事件的目标是 document，但必须将其事件处理程序添加到 window。来看下面的例子。

(function(){ var showCount = 0; EventUtil.addHandler(window, "load", function(){ alert("Load fired"); }); EventUtil.addHandler(window, "pageshow", function(){ showCount++; alert("Show has been fired " + showCount + " times."); }); })();

这个例子使用了私有作用域，以防止变量 showCount 进入全局作用域。当页面首次加载完成时，showCount 的值为 0。此后，每当触发 pageshow 事件，showCount 的值就会递增并通过警告框显示出来。如果你在离开包含以上代码的页面之后，又单击「后退」按钮返回该页面，就会看到 showCount 每次递增的值。这是因为该变量的状态，乃至整个页面的状态，都被保存在了内存中，当你返回这个页面时，它们的状态得到了恢复。如果你单击了浏览器的「刷新」按钮，那么 showCount 的值就会被重置为 0，因为页面已经完全重新加载了。

除了通常的属性之外，pageshow 事件的 event 对象还包含一个名为 persisted 的布尔值属性。如果页面被保存在了 bfcache 中，则这个属性的值为 true；否则，这个属性的值为 false。可以像下面这样在事件处理程序中检测这个属性。

(function(){ var showCount = 0; EventUtil.addHandler(window, "load", function(){ alert("Load fired"); }); EventUtil.addHandler(window, "pageshow", function(event){ showCount++; alert("Show has been fired " + showCount + " times. Persisted? " + event.persisted); }); })();

PageShowEventExample01.htm

通过检测 persisted 属性，就可以根据页面在 bfcache 中的状态来确定是否需要采取其他操作。

与 pageshow 事件对应的是 pagehide 事件，该事件会在浏览器卸载页面的时候触发，而且是在 unload 事件之前触发。与 pageshow 事件一样，pagehide 在 document 上面触发，但其事件处理程序必须要添加到 window 对象。这个事件的 event 对象也包含 persisted 属性，不过其用途稍有不同。来看下面的例子。

EventUtil.addHandler(window, "pagehide", function(event){ alert("Hiding. Persisted? " + event.persisted); });

PageShowEventExample01.htm

有时候，可能需要在 pagehide 事件触发时根据 persisted 的值采取不同的操作。对于 pageshow 事件，如果页面是从 bfcache 中加载的，那么 persisted 的值就是 true；对于 pagehide 事件，如果页面在卸载之后会被保存在 bfcache 中，那么 persisted 的值也会被设置为 true。因此，当第一次触发 pageshow 时，persisted 的值一定是 false，而在第一次触发 pagehide 时，persisted 就会变成 true（除非页面不会被保存在 bfcache 中）。

支持 pageshow 和 pagehide 事件的浏览器有 Firefox、Safari 5+、Chrome 和 Opera。IE9 及之前版本不支持这两个事件。

指定了 onunload 事件处理程序的页面会被自动排除在 bfcache 之外，即使事件处理程序是空的。原因在于，onunload 最常用于撤销在 onload 中所执行的操作，而跳过 onload 后再次显示页面很可能就会导致页面不正常。

6. hashchange 事件

HTML5 新增了 haschange 事件，以便在 URL 的参数列表（及 URL 中「#」号后面的所有字符串）发生变化时通知开发人员。之所以新增这个事件，是因为在 Ajax 应用中，开发人员经常要利用 URL 参数列来保存状态或导航信息。

必须要把 hashchange 事件处理程序添加给 window 对象，然后 URL 参数列表只要变化就会调用它。此时的 event 对象应该额外包含两个属性：oldURL 和 newURL。这两个属性分别保存着参数列表变化前后的完整 URL。例如：

EventUtil.addHandler(window, "hashchange", function(event){ alert("Old URL: " + event.oldURL + "\nNew URL: " + event.newURL); });

HashChangeEventExample01.htm

支持 haschange 事件的浏览器有 IE8+、Firefox 3.6+、Safari 5+、Chrome 和 Opera 10.6+。在这些浏览器中，只有 Firefox 6+、Chrome 和 Opera 支持 oldURL 和 newURL 属性。为此，最好是使用 location 对象来确定当前的参数列表。

EventUtil.addHandler(window, "hashchange", function(event){ alert("Current hash: " + location.hash); });

使用以下代码可以检测浏览器是否支持 haschange 事件：

var isSupported = ("onhashchange" in window); // 这里有 bug

如果 IE8 是在 IE7 文档模式下运行，即使功能无效它也会返回 true。为解决这个问题，可以使用以下这个更稳妥的检测方式：

var isSupported = ("onhashchange" in window) && (document.documentMode === undefined || document.documentMode > 7);

13.4.8　设备事件

智能手机和平板电脑的普及，为用户与浏览器交互引入了一种新的方式，而一类新事件也应运而生。设备事件（device event）可以让开发人员确定用户在怎样使用设备。W3C 从 2011 年开始着手制定一份关于设备事件的新草案（http://dev.w3.org/geo/api/spec-source-orientation.html），以涵盖不断增长的设备类型并为它们定义相关的事件。本节会同时讨论这份草案中涉及的 API 和特定于浏览器开发商的事件。

1. orientationchange 事件

苹果公司为移动 Safari 中添加了 orientationchange 事件，以便开发人员能够确定用户何时将设备由横向查看模式切换为纵向查看模式。移动 Safari 的 window.orientation 属性中可能包含 3 个值：0 表示肖像模式，90 表示向左旋转的横向模式（「主屏幕」按钮在右侧），-90 表示向右旋转的横向模式（「主屏幕」按钮在左侧）。相关文档中还提到一个值，即 180 表示 iPhone 头朝下；但这种模式至今尚未得到支持。图 13-10 展示了 window.orientation 的每个值的含义。

图　13-10

只要用户改变了设备的查看模式，就会触发 orientationchange 事件。此时的 event 对象不包含任何有价值的信息，因为唯一相关的信息可以通过 window.orientation 访问到。下面是使用这个事件的典型示例。

EventUtil.addHandler(window, "load", function(event){ var div = document.getElementById("myDiv"); div.innerHTML = "Current orientation is " + window.orientation; EventUtil.addHandler(window, "orientationchange", function(event){ div.innerHTML = "Current orientation is " + window.orientation; }); });

OrientationChangeEventExample01.htm

在这个例子中，当触发 load 事件时会显示最初的方向信息。然后，添加了处理 orientationchange 事件的处理程序。只要发生这个事件，就会有表示新方向的信息更新页面中的消息。

所有 iOS 设备都支持 orientationchange 事件和 window.orientation 属性。

由于可以将 orientationchange 看成 window 事件，所以也可以通过指定 <body> 元素的 onorientationchange 特性来指定事件处理程序。

2. MozOrientation 事件

Firefox 3.6 为检测设备的方向引入了一个名为 MozOrientation 的新事件。（前缀 Moz 表示这是特定于浏览器开发商的事件，不是标准事件。）当设备的加速计检测到设备方向改变时，就会触发这个事件。但这个事件与 iOS 中的 orientationchange 事件不同，该事件只能提供一个平面的方向变化。由于 MozOrientation 事件是在 window 对象上触发的，所以可以使用以下代码来处理。

EventUtil.addHandler (window, "MozOrientation", function (event){// 响应事件});

此时的 event 对象包含三个属性：x、y 和 z。这几个属性的值都介于 1 到 - 1 之间，表示不同坐标轴上的方向。在静止状态下，x 值为 0，y 值为 0，z 值为 1（表示设备处于竖直状态）。如果设备向右倾斜，x 值会减小；反之，向左倾斜，x 值会增大。类似地，如果设备向远离用户的方向倾斜，y 值会减小，向接近用户的方向倾斜，y 值会增大。z 轴检测垂直加速度度，1 表示静止不动，在设备移动时值会减小。（失重状态下值为 0。）以下是输出这三个值的一个简单的例子。

EventUtil.addHandler(window, "MozOrientation", function(event){ var output = document.getElementById("output"); output.innerHTML = "X=" + event.x + ", Y=" + event.y + ", Z=" + event.z +"<br>"; });

MozOrientationEventExample01.htm

只有带加速计的设备才支持 MozOrientation 事件，包括 Macbook、Lenovo Thinkpad、Windows Mobile 和 Android 设备。请大家注意，这是一个实验性 API，将来可能会变（可能会被其他事件取代）。

3. deviceorientation 事件

本质上，DeviceOrientation Event 规范定义的 deviceorientation 事件与 MozOrientation 事件类似。它也是在加速计检测到设备方向变化时在 window 对象上触发，而且具有与 MozOrientation 事件相同的支持限制。不过，deviceorientation 事件的意图是告诉开发人员设备在空间中朝向哪儿，而不是如何移动。

设备在三维空间中是靠 x、y 和 z 轴来定位的。当设备静止放在水平表面上时，这三个值都是 0。x 轴方向是从左往右，y 轴方向是从下往上，z 轴方向是从后往前（参见图 13-11）。

图　13-11

触发 deviceorientation 事件时，事件对象中包含着每个轴相对于设备静止状态下发生变化的信息。事件对象包含以下 5 个属性。

alpha：在围绕 z 轴旋转时（即左右旋转时），y 轴的度数差；是一个介于 0 到 360 之间的浮点数。

beta：在围绕 x 轴旋转时（即前后旋转时），z 轴的度数差；是一个介于？180 到 180 之间的浮点数。

gamma：在围绕 y 轴旋转时（即扭转设备时），z 轴的度数差；是一个介于？90 到 90 之间的浮点数。

absolute：布尔值，表示设备是否返回一个绝对值。

compassCalibrated：布尔值，表示设备的指南针是否校准过。

图 13-12 是 alpha、beta 和 gamma 值含义的示意图。

下面是一个输出 alpha、beta 和 gamma 值的例子。

EventUtil.addHandler(window, "deviceorientation", function(event){ var output = document.getElementById("output"); output.innerHTML = "Alpha=" + event.alpha + ", Beta=" + event.beta + ", Gamma=" + event.gamma + "<br>"; });

DeviceOrientationEventExample01.htm

通过这些信息，可以响应设备的方向，重新排列或修改屏幕上的元素。要响应设备方向的改变而旋转元素，可以参考如下代码。

EventUtil.addHandler(window, "deviceorientation", function(event){ var arrow = document.getElementById("arrow"); arrow.style.webkitTransform = "rotate(" + Math.round(event.alpha) + "deg)"; });

DeviceOrientationEventExample01.htm

图　13-12

这个例子只能在移动 WebKit 浏览器中运行，因为它使用了专有的 webkitTransform 属性（即 CSS 标准属性 transform 的临时版）。元素「arrow」会随着 event.alpha 值的变化而旋转，给人一种指南针的感觉。为了保证旋转平滑，这里的 CSS3 变换使用了舍入之后的值。

到 2011 年，支持 deviceorientation 事件的浏览器有 iOS 4.2 + 中的 Safari、Chrome 和 Android 版 WebKit。

4. devicemotion 事件

DeviceOrientation Event 规范还定义了一个 devicemotion 事件。这个事件是要告诉开发人员设备什么时候移动，而不仅仅是设备方向如何改变。例如，通过 devicemotion 能够检测到设备是不是正在往下掉，或者是不是被走着的人拿在手里。

触发 devicemotion 事件时，事件对象包含以下属性。

acceleration：一个包含 x、y 和 z 属性的对象，在不考虑重力的情况下，告诉你在每个方向上的加速度。

accelerationIncludingGravity：一个包含 x、y 和 z 属性的对象，在考虑 z 轴自然重力加速度的情况下，告诉你在每个方向上的加速度。

interval：以毫秒表示的时间值，必须在另一个 devicemotion 事件触发前传入。这个值在每个事件中应该是一个常量。

rotationRate：一个包含表示方向的 alpha、beta 和 gamma 属性的对象。

如果读取不到 acceleration、accelerationIncludingGravity 和 rotationRate 值，则它们的值为 null。因此，在使用这三个属性之前，应该先检测确定它们的值不是 null。例如：

EventUtil.addHandler(window, "devicemotion", function(event){ var output = document.getElementById("output"); if (event.rotationRate !== null){ output.innerHTML += "Alpha=" + event.rotationRate.alpha + ", Beta=" + event.rotationRate.beta + ", Gamma=" + event.rotationRate.gamma; } });

DeviceMotionEventExample01.htm

与 deviceorientation 事件类似，只有 iOS 4.2 + 中的 Safari、Chrome 和 Android 版 WebKit 实现了 devicemotion 事件。

13.4.9　触摸与手势事件

iOS 版 Safari 为了向开发人员传达一些特殊信息，新增了一些专有事件。因为 iOS 设备既没有鼠标也没有键盘，所以在为移动 Safari 开发交互性网页时，常规的鼠标和键盘事件根本不够用。随着 Android 中的 WebKit 的加入，很多这样的专有事件变成了事实标准，导致 W3C 开始制定 Touch Events 规范（参见 https://dvcs.w3.org/hg/webevents/raw-file/tip/touchevents.html）。以下介绍的事件只针对触摸设备。

1. 触摸事件

包含 iOS 2.0 软件的 iPhone 3G 发布时，也包含了一个新版本的 Safari 浏览器。这款新的移动 Safari 提供了一些与触摸（touch）操作相关的新事件。后来，Android 上的浏览器也实现了相同的事件。触摸事件会在用户手指放在屏幕上面时、在屏幕上滑动时或从屏幕上移开时触发。具体来说，有以下几个触摸事件。

touchstart：当手指触摸屏幕时触发；即使已经有一个手指放在了屏幕上也会触发。

touchmove：当手指在屏幕上滑动时连续地触发。在这个事件发生期间，调用 preventDefault () 可以阻止滚动。

touchend：当手指从屏幕上移开时触发。

touchcancel：当系统停止跟踪触摸时触发。关于此事件的确切触发时间，文档中没有明确说明。

上面这几个事件都会冒泡，也都可以取消。虽然这些触摸事件没有在 DOM 规范中定义，但它们却是以兼容 DOM 的方式实现的。因此，每个触摸事件的 event 对象都提供了在鼠标事件中常见的属性：bubbles、cancelable、view、clientX、clientY、screenX、screenY、detail、altKey、shiftKey、ctrlKey 和 metaKey。

除了常见的 DOM 属性外，触摸事件还包含下列三个用于跟踪触摸的属性。

touches：表示当前跟踪的触摸操作的 Touch 对象的数组。

targetTouchs：特定于事件目标的 Touch 对象的数组。

changeTouches：表示自上次触摸以来发生了什么改变的 Touch 对象的数组。

每个 Touch 对象包含下列属性。

