if (document.forms [0].checkValidity ()){// 表单有效，继续} else {// 表单无效}

与 checkValidity () 方法简单地告诉你字段是否有效相比，validity 属性则会告诉你为什么字段有效或无效。这个对象中包含一系列属性，每个属性会返回一个布尔值。

customError：如果设置了 setCustomValidity ()，则为 true，否则返回 false。

patternMismatch：如果值与指定的 pattern 属性不匹配，返回 true。

rangeOverflow：如果值比 max 值大，返回 true。

rangeUnderflow：如果值比 min 值小，返回 true。

stepMisMatch：如果 min 和 max 之间的步长值不合理，返回 true。

tooLong：如果值的长度超过了 maxlength 属性指定的长度，返回 true。有的浏览器（如 Firefox 4）会自动约束字符数量，因此这个值可能永远都返回 false。

typeMismatch：如果值不是 "mail" 或 "url" 要求的格式，返回 true。

valid：如果这里的其他属性都是 false，返回 true。checkValidity () 也要求相同的值。

valueMissing：如果标注为 required 的字段中没有值，返回 true。

因此，要想得到更具体的信息，就应该使用 validity 属性来检测表单的有效性。下面是一个例子。

if (input.validity && !input.validity.valid){ if (input.validity.valueMissing){ alert("Please specify a value.") } else if (input.validity.typeMismatch){ alert("Please enter an email address."); } else { alert("Value is invalid."); } }

6. 禁用验证

通过设置 novalidate 属性，可以告诉表单不进行验证。

<form method="post" action="signup.php" novalidate> <!-- 这里插入表单元素 --> </form>

在 JavaScript 中使用 noValidate 属性可以取得或设置这个值，如果这个属性存在，值为 true，如果不存在，值为 false。

document.forms [0].noValidate = true; // 禁用验证

如果一个表单中有多个提交按钮，为了指定点击某个提交按钮不必验证表单，可以在相应的按钮上添加 formnovalidate 属性。

<form method="post" action="foo.php"> <!-- 这里插入表单元素 --> <input type="submit" value="Regular Submit"> <input type="submit" formnovalidate name="btnNoValidate" value="Non-validating Submit"> </form>

在这个例子中，点击第一个提交按钮会像往常一样验证表单，而点击第二个按钮则会不经过验证而提交表单。使用 JavaScript 也可以设置这个属性。

// 禁用验证 document.forms [0].elements ["btnNoValidate"].formNoValidate = true;

14.3　选择框脚本

选择框是通过 <select> 和 <option> 元素创建的。为了方便与这个控件交互，除了所有表单字段共有的属性和方法外，HTMLSelectElement 类型还提供了下列属性和方法。

add (newOption, relOption)：向控件中插入新 <option> 元素，其位置在相关项（relOption）之前。

multiple：布尔值，表示是否允许多项选择；等价于 HTML 中的 multiple 特性。

options：控件中所有 <option> 元素的 HTMLCollection。

remove (index)：移除给定位置的选项。

selectedIndex：基于 0 的选中项的索引，如果没有选中项，则值为 - 1。对于支持多选的控件，只保存选中项中第一项的索引。

size：选择框中可见的行数；等价于 HTML 中的 size 特性。

选择框的 type 属性不是 "select-one"，就是 "select-multiple"，这取决于 HTML 代码中有没有 multiple 特性。选择框的 value 属性由当前选中项决定，相应规则如下。

如果没有选中的项，则选择框的 value 属性保存空字符串。

如果有一个选中项，而且该项的 value 特性已经在 HTML 中指定，则选择框的 value 属性等于选中项的 value 特性。即使 value 特性的值是空字符串，也同样遵循此条规则。

如果有一个选中项，但该项的 value 特性在 HTML 中未指定，则选择框的 value 属性等于该项的文本。

如果有多个选中项，则选择框的 value 属性将依据前两条规则取得第一个选中项的值。

以下面的选择框为例：

<select name="location" id="selLocation"> <option value="Sunnyvale, CA">Sunnyvale</option> <option value="Los Angeles, CA">Los Angeles</option> <option value="Mountain View, CA">Mountain View</option> <option value="">China</option> <option>Australia</option> </select>

如果用户选择了其中第一项，则选择框的值就是 "Sunnyvale, CA"。如果文本为 "China" 的选项被选中，则选择框的值就是一个空字符串，因为其 value 特性是空的。如果选择了最后一项，那么由于 <option> 中没有指定 value 特性，则选择框的值就是 "Australia"。

在 DOM 中，每个 <option> 元素都有一个 HTMLOptionElement 对象表示。为便于访问数据，HTMLOptionElement 对象添加了下列属性：

index：当前选项在 options 集合中的索引。

label：当前选项的标签；等价于 HTML 中的 label 特性。

selected：布尔值，表示当前选项是否被选中。将这个属性设置为 true 可以选中当前选项。

text：选项的文本。

value：选项的值（等价于 HTML 中的 value 特性）。

其中大部分属性的目的，都是为了方便对选项数据的访问。虽然也可以使用常规的 DOM 功能来访问这些信息，但效率是比较低的，如下面的例子所示：

var selectbox = document.forms [0]. elements ["location"]; // 不推荐 var text = selectbox.options [0].firstChild.nodeValue; // 选项的文本 var value = selectbox.options [0].getAttribute ("value"); // 选项的值

以上代码使用标准 DOM 方法，取得了选择框中第一项的文本和值。可以与下面使用选项属性的代码作一比较：

var selectbox = document.forms [0]. elements ["location"]; // 推荐 var text = selectbox.options [0].text; // 选项的文本 var value = selectbox.options [0].value; // 选项的值

在操作选项时，我们建议最好是使用特定于选项的属性，因为所有浏览器都支持这些属性。在将表单控件作为 DOM 节点的情况下，实际的交互方式则会因浏览器而异。我们不推荐使用标准 DOM 技术修改 <option> 元素的文本或者值。

最后，我们还想提醒读者注意一点：选择框的 change 事件与其他表单字段的 change 事件触发的条件不一样。其他表单字段的 change 事件是在值被修改且焦点离开当前字段时触发，而选择框的 change 事件只要选中了选项就会触发。

不同浏览器下，选项的 value 属性返回什么值也存在差别。但是，在所有浏览器中，value 属性始终等于 value 特性。在未指定 value 特性的情况下，IE8 会返回空字符串，而 IE9+、Safari、Firefox、Chrome 和 Opera 则会返回与 text 特性相同的值。

14.3.1　选择选项

对于只允许选择一项的选择框，访问选中项的最简单方式，就是使用选择框的 selectedIndex 属性，如下面的例子所示：

var selectedOption = selectbox.options[selectbox.selectedIndex];

取得选中项之后，可以像下面这样显示该选项的信息：

var selectedIndex = selectbox.selectedIndex; var selectedOption = selectbox.options[selectedIndex]; alert("Selected index: " + selectedIndex + "\nSelected text: " + selectedOption.text + "\nSelected value: " + selectedOption.value);

SelectboxExample01.htm

这里，我们通过一个警告框显示了选中项的索引、文本和值。

对于可以选择多项的选择框，selectedfIndex 属性就好像只允许选择一项一样。设置 selectedIndex 会导致取消以前的所有选项并选择指定的那一项，而读取 selectedIndex 则只会返回选中项中第一项的索引值。

另一种选择选项的方式，就是取得对某一项的引用，然后将其 selected 属性设置为 true。例如，下面的代码会选中选择框中的第一项：

selectbox.options[0].selected = true;

与 selectedIndex 不同，在允许多选的选择框中设置选项的 selected 属性，不会取消对其他选中项的选择，因而可以动态选中任意多个项。但是，如果是在单选选择框中，修改某个选项的 selected 属性则会取消对其他选项的选择。需要注意的是，将 selected 属性设置为 false 对单选选择框没有影响。

实际上，selected 属性的作用主要是确定用户选择了选择框中的哪一项。要取得所有选中的项，可以循环遍历选项集合，然后测试每个选项的 selected 属性。来看下面的例子。

function getSelectedOptions(selectbox){ var result = new Array(); var option = null; for (var i=0, len=selectbox.options.length; i < len; i++){ option = selectbox.options[i]; if (option.selected){ result.push(option); } } return result; }

SelectboxExample03.htm

这个函数可以返回给定选择框中选中项的一个数组。首先，创建一个将包含选中项的数组，然后使用 for 循环迭代所有选项，同时检测每一项的 selected 属性。如果有选项被选中，则将其添加到 result 数组中。最后，返回包含选中项的数组。下面是一个使用 getSelectedOptions () 函数取得选中项的示例。

var selectbox = document.getElementById("selLocation"); var selectedOptions = getSelectedOptions(selectbox); var message = ""; for (var i=0, len=selectedOptions.length; i < len; i++){ message += "Selected index: " + selectedOptions[i].index + "\nSelected text: " + selectedOptions[i].text + "\nSelected value: " + selectedOptions[i].value + "\n\n"; } alert(message);

SelectboxExample03.htm

在这个例子中，我们首先从一个选择框中取得了选中项。然后，使用 for 循环构建了一条消息，包含所有选中项的信息：每一项的索引、文本和值。这种技术适用于单选和多选选择框。

14.3.2　添加选项

可以使用 JavaScript 动态创建选项，并将它们添加到选择框中。添加选项的方式有很多，第一种方式就是使用如下所示的 DOM 方法。

var newOption = document.createElement("option"); newOption.appendChild(document.createTextNode("Option text")); newOption.setAttribute("value", "Option value"); selectbox.appendChild(newOption);

SelectboxExample04.htm

以上代码创建了一个新的 <option> 元素，然后为它添加了一个文本节点，并设置其 value 特性，最后将它添加到了选择框中。添加到选择框之后，用户立即就可以看到新选项。

第二种方式是使用 Option 构造函数来创建新选项，这个构造函数是 DOM 出现之前就有的，一直遗留到现在。Option 构造函数接受两个参数：文本（text）和值（value）；第二个参数可选。虽然这个构造函数会创建一个 Object 的实例，但兼容 DOM 的浏览器会返回一个 <option> 元素。换句话说，在这种情况下，我们仍然可以使用 appendChild () 将新选项添加到选择框中。来看下面的例子。

var newOption = new Option ("Option text", "Option value"); selectbox.appendChild (newOption); // 在 IE8 及之前版本中有问题

SelectboxExample08.htm

这种方式在除 IE 之外的浏览器中都可以使用。由于存在 bug，IE 在这种方式下不能正确设置新选项的文本。

第三种添加新选项的方式是使用选择框的 add () 方法。DOM 规定这个方法接受两个参数：要添加的新选项和将位于新选项之后的选项。如果想在列表的最后添加一个选项，应该将第二个参数设置为 null。在 IE 对 add () 方法的实现中，第二个参数是可选的，而且如果指定，该参数必须是新选项之后选项的索引。兼容 DOM 的浏览器要求必须指定第二个参数，因此要想编写跨浏览器的代码，就不能只传入一个参数。这时候，为第二个参数传入 undefined，就可以在所有浏览器中都将新选项插入到列表最后了。来看一个例子。

var newOption = new Option ("Option text", "Option value"); selectbox.add (newOption, undefined); // 最佳方案

SelectboxExample04.htm

在 IE 和兼容 DOM 的浏览器中，上面的代码都可以正常使用。如果你想将新选项添加到其他位置（不是最后一个），就应该使用标准的 DOM 技术和 insertBefore () 方法。

就和在 HTML 中一样，此时也不一定要为选项指定值。换句话说，只为 Option 构造函数传入一个参数（选项的文本）也没有问题。

14.3.3　移除选项

与添加选项类似，移除选项的方式也有很多种。首先，可以使用 DOM 的 removeChild () 方法，为其传入要移除的选项，如下面的例子所示：

selectbox.removeChild (selectbox.options [0]); // 移除第一个选项

其次，可以使用选择框的 remove () 方法。这个方法接受一个参数，即要移除选项的索引，如下面的例子所示：

selectbox.remove (0); // 移除第一个选项

最后一种方式，就是将相应选项设置为 null。这种方式也是 DOM 出现之前浏览器的遗留机制。例如：

selectbox.options [0] = null; // 移除第一个选项

要清除选择框中所有的项，需要迭代所有选项并逐个移除它们，如下面的例子所示：

function clearSelectbox(selectbox){ for(var i=0, len=selectbox.options.length; i < len; i++){ selectbox.remove(i); } }

这个函数每次只移除选择框中的第一个选项。由于移除第一个选项后，所有后续选项都会自动向上移动一个位置，因此重复移除第一个选项就可以移除所有选项了。

14.3.4　移动和重排选项

在 DOM 标准出现之前，将一个选择框中的选项移动到另一个选择框中是非常麻烦的。整个过程要涉及从第一个选择框中移除选项，然后以相同的文本和值创建新选项，最后再将新选项添加到第二个选择框中。而使用 DOM 的 appendChild () 方法，就可以将第一个选择框中的选项直接移动到第二个选择框中。我们知道，如果为 appendChild () 方法传入一个文档中已有的元素，那么就会先从该元素的父节点中移除它，再把它添加到指定的位置。下面的代码展示了将第一个选择框中的第一个选项移动到第二个选择框中的过程。

var selectbox1 = document.getElementById("selLocations1"); var selectbox2 = document.getElementById("selLocations2"); selectbox2.appendChild(selectbox1.options[0]);

SelectboxExample05.htm

移动选项与移除选项有一个共同之处，即会重置每一个选项的 index 属性。

重排选项次序的过程也十分类似，最好的方式仍然是使用 DOM 方法。要将选择框中的某一项移动到特定位置，最合适的 DOM 方法就是 insertBefore ()；appendChild () 方法只适用于将选项添加到选择框的最后。要在选择框中向前移动一个选项的位置，可以使用以下代码：

var optionToMove = selectbox.options[1]; selectbox.insertBefore(optionToMove, selectbox.options[optionToMove.index-1]);

SelectboxExample06.htm

以上代码首先选择了要移动的选项，然后将其插入到了排在它前面的选项之前。实际上，第二行代码对除第一个选项之外的其他选项是通用的。类似地，可以使用下列代码将选择框中的选项向后移动一个位置。

var optionToMove = selectbox.options[1]; selectbox.insertBefore(optionToMove, selectbox.options[optionToMove.index+2]);

SelectboxExample06.htm

以上代码适用于选择框中的所有选项，包括最后一个选项。

IE7 存在一个页面重绘问题，有时候会导致使用 DOM 方法重排的选项不能马上正确显示。

14.4　表单序列化

随着 Ajax 的出现，表单序列化已经成为一种常见需求（第 21 章将讨论 Ajax）。在 JavaScript 中，可以利用表单字段的 type 属性，连同 name 和 value 属性一起实现对表单的序列化。在编写代码之前，有必须先搞清楚在表单提交期间，浏览器是怎样将数据发送给服务器的。

对表单字段的名称和值进行 URL 编码，使用和号（&）分隔。

不发送禁用的表单字段。

只发送勾选的复选框和单选按钮。

不发送 type 为 "reset" 和 "button" 的按钮。

多选选择框中的每个选中的值单独一个条目。

在单击提交按钮提交表单的情况下，也会发送提交按钮；否则，不发送提交按钮。也包括 type 为 "image" 的 <input> 元素。

<select> 元素的值，就是选中的 <option> 元素的 value 特性的值。如果 <option> 元素没有 value 特性，则是 <option> 元素的文本值。

在表单序列化过程中，一般不包含任何按钮字段，因为结果字符串很可能是通过其他方式提交的。除此之外的其他上述规则都应该遵循。以下就是实现表单序列化的代码。

function serialize (form){var parts = [], field = null, i, len, j, optLen, option, optValue; for (i=0, len=form.elements.length; i < len; i++){field = form.elements [i]; switch (field.type){case "select-one": case "select-multiple": if (field.name.length){for (j=0, optLen = field.options.length; j < optLen; j++){option = field.options [j]; if (option.selected){optValue = ""; if (option.hasAttribute){optValue = (option.hasAttribute ("value") ? option.value : option.text); } else {optValue = (option.attributes ["value"].specified ? option.value : option.text); } parts.push (encodeURIComponent (field.name) +"="+ encodeURIComponent (optValue)); } } } break; case undefined: // 字段集 case"file": // 文件输入 case"submit": // 提交按钮 case"reset": // 重置按钮 case"button": // 自定义按钮 break; case"radio": // 单选按钮 case"checkbox": // 复选框 if (!field.checked){break;} /* 执行默认操作 */default: // 不包含没有名字的表单字段 if (field.name.length){parts.push (encodeURIComponent (field.name) +"="+ encodeURIComponent (field.value)); } } } return parts.join ("&"); }

FormSerializationExample01.htm

上面这个 serialize () 函数首先定义了一个名为 parts 的数组，用于保存将要创建的字符串的各个部分。然后，通过 for 循环迭代每个表单字段，并将其保存在 field 变量中。在获得了一个字段的引用之后，使用 switch 语句检测其 type 属性。序列化过程中最麻烦的就是 < select> 元素，它可能是单选框也可能是多选框。为此，需要遍历控件中的每一个选项，并在相应选项被选中的情况下向数组中添加一个值。对于单选框，只可能有一个选中项，而多选框则可能有零或多个选中项。这里的代码适用于这两种选择框，至于可选项的数量则是由浏览器控制的。在找到一个选中项之后，需要确定使用什么值。如果不存在 value 特性，或者虽然存在该特性，但值为空字符串，都要使用选项的文本来代替。为检查这个特性，在 DOM 兼容的浏览器中需要使用 hasAttribute () 方法，而在 IE 中需要使用特性的 specified 属性。

如果表单中包含 <fieldset> 元素，则该元素会出现在元素集合中，但没有 type 属性。因此，如果 type 属性未定义，则不需要对其进行序列化。同样，对于各种按钮以及文件输入字段也是如此（文件输入字段在表单提交过程中包含文件的内容；但是，这个字段是无法模仿的，序列化时一般都要忽略）。对于单选按钮和复选框，要检查其 checked 属性是否被设置为 false，如果是则退出 switch 语句。如果 checked 属性为 true，则继续执行 default 语句，即将当前字段的名称和值进行编码，然后添加到 parts 数组中。函数的最后一步，就是使用 join () 格式化整个字符串，也就是用和号来分隔每一个表单字段。

最后，serialize () 函数会以查询字符串的格式输出序列化之后的字符串。当然，要序列化成其他格式，也不是什么困难的事。

14.5　富文本编辑

富文本编辑，又称为 WYSIWYG（What You See Is What You Get，所见即所得）。在网页中编辑富文本内容，是人们对 Web 应用程序最大的期待之一。虽然也没有规范，但在 IE 最早引入的这一功能基础上，已经出现了事实标准。而且，Opera、Safari、Chrome 和 Firefox 都已经支持这一功能。这一技术的本质，就是在页面中嵌入一个包含空 HTML 页面的 iframe。通过设置 designMode 属性，这个空白的 HTML 页面可以被编辑，而编辑对象则是该页面 <body> 元素的 HTML 代码。designMode 属性有两个可能的值："off"（默认值）和 "on"。在设置为 "on" 时，整个文档都会变得可以编辑（显示插入符号），然后就可以像使用字处理软件一样，通过键盘将文本内容加粗、变成斜体，等等。

可以给 iframe 指定一个非常简单的 HTML 页面作为其内容来源。例如：

<!DOCTYPE html> <html> <head> <title>Blank Page for Rich Text Editing</title> </head> <body> </body> </html>

这个页面在 iframe 中可以像其他页面一样被加载。要让它可以编辑，必须要将 designMode 设置为 "on"，但只有在页面完全加载之后才能设置这个属性。因此，在包含页面中，需要使用 onload 事件处理程序来在恰当的时刻设置 designMode，如下面的例子所示：

<iframe name="richedit" style="height:100px;width:100px;" src="blank.htm"></iframe> <script type="text/javascript"> EventUtil.addHandler(window, "load", function(){ frames["richedit"].document.designMode = "on"; }); </script>

等到以上代码执行之后，你就会在页面中看到一个类似文本框的可编辑区字段。这个区字段具有与其他网页相同的默认样式；不过，通过为空白页面应用 CSS 样式，可以修改可编辑区字段的外观。

14.5.1　使用 contenteditable 属性

另一种编辑富文本内容的方式是使用名为 contenteditable 的特殊属性，这个属性也是由 IE 最早实现的。可以把 contenteditable 属性应用给页面中的任何元素，然后用户立即就可以编辑该元素。这种方法之所以受到欢迎，是因为它不需要 iframe、空白页和 JavaScript，只要为元素设置 contenteditable 属性即可。

<div class="editable" id="richedit" contenteditable></div>

这样，元素中包含的任何文本内容就都可以编辑了，就好像这个元素变成了 <textarea> 元素一样。通过在这个元素上设置 contenteditable 属性，也能打开或关闭编辑模式。

var div = document.getElementById("richedit"); richedit.contentEditable = "true";

contenteditable 属性有三个可能的值："true" 表示打开、"false" 表示关闭，"inherit" 表示从父元素那里继承（因为可以在 contenteditable 元素中创建或删除元素）。支持 contenteditable 属性的元素有 IE、Firefox、Chrome、Safari 和 Opera。在移动设备上，支持 contenteditable 属性的浏览器有 iOS 5 + 中的 Safari 和 Android 3 + 中的 WebKit。

14.5.2　操作富文本

与富文本编辑器交互的主要方式，就是使用 document.execCommand ()。这个方法可以对文档执行预定义的命令，而且可以应用大多数格式。可以为 document.execCommand () 方法传递 3 个参数：要执行的命令名称、表示浏览器是否应该为当前命令提供用户界面的一个布尔值和执行命令必须的一个值（如果不需要值，则传递 null）。为了确保跨浏览器的兼容性，第二个参数应该始终设置为 false，因为 Firefox 会在该参数为 true 时抛出错误。

不同浏览器支持的预定义命令也不一样。下表列出了那些被支持最多的命令。

命　　令 值（第三个参数） 说　　明

backcolor 颜色字符串 设置文档的背景颜色

bold null 将选择的文本转换为粗体

copy null 将选择的文本复制到剪贴板

createlink URL 字符串 将选择的文本转换成一个链接，指向指定的 URL

cut null 将选择的文本剪切到剪贴板

delete null 删除选择的文本

fontname 字体名称 将选择的文本修改为指定字体

fontsize 1～7 将选择的文本修改为指定字体大小

forecolor 颜色字符串 将选择的文本修改为指定的颜色

formatblock 要包围当前文本块的 HTML 标签；如 <h1> 使用指定的 HTML 标签来格式化选择的文本块

indent null 缩进文本

inserthorizontalrule null 在插入字符处插入一个 <hr> 元素

insertimage 图像的 URL 在插入字符处插入一个图像

insertorderedlist null 在插入字符处插入一个 <ol> 元素

insertunorderedlist null 在插入字符处插入一个 <ul> 元素

insertparagraph null 在插入字符处插入一个 <p> 元素

italic null 将选择的文本转换成斜体

justifycenter null 将插入光标所在文本块居中对齐

justifyleft null 将插入光标所在文本块左对齐

outdent null 凸排文本（减少缩进）

paste null 将剪贴板中的文本粘贴到选择的文本

removeformat null 移除插入光标所在文本块的块级格式。这是撤销 formatblock 命令的操作

selectall null 选择文档中的所有文本

underline null 为选择的文本添加下划线

unlink null 移除文本的链接。这是撤销 createlink 命令的操作

其中，与剪贴板有关的命令在不同浏览器中的差异极大。Opera 根本没有实现任何剪贴板命令，而 Firefox 在默认情况下会禁用它们（必须修改用户的首选项来启用它们）。Safari 和 Chrome 实现了 cut 和 copy，但没有实现 paste。不过，即使不能通过 document.execCommand () 来执行这些命令，但却可以通过相应的快捷键来实现同样的操作。

可以在任何时候使用这些命令来修改富文本区域的外观，如下面的例子所示。

// 转换粗体文本 frames ["richedit"].document.execCommand ("bold", false, null); // 转换斜体文本 frames ["richedit"].document.execCommand ("italic", false, null); // 创建指向 www.wrox.com 的链接 frames ["richedit"].document.execCommand ("createlink", false, "http://www.wrox.com"); // 格式化为 1 级标题 frames ["richedit"].document.execCommand ("formatblock", false, "<h1>");

RichTextEditingExample01.htm

同样的方法也适用于页面中 contenteditable 属性为 "true" 的区块，只要把对框架的引用替换成当前窗口的 document 对象即可。

// 转换粗体文本 document.execCommand ("bold", false, null); // 转换斜体文本 document.execCommand ("italic", false, null); // 创建指向 www.wrox.com 的链接 document.execCommand ("createlink", false, "http://www.wrox.com"); // 格式化为 1 级标题 document.execCommand ("formatblock", false, "<h1>");

RichTextEditingExample01.htm

需要注意的是，虽然所有浏览器都支持这些命令，但这些命令所产生的 HTML 仍然有很大不同。例如，执行 bold 命令时，IE 和 Opera 会使用 <strong> 标签包围文本，Safari 和 Chrome 使用 <b> 标签，而 Firefox 则使用 <span> 标签。由于各个浏览器实现命令的方式不同，加上它们通过 innerHTML 实现转换的方式也不一样，因此不能指望富文本编辑器会产生一致的 HTML。

除了命令之外，还有一些与命令相关的方法。第一个方法就是 queryCommandEnabled ()，可以用它来检测是否可以针对当前选择的文本，或者当前插入字符所在位置执行某个命令。这个方法接收一个参数，即要检测的命令。如果当前编辑区域允许执行传入的命令，这个方法返回 true，否则返回 false。例如：

var result = frames["richedit"].document.queryCommandEnabled("bold");

如果能够对当前选择的文本执行 "bold" 命令，以上代码会返回 true。需要注意的是，queryCommandEnabled () 方法返回 true，并不意味着实际上就可以执行相应命令，而只能说明对当前选择的文本执行相应命令是否合适。例如，Firefox 在默认情况下会禁用剪切操作，但执行 queryCommandEnabled ("cut") 也可能会返回 true。

另外，queryCommandState () 方法用于确定是否已将指定命令应用到了选择的文本。例如，要确定当前选择的文本是否已经转换成了粗体，可以使用如下代码。

var isBold = frames["richedit"].document.queryCommandState("bold");

RichTextEditingExample01.htm

如果此前已经对选择的文本执行了 "bold" 命令，那么上面的代码会返回 true。一些功能全面的富文本编辑器，正是利用这个方法来更新粗体、斜体等按钮的状态的。

最后一个方法是 queryCommandValue ()，用于取得执行命令时传入的值（即前面例子中传给 document.execCommand () 的第三个参数）。例如，在对一段文本应用 "fontsize" 命令时如果传入了 7，那么下面的代码就会返回 "7"：

var fontSize = frames["richedit"].document.queryCommandValue("fontsize");

RichTextEditingExample01.htm

通过这个方法可以确定某个命令是怎样应用到选择的文本的，可以据以确定再对其应用后续命令是否合适。

14.5.3　富文本选区

在富文本编辑器中，使用框架（iframe）的 getSelection () 方法，可以确定实际选择的文本。这个方法是 window 对象和 document 对象的属性，调用它会返回一个表示当前选择文本的 Selection 对象。每个 Selection 对象都有下列属性。

anchorNode：选区起点所在的节点。

anchorOffset：在到达选区起点位置之前跳过的 anchorNode 中的字符数量。

focusNode：选区终点所在的节点。

focusOffset：focusNode 中包含在选区之内的字符数量。

isCollapsed：布尔值，表示选区的起点和终点是否重合。

rangeCount：选区中包含的 DOM 范围的数量。

Selection 对象的这些属性并没有包含多少有用的信息。好在，该对象的下列方法提供了更多信息，并且支持对选区的操作。

addRange (range)：将指定的 DOM 范围添加到选区中。

collapse (node, offset)：将选区折叠到指定节点中的相应的文本偏移位置。

collapseToEnd ()：将选区折叠到终点位置。

collapseToStart ()：将选区折叠到起点位置。

containsNode (node)：确定指定的节点是否包含在选区中。

deleteFromDocument ()：从文档中删除选区中的文本，与 document.execCommand ("delete", false, null) 命令的结果相同。

extend (node, offset)：通过将 focusNode 和 focusOffset 移动到指定的值来扩展选区。

getRangeAt (index)：返回索引对应的选区中的 DOM 范围。

removeAllRanges ()：从选区中移除所有 DOM 范围。实际上，这样会移除选区，因为选区中至少要有一个范围。

reomveRange (range)：从选区中移除指定的 DOM 范围。

selectAllChildren (node)：清除选区并选择指定节点的所有子节点。

toString ()：返回选区所包含的文本内容。

Selection 对象的这些方法都极为实用，它们利用了（第 12 章讨论过的）DOM 范围来管理选区。由于可以直接操作选择文本的 DOM 表现，因此访问 DOM 范围与使用 execCommand () 相比，能够对富文本编辑器进行更加细化的控制。下面来看一个例子。

var selection = frames ["richedit"].getSelection (); // 取得选择的文本 var selectedText = selection.toString (); // 取得代表选区的范围 var range = selection.getRangeAt (0); // 突出显示选择的文本 var span = frames ["richedit"].document.createElement ("span"); span.style.backgroundColor = "yellow"; range.surroundContents (span);

RichTextEditingExample01.htm

以上代码会为富文本编辑器中被选择的文本添加黄色的背景。这里使用了默认选区中的 DOM 范围，通过 surroundContents () 方法将选区添加到了带有黄色背景的 < span> 元素中。

HTML5 将 getSelection () 方法纳入了标准，而且 IE9、Firefox、Safari、Chrome 和 Opera 8 都实现了它。由于历史原因，在 Firefox 3.6 + 中调用 document.getSelection () 会返回一个字符串。为此，可以在 Firefox 3.6 + 中改作调用 window.getSelection ()，从而返回 selection 对象。Firefox 8 修复了 document.getSelection () 的 bug，能返回与 window.getSelection () 相同的值。

IE8 及更早的版本不支持 DOM 范围，但我们可以通过它支持的 selection 对象操作选择的文本。IE 中的 selection 对象是 document 的属性，本章前面曾经讨论过。要取得富文本编辑器中选择的文本，首先必须创建一个文本范围（请参考第 12 章中的相关内容），然后再像下面这样访问其 text 属性。

var range = frames["richedit"].document.selection.createRange(); var selectedText = range.text;

虽然使用 IE 的文本范围来执行 HTML 操作并不像使用 DOM 范围那么可靠，但也不失为一种有效的途径。要像前面使用 DOM 范围那样实现相同的文本高亮效果，可以组合使用 htmlText 属性和 pasteHTML () 方法。

var range = frames["richedit"].document.selection.createRange(); range.pasteHTML("<span style=\"background-color:yellow\"> " + range.htmlText + "</span>");

以上代码通过 htmlText 取得了当前选区中的 HTML，然后将其放在了一对 <span> 标签中，最后又使用 pasteHTML () 将结果重新插入到了选区中。

14.5.4　表单与富文本

由于富文本编辑是使用 iframe 而非表单控件实现的，因此从技术上说，富文本编辑器并不属于表单。换句话说，富文本编辑器中的 HTML 不会被自动提交给服务器，而需要我们手工来提取并提交 HTML。为此，通常可以添加一个隐藏的表单字段，让它的值等于从 iframe 中提取出的 HTML。具体来说，就是在提交表单之前，从 iframe 中提取出 HTML，并将其插入到隐藏的字段中。下面就是通过表单的 onsubmit 事件处理程序实现上述操作的代码。

EventUtil.addHandler(form, "submit", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); target.elements["comments"].value = frames["richedit"].document.body.innerHTML; });

RichTextEditingExample01.htm

在此，我们通过文档主体的 innerHTML 属性取得了 iframe 中的 HTML，然后将其插入到了名为 "comments" 的表单字段中。这样可以确保恰好在提交表单之前填充 "comments" 字段。如果你想在代码中通过 submit () 来手工提交表单，那么一定不要忘记事先执行上面的操作。对于 contenteditable 元素，也可以执行类似操作。

EventUtil.addHandler(form, "submit", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); target.elements["comments"].value = document.getElementById("richedit").innerHTML; });

14.6　小结

虽然 HTML 和 Web 应用自诞生以来已经发生了天翻地覆的变化，但 Web 表单相对却没有什么改变。使用 JavaScript 可以增强已有的表单字段，从而创造出新的功能，或者提升表单的易用性。为此，表单、表单字段都引入了相应的属性和方法，以便 JavaScript 使用。下面是本章介绍的几个概念。

可以使用一些标准或非标准的方法选择文本框中的全部或部分文本。

大多数浏览器都采用了 Firefox 操作选择文本的方式，但 IE 仍然坚持自己的实现。

在文本框的内容变化时，可以通过侦听键盘事件以及检测插入的字符，来允许或禁止用户输入某些字符。

除 Opera 之外的所有浏览器都支持剪贴板事件，包括 copy、cut 和 paste。其他浏览器在实现剪贴板事件时也可以分为几种不同的情况。

IE、Firefox、Chrome 和 Safari 允许通过 JavaScript 访问剪贴板中的数据，而 Opera 不允许这种访问方式。

即使是 IE、Chrome 和 Safari，它们各自的实现方式也不相同。

Firefox、Safari 和 Chrome 只允许在 paste 事件发生时读取剪贴板数据，而 IE 没有这个限制。

Firefox、Safari 和 Chrome 只允许在发生剪贴板事件时访问与剪贴板相关的信息，而 IE 允许在任何时候访问相关信息。

在文本框内容必须限制为某些特定字符的情况下，就可以利用剪贴板事件来屏蔽通过粘贴向文本框中插入内容的操作。

选择框也是经常要通过 JavaScript 来控制的一个表单字段。由于有了 DOM，对选择框的操作比以前要方便多了。添加选项、移除选项、将选项从一个选择框移动到另一个选择框，甚至对选项进行排序等操作，都可以使用标准的 DOM 技术来实现。

富文本编辑功能是通过一个包含空 HTML 文档的 iframe 元素来实现的。通过将空文档的 designMode 属性设置为 "on"，就可以将该页面转换为可编辑状态，此时其表现如同字处理软件。另外，也可以将某个元素设置为 contenteditable。在默认情况下，可以将字体加粗或者将文本转换为斜体，还可以使用剪贴板。JavaScript 通过使用 execCommand () 方法也可以实现相同的一些功能。另外，使用 queryCommandEnabled ()、queryCommandState () 和 queryCommandValue () 方法则可以取得有关文本选区的信息。由于以这种方式构建的富文本编辑器并不是一个表单字段，因此在将其内容提交给服务器之前，必须将 iframe 或 contenteditable 元素中的 HTML 复制到一个表单字段中。

第 15 章　使用 Canvas 绘图

本章内容

理解 <canvas> 元素

绘制简单的 2D 图形

使用 WebGL 绘制 3D 图形

不用说，HTML5 添加的最受欢迎的功能就是 <canvas> 元素。这个元素负责在页面中设定一个区域，然后就可以通过 JavaScript 动态地在这个区域中绘制图形。<canvas> 元素最早是由苹果公司推出的，当时主要用在其 Dashboard 微件中。很快，HTML5 加入了这个元素，主流浏览器也迅速开始支持它。IE9+、Firefox 1.5+、Safari 2+、Opera 9+、Chrome、iOS 版 Safari 以及 Android 版 WebKit 都在某种程度上支持 <canvas>。

与浏览器环境中的其他组件类似，<canvas> 由几组 API 构成，但并非所有浏览器都支持所有这些 API。除了具备基本绘图能力的 2D 上下文，<canvas> 还建议了一个名为 WebGL 的 3D 上下文。目前，支持该元素的浏览器都支持 2D 上下文及文本 API，但对 WebGL 的支持还不够好。由于 WebGL 还是实验性的，因此要得到所有浏览器支持还需要很长一段时间。Firefox 4 + 和 Chrome 支持 WebGL 规范的早期版本，但一些老版本的浏览器，比如 Windows XP，由于缺少必要的绘图驱动程序，即便安装了这两款浏览器也无济于事。

15.1　基本用法

要使用 <canvas> 元素，必须先设置其 width 和 height 属性，指定可以绘图的区域大小。出现在开始和结束标签中的内容是后备信息，如果浏览器不支持 <canvas> 元素，就会显示这些信息。下面就是 <canvas> 元素的例子。

<canvas id="drawing" width=" 200" height="200">A drawing of something.</canvas>

与其他元素一样，<canvas> 元素对应的 DOM 元素对象也有 width 和 height 属性，可以随意修改。而且，也能通过 CSS 为该元素添加样式，如果不添加任何样式或者不绘制任何图形，在页面中是看不到该元素的。

要在这块画布（canvas）上绘图，需要取得绘图上下文。而取得绘图上下文对象的引用，需要调用 getContext () 方法并传入上下文的名字。传入 "2d"，就可以取得 2D 上下文对象。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); // 更多代码 }

在使用 <canvas> 元素之前，首先要检测 getContext () 方法是否存在，这一步非常重要。有些浏览器会为 HTML 规范之外的元素创建默认的 HTML 元素对象 1。在这种情况下，即使 drawing 变量中保存着一个有效的元素引用，也检测不到 getContext () 方法。

1 假设你想在 Firefox 3 中使用 <canvas> 元素。虽然浏览器会为该标签创建一个 DOM 对象，而且也可以引用它，但这个对象中并没有 getContext () 方法。（据作者回复）

使用 toDataURL () 方法，可以导出在 < canvas> 元素上绘制的图像。这个方法接受一个参数，即图像的 MIME 类型格式，而且适合用于创建图像的任何上下文。比如，要取得画布中的一幅 PNG 格式的图像，可以使用以下代码。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){// 取得图像的数据 URI var imgURI = drawing.toDataURL ("image/png"); // 显示图像 var image = document.createElement ("img"); image.src = imgURI; document.body.appendChild (image); }

2DDataUrlExample01.htm

默认情况下，浏览器会将图像编码为 PNG 格式（除非另行指定）。Firefox 和 Opera 也支持基于 "image/jpeg" 参数的 JPEG 编码格式。由于这个方法是后来才追加的，所以支持 <canvas> 的浏览器也是在较新的版本中才加入了对它的支持，比如 IE9、Firefox 3.5 和 Opera 10。

如果绘制到画布上的图像源自不同的域，toDataURL () 方法会抛出错误。本章后面还将介绍更多相关内容。

15.2　2D 上下文

使用 2D 绘图上下文提供的方法，可以绘制简单的 2D 图形，比如矩形、弧线和路径。2D 上下文的坐标开始于 <canvas> 元素的左上角，原点坐标是 (0,0)。所有坐标值都基于这个原点计算，x 值越大表示越靠右，y 值越大表示越靠下。默认情况下，width 和 height 表示水平和垂直两个方向上可用的像素数目。

15.2.1　填充和描边

2D 上下文的两种基本绘图操作是填充和描边。填充，就是用指定的样式（颜色、渐变或图像）填充图形；描边，就是只在图形的边缘画线。大多数 2D 上下文操作都会细分为填充和描边两个操作，而操作的结果取决于两个属性：fillStyle 和 strokeStyle。

这两个属性的值可以是字符串、渐变对象或模式对象，而且它们的默认值都是 "#000000"。如果为它们指定表示颜色的字符串值，可以使用 CSS 中指定颜色值的任何格式，包括颜色名、十六进制码、rgb、rgba、hsl 或 hsla。举个例子：

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); context.strokeStyle = "red"; context.fillStyle = "#0000ff"; }

以上代码将 strokeStyle 设置为 red（CSS 中的颜色名），将 fillStyle 设置为 #0000ff（蓝色）。然后，所有涉及描边和填充的操作都将使用这两个样式，直至重新设置这两个值。如前所述，这两个属性的值也可以是渐变对象或模式对象。本章后面会讨论这两种对象。

15.2.2　绘制矩形

矩形是唯一一种可以直接在 2D 上下文中绘制的形状。与矩形有关的方法包括 fillRect ()、strokeRect () 和 clearRect ()。这三个方法都能接收 4 个参数：矩形的 x 坐标、矩形的 y 坐标、矩形宽度和矩形高度。这些参数的单位都是像素。

首先，fillRect () 方法在画布上绘制的矩形会填充指定的颜色。填充的颜色通过 fillStyle 属性指定，比如：

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); /* * 根据 Mozilla 的文档 * http://developer.mozilla.org/en/docs/Canvas_tutorial:Basic_usage */// 绘制红色矩形 context.fi llStyle = "#ff0000"; context.fi llRect (10, 10, 50, 50); // 绘制半透明的蓝色矩形 context.fi llStyle = "rgba (0,0,255,0.5)"; context.fi llRect (30, 30, 50, 50); }

2DFillRectExample01.htm

以上代码首先将 fillStyle 设置为红色，然后从 (10,10) 处开始绘制矩形，矩形的宽和高均为 50 像素。然后，通过 rgba () 格式再将 fillStyle 设置为半透明的蓝色，在第一个矩形上面绘制第二个矩形。结果就是可以透过蓝色的矩形看到红色的矩形（见图 15-1）。

图　15-1

strokeRect () 方法在画布上绘制的矩形会使用指定的颜色描边。描边颜色通过 strokeStyle 属性指定。比如：

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); /* * 根据 Mozilla 的文档 * http://developer.mozilla.org/en/docs/Canvas_tutorial:Basic_usage */// 绘制红色描边矩形 context.strokeStyle = "#ff0000"; context.strokeRect (10, 10, 50, 50); // 绘制半透明的蓝色描边矩形 context.strokeStyle = "rgba (0,0,255,0.5)"; context.strokeRect (30, 30, 50, 50); }

2DStrokeRectExample01.htm/I>

以上代码绘制了两个重叠的矩形。不过，这两个矩形都只有框线，内部并没有填充颜色（见图 15-2）。

图　15-2

描边线条的宽度由 lineWidth 属性控制，该属性的值可以是任意整数。另外，通过 lineCap 属性可以控制线条末端的形状是平头、圆头还是方头（"butt"、"round" 或 "square"），通过 lineJoin 属性可以控制线条相交的方式是圆交、斜交还是斜接（"round"、"bevel" 或 "miter"）。

最后，clearRect () 方法用于清除画布上的矩形区域。本质上，这个方法可以把绘制上下文中的某一矩形区域变透明。通过绘制形状然后再清除指定区域，就可以生成有意思的效果，例如把某个形状切掉一块。下面看一个例子。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); /* * 根据 Mozilla 的文档 * http://developer.mozilla.org/en/docs/Canvas_tutorial:Basic_usage */// 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 绘制半透明的蓝色矩形 context.fillStyle = "rgba (0,0,255,0.5)"; context.fillRect (30, 30, 50, 50); // 在两个矩形重叠的地方清除一个小矩形 context.clearRect (40, 40, 10, 10); }

2DClearRectExample01.htm

如图 15-3 所示，两个填充矩形重叠在一起，而重叠的地方又被清除了一个小矩形区域。

图　15-3

15.2.3　绘制路径

2D 绘制上下文支持很多在画布上绘制路径的方法。通过路径可以创造出复杂的形状和线条。要绘制路径，首先必须调用 beginPath () 方法，表示要开始绘制新路径。然后，再通过调用下列方法来实际地绘制路径。

arc (x, y, radius, startAngle, endAngle, counterclockwise)：以 (x,y) 为圆心绘制一条弧线，弧线半径为 radius，起始和结束角度（用弧度表示）分别为 startAngle 和 endAngle。最后一个参数表示 startAngle 和 endAngle 是否按逆时针方向计算，值为 false 表示按顺时针方向计算。

arcTo (x1, y1, x2, y2, radius)：从上一点开始绘制一条弧线，到 (x2,y2) 为止，并且以给定的半径 radius 穿过 (x1,y1)。

bezierCurveTo (c1x, c1y, c2x, c2y, x, y)：从上一点开始绘制一条曲线，到 (x,y) 为止，并且以 (c1x,c1y) 和 (c2x,c2y) 为控制点。

lineTo (x, y)：从上一点开始绘制一条直线，到 (x,y) 为止。

moveTo (x, y)：将绘图游标移动到 (x,y)，不画线。

quadraticCurveTo (cx, cy, x, y)：从上一点开始绘制一条二次曲线，到 (x,y) 为止，并且以 (cx,cy) 作为控制点。

rect (x, y, width, height)：从点 (x,y) 开始绘制一个矩形，宽度和高度分别由 width 和 height 指定。这个方法绘制的是矩形路径，而不是 strokeRect () 和 fillRect () 所绘制的独立的形状。

创建了路径后，接下来有几种可能的选择。如果想绘制一条连接到路径起点的线条，可以调用 closePath ()。如果路径已经完成，你想用 fillStyle 填充它，可以调用 fill () 方法。另外，还可以调用 stroke () 方法对路径描边，描边使用的是 strokeStyle。最后还可以调用 clip ()，这个方法可以在路径上创建一个剪切区域。

下面看一个例子，即绘制一个不带数字的时钟表盘。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); // 开始路径 context.beginPath (); // 绘制外圆 context.arc (100, 100, 99, 0, 2 * Math.PI, false); // 绘制内圆 context.moveTo (194, 100); context.arc (100, 100, 94, 0, 2 * Math.PI, false); // 绘制分针 context.moveTo (100, 100); context.lineTo (100, 15); // 绘制时针 context.moveTo (100, 100); context.lineTo (35, 100); // 描边路径 context.stroke ();}

2DPathExample01.htm

这个例子使用 arc () 方法绘制了两个圆形：一个外圆和一个内圆，构成了表盘的边框。外圆的半径是 99 像素，圆心位于点 (100,100)，也是画布的中心点。为了绘制一个完整的圆形，我们从 0 弧度开始，绘制 2π 弧度（通过 Math.PI 来计算）。在绘制内圆之前，必须把路径移动到外圆上的某一点，以避免绘制出多余的线条。第二次调用 arc () 使用了小一点的半径，以便创造边框的效果。然后，组合使用 moveTo () 和 lineTo () 方法来绘制时针和分针。最后一步是调用 stroke () 方法，这样才能把图形绘制到画布上，如图 15-4 所示。

图　15-4

在 2D 绘图上下文中，路径是一种主要的绘图方式，因为路径能为要绘制的图形提供更多控制。由于路径的使用很频繁，所以就有了一个名为 isPointInPath () 的方法。这个方法接收 x 和 y 坐标作为参数，用于在路径被关闭之前确定画布上的某一点是否位于路径上，例如：

if (context.isPointInPath(100, 100)){ alert("Point (100, 100) is in the path."); }

2D 上下文中的路径 API 已经非常稳定，可以利用它们结合不同的填充和描边样式，绘制出非常复杂的图形来。

15.2.4　绘制文本

文本与图形总是如影随形。为此，2D 绘图上下文也提供了绘制文本的方法。绘制文本主要有两个方法：fillText () 和 strokeText ()。这两个方法都可以接收 4 个参数：要绘制的文本字符串、x 坐标、y 坐标和可选的最大像素宽度。而且，这两个方法都以下列 3 个属性为基础。

font：表示文本样式、大小及字体，用 CSS 中指定字体的格式来指定，例如 "10px Arial"。

textAlign：表示文本对齐方式。可能的值有 "start"、"end"、"left"、"right" 和 "center"。建议使用 "start" 和 "end"，不要使用 "left" 和 "right"，因为前两者的意思更稳妥，能同时适合从左到右和从右到左显示（阅读）的语言。

textBaseline：表示文本的基线。可能的值有 "top"、"hanging"、"middle"、"alphabetic"、"ideographic" 和 "bottom"。

这几个属性都有默认值，因此没有必要每次使用它们都重新设置一遍值。fillText () 方法使用 fillStyle 属性绘制文本，而 strokeText () 方法使用 strokeStyle 属性为文本描边。相对来说，还是使用 fillText () 的时候更多，因为该方法模仿了在网页中正常显示文本。例如，下面的代码在前一节创建的表盘上方绘制了数字 12：

context.font = "bold 14px Arial"; context.textAlign = "center"; context.textBaseline = "middle"; context.fillText("12", 100, 20);

2D TextExample01.htm

结果如图 15-5 所示。

图　15-5

因为这里把 textAlign 设置为 "center"，把 textBaseline 设置为 "middle"，所以坐标 (100,20) 表示的是文本水平和垂直中点的坐标。如果将 textAlign 设置为 "start"，则 x 坐标表示的是文本左端的位置（从左到右阅读的语言）；设置为 "end"，则 x 坐标表示的是文本右端的位置（从左到右阅读的语言）。例如：

// 正常 context.font = "bold 14px Arial"; context.textAlign = "center"; context.textBaseline = "middle"; context.fillText ("12", 100, 20); // 起点对齐 context.textAlign = "start"; context.fi llText ("12", 100, 40); // 终点对齐 context.textAlign = "end"; context.fi llText ("12", 100, 60);

2DTextExample02.htm

这一回绘制了三个字符串 "12"，每个字符串的 x 坐标值相同，但 textAlign 值不同。另外，后两个字符串的 y 坐标依次增大，以避免相互重叠。结果如图 15-6 所示。

图　15-6

表盘中的分针恰好位于正中间，因此文本的水平对齐方式如何变化也能够一目了然。类似地，修改 textBaseline 属性的值可以调整文本的垂直对齐方式：值为 "top"，y 坐标表示文本顶端；值为 "bottom"，y 坐标表示文本底端；值为 "hanging"、"alphabetic" 和 "ideographic"，则 y 坐标分别指向字体的特定基线坐标。

由于绘制文本比较复杂，特别是需要把文本控制在某一区域中的时候，2D 上下文提供了辅助确定文本大小的方法 measureText ()。这个方法接收一个参数，即要绘制的文本；返回一个 TextMetrics 对象。返回的对象目前只有一个 width 属性，但将来还会增加更多度量属性。

measureText () 方法利用 font、textAlign 和 textBaseline 的当前值计算指定文本的大小。比如，假设你想在一个 140 像素宽的矩形区域中绘制文本 Hello world!，下面的代码从 100 像素的字体大小开始递减，最终会找到合适的字体大小。

var fontSize = 100; context.font = fontSize + "px Arial"; while(context.measureText("Hello world!").width > 140){ fontSize--; context.font = fontSize + "px Arial"; } context.fillText("Hello world!", 10, 10); context.fillText("Font size is " + fontSize + "px", 10, 50);

2DTextExample03.htm

前面提到过，fillText 和 strokeText () 方法都可以接收第四个参数，也就是文本的最大像素宽度。不过，这个可选的参数尚未得到所有浏览器支持（最早支持它的是 Firefox 4）。提供这个参数后，调用 fillText () 或 strokeText () 时如果传入的字符串大于最大宽度，则绘制的文本字符的高度正确，但宽度会收缩以适应最大宽度。图 15-7 展示了这个效果。

图　15-7

绘制文本还是相对比较复杂的操作，因此支持 <canvas> 元素的浏览器也并未完全实现所有与绘制文本相关的 API。

15.2.5　变换

通过上下文的变换，可以把处理后的图像绘制到画布上。2D 绘制上下文支持各种基本的绘制变换。创建绘制上下文时，会以默认值初始化变换矩阵，在默认的变换矩阵下，所有处理都按描述直接绘制。为绘制上下文应用变换，会导致使用不同的变换矩阵应用处理，从而产生不同的结果。

可以通过如下方法来修改变换矩阵。

rotate (angle)：围绕原点旋转图像 angle 弧度。

scale (scaleX, scaleY)：缩放图像，在 x 方向乘以 scaleX，在 y 方向乘以 scaleY。scaleX 和 scaleY 的默认值都是 1.0。

translate (x, y)：将坐标原点移动到 (x,y)。执行这个变换之后，坐标 (0,0) 会变成之前由 (x,y) 表示的点。

transform (m1_1, m1_2, m2_1, m2_2, dx, dy)：直接修改变换矩阵，方式是乘以如下 矩阵。

m1_1 m1_2 dx m2_1 m2_2 dy 0 0 1

setTransform (m1_1, m1_2, m2_1, m2_2, dx, dy)：将变换矩阵重置为默认状态，然后再调用 transform ()。

变换有可能很简单，但也可能很复杂，这都要视情况而定。比如，就拿前面例子中绘制表针来说，如果把原点变换到表盘的中心，然后再绘制表针就容易多了。请看下面的例子。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); // 开始路径 context.beginPath (); // 绘制外圆 context.arc (100, 100, 99, 0, 2 * Math.PI, false); // 绘制内圆 context.moveTo (194, 100); context.arc (100, 100, 94, 0, 2 * Math.PI, false); // 变换原点 context.translate (100, 100); // 绘制分针 context.moveTo (0,0); context.lineTo (0, -85); // 绘制时针 context.moveTo (0, 0); context.lineTo (-65, 0); // 描边路径 context.stroke ();}

2DTransformExample01.htm

把原点变换到时钟表盘的中心点 (100,100) 后，在同一方向上绘制线条就变成了简单的数学问题了。所有数学计算都基于 (0,0)，而不是 (100,100)。还可以更进一步，像下面这样使用 rotate () 方法旋转时钟的表针。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"); // 开始路径 context.beginPath (); // 绘制外圆 context.arc (100, 100, 99, 0, 2 * Math.PI, false); // 绘制内圆 context.moveTo (194, 100); context.arc (100, 100, 94, 0, 2 * Math.PI, false); // 变换原点 context.translate (100, 100); // 旋转表针 context.rotate (1); // 绘制分针 context.moveTo (0,0); context.lineTo (0, -85); // 绘制时针 context.moveTo (0, 0); context.lineTo (-65, 0); // 描边路径 context.stroke ();}

2DTransformExample01.htm

因为原点已经变换到了时钟表盘的中心点，所以旋转也是以该点为圆心的。结果就像是表针真地被固定在表盘中心一样，然后向右旋转了一定角度。结果如图 15-8 所示。

图　15-8

无论是刚才执行的变换，还是 fillStyle、strokeStyle 等属性，都会在当前上下文中一直有效，除非再对上下文进行什么修改。虽然没有什么办法把上下文中的一切都重置回默认值，但有两个方法可以跟踪上下文的状态变化。如果你知道将来还要返回某组属性与变换的组合，可以调用 save () 方法。调用这个方法后，当时的所有设置都会进入一个栈结构，得以妥善保管。然后可以对上下文进行其他修改。等想要回到之前保存的设置时，可以调用 restore () 方法，在保存设置的栈结构中向前返回一级，恢复之前的状态。连续调用 save () 可以把更多设置保存到栈结构中，之后再连续调用 restore () 则可以一级一级返回。下面来看一个例子。

context.fillStyle = "#ff0000"; context.save (); context.fillStyle = "#00ff00"; context.translate (100, 100); context.save (); context.fillStyle = "#0000ff"; context.fillRect (0, 0, 100, 200); // 从点 (100,100) 开始绘制蓝色矩形 context.restore (); context.fillRect (10, 10, 100, 200); // 从点 (110,110) 开始绘制绿色矩形 context.restore (); context.fillRect (0, 0, 100, 200); // 从点 (0,0) 开始绘制红色矩形

2DSaveRestoreExample01.htm

首先，将 fillStyle 设置为红色，并调用 save () 保存上下文状态。接下来，把 fillStyle 修改为绿色，把坐标原点变换到 (100,100)，再调用 save () 保存上下文状态。然后，把 fillStyle 修改为蓝色并绘制蓝色的矩形。因为此时的坐标原点已经变了，所以矩形的左上角坐标实际上是 (100,100)。然后调用 restore ()，之后 fillStyle 变回了绿色，因而第二个矩形就是绿色。之所以第二个矩形的起点坐标是 (110,110)，是因为坐标位置的变换仍然起作用。再调用一次 restore ()，变换就被取消了，而 fillStyle 也返回了红色。所以最后一个矩形是红色的，而且绘制的起点是 (0,0)。

需要注意的是，save () 方法保存的只是对绘图上下文的设置和变换，不会保存绘图上下文的内容。

15.2.6　绘制图像

2D 绘图上下文内置了对图像的支持。如果你想把一幅图像绘制到画布上，可以使用 drawImage () 方法。根据期望的最终结果不同，调用这个方法时，可以使用三种不同的参数组合。最简单的调用方式是传入一个 HTML <img> 元素，以及绘制该图像的起点的 x 和 y 坐标。例如：

var image = document.images[0]; context.drawImage(image, 10, 10);

2DDrawImageExample01.htm

这两行代码取得了文档中的第一幅图像，然后将它绘制到上下文中，起点为 (10,10)。绘制到画布上的图像大小与原始大小一样。如果你想改变绘制后图像的大小，可以再多传入两个参数，分别表示目标宽度和目标高度。通过这种方式来缩放图像并不影响上下文的变换矩阵。例如：

context.drawImage(image, 50, 10, 20, 30);

2DDrawImageExample01.htm

执行代码后，绘制出来的图像大小会变成 20×30 像素。

除了上述两种方式，还可以选择把图像中的某个区域绘制到上下文中。drawImage () 方法的这种调用方式总共需要传入 9 个参数：要绘制的图像、源图像的 x 坐标、源图像的 y 坐标、源图像的宽度、源图像的高度、目标图像的 x 坐标、目标图像的 y 坐标、目标图像的宽度、目标图像的高度。这样调用 drawImage () 方法可以获得最多的控制。例如：

context.drawImage(image, 0, 10, 50, 50, 0, 100, 40, 60);

2DDrawImageExample01.htm

这行代码只会把原始图像的一部分绘制到画布上。原始图像的这一部分的起点为 (0,10)，宽和高都是 50 像素。最终绘制到上下文中的图像的起点是 (0,100)，而大小变成了 40×60 像素。

这种调用方式可以创造出很有意思的效果，如图 15-9 所示。

图　15-9

除了给 drawImage () 方法传入 HTML <img> 元素外，还可以传入另一个 <canvas> 元素作为其第一个参数。这样，就可以把另一个画布内容绘制到当前画布上。

结合使用 drawImage () 和其他方法，可以对图像进行各种基本操作。而操作的结果可以通过 toDataURL () 方法获得 1。不过，有一个例外，即图像不能来自其他域。如果图像来自其他域，调用 toDataURL () 会抛出一个错误。打个比方，假如位于 www.example.com 上的页面绘制的图像来自于 www.example.com，那当前上下文就会被认为「不干净」，因而会抛出错误。

1 请读者注意，虽然本章至今一直在讨论 2D 绘图上下文，但 toDataURL () 是 Canvas 对象的方法，不是上下文对象的方法。

15.2.7　阴影

2D 上下文会根据以下几个属性的值，自动为形状或路径绘制出阴影。

shadowColor：用 CSS 颜色格式表示的阴影颜色，默认为黑色。

shadowOffsetX：形状或路径 x 轴方向的阴影偏移量，默认为 0。

shadowOffsetY：形状或路径 y 轴方向的阴影偏移量，默认为 0。

shadowBlur：模糊的像素数，默认 0，即不模糊。

这些属性都可以通过 context 对象来修改。只要在绘制前为它们设置适当的值，就能自动产生阴影。例如：

var context = drawing.getContext ("2d"); // 设置阴影 context.shadowOffsetX = 5; context.shadowOffsetY = 5; context.shadowBlur = 4; context.shadowColor = "rgba (0, 0, 0, 0.5)"; // 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 绘制蓝色矩形 context.fillStyle = "rgba (0,0,255,1)"; context.fillRect (30, 30, 50, 50);

2DFillRectShadowExample01.htm

两个矩形的阴影样式相同，结果如图 15-10 所示。

图　15-10

不同浏览器对阴影的支持有一些差异。IE9、Firefox 4 和 Opera 11 的行为最为规范，其他浏览器多多少少会有一些奇怪的现象，甚至根本不支持阴影。Chrome（直至第 10 版）不能正确地为描边的形状应用实心阴影。Chrome 和 Safari（直至第 5 版）在为带透明像素的图像应用阴影时也会有问题：不透明部分的下方本来是该有阴影的，但此时则一概不见了。Safari 也不能给渐变图形应用阴影，其他浏览器都可以。

15.2.8　渐变

渐变由 CanvasGradient 实例表示，很容易通过 2D 上下文来创建和修改。要创建一个新的线性渐变，可以调用 createLinearGradient () 方法。这个方法接收 4 个参数：起点的 x 坐标、起点的 y 坐标、终点的 x 坐标、终点的 y 坐标。调用这个方法后，它就会创建一个指定大小的渐变，并返回 CanvasGradient 对象的实例。

创建了渐变对象后，下一步就是使用 addColorStop () 方法来指定色标。这个方法接收两个参数：色标位置和 CSS 颜色值。色标位置是一个 0（开始的颜色）到 1（结束的颜色）之间的数字。例如：

var gradient = context.createLinearGradient(30, 30, 70, 70); gradient.addColorStop(0, "white"); gradient.addColorStop(1, "black");

2DFillRectGradientExample01.htm

此时，gradient 对象表示的是一个从画布上点 (30,30) 到点 (70,70) 的渐变。起点的色标是白色，终点的色标是黑色。然后就可以把 fillStyle 或 strokeStyle 设置为这个对象，从而使用渐变来绘制形状或描边：

// 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 绘制渐变矩形 context.fillStyle = gradient; context.fillRect (30, 30, 50, 50);

2DFillRectGradientExample01.htm

为了让渐变覆盖整个矩形，而不是仅应用到矩形的一部分，矩形和渐变对象的坐标必须匹配才行。以上代码会得到如图 15-11 所示的结果。

图　15-11

如果没有把矩形绘制到恰当的位置，那可能就只会显示部分渐变效果。例如：

context.fillStyle = gradient; context.fillRect(50, 50, 50, 50);

2DFillRectGradientExample02.htm

这两行代码执行后得到的矩形只有左上角稍微有一点白色。这主要是因为矩形的起点位于渐变的中间位置，而此时渐变差不多已经结束了。由于渐变不重复，所以矩形的大部分区域都是黑色。确保渐变与形状对齐非常重要，有时候可以考虑使用函数来确保坐标合适。例如：

function createRectLinearGradient(context, x, y, width, height){ return context.createLinearGradient(x, y, x+width, y+height); }

2DFillRectGradientExample03.htm

这个函数基于起点的 x 和 y 坐标以及宽度和高度值来创建渐变对象，从而让我们可以在 fillRect () 中使用相同的值。

var gradient = createRectLinearGradient (context, 30, 30, 50, 50); gradient.addColorStop (0, "white"); gradient.addColorStop (1, "black"); // 绘制渐变矩形 context.fi llStyle = gradient; context.fillRect (30, 30, 50, 50);

2DFillRectGradientExample03.htm

使用画布的时候，确保坐标匹配很重要，也需要一些技巧。类似 createRectLinearGradient () 这样的辅助方法可以让控制坐标更容易一些。

要创建径向渐变（或放射渐变），可以使用 createRadialGradient () 方法。这个方法接收 6 个参数，对应着两个圆的圆心和半径。前三个参数指定的是起点圆的原心（x 和 y）及半径，后三个参数指定的是终点圆的原心（x 和 y）及半径。可以把径向渐变想象成一个长圆桶，而这 6 个参数定义的正是这个桶的两个圆形开口的位置。如果把一个圆形开口定义得比另一个小一些，那这个圆桶就变成了圆锥体，而通过移动每个圆形开口的位置，就可达到像旋转这个圆锥体一样的效果。

如果想从某个形状的中心点开始创建一个向外扩散的径向渐变效果，就要将两个圆定义为同心圆。比如，就拿前面创建的矩形来说，径向渐变的两个圆的圆心都应该在 (55,55)，因为矩形的区域是从 (30,30) 到 (80,80)。请看代码：

var gradient = context.createRadialGradient (55, 55, 10, 55, 55, 30); gradient.addColorStop (0, "white"); gradient.addColorStop (1, "black"); // 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 绘制渐变矩形 context.fillStyle = gradient; context.fillRect (30, 30, 50, 50);

2DFillRectGradientExample04.htm

运行代码，会得到如图 15-12 所示的结果。

图　15-12

