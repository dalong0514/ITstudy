SealedObjectsExample01.htm

在这个例子中，添加 age 属性的行为被忽略了。而尝试删除 name 属性的操作也被忽略了，因此这个属性没有受任何影响。这是在非严格模式下的行为。在严格模式下，尝试添加或删除对象成员都会导致抛出错误。

使用 Object.isSealed () 方法可以确定对象是否被密封了。因为被密封的对象不可扩展，所以用 Object.isExtensible () 检测密封的对象也会返回 false。

var person = { name: "Nicholas" }; alert(Object.isExtensible(person)); //true alert(Object.isSealed(person)); //false Object.seal(person); alert(Object.isExtensible(person)); //false alert(Object.isSealed(person)); //true

SealedObjectsExample02.htm

22.2.3　冻结的对象

最严格的防篡改级别是冻结对象（frozen object）。冻结的对象既不可扩展，又是密封的，而且对象数据属性的 [[Writable]] 特性会被设置为 false。如果定义 [[Set]] 函数，访问器属性仍然是可写的。ECMAScript 5 定义的 Object.freeze () 方法可以用来冻结对象。

var person = { name: "Nicholas" }; Object.freeze(person); person.age = 29; alert(person.age); //undefined delete person.name; alert(person.name); //"Nicholas" person.name = "Greg"; alert(person.name); //"Nicholas"

FrozenObjectsExample01.htm

与密封和不允许扩展一样，对冻结的对象执行非法操作在非严格模式下会被忽略，而在严格模式下会抛出错误。

当然，也有一个 Object.isFrozen () 方法用于检测冻结对象。因为冻结对象既是密封的又是不可扩展的，所以用 Object.isExtensible () 和 Object.isSealed () 检测冻结对象将分别返回 false 和 true。

var person = { name: "Nicholas" }; alert(Object.isExtensible(person)); //true alert(Object.isSealed(person)); //false alert(Object.isFrozen(person)); //false Object.freeze(person); alert(Object.isExtensible(person)); //false alert(Object.isSealed(person)); //true alert(Object.isFrozen(person)); //true

FrozenObjectsExample02.htm

对 JavaScript 库的作者而言，冻结对象是很有用的。因为 JavaScript 库最怕有人意外（或有意）地修改了库中的核心对象。冻结（或密封）主要的库对象能够防止这些问题的发生。

22.3　高级定时器

使用 setTimeout () 和 setInterval () 创建的定时器可以用于实现有趣且有用的功能。虽然人们对 JavaScript 的定时器存在普遍的误解，认为它们是线程，其实 JavaScript 是运行于单线程的环境中的，而定时器仅仅只是计划代码在未来的某个时间执行。执行时机是不能保证的，因为在页面的生命周期中，不同时间可能有其他代码在控制 JavaScript 进程。在页面下载完后的代码运行、事件处理程序、Ajax 回调函数都必须使用同样的线程来执行。实际上，浏览器负责进行排序，指派某段代码在某个时间点运行的优先级。

可以把 JavaScript 想象成在时间线上运行的。当页面载入时，首先执行是任何包含在 <script> 元素中的代码，通常是页面生命周期后面要用到的一些简单的函数和变量的声明，不过有时候也包含一些初始数据的处理。在这之后，JavaScript 进程将等待更多代码执行。当进程空闲的时候，下一个代码会被触发并立刻执行。例如，当点击某个按钮时，onclick 事件处理程序会立刻执行，只要 JavaScript 进程处于空闲状态。这样一个页面的时间线类似于图 22-1。

图　22-1

除了主 JavaScript 执行进程外，还有一个需要在进程下一次空闲时执行的代码队列。随着页面在其生命周期中的推移，代码会按照执行顺序添加入队列。例如，当某个按钮被按下时，它的事件处理程序代码就会被添加到队列中，并在下一个可能的时间里执行。当接收到某个 Ajax 响应时，回调函数的代码会被添加到队列。在 JavaScript 中没有任何代码是立刻执行的，但一旦进程空闲则尽快执行。

定时器对队列的工作方式是，当特定时间过去后将代码插入。注意，给队列添加代码并不意味着对它立刻执行，而只能表示它会尽快执行。设定一个 150ms 后执行的定时器不代表到了 150ms 代码就立刻执行，它表示代码会在 150ms 后被加入到队列中。如果在这个时间点上，队列中没有其他东西，那么这段代码就会被执行，表面上看上去好像代码就在精确指定的时间点上执行了。其他情况下，代码可能明显地等待更长时间才执行。

请看以下代码：

var btn = document.getElementById ("my-btn"); btn.onclick = function (){ setTimeout (function (){document.getElementById ("message").style.visibility = "visible"; }, 250); // 其他代码 };

在这里给一个按钮设置了一个事件处理程序。事件处理程序设置了一个 250ms 后调用的定时器。点击该按钮后，首先将 onclick 事件处理程序加入队列。该程序执行后才设置定时器，再有 250ms 后，指定的代码才被添加到队列中等待执行。实际上，对 setTimeout () 的调用表示要晚点执行某些代码。

关于定时器要记住的最重要的事情是，指定的时间间隔表示何时将定时器的代码添加到队列，而不是何时实际执行代码。如果前面例子中的 onclick 事件处理程序执行了 300ms，那么定时器的代码至少要在定时器设置之后的 300ms 后才会被执行。队列中所有的代码都要等到 JavaScript 进程空闲之后才能执行，而不管它们是如何添加到队列中的。见图 22-2。

图　22-2

如图 22-2 所示，尽管在 255ms 处添加了定时器代码，但这时候还不能执行，因为 onclick 事件处理程序仍在运行。定时器代码最早能执行的时机是在 300ms 处，即 onclick 事件处理程序结束之后。

实际上 Firefox 中定时器的实现还能让你确定定时器过了多久才执行，这需传递一个实际执行的时间与指定的间隔的差值。如下面的例子所示。

// 仅 Firefox 中 setTimeout (function (diff){if (diff> 0) {// 晚调用} else if (diff < 0){// 早调用} else {// 调用及时} }, 250);

执行完一套代码后，JavaScript 进程返回一段很短的时间，这样页面上的其他处理就可以进行了。由于 JavaScript 进程会阻塞其他页面处理，所以必须有这些小间隔来防止用户界面被锁定（代码长时间运行中还有可能出现）。这样设置一个定时器，可以确保在定时器代码执行前至少有一个进程间隔。

22.3.1　重复的定时器

使用 setInterval () 创建的定时器确保了定时器代码规则地插入队列中。这个方式的问题在于，定时器代码可能在代码再次被添加到队列之前还没有完成执行，结果导致定时器代码连续运行好几次，而之间没有任何停顿。幸好，JavaScript 引擎够聪明，能避免这个问题。当使用 setInterval () 时，仅当没有该定时器的任何其他代码实例时，才将定时器代码添加到队列中。这确保了定时器代码加入到队列中的最小时间间隔为指定间隔。

这种重复定时器的规则有 2 点问题：(1) 某些间隔会被跳过；(2) 多个定时器的代码执行之间的间隔可能会比预期的小。假设，某个 onclick 事件处理程序使用 setInterval () 设置了一个 200ms 间隔的重复定时器。如果事件处理程序花了 300ms 多一点的时间完成，同时定时器代码也花了差不多的时间，就会跳过一个间隔同时运行着一个定时器代码。参见图 22-3。

图　22-3

这个例子中的第 1 个定时器是在 205ms 处添加到队列中的，但是直到过了 300ms 处才能够执行。当执行这个定时器代码时，在 405ms 处又给队列添加了另外一个副本。在下一个间隔，即 605ms 处，第一个定时器代码仍在运行，同时在队列中已经有了一个定时器代码的实例。结果是，在这个时间点上的定时器代码不会被添加到队列中。结果在 5ms 处添加的定时器代码结束之后，405ms 处添加的定时器代码就立刻执行。

为了避免 setInterval () 的重复定时器的这 2 个缺点，你可以用如下模式使用链式 setTimeout () 调用。

setTimeout (function (){// 处理中 setTimeout (arguments.callee, interval); }, interval);

这个模式链式调用了 setTimeout ()，每次函数执行的时候都会创建一个新的定时器。第二个 setTimeout () 调用使用了 arguments.callee 来获取对当前执行的函数的引用，并为其设置另外一个定时器。这样做的好处是，在前一个定时器代码执行完之前，不会向队列插入新的定时器代码，确保不会有任何缺失的间隔。而且，它可以保证在下一次定时器代码执行之前，至少要等待指定的间隔，避免了连续的运行。这个模式主要用于重复定时器，如下例所示。

setTimeout(function(){ var div = document.getElementById("myDiv"); left = parseInt(div.style.left) + 5; div.style.left = left + "px"; if (left < 200){ setTimeout(arguments.callee, 50); } }, 50);

RepeatingTimersExample.htm

这段定时器代码每次执行的时候将一个 <div> 元素向右移动，当左坐标在 200 像素的时候停止。JavaScript 动画中使用这个模式很常见。

每个浏览器窗口、标签页、或者框架都有其各自的代码执行队列。这意味着，进行跨框架或者跨窗口的定时调用，当代码同时执行的时候可能会导致竞争条件。无论何时需要使用这种通信类型，最好是在接收框架或者窗口中创建一个定时器来执行 代码。

22.3.2　Yielding Processes

运行在浏览器中的 JavaScript 都被分配了一个确定数量的资源。不同于桌面应用往往能够随意控制他们要的内存大小和处理器时间，JavaScript 被严格限制了，以防止恶意的 Web 程序员把用户的计算机搞挂了。其中一个限制是长时间运行脚本的制约，如果代码运行超过特定的时间或者特定语句数量就不让它继续执行。如果代码达到了这个限制，会弹出一个浏览器错误的对话框，告诉用户某个脚本会用过长的时间执行，询问是允许其继续执行还是停止它。所有 JavaScript 开发人员的目标就是，确保用户永远不会在浏览器中看到这个令人费解的对话框。定时器是绕开此限制的方法之一。

脚本长时间运行的问题通常是由两个原因之一造成的：过长的、过深嵌套的函数调用或者是进行大量处理的循环。这两者中，后者是较为容易解决的问题。长时间运行的循环通常遵循以下模式：

for (var i=0, len=data.length; i < len; i++){ process(data[i]); }

这个模式的问题在于要处理的项目的数量在运行前是不可知的。如果完成 process () 要花 100ms，只有 2 个项目的数组可能不会造成影响，但是 10 个的数组可能会导致脚本要运行一秒钟才能完成。数组中的项目数量直接关系到执行完该循环的时间长度。同时由于 JavaScript 的执行是一个阻塞操作，脚本运行所花时间越久，用户无法与页面交互的时间也越久。

在展开该循环之前，你需要回答以下两个重要的问题。

该处理是否必须同步完成？如果这个数据的处理会造成其他运行的阻塞，那么最好不要改动它。不过，如果你对这个问题的回答确定为「否」，那么将某些处理推迟到以后是个不错的备选项。

数据是否必须按顺序完成？通常，数组只是对项目的组合和迭代的一种简便的方法而无所谓顺序。如果项目的顺序不是非常重要，那么可能可以将某些处理推迟到以后。

当你发现某个循环占用了大量时间，同时对于上述两个问题，你的回答都是「否」，那么你就可以使用定时器分割这个循环。这是一种叫做数组分块（array chunking）的技术，小块小块地处理数组，通常每次一小块。基本的思路是为要处理的项目创建一个队列，然后使用定时器取出下一个要处理的项目进行处理，接着再设置另一个定时器。基本的模式如下。

setTimeout (function (){// 取出下一个条目并处理 var item = array.shift (); process (item); // 若还有条目，再设置另一个定时器 if (array.length> 0){setTimeout (arguments.callee, 100); } }, 100);

在数组分块模式中，array 变量本质上就是一个「待办事宜」列表，它包含了要处理的项目。使用 shift () 方法可以获取队列中下一个要处理的项目，然后将其传递给某个函数。如果在队列中还有其他项目，则设置另一个定时器，并通过 arguments.callee 调用同一个匿名函数。要实现数组分块非常简单，可以使用以下函数。

function chunk(array, process, context){ setTimeout(function(){ var item = array.shift(); process.call(context, item); if (array.length > 0){ setTimeout(arguments.callee, 100); } }, 100); }

ArrayChunkingExample.htm

chunk () 方法接受三个参数：要处理的项目的数组，用于处理项目的函数，以及可选的运行该函数的环境。函数内部用了之前描述过的基本模式，通过 call () 调用的 process () 函数，这样可以设置一个合适的执行环境（如果必须）。定时器的时间间隔设置为了 100ms，使得 JavaScript 进程有时间在处理项目的事件之间转入空闲。你可以根据你的需要更改这个间隔大小，不过 100ms 在大多数情况下效果不错。可以按如下所示使用该函数：

var data = [12,123,1234,453,436,23,23,5,4123,45,346,5634,2234,345,342]; function printValue(item){ var div = document.getElementById("myDiv"); div.innerHTML += item + "<br>"; } chunk(data, printValue);

ArrayChunkingExample.htm

这个例子使用 printValue () 函数将 data 数组中的每个值输出到一个 < div> 元素。由于函数处在全局作用域内，因此无需给 chunk () 传递一个 context 对象。

必须当心的地方是，传递给 chunk () 的数组是用作一个队列的，因此当处理数据的同时，数组中的条目也在改变。如果你想保持原数组不变，则应该将该数组的克隆传递给 chunk ()，如下例所示：

chunk(data.concat(), printValue);

当不传递任何参数调用某个数组的 concat () 方法时，将返回和原来数组中项目一样的数组。这样你就可以保证原数组不会被该函数更改。

数组分块的重要性在于它可以将多个项目的处理在执行队列上分开，在每个项目处理之后，给予其他的浏览器处理机会运行，这样就可能避免长时间运行脚本的错误。

一旦某个函数需要花 50ms 以上的时间完成，那么最好看看能否将任务分割为一系列可以使用定时器的小任务。

22.3.3　函数节流

浏览器中某些计算和处理要比其他的昂贵很多。例如，DOM 操作比起非 DOM 交互需要更多的内存和 CPU 时间。连续尝试进行过多的 DOM 相关操作可能会导致浏览器挂起，有时候甚至会崩溃。尤其在 IE 中使用 onresize 事件处理程序的时候容易发生，当调整浏览器大小的时候，该事件会连续触发。在 onresize 事件处理程序内部如果尝试进行 DOM 操作，其高频率的更改可能会让浏览器崩溃。为了绕开这个问题，你可以使用定时器对该函数进行节流。

函数节流背后的基本思想是指，某些代码不可以在没有间断的情况连续重复执行。第一次调用函数，创建一个定时器，在指定的时间间隔之后运行代码。当第二次调用该函数时，它会清除前一次的定时器并设置另一个。如果前一个定时器已经执行过了，这个操作就没有任何意义。然而，如果前一个定时器尚未执行，其实就是将其替换为一个新的定时器。目的是只有在执行函数的请求停止了一段时间之后才执行。以下是该模式的基本形式：

var processor = {timeoutId: null, // 实际进行处理的方法 performProcessing: function (){// 实际执行的代码}, // 初始处理调用的方法 process: function (){ clearTimeout (this.timeoutId); var that = this; this.timeoutId = setTimeout (function (){that.performProcessing (); }, 100); } }; // 尝试开始执行 processor.process ();

在这段代码中，创建了一个叫做 processor 对象。这个对象还有 2 个方法：process () 和 performProcessing ()。前者是初始化任何处理所必须调用的，后者则实际进行应完成的处理。当调用了 process ()，第一步是清除存好的 timeoutId，来阻止之前的调用被执行。然后，创建一个新的定时器调用 performProcessing ()。由于 setTimeout () 中用到的函数的环境总是 window，所以有必要保存 this 的引用以方便以后使用。

时间间隔设为了 100ms，这表示最后一次调用 process () 之后至少 100ms 后才会调用 performProcessing ()。所以如果 100ms 之内调用了 process () 共 20 次，performanceProcessing () 仍只会被调用一次。

这个模式可以使用 throttle () 函数来简化，这个函数可以自动进行定时器的设置和清除，如下例所示：

function throttle(method, context) { clearTimeout(method.tId); method.tId= setTimeout(function(){ method.call(context); }, 100); }

ThrottlingExample.htm

throttle () 函数接受两个参数：要执行的函数以及在哪个作用域中执行。上面这个函数首先清除之前设置的任何定时器。定时器 ID 是存储在函数的 tId 属性中的，第一次把方法传递给 throttle () 的时候，这个属性可能并不存在。接下来，创建一个新的定时器，并将其 ID 储存在方法的 tId 属性中。如果这是第一次对这个方法调用 throttle () 的话，那么这段代码会创建该属性。定时器代码使用 call () 来确保方法在适当的环境中执行。如果没有给出第二个参数，那么就在全局作用域内执行该方法。

前面提到过，节流在 resize 事件中是最常用的。如果你基于该事件来改变页面布局的话，最好控制处理的频率，以确保浏览器不会在极短的时间内进行过多的计算。例如，假设有一个 <div/> 元素需要保持它的高度始终等同于宽度。那么实现这一功能的 JavaScript 可以如下编写：

window.onresize = function(){ var div = document.getElementById("myDiv"); div.style.height = div. offsetWidth + "px"; };

这段非常简单的例子有两个问题可能会造成浏览器运行缓慢。首先，要计算 offsetWidth 属性，如果该元素或者页面上其他元素有非常复杂的 CSS 样式，那么这个过程将会很复杂。其次，设置某个元素的高度需要对页面进行回流来令改动生效。如果页面有很多元素同时应用了相当数量的 CSS 的话，这又需要很多计算。这就可以用到 throttle () 函数，如下例所示：

function resizeDiv(){ var div = document.getElementById("myDiv"); div.style.height = div.offsetWidth + "px"; } window.onresize = function(){ throttle(resizeDiv); };

ThrottlingExample.htm

这里，调整大小的功能被放入了一个叫做 resizeDiv () 的单独函数中。然后 onresize 事件处理程序调用 throttle () 并传入 resizeDiv 函数，而不是直接调用 resizeDiv ()。多数情况下，用户是感觉不到变化的，虽然给浏览器节省的计算可能会非常大。

只要代码是周期性执行的，都应该使用节流，但是你不能控制请求执行的速率。这里展示的 throttle () 函数用了 100ms 作为间隔，你当然可以根据你的需要来修改它。

22.4　自定义事件

在本书前面，你已经学到事件是 JavaScript 与浏览器交互的主要途径。事件是一种叫做观察者的设计模式，这是一种创建松散耦合代码的技术。对象可以发布事件，用来表示在该对象生命周期中某个有趣的时刻到了。然后其他对象可以观察该对象，等待这些有趣的时刻到来并通过运行代码来响应。

观察者模式由两类对象组成：主体和观察者。主体负责发布事件，同时观察者通过订阅这些事件来观察该主体。该模式的一个关键概念是主体并不知道观察者的任何事情，也就是说它可以独自存在并正常运作即使观察者不存在。从另一方面来说，观察者知道主体并能注册事件的回调函数（事件处理程序）。涉及 DOM 上时，DOM 元素便是主体，你的事件处理代码便是观察者。

事件是与 DOM 交互的最常见的方式，但它们也可以用于非 DOM 代码中 —— 通过实现自定义事件。自定义事件背后的概念是创建一个管理事件的对象，让其他对象监听那些事件。实现此功能的基本模式可以如下定义：

function EventTarget(){ this.handlers = {}; } EventTarget.prototype = { constructor: EventTarget, addHandler: function(type, handler){ if (typeof this.handlers[type] == "undefined"){ this.handlers[type] = []; } this.handlers[type].push(handler); }, fire: function(event){ if (!event.target){ event.target = this; } if (this.handlers[event.type] instanceof Array){ var handlers = this.handlers[event.type]; for (var i=0, len=handlers.length; i < len; i++){ handlers[i](event); } } }, removeHandler: function(type, handler){ if (this.handlers[type] instanceof Array){ var handlers = this.handlers[type]; for (var i=0, len=handlers.length; i < len; i++){ if (handlers[i] === handler){ break; } } handlers.splice(i, 1); } } };

EventTarget.js

EventTarget 类型有一个单独的属性 handlers，用于储存事件处理程序。还有三个方法：addHandler ()，用于注册给定类型事件的事件处理程序；fire ()，用于触发一个事件； removeHandler ()，用于注销某个事件类型的事件处理程序。

addHandler () 方法接受两个参数：事件类型和用于处理该事件的函数。当调用该方法时，会进行一次检查，看看 handlers 属性中是否已经存在一个针对该事件类型的数组；如果没有，则创建一个新的。然后使用 push () 将该处理程序添加到数组的末尾。

如果要触发一个事件，要调用 fire () 函数。该方法接受一个单独的参数，是一个至少包含 type 属性的对象。fire () 方法先给 event 对象设置一个 target 属性，如果它尚未被指定的话。然后它就查找对应该事件类型的一组处理程序，调用各个函数，并给出 event 对象。因为这些都是自定义事件，所以 event 对象上还需要的额外信息由你自己决定。

removeHandler () 方法是 addHandler () 的辅助，它们接受的参数一样：事件的类型和事件处理程序。这个方法搜索事件处理程序的数组找到要删除的处理程序的位置。如果找到了，则使用 break 操作符退出 for 循环。然后使用 splice () 方法将该项目从数组中删除。

然后，使用 EventTarget 类型的自定义事件可以如下使用：

function handleMessage (event){alert ("Message received:" + event.message); } // 创建一个新对象 var target = new EventTarget (); // 添加一个事件处理程序 target.addHandler ("message", handleMessage); // 触发事件 target.fire ({type: "message", message: "Hello world!"}); // 删除事件处理程序 target.removeHandler ("message", handleMessage); // 再次，应没有处理程序 target.fire ({type: "message", message: "Hello world!"});

EventTargetExample01.htm

在这段代码中，定义了 handleMessage () 函数用于处理 message 事件。它接受 event 对象并输出 message 属性。调用 target 对象的 addHandler () 方法并传给 "message" 以及 handleMessage () 函数。在接下来的一行上，调用了 fire () 函数，并传递了包含 2 个属性，即 type 和 message 的对象直接量。它会调用 message 事件的事件处理程序，这样就会显示一个警告框（来自 handleMessage ()）。然后删除了事件处理程序，这样即使事件再次触发，也不会显示任何警告框。

因为这种功能是封装在一种自定义类型中的，其他对象可以继承 EventTarget 并获得这个行为，如下例所示：

function Person(name, age){ EventTarget.call(this); this.name = name; this.age = age; } inheritPrototype(Person,EventTarget); Person.prototype.say = function(message){ this.fire({type: "message", message: message}); };

EventTargetExample02.htm

Person 类型使用了寄生组合继承（参见第 6 章）方法来继承 EventTarget。一旦调用了 say () 方法，便触发了事件，它包含了消息的细节。在某种类型的另外的方法中调用 fire () 方法是很常见的，同时它通常不是公开调用的。这段代码可以照如下方式使用：

function handleMessage (event){alert (event.target.name + "says:" + event.message); } // 创建新 person var person = new Person ("Nicholas", 29); // 添加一个事件处理程序 person.addHandler ("message", handleMessage); // 在该对象上调用 1 个方法，它触发消息事件 person.say ("Hi there.");

EventTargetExample02.htm

这个例子中的 handleMessage () 函数显示了某人名字（通过 event.target.name 获得）的一个警告框和消息正文。当调用 say () 方法并传递一个消息时，就会触发 message 事件。接下来，它又会调用 handleMessage () 函数并显示警告框。

当代码中存在多个部分在特定时刻相互交互的情况下，自定义事件就非常有用了。这时，如果每个对象都有对其他所有对象的引用，那么整个代码就会紧密耦合，同时维护也变得很困难，因为对某个对象的修改也会影响到其他对象。使用自定义事件有助于解耦相关对象，保持功能的隔绝。在很多情况中，触发事件的代码和监听事件的代码是完全分离的。

22.5　拖放

拖放是一种非常流行的用户界面模式。它的概念很简单：点击某个对象，并按住鼠标按钮不放，将鼠标移动到另一个区域，然后释放鼠标按钮将对象「放」在这里。拖放功能也流行到了 Web 上，成为了一些更传统的配置界面的一种候选方案。

拖放的基本概念很简单：创建一个绝对定位的元素，使其可以用鼠标移动。这个技术源自一种叫做「鼠标拖尾」的经典网页技巧。鼠标拖尾是一个或者多个图片在页面上跟着鼠标指针移动。单元素鼠标拖尾的基本代码需要为文档设置一个 onmousemove 事件处理程序，它总是将指定元素移动到鼠标指针的位置，如下面的例子所示。

EventUtil.addHandler(document, "mousemove", function(event){ var myDiv = document.getElementById("myDiv"); myDiv.style.left = event.clientX + "px"; myDiv.style.top = event.clientY + "px"; });

DragAndDropExample01.htm

在这个例子中，元素的 left 和 top 坐标设置为了 event 对象的 clientX 和 clientY 属性，这就将元素方到了视口中指针的位置上。它的效果是一个元素始终跟随指针在页面上的移动。只要正确的时刻（当鼠标按钮按下的时候）实现该功能，并在之后删除它（当释放鼠标按钮时），就可以实现拖放了。最简单的拖放界面可用以下代码实现：

var DragDrop = function (){ var dragging = null; function handleEvent (event){// 获取事件和目标 event = EventUtil.getEvent (event); var target = EventUtil.getTarget (event); // 确定事件类型 switch (event.type){case "mousedown": if (target.className.indexOf ("draggable") > -1){dragging = target;} break; case "mousemove": if (dragging !== null){//assign location dragging.style.left = event.clientX + "px"; dragging.style.top = event.clientY + "px";} break; case "mouseup": dragging = null; break; } }; // 公共接口 return {enable: function (){EventUtil.addHandler (document, "mousedown", handleEvent); EventUtil.addHandler (document, "mousemove", handleEvent); EventUtil.addHandler (document, "mouseup", handleEvent); }, disable: function (){ EventUtil.removeHandler (document, "mousedown", handleEvent); EventUtil.removeHandler (document, "mousemove", handleEvent); EventUtil.removeHandler (document, "mouseup", handleEvent); } } }();

DragAndDropExample02.htm

DragDrop 对象封装了拖放的所有基本功能。这是一个单例对象，并使用了模块模式来隐藏某些实现细节。dragging 变量起初是 null，将会存放被拖动的元素，所以当该变量不为 null 时，就知道正在拖动某个东西。handleEvent () 函数处理拖放功能中的所有的三个鼠标事件。它首先获取 event 对象和事件目标的引用。之后，用一个 switch 语句确定要触发哪个事件样式。当 mousedown 事件发生时，会检查 target 的 class 是否包含 "draggable" 类，如果是，那么将 target 存放到 dragging 中。这个技巧可以很方便地通过标记语言而非 JavaScript 脚本来确定可拖动的元素。

handleEvent () 的 mousemove 情况和前面的代码一样，不过要检查 dragging 是否为 null。当它不是 null，就知道 dragging 就是要拖动的元素，这样就会把它放到恰当的位置上。mouseup 情况就仅仅是将 dragging 重置为 null，让 mousemove 事件中的判断失效。

DragDrop 还有两个公共方法：enable () 和 disable ()，它们只是相应添加和删除所有的事件处理程序。这两个函数提供了额外的对拖放功能的控制手段。

要使用 DragDrop 对象，只要在页面上包含这些代码并调用 enable ()。拖放会自动针对所有包含 "draggable" 类的元素启用，如下例所示：

<div class="draggable" style="position:absolute; background:red"> </div>

注意为了元素能被拖放，它必须是绝对定位的。

22.5.1　修缮拖动功能

当你试了上面的例子之后，你会发现元素的左上角总是和指针在一起。这个结果对用户来说有一点不爽，因为当鼠标开始移动的时候，元素好像是突然跳了一下。理想情况是，这个动作应该看上去好像这个元素是被指针「拾起」的，也就是说当在拖动元素的时候，用户点击的那一点就是指针应该保持的位置（见图 22-4）。

图　22-4

要达到需要的效果，必须做一些额外的计算。你需要计算元素左上角和指针位置之间的差值。这个差值应该在 mousedown 事件发生的时候确定，并且一直保持，直到 mouseup 事件发生。通过将 event 的 clientX 和 clientY 属性与该元素的 offsetLeft 和 offsetTop 属性进行比较，就可以算出水平方向和垂直方向上需要多少空间，见图 22-5。

图　22-5

为了保存 x 和 y 坐标上的差值，还需要几个变量。diffX 和 diffY 这些变量需要在 onmousemove 事件处理程序中用到，来对元素进行适当的定位，如下面的例子所示。

var DragDrop = function (){ var dragging = null; diffX = 0; diffY = 0; function handleEvent (event){// 获取事件和目标 event = EventUtil.getEvent (event); var target = EventUtil.getTarget (event); // 确定事件类型 switch (event.type){case "mousedown": if (target.className.indexOf ("draggable") > -1){dragging = target; diffX = event.clientX - target.offsetLeft; diffY = event.clientY - target.offsetTop;} break; case "mousemove": if (dragging !== null){// 指定位置 dragging.style.left = (event.clientX - diffX) + "px"; dragging.style.top = (event.clientY - diffY) + "px"; } break; case "mouseup": dragging = null; break; } }; // 公共接口 return {enable: function (){EventUtil.addHandler (document, "mousedown", handleEvent); EventUtil.addHandler (document, "mousemove", handleEvent); EventUtil.addHandler (document, "mouseup", handleEvent); }, disable: function (){ EventUtil.removeHandler (document, "mousedown", handleEvent); EventUtil.removeHandler (document, "mousemove", handleEvent); EventUtil.removeHandler (document, "mouseup", handleEvent); } } }();

DragAndDropExample03.htm

diffX 和 diffY 变量是私有的，因为只有 handleEvent () 函数需要用到它们。当 mousedown 事件发生时，通过 clientX 减去目标的 offsetLeft，clientY 减去目标的 offsetTop，可以计算到这两个变量的值。当触发了 mousemove 事件后，就可以使用这些变量从指针坐标中减去，得到最终的坐标。最后得到一个更加平滑的拖动体验，更加符合用户所期望的方式。

22.5.2　添加自定义事件

拖放功能还不能真正应用起来，除非能知道什么时候拖动开始了。从这点上看，前面的代码没有提供任何方法表示拖动开始、正在拖动或者已经结束。这时，可以使用自定义事件来指示这几个事件的发生，让应用的其他部分与拖动功能进行交互。

由于 DragDrop 对象是一个使用了模块模式的单例，所以需要进行一些更改来使用 EventTarget 类型。首先，创建一个新的 EventTarget 对象，然后添加 enable () 和 disable () 方法，最后返回这个对象。看以下内容。

var DragDrop = function (){ var dragdrop = new EventTarget (), dragging = null, diffX = 0, diffY = 0; function handleEvent (event){// 获取事件和对象 event = EventUtil.getEvent (event); var target = EventUtil.getTarget (event); // 确定事件类型 switch (event.type){case "mousedown": if (target.className.indexOf ("draggable") > -1){dragging = target; diffX = event.clientX - target.offsetLeft; diffY = event.clientY - target.offsetTop; dragdrop.fire ({type:"dragstart", target: dragging, x: event.clientX, y: event.clientY}); } break; case "mousemove": if (dragging !== null){// 指定位置 dragging.style.left = (event.clientX - diffX) + "px"; dragging.style.top = (event.clientY - diffY) + "px"; // 触发自定义事件 dragdrop.fire ({type:"drag", target: dragging, x: event.clientX, y: event.clientY}); } break; case "mouseup": dragdrop.fire ({type:"dragend", target: dragging, x: event.clientX, y: event.clientY}); dragging = null; break; } }; // 公共接口 dragdrop.enable = function (){ EventUtil.addHandler (document, "mousedown", handleEvent); EventUtil.addHandler (document, "mousemove", handleEvent); EventUtil.addHandler (document, "mouseup", handleEvent); }; dragdrop.disable = function (){ EventUtil.removeHandler (document, "mousedown", handleEvent); EventUtil.removeHandler (document, "mousemove", handleEvent); EventUtil.removeHandler (document, "mouseup", handleEvent); }; return dragdrop; }();

DragAndDropExample04.htm

这段代码定义了三个事件：dragstart、drag 和 dragend。它们都将被拖动的元素设置为了 target，并给出了 x 和 y 属性来表示当前的位置。它们触发于 dragdrop 对象上，之后在返回对象前给对象增加 enable () 和 disable () 方法。这些模块模式中的细小更改令 DragDrop 对象支持了事件，如下：

DragDrop.addHandler("dragstart", function(event){ var status = document.getElementById("status"); status.innerHTML = "Started dragging " + event.target.id; }); DragDrop.addHandler("drag", function(event){ var status = document.getElementById("status"); status.innerHTML += "<br/> Dragged " + event.target.id + " to (" + event.x + "," + event.y + ")"; }); DragDrop.addHandler("dragend", function(event){ var status = document.getElementById("status"); status.innerHTML += "<br/> Dropped " + event.target.id + " at (" + event.x + "," + event.y + ")"; });

DragAndDropExample04.htm

这里，为 DragDrop 对象的每个事件添加了事件处理程序。还使用了一个元素来实现被拖动的元素当前的状态和位置。一旦元素被放下了，就可以看到从它一开始被拖动之后经过的所有的中间步骤。

为 DragDrop 添加自定义事件可以使这个对象更健壮，它将可以在网络应用中处理复杂的拖放功能。

22.6　小结

JavaScript 中的函数非常强大，因为它们是第一类对象。使用闭包和函数环境切换，还可以有很多使用函数的强大方法。可以创建作用域安全的构造函数，确保在缺少 new 操作符时调用构造函数不会改变错误的环境对象。

可以使用惰性载入函数，将任何代码分支推迟到第一次调用函数的时候。

函数绑定可以让你创建始终在指定环境中运行的函数，同时函数柯里化可以让你创建已经填了某些参数的函数。

将绑定和柯里化组合起来，就能够给你一种在任意环境中以任意参数执行任意函数的方法。

ECMAScript 5 允许通过以下几种方式来创建防篡改对象。

不可扩展的对象，不允许给对象添加新的属性或方法。

密封的对象，也是不可扩展的对象，不允许删除已有的属性和方法。

冻结的对象，也是密封的对象，不允许重写对象的成员。

JavaScript 中可以使用 setTimeout () 和 setInterval () 如下创建定时器。

定时器代码是放在一个等待区域，直到时间间隔到了之后，此时将代码添加到 JavaScript 的处理队列中，等待下一次 JavaScript 进程空闲时被执行。

每次一段代码执行结束之后，都会有一小段空闲时间进行其他浏览器处理。

这种行为意味着，可以使用定时器将长时间运行的脚本切分为一小块一小块可以在以后运行的代码段。这种做法有助于 Web 应用对用户交互有更积极的响应。

JavaScript 中经常以事件的形式应用观察者模式。虽然事件常常和 DOM 一起使用，但是你也可以通过实现自定义事件在自己的代码中应用。使用自定义事件有助于将不同部分的代码相互之间解耦，让维护更加容易，并减少引入错误的机会。

拖放对于桌面和 Web 应用都是一个非常流行的用户界面范例，它能够让用户非常方便地以一种直观的方式重新排列或者配置东西。在 JavaScrip 中可以使用鼠标事件和一些简单的计算来实现这种功能类型。将拖放行为和自定义事件结合起来可以创建一个可重复使用的框架，它能应用于各种不同的情况下。

第 23 章　离线应用与客户端存储

本章内容

进行离线检测

使用离线缓存

在浏览器中保存数据

支持离线 Web 应用开发是 HTML5 的另一个重点。所谓 ** 离线 **Web 应用，就是在设备不能上网的情况下仍然可以运行的应用。HTML5 把离线应用作为重点，主要是基于开发人员的心愿。前端开发人员一直希望 Web 应用能够与传统的客户端应用同场竞技，起码做到只要设备有电就能使用。

开发离线 Web 应用需要几个步骤。首先是确保应用知道设备是否能上网，以便下一步执行正确的操作。然后，应用还必须能访问一定的资源（图像、JavaScript、CSS 等），只有这样才能正常工作。最后，必须有一块本地空间用于保存数据，无论能否上网都不妨碍读写。HTML5 及其相关的 API 让开发离线应用成为现实。

23.1　离线检测

开发离线应用的第一步是要知道设备是在线还是离线，HTML5 为此定义了一个 navigator.onLine 属性，这个属性值为 true 表示设备能上网，值为 false 表示设备离线。这个属性的关键是浏览器必须知道设备能否访问网络，从而返回正确的值。实际应用中，navigator.onLine 在不同浏览器间还有些小的差异。

IE6 + 和 Safari 5 + 能够正确检测到网络已断开，并将 navigator.onLine 的值转换为 false。

Firefox 3 + 和 Opera 10.6 + 支持 navigator.onLine 属性，但你必须手工选中菜单项「文件 → Web 开发人员（设置）→ 脱机工作」才能让浏览器正常工作。

Chrome 11 及之前版本始终将 navigator.onLine 属性设置为 true。这是一个有待修复的 bug1。

1 这个 bug 在 2011 年 10 月已被修复（http://code.google.com/p/chromium/issues/detail?id=7469）。

由于存在上述兼容性问题，单独使用 navigator.onLine 属性不能确定网络是否连通。即便如此，在请求发生错误的情况下，检测这个属性仍然是管用的。以下是检测该属性状态的示例。

if (navigator.onLine){// 正常工作} else {// 执行离线状态时的任务}

OnLineExample01.htm

除 navigator.onLine 属性之外，为了更好地确定网络是否可用，HTML5 还定义了两个事件：online 和 offline。当网络从离线变为在线或者从在线变为离线时，分别触发这两个事件。这两个事件在 window 对象上触发。

EventUtil.addHandler(window, "online", function(){ alert("Online"); }); EventUtil.addHandler(window, "offline", function(){ alert("Offline"); });

OnlineEventsExample01.htm

为了检测应用是否离线，在页面加载后，最好先通过 navigator.onLine 取得初始的状态。然后，就是通过上述两个事件来确定网络连接状态是否变化。当上述事件触发时，navigator.onLine 属性的值也会改变，不过必须要手工轮询这个属性才能检测到网络状态的变化。

支持离线检测的浏览器有 IE 6+（只支持 navigator.onLine 属性）、Firefox 3、Safari 4、Opera 10.6、Chrome、iOS 3.2 版 Safari 和 Android 版 WebKit。

23.2　应用缓存

HTML5 的应用缓存（application cache），或者简称为 appcache，是专门为开发离线 Web 应用而设计的。Appcache 就是从浏览器的缓存中分出来的一块缓存区。要想在这个缓存中保存数据，可以使用一个描述文件（manifest file），列出要下载和缓存的资源。下面是一个简单的描述文件示例。

CACHE MANIFEST #Comment file.js file.css

在最简单的情况下，描述文件中列出的都是需要下载的资源，以备离线时使用。

设置描述文件的选项非常多，本书不打算详细解释每一个选项。要了解这些选项，推荐读者阅读 HTML5Doctor 中的文章「Go offline with application cache」，网址为 http://html5doctor.com/go-offline-with-application-cache。

要将描述文件与页面关联起来，可以在 <html> 中的 manifest 属性中指定这个文件的路径，例如：

<html manifest="/offline.manifest">

以上代码告诉页面，/offline.manifest 中包含着描述文件。这个文件的 MIME 类型必须是 text/cache-manifest1。

1 描述文件的扩展名以前推荐用 manifest，但现在推荐的是 appcache。

虽然应用缓存的意图是确保离线时资源可用，但也有相应的 JavaScript API 让你知道它都在做什么。这个 API 的核心是 applicationCache 对象，这个对象有一个 status 属性，属性的值是常量，表示应用缓存的如下当前状态。

0：无缓存，即没有与页面相关的应用缓存。

1：闲置，即应用缓存未得到更新。

2：检查中，即正在下载描述文件并检查更新。

3：下载中，即应用缓存正在下载描述文件中指定的资源。

4：更新完成，即应用缓存已经更新了资源，而且所有资源都已下载完毕，可以通过 swapCache () 来使用了。

5：废弃，即应用缓存的描述文件已经不存在了，因此页面无法再访问应用缓存。

应用缓存还有很多相关的事件，表示其状态的改变。以下是这些事件。

checking：在浏览器为应用缓存查找更新时触发。

error：在检查更新或下载资源期间发生错误时触发。

noupdate：在检查描述文件发现文件无变化时触发。

downloading：在开始下载应用缓存资源时触发。

progress：在文件下载应用缓存的过程中持续不断地触发。

updateready：在页面新的应用缓存下载完毕且可以通过 swapCache () 使用时触发。

cached：在应用缓存完整可用时触发。

一般来讲，这些事件会随着页面加载按上述顺序依次触发。不过，通过调用 update () 方法也可以手工干预，让应用缓存为检查更新而触发上述事件。

applicationCache.update();

update () 一经调用，应用缓存就会去检查描述文件是否更新（触发 checking 事件），然后就像页面刚刚加载一样，继续执行后续操作。如果触发了 cached 事件，就说明应用缓存已经准备就绪，不会再发生其他操作了。如果触发了 updateready 事件，则说明新版本的应用缓存已经可用，而此时你需要调用 swapCache () 来启用新应用缓存。

EventUtil.addHandler(applicationCache, "updateready", function(){ applicationCache.swapCache(); });

支持 HTML5 应用缓存的浏览器有 Firefox 3+、Safari 4+、Opera 10.6、Chrome、iOS 3.2 + 版 Safari 及 Android 版 WebKit。在 Firefox 4 及之前版本中调用 swapCache () 会抛出错误。

23.3　数据存储

随着 Web 应用程序的出现，也产生了对于能够直接在客户端上存储用户信息能力的要求。想法很合乎逻辑，属于某个特定用户的信息应该存在该用户的机器上。无论是登录信息、偏好设定或其他数据，Web 应用提供者发现他们在找各种方式将数据存在客户端上。这个问题的第一个方案是以 cookie 的形式出现的，cookie 是原来的网景公司创造的。一份题为「Persistent Client State: HTTP Cookes」（持久客户端状态：HTTP Cookies）的标准中对 cookie 机制进行了阐述（该标准还可以在这里看到：http://curl.haxx.se/rfc/cookie_spec.html）。今天，cookie 只是在客户端存储数据的其中一种选项。

23.3.1　Cookie

HTTP Cookie，通常直接叫做 cookie，最初是在客户端用于存储会话信息的。该标准要求服务器对任意 HTTP 请求发送 Set-Cookie HTTP 头作为响应的一部分，其中包含会话信息。例如，这种服务器响应的头可能如下：

HTTP/1.1 200 OK Content-type: text/html Set-Cookie: name=value Other-header: other-header-value

这个 HTTP 响应设置以 name 为名称、以 value 为值的一个 cookie，名称和值在传送时都必须是 URL 编码的。浏览器会存储这样的会话信息，并在这之后，通过为每个请求添加 Cookie HTTP 头将信息发送回服务器，如下所示：

GET /index.html HTTP/1.1 Cookie: name=value Other-header: other-header-value

发送回服务器的额外信息可以用于唯一验证客户来自于发送的哪个请求。

1. 限制

cookie 在性质上是绑定在特定的域名下的。当设定了一个 cookie 后，再给创建它的域名发送请求时，都会包含这个 cookie。这个限制确保了储存在 cookie 中的信息只能让批准的接受者访问，而无法被其他域访问。

由于 cookie 是存在客户端计算机上的，还加入了一些限制确保 cookie 不会被恶意使用，同时不会占据太多磁盘空间。每个域的 cookie 总数是有限的，不过浏览器之间各有不同。如下所示。

IE6 以及更低版本限制每个域名最多 20 个 cookie。

IE7 和之后版本每个域名最多 50 个。IE7 最初是支持每个域名最大 20 个 cookie，之后被微软的一个补丁所更新。

Firefox 限制每个域最多 50 个 cookie。

Opera 限制每个域最多 30 个 cookie。

Safari 和 Chrome 对于每个域的 cookie 数量限制没有硬性规定。

当超过单个域名限制之后还要再设置 cookie，浏览器就会清除以前设置的 cookie。IE 和 Opera 会删除最近最少使用过的（LRU，Least Recently Used）cookie，腾出空间给新设置的 cookie。Firefox 看上去好像是随机决定要清除哪个 cookie，所以考虑 cookie 限制非常重要，以免出现不可预期的后果。

浏览器中对于 cookie 的尺寸也有限制。大多数浏览器都有大约 4096B（加减 1）的长度限制。为了最佳的浏览器兼容性，最好将整个 cookie 长度限制在 4095B（含 4095）以内。尺寸限制影响到一个域下所有的 cookie，而并非每个 cookie 单独限制。

如果你尝试创建超过最大尺寸限制的 cookie，那么该 cookie 会被悄无声息地丢掉。注意，虽然一个字符通常占用一字节，但是多字节情况则有不同。

2. cookie 的构成

cookie 由浏览器保存的以下几块信息构成。

名称：一个唯一确定 cookie 的名称。cookie 名称是不区分大小写的，所以 myCookie 和 MyCookie 被认为是同一个 cookie。然而，实践中最好将 cookie 名称看作是区分大小写的，因为某些服务器会这样处理 cookie。cookie 的名称必须是经过 URL 编码的。

值：储存在 cookie 中的字符串值。值必须被 URL 编码。

域：cookie 对于哪个域是有效的。所有向该域发送的请求中都会包含这个 cookie 信息。这个值可以包含子域（subdomain，如 www.wrox.com），也可以不包含它（如.wrox.com，则对于 wrox.com 的所有子域都有效）。如果没有明确设定，那么这个域会被认作来自设置 cookie 的那个域。

路径：对于指定域中的那个路径，应该向服务器发送 cookie。例如，你可以指定 cookie 只有从 http://www.wrox.com/books/ 中才能访问，那么 http://www.wrox.com 的页面就不会发送 cookie 信息，即使请求都是来自同一个域的。

失效时间：表示 cookie 何时应该被删除的时间戳（也就是，何时应该停止向服务器发送这个 cookie）。默认情况下，浏览器会话结束时即将所有 cookie 删除；不过也可以自己设置删除时间。这个值是个 GMT 格式的日期（Wdy, DD-Mon-YYYY HH:MM:SS GMT），用于指定应该删除 cookie 的准确时间。因此，cookie 可在浏览器关闭后依然保存在用户的机器上。如果你设置的失效日期是个以前的时间，则 cookie 会被立刻删除。

安全标志：指定后，cookie 只有在使用 SSL 连接的时候才发送到服务器。例如，cookie 信息只能发送给 https://www.wrox.com，而 http://www.wrox.com 的请求则不能发送 cookie。

每一段信息都作为 Set-Cookie 头的一部分，使用分号加空格分隔每一段，如下例所示。

HTTP/1.1 200 OK Content-type: text/html Set-Cookie: name=value; expires=Mon, 22-Jan-07 07:10:24 GMT; domain=.wrox.com Other-header: other-header-value

该头信息指定了一个叫做 name 的 cookie，它会在格林威治时间 2007 年 1 月 22 日 7:10:24 失效，同时对于 www.wrox.com 和 wrox.com 的任何子域（如 p2p.wrox.com）都有效。

secure 标志是 cookie 中唯一一个非名值对儿的部分，直接包含一个 secure 单词。如下：

HTTP/1.1 200 OK Content-type: text/html Set-Cookie: name=value; domain=.wrox.com; path=/; secure Other-header: other-header-value

这里，创建了一个对于所有 wrox.com 的子域和域名下（由 path 参数指定的）所有页面都有效的 cookie。因为设置了 secure 标志，这个 cookie 只能通过 SSL 连接才能传输。

尤其要注意，域、路径、失效时间和 secure 标志都是服务器给浏览器的指示，以指定何时应该发送 cookie。这些参数并不会作为发送到服务器的 cookie 信息的一部分，只有名值对儿才会被发送。

3. JavaScript 中的 cookie

在 JavaScript 中处理 cookie 有些复杂，因为其众所周知的蹩脚的接口，即 BOM 的 document. cookie 属性。这个属性的独特之处在于它会因为使用它的方式不同而表现出不同的行为。当用来获取属性值时，document.cookie 返回当前页面可用的（根据 cookie 的域、路径、失效时间和安全设置）所有 cookie 的字符串，一系列由分号隔开的名值对儿，如下例所示。

name1=value1;name2=value2;name3=value3

所有名字和值都是经过 URL 编码的，所以必须使用 decodeURIComponent () 来解码。

当用于设置值的时候，document.cookie 属性可以设置为一个新的 cookie 字符串。这个 cookie 字符串会被解释并添加到现有的 cookie 集合中。设置 document.cookie 并不会覆盖 cookie，除非设置的 cookie 的名称已经存在。设置 cookie 的格式如下，和 Set-Cookie 头中使用的格式一样。

name=value; expires=expiration_time; path=domain_path; domain=domain_name; secure

这些参数中，只有 cookie 的名字和值是必需的。下面是一个简单的例子。

document.cookie = "name=Nicholas";

这段代码创建了一个叫 name 的 cookie，值为 Nicholas。当客户端每次向服务器端发送请求的时候，都会发送这个 cookie；当浏览器关闭的时候，它就会被删除。虽然这段代码没问题，但因为这里正好名称和值都无需编码，所以最好每次设置 cookie 时都像下面这个例子中一样使用 encodeURIComponent ()。

document.cookie = encodeURIComponent("name") + "=" + encodeURIComponent("Nicholas");

要给被创建的 cookie 指定额外的信息，只要将参数追加到该字符串，和 Set-Cookie 头中的格式一样，如下所示。

document.cookie = encodeURIComponent("name") + "=" + encodeURIComponent("Nicholas") + "; domain=.wrox.com; path=/";

由于 JavaScript 中读写 cookie 不是非常直观，常常需要写一些函数来简化 cookie 的功能。基本的 cookie 操作有三种：读取、写入和删除。它们在 CookieUtil 对象中如下表示。

var CookieUtil = { get: function (name){ var cookieName = encodeURIComponent(name) + "=", cookieStart = document.cookie.indexOf(cookieName), cookieValue = null; if (cookieStart > -1){ var cookieEnd = document.cookie.indexOf(";", cookieStart); if (cookieEnd == -1){ cookieEnd = document.cookie.length; } cookieValue = decodeURIComponent(document.cookie.substring(cookieStart + cookieName.length, cookieEnd)); } return cookieValue; }, set: function (name, value, expires, path, domain, secure) { var cookieText = encodeURIComponent(name) + "=" + encodeURIComponent(value); if (expires instanceof Date) { cookieText += "; expires=" + expires.toGMTString(); } if (path) { cookieText += "; path=" + path; } if (domain) { cookieText += "; domain=" + domain; } if (secure) { cookieText += "; secure"; } document.cookie = cookieText; }, unset: function (name, path, domain, secure){ this.set(name, "", new Date(0), path, domain, secure); } };

CookieUtil.js

CookieUtil.get () 方法根据 cookie 的名字获取相应的值。它会在 document.cookie 字符串中查找 cookie 名加上等于号的位置。如果找到了，那么使用 indexOf () 查找该位置之后的第一个分号（表示了该 cookie 的结束位置）。如果没有找到分号，则表示该 cookie 是字符串中的最后一个，则余下的字符串都是 cookie 的值。该值使用 decodeURIComponent () 进行解码并最后返回。如果没有发现 cookie，则返回 null。

CookieUtil.set () 方法在页面上设置一个 cookie，接收如下几个参数：cookie 的名称，cookie 的值，可选的用于指定 cookie 何时应被删除的 Date 对象，cookie 的可选的 URL 路径，可选的域，以及可选的表示是否要添加 secure 标志的布尔值。参数是按照它们的使用频率排列的，只有头两个是必需的。在这个方法中，名称和值都使用 encodeURIComponent () 进行了 URL 编码，并检查其他选项。如果 expires 参数是 Date 对象，那么会使用 Date 对象的 toGMTString () 方法正确格式化 Date 对象，并添加到 expires 选项上。方法的其他部分就是构造 cookie 字符串并将其设置到 document.cookie 中。

没有删除已有 cookie 的直接方法。所以，需要使用相同的路径、域和安全选项再次设置 cookie，并将失效时间设置为过去的时间。CookieUtil.unset () 方法可以处理这种事情。它接收 4 个参数：要删除的 cookie 的名称、可选的路径参数、可选的域参数和可选的安全参数。

这些参数加上空字符串并设置失效时间为 1970 年 1 月 1 日（初始化为 0ms 的 Date 对象的值），传给 CookieUtil.set ()。这样就能确保删除 cookie。

可以像下面这样使用上述方法。

// 设置 cookie CookieUtil.set ("name", "Nicholas"); CookieUtil.set ("book", "Professional JavaScript"); // 读取 cookie 的值 alert (CookieUtil.get ("name")); //"Nicholas" alert (CookieUtil.get ("book")); //"Professional JavaScript" // 删除 cookie CookieUtil.unset ("name"); CookieUtil.unset ("book"); // 设置 cookie，包括它的路径、域、失效日期 CookieUtil.set ("name", "Nicholas", "/books/projs/", "www.wrox.com", new Date ("January 1, 2010")); // 删除刚刚设置的 cookie CookieUtil.unset ("name", "/books/projs/", "www.wrox.com"); // 设置安全的 cookie CookieUtil.set ("name", "Nicholas", null, null, null, true);

CookieExample01.htm

这些方法通过处理解析、构造 cookie 字符串的任务令在客户端利用 cookie 存储数据更加简单。

4. 子 cookie

为了绕开浏览器的单域名下的 cookie 数限制，一些开发人员使用了一种称为子 cookie（subcookie）的概念。子 cookie 是存放在单个 cookie 中的更小段的数据。也就是使用 cookie 值来存储多个名称值对儿。子 cookie 最常见的的格式如下所示。

name=name1=value1&name2=value2&name3=value3&name4=value4&name5=value5

子 cookie 一般也以查询字符串的格式进行格式化。然后这些值可以使用单个 cookie 进行存储和访问，而非对每个名称？值对儿使用不同的 cookie 存储。最后网站或者 Web 应用程序可以无需达到单域名 cookie 上限也可以存储更加结构化的数据。

为了更好地操作子 cookie，必须建立一系列新方法。子 cookie 的解析和序列化会因子 cookie 的期望用途而略有不同并更加复杂些。例如，要获得一个子 cookie，首先要遵循与获得 cookie 一样的基本步骤，但是在解码 cookie 值之前，需要按如下方法找出子 cookie 的信息。

var SubCookieUtil = {get: function (name, subName){var subCookies = this.getAll (name); if (subCookies){return subCookies [subName]; } else {return null;} }, getAll: function (name){var cookieName = encodeURIComponent (name) + "=", cookieStart = document.cookie.indexOf (cookieName), cookieValue = null, cookieEnd, subCookies, i, parts, result = {}; if (cookieStart> -1){cookieEnd = document.cookie.indexOf (";", cookieStart); if (cookieEnd == -1){cookieEnd = document.cookie.length;} cookieValue = document.cookie.substring (cookieStart + cookieName.length, cookieEnd); if (cookieValue.length> 0){subCookies = cookieValue.split ("&"); for (i=0, len=subCookies.length; i < len; i++){parts = subCookies [i].split ("="); result [decodeURIComponent (parts [0])] = decodeURIComponent (parts [1]); } return result; } } return null; }, // 省略了更多代码 };

SubCookieUtil.js

获取子 cookie 的方法有两个：get () 和 getAll ()。其中 get () 获取单个子 cookie 的值，getAll () 获取所有子 cookie 并将它们放入一个对象中返回，对象的属性为子 cookie 的名称，对应值为子 cookie 对应的值。get () 方法接收两个参数：cookie 的名字和子 cookie 的名字。它其实就是调用 getAll () 获取所有的子 cookie，然后只返回所需的那一个（如果 cookie 不存在则返回 null）。

SubCookieUtil.getAll () 方法和 CookieUtil.get () 在解析 cookie 值的方式上非常相似。区别在于 cookie 的值并非立即解码，而是先根据 & 字符将子 cookie 分割出来放在一个数组中，每一个子 cookie 再根据等于号分割，这样在 parts 数组中的前一部分便是子 cookie 名，后一部分则是子 cookie 的值。这两个项目都要使用 decodeURIComponent () 来解码，然后放入 result 对象中，最后作为方法的返回值。如果 cookie 不存在，则返回 null。

可以像下面这样使用上述方法：

// 假设 document.cookie=data=name=Nicholas&book=Professional%20JavaScript // 取得全部子 cookie var data = SubCookieUtil.getAll ("data"); alert (data.name); //"Nicholas" alert (data.book); //"Professional JavaScript" // 逐个获取子 cookie alert (SubCookieUtil.get ("data", "name")); //"Nicholas" alert (SubCookieUtil.get ("data", "book")); //"Professional JavaScript"

SubCookiesExample01.htm

要设置子 cookie，也有两种方法：set () 和 setAll ()。以下代码展示了它们的构造。

var SubCookieUtil = {set: function (name, subName, value, expires, path, domain, secure) {var subcookies = this.getAll (name) || {}; subcookies [subName] = value; this.setAll (name, subcookies, expires, path, domain, secure); }, setAll: function (name, subcookies, expires, path, domain, secure){var cookieText = encodeURIComponent (name) + "=", subcookieParts = new Array (), subName; for (subName in subcookies){if (subName.length> 0 && subcookies.hasOwnProperty (subName)){subcookieParts.push (encodeURIComponent (subName) + "=" + encodeURIComponent (subcookies [subName])); } } if (cookieParts.length> 0){cookieText += subcookieParts.join ("&"); if (expires instanceof Date) {cookieText += "; expires=" + expires.toGMTString (); } if (path) {cookieText += "; path=" + path;} if (domain) {cookieText += "; domain=" + domain;} if (secure) {cookieText += "; secure";} } else {cookieText += "; expires=" + (new Date (0)).toGMTString ();} document.cookie = cookieText; }, // 省略了更多代码 };

SubCookieUtil.js

这里的 set () 方法接收 7 个参数：cookie 名称、子 cookie 名称、子 cookie 值、可选的 cookie 失效日期或时间的 Date 对象、可选的 cookie 路径、可选的 cookie 域和可选的布尔 secure 标志。所有的可选参数都是作用于 cookie 本身而非子 cookie。为了在同一个 cookie 中存储多个子 cookie，路径、域和 secure 标志必须一致；针对整个 cookie 的失效日期则可以在任何一个单独的子 cookie 写入的时候同时设置。在这个方法中，第一步是获取指定 cookie 名称对应的所有子 cookie。逻辑或操作符「||」用于当 getAll () 返回 null 时将 subcookies 设置为一个新对象。然后，在 subcookies 对象上设置好子 cookie 值并传给 setAll ()。

而 setAll () 方法接收 6 个参数：cookie 名称、包含所有子 cookie 的对象以及和 set () 中一样的 4 个可选参数。这个方法使用 for-in 循环遍历第二个参数中的属性。为了确保确实是要保存的数据，使用了 hasOwnProperty () 方法，来确保只有实例属性被序列化到子 cookie 中。由于可能会存在属性名为空字符串的情况，所以在把属性名加入结果对象之前还要检查一下属性名的长度。将每个子 cookie 的名值对儿都存入 subcookieParts 数组中，以便稍后可以使用 join () 方法以 & 号组合起来。剩下的方法则和 CookieUtil.set () 一样。

可以按如下方式使用这些方法。

// 假设 document.cookie=data=name=Nicholas&book=Professional%20JavaScript // 设置两个 cookie SubCookieUtil.set ("data", "name", "Nicholas"); SubCookieUtil.set ("data", "book", "Professional JavaScript"); // 设置全部子 cookie 和失效日期 SubCookieUtil.setAll ("data", { name: "Nicholas", book: "Professional JavaScript"}, new Date ("January 1, 2010")); // 修改名字的值，并修改 cookie 的失效日期 SubCookieUtil.set ("data", "name", "Michael", new Date ("February 1, 2010"));

SubCookiesExample01.htm

子 cookie 的最后一组方法是用于删除子 cookie 的。普通 cookie 可以通过将失效时间设置为过去的时间的方法来删除，但是子 cookie 不能这样做。为了删除一个子 cookie，首先必须获取包含在某个 cookie 中的所有子 cookie，然后仅删除需要删除的那个子 cookie，然后再将余下的子 cookie 的值保存为 cookie 的值。请看以下代码。

var SubCookieUtil = {// 这里省略了更多代码 unset: function (name, subName, path, domain, secure){var subcookies = this.getAll (name); if (subcookies){delete subcookies [subName]; this.setAll (name, subcookies, null, path, domain, secure); } }, unsetAll: function (name, path, domain, secure){this.setAll (name, null, new Date (0), path, domain, secure); } };

SubCookieUtil.js

这里定义的两个方法用于两种不同的目的。unset () 方法用于删除某个 cookie 中的单个子 cookie 而不影响其他的；而 unsetAll () 方法则等同于 CookieUtil.unset ()，用于删除整个 cookie。和 set () 及 setAll () 一样，路径、域和 secure 标志必须和之前创建的 cookie 包含的内容一致。这两个方法可以像下面这样使用。

// 仅删除名为 name 的子 cookie SubCookieUtil.unset ("data", "name"); // 删除整个 cookie SubCookieUtil.unsetAll ("data");

如果你担心开发中可能会达到单域名的 cookie 上限，那么子 cookie 可是一个非常有吸引力的备选方案。不过，你需要更加密切关注 cookie 的长度，以防超过单个 cookie 的长度限制。

5. 关于 cookie 的思考

还有一类 cookie 被称为「HTTP 专有 cookie」。HTTP 专有 cookie 可以从浏览器或者服务器设置，但是只能从服务器端读取，因为 JavaScript 无法获取 HTTP 专有 cookie 的值。

由于所有的 cookie 都会由浏览器作为请求头发送，所以在 cookie 中存储大量信息会影响到特定域的请求性能。cookie 信息越大，完成对服务器请求的时间也就越长。尽管浏览器对 cookie 进行了大小限制，不过最好还是尽可能在 cookie 中少存储信息，以避免影响性能。

cookie 的性质和它的局限使得其并不能作为存储大量信息的理想手段，所以又出现了其他方法。

一定不要在 cookie 中存储重要和敏感的数据。cookie 数据并非存储在一个安全环境中，其中包含的任何数据都可以被他人访问。所以不要在 cookie 中存储诸如信用卡号或者个人地址之类的数据。

23.3.2　IE 用户数据

在 IE5.0 中，微软通过一个自定义行为引入了持久化用户数据的概念。用户数据允许每个文档最多 128KB 数据，每个域名最多 1MB 数据。要使用持久化用户数据，首先必须如下所示，使用 CSS 在某个元素上指定 userData 行为：

<div style="behavior:url(#default#userData)" id="dataStore"></div>

一旦该元素使用了 userData 行为，那么就可以使用 setAttribute () 方法在上面保存数据了。为了将数据提交到浏览器缓存中，还必须调用 save () 方法并告诉它要保存到的数据空间的名字。数据空间名字可以完全任意，仅用于区分不同的数据集。请看以下例子。

var dataStore = document.getElementById("dataStore"); dataStore.setAttribute("name", "Nicholas"); dataStore.setAttribute("book", "Professional JavaScript"); dataStore.save("BookInfo");

UserDataExample01.htm

在这段代码中，<div> 元素上存入了两部分信息。在用 setAttribute () 存储了数据之后，调用了 save () 方法，指定了数据空间的名称为 BookInfo。下一次页面载入之后，可以使用 load () 方法指定同样的数据空间名称来获取数据，如下所示。

dataStore.load("BookInfo"); alert(dataStore.getAttribute("name")); //"Nicholas" alert(dataStore.getAttribute("book")); //"Professional JavaScript"

UserDataExample01.htm

对 load () 的调用获取了 BookInfo 数据空间中的所有信息，并且使数据可以通过元素访问；只有到载入确切完成之后数据方能使用。如果 getAttribute () 调用了不存在的名称或者是尚未载入的名程，则返回 null。

你可以通过 removeAttribute () 方法明确指定要删除某元素数据，只要指定属性名称。删除之后，必须像下面这样再次调用 save () 来提交更改。

dataStore.removeAttribute("name"); dataStore.removeAttribute("book"); dataStore.save("BookInfo");

UserDataExample01.htm

这段代码删除了两个数据属性，然后将更改保存到缓存中。

对 IE 用户数据的访问限制和对 cookie 的限制类似。要访问某个数据空间，脚本运行的页面必须来自同一个域名，在同一个路径下，并使用与进行存储的脚本同样的协议。和 cookie 不同的是，你无法将用户数据访问限制扩展到更多的客户。还有一点不同，用户数据默认是可以跨越会话持久存在的，同时也不会过期；数据需要通过 removeAttribute () 方法专门进行删除以释放空间。

和 cookie 一样，IE 用户数据并非安全的，所以不能存放敏感信息。

23.3.3　Web 存储机制

Web Storage 最早是在 Web 超文本应用技术工作组（WHAT-WG）的 Web 应用 1.0 规范中描述的。这个规范的最初的工作最终成为了 HTML5 的一部分。Web Storage 的目的是克服由 cookie 带来的一些限制，当数据需要被严格控制在客户端上时，无须持续地将数据发回服务器。Web Storage 的两个主要目标是：

提供一种在 cookie 之外存储会话数据的途径；

提供一种存储大量可以跨会话存在的数据的机制。

最初的 Web Storage 规范包含了两种对象的定义：sessionStorage 和 globalStorage。这两个对象在支持的浏览器中都是以 windows 对象属性的形式存在的，支持这两个属性的浏览器包括 IE8+、Firefox 3.5+、Chrome 4 + 和 Opera 10.5+。

Firefox 2 和 3 基于早期规范的内容部分实现了 Web Storage，当时只实现了 globalStorage，没有实现 localStorage。

1. Storage 类型

Storage 类型提供最大的存储空间（因浏览器而异）来存储名值对儿。Storage 的实例与其他对象类似，有如下方法。

clear ()： 删除所有值；Firefox 中没有实现 。

getItem (name)：根据指定的名字 name 获取对应的值。

key (index)：获得 index 位置处的值的名字。

removeItem (name)：删除由 name 指定的名值对儿。

setItem (name, value)：为指定的 name 设置一个对应的值。

其中，getItem ()、removeItem () 和 setItem () 方法可以直接调用，也可通过 Storage 对象间接调用。因为每个项目都是作为属性存储在该对象上的，所以可以通过点语法或者方括号语法访问属性来读取值，设置也一样，或者通过 delete 操作符进行删除。不过，我们还建议读者使用方法而不是属性来访问数据，以免某个键会意外重写该对象上已经存在的成员。

还可以使用 length 属性来判断有多少名值对儿存放在 Storage 对象中。但无法判断对象中所有数据的大小，不过 IE8 提供了一个 remainingSpace 属性，用于获取还可以使用的存储空间的字节数。

Storage 类型只能存储字符串。非字符串的数据在存储之前会被转换成字符串。

2. sessionStorage 对象

sessionStorage 对象存储特定于某个会话的数据，也就是该数据只保持到浏览器关闭。这个对象就像会话 cookie，也会在浏览器关闭后消失。存储在 sessionStorage 中的数据可以跨越页面刷新而存在，同时如果浏览器支持，浏览器崩溃并重启之后依然可用（Firefox 和 WebKit 都支持，IE 则不行）。

因为 seesionStorage 对象绑定于某个服务器会话，所以当文件在本地运行的时候是不可用的。存储在 sessionStorage 中的数据只能由最初给对象存储数据的页面访问到，所以对多页面应用有限制。

由于 sessionStorage 对象其实是 Storage 的一个实例，所以可以使用 setItem () 或者直接设置新的属性来存储数据。下面是这两种方法的例子。

// 使用方法存储数据 sessionStorage.setItem ("name", "Nicholas"); // 使用属性存储数据 sessionStorage.book = "Professional JavaScript";

SessionStorageExample01.htm

不同浏览器写入数据方面略有不同。Firefox 和 WebKit 实现了同步写入，所以添加到存储空间中的数据是立刻被提交的。而 IE 的实现则是异步写入数据，所以在设置数据和将数据实际写入磁盘之间可能有一些延迟。对于少量数据而言，这个差异是可以忽略的。对于大量数据，你会发现 IE 要比其他浏览器更快地恢复执行，因为它会跳过实际的磁盘写入过程。

在 IE8 中可以强制把数据写入磁盘：在设置新数据之前使用 begin () 方法，并且在所有设置完成之后调用 commit () 方法。看以下例子。

// 只适用于 IE8 sessionStorage.begin (); sessionStorage.name = "Nicholas"; sessionStorage.book = "Professional JavaScript"; sessionStorage.commit ();

这段代码确保了 name 和 book 的值在调用 commit () 之后立刻被写入磁盘。调用 begin () 是为了确保在这段代码执行的时候不会发生其他磁盘写入操作。对于少量数据而言，这个过程不是必需的；不过，对于大量数据（如文档之类的）可能就要考虑这种事务形式的方法了。

sessionStorage 中有数据时，可以使用 getItem () 或者通过直接访问属性名来获取数据。两种方法的例子如下。

// 使用方法读取数据 var name = sessionStorage.getItem ("name"); // 使用属性读取数据 var book = sessionStorage.book;

SessionStorageExample01.htm

还可以通过结合 length 属性和 key () 方法来迭代 sessionStorage 中的值，如下所示。

for (var i=0, len = sessionStorage.length; i < len; i++){ var key = sessionStorage.key(i); var value = sessionStorage.getItem(key); alert(key + "=" + value); }

SessionStorageExample01.htm

它是这样遍历 sessionStorage 中的名值对儿的：首先通过 key () 方法获取指定位置上的名字，然后再通过 getItem () 找出对应该名字的值。

还可以使用 for-in 循环来迭代 sessionStorage 中的值：

for (var key in sessionStorage){ var value = sessionStorage.getItem(key); alert(key + "=" + value); }

每次经过循环的时候，key 被设置为 sessionStorage 中下一个名字，此时不会返回任何内置方法或 length 属性。

要从 sessionStorage 中删除数据，可以使用 delete 操作符删除对象属性，也可调用 removeItem () 方法。以下是这些方法的例子。

// 使用 delete 删除一个值 —— 在 WebKit 中无效 delete sessionStorage.name; // 使用方法删除一个值 sessionStorage.removeItem ("book");

SessionStorageExample01.htm

在撰写本书时，delete 操作符在 WebKit 中无法删除数据，removeItem () 则可以在各种支持的浏览器中正确运行。

sessionStorage 对象应该主要用于仅针对会话的小段数据的存储。如果需要跨越会话存储数据，那么 globalStorage 或者 localStorage 更为合适。

3. globalStorage 对象

Firefox 2 中实现了 globalStorage 对象。作为最初的 Web Storage 规范的一部分，这个对象的目的是跨越会话存储数据，但有特定的访问限制。要使用 globalStorage，首先要指定哪些域可以访问该数据。可以通过方括号标记使用属性来实现，如以下例子所示。

// 保存数据 globalStorage ["wrox.com"].name = "Nicholas"; // 获取数据 var name = globalStorage ["wrox.com"].name;

GlobalStorageExample01.htm

在这里，访问的是针对域名 wrox.com 的存储空间。globalStorage 对象不是 Storage 的实例，而具体的 globalStorage ["wrox.com"] 才是。这个存储空间对于 wrox.com 及其所有子域都是可以访问的。可以像下面这样指定子域名。

// 保存数据 globalStorage ["www.wrox.com"].name = "Nicholas"; // 获取数据 var name = globalStorage ["www.wrox.com"].name;

GlobalStorageExample01.htm

这里所指定的存储空间只能由来自 www.wrox.com 的页面访问，其他子域名都不行。

某些浏览器允许更加宽泛的访问限制，比如只根据顶级域名进行限制或者允许全局访问，如下面例子所示。

// 存储数据，任何人都可以访问 —— 不要这样做！ globalStorage [""].name ="Nicholas"; // 存储数据，可以让任何以.net 结尾的域名访问 —— 不要这样做！ globalStorage ["net"].name ="Nicholas";

虽然这些也支持，但是还是要避免使用这种可宽泛访问的数据存储，以防止出现潜在的安全问题。考虑到安全问题，这些功能在未来可能会被删除或者是被更严格地限制，所以不应依赖于这类功能。当使用 globalStorage 的时候一定要指定一个域名。

对 globalStorage 空间的访问，是依据发起请求的页面的域名、协议和端口来限制的。例如，如果使用 HTTPS 协议在 wrox.com 中存储了数据，那么通过 HTTP 访问的 wrox.com 的页面就不能访问该数据。同样，通过 80 端口访问的页面则无法与同一个域同样协议但通过 8080 端口访问的页面共享数据。这类似于 Ajax 请求的同源策略。

globalStorage 的每个属性都是 Storage 的实例。因此，可以像如下代码中这样使用。

globalStorage["www.wrox.com"].name = "Nicholas"; globalStorage["www.wrox.com"].book = "Professional JavaScript"; globalStorage["www.wrox.com"].removeItem("name"); var book = globalStorage["www.wrox.com"].getItem("book");

GlobalStorageExample01.htm

如果你事先不能确定域名，那么使用 location.host 作为属性名比较安全。例如：

globalStorage[location.host].name = "Nicholas"; var book = globalStorage[location.host].getItem("book");

GlobalStorageExample01.htm

如果不使用 removeItem () 或者 delete 删除，或者用户未清除浏览器缓存，存储在 globalStorage 属性中的数据会一直保留在磁盘上。这让 globalStorage 非常适合在客户端存储文档或者长期保存用户偏好设置。

4. localStorage 对象

localStorage 对象在修订过的 HTML 5 规范中作为持久保存客户端数据的方案取代了 globalStorage。与 globalStorage 不同，不能给 localStorage 指定任何访问规则；规则事先就设定好了。要访问同一个 localStorage 对象，页面必须来自同一个域名（子域名无效），使用同一种协议，在同一个端口上。这相当于 globalStorage [location.host]。

由于 localStorage 是 Storage 的实例，所以可以像使用 sessionStorage 一样来使用它。下面是一些例子。

// 使用方法存储数据 localStorage.setItem ("name", "Nicholas"); // 使用属性存储数据 localStorage.book = "Professional JavaScript"; // 使用方法读取数据 var name = localStorage.getItem ("name"); // 使用属性读取数据 var book = localStorage.book;

LocalStorageExample01.htm

存储在 localStorage 中的数据和存储在 globalStorage 中的数据一样，都遵循相同的规则：数据保留到通过 JavaScript 删除或者是用户清除浏览器缓存。

为了兼容只支持 globalStorage 的浏览器，可以使用以下函数。

function getLocalStorage(){ if (typeof localStorage == "object"){ return localStorage; } else if (typeof globalStorage == "object"){ return globalStorage[location.host]; } else { throw new Error("Local storage not available."); } }

GlobalAndLocalStorageExample01.htm

然后，像下面这样调用一次这个函数，就可以正常地读写数据了。

var storage = getLocalStorage();

GlobalAndLocalStorageExample01.htm

在确定了使用哪个 Storage 对象之后，就能在所有支持 Web Storage 的浏览器中使用相同的存取规则操作数据了。

5. storage 事件

对 Storage 对象进行任何修改，都会在文档上触发 storage 事件。当通过属性或 setItem () 方法保存数据，使用 delete 操作符或 removeItem () 删除数据，或者调用 clear () 方法时，都会发生该事件。这个事件的 event 对象有以下属性。

domain：发生变化的存储空间的域名。

key：设置或者删除的键名。

newValue：如果是设置值，则是新值；如果是删除键，则是 null。

oldValue：键被更改之前的值。

在这四个属性中，IE8 和 Firefox 只实现了 domain 属性。在撰写本书的时候，WebKit 尚不支持 storage 事件：

以下代码展示了如何侦听 storage 事件：

EventUtil.addHandler(document, "storage", function(event){ alert("Storage changed for " + event.domain); });

StorageEventExample01.htm

