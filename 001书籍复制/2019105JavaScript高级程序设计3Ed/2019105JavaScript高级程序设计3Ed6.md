将函数名想象为指针，也有助于理解为什么 ECMAScript 中没有函数重载的概念。以下是曾在第 3 章使用过的例子。

function addSomeNumber(num){ return num + 100; } function addSomeNumber(num) { return num + 200; } var result = addSomeNumber(100); //300

显然，这个例子中声明了两个同名函数，而结果则是后面的函数覆盖了前面的函数。以上代码实际上与下面的代码没有什么区别。

var addSomeNumber = function (num){ return num + 100; }; addSomeNumber = function (num) { return num + 200; }; var result = addSomeNumber(100); //300

通过观察重写之后的代码，很容易看清楚到底是怎么回事儿 —— 在创建第二个函数时，实际上覆盖了引用第一个函数的变量 addSomeNumber。

5.5.2　函数声明与函数表达式

本节到目前为止，我们一直没有对函数声明和函数表达式加以区别。而实际上，解析器在向执行环境中加载数据时，对函数声明和函数表达式并非一视同仁。解析器会率先读取函数声明，并使其在执行任何代码之前可用（可以访问）；至于函数表达式，则必须等到解析器执行到它所在的代码行，才会真正被解释执行。请看下面的例子。

alert(sum(10,10)); function sum(num1, num2){ return num1 + num2; }

FunctionDeclarationExample01.htm

以上代码完全可以正常运行。因为在代码开始执行之前，解析器就已经通过一个名为函数声明提升（function declaration hoisting）的过程，读取并将函数声明添加到执行环境中。对代码求值时，JavaScript 引擎在第一遍会声明函数并将它们放到源代码树的顶部。所以，即使声明函数的代码在调用它的代码后面，JavaScript 引擎也能把函数声明提升到顶部。如果像下面例子所示的，把上面的函数声明改为等价的函数表达式，就会在执行期间导致错误。

alert(sum(10,10)); var sum = function(num1, num2){ return num1 + num2; };

FunctionInitializationExample01.htm

以上代码之所以会在运行期间产生错误，原因在于函数位于一个初始化语句中，而不是一个函数声明。换句话说，在执行到函数所在的语句之前，变量 sum 中不会保存有对函数的引用；而且，由于第一行代码就会导致「unexpected identifier」（意外标识符）错误，实际上也不会执行到下一行。

除了什么时候可以通过变量访问函数这一点区别之外，函数声明与函数表达式的语法其实是等价的。

也可以同时使用函数声明和函数表达式，例如 var sum = function sum (){}。不过，这种语法在 Safari 中会导致错误。

5.5.3　作为值的函数

因为 ECMAScript 中的函数名本身就是变量，所以函数也可以作为值来使用。也就是说，不仅可以像传递参数一样把一个函数传递给另一个函数，而且可以将一个函数作为另一个函数的结果返回。来看一看下面的函数。

function callSomeFunction(someFunction, someArgument){ return someFunction(someArgument); }

这个函数接受两个参数。第一个参数应该是一个函数，第二个参数应该是要传递给该函数的一个值。然后，就可以像下面的例子一样传递函数了。

function add10(num){ return num + 10; } var result1 = callSomeFunction(add10, 10); alert(result1); //20 function getGreeting(name){ return "Hello, " + name; } var result2 = callSomeFunction(getGreeting, "Nicholas"); alert(result2); //"Hello, Nicholas"

FunctionAsAnArgumentExample01.htm

这里的 callSomeFunction () 函数是通用的，即无论第一个参数中传递进来的是什么函数，它都会返回执行第一个参数后的结果。还记得吧，要访问函数的指针而不执行函数的话，必须去掉函数名后面的那对圆括号。因此上面例子中传递给 callSomeFunction () 的是 add10 和 getGreeting，而不是执行它们之后的结果。

当然，可以从一个函数中返回另一个函数，而且这也是极为有用的一种技术。例如，假设有一个对象数组，我们想要根据某个对象属性对数组进行排序。而传递给数组 sort () 方法的比较函数要接收两个参数，即要比较的值。可是，我们需要一种方式来指明按照哪个属性来排序。要解决这个问题，可以定义一个函数，它接收一个属性名，然后根据这个属性名来创建一个比较函数，下面就是这个函数的定义。

function createComparisonFunction(propertyName) { return function(object1, object2){ var value1 = object1[propertyName]; var value2 = object2[propertyName]; if (value1 < value2){ return -1; } else if (value1 > value2){ return 1; } else { return 0; } }; }

FunctionReturningFunctionExample01.htm

这个函数定义看起来有点复杂，但实际上无非就是在一个函数中嵌套了另一个函数，而且内部函数前面加了一个 return 操作符。在内部函数接收到 propertyName 参数后，它会使用方括号表示法来取得给定属性的值。取得了想要的属性值之后，定义比较函数就非常简单了。上面这个函数可以像在下面例子中这样使用。

var data = [{name: "Zachary", age: 28}, {name: "Nicholas", age: 29}]; data.sort(createComparisonFunction("name")); alert(data[0].name); //Nicholas data.sort(createComparisonFunction("age")); alert(data[0].name); //Zachary

这里，我们创建了一个包含两个对象的数组 data。其中，每个对象都包含一个 name 属性和一个 age 属性。在默认情况下，sort () 方法会调用每个对象的 toString () 方法以确定它们的次序；但得到的结果往往并不符合人类的思维习惯。因此，我们调用 createComparisonFunction ("name") 方法创建了一个比较函数，以便按照每个对象的 name 属性值进行排序。而结果排在前面的第一项是 name 为 "Nicholas"，age 是 29 的对象。然后，我们又使用了 createComparisonFunction ("age") 返回的比较函数，这次是按照对象的 age 属性排序。得到的结果是 name 值为 "Zachary"，age 值是 28 的对象排在了第一位。

5.5.4　函数内部属性

在函数内部，有两个特殊的对象：arguments 和 this。其中，arguments 在第 3 章曾经介绍过，它是一个类数组对象，包含着传入函数中的所有参数。虽然 arguments 的主要用途是保存函数参数，但这个对象还有一个名叫 callee 的属性，该属性是一个指针，指向拥有这个 arguments 对象的函数。请看下面这个非常经典的阶乘函数。

function factorial(num){ if (num <=1) { return 1; } else { return num * factorial(num-1) } }

定义阶乘函数一般都要用到递归算法；如上面的代码所示，在函数有名字，而且名字以后也不会变的情况下，这样定义没有问题。但问题是这个函数的执行与函数名 factorial 紧紧耦合在了一起。为了消除这种紧密耦合的现象，可以像下面这样使用 arguments.callee。

function factorial(num){ if (num <=1) { return 1; } else { return num * arguments.callee(num-1) } }

FunctionTypeArgumentsExample01.htm

在这个重写后的 factorial () 函数的函数体内，没有再引用函数名 factorial。这样，无论引用函数时使用的是什么名字，都可以保证正常完成递归调用。例如：

var trueFactorial = factorial; factorial = function(){ return 0; }; alert(trueFactorial(5)); //120 alert(factorial(5)); //0

在此，变量 trueFactorial 获得了 factorial 的值，实际上是在另一个位置上保存了一个函数的指针。然后，我们又将一个简单地返回 0 的函数赋值给 factorial 变量。如果像原来的 factorial () 那样不使用 arguments.callee，调用 trueFactorial () 就会返回 0。可是，在解除了函数体内的代码与函数名的耦合状态之后，trueFactorial () 仍然能够正常地计算阶乘；至于 factorial ()，它现在只是一个返回 0 的函数。

函数内部的另一个特殊对象是 this，其行为与 Java 和 C# 中的 this 大致类似。换句话说，this 引用的是函数据以执行的环境对象 —— 或者也可以说是 this 值（当在网页的全局作用域中调用函数时，this 对象引用的就是 window）。来看下面的例子。

window.color = "red"; var o = { color: "blue" }; function sayColor(){ alert(this.color); } sayColor(); //"red" o.sayColor = sayColor; o.sayColor(); //"blue"

FunctionTypeThisExample01.htm

上面这个函数 sayColor () 是在全局作用域中定义的，它引用了 this 对象。由于在调用函数之前，this 的值并不确定，因此 this 可能会在代码执行过程中引用不同的对象。当在全局作用域中调用 sayColor () 时，this 引用的是全局对象 window；换句话说，对 this.color 求值会转换成对 window.color 求值，于是结果就返回了 "red"。而当把这个函数赋给对象 o 并调用 o.sayColor () 时，this 引用的是对象 o，因此对 this.color 求值会转换成对 o.color 求值，结果就返回了 "blue"。

请读者一定要牢记，函数的名字仅仅是一个包含指针的变量而已。因此，即使是在不同的环境中执行，全局的 sayColor () 函数与 o.sayColor () 指向的仍然是同一个函数。

ECMAScript 5 也规范化了另一个函数对象的属性：caller。除了 Opera 的早期版本不支持，其他浏览器都支持这个 ECMAScript 3 并没有定义的属性。这个属性中保存着调用当前函数的函数的引用，如果是在全局作用域中调用当前函数，它的值为 null。例如：

function outer(){ inner(); } function inner(){ alert(inner.caller); } outer();

FunctionTypeArgumentsCallerExample01.htm

以上代码会导致警告框中显示 outer () 函数的源代码。因为 outer () 调用了 inter ()，所以 inner.caller 就指向 outer ()。为了实现更松散的耦合，也可以通过 arguments.callee.caller 来访问相同的信息。

function outer(){ inner(); } function inner(){ alert(arguments.callee.caller); } outer();

FunctionTypeArgumentsCallerExample02.htm

IE、Firefox、Chrome 和 Safari 的所有版本以及 Opera 9.6 都支持 caller 属性。

当函数在严格模式下运行时，访问 arguments.callee 会导致错误。ECMAScript 5 还定义了 arguments.caller 属性，但在严格模式下访问它也会导致错误，而在非严格模式下这个属性始终是 undefined。定义这个属性是为了分清 arguments.caller 和函数的 caller 属性。以上变化都是为了加强这门语言的安全性，这样第三方代码就不能在相同的环境里窥视其他代码了。

严格模式还有一个限制：不能为函数的 caller 属性赋值，否则会导致错误。

5.5.5　函数属性和方法

前面曾经提到过，ECMAScript 中的函数是对象，因此函数也有属性和方法。每个函数都包含两个属性：length 和 prototype。其中，length 属性表示函数希望接收的命名参数的个数，如下面的例子所示。

function sayName(name){ alert(name); } function sum(num1, num2){ return num1 + num2; } function sayHi(){ alert("hi"); } alert(sayName.length); //1 alert(sum.length); //2 alert(sayHi.length); //0

FunctionTypeLengthPropertyExample01.htm

以上代码定义了 3 个函数，但每个函数接收的命名参数个数不同。首先，sayName () 函数定义了一个参数，因此其 length 属性的值为 1。类似地，sum () 函数定义了两个参数，结果其 length 属性中保存的值为 2。而 sayHi () 没有命名参数，所以其 length 值为 0。

在 ECMAScript 核心所定义的全部属性中，最耐人寻味的就要数 prototype 属性了。对于 ECMAScript 中的引用类型而言，prototype 是保存它们所有实例方法的真正所在。换句话说，诸如 toString () 和 valueOf () 等方法实际上都保存在 prototype 名下，只不过是通过各自对象的实例访问罢了。在创建自定义引用类型以及实现继承时，prototype 属性的作用是极为重要的（第 6 章将详细介绍）。在 ECMAScript 5 中，prototype 属性是不可枚举的，因此使用 for-in 无法发现。

每个函数都包含两个非继承而来的方法：apply () 和 call ()。这两个方法的用途都是在特定的作用域中调用函数，实际上等于设置函数体内 this 对象的值。首先，apply () 方法接收两个参数：一个是在其中运行函数的作用域，另一个是参数数组。其中，第二个参数可以是 Array 的实例，也可以是 arguments 对象。例如：

function sum (num1, num2){return num1 + num2;} function callSum1 (num1, num2){return sum.apply (this, arguments); // 传入 arguments 对象 } function callSum2 (num1, num2){return sum.apply (this, [num1, num2]); // 传入数组 } alert (callSum1 (10,10)); //20 alert (callSum2 (10,10)); //20

FunctionTypeApplyMethodExample01.htm

在上面这个例子中，callSum1 () 在执行 sum () 函数时传入了 this 作为 this 值（因为是在全局作用域中调用的，所以传入的就是 window 对象）和 arguments 对象。而 callSum2 同样也调用了 sum () 函数，但它传入的则是 this 和一个参数数组。这两个函数都会正常执行并返回正确的结果。

在严格模式下，未指定环境对象而调用函数，则 this 值不会转型为 window。除非明确把函数添加到某个对象或者调用 apply () 或 call ()，否则 this 值将是 undefined。

call () 方法与 apply () 方法的作用相同，它们的区别仅在于接收参数的方式不同。对于 call () 方法而言，第一个参数是 this 值没有变化，变化的是其余参数都直接传递给函数。换句话说，在使用 call () 方法时，传递给函数的参数必须逐个列举出来，如下面的例子所示。

function sum(num1, num2){ return num1 + num2; } function callSum(num1, num2){ return sum.call(this, num1, num2); } alert(callSum(10,10)); //20

FunctionTypeCallMethodExample01.htm

在使用 call () 方法的情况下，callSum () 必须明确地传入每一个参数。结果与使用 apply () 没有什么不同。至于是使用 apply () 还是 call ()，完全取决于你采取哪种给函数传递参数的方式最方便。如果你打算直接传入 arguments 对象，或者包含函数中先接收到的也是一个数组，那么使用 apply () 肯定更方便；否则，选择 call () 可能更合适。（在不给函数传递参数的情况下，使用哪个方法都无所谓。）

事实上，传递参数并非 apply () 和 call () 真正的用武之地；它们真正强大的地方是能够扩充函数赖以运行的作用域。下面来看一个例子。

window.color = "red"; var o = { color: "blue" }; function sayColor(){ alert(this.color); } sayColor(); //red sayColor.call(this); //red sayColor.call(window); //red sayColor.call(o); //blue

FunctionTypeCallExample01.htm

这个例子是在前面说明 this 对象的示例基础上修改而成的。这一次，sayColor () 也是作为全局函数定义的，而且当在全局作用域中调用它时，它确实会显示 "red"—— 因为对 this.color 的求值会转换成对 window.color 的求值。而 sayColor.call (this) 和 sayColor.call (window)，则是两种显式地在全局作用域中调用函数的方式，结果当然都会显示 "red"。但是，当运行 sayColor.call (o) 时，函数的执行环境就不一样了，因为此时函数体内的 this 对象指向了 o，于是结果显示的是 "blue"。

使用 call ()（或 apply ()）来扩充作用域的最大好处，就是对象不需要与方法有任何耦合关系。在前面例子的第一个版本中，我们是先将 sayColor () 函数放到了对象 o 中，然后再通过 o 来调用它的；而在这里重写的例子中，就不需要先前那个多余的步骤了。

ECMAScript 5 还定义了一个方法：bind ()。这个方法会创建一个函数的实例，其 this 值会被绑定到传给 bind () 函数的值。例如：

window.color = "red"; var o = { color: "blue" }; function sayColor(){ alert(this.color); } var objectSayColor = sayColor.bind(o); objectSayColor(); //blue

FunctionTypeBindMethodExample01.htm

在这里，sayColor () 调用 bind () 并传入对象 o，创建了 objectSayColor () 函数。objectSayColor () 函数的 this 值等于 o，因此即使是在全局作用域中调用这个函数，也会看到 "blue"。这种技巧的优点请参考第 22 章。

支持 bind () 方法的浏览器有 IE9+、Firefox 4+、Safari 5.1+、Opera 12 + 和 Chrome。

每个函数继承的 toLocaleString () 和 toString () 方法始终都返回函数的代码。返回代码的格式则因浏览器而异 —— 有的返回的代码与源代码中的函数代码一样，而有的则返回函数代码的内部表示，即由解析器删除了注释并对某些代码作了改动后的代码。由于存在这些差异，我们无法根据这两个方法返回的结果来实现任何重要功能；不过，这些信息在调试代码时倒是很有用。另外一个继承的 valueOf () 方法同样也只返回函数代码。

5.6　基本包装类型

为了便于操作基本类型值，ECMAScript 还提供了 3 个特殊的引用类型：Boolean、Number 和 String。这些类型与本章介绍的其他引用类型相似，但同时也具有与各自的基本类型相应的特殊行为。实际上，每当读取一个基本类型值的时候，后台就会创建一个对应的基本包装类型的对象，从而让我们能够调用一些方法来操作这些数据。来看下面的例子。

var s1 = "some text"; var s2 = s1.substring(2);

这个例子中的变量 s1 包含一个字符串，字符串当然是基本类型值。而下一行调用了 s1 的 substring () 方法，并将返回的结果保存在了 s2 中。我们知道，基本类型值不是对象，因而从逻辑上讲它们不应该有方法（尽管如我们所愿，它们确实有方法）。其实，为了让我们实现这种直观的操作，后台已经自动完成了一系列的处理。当第二行代码访问 s1 时，访问过程处于一种读取模式，也就是要从内存中读取这个字符串的值。而在读取模式中访问字符串时，后台都会自动完成下列处理。

创建 String 类型的一个实例；

在实例上调用指定的方法；

销毁这个实例。

可以将以上三个步骤想象成是执行了下列 ECMAScript 代码。

var s1 = new String("some text"); var s2 = s1.substring(2); s1 = null;

经过此番处理，基本的字符串值就变得跟对象一样了。而且，上面这三个步骤也分别适用于 Boolean 和 Number 类型对应的布尔值和数字值。

引用类型与基本包装类型的主要区别就是对象的生存期。使用 new 操作符创建的引用类型的实例，在执行流离开当前作用域之前都一直保存在内存中。而自动创建的基本包装类型的对象，则只存在于一行代码的执行瞬间，然后立即被销毁。这意味着我们不能在运行时为基本类型值添加属性和方法。来看下面的例子：

var s1 = "some text"; s1.color = "red"; alert(s1.color); //undefined

在此，第二行代码试图为字符串 s1 添加一个 color 属性。但是，当第三行代码再次访问 s1 时，其 color 属性不见了。问题的原因就是第二行创建的 String 对象在执行第三行代码时已经被销毁了。第三行代码又创建自己的 String 对象，而该对象没有 color 属性。

当然，可以显式地调用 Boolean、Number 和 String 来创建基本包装类型的对象。不过，应该在绝对必要的情况下再这样做，因为这种做法很容易让人分不清自己是在处理基本类型还是引用类型的值。对基本包装类型的实例调用 typeof 会返回 "object"，而且所有基本包装类型的对象都会被转换为布尔值 true。

Object 构造函数也会像工厂方法一样，根据传入值的类型返回相应基本包装类型的实例。例如：

var obj = new Object("some text"); alert(obj instanceof String); //true

把字符串传给 Object 构造函数，就会创建 String 的实例；而传入数值参数会得到 Number 的实例，传入布尔值参数就会得到 Boolean 的实例。

要注意的是，使用 new 调用基本包装类型的构造函数，与直接调用同名的转型函数是不一样的。例如：

var value = "25"; var number = Number (value); // 转型函数 alert (typeof number); //"number" var obj = new Number (value); // 构造函数 alert (typeof obj); //"object"

在这个例子中，变量 number 中保存的是基本类型的值 25，而变量 obj 中保存的是 Number 的实例。要了解有关转型函数的更多信息，请参考第 3 章。

尽管我们不建议显式地创建基本包装类型的对象，但它们操作基本类型值的能力还是相当重要的。而每个基本包装类型都提供了操作相应值的便捷方法。

5.6.1　Boolean 类型

Boolean 类型是与布尔值对应的引用类型。要创建 Boolean 对象，可以像下面这样调用 Boolean 构造函数并传入 true 或 false 值。

var booleanObject = new Boolean(true);

Boolean 类型的实例重写了 valueOf () 方法，返回基本类型值 true 或 false；重写了 toString () 方法，返回字符串 "true" 和 "false"。可是，Boolean 对象在 ECMAScript 中的用处不大，因为它经常会造成人们的误解。其中最常见的问题就是在布尔表达式中使用 Boolean 对象，例如：

var falseObject = new Boolean(false); var result = falseObject && true; alert(result); //true var falseValue = false; result = falseValue && true; alert(result); //false

BooleanTypeExample01.htm

在这个例子中，我们使用 false 值创建了一个 Boolean 对象。然后，将这个对象与基本类型值 true 构成了逻辑与表达式。在布尔运算中，false && true 等于 false。可是，示例中的这行代码是对 falseObject 而不是对它的值（false）进行求值。前面讨论过，布尔表达式中的所有对象都会被转换为 true，因此 falseObject 对象在布尔表达式中代表的是 true。结果，true && true 当然就等于 true 了。

基本类型与引用类型的布尔值还有两个区别。首先，typeof 操作符对基本类型返回 "boolean"，而对引用类型返回 "object"。其次，由于 Boolean 对象是 Boolean 类型的实例，所以使用 instanceof 操作符测试 Boolean 对象会返回 true，而测试基本类型的布尔值则返回 false。例如：

alert(typeof falseObject); //object alert(typeof falseValue); //boolean alert(falseObject instanceof Boolean); //true alert(falseValue instanceof Boolean); //false

理解基本类型的布尔值与 Boolean 对象之间的区别非常重要 —— 当然，我们的建议是永远不要使用 Boolean 对象。

5.6.2　Number 类型

Number 是与数字值对应的引用类型。要创建 Number 对象，可以在调用 Number 构造函数时向其中传递相应的数值。下面是一个例子。

var numberObject = new Number(10);

NumberTypeExample01.htm

与 Boolean 类型一样，Number 类型也重写了 valueOf ()、toLocaleString () 和 toString () 方法。重写后的 valueOf () 方法返回对象表示的基本类型的数值，另外两个方法则返回字符串形式的数值。我们在第 3 章还介绍过，可以为 toString () 方法传递一个表示基数的参数，告诉它返回几进制数值的字符串形式，如下面的例子所示。

var num = 10; alert(num.toString()); //"10" alert(num.toString(2)); //"1010" alert(num.toString(8)); //"12" alert(num.toString(10)); //"10" alert(num.toString(16)); //"a"

NumberTypeExample01.htm

除了继承的方法之外，Number 类型还提供了一些用于将数值格式化为字符串的方法。

其中，toFixed () 方法会按照指定的小数位返回数值的字符串表示，例如：

var num = 10; alert(num.toFixed(2)); //"10.00"

NumberTypeExample01.htm

这里给 toFixed () 方法传入了数值 2，意思是显示几位小数。于是，这个方法返回了 "10.00"，即以 0 填补了必要的小数位。如果数值本身包含的小数位比指定的还多，那么接近指定的最大小数位的值就会舍入，如下面的例子所示。

var num = 10.005; alert(num.toFixed(2)); //"10.01"

能够自动舍入的特性，使得 toFixed () 方法很适合处理货币值。但需要注意的是，不同浏览器给这个方法设定的舍入规则可能会有所不同。在给 toFixed () 传入 0 的情况下，IE8 及之前版本不能正确舍入范围在 {(?0.94,?0.5],[0.5,0.94)} 之间的值。对于这个范围内的值，IE 会返回 0，而不是？1 或 1；其他浏览器都能返回正确的值。IE9 修复了这个问题。

toFixed () 方法可以表示带有 0 到 20 个小数位的数值。但这只是标准实现的范围，有些浏览器也可能支持更多位数。

另外可用于格式化数值的方法是 toExponential ()，该方法返回以指数表示法（也称 e 表示法）表示的数值的字符串形式。与 toFixed () 一样，toExponential () 也接收一个参数，而且该参数同样也是指定输出结果中的小数位数。看下面的例子。

var num = 10; alert(num.toExponential(1)); //"1.0e+1"

以上代码输出了 "1.0e+1"；不过，这么小的数值一般不必使用 e 表示法。如果你想得到表示某个数值的最合适的格式，就应该使用 toPrecision () 方法。

对于一个数值来说，toPrecision () 方法可能会返回固定大小（fixed）格式，也可能返回指数（exponential）格式；具体规则是看哪种格式最合适。这个方法接收一个参数，即表示数值的所有数字的位数（不包括指数部分）。请看下面的例子。

var num = 99; alert(num.toPrecision(1)); //"1e+2" alert(num.toPrecision(2)); //"99" alert(num.toPrecision(3)); //"99.0"

NumberTypeExample01.htm

以上代码首先完成的任务是以一位数来表示 99，结果是 "1e+2"，即 100。因为一位数无法准确地表示 99，因此 toPrecision () 就将它向上舍入为 100，这样就可以使用一位数来表示它了。而接下来的用两位数表示 99，当然还是 "99"。最后，在想以三位数表示 99 时，toPrecision () 方法返回了 "99.0"。实际上，toPrecision () 会根据要处理的数值决定到底是调用 toFixed () 还是调用 toExponential ()。而这三个方法都可以通过向上或向下舍入，做到以最准确的形式来表示带有正确小数位的值。

toPrecision () 方法可以表现 1 到 21 位小数。某些浏览器支持的范围更大，但这是典型实现的范围。

与 Boolean 对象类似，Number 对象也以后台方式为数值提供了重要的功能。但与此同时，我们仍然不建议直接实例化 Number 类型，而原因与显式创建 Boolean 对象一样。具体来讲，就是在使用 typeof 和 instanceof 操作符测试基本类型数值与引用类型数值时，得到的结果完全不同，如下面的例子所示。

var numberObject = new Number(10); var numberValue = 10; alert(typeof numberObject); //"object" alert(typeof numberValue); //"number" alert(numberObject instanceof Number); //true alert(numberValue instanceof Number); //false

在使用 typeof 操作符测试基本类型数值时，始终会返回 "number"，而在测试 Number 对象时，则会返回 "object"。类似地，Number 对象是 Number 类型的实例，而基本类型的数值则不是。

5.6.3　String 类型

String 类型是字符串的对象包装类型，可以像下面这样使用 String 构造函数来创建。

var stringObject = new String("hello world");

StringTypeExample01.htm

String 对象的方法也可以在所有基本的字符串值中访问到。其中，继承的 valueOf ()、toLocaleString () 和 toString () 方法，都返回对象所表示的基本字符串值。

String 类型的每个实例都有一个 length 属性，表示字符串中包含多个字符。来看下面的例子。

var stringValue = "hello world"; alert(stringValue.length); //"11"

这个例子输出了字符串 "hello world" 中的字符数量，即 "11"。应该注意的是，即使字符串中包含双字节字符（不是占一个字节的 ASCII 字符），每个字符也仍然算一个字符。

String 类型提供了很多方法，用于辅助完成对 ECMAScript 中字符串的解析和操作。

1. 字符方法

两个用于访问字符串中特定字符的方法是：charAt () 和 charCodeAt ()。这两个方法都接收一个参数，即基于 0 的字符位置。其中，charAt () 方法以单字符字符串的形式返回给定位置的那个字符（ECMAScript 中没有字符类型）。例如：

var stringValue = "hello world"; alert(stringValue.charAt(1)); //"e"

字符串 "hello world" 位置 1 处的字符是 "e"，因此调用 charAt (1) 就返回了 "e"。如果你想得到的不是字符而是字符编码，那么就要像下面这样使用 charCodeAt () 了。

var stringValue = "hello world"; alert (stringValue.charCodeAt (1)); // 输出 "101"

这个例子输出的是 "101"，也就是小写字母 "e" 的字符编码。

ECMAScript 5 还定义了另一个访问个别字符的方法。在支持浏览器中，可以使用方括号加数字索引来访问字符串中的特定字符，如下面的例子所示。

var stringValue = "hello world"; alert(stringValue[1]); //"e"

使用方括号表示法访问个别字符的语法得到了 IE8 及 Firefox、Safari、Chrome 和 Opera 所有版本的支持。如果是在 IE7 及更早版本中使用这种语法，会返回 undefined 值（尽管根本不是特殊的 undefined 值）。

2. 字符串操作方法

下面介绍与操作字符串有关的几个方法。第一个就是 concat ()，用于将一或多个字符串拼接起来，返回拼接得到的新字符串。先来看一个例子。

var stringValue = "hello "; var result = stringValue.concat("world"); alert(result); //"hello world" alert(stringValue); //"hello"

在这个例子中，通过 stringValue 调用 concat () 方法返回的结果是 "hello world"—— 但 stringValue 的值则保持不变。实际上，concat () 方法可以接受任意多个参数，也就是说可以通过它拼接任意多个字符串。再看一个例子：

var stringValue = "hello "; var result = stringValue.concat("world", "!"); alert(result); //"hello world!" alert(stringValue); //"hello"

这个例子将 "world" 和 "!" 拼接到了 "hello" 的末尾。虽然 concat () 是专门用来拼接字符串的方法，但实践中使用更多的还是加号操作符（+）。而且，使用加号操作符在大多数情况下都比使用 concat () 方法要简便易行（特别是在拼接多个字符串的情况下）。

ECMAScript 还提供了三个基于子字符串创建新字符串的方法：slice ()、substr () 和 substring ()。这三个方法都会返回被操作字符串的一个子字符串，而且也都接受一或两个参数。第一个参数指定子字符串的开始位置，第二个参数（在指定的情况下）表示子字符串到哪里结束。具体来说，slice () 和 substring () 的第二个参数指定的是子字符串最后一个字符后面的位置。而 substr () 的第二个参数指定的则是返回的字符个数。如果没有给这些方法传递第二个参数，则将字符串的长度作为结束位置。与 concat () 方法一样，slice ()、substr () 和 substring () 也不会修改字符串本身的值 —— 它们只是返回一个基本类型的字符串值，对原始字符串没有任何影响。请看下面的例子。

var stringValue = "hello world"; alert(stringValue.slice(3)); //"lo world" alert(stringValue.substring(3)); //"lo world" alert(stringValue.substr(3)); //"lo world" alert(stringValue.slice(3, 7)); //"lo w" alert(stringValue.substring(3,7)); //"lo w" alert(stringValue.substr(3, 7)); //"lo worl"

StringTypeManipulationMethodsExample01.htm

这个例子比较了以相同方式调用 slice ()、substr () 和 substring () 得到的结果，而且多数情况下的结果是相同的。在只指定一个参数 3 的情况下，这三个方法都返回 "lo world"，因为 "hello" 中的第二个 "l" 处于位置 3。而在指定两个参数 3 和 7 的情况下，slice () 和 substring () 返回 "lo w"（"world" 中的 "o" 处于位置 7，因此结果中不包含 "o"），但 substr () 返回 "lo worl"，因为它的第二个参数指定的是要返回的字符个数。

在传递给这些方法的参数是负值的情况下，它们的行为就不尽相同了。其中，slice () 方法会将传入的负值与字符串的长度相加，substr () 方法将负的第一个参数加上字符串的长度，而将负的第二个参数转换为 0。最后，substring () 方法会把所有负值参数都转换为 0。下面来看例子。

var stringValue = "hello world"; alert (stringValue.slice (-3)); //"rld" alert (stringValue.substring (-3)); //"hello world" alert (stringValue.substr (-3)); //"rld" alert (stringValue.slice (3, -4)); //"lo w" alert (stringValue.substring (3, -4)); //"hel" alert (stringValue.substr (3, -4)); //""（空字符串）

StringTypeManipulationMethodsExample01.htm

这个例子清晰地展示了上述三个方法之间的不同行为。在给 slice () 和 substr () 传递一个负值参数时，它们的行为相同。这是因为 - 3 会被转换为 8（字符串长度加参数 11+(-3)=8），实际上相当于调用了 slice (8) 和 substr (8)。但 substring () 方法则返回了全部字符串，因为它将 - 3 转换成了 0。

IE 的 JavaScript 实现在处理向 substr () 方法传递负值的情况时存在问题，它会返回原始的字符串。IE9 修复了这个问题。

当第二个参数是负值时，这三个方法的行为各不相同。slice () 方法会把第二个参数转换为 7，这就相当于调用了 slice (3,7)，因此返回 "lo w"。substring () 方法会把第二个参数转换为 0，使调用变成了 substring (3,0)，而由于这个方法会将较小的数作为开始位置，将较大的数作为结束位置，因此最终相当于调用了 substring (0,3)。substr () 也会将第二个参数转换为 0，这也就意味着返回包含零个字符的字符串，也就是一个空字符串。

3. 字符串位置方法

有两个可以从字符串中查找子字符串的方法：indexOf () 和 lastIndexOf ()。这两个方法都是从一个字符串中搜索给定的子字符串，然后返子字符串的位置（如果没有找到该子字符串，则返回 - 1）。这两个方法的区别在于：indexOf () 方法从字符串的开头向后搜索子字符串，而 lastIndexOf () 方法是从字符串的末尾向前搜索子字符串。还是来看一个例子吧。

var stringValue = "hello world"; alert(stringValue.indexOf("o")); //4 alert(stringValue.lastIndexOf("o")); //7

StringTypeLocationMethodsExample01.htm

子字符串 "o" 第一次出现的位置是 4，即 "hello" 中的 "o"；最后一次出现的位置是 7，即 "world" 中的 "o"。如果 "o" 在这个字符串中仅出现了一次，那么 indexOf () 和 lastIndexOf () 会返回相同的位置值。

这两个方法都可以接收可选的第二个参数，表示从字符串中的哪个位置开始搜索。换句话说，indexOf () 会从该参数指定的位置向后搜索，忽略该位置之前的所有字符；而 lastIndexOf () 则会从指定的位置向前搜索，忽略该位置之后的所有字符。看下面的例子。

var stringValue = "hello world"; alert(stringValue.indexOf("o", 6)); //7 alert(stringValue.lastIndexOf("o", 6)); //4

在将第二个参数 6 传递给这两个方法之后，得到了与前面例子相反的结果。这一次，由于 indexOf () 是从位置 6（字母 "w"）开始向后搜索，结果在位置 7 找到了 "o"，因此它返回 7。而 lastIndexOf () 是从位置 6 开始向前搜索。结果找到了 "hello" 中的 "o"，因此它返回 4。在使用第二个参数的情况下，可以通过循环调用 indexOf () 或 lastIndexOf () 来找到所有匹配的子字符串，如下面的例子所示：

var stringValue = "Lorem ipsum dolor sit amet, consectetur adipisicing elit"; var positions = new Array(); var pos = stringValue.indexOf("e"); while(pos > -1){ positions.push(pos); pos = stringValue.indexOf("e", pos + 1); } alert(positions); //"3,24,32,35,52"

StringTypeLocationMethodsExample02.htm

这个例子通过不断增加 indexOf () 方法开始查找的位置，遍历了一个长字符串。在循环之外，首先找到了 "e" 在字符串中的初始位置；而进入循环后，则每次都给 indexOf () 传递上一次的位置加 1。这样，就确保了每次新搜索都从上一次找到的子字符串的后面开始。每次搜索返回的位置依次被保存在数组 positions 中，以便将来使用。

4. trim () 方法

ECMAScript 5 为所有字符串定义了 trim () 方法。这个方法会创建一个字符串的副本，删除前置及后缀的所有空格，然后返回结果。例如：

var stringValue = " hello world "; var trimmedStringValue = stringValue.trim(); alert(stringValue); //" hello world " alert(trimmedStringValue); //"hello world"

由于 trim () 返回的是字符串的副本，所以原始字符串中的前置及后缀空格会保持不变。支持这个方法的浏览器有 IE9+、Firefox 3.5+、Safari 5+、Opera 10.5 + 和 Chrome。此外，Firefox 3.5+、Safari 5 + 和 Chrome 8 + 还支持非标准的 trimLeft () 和 trimRight () 方法，分别用于删除字符串开头和末尾的空格。

5. 字符串大小写转换方法

接下来我们要介绍的是一组与大小写转换有关的方法。ECMAScript 中涉及字符串大小写转换的方法有 4 个：toLowerCase ()、toLocaleLowerCase ()、toUpperCase () 和 toLocaleUpperCase ()。其中，toLowerCase () 和 toUpperCase () 是两个经典的方法，借鉴自 java.lang.String 中的同名方法。而 toLocaleLowerCase () 和 toLocaleUpperCase () 方法则是针对特定地区的实现。对有些地区来说，针对地区的方法与其通用方法得到的结果相同，但少数语言（如土耳其语）会为 Unicode 大小写转换应用特殊的规则，这时候就必须使用针对地区的方法来保证实现正确的转换。以下是几个例子。

var stringValue = "hello world"; alert(stringValue.toLocaleUpperCase()); //"HELLO WORLD" alert(stringValue.toUpperCase()); //"HELLO WORLD" alert(stringValue.toLocaleLowerCase()); //"hello world" alert(stringValue.toLowerCase()); //"hello world"

StringTypeCaseMethodExample01.htm

以上代码调用的 toLocaleUpperCase () 和 toUpperCase () 都返回了 "HELLO WORLD"，就像调用 toLocaleLowerCase () 和 toLowerCase () 都返回 "hello world" 一样。一般来说，在不知道自己的代码将在哪种语言环境中运行的情况下，还是使用针对地区的方法更稳妥一些。

6. 字符串的模式匹配方法

String 类型定义了几个用于在字符串中匹配模式的方法。第一个方法就是 match ()，在字符串上调用这个方法，本质上与调用 RegExp 的 exec () 方法相同。match () 方法只接受一个参数，要么是一个正则表达式，要么是一个 RegExp 对象。来看下面的例子。

var text = "cat, bat, sat, fat"; var pattern = /.at/; // 与 pattern.exec (text) 相同 var matches = text.match (pattern); alert (matches.index); //0 alert (matches [0]); //"cat" alert (pattern.lastIndex); //0

StringTypePatternMatchingExample01.htm

本例中的 match () 方法返回了一个数组；如果是调用 RegExp 对象的 exec () 方法并传递本例中的字符串作为参数，那么也会得到与此相同的数组：数组的第一项是与整个模式匹配的字符串，之后的每一项（如果有）保存着与正则表达式中的捕获组匹配的字符串。

另一个用于查找模式的方法是 search ()。这个方法的唯一参数与 match () 方法的参数相同：由字符串或 RegExp 对象指定的一个正则表达式。search () 方法返回字符串中第一个匹配项的索引；如果没有找到匹配项，则返回 - 1。而且，search () 方法始终是从字符串开头向后查找模式。看下面的例子。

var text = "cat, bat, sat, fat"; var pos = text.search(/at/); alert(pos); //1

StringTypePatternMatchingExample01.htm

这个例子中的 search () 方法返回 1，即 "at" 在字符串中第一次出现的位置。

为了简化替换子字符串的操作，ECMAScript 提供了 replace () 方法。这个方法接受两个参数：第一个参数可以是一个 RegExp 对象或者一个字符串（这个字符串不会被转换成正则表达式），第二个参数可以是一个字符串或者一个函数。如果第一个参数是字符串，那么只会替换第一个子字符串。要想替换所有子字符串，唯一的办法就是提供一个正则表达式，而且要指定全局（g）标志，如下所示。

var text = "cat, bat, sat, fat"; var result = text.replace("at", "ond"); alert(result); //"cond, bat, sat, fat" result = text.replace(/at/g, "ond"); alert(result); //"cond, bond, sond, fond"

StringTypePatternMatchingExample01.htm

在这个例子中，首先传入 replace () 方法的是字符串 "at" 和替换用的字符串 "ond"。替换的结果是把 "cat" 变成了 "cond"，但字符串中的其他字符并没有受到影响。然后，通过将第一个参数修改为带有全局标志的正则表达式，就将全部 "at" 都替换成了 "ond"。

如果第二个参数是字符串，那么还可以使用一些特殊的字符序列，将正则表达式操作得到的值插入到结果字符串中。下表列出了 ECMAScript 提供的这些特殊的字符序列。

字符序列 替换文本

$$ $

$& 匹配整个模式的子字符串。与 RegExp.lastMatch 的值相同

$' 匹配的子字符串之前的子字符串。与 RegExp.leftContext 的值相同

$` 匹配的子字符串之后的子字符串。与 RegExp.rightContext 的值相同

$n 匹配第 n 个捕获组的子字符串，其中 n 等于 0～9。例如，$1 是匹配第一个捕获组的子字符串，$2 是匹配第二个捕获组的子字符串，以此类推。如果正则表达式中没有定义捕获组，则使用空字符串

$nn 匹配第 nn 个捕获组的子字符串，其中 nn 等于 01～99。例如，$01 是匹配第一个捕获组的子字符串，$02 是匹配第二个捕获组的子字符串，以此类推。如果正则表达式中没有定义捕获组，则使用空字符串

通过这些特殊的字符序列，可以使用最近一次匹配结果中的内容，如下面的例子所示。

var text = "cat, bat, sat, fat"; result = text.replace(/(.at)/g, "word ($1)"); alert(result); //word (cat), word (bat), word (sat), word (fat)

StringTypePatternMatchingExample01.htm

在此，每个以 "at" 结尾的单词都被替换了，替换结果是 "word" 后跟一对圆括号，而圆括号中是被字符序列 $1 所替换的单词。

replace () 方法的第二个参数也可以是一个函数。在只有一个匹配项（即与模式匹配的字符串）的情况下，会向这个函数传递 3 个参数：模式的匹配项、模式匹配项在字符串中的位置和原始字符串。在正则表达式中定义了多个捕获组的情况下，传递给函数的参数依次是模式的匹配项、第一个捕获组的匹配项、第二个捕获组的匹配项……，但最后两个参数仍然分别是模式的匹配项在字符串中的位置和原始字符串。这个函数应该返回一个字符串，表示应该被替换的匹配项。使用函数作为 replace () 方法的第二个参数可以实现更加精细的替换操作，请看下面这个例子。

function htmlEscape(text){ return text.replace(/[<>"&]/g, function(match, pos, originalText){ switch(match){ case "<": return "&lt;"; case ">": return "&gt;"; case "&": return "&amp;"; case "\"": return "&quot;"; } }); } alert(htmlEscape("<p class=\"greeting\">Hello world!</p>")); //&lt;p class=&quot;greeting&quot;&gt;Hello world!&lt;/p&gt;

StringTypePatternMatchingExample01.htm

这里，我们为插入 HTML 代码定义了函数 htmlEscape ()，这个函数能够转义 4 个字符：小于号、大于号、和号以及双引号。实现这种转义的最简单方式，就是使用正则表达式查找这几个字符，然后定义一个能够针对每个匹配的字符返回特定 HTML 实体的函数。

最后一个与模式匹配有关的方法是 split ()，这个方法可以基于指定的分隔符将一个字符串分割成多个子字符串，并将结果放在一个数组中。分隔符可以是字符串，也可以是一个 RegExp 对象（这个方法不会将字符串看成正则表达式）。split () 方法可以接受可选的第二个参数，用于指定数组的大小，以便确保返回的数组不会超过既定大小。请看下面的例子。

var colorText = "red,blue,green,yellow"; var colors1 = colorText.split(","); //["red", "blue", "green", "yellow"] var colors2 = colorText.split(",", 2); //["red", "blue"] var colors3 = colorText.split(/[^\,]+/); //["", ",", ",", ",", ""]

StringTypePatternMatchingExample01.htm

在这个例子中，colorText 是逗号分隔的颜色名字符串。基于该字符串调用 split (",") 会得到一个包含其中颜色名的数组，用于分割字符串的分隔符是逗号。为了将数组截短，让它只包含两项，可以为 split () 方法传递第二个参数 2。最后，通过使用正则表达式，还可以取得包含逗号字符的数组。需要注意的是，在最后一次调用 split () 返回的数组中，第一项和最后一项是两个空字符串。之所以会这样，是因为通过正则表达式指定的分隔符出现在了字符串的开头（即子字符串 "red"）和末尾（即子字符串 "yellow"）。

对 split () 中正则表达式的支持因浏览器而异。尽管对于简单的模式没有什么差别，但对于未发现匹配项以及带有捕获组的模式，匹配的行为就不大相同了。以下是几种常见的差别。

IE8 及之前版本会忽略捕获组。ECMA-262 规定应该把捕获组拼接到结果数组中。IE9 能正确地在结果中包含捕获组。

Firefox 3.6 及之前版本在捕获组未找到匹配项时，会在结果数组中包含空字符串；ECMA-262 规定没有匹配项的捕获组在结果数组中应该用 undefined 表示。

在正则表达式中使用捕获组时还有其他微妙的差别。在使用这种正则表达式时，一定要在各种浏览器下多做一些测试。

要了解关于 split () 方法以及捕获组的跨浏览器问题的更多讨论，请参考 Steven Levithan 的文章「JavaScript split bugs：Fixed!」（http://blog.stevenlevithan.com/archives/cross-browser-split）。

7. localeCompare () 方法

与操作字符串有关的最后一个方法是 localeCompare ()，这个方法比较两个字符串，并返回下列值中的一个：

如果字符串在字母表中应该排在字符串参数之前，则返回一个负数（大多数情况下是 - 1，具体的值要视实现而定）；

如果字符串等于字符串参数，则返回 0；

如果字符串在字母表中应该排在字符串参数之后，则返回一个正数（大多数情况下是 1，具体的值同样要视实现而定）。

下面是几个例子。

var stringValue = "yellow"; alert(stringValue.localeCompare("brick")); //1 alert(stringValue.localeCompare("yellow")); //0 alert(stringValue.localeCompare("zoo")); //-1

StringTypeLocaleCompareExample01.htm

这个例子比较了字符串 "yellow" 和另外几个值："brick"、"yellow" 和 "zoo"。因为 "brick" 在字母表中排在 "yellow" 之前，所以 localeCompare () 返回了 1；而 "yellow" 等于 "yellow"，所以 localeCompare () 返回了 0；最后，"zoo" 在字母表中排在 "yellow" 后面，所以 localeCompare () 返回了 - 1。再强调一次，因为 localeCompare () 返回的数值取决于实现，所以最好是像下面例子所示的这样使用这个方法。

function determineOrder(value) { var result = stringValue.localeCompare(value); if (result < 0){ alert("The string 'yellow' comes before the string '" + value + "'."); } else if (result > 0) { alert("The string 'yellow' comes after the string '" + value + "'."); } else { alert("The string 'yellow' is equal to the string '" + value + "'."); } } determineOrder("brick"); determineOrder("yellow"); determineOrder("zoo");

StringTypeLocaleCompareExample01.htm

使用这种结构，就可以确保自己的代码在任何实现中都可以正确地运行了。

localeCompare () 方法比较与众不同的地方，就是实现所支持的地区（国家和语言）决定了这个方法的行为。比如，美国以英语作为 ECMAScript 实现的标准语言，因此 localeCompare () 就是区分大小写的，于是大写字母在字母表中排在小写字母前头就成为了一项决定性的比较规则。不过，在其他地区恐怕就不是这种情况了。

8. fromCharCode () 方法

另外，String 构造函数本身还有一个静态方法：fromCharCode ()。这个方法的任务是接收一或多个字符编码，然后将它们转换成一个字符串。从本质上来看，这个方法与实例方法 charCodeAt () 执行的是相反的操作。来看一个例子：

alert(String.fromCharCode(104, 101, 108, 108, 111)); //"hello"

StringTypeFromCharCodeExample01.htm

在这里，我们给 fromCharCode () 传递的是字符串 "hello" 中每个字母的字符编码。

9. HTML 方法

早期的 Web 浏览器提供商觉察到了使用 JavaScript 动态格式化 HTML 的需求。于是，这些提供商就扩展了标准，实现了一些专门用于简化常见 HTML 格式化任务的方法。下表列出了这些 HTML 方法。不过，需要请读者注意的是，应该尽量不使用这些方法，因为它们创建的标记通常无法表达语义。

方　　法 输出结果

anchor(name) <a name= "name">string</a>

big() <big>string</big>

bold() <b>string</b>

fixed() <tt>string</tt>

fontcolor(color) <font color="color">string</font>

fontsize(size) <font size="size">string</font>

italics() <i>string</i>

link(url) <a href="url">string</a>

small() <small>string</small>

strike() <strike>string</strike>

sub() <sub>string</sub>

sup() <sup>string</sup>

5.7　单体内置对象

ECMA-262 对内置对象的定义是：「由 ECMAScript 实现提供的、不依赖于宿主环境的对象，这些对象在 ECMAScript 程序执行之前就已经存在了。」意思就是说，开发人员不必显式地实例化内置对象，因为它们已经实例化了。前面我们已经介绍了大多数内置对象，例如 Object、Array 和 String。ECMA-262 还定义了两个单体内置对象：Global 和 Math。

5.7.1　Global 对象

Global（全局）对象可以说是 ECMAScript 中最特别的一个对象了，因为不管你从什么角度上看，这个对象都是不存在的。ECMAScript 中的 Global 对象在某种意义上是作为一个终极的「兜底儿对象」来定义的。换句话说，不属于任何其他对象的属性和方法，最终都是它的属性和方法。事实上，没有全局变量或全局函数；所有在全局作用域中定义的属性和函数，都是 Global 对象的属性。本书前面介绍过的那些函数，诸如 isNaN ()、isFinite ()、parseInt () 以及 parseFloat ()，实际上全都是 Global 对象的方法。除此之外，Global 对象还包含其他一些方法。

1. URI 编码方法

Global 对象的 encodeURI () 和 encodeURIComponent () 方法可以对 URI（Uniform Resource Identifiers，通用资源标识符）进行编码，以便发送给浏览器。有效的 URI 中不能包含某些字符，例如空格。而这两个 URI 编码方法就可以对 URI 进行编码，它们用特殊的 UTF-8 编码替换所有无效的字符，从而让浏览器能够接受和理解。

其中，encodeURI () 主要用于整个 URI（例如，http://www.wrox.com/illegalvalue.htm），而 encodeURIComponent () 主要用于对 URI 中的某一段（例如前面 URI 中的 illegal value.htm）进行编码。它们的主要区别在于，encodeURI () 不会对本身属于 URI 的特殊字符进行编码，例如冒号、正斜杠、问号和井字号；而 encodeURIComponent () 则会对它发现的任何非标准字符进行编码。来看下面的例子。

var uri = "http://www.wrox.com/illegal value.htm#start"; //"http://www.wrox.com/illegal%20value.htm#start" alert(encodeURI(uri)); //"http%3A%2F%2Fwww.wrox.com%2Fillegal%20value.htm%23start" alert(encodeURIComponent(uri));

GlobalObjectURIEncodingExample01.htm

使用 encodeURI () 编码后的结果是除了空格之外的其他字符都原封不动，只有空格被替换成了 %20。而 encodeURIComponent () 方法则会使用对应的编码替换所有非字母数字字符。这也正是可以对整个 URI 使用 encodeURI ()，而只能对附加在现有 URI 后面的字符串使用 encodeURIComponent () 的原因所在。

一般来说，我们使用 encodeURIComponent () 方法的时候要比使用 encodeURI () 更多，因为在实践中更常见的是对查询字符串参数而不是对基础 URI 进行编码。

与 encodeURI () 和 encodeURIComponent () 方法对应的两个方法分别是 decodeURI () 和 decodeURIComponent ()。其中，decodeURI () 只能对使用 encodeURI () 替换的字符进行解码。例如，它可将 %20 替换成一个空格，但不会对 %23 作任何处理，因为 %23 表示井字号（#），而井字号不是使用 encodeURI () 替换的。同样地，decodeURIComponent () 能够解码使用 encodeURIComponent () 编码的所有字符，即它可以解码任何特殊字符的编码。来看下面的例子：

var uri = "http%3A%2F%2Fwww.wrox.com%2Fillegal%20value.htm%23start"; //http%3A%2F%2Fwww.wrox.com%2Fillegal value.htm%23start alert(decodeURI(uri)); //http://www.wrox.com/illegal value.htm#start alert(decodeURIComponent(uri));

GlobalObjectURIDecodingExample01.htm

这里，变量 uri 包含着一个由 encodeURIComponent () 编码的字符串。在第一次调用 decodeURI () 输出的结果中，只有 %20 被替换成了空格。而在第二次调用 decodeURIComponent () 输出的结果中，所有特殊字符的编码都被替换成了原来的字符，得到了一个未经转义的字符串（但这个字符串并不是一个有效的 URI）。

URI 方法 encodeURI ()、encodeURIComponent ()、decodeURI () 和 decodeURIComponent () 用于替代已经被 ECMA-262 第 3 版废弃的 escape () 和 unescape () 方法。URI 方法能够编码所有 Unicode 字符，而原来的方法只能正确地编码 ASCII 字符。因此在开发实践中，特别是在产品级的代码中，一定要使用 URI 方法，不要使用 escape () 和 unescape () 方法。

2. eval () 方法

现在，我们介绍最后一个 —— 大概也是整个 ECMAScript 语言中最强大的一个方法：eval ()。eval () 方法就像是一个完整的 ECMAScript 解析器，它只接受一个参数，即要执行的 ECMAScript（或 JavaScript）字符串。看下面的例子：

eval("alert('hi')");

这行代码的作用等价于下面这行代码：

alert("hi");

当解析器发现代码中调用 eval () 方法时，它会将传入的参数当作实际的 ECMAScript 语句来解析，然后把执行结果插入到原位置。通过 eval () 执行的代码被认为是包含该次调用的执行环境的一部分，因此被执行的代码具有与该执行环境相同的作用域链。这意味着通过 eval () 执行的代码可以引用在包含环境中定义的变量，举个例子：

var msg = "hello world"; eval("alert(msg)"); //"hello world"

可见，变量 msg 是在 eval () 调用的环境之外定义的，但其中调用的 alert () 仍然能够显示 "hello world"。这是因为上面第二行代码最终被替换成了一行真正的代码。同样地，我们也可以在 eval () 调用中定义一个函数，然后再在该调用的外部代码中引用这个函数：

eval("function sayHi() { alert('hi'); }"); sayHi();

显然，函数 sayHi () 是在 eval () 内部定义的。但由于对 eval () 的调用最终会被替换成定义函数的实际代码，因此可以在下一行调用 sayHi ()。对于变量也一样：

eval("var msg = 'hello world'; "); alert(msg); //"hello world"

在 eval () 中创建的任何变量或函数都不会被提升，因为在解析代码的时候，它们被包含在一个字符串中；它们只在 eval () 执行的时候创建。

严格模式下，在外部访问不到 eval () 中创建的任何变量或函数，因此前面两个例子都会导致错误。同样，在严格模式下，为 eval 赋值也会导致错误：

"use strict"; eval = "hi"; //causes error

能够解释代码字符串的能力非常强大，但也非常危险。因此在使用 eval () 时必须极为谨慎，特别是在用它执行用户输入数据的情况下。否则，可能会有恶意用户输入威胁你的站点或应用程序安全的代码（即所谓的代码注入）。

3. Global 对象的属性

Global 对象还包含一些属性，其中一部分属性已经在本书前面介绍过了。例如，特殊的值 undefined、NaN 以及 Infinity 都是 Global 对象的属性。此外，所有原生引用类型的构造函数，像 Object 和 Function，也都是 Global 对象的属性。下表列出了 Global 对象的所有属性。

属　　性 说　　明 属　　性 说　　明

undefined 特殊值 undefined Date 构造函数 Date

NaN 特殊值 NaN RegExp 构造函数 RegExp

Infinity 特殊值 Infinity Error 构造函数 Error

Object 构造函数 Object EvalError 构造函数 EvalError

Array 构造函数 Array RangeError 构造函数 RangeError

Function 构造函数 Function ReferenceError 构造函数 ReferenceError

Boolean 构造函数 Boolean SyntaxError 构造函数 SyntaxError

String 构造函数 String TypeError 构造函数 TypeError

Number 构造函数 Number URIError 构造函数 URIError

ECMAScript 5 明确禁止给 undefined、NaN 和 Infinity 赋值，这样做即使在非严格模式下也会导致错误。

4. window 对象

ECMAScript 虽然没有指出如何直接访问 Global 对象，但 Web 浏览器都是将这个全局对象作为 window 对象的一部分加以实现的。因此，在全局作用域中声明的所有变量和函数，就都成为了 window 对象的属性。来看下面的例子。

var color = "red"; function sayColor(){ alert(window.color); } window.sayColor(); //"red"

GlobalObjectWindowExample01.htm

这里定义了一个名为 color 的全局变量和一个名为 sayColor () 的全局函数。在 sayColor () 内部，我们通过 window.color 来访问 color 变量，以说明全局变量是 window 对象的属性。然后，又使用 window.sayColor () 来直接通过 window 对象调用这个函数，结果显示在了警告框中。

JavaScript 中的 window 对象除了扮演 ECMAScript 规定的 Global 对象的角色外，还承担了很多别的任务。第 8 章在讨论浏览器对象模型时将详细介绍 window 对象。

另一种取得 Global 对象的方法是使用以下代码：

var global = function(){ return this; }();

以上代码创建了一个立即调用的函数表达式，返回 this 的值。如前所述，在没有给函数明确指定 this 值的情况下（无论是通过将函数添加为对象的方法，还是通过调用 call () 或 apply ()），this 值等于 Global 对象。而像这样通过简单地返回 this 来取得 Global 对象，在任何执行环境下都是可行的。第 7 章将深入讨论函数表达式。

5.7.2　Math 对象

ECMAScript 还为保存数学公式和信息提供了一个公共位置，即 Math 对象。与我们在 JavaScript 直接编写的计算功能相比，Math 对象提供的计算功能执行起来要快得多。Math 对象中还提供了辅助完成这些计算的属性和方法。

1. Math 对象的属性

Math 对象包含的属性大都是数学计算中可能会用到的一些特殊值。下表列出了这些属性。

属　　性 说　　明

Math.E 自然对数的底数，即常量 e 的值

Math.LN10 10 的自然对数

Math.LN2 2 的自然对数

Math.LOG2E 以 2 为底 e 的对数

Math.LOG10E 以 10 为底 e 的对数

Math.PI π 的值

Math.SQRT1_2 1/2 的平方根（即 2 的平方根的倒数）

Math.SQRT2 2 的平方根

虽然讨论这些值的含义和用途超出了本书范围，但你确实可以随时使用它们。

2. min () 和 max () 方法

Math 对象还包含许多方法，用于辅助完成简单和复杂的数学计算。

其中，min () 和 max () 方法用于确定一组数值中的最小值和最大值。这两个方法都可以接收任意多个数值参数，如下面的例子所示。

var max = Math.max(3, 54, 32, 16); alert(max); //54 var min = Math.min(3, 54, 32, 16); alert(min); //3

MathObjectMinMaxExample01.htm

对于 3、54、32 和 16，Math.max () 返回 54，而 Math.min () 返回 3。这两个方法经常用于避免多余的循环和在 if 语句中确定一组数的最大值。

要找到数组中的最大或最小值，可以像下面这样使用 apply () 方法。

var values = [1, 2, 3, 4, 5, 6, 7, 8]; var max = Math.max.apply(Math, values);

这个技巧的关键是把 Math 对象作为 apply () 的第一个参数，从而正确地设置 this 值。然后，可以将任何数组作为第二个参数。

3. 舍入方法

下面来介绍将小数值舍入为整数的几个方法：Math.ceil ()、Math.floor () 和 Math.round ()。这三个方法分别遵循下列舍入规则：

Math.ceil () 执行向上舍入，即它总是将数值向上舍入为最接近的整数；

Math.floor () 执行向下舍入，即它总是将数值向下舍入为最接近的整数；

Math.round () 执行标准舍入，即它总是将数值四舍五入为最接近的整数（这也是我们在数学课上学到的舍入规则）。

下面是使用这些方法的示例：

alert(Math.ceil(25.9)); //26 alert(Math.ceil(25.5)); //26 alert(Math.ceil(25.1)); //26 alert(Math.round(25.9)); //26 alert(Math.round(25.5)); //26 alert(Math.round(25.1)); //25 alert(Math.floor(25.9)); //25 alert(Math.floor(25.5)); //25 alert(Math.floor(25.1)); //25

MathObjectRoundingExample01.htm

对于所有介于 25 和 26（不包括 26）之间的数值，Math.ceil () 始终返回 26，因为它执行的是向上舍入。Math.round () 方法只在数值大于等于 25.5 时返回 26；否则返回 25。最后，Math.floor () 对所有介于 25 和 26（不包括 26）之间的数值都返回 25。

4. random () 方法

Math.random () 方法返回介于 0 和 1 之间一个随机数，不包括 0 和 1。对于某些站点来说，这个方法非常实用，因为可以利用它来随机显示一些名人名言和新闻事件。套用下面的公式，就可以利用 Math.random () 从某个整数范围内随机选择一个值。

值 = Math.floor (Math.random () * 可能值的总数 + 第一个可能的值)

公式中用到了 Math.floor () 方法，这是因为 Math.random () 总返回一个小数值。而用这个小数值乘以一个整数，然后再加上一个整数，最终结果仍然还是一个小数。举例来说，如果你想选择一个 1 到 10 之间的数值，可以像下面这样编写代码：

var num = Math.floor(Math.random() * 10 + 1);

MathObjectRandomExample01.htm

总共有 10 个可能的值（1 到 10），而第一个可能的值是 1。而如果想要选择一个介于 2 到 10 之间的值，就应该将上面的代码改成这样：

var num = Math.floor(Math.random() * 9 + 2);

MathObjectRandomExample02.htm

从 2 数到 10 要数 9 个数，因此可能值的总数就是 9，而第一个可能的值就是 2。多数情况下，其实都可以通过一个函数来计算可能值的总数和第一个可能的值，例如：

function selectFrom (lowerValue, upperValue) {var choices = upperValue - lowerValue + 1; return Math.floor (Math.random () * choices + lowerValue); } var num = selectFrom (2, 10); alert (num); // 介于 2 和 10 之间（包括 2 和 10）的一个数值

MathObjectRandomExample03.htm

函数 selectFrom () 接受两个参数：应该返回的最小值和最大值。而用最大值减最小值再加 1 得到了可能值的总数，然后它又把这些数值套用到了前面的公式中。这样，通过调用 selectFrom (2,10) 就可以得到一个介于 2 和 10 之间（包括 2 和 10）的数值了。利用这个函数，可以方便地从数组中随机取出一项，例如：

var colors = ["red", "green", "blue", "yellow", "black", "purple", "brown"]; var color = colors [selectFrom (0, colors.length-1)]; alert (color); // 可能是数组中包含的任何一个字符串

MathObjectRandomExample03.htm

在这个例子中，传递给 selectFrom () 的第二个参数是数组的长度减 1，也就是数组中最后一项的位置。

5. 其他方法

Math 对象中还包含其他一些与完成各种简单或复杂计算有关的方法，但详细讨论其中每一个方法的细节及适用情形超出了本书的范围。下面我们就给出一个表格，其中列出了这些没有介绍到的 Math 对象的方法。

方　　法 说　　明 方　　法 说　　明

Math.abs (num) 返回 num 的绝对值 Math.asin (x) 返回 x 的反正弦值

Math.exp (num) 返回 Math.E 的 num 次幂 Math.atan (x) 返回 x 的反正切值

Math.log (num) 返回 num 的自然对数 Math.atan2 (y,x) 返回 y/x 的反正切值

Math.pow (num,power) 返回 num 的 power 次幂 Math.cos (x) 返回 x 的余弦值

Math.sqrt (num) 返回 num 的平方根 Math.sin (x) 返回 x 的正弦值

Math.acos (x) 返回 x 的反余弦值 Math.tan (x) 返回 x 的正切值

虽然 ECMA-262 规定了这些方法，但不同实现可能会对这些方法采用不同的算法。毕竟，计算某个值的正弦、余弦和正切的方式多种多样。也正因为如此，这些方法在不同的实现中可能会有不同的精度。

