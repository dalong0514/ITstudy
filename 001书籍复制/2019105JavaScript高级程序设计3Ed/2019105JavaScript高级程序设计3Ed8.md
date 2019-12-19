RecursionExample02.htm

加粗的代码显示，通过使用 arguments.callee 代替函数名，可以确保无论怎样调用函数都不会出问题。因此，在编写递归函数时，使用 arguments.callee 总比使用函数名更保险。

但在严格模式下，不能通过脚本访问 arguments.callee，访问这个属性会导致错误。不过，可以使用命名函数表达式来达成相同的结果。例如：

var factorial = (function f(num){ if (num <= 1){ return 1; } else { return num * f(num-1); } });

以上代码创建了一个名为 f () 的命名函数表达式，然后将它赋值给变量 factorial。即便把函数赋值给了另一个变量，函数的名字 f 仍然有效，所以递归调用照样能正确完成。这种方式在严格模式和非严格模式下都行得通。

7.2　闭包

有不少开发人员总是搞不清匿名函数和闭包这两个概念，因此经常混用。闭包是指有权访问另一个函数作用域中的变量的函数。创建闭包的常见方式，就是在一个函数内部创建另一个函数，仍以前面的 createComparisonFunction () 函数为例，注意加粗的代码。

function createComparisonFunction(propertyName) { return function(object1, object2){ var value1 = object1[propertyName]; var value2 = object2[propertyName]; if (value1 < value2){ return -1; } else if (value1 > value2){ return 1; } else { return 0; } }; }

在这个例子中，突出的那两行代码是内部函数（一个匿名函数）中的代码，这两行代码访问了外部函数中的变量 propertyName。即使这个内部函数被返回了，而且是在其他地方被调用了，但它仍然可以访问变量 propertyName。之所以还能够访问这个变量，是因为内部函数的作用域链中包含 createComparisonFunction () 的作用域。要彻底搞清楚其中的细节，必须从理解函数第一次被调用的时候都会发生什么入手。

第 4 章介绍了作用域链的概念。而有关如何创建作用域链以及作用域链有什么作用的细节，对彻底理解闭包至关重要。当某个函数第一次被调用时，会创建一个执行环境（execution context）及相应的作用域链，并把作用域链赋值给一个特殊的内部属性（即 [[Scope]]）。然后，使用 this、arguments 和其他命名参数的值来初始化函数的活动对象（activation object）。但在作用域链中，外部函数的活动对象始终处于第二位，外部函数的外部函数的活动对象处于第三位，…… 直至作为作用域链终点的全局执行环境。

在函数执行过程中，为读取和写入变量的值，就需要在作用域链中查找变量。来看下面的例子。

function compare(value1, value2){ if (value1 < value2){ return -1; } else if (value1 > value2){ return 1; } else { return 0; } } var result = compare(5, 10);

以上代码先定义了 compare () 函数，然后又在全局作用域中调用了它。当第一次调用 compare () 时，会创建一个包含 this、arguments、value1 和 value2 的活动对象。全局执行环境的变量对象（包含 this、result 和 compare）在 compare () 执行环境的作用域链中则处于第二位。图 7-1 展示了包含上述关系的 compare () 函数执行时的作用域链。

图　7-1

后台的每个执行环境都有一个表示变量的对象 —— 变量对象。全局环境的变量对象始终存在，而像 compare () 函数这样的局部环境的变量对象，则只在函数执行的过程中存在。在创建 compare () 函数时，会创建一个预先包含全局变量对象的作用域链，这个作用域链被保存在内部的 [[Scope]] 属性中。当调用 compare () 函数时，会为函数创建一个执行环境，然后通过复制函数的 [[Scope]] 属性中的对象构建起执行环境的作用域链。此后，又有一个活动对象（在此作为变量对象使用）被创建并被推入执行环境作用域链的前端。对于这个例子中 compare () 函数的执行环境而言，其作用域链中包含两个变量对象：本地活动对象和全局变量对象。显然，作用域链本质上是一个指向变量对象的指针列表，它只引用但不实际包含变量对象。

无论什么时候在函数中访问一个变量时，就会从作用域链中搜索具有相应名字的变量。一般来讲，当函数执行完毕后，局部活动对象就会被销毁，内存中仅保存全局作用域（全局执行环境的变量对象）。但是，闭包的情况又有所不同。

在另一个函数内部定义的函数会将包含函数（即外部函数）的活动对象添加到它的作用域链中。因此，在 createComparisonFunction () 函数内部定义的匿名函数的作用域链中，实际上将会包含外部函数 createComparisonFunction () 的活动对象。图 7-2 展示了当下列代码执行时，包含函数与内部匿名函数的作用域链。

var compare = createComparisonFunction("name"); var result = compare({ name: "Nicholas" }, { name: "Greg" });

在匿名函数从 createComparisonFunction () 中被返回后，它的作用域链被初始化为包含 createComparisonFunction () 函数的活动对象和全局变量对象。这样，匿名函数就可以访问在 createComparisonFunction () 中定义的所有变量。更为重要的是，createComparisonFunction () 函数在执行完毕后，其活动对象也不会被销毁，因为匿名函数的作用域链仍然在引用这个活动对象。换句话说，当 createComparisonFunction () 函数返回后，其执行环境的作用域链会被销毁，但它的活动对象仍然会留在内存中；直到匿名函数被销毁后，createComparisonFunction () 的活动对象才会被销毁，例如：

// 创建函数 var compareNames = createComparisonFunction ("name"); // 调用函数 var result = compareNames ({name: "Nicholas"}, {name: "Greg"}); // 解除对匿名函数的引用（以便释放内存） compareNames = null;

首先，创建的比较函数被保存在变量 compareNames 中。而通过将 compareNames 设置为等于 null 解除该函数的引用，就等于通知垃圾回收例程将其清除。随着匿名函数的作用域链被销毁，其他作用域（除了全局作用域）也都可以安全地销毁了。图 7-2 展示了调用 compareNames () 的过程中产生的作用域链之间的关系。

图　7-2

由于闭包会携带包含它的函数的作用域，因此会比其他函数占用更多的内存。过度使用闭包可能会导致内存占用过多，我们建议读者只在绝对必要时再考虑使用闭包。虽然像 V8 等优化后的 JavaScript 引擎会尝试回收被闭包占用的内存，但请大家还是要慎重使用闭包。

7.2.1　闭包与变量

作用域链的这种配置机制引出了一个值得注意的副作用，即闭包只能取得包含函数中任何变量的最后一个值。别忘了闭包所保存的是整个变量对象，而不是某个特殊的变量。下面这个例子可以清晰地说明这个问题。

function createFunctions(){ var result = new Array(); for (var i=0; i < 10; i++){ result[i] = function(){ return i; }; } return result; }

ClosureExample01.htm

这个函数会返回一个函数数组。表面上看，似乎每个函数都应该返自己的索引值，即位置 0 的函数返回 0，位置 1 的函数返回 1，以此类推。但实际上，每个函数都返回 10。因为每个函数的作用域链中都保存着 createFunctions () 函数的活动对象，所以它们引用的都是同一个变量 i。当 createFunctions () 函数返回后，变量 i 的值是 10，此时每个函数都引用着保存变量 i 的同一个变量对象，所以在每个函数内部 i 的值都是 10。但是，我们可以通过创建另一个匿名函数强制让闭包的行为符合预期，如下所示。

function createFunctions(){ var result = new Array(); for (var i=0; i < 10; i++){ result[i] = function(num){ return function(){ return num; }; }(i); } return result; }

ClosureExample02.htm

在重写了前面的 createFunctions () 函数后，每个函数就会返回各自不同的索引值了。在这个版本中，我们没有直接把闭包赋值给数组，而是定义了一个匿名函数，并将立即执行该匿名函数的结果赋给数组。这里的匿名函数有一个参数 num，也就是最终的函数要返回的值。在调用每个匿名函数时，我们传入了变量 i。由于函数参数是按值传递的，所以就会将变量 i 的当前值复制给参数 num。而在这个匿名函数内部，又创建并返回了一个访问 num 的闭包。这样一来，result 数组中的每个函数都有自己 num 变量的一个副本，因此就可以返回各自不同的数值了。

7.2.2　关于 this 对象

在闭包中使用 this 对象也可能会导致一些问题。我们知道，this 对象是在运行时基于函数的执行环境绑定的：在全局函数中，this 等于 window，而当函数被作为某个对象的方法调用时，this 等于那个对象。不过，匿名函数的执行环境具有全局性，因此其 this 对象通常指向 window1。但有时候由于编写闭包的方式不同，这一点可能不会那么明显。下面来看一个例子。

1 当然，在通过 call () 或 apply () 改变函数执行环境的情况下，this 就会指向其他对象。

var name = "The Window"; var object = {name : "My Object", getNameFunc : function (){return function (){return this.name;}; } }; alert (object.getNameFunc ()()); //"The Window"（在非严格模式下）

ThisObjectExample01.htm

以上代码先创建了一个全局变量 name，又创建了一个包含 name 属性的对象。这个对象还包含一个方法 ——getNameFunc ()，它返回一个匿名函数，而匿名函数又返回 this.name。由于 getNameFunc () 返回一个函数，因此调用 object.getNameFunc ()() 就会立即调用它返回的函数，结果就是返回一个字符串。然而，这个例子返回的字符串是 "The Window"，即全局 name 变量的值。为什么匿名函数没有取得其包含作用域（或外部作用域）的 this 对象呢？

前面曾经提到过，每个函数在被调用时，其活动对象都会自动取得两个特殊变量：this 和 arguments。内部函数在搜索这两个变量时，只会搜索到其活动对象为止，因此永远不可能直接访问外部函数中的这两个变量（这一点通过图 7-2 可以看得更清楚）。不过，把外部作用域中的 this 对象保存在一个闭包能够访问到的变量里，就可以让闭包访问该对象了，如下所示。

var name = "The Window"; var object = { name : "My Object", getNameFunc : function(){ var that = this; return function(){ return that.name; }; } }; alert(object.getNameFunc()()); //"My Object"

ThisObjectExample02.htm

代码中突出的行展示了这个例子与前一个例子之间的不同之处。在定义匿名函数之前，我们把 this 对象赋值给了一个名叫 that 的变量。而在定义了闭包之后，闭包也可以访问这个变量，因为它是我们在包含函数中特意声名的一个变量。即使在函数返回之后，that 也仍然引用着 object，所以调用 object.getNameFunc ()() 就返回了 "My Object"。

this 和 arguments 也存在同样的问题。如果想访问作用域中的 arguments 对象，必须将对该对象的引用保存到另一个闭包能够访问的变量中。

在几种特殊情况下，this 的值可能会意外地改变。比如，下面的代码是修改前面例子的结果。

var name = "The Window"; var object = { name : "My Object", getName: function(){ return this.name; } };

这里的 getName () 方法只简单地返回 this.name 的值。以下是几种调用 object.getName () 的方式以及各自的结果。

object.getName (); //"My Object" (object.getName)(); //"My Object" (object.getName = object.getName)(); //"The Window"，在非严格模式下

ThisObjectExample03.htm

第一行代码跟平常一样调用了 object.getName ()，返回的是 "My Object"，因为 this.name 就是 object.name。第二行代码在调用这个方法前先给它加上了括号。虽然加上括号之后，就好像只是在引用一个函数，但 this 的值得到了维持，因为 object.getName 和 (object.getName) 的定义是相同的。第三行代码先执行了一条赋值语句，然后再调用赋值后的结果。因为这个赋值表达式的值是函数本身，所以 this 的值不能得到维持，结果就返回了 "The Window"。

当然，你不大可能会像第二行和第三行代码一样调用这个方法。不过，这个例子有助于说明即使是语法的细微变化，都有可能意外改变 this 的值。

7.2.3　内存泄漏

由于 IE9 之前的版本对 JScript 对象和 COM 对象使用不同的垃圾收集例程（第 4 章曾经讨论过），因此闭包在 IE 的这些版本中会导致一些特殊的问题。具体来说，如果闭包的作用域链中保存着一个 HTML 元素，那么就意味着该元素将无法被销毁。来看下面的例子。

function assignHandler(){ var element = document.getElementById("someElement"); element.onclick = function(){ alert(element.id); }; }

以上代码创建了一个作为 element 元素事件处理程序的闭包，而这个闭包则又创建了一个循环引用（事件将在第 13 章讨论）。由于匿名函数保存了一个对 assignHandler () 的活动对象的引用，因此就会导致无法减少 element 的引用数。只要匿名函数存在，element 的引用数至少也是 1，因此它所占用的内存就永远不会被回收。不过，这个问题可以通过稍微改写一下代码来解决，如下所示。

function assignHandler(){ var element = document.getElementById("someElement"); var id = element.id; element.onclick = function(){ alert(id); }; element = null; }

在上面的代码中，通过把 element.id 的一个副本保存在一个变量中，并且在闭包中引用该变量消除了循环引用。但仅仅做到这一步，还是不能解决内存泄漏的问题。必须要记住：闭包会引用包含函数的整个活动对象，而其中包含着 element。即使闭包不直接引用 element，包含函数的活动对象中也仍然会保存一个引用。因此，有必要把 element 变量设置为 null。这样就能够解除对 DOM 对象的引用，顺利地减少其引用数，确保正常回收其占用的内存。

7.3　模仿块级作用域

如前所述，JavaScript 没有块级作用域的概念。这意味着在块语句中定义的变量，实际上是在包含函数中而非语句中创建的，来看下面的例子。

function outputNumbers (count){for (var i=0; i < count; i++){alert (i); } alert (i); // 计数 }

BlockScopeExample01.htm

这个函数中定义了一个 for 循环，而变量 i 的初始值被设置为 0。在 Java、C++ 等语言中，变量 i 只会在 for 循环的语句块中有定义，循环一旦结束，变量 i 就会被销毁。可是在 JavaScrip 中，变量 i 是定义在 ouputNumbers () 的活动对象中的，因此从它有定义开始，就可以在函数内部随处访问它。即使像下面这样错误地重新声明同一个变量，也不会改变它的值。

function outputNumbers (count){for (var i=0; i < count; i++){alert (i); } var i; // 重新声明变量 alert (i); // 计数 }

BlockScopeExample02.htm

JavaScript 从来不会告诉你是否多次声明了同一个变量；遇到这种情况，它只会对后续的声明视而不见（不过，它会执行后续声明中的变量初始化）。匿名函数可以用来模仿块级作用域并避免这个问题。

用作块级作用域（通常称为私有作用域）的匿名函数的语法如下所示。

(function (){// 这里是块级作用域})();

以上代码定义并立即调用了一个匿名函数。将函数声明包含在一对圆括号中，表示它实际上是一个函数表达式。而紧随其后的另一对圆括号会立即调用这个函数。如果有读者感觉这种语法不太好理解，可以再看看下面这个例子。

var count = 5; outputNumbers(count);

这里初始化了变量 count，将其值设置为 5。当然，这里的变量是没有必要的，因为可以把值直接传给函数。为了让代码更简洁，我们在调用函数时用 5 来代替变量 count，如下所示。

outputNumbers(5);

这样做之所以可行，是因为变量只不过是值的另一种表现形式，因此用实际的值替换变量没有问题。再看下面的例子。

var someFunction = function (){ // 这里是块级作用域}; someFunction ();

这个例子先定义了一个函数，然后立即调用了它。定义函数的方式是创建一个匿名函数，并把匿名函数赋值给变量 someFunction。而调用函数的方式是在函数名称后面添加一对圆括号，即 someFunction ()。通过前面的例子我们知道，可以使用实际的值来取代变量 count，那在这里是不是也可以用函数的值直接取代函数名呢？ 然而，下面的代码却会导致错误。

function (){ // 这里是块级作用域}(); // 出错！

这段代码会导致语法错误，是因为 JavaScript 将 function 关键字当作一个函数声明的开始，而函数声明后面不能跟圆括号。然而，函数表达式的后面可以跟圆括号。要将函数声明转换成函数表达式，只要像下面这样给它加上一对圆括号即可。

(function (){// 这里是块级作用域})();

无论在什么地方，只要临时需要一些变量，就可以使用私有作用域，例如：

function outputNumbers (count){(function () {for (var i=0; i < count; i++){alert (i); } })(); alert (i); // 导致一个错误！ }

BlockScopeExample03.htm

在这个重写后的 outputNumbers () 函数中，我们在 for 循环外部插入了一个私有作用域。在匿名函数中定义的任何变量，都会在执行结束时被销毁。因此，变量 i 只能在循环中使用，使用后即被销毁。而在私有作用域中能够访问变量 count，是因为这个匿名函数是一个闭包，它能够访问包含作用域中的所有变量。

这种技术经常在全局作用域中被用在函数外部，从而限制向全局作用域中添加过多的变量和函数。一般来说，我们都应该尽量少向全局作用域中添加变量和函数。在一个由很多开发人员共同参与的大型应用程序中，过多的全局变量和函数很容易导致命名冲突。而通过创建私有作用域，每个开发人员既可以使用自己的变量，又不必担心搞乱全局作用域。例如：

(function(){ var now = new Date(); if (now.getMonth() == 0 && now.getDate() == 1){ alert("Happy new year!"); } })();

把上面这段代码放在全局作用域中，可以用来确定哪一天是 1 月 1 日；如果到了这一天，就会向用户显示一条祝贺新年的消息。其中的变量 now 现在是匿名函数中的局部变量，而我们不必在全局作用域中创建它。

这种做法可以减少闭包占用的内存问题，因为没有指向匿名函数的引用。只要函数执行完毕，就可以立即销毁其作用域链了。

7.4　私有变量

严格来讲，JavaScript 中没有私有成员的概念；所有对象属性都是公有的。不过，倒是有一个私有变量的概念。任何在函数中定义的变量，都可以认为是私有变量，因为不能在函数的外部访问这些变量。私有变量包括函数的参数、局部变量和在函数内部定义的其他函数。来看下面的例子：

function add(num1, num2){ var sum = num1 + num2; return sum; }

在这个函数内部，有 3 个私有变量：num1、num2 和 sum。在函数内部可以访问这几个变量，但在函数外部则不能访问它们。如果在这个函数内部创建一个闭包，那么闭包通过自己的作用域链也可以访问这些变量。而利用这一点，就可以创建用于访问私有变量的公有方法。

我们把有权访问私有变量和私有函数的公有方法称为特权方法（privileged method）。有两种在对象上创建特权方法的方式。第一种是在构造函数中定义特权方法，基本模式如下。

function MyObject (){ // 私有变量和私有函数 var privateVariable = 10; function privateFunction (){return false;} // 特权方法 this.publicMethod = function (){ privateVariable++; return privateFunction (); }; }

这个模式在构造函数内部定义了所有私有变量和函数。然后，又继续创建了能够访问这些私有成员的特权方法。能够在构造函数中定义特权方法，是因为特权方法作为闭包有权访问在构造函数中定义的所有变量和函数。对这个例子而言，变量 privateVariable 和函数 privateFunction () 只能通过特权方法 publicMethod () 来访问。在创建 MyObject 的实例后，除了使用 publicMethod () 这一个途径外，没有任何办法可以直接访问 privateVariable 和 privateFunction ()。

利用私有和特权成员，可以隐藏那些不应该被直接修改的数据，例如：

function Person(name){ this.getName = function(){ return name; }; this.setName = function (value) { name = value; }; } var person = new Person("Nicholas"); alert(person.getName()); //"Nicholas" person.setName("Greg"); alert(person.getName()); //"Greg"

PrivilegedMethodExample01.htm

以上代码的构造函数中定义了两个特权方法：getName () 和 setName ()。这两个方法都可以在构造函数外部使用，而且都有权访问私有变量 name。但在 Person 构造函数外部，没有任何办法访问 name。由于这两个方法是在构造函数内部定义的，它们作为闭包能够通过作用域链访问 name。私有变量 name 在 Person 的每一个实例中都不相同，因为每次调用构造函数都会重新创建这两个方法。不过，在构造函数中定义特权方法也有一个缺点，那就是你必须使用构造函数模式来达到这个目的。第 6 章曾经讨论过，构造函数模式的缺点是针对每个实例都会创建同样一组新方法，而使用静态私有变量来实现特权方法就可以避免这个问题。

7.4.1　静态私有变量

通过在私有作用域中定义私有变量或函数，同样也可以创建特权方法，其基本模式如下所示。

(function (){// 私有变量和私有函数 var privateVariable = 10; function privateFunction (){return false;} // 构造函数 MyObject = function (){}; // 公有 / 特权方法 MyObject.prototype.publicMethod = function (){ privateVariable++; return privateFunction (); }; })();

这个模式创建了一个私有作用域，并在其中封装了一个构造函数及相应的方法。在私有作用域中，首先定义了私有变量和私有函数，然后又定义了构造函数及其公有方法。公有方法是在原型上定义的，这一点体现了典型的原型模式。需要注意的是，这个模式在定义构造函数时并没有使用函数声明，而是使用了函数表达式。函数声明只能创建局部函数，但那并不是我们想要的。出于同样的原因，我们也没有在声明 MyObject 时使用 var 关键字。记住：初始化未经声明的变量，总是会创建一个全局变量。因此，MyObject 就成了一个全局变量，能够在私有作用域之外被访问到。但也要知道，在严格模式下给未经声明的变量赋值会导致错误。

这个模式与在构造函数中定义特权方法的主要区别，就在于私有变量和函数是由实例共享的。由于特权方法是在原型上定义的，因此所有实例都使用同一个函数。而这个特权方法，作为一个闭包，总是保存着对包含作用域的引用。来看一看下面的代码。

(function(){ var name = ""; Person = function(value){ name = value; }; Person.prototype.getName = function(){ return name; }; Person.prototype.setName = function (value){ name = value; }; })(); var person1 = new Person("Nicholas"); alert(person1.getName()); //"Nicholas" person1.setName("Greg"); alert(person1.getName()); //"Greg" var person2 = new Person("Michael"); alert(person1.getName()); //"Michael" alert(person2.getName()); //"Michael"

PrivilegedMethodExample02.htm

这个例子中的 Person 构造函数与 getName () 和 setName () 方法一样，都有权访问私有变量 name。在这种模式下，变量 name 就变成了一个静态的、由所有实例共享的属性。也就是说，在一个实例上调用 setName () 会影响所有实例。而调用 setName () 或新建一个 Person 实例都会赋予 name 属性一个新值。结果就是所有实例都会返回相同的值。

以这种方式创建静态私有变量会因为使用原型而增进代码复用，但每个实例都没有自己的私有变量。到底是使用实例变量，还是静态私有变量，最终还是要视你的具体需求而定。

多查找作用域链中的一个层次，就会在一定程度上影响查找速度。而这正是使用闭包和私有变量的一个显明的不足之处。

7.4.2　模块模式

前面的模式是用于为自定义类型创建私有变量和特权方法的。而道格拉斯所说的模块模式（module pattern）则是为单例创建私有变量和特权方法。所谓单例（singleton），指的就是只有一个实例的对象。按照惯例，JavaScript 是以对象字面量的方式来创建单例对象的。

var singleton = {name : value, method : function () {// 这里是方法的代码} };

模块模式通过为单例添加私有变量和特权方法能够使其得到增强，其语法形式如下：

var singleton = function (){ // 私有变量和私有函数 var privateVariable = 10; function privateFunction (){return false;} // 特权 / 公有方法和属性 return {publicProperty: true, publicMethod : function (){privateVariable++; return privateFunction (); } }; }();

这个模块模式使用了一个返回对象的匿名函数。在这个匿名函数内部，首先定义了私有变量和函数。然后，将一个对象字面量作为函数的值返回。返回的对象字面量中只包含可以公开的属性和方法。由于这个对象是在匿名函数内部定义的，因此它的公有方法有权访问私有变量和函数。从本质上来讲，这个对象字面量定义的是单例的公共接口。这种模式在需要对单例进行某些初始化，同时又需要维护其私有变量时是非常有用的，例如：

var application = function (){ // 私有变量和函数 var components = new Array (); // 初始化 components.push (new BaseComponent ()); // 公共 return {getComponentCount : function (){return components.length;}, registerComponent : function (component){if (typeof component == "object"){components.push (component); } } }; }();

ModulePatternExample01.htm

在 Web 应用程序中，经常需要使用一个单例来管理应用程序级的信息。这个简单的例子创建了一个用于管理组件的 application 对象。在创建这个对象的过程中，首先声明了一个私有的 components 数组，并向数组中添加了一个 BaseComponent 的新实例（在这里不需要关心 BaseComponent 的代码，我们只是用它来展示初始化操作）。而返回对象的 getComponentCount () 和 registerComponent () 方法，都是有权访问数组 components 的特权方法。前者只是返回已注册的组件数目，后者用于注册新组件。

简言之，如果必须创建一个对象并以某些数据对其进行初始化，同时还要公开一些能够访问这些私有数据的方法，那么就可以使用模块模式。以这种模式创建的每个单例都是 Object 的实例，因为最终要通过一个对象字面量来表示它。事实上，这也没有什么；毕竟，单例通常都是作为全局对象存在的，我们不会将它传递给一个函数。因此，也就没有什么必要使用 instanceof 操作符来检查其对象类型了。

7.4.3　增强的模块模式

有人进一步改进了模块模式，即在返回对象之前加入对其增强的代码。这种增强的模块模式适合那些单例必须是某种类型的实例，同时还必须添加某些属性和（或）方法对其加以增强的情况。来看下面的例子。

var singleton = function (){ // 私有变量和私有函数 var privateVariable = 10; function privateFunction (){return false;} // 创建对象 var object = new CustomType (); // 添加特权 / 公有属性和方法 object.publicProperty = true; object.publicMethod = function (){privateVariable++; return privateFunction (); }; // 返回这个对象 return object; }();

如果前面演示模块模式的例子中的 application 对象必须是 BaseComponent 的实例，那么就可以使用以下代码。

var application = function (){ // 私有变量和函数 var components = new Array (); // 初始化 components.push (new BaseComponent ()); // 创建 application 的一个局部副本 var app = new BaseComponent (); // 公共接口 app.getComponentCount = function (){return components.length;}; app.registerComponent = function (component){if (typeof component == "object"){components.push (component); } }; // 返回这个副本 return app; }();

ModuleAugmentationPatternExample01.htm

在这个重写后的应用程序（application）单例中，首先也是像前面例子中一样定义了私有变量。主要的不同之处在于命名变量 app 的创建过程，因为它必须是 BaseComponent 的实例。这个实例实际上是 application 对象的局部变量版。此后，我们又为 app 对象添加了能够访问私有变量的公有方法。最后一步是返回 app 对象，结果仍然是将它赋值给全局变量 application。

7.5　小结

在 JavaScript 编程中，函数表达式是一种非常有用的技术。使用函数表达式可以无须对函数命名，从而实现动态编程。匿名函数，也称为拉姆达函数，是一种使用 JavaScript 函数的强大方式。以下总结了函数表达式的特点。

函数表达式不同于函数声明。函数声明要求有名字，但函数表达式不需要。没有名字的函数表达式也叫做匿名函数。

在无法确定如何引用函数的情况下，递归函数就会变得比较复杂；

递归函数应该始终使用 arguments.callee 来递归地调用自身，不要使用函数名 —— 函数名可能会发生变化。

当在函数内部定义了其他函数时，就创建了闭包。闭包有权访问包含函数内部的所有变量，原理如下。

在后台执行环境中，闭包的作用域链包含着它自己的作用域、包含函数的作用域和全局作用域。

通常，函数的作用域及其所有变量都会在函数执行结束后被销毁。

但是，当函数返回了一个闭包时，这个函数的作用域将会一直在内存中保存到闭包不存在为止。

使用闭包可以在 JavaScript 中模仿块级作用域（JavaScript 本身没有块级作用域的概念），要点如下。

创建并立即调用一个函数，这样既可以执行其中的代码，又不会在内存中留下对该函数的引用。

结果就是函数内部的所有变量都会被立即销毁 —— 除非将某些变量赋值给了包含作用域（即外部作用域）中的变量。

闭包还可以用于在对象中创建私有变量，相关概念和要点如下。

即使 JavaScript 中没有正式的私有对象属性的概念，但可以使用闭包来实现公有方法，而通过公有方法可以访问在包含作用域中定义的变量。

有权访问私有变量的公有方法叫做特权方法。

可以使用构造函数模式、原型模式来实现自定义类型的特权方法，也可以使用模块模式、增强的模块模式来实现单例的特权方法。

JavaScript 中的函数表达式和闭包都是极其有用的特性，利用它们可以实现很多功能。不过，因为创建闭包必须维护额外的作用域，所以过度使用它们可能会占用大量内存。

第 8 章　BOM

本章内容

理解 window 对象 ——BOM 的核心

控制窗口、框架和弹出窗口

利用 location 对象中的页面信息

使用 navigator 对象了解浏览器

ECMAScript 是 JavaScript 的核心，但如果要在 Web 中使用 JavaScript，那么 BOM（浏览器对象模型）则无疑才是真正的核心。BOM 提供了很多对象，用于访问浏览器的功能，这些功能与任何网页内容无关。多年来，缺少事实上的规范导致 BOM 既有意思又有问题，因为浏览器提供商会按照各自的想法随意去扩展它。于是，浏览器之间共有的对象就成为了事实上的标准。这些对象在浏览器中得以存在，很大程度上是由于它们提供了与浏览器的互操作性。W3C 为了把浏览器中 JavaScript 最基本的部分标准化，已经将 BOM 的主要方面纳入了 HTML5 的规范中。

8.1　window 对象

BOM 的核心对象是 window，它表示浏览器的一个实例。在浏览器中，window 对象有双重角色，它既是通过 JavaScript 访问浏览器窗口的一个接口，又是 ECMAScript 规定的 Global 对象。这意味着在网页中定义的任何一个对象、变量和函数，都以 window 作为其 Global 对象，因此有权访问 parseInt () 等方法。

8.1.1　全局作用域

由于 window 对象同时扮演着 ECMAScript 中 Global 对象的角色，因此所有在全局作用域中声明的变量、函数都会变成 window 对象的属性和方法。来看下面的例子。

var age = 29; function sayAge(){ alert(this.age); } alert(window.age); //29 sayAge(); //29 window.sayAge(); //29

我们在全局作用域中定义了一个变量 age 和一个函数 sayAge ()，它们被自动归在了 window 对象名下。于是，可以通过 window.age 访问变量 age，可以通过 window.sayAge () 访问函数 sayAge ()。由于 sayAge () 存在于全局作用域中，因此 this.age 被映射到 window.age，最终显示的仍然是正确的结果。

抛开全局变量会成为 window 对象的属性不谈，定义全局变量与在 window 对象上直接定义属性还是有一点差别：全局变量不能通过 delete 操作符删除，而直接在 window 对象上的定义的属性可以。例如：

var age = 29; window.color = "red"; // 在 IE <9 时抛出错误，在其他所有浏览器中都返回 false delete window.age; // 在 IE < 9 时抛出错误，在其他所有浏览器中都返回 true delete window.color; //returns true alert (window.age); //29 alert (window.color); //undefined

DeleteOperatorExample01.htm

刚才使用 var 语句添加的 window 属性有一个名为 [[Configurable]] 的特性，这个特性的值被设置为 false，因此这样定义的属性不可以通过 delete 操作符删除。IE8 及更早版本在遇到使用 delete 删除 window 属性的语句时，不管该属性最初是如何创建的，都会抛出错误，以示警告。IE9 及更高版本不会抛出错误。

另外，还要记住一件事：尝试访问未声明的变量会抛出错误，但是通过查询 window 对象，可以知道某个可能未声明的变量是否存在。例如：

// 这里会抛出错误，因为 oldValue 未定义 var newValue = oldValue; // 这里不会抛出错误，因为这是一次属性查询 //newValue 的值是 undefined var newValue = window.oldValue;

本章后面将要讨论的很多全局 JavaScript 对象（如 location 和 navigator）实际上都是 window 对象的属性。

Windows Mobile 平台的 IE 浏览器不允许通过 window.property = value 之类的形式，直接在 window 对象上创建新的属性或方法。可是，在全局作用域中声明的所有变量和函数，照样会变成 window 对象的成员。

8.1.2　窗口关系及框架

如果页面中包含框架，则每个框架都拥有自己的 window 对象，并且保存在 frames 集合中。在 frames 集合中，可以通过数值索引（从 0 开始，从左至右，从上到下）或者框架名称来访问相应的 window 对象。每个 window 对象都有一个 name 属性，其中包含框架的名称。下面是一个包含框架的页面：

<html> <head> <title>Frameset Example</title> </head> <frameset rows="160,*"> <frame src="frame.htm" name="topFrame"> <frameset cols="50%,50%"> <frame src="anotherframe.htm" name="leftFrame"> <frame src="yetanotherframe.htm" name="rightFrame"> </frameset> </frameset> </html>

FramesetExample01.htm

以上代码创建了一个框架集，其中一个框架居上，两个框架居下。对这个例子而言，可以通过 window.frames [0] 或者 window.frames ["topFrame"] 来引用上方的框架。不过，恐怕你最好使用 top 而非 window 来引用这些框架（例如，通过 top.frames [0]）。

我们知道，top 对象始终指向最高（最外）层的框架，也就是浏览器窗口。使用它可以确保在一个框架中正确地访问另一个框架。因为对于在一个框架中编写的任何代码来说，其中的 window 对象指向的都是那个框架的特定实例，而非最高层的框架。图 8-1 展示了在最高层窗口中，通过代码来访问前面例子中每个框架的不同方式。

图　8-1

与 top 相对的另一个 window 对象是 parent。顾名思义，parent（父）对象始终指向当前框架的直接上层框架。在某些情况下，parent 有可能等于 top；但在没有框架的情况下，parent 一定等于 top（此时它们都等于 window）。再看下面的例子。

<html> <head> <title>Frameset Example</title> </head> <frameset rows="100,*"> <frame src="frame.htm" name="topFrame"> <frameset cols="50%,50%"> <frame src="anotherframe.htm" name="leftFrame"> <frame src="anotherframeset.htm" name="rightFrame"> </frameset> </frameset> </html>

frameset1.htm

这个框架集中的一个框架包含了另一个框架集，该框架集的代码如下所示。

<html> <head> <title>Frameset Example</title> </head> <frameset cols="50%,50%"> <frame src="red.htm" name="redFrame"> <frame src="blue.htm" name="blueFrame"> </frameset> </html>

anotherframeset.htm

浏览器在加载完第一个框架集以后，会继续将第二个框架集加载到 rightFrame 中。如果代码位于 redFrame（或 blueFrame）中，那么 parent 对象指向的就是 rightFrame。可是，如果代码位于 topFrame 中，则 parent 指向的是 top，因为 topFrame 的直接上层框架就是最外层框架。图 8-2 展示了在将前面例子加载到浏览器之后，不同 window 对象的值。

图　8-2

注意，除非最高层窗口是通过 window.open () 打开的（本章后面将会讨论），否则其 window 对象的 name 属性不会包含任何值。

与框架有关的最后一个对象是 self，它始终指向 window；实际上，self 和 window 对象可以互换使用。引入 self 对象的目的只是为了与 top 和 parent 对象对应起来，因此它不格外包含其他值。

所有这些对象都是 window 对象的属性，可以通过 window.parent、window.top 等形式来访问。同时，这也意味着可以将不同层次的 window 对象连缀起来，例如 window.parent.parent.frames [0]。

在使用框架的情况下，浏览器中会存在多个 Global 对象。在每个框架中定义的全局变量会自动成为框架中 window 对象的属性。由于每个 window 对象都包含原生类型的构造函数，因此每个框架都有一套自己的构造函数，这些构造函数一一对应，但并不相等。例如，top.Object 并不等于 top.frames [0].Object。这个问题会影响到对跨框架传递的对象使用 instanceof 操作符。

8.1.3　窗口位置

用来确定和修改 window 对象位置的属性和方法有很多。IE、Safari、Opera 和 Chrome 都提供了 screenLeft 和 screenTop 属性，分别用于表示窗口相对于屏幕左边和上边的位置。Firefox 则在 screenX 和 screenY 属性中提供相同的窗口位置信息，Safari 和 Chrome 也同时支持这两个属性。Opera 虽然也支持 screenX 和 screenY 属性，但与 screenLeft 和 screenTop 属性并不对应，因此建议大家不要在 Opera 中使用它们。使用下列代码可以跨浏览器取得窗口左边和上边的位置。

var leftPos = (typeof window.screenLeft == "number") ? window.screenLeft : window.screenX; var topPos = (typeof window.screenTop == "number") ? window.screenTop : window.screenY;

WindowPositionExample01.htm

这个例子运用二元操作符首先确定 screenLeft 和 screenTop 属性是否存在，如果是（在 IE、Safari、Opera 和 Chrome 中），则取得这两个属性的值。如果不存在（在 Firefox 中），则取得 screenX 和 screenY 的值。

在使用这些值的过程中，还必须注意一些小问题。在 IE、Opera 和 Chrome 中，screenLeft 和 screenTop 中保存的是从屏幕左边和上边到由 window 对象表示的页面可见区域的距离。换句话说，如果 window 对象是最外层对象，而且浏览器窗口紧贴屏幕最上端 —— 即 y 轴坐标为 0，那么 screenTop 的值就是位于页面可见区域上方的浏览器工具栏的像素高度。但是，在 Firefox 和 Safari 中，screenY 或 screenTop 中保存的是整个浏览器窗口相对于屏幕的坐标值，即在窗口的 y 轴坐标为 0 时返回 0。

更让人捉摸不透是，Firefox、Safari 和 Chrome 始终返回页面中每个框架的 top.screenX 和 top.screenY 值。即使在页面由于被设置了外边距而发生偏移的情况下，相对于 window 对象使用 screenX 和 screenY 每次也都会返回相同的值。而 IE 和 Opera 则会给出框架相对于屏幕边界的精确坐标值。

最终结果，就是无法在跨浏览器的条件下取得窗口左边和上边的精确坐标值。然而，使用 moveTo () 和 moveBy () 方法倒是有可能将窗口精确地移动到一个新位置。这两个方法都接收两个参数，其中 moveTo () 接收的是新位置的 x 和 y 坐标值，而 moveBy () 接收的是在水平和垂直方向上移动的像素数。下面来看几个例子：

// 将窗口移动到屏幕左上角 window.moveTo (0,0); // 将窗向下移动 100 像素 window.moveBy (0,100); // 将窗口移动到 (200,300) window.moveTo (200,300); // 将窗口向左移动 50 像素 window.moveBy (-50,0);

需要注意的是，这两个方法可能会被浏览器禁用；而且，在 Opera 和 IE 7（及更高版本）中默认就是禁用的。另外，这两个方法都不适用于框架，只能对最外层的 window 对象使用。

8.1.4　窗口大小

跨浏览器确定一个窗口的大小不是一件简单的事。IE9+、Firefox、Safari、Opera 和 Chrome 均为此提供了 4 个属性：innerWidth、innerHeight、outerWidth 和 outerHeight。在 IE9+、Safari 和 Firefox 中，outerWidth 和 outerHeight 返回浏览器窗口本身的尺寸（无论是从最外层的 window 对象还是从某个框架访问）。在 Opera 中，这两个属性的值表示页面视图容器 1 的大小。而 innerWidth 和 innerHeight 则表示该容器中页面视图区的大小（减去边框宽度）。在 Chrome 中，outerWidth、outerHeight 与 innerWidth、innerHeight 返回相同的值，即视口（viewport）大小而非浏览器窗口大小。

1 这里所谓的「页面视图容器」指的是 Opera 中单个标签页对应的浏览器窗口。

IE8 及更早版本没有提供取得当前浏览器窗口尺寸的属性；不过，它通过 DOM 提供了页面可见区域的相关信息。

在 IE、Firefox、Safari、Opera 和 Chrome 中，document.documentElement.clientWidth 和 document.documentElement.clientHeight 中保存了页面视口的信息。在 IE6 中，这些属性必须在标准模式下才有效；如果是混杂模式，就必须通过 document.body.clientWidth 和 document.body. clientHeight 取得相同信息。而对于混杂模式下的 Chrome，则无论通过 document.documentElement 还是 document.body 中的 clientWidth 和 clientHeight 属性，都可以取得视口的大小。

虽然最终无法确定浏览器窗口本身的大小，但却可以取得页面视口的大小，如下所示。

var pageWidth = window.innerWidth, pageHeight = window.innerHeight; if (typeof pageWidth != "number"){ if (document.compatMode == "CSS1Compat"){ pageWidth = document.documentElement.clientWidth; pageHeight = document.documentElement.clientHeight; } else { pageWidth = document.body.clientWidth; pageHeight = document.body.clientHeight; } }

WindowSizeExample01.htm

在以上代码中，我们首先将 window.innerWidth 和 window.innerHeight 的值分别赋给了 pageWidth 和 pageHeight。然后检查 pageWidth 中保存的是不是一个数值；如果不是，则通过检查 document.compatMode（这个属性将在第 10 章全面讨论）来确定页面是否处于标准模式。如果是，则分别使用 document.documentElement.clientWidth 和 document.documentElement.clientHeight 的值。否则，就使用 document.body.clientWidth 和 document.body.clientHeight 的值。

对于移动设备，window.innerWidth 和 window.innerHeight 保存着可见视口，也就是屏幕上可见页面区域的大小。移动 IE 浏览器不支持这些属性，但通过 document.documentElement.clientWidth 和 document.documentElement.clientHeihgt 提供了相同的信息。随着页面的缩放，这些值也会相应变化。

在其他移动浏览器中，document.documentElement 度量的是布局视口，即渲染后页面的实际大小（与可见视口不同，可见视口只是整个页面中的一小部分）。移动 IE 浏览器把布局视口的信息保存在 document.body.clientWidth 和 document.body.clientHeight 中。这些值不会随着页面缩放变化。

由于与桌面浏览器间存在这些差异，最好是先检测一下用户是否在使用移动设备，然后再决定使用哪个属性。

有关移动设备视口的话题比较复杂，有很多非常规的情形，也有各种各样的建议。移动开发咨询师 Peter-Paul Koch 记述了他对这个问题的研究：http://t.cn/zOZs0Tz。如果你在做移动 Web 开发，推荐你读一读这篇文章。

另外，使用 resizeTo () 和 resizeBy () 方法可以调整浏览器窗口的大小。这两个方法都接收两个参数，其中 resizeTo () 接收浏览器窗口的新宽度和新高度，而 resizeBy () 接收新窗口与原窗口的宽度和高度之差。来看下面的例子。

// 调整到 100×100 window.resizeTo (100, 100); // 调整到 200×150 window.resizeBy (100, 50); // 调整到 300×300 window.resizeTo (300, 300);

需要注意的是，这两个方法与移动窗口位置的方法类似，也有可能被浏览器禁用；而且，在 Opera 和 IE7（及更高版本）中默认就是禁用的。另外，这两个方法同样不适用于框架，而只能对最外层的 window 对象使用。

8.1.5　导航和打开窗口

使用 window.open () 方法既可以导航到一个特定的 URL，也可以打开一个新的浏览器窗口。这个方法可以接收 4 个参数：要加载的 URL、窗口目标、一个特性字符串以及一个表示新页面是否取代浏览器历史记录中当前加载页面的布尔值。通常只须传递第一个参数，最后一个参数只在不打开新窗口的情况下使用。

如果为 window.open () 传递了第二个参数，而且该参数是已有窗口或框架的名称，那么就会在具有该名称的窗口或框架中加载第一个参数指定的 URL。看下面的例子。

// 等同于 <a href="http://www.wrox.com" target="topFrame"></a> window.open ("http://www.wrox.com/", topFrame");

调用这行代码，就如同用户单击了 href 属性为 http://www.wrox.com/，target 属性为 "topFrame" 的链接。如果有一个名叫 "topFrame" 的窗口或者框架，就会在该窗口或框架加载这个 URL；否则，就会创建一个新窗口并将其命名为 "topFrame"。此外，第二个参数也可以是下列任何一个特殊的窗口名称：_self、_parent、_top 或_blank。

1. 弹出窗口

如果给 window.open () 传递的第二个参数并不是一个已经存在的窗口或框架，那么该方法就会根据在第三个参数位置上传入的字符串创建一个新窗口或新标签页。如果没有传入第三个参数，那么就会打开一个带有全部默认设置（工具栏、地址栏和状态栏等）的新浏览器窗口（或者打开一个新标签页 —— 根据浏览器设置）。在不打开新窗口的情况下，会忽略第三个参数。

第三个参数是一个逗号分隔的设置字符串，表示在新窗口中都显示哪些特性。下表列出了可以出现在这个字符串中的设置选项。

设　　置 值 说　　明

fullscreen yes 或 no 表示浏览器窗口是否最大化。仅限 IE

height 数值 表示新窗口的高度。不能小于 100

left 数值 表示新窗口的左坐标。不能是负值

location yes 或 no 表示是否在浏览器窗口中显示地址栏。不同浏览器的默认值不同。如果设置为 no，地址栏可能会隐藏，也可能会被禁用（取决于浏览器）

menubar yes 或 no 表示是否在浏览器窗口中显示菜单栏。默认值为 no

resizable yes 或 no 表示是否可以通过拖动浏览器窗口的边框改变其大小。默认值为 no

scrollbars yes 或 no 表示如果内容在视口中显示不下，是否允许滚动。默认值为 no

status yes 或 no 表示是否在浏览器窗口中显示状态栏。默认值为 no

toolbar yes 或 no 表示是否在浏览器窗口中显示工具栏。默认值为 no

top 数值 表示新窗口的上坐标。不能是负值

width 数值 表示新窗口的宽度。不能小于 100

表中所列的部分或全部设置选项，都可以通过逗号分隔的名值对列表来指定。其中，名值对以等号表示（注意，整个特性字符串中不允许出现空格），如下面的例子所示。

window.open("http://www.wrox.com/","wroxWindow", "height=400,width=400,top=10,left=10,resizable=yes");

这行代码会打开一个新的可以调整大小的窗口，窗口初始大小为 400×400 像素，并且距屏幕上沿和左边各 10 像素。

window.open () 方法会返回一个指向新窗口的引用。引用的对象与其他 window 对象大致相似，但我们可以对其进行更多控制。例如，有些浏览器在默认情况下可能不允许我们针对主浏览器窗口调整大小或移动位置，但却允许我们针对通过 window.open () 创建的窗口调整大小或移动位置。通过这个返回的对象，可以像操作其他窗口一样操作新打开的窗口，如下所示。

var wroxWin = window.open ("http://www.wrox.com/","wroxWindow", "height=400,width=400,top=10,left=10,resizable=yes"); // 调整大小 wroxWin.resizeTo (500,500); // 移动位置 wroxWin.moveTo (100,100);

调用 close () 方法还可以关闭新打开的窗口。

wroxWin.close();

但是，这个方法仅适用于通过 window.open () 打开的弹出窗口。对于浏览器的主窗口，如果没有得到用户的允许是不能关闭它的。不过，弹出窗口倒是可以调用 top.close () 在不经用户允许的情况下关闭自己。弹出窗口关闭之后，窗口的引用仍然还在，但除了像下面这样检测其 closed 属性之外，已经没有其他用处了。

wroxWin.close(); alert(wroxWin.closed); //true

新创建的 window 对象有一个 opener 属性，其中保存着打开它的原始窗口对象。这个属性只在弹出窗口中的最外层 window 对象（top）中有定义，而且指向调用 window.open () 的窗口或框架。例如：

var wroxWin = window.open("http://www.wrox.com/","wroxWindow", "height=400,width=400,top=10,left=10,resizable=yes"); alert(wroxWin.opener == window); //true

虽然弹出窗口中有一个指针指向打开它的原始窗口，但原始窗口中并没有这样的指针指向弹出窗口。窗口并不跟踪记录它们打开的弹出窗口，因此我们只能在必要的时候自己来手动实现跟踪。

有些浏览器（如 IE8 和 Chrome）会在独立的进程中运行每个标签页。当一个标签页打开另一个标签页时，如果两个 window 对象之间需要彼此通信，那么新标签页就不能运行在独立的进程中。在 Chrome 中，将新创建的标签页的 opener 属性设置为 null，即表示在单独的进程中运行新标签页，如下所示。

var wroxWin = window.open("http://www.wrox.com/","wroxWindow", "height=400,width=400,top=10,left=10,resizable=yes"); wroxWin.opener = null;

将 opener 属性设置为 null 就是告诉浏览器新创建的标签页不需要与打开它的标签页通信，因此可以在独立的进程中运行。标签页之间的联系一旦切断，将没有办法恢复。

2. 安全限制

曾经有一段时间，广告商在网上使用弹出窗口达到了肆无忌惮的程度。他们经常把弹出窗口打扮成系统对话框的模样，引诱用户去点击其中的广告。由于看起来像是系统对话框，一般用户很难分辨是真是假。为了解决这个问题，有些浏览器开始在弹出窗口配置方面增加限制。

Windows XP SP2 中的 IE6 对弹出窗口施加了多方面的安全限制，包括不允许在屏幕之外创建弹出窗口、不允许将弹出窗口移动到屏幕以外、不允许关闭状态栏等。IE7 则增加了更多的安全限制，如不允许关闭地址栏、默认情况下不允许移动弹出窗口或调整其大小。Firefox 1 从一开始就不支持修改状态栏，因此无论给 window.open () 传入什么样的特性字符串，弹出窗口中都会无一例外地显示状态栏。后来的 Firefox 3 又强制始终在弹出窗口中显示地址栏。Opera 只会在主浏览器窗口中打开弹出窗口，但不允许它们出现在可能与系统对话框混淆的地方。

此外，有的浏览器只根据用户操作来创建弹出窗口。这样一来，在页面尚未加载完成时调用 window.open () 的语句根本不会执行，而且还可能会将错误消息显示给用户。换句话说，只能通过单击或者击键来打开弹出窗口。

对于那些不是用户有意打开的弹出窗口，Chrome 采取了不同的处理方式。它不会像其他浏览器那样简单地屏蔽这些弹出窗口，而是只显示它们的标题栏，并把它们放在浏览器窗口的右下角。

在打开计算机硬盘中的网页时，IE 会解除对弹出窗口的某些限制。但是在服务器上执行这些代码会受到对弹出窗口的限制。

3. 弹出窗口屏蔽程序

大多数浏览器都内置有弹出窗口屏蔽程序，而没有内置此类程序的浏览器，也可以安装 Yahoo! Toolbar 等带有内置屏蔽程序的实用工具。结果就是用户可以将绝大多数不想看到弹出窗口屏蔽掉。于是，在弹出窗口被屏蔽时，就应该考虑两种可能性。如果是浏览器内置的屏蔽程序阻止的弹出窗口，那么 window.open () 很可能会返回 null。此时，只要检测这个返回的值就可以确定弹出窗口是否被屏蔽了，如下面的例子所示。

var wroxWin = window.open("http://www.wrox.com", "_blank"); if (wroxWin == null){ alert("The popup was blocked!"); }

如果是浏览器扩展或其他程序阻止的弹出窗口，那么 window.open () 通常会抛出一个错误。因此，要想准确地检测出弹出窗口是否被屏蔽，必须在检测返回值的同时，将对 window.open () 的调用封装在一个 try-catch 块中，如下所示。

var blocked = false; try { var wroxWin = window.open("http://www.wrox.com", "_blank"); if (wroxWin == null){ blocked = true; } } catch (ex){ blocked = true; } if (blocked){ alert("The popup was blocked!"); }

PopupBlockerExample01.htm

在任何情况下，以上代码都可以检测出调用 window.open () 打开的弹出窗口是不是被屏蔽了。但要注意的是，检测弹出窗口是否被屏蔽只是一方面，它并不会阻止浏览器显示与被屏蔽的弹出窗口有关的消息。

8.1.6　间歇调用和超时调用

JavaScript 是单线程语言，但它允许通过设置超时值和间歇时间值来调度代码在特定的时刻执行。前者是在指定的时间过后执行代码，而后者则是每隔指定的时间就执行一次代码。

超时调用需要使用 window 对象的 setTimeout () 方法，它接受两个参数：要执行的代码和以毫秒表示的时间（即在执行代码前需要等待多少毫秒）。其中，第一个参数可以是一个包含 JavaScript 代码的字符串（就和在 eval () 函数中使用的字符串一样），也可以是一个函数。例如，下面对 setTimeout () 的两次调用都会在一秒钟后显示一个警告框。

// 不建议传递字符串！ setTimeout ("alert ('Hello world!')", 1000); // 推荐的调用方式 setTimeout (function () {alert ("Hello world!"); }, 1000);

TimeoutExample01.htm

虽然这两种调用方式都没有问题，但由于传递字符串可能导致性能损失，因此不建议以字符串作为第一个参数。

第二个参数是一个表示等待多长时间的毫秒数，但经过该时间后指定的代码不一定会执行。JavaScript 是一个单线程序的解释器，因此一定时间内只能执行一段代码。为了控制要执行的代码，就有一个 JavaScript 任务队列。这些任务会按照将它们添加到队列的顺序执行。setTimeout () 的第二个参数告诉 JavaScript 再过多长时间把当前任务添加到队列中。如果队列是空的，那么添加的代码会立即执行；如果队列不是空的，那么它就要等前面的代码执行完了以后再执行。

调用 setTimeout () 之后，该方法会返回一个数值 ID，表示超时调用。这个超时调用 ID 是计划执行代码的唯一标识符，可以通过它来取消超时调用。要取消尚未执行的超时调用计划，可以调用 clearTimeout () 方法并将相应的超时调用 ID 作为参数传递给它，如下所示。

// 设置超时调用 var timeoutId = setTimeout (function () {alert ("Hello world!"); }, 1000); // 注意：把它取消 clearTimeout (timeoutId);

TimeoutExample02.htm

只要是在指定的时间尚未过去之前调用 clearTimeout ()，就可以完全取消超时调用。前面的代码在设置超时调用之后马上又调用了 clearTimeout ()，结果就跟什么也没有发生一样。

超时调用的代码都是在全局作用域中执行的，因此函数中 this 的值在非严格模式下指向 window 对象，在严格模式下是 undefined。

间歇调用与超时调用类似，只不过它会按照指定的时间间隔重复执行代码，直至间歇调用被取消或者页面被卸载。设置间歇调用的方法是 setInterval ()，它接受的参数与 setTimeout () 相同：要执行的代码（字符串或函数）和每次执行之前需要等待的毫秒数。下面来看一个例子。

// 不建议传递字符串！ setInterval ("alert ('Hello world!')", 10000); // 推荐的调用方式 setInterval (function () {alert ("Hello world!"); }, 10000);

IntervalExample01.htm

调用 setInterval () 方法同样也会返回一个间歇调用 ID，该 ID 可用于在将来某个时刻取消间歇调用。要取消尚未执行的间歇调用，可以使用 clearInterval () 方法并传入相应的间歇调用 ID。取消间歇调用的重要性要远远高于取消超时调用，因为在不加干涉的情况下，间歇调用将会一直执行到页面卸载。以下是一个常见的使用间歇调用的例子。

var num = 0; var max = 10; var intervalId = null; function incrementNumber () { num++; // 如果执行次数达到了 max 设定的值，则取消后续尚未执行的调用 if (num == max) {clearInterval (intervalId); alert ("Done"); } } intervalId = setInterval (incrementNumber, 500);

IntervalExample02.htm

在这个例子中，变量 num 每半秒钟递增一次，当递增到最大值时就会取消先前设定的间歇调用。这个模式也可以使用超时调用来实现，如下所示。

var num = 0; var max = 10; function incrementNumber () { num++; // 如果执行次数未达到 max 设定的值，则设置另一次超时调用 if (num < max) {setTimeout (incrementNumber, 500); } else {alert ("Done"); } } setTimeout (incrementNumber, 500);

TimeoutExample03.htm

可见，在使用超时调用时，没有必要跟踪超时调用 ID，因为每次执行代码之后，如果不再设置另一次超时调用，调用就会自行停止。一般认为，使用超时调用来模拟间歇调用的是一种最佳模式。在开发环境下，很少使用真正的间歇调用，原因是后一个间歇调用可能会在前一个间歇调用结束之前启动。而像前面示例中那样使用超时调用，则完全可以避免这一点。所以，最好不要使用间歇调用。

8.1.7　系统对话框

浏览器通过 alert ()、confirm () 和 prompt () 方法可以调用系统对话框向用户显示消息。系统对话框与在浏览器中显示的网页没有关系，也不包含 HTML。它们的外观由操作系统及（或）浏览器设置决定，而不是由 CSS 决定。此外，通过这几个方法打开的对话框都是同步和模态的。也就是说，显示这些对话框的时候代码会停止执行，而关掉这些对话框后代码又会恢复执行。

本书各章经常会用到 alert () 方法，这个方法接受一个字符串并将其显示给用户。具体来说，调用 alert () 方法的结果就是向用户显示一个系统对话框，其中包含指定的文本和一个 OK（「确定」）按钮。例如，alert ("Hello world!") 会在 Windows XP 系统的 IE 中生成如图 8-3 所示的对话框。

通常使用 alert () 生成的「警告」对话框向用户显示一些他们无法控制的消息，例如错误消息。而用户只能在看完消息后关闭对话框。

第二种对话框是调用 confirm () 方法生成的。从向用户显示消息的方面来看，这种「确认」对话框很像是一个「警告」对话框。但二者的主要区别在于「确认」对话框除了显示 OK 按钮外，还会显示一个 Cancel（「取消」）按钮，两个按钮可以让用户决定是否执行给定的操作。例如，confirm ("Are you sure?") 会显示如图 8-4 所示的确认对话框。

图　8-3 图　8-4

为了确定用户是单击了 OK 还是 Cancel，可以检查 confirm () 方法返回的布尔值：true 表示单击了 OK，false 表示单击了 Cancel 或单击了右上角的 X 按钮。确认对话框的典型用法如下。

if (confirm("Are you sure?")) { alert("I'm so glad you're sure! "); } else { alert("I'm sorry to hear you're not sure. "); }

在这个例子中，第一行代码（if 条件语句）会向用户显示一个确认对话框。如果用户单击了 OK，则通过一个警告框向用户显示消息 I’m so glad you’ re sure! 。如果用户单击的是 Cancel 按钮，则通过警告框显示 I’m sorry to hear you’re not sure.。这种模式经常在用户想要执行删除操作的时候使用，例如删除电子邮件。

最后一种对话框是通过调用 prompt () 方法生成的，这是一个「提示」框，用于提示用户输入一些文本。提示框中除了显示 OK 和 Cancel 按钮之外，还会显示一个文本输入域，以供用户在其中输入内容。prompt () 方法接受两个参数：要显示给用户的文本提示和文本输入域的默认值（可以是一个空字符串）。调用 prompt ("What's your name?","Michael") 会得到如图 8-5 所示的对话框。

图　8-5

如果用户单击了 OK 按钮，则 prompt () 返回文本输入域的值；如果用户单击了 Cancel 或没有单击 OK 而是通过其他方式关闭了对话框，则该方法返回 null。下面是一个例子。

var result = prompt("What is your name? ", ""); if (result !== null) { alert("Welcome, " + result); }

综上所述，这些系统对话框很适合向用户显示消息并请用户作出决定。由于不涉及 HTML、CSS 或 JavaScript，因此它们是增强 Web 应用程序的一种便捷方式。

除了上述三种对话框之外，Google Chrome 浏览器还引入了一种新特性。如果当前脚本在执行过程中会打开两个或多个对话框，那么从第二个对话框开始，每个对话框中都会显示一个复选框，以便用户阻止后续的对话框显示，除非用户刷新页面（见图 8-6）。

图　8-6

如果用户勾选了其中的复选框，并且关闭了对话框，那么除非用户刷新页面，所有后续的系统对话框（包括警告框、确认框和提示框）都会被屏蔽。Chrome 没有就对话框是否显示向开发人员提供任何信息。由于浏览器会在空闲时重置对话框计数器，因此如果两次独立的用户操作分别打开两个警告框，那么这两个警告框中都不会显示复选框。而如果是同一次用户操作会生成两个警告框，那么第二个警告框中就会显示复选框。这个新特性出现以后，IE9 和 Firefox 4 也实现了它。

还有两个可以通过 JavaScript 打开的对话框，即「查找」和「打印」。这两个对话框都是异步显示的，能够将控制权立即交还给脚本。这两个对话框与用户通过浏览器菜单的「查找」和「打印」命令打开的对话框相同。而在 JavaScript 中则可以像下面这样通过 window 对象的 find () 和 print () 方法打开它们。

// 显示「打印」对话框 window.print (); // 显示「查找」对话框 window.find ();

这两个方法同样不会就用户在对话框中的操作给出任何信息，因此它们的用处有限。另外，既然这两个对话框是异步显示的，那么 Chrome 的对话框计数器就不会将它们计算在内，所以它们也不会受用户禁用后续对话框显示的影响。

8.2　location 对象

location 是最有用的 BOM 对象之一，它提供了与当前窗口中加载的文档有关的信息，还提供了一些导航功能。事实上，location 对象是很特别的一个对象，因为它既是 window 对象的属性，也是 document 对象的属性；换句话说，window.location 和 document.location 引用的是同一个对象。location 对象的用处不只表现在它保存着当前文档的信息，还表现在它将 URL 解析为独立的片段，让开发人员可以通过不同的属性访问这些片段。下表列出了 location 对象的所有属性（注：省略了每个属性前面的 location 前缀）。

属　性　名 例　　子 说　　明

hash "#contents" 返回 URL 中的 hash（# 号后跟零或多个字符），如果 URL 中不包含散列，则返回空字符串

host "www.wrox.com:80" 返回服务器名称和端口号（如果有）

hostname "www.wrox.com" 返回不带端口号的服务器名称

href "http:/www.wrox.com" 返回当前加载页面的完整 URL。而 location 对象的 toString () 方法也返回这个值

pathname "/WileyCDA/" 返回 URL 中的目录和（或）文件名

port "8080" 返回 URL 中指定的端口号。如果 URL 中不包含端口号，则这个属性返回空字符串

protocol "http:" 返回页面使用的协议。通常是 http: 或 https:

search "?q=javascript" 返回 URL 的查询字符串。这个字符串以问号开头

8.2.1　查询字符串参数

虽然通过上面的属性可以访问到 location 对象的大多数信息，但其中访问 URL 包含的查询字符串的属性并不方便。尽管 location.search 返回从问号到 URL 末尾的所有内容，但却没有办法逐个访问其中的每个查询字符串参数。为此，可以像下面这样创建一个函数，用以解析查询字符串，然后返回包含所有参数的一个对象：

function getQueryStringArgs (){ // 取得查询字符串并去掉开头的问号 var qs = (location.search.length> 0 ? location.search.substring (1) : ""), // 保存数据的对象 args = {}, // 取得每一项 items = qs.length ? qs.split ("&") : [], item = null, name = null, value = null, // 在 for 循环中使用 i = 0, len = items.length; // 逐个将每一项添加到 args 对象中 for (i=0; i < len; i++){item = items [i].split ("="); name = decodeURIComponent (item [0]); value = decodeURIComponent (item [1]); if (name.length) {args [name] = value; } } return args; }

LocationExample01.htm

这个函数的第一步是先去掉查询字符串开头的问号。当然，前提是 location.search 中必须要包含一或多个字符。然后，所有参数将被保存在 args 对象中，该对象以字面量形式创建。接下来，根据和号（&）来分割查询字符串，并返回 name=value 格式的字符串数组。下面的 for 循环会迭代这个数组，然后再根据等于号分割每一项，从而返回第一项为参数名，第二项为参数值的数组。再使用 decodeURIComponent () 分别解码 name 和 value（因为查询字符串应该是被编码过的）。最后，将 name 作为 args 对象的属性，将 value 作为相应属性的值。下面给出了使用这个函数的示例。

// 假设查询字符串是？q=javascript&num=10 var args = getQueryStringArgs (); alert (args ["q"]); //"javascript" alert (args ["num"]); //"10"

可见，每个查询字符串参数都成了返回对象的属性。这样就极大地方便了对每个参数的访问。

8.2.2　位置操作

使用 location 对象可以通过很多方式来改变浏览器的位置。首先，也是最常用的方式，就是使用 assign () 方法并为其传递一个 URL，如下所示。

location.assign("http://www.wrox.com");

这样，就可以立即打开新 URL 并在浏览器的历史记录中生成一条记录。如果是将 location.href 或 window.location 设置为一个 URL 值，也会以该值调用 assign () 方法。例如，下列两行代码与显式调用 assign () 方法的效果完全一样。

window.location = "http://www.wrox.com"; location.href = "http://www.wrox.com";

在这些改变浏览器位置的方法中，最常用的是设置 location.href 属性。

另外，修改 location 对象的其他属性也可以改变当前加载的页面。下面的例子展示了通过将 hash、search、hostname、pathname 和 port 属性设置为新值来改变 URL。

// 假设初始 URL 为 http://www.wrox.com/WileyCDA/// 将 URL 修改为 "http://www.wrox.com/WileyCDA/#section1" location.hash = "#section1"; // 将 URL 修改为 "http://www.wrox.com/WileyCDA/?q=javascript" location.search = "?q=javascript"; // 将 URL 修改为 "http://www.yahoo.com/WileyCDA/" location.hostname = "www.yahoo.com"; // 将 URL 修改为 "http://www.yahoo.com/mydir/" location.pathname = "mydir"; // 将 URL 修改为 "http://www.yahoo.com:8080/WileyCDA/" location.port = 8080;

每次修改 location 的属性（hash 除外），页面都会以新 URL 重新加载。

在 IE8、Firefox 1、Safari 2+、Opera 9 + 和 Chrome 中，修改 hash 的值会在浏览器的历史记录中生成一条新记录。在 IE 的早期版本中，hash 属性不会在用户单击「后退」和「前进」按钮时被更新，而只会在用户单击包含 hash 的 URL 时才会被更新。

当通过上述任何一种方式修改 URL 之后，浏览器的历史记录中就会生成一条新记录，因此用户通过单击「后退」按钮都会导航到前一个页面。要禁用这种行为，可以使用 replace () 方法。这个方法只接受一个参数，即要导航到的 URL；结果虽然会导致浏览器位置改变，但不会在历史记录中生成新记录。在调用 replace () 方法之后，用户不能回到前一个页面，来看下面的例子：

<!DOCTYPE html> <html> <head> <title>You won't be able to get back here</title> </head> <body> <p>Enjoy this page for a second, because you won't be coming back here.</p> <script type="text/javascript"> setTimeout(function () { location.replace("http://www.wrox.com/"); }, 1000); </script> </body> </html>

LocationReplaceExample01.htm

如果将这个页面加载到浏览器中，浏览器就会在 1 秒钟后重新定向到 www.wrox.com。然后，「后退」按钮将处于禁用状态，如果不重新输入完整的 URL，则无法返回示例页面。

与位置有关的最后一个方法是 reload ()，作用是重新加载当前显示的页面。如果调用 reload () 时不传递任何参数，页面就会以最有效的方式重新加载。也就是说，如果页面自上次请求以来并没有改变过，页面就会从浏览器缓存中重新加载。如果要强制从服务器重新加载，则需要像下面这样为该方法传递参数 true。

location.reload (); // 重新加载（有可能从缓存中加载） location.reload (true); // 重新加载（从服务器重新加载）

位于 reload () 调用之后的代码可能会也可能不会执行，这要取决于网络延迟或系统资源等因素。为此，最好将 reload () 放在代码的最后一行。

8.3　navigator 对象

最早由 Netscape Navigator 2.0 引入的 navigator 对象，现在已经成为识别客户端浏览器的事实标准。虽然其他浏览器也通过其他方式提供了相同或相似的信息（例如，IE 中的 window.clientInformation 和 Opera 中的 window.opera），但 navigator 对象却是所有支持 JavaScript 的浏览器所共有的。与其他 BOM 对象的情况一样，每个浏览器中的 navigator 对象也都有一套自己的属性。下表列出了存在于所有浏览器中的属性和方法，以及支持它们的浏览器版本。

属性或方法 说　　明 IE Firefox Safari/

Chrome Opera

appCodeName 浏览器的名称。通常都是 Mozilla，即使在非 Mozilla 浏览器中也是如此 3.0+ 1.0+ 1.0+ 7.0+

appMinorVersion 次版本信息 4.0+ － － 9.5+

appName 完整的浏览器名称 3.0+ 1.0+ 1.0+ 7.0+

appVersion 浏览器的版本。一般不与实际的浏览器版本对应 3.0+ 1.0+ 1.0+ 7.0+

buildID 浏览器编译版本 － 2.0+ － －

cookieEnabled 表示 cookie 是否启用 4.0+ 1.0+ 1.0+ 7.0+

cpuClass 客户端计算机中使用的 CPU 类型（x86、68K、Alpha、PPC 或 Other） 4.0+ － － －

javaEnabled () 表示当前浏览器中是否启用了 Java 4.0+ 1.0+ 1.0+ 7.0+

language 浏览器的主语言 － 1.0+ 1.0+ 7.0+

mimeTypes 在浏览器中注册的 MIME 类型数组 4.0+ 1.0+ 1.0+ 7.0+

onLine 表示浏览器是否连接到了因特网 4.0+ 1.0+ － 9.5+

opsProfile 似乎早就不用了。查不到相关文档 4.0+ － － －

oscpu 客户端计算机的操作系统或使用的 CPU － 1.0+ － －

Platform 浏览器所在的系统平台 4.0+ 1.0+ 1.0+ 7.0+

plugins 浏览器中安装的插件信息的数组 4.0+ 1.0+ 1.0+ 7.0+

preference () 设置用户的首选项 － 1.5+ － －

product 产品名称（如 Gecko） － 1.0+ 1.0+ －

productSub 关于产品的次要信息（如 Gecko 的版本） － 1.0+ 1.0+ －

register-

ContentHandler () 针对特定的 MIME 类型将一个站点注册为处理程序 － 2.0+ － －

register-

ProtocolHandler () 针对特定的协议将一个站点注册为处理程序 － 2.0 － －

securityPolicy 已经废弃。安全策略的名称。为了与 Netscape Navigator 4 向后兼容而保留下来 － 1.0+ － －

systemLanguage 操作系统的语言 4.0+ － － －

taintEnabled () 已经废弃。表示是否允许变量被修改（taint）。为了与 Netscape Navigator 3 向后兼容而保留下来 4.0+ 1.0+ － 7.0+

userAgent 浏览器的用户代理字符串 3.0+ 1.0+ 1.0+ 7.0+

userLanguage 操作系统的默认语言 4.0+ － － 7.0+

userProfile 借以访问用户个人信息的对象 4.0+ － － －

vendor 浏览器的品牌 － 1.0+ 1.0+ －

vendorSub 有关供应商的次要信息 － 1.0+ 1.0+ －

表中的这些 navigator 对象的属性通常用于检测显示网页的浏览器类型（第 9 章会详细讨论）。

8.3.1　检测插件

检测浏览器中是否安装了特定的插件是一种最常见的检测例程。对于非 IE 浏览器，可以使用 plugins 数组来达到这个目的。该数组中的每一项都包含下列属性。

name：插件的名字。

description：插件的描述。

filename：插件的文件名。

length：插件所处理的 MIME 类型数量。

一般来说，name 属性中会包含检测插件必需的所有信息，但有时候也不完全如此。在检测插件时，需要像下面这样循环迭代每个插件并将插件的 name 与给定的名字进行比较。

// 检测插件（在 IE 中无效） function hasPlugin (name){name = name.toLowerCase (); for (var i=0; i < navigator.plugins.length; i++){if (navigator. plugins [i].name.toLowerCase ().indexOf (name) > -1){return true;} } return false; } // 检测 Flash alert (hasPlugin ("Flash")); // 检测 QuickTime alert (hasPlugin ("QuickTime"));

PluginDetectionExample01.htm

这个 hasPlugin () 函数接受一个参数：要检测的插件名。第一步是将传入的名称转换为小写形式，以便于比较。然后，迭代 plugins 数组，通过 indexOf () 检测每个 name 属性，以确定传入的名称是否出现在字符串的某个地方。比较的字符串都使用小写形式可以避免因大小写不一致导致的错误。而传入的参数应该尽可能具体，以避免混淆。应该说，像 Flash 和 QuickTime 这样的字符串就比较具体了，不容易导致混淆。在 Firefox、Safari、Opera 和 Chrome 中可以使用这种方法来检测插件。

每个插件对象本身也是一个 MimeType 对象的数组，这些对象可以通过方括号语法来访问。每个 MimeType 对象有 4 个属性：包含 MIME 类型描述的 description、回指插件对象的 enabledPlugin、表示与 MIME 类型对应的文件扩展名的字符串 suffixes（以逗号分隔）和表示完整 MIME 类型字符串的 type。

检测 IE 中的插件比较麻烦，因为 IE 不支持 Netscape 式的插件。在 IE 中检测插件的唯一方式就是使用专有的 ActiveXObject 类型，并尝试创建一个特定插件的实例。IE 是以 COM 对象的方式实现插件的，而 COM 对象使用唯一标识符来标识。因此，要想检查特定的插件，就必须知道其 COM 标识符。例如，Flash 的标识符是 ShockwaveFlash.ShockwaveFlash。知道唯一标识符之后，就可以编写类似下面的函数来检测 IE 中是否安装相应插件了。

// 检测 IE 中的插件 function hasIEPlugin (name){try { new ActiveXObject (name); return true; } catch (ex){return false;} } // 检测 Flash alert (hasIEPlugin ("ShockwaveFlash.ShockwaveFlash")); // 检测 QuickTime alert (hasIEPlugin ("QuickTime.QuickTime"));

PluginDetectionExample02.htm

在这个例子中，函数 hasIEPlugin () 只接收一个 COM 标识符作为参数。在函数内部，首先会尝试创建一个 COM 对象的实例。之所以要在 try-catch 语句中进行实例化，是因为创建未知 COM 对象会导致抛出错误。这样，如果实例化成功，则函数返回 true；否则，如果抛出了错误，则执行 catch 块，结果就会返回 false。例子最后检测 IE 中是否安装了 Flash 和 QuickTime 插件。

鉴于检测这两种插件的方法差别太大，因此典型的做法是针对每个插件分别创建检测函数，而不是使用前面介绍的通用检测方法。来看下面的例子。

// 检测所有浏览器中的 Flash function hasFlash (){ var result = hasPlugin ("Flash"); if (!result){result = hasIEPlugin ("ShockwaveFlash.ShockwaveFlash"); } return result; } // 检测所有浏览器中的 QuickTime function hasQuickTime (){ var result = hasPlugin ("QuickTime"); if (!result){result = hasIEPlugin ("QuickTime.QuickTime"); } return result; } // 检测 Flash alert (hasFlash ()); // 检测 QuickTime alert (hasQuickTime ());

PluginDetectionExample03.htm

上面代码中定义了两个函数：hasFlash () 和 hasQuickTime ()。每个函数都是先尝试使用不针对 IE 的插件检测方法。如果返回了 false（在 IE 中会这样），那么再使用针对 IE 的插件检测方法。如果 IE 的插件检测方法再返回 false，则整个方法也将返回 false。只要任何一次检测返回 true，整个方法都会返回 true。

plugins 集合有一个名叫 refresh () 的方法，用于刷新 plugins 以反映最新安装的插件。这个方法接收一个参数：表示是否应该重新加载页面的一个布尔值。如果将这个值设置为 true，则会重新加载包含插件的所有页面；否则，只更新 plugins 集合，不重新加载页面。

8.3.2　注册处理程序

Firefox 2 为 navigator 对象新增了 registerContentHandler () 和 registerProtocolHandler () 方法（这两个方法是在 HTML5 中定义的，相关内容将在第 22 章讨论）。这两个方法可以让一个站点指明它可以处理特定类型的信息。随着 RSS 阅读器和在线电子邮件程序的兴起，注册处理程序就为像使用桌面应用程序一样默认使用这些在线应用程序提供了一种方式。

其中，registerContentHandler () 方法接收三个参数：要处理的 MIME 类型、可以处理该 MIME 类型的页面的 URL 以及应用程序的名称。举个例子，要将一个站点注册为处理 RSS 源的处理程序，可以使用如下代码。

navigator.registerContentHandler("application/rss+xml", "http://www.somereader.com?feed=%s", "Some Reader");

第一个参数是 RSS 源的 MIME 类型。第二个参数是应该接收 RSS 源 URL 的 URL，其中的 % s 表示 RSS 源 URL，由浏览器自动插入。当下一次请求 RSS 源时，浏览器就会打开指定的 URL，而相应的 Web 应用程序将以适当方式来处理该请求。

Firefox 4 及之前版本只允许在 registerContentHandler () 方法中使用三个 MIME 类型：application/rss+xml、application/atom+xml 和 application/vnd.mozilla.maybe. feed。这三个 MIME 类型的作用都一样，即为 RSS 或 ATOM 新闻源（feed）注册处理程序。

类似的调用方式也适用于 registerProtocolHandler () 方法，它也接收三个参数：要处理的协议（例如，mailto 或 ftp）、处理该协议的页面的 URL 和应用程序的名称。例如，要想将一个应用程序注册为默认的邮件客户端，可以使用如下代码。

navigator.registerProtocolHandler("mailto", "http://www.somemailclient.com?cmd=%s", "Some Mail Client");

这个例子注册了一个 mailto 协议的处理程序，该程序指向一个基于 Web 的电子邮件客户端。同样，第二个参数仍然是处理相应请求的 URL，而 % s 则表示原始的请求。

Firefox 2 虽然实现了 registerProtocolHandler ()，但该方法还不能用。Firefox 3 完整实现这个方法。

8.4　screen 对象

JavaScript 中有几个对象在编程中用处不大，而 screen 对象就是其中之一。screen 对象基本上只用来表明客户端的能力，其中包括浏览器窗口外部的显示器的信息，如像素宽度和高度等。每个浏览器中的 screen 对象都包含着各不相同的属性，下表列出了所有属性及支持相应属性的浏览器。

