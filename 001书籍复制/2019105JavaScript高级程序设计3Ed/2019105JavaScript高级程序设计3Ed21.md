通常，这个方法会在修改相应命名空间下的元素标签名或特性名时用到。如果该名称不属于任何命名空间，则可以像下面这样使用 setLocalName () 方法来修改内部名称：

xml.setLocalName("newtagname");

19.2　一般用法

在将 XML 对象、元素、特性和文本集合到一个层次化对象之后，就可以使用点号加特性或标签名的方式来访问其中不同的层次和结构。每个子元素都是父元素的一个属性，而属性名与元素的内部名称相同。如果子元素只包含文本，则相应的属性只返回文本，如下面的例子所示。

var employee = <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee>; alert(employee.name); //"Nicholas C. Zakas"

以上代码中的 <name/> 元素只包含文本。访问 employee.name 即可取得该文本，而在内部需要定位到 <name/> 元素，然后返回相应文本。由于传入到 alert () 时，会隐式调用 toString () 方法，因此显示的是 <name/> 中包含的文本。这就使得访问 XML 文档中包含的文本数据非常方便。如果有多个元素具有相同的标签名，则会返回 XMLList。下面再看一个例子。

var employees = <employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees>; alert(employees.employee[0].name); //"Nicholas C. Zakas" alert(employees.employee[1].name); //"Jim Smith"

这个例子访问了每个 <employee/> 元素并返回了它们 <name/> 元素的值。如果你不确定子元素的内部名称，或者你想访问所有子元素，不管其名称是什么，也可以像下面这样使用星号（*）。

var allChildren = employees.*; // 返回所有子元素，不管其名称是什么 alert (employees.*[0].name); //"Nicholas C. Zakas"

UsageExample01.htm/I>

与其他属性一样，星号也可能返回 XML 对象，或返回 XMLList 对象，这要取决于 XML 结构。

要达到同样的目的，除了属性之外，还可以使用 child () 方法。将属性名或索引值传递给 child () 方法，也会得到相同的值。来看下面的例子。

var firstChild = employees.child (0); // 与 employees.*[0] 相同 var employeeList = employees.child ("employee"); // 与 employees.employee 相同 var allChildren = employees.child ("*"); // 与 employees.* 相同

为了再方便一些，还有一个 children () 方法始终返回所有子元素。例如：

var allChildren = employees.children (); // 与 employees.* 相同

而另一个方法 elements () 的行为与 child () 类似，区别仅在于它只返回表示元素的 XML 对象。例如：

var employeeList = employees.elements ("employee"); // 与 employees.employee 相同 var allChildren = employees.elements ("*"); // 与 employees.* 相同

这些方法为 JavaScript 开发人员提供了访问 XML 数据的较为熟悉的语法。

要删除子元素，可以使用 delete 操作符，如下所示：

delete employees.employee[0]; alert(employees.employee.length()); //1

显然，这也正是将子节点看成属性的一个主要的优点。

19.2.1　访问特性

访问特性也可以使用点语法，不过其语法稍有扩充。为了区分特性名与子元素的标签名，必须在名称前面加上一个 @字符。这是从 XPath 中借鉴的语法；XPath 也是使用 @来区分特性和标签的名称。不过，结果可能就是这种语法看起来比较奇怪，例如：

var employees = <employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees>; alert(employees.employee[0].@position); //"Software Engineer"

AttributesExample01.htm

与元素一样，每个特性都由一个属性来表示，而且可以通过这种简写语法来访问。以这种语法访问特性会得到一个表示特性的 XML 对象，对象的 toString () 方法始终会返回特性的值。要取得特性的名称，可以使用对象的 name () 方法。

另外，也可以使用 child () 方法来访问特性，只要传入带有 @前缀的特性的名称即可。

alert(employees.employee[0].child("@position")); //"Software Engineer"

AttributesExample01.htm

由于访问 XML 对象的属性时也可以使用 child ()，因此必须使用 @字符来区分标签名和特性名。

使用 attribute () 方法并传入特性名，可以只访问 XML 对象的特性。与 child () 方法不同，使用 attribute () 方法时，不需要传入带 @字符的特性名。下面是一个例子。

alert(employees.employee[0].attribute("position")); //"Software Engineer"

AttributesExample01.htm

这三种访问特性的方式同时适用于 XML 和 XMLList 类型。对于 XML 对象来说，会返回一个表示相应特性的 XML 对象；对 XMLList 对象来说，会返回一个 XMLList 对象，其中包含列表中所有元素的特性 XML 对象。对于前面的例子而言，employees.employee.@position 返回的 XMLList 将包含两个对象：一个对象表示第一个 <employee/> 元素中的 position 特性，另一个对象表示第二个元素中的同一特性。

要取得 XML 或 XMLList 对象中的所有特性，可以使用 attributes () 方法。这个方法会返回一个表示所有特性的 XMLList 对象。使用这个方法与使用 @* 的结果相同，如下面的例子所示。

// 下面两种方式都会取得所有特性 var atts1 = employees.employee [0].@*; var atts2 = employees.employee [0].attributes ();

在 E4X 中修改特性的值与修改属性的值一样非常简单，只要像下面这样为特性指定一个新值即可。

employees.employee [0].@position = "Author"; // 修改 position 特性

修改的特性会在内部反映出来，换句话说，此后再序列化 XML 对象，就会使用新的特性值。同样，为特性赋值的语法也可以用来添加新特性，如下面的例子所示。

employees.employee [0].@experience = "8 years"; // 添加 experience 特性 employees.employee [0].@manager = "Jim Smith"; // 添加 manager 特性

由于特性与其他 ECMAScript 属性类似，因此也可以使用 delete 操作符来删除特性，如下所示。

delete employees.employee [0].@position; // 删除 position 特性

通过属性来访问特性极大地简化了与底层 XML 结构交互的操作。

19.2.2　其他节点类型

E4X 定义了表现 XML 文档中所有部分的类型，包括注释和处理指令。在默认情况上，E4X 不会解析注释或处理指令，因此这些部分不会出现在最终的对象层次中。如果想让解析器解析这些部分，可以像下面这样设置 XML 构造函数的下列两个属性。

XML.ignoreComments = false; XML.ignoreProcessingInstructions = false;

在设置了这两个属性之后，E4X 就会将注释和处理指令解析到 XML 结构中。

由于 XML 类型可以表示所有节点，因此必须有一种方式来确定节点类型。使用 nodeKind () 方法可以得到 XML 对象表示的类型，该访问可能会返回 "text"、"element"、"comment"、"processinginstruction" 或 "attribute"。以下面的 XML 对象为例。

var employees = <employees> <?Dont forget the donuts?> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <!--just added--> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees> ;

我们可以通过下面的表格来说明 nodeKind () 返回的节点类型。

语　　句 返　回　值

employees.nodeKind() "element"

employees.*[0].nodeKind() "processing-instruction"

employees.employee[0].@position.nodeKind() "attribute"

employees.employee[0].nodeKind() "element"

employees.*[2].nodeKind() "comment"

employees.employee[0].name.*[0].nodeKind() "text"

不能在包含多个 XML 对象的 XMLList 上调用 nodeKind () 方法；否则，会抛出一个错误。

可以只取得特定类型的节点，而这就要用到下列方法。

attributes ()：返回 XML 对象的所有特性。

comments ()：返回 XML 对象的所有子注释节点。

elements (tagName)：返回 XML 对象的所有子元素。可以通过提供元素的 tagName（标签名）来过滤想要返回的结果。

processingInstructions (name)：返回 XML 对象的所有处理指令。可以通过提供处理指令的 name（名称）来过滤想要返回的结果。

text ()：返回 XML 对象的所有文本子节点。

上述的每一个方法都返回一个包含适当 XML 对象的 XMLList。

使用 hasSimpleContent () 和 hasComplexContent () 方法，可以确定 XML 对象中是只包含文本，还是包含更复杂的内容。如果 XML 对象中只包含子文本节点，则前一个方法会返回 true；如果 XML 对象的子节点中有任何非文本节点，则后一个方法返回 true。来看下面的例子。

alert(employees.employee[0].hasComplexContent()); //true alert(employees.employee[0].hasSimpleContent()); //false alert(employees.employee[0].name.hasComplexContent()); //false alert(employees.employee[0].name.hasSimpleContent()); //true

利用这些方法，以及前面提到的其他方法，可以极大地方便查找 XML 结构中的数据。

19.2.3　查询

实际上，E4X 提供的查询语法在很多方面都与 XPath 类似。取得元素或特性值的简单操作是最基本的查询。在查询之前，不会创建表现 XML 文档结构中不同部分的 XML 对象。从底层来看，XML 和 XMLList 的所有属性事实上都是查询的结果。也就是说，引用不表现 XML 结构中某一部分的属性仍然会返回 XMLList；只不过这个 XMLList 中什么也不会包含。例如，如果基于前面的 XML 示例执行下列代码，则返回的结果就是空的。

var cats = employees.cat; alert(cats.length()); //0

QueryingExample01.htm

这个查询想要查找 <employees/> 中的 <cat/> 元素，但这个元素并不存在。上面的第一行代码会返回一个空的 XMLList 对象。虽然返回的是空对象，但查询可以照常进行，而不会发生异常。

前面我们看到的大多数例子都使用点语法来访问直接的子节点。而像下面这样使用两个点，则可以进一步扩展查询的深度，查询到所有后代节点。

var allDescendants = employees..*; // 取得 <employees/> 的所有后代节点

上面的代码会返回 <employees/> 元素的所有后代节点。结果中将会包含元素、文本、注释和处理指令，最后两种节点的有无取决于在 XML 构造函数上的设置（前面曾经讨论过）；但结果中不会包含特性。要想取得特定标签的元素，需要将星号替换成实际的标签名。

var allNames = employees..name; // 取得作为 <employees/> 后代的所有 <name/> 节点

同样的查询可以使用 descendants () 方法来完成。在不给这个方法传递参数的情况下，它会返回所有后代节点（与使用..* 相同），而传递一个名称作为参数则可以限制结果。下面就是这两种情况的例子。

var allDescendants = employees.descendants (); // 所有后代节点 var allNames = employees.descendants ("name"); // 后代中的所有 <name/> 元素

还可以取得所有后代元素中的所有特性，方法是使用下列任何一行代码。

var allAttributes = employees..@*; // 取得所有后代元素中的所有特性 var allAttributes2 = employees.descendants ("@*"); // 同上

与限制结果中的后代元素一样，也可以通过用完整的特性名来替换星号达到过滤特性的目的。例如：

var allAttributes = employees..@position; // 取得所有 position 特性 var allAttributes2 = employees.descendants ("@position"); // 同上

除了访问后代元素之外，还可以指定查询的条件。例如，要想返回 position 特性值为 "Salesperson" 的所有 <employee/> 元素，可以使用下面的查询：

var salespeople = employees.employee.(@position == "Salesperson");

同样的语法也可以用于修改 XML 结构中的某一部分。例如，可以将第一位销售员（salesperson）的 position 特性修改为 "Senior Salesperson"，代码如下：

employees.employee.(@position == "Salesperson")[0].@position= "Senior Salesperson";

注意，圆括号中的表达式会返回一个包含结果的 XMLList，而方括号返回其中的第一项，然后我们重写了 @position 属性的值。

使用 parent () 方法能够在 XML 结构中上溯，这个方法会返回一个 XML 对象，表示当前 XML 对象的父元素。如果在 XMLList 上调用 parent () 方法，则会返回列表中所有对象的公共父元素。下面是一个例子。

var employees2 = employees.employee.parent();

这里，变量 employees2 中包含着与变量 employees 相同的值。在处理来源未知的 XML 对象时，经常会用到 parent () 方法。

19.2.4　构建和操作 XML

将 XML 数据转换成 XML 对象的方式有很多种。前面曾经讨论过，可以将 XML 字符串传递到 XML 构造函数中，也可以使用 XML 字面量。相对而言，XML 字面量方式更方便一些，因为可以在字面量中嵌入 JavaScript 变量，语法是使用花括号（{}）。可以将 JavaScript 变量嵌入到字面量中的任意位置上，如下面的例子所示。

var tagName = "color"; var color = "red"; var xml = <{tagName}>{color}</{tagName}>; alert(xml.toXMLString()); //"<color>red</color>

XMLConstructionExample01.htm

在这个例子中，XML 字面量的标签名和文本值都是使用花括号语法插入的。有了这个语法，就可以省去在构建 XML 结构时拼接字符串的麻烦。

E4X 也支持使用标准的 JavaScript 语法来构建完整的 XML 结构。如前所述，大多数必要的操作都是查询，而且即便元素或特性不存在也不会抛出错误。在此基础上更进一步，如果将一个值指定给一个不存在的元素或特性，E4X 就会首先在底层创建相应的结构，然后完成赋值。来看下面的例子。

var employees = <employees/>; employees.employee.name = "Nicholas C. Zakas"; employees.employee.@position = "Software Engineer";

XMLConstructionExample02.htm

这个例子一开始声明了 <employees/> 元素，然后在这个元素基础上开始构建 XML 结构。第二行代码在 <employees/> 中创建了一个 <employee/> 元素和一个 <name/> 元素，并指定了文本值。第三行代码添加了一个 position 特性并为该特性指定了值。此时构建的 XML 结构如下所示。

<employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> </employees>

当然，使用加号操作符也可以再添加一个 <employee/> 元素，如下所示。

employees.employee += <employee position="Salesperson"> <name>Jim Smith</name> </employee>;

XMLConstructionExample02.htm

最终构建的 XML 结构如下所示：

<employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees>

除了上面介绍的基本的 XML 构建语法之外，还有一些类似 DOM 的方法，简介如下。

appendChild (child)：将给定的 child 作为子节点添加到 XMLList 的末尾。

copy ()：返回 XML 对象副本。

insertChildAfter (refNode, child)：将 child 作为子节点插入到 XMLList 中 refNode 的后面。

insertChildBefore (refNode, child)：将 child 作为子节点插入到 XMLList 中 refNode 的前面。

prependChild (child)：将给定的 child 作为子节点添加到 XMLList 的开始位置。

replace (propertyName, value)：用 value 值替换名为 propertyName 的属性，这个属性可能是一个元素，也可能是一个特性。

setChildren (children)：用 children 替换当前所有的子元素，children 可以是 XML 对象，也可是 XMLList 对象。

这些方法既非常有用，也非常容易使用。下列代码展示了这些方法的用途。

var employees = <employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees>; employees.appendChild(<employee position="Vice President"> <name>Benjamin Anderson</name> </employee>); employees.prependChild(<employee position="User Interface Designer"> <name>Michael Johnson</name> </employee>); employees.insertChildBefore(employees.child(2), <employee position="Human Resources Manager"> <name>Margaret Jones</name> </employee>); employees.setChildren(<employee position="President"> <name>Richard McMichael</name> </employee> + <employee position="Vice President"> <name>Rebecca Smith</name> </employee>);

XMLConstructionExample03.htm

以上代码首先在员工列表的底部添加了一个名为 Benjamin Anderson 的副总统（vice president）。然后，在员工列表顶部又添加了一个名为 Michael Johnson 的界面设计师。接着，在列表中位置为 2 的员 工 —— 此时这个员工是 Jim Smith，因为他前面还有 Michael Johnson 和 Nicholas C. Zakas—— 之前又添加了一个名为 Margaret Jones 的人力资源部经理。最后，所有这些子元素都被总统 Richard McMichael 和副总统 Rebecca Smith 替代。结果 XML 如下所示。

<employees> <employee position="President"> <name>Richard McMichael</name> </employee> <employee position="Vice President"> <name>Rebecca Smith</name> </employee> </employees>

熟练运用这些技术和方法，就能够使用 E4X 执行任何 DOM 风格的操作。

19.2.5　解析和序列化

E4X 将解析和序列化数据的控制放在了 XML 构造函数的一些设置当中。与 XML 解析相关的设置有如下三个。

ignoreComments：表示解析器应该忽略标记中的注释。默认设置为 true。

ignoreProcessingInstructions：表示解析器应该忽略标记中的处理指令。默认设置为 true。

ignoreWhitespace：表示解析器应该忽略元素间的空格，而不是创建表现这些空格的文本节点。默认设置为 true。

这三个设置会影响对传入到 XML 构造函数中的字符串以及 XML 字面量的解析。

另外，与 XML 数据序列化相关的设置有如下两个。

prettyIndent：表示在序列化 XML 时，每次缩进的空格数量。默认值为 2。

prettyPrinting：表示应该以方便人类认读的方式输出 XML，即每个元素重起一行，而且子元素都要缩进。默认设置为 true。

这两个设置将影响到 toString () 和 toXMLString () 的输出。

以上五个设置都保存在 settings 对象中，通过 XML 构造函数的 settings () 方法可以取得这个对象，如下所示。

var settings = XML.settings(); alert(settings.ignoreWhitespace); //true alert(settings.ignoreComments); //true

ParsingAndSerializationExample01.htm

通过向 setSettings () 方法中传入包含全部 5 项设置的对象，可以一次性指定所有设置。在需要临时改变设置的情况下，这种设置方式非常有用，如下所示。

var settings = XML.settings (); XML.prettyIndent = 8; XML.ignoreComments = false; // 执行某些处理 XML.setSettings (settings); // 重置前面的设置

而使用 defaultSettings () 方法则可以取得一个包含默认设置的对象，因此任何时候都可以使用下面的代码重置设置。

XML.setSettings(XML.defaultSettings());

19.2.6　命名空间

E4X 提供了方便使用命名空间的特性。前面曾经讨论过，使用 namspace () 方法可以取得与特定前缀对应的 Namespace 对象。而通过使用 setNamespace () 并传入 Namespace 对象，也可以为给定元素设置命名空间。来看下面的例子。

var messages = <messages> <message>Hello world!</message> </messages>; messages.setNamespace(new Namespace("wrox", "http://www.wrox.com/"));

调用 setNamespace () 方法后，相应的命名空间只会应用到调用这个方法的元素。此时，序列化 messages 变量会得到如下结果。

<wrox:messages xmlns:wrox="http://www.wrox.com/"> <message>Hello world!</message> </wrox:messages>

可见，由于调用了 setNamespace () 方法，<messages/> 元素有了 wrox 命名空间前缀，而 <message/> 元素则没有变化。

如果只想添加一个命名空间声明，而不想改变元素，可以使用 addNamespace () 方法并传入 Namespace 对象，如下面的例子所示。

messages.addNamespace(new Namespace("wrox", "http://www.wrox.com/"));

在将这行代码应用于原先的 <messages/> 元素时，就会创建如下所示的 XML 结构。

<messages xmlns:wrox="http://www.wrox.com/"> <message>Hello world!</message> </messages>

调用 removeNamespace () 方法并传入 Namespace 对象，可以移除表示特定命名空间前缀和 URI 的命名空间声明；注意，必须传入丝毫不差的表示命名空间的 Namespace 对象。例如：

messages.removeNamespace(new Namespace("wrox", "http://www.wrox.com/"));

这行代码可以移除 wrox 命名空间。不过，引用前缀的限定名不会受影响。

有两个方法可以返回与节点相关的 Namespace 对象的数组：namespaceDeclarations () 和 inScopeNamespaces ()。前者返回在给定节点上声明的所有命名空间的数组，后者返回位于给定节点作用域中（即包括在节点自身和祖先元素中声明的）所有命名空间的数组。如下面的例子所示：

var messages = <messages xmlns:wrox="http://www.wrox.com/"> <message>Hello world!</message> </messages>; alert(messages.namespaceDeclarations()); //"http://www.wrox.com" alert(messages.inScopeNamespaces()); //",http://www.wrox.com" alert(messages.message.namespaceDeclarations()); //"" alert(messages.message.inScopeNamespaces()); //",http://www.wrox.com"

这里，<messages/> 元素在调用 namespaceDeclarations () 时，会返回包含一个命名空间的数组，而在调用 inScopeNamespaces () 时，则会返回包含两个命名空间的数组。作用域中的这两个命名空间，分别是默认命名空间（由空字符串表示）和 wrox 命名空间。在 <message/> 元素上调用这些方法时，namespaceDeclarations ()，会返回一个空数组，而 inScopeNamespaces () 方法返回的结果与在 <messages/> 元素上调用时的返回结果相同。

使用双冒号（::）也可以基于 Namespace 对象来查询 XML 结构中具有特定命名空间的元素。例如，要取得包含在 wrox 命名空间中的所有 <message/> 元素，可以参考下面的代码。

var messages = <messages xmlns:wrox="http://www.wrox.com/"> <wrox:message>Hello world!</message> </messages>; var wroxNS = new Namespace("wrox", "http://www.wrox.com/"); var wroxMessages = messages.wroxNS::message;

这里的双冒号表示返回的元素应该位于其中的命名空间。注意，这里使用的是 JavaScript 变量，而不是命名空间前缀。

还可以为某个作用域中的所有 XML 对象设置默认命名空间。为此，要使用 default xml namespace 语句，并将一个 Namespace 对象或一个命名空间 URI 作为值赋给它。例如：

default xml namespace = "http://www.wrox.com/"; function doSomething (){ // 只为这个函数设置默认的命名空间 default xml namespace = new Namespace ("your", "http://www.yourdomain.com"); }

在 doSomething () 函数体内设置默认命名空间并不会改变全局作用域中的默认 XML 命名空间。在给定作用域中，当所有 XML 数据都需要使用特定的命名空间时，就可以使用这个语句，从而避免多次引用命名空间的麻烦。

19.3　其他变化

为了与 ECMAScript 做到无缝集成，E4X 也对语言基础进行了一些修改。其中之一就是引入了 for-each-in 循环，以便迭代遍历每一个属性并返回属性的值，如下面的例子所示。

var employees = <employees> <employee position="Software Engineer"> <name>Nicholas C. Zakas</name> </employee> <employee position="Salesperson"> <name>Jim Smith</name> </employee> </employees>; for each (var child in employees){ alert(child.toXMLString()); }

ForEachInExample01.htm

在这个例子的 for-each-in 循环中，<employees/> 的每个子节点会依次被赋值给 child 变量，其中包括注释、处理指令和 / 或文本节点。要想返回特性节点，则需要对一个由特性节点组成的 XMLList 对象进行操作，如下所示。

for each (var attribute in employees.@*){// 遍历特性 alert (attribute); }

虽然 for-each-in 循环是在 E4X 中定义的，但这个语句也可以用于常规的数组和对象，例如：

var colors = ["red","green","blue"]; for each(var color in colors){ alert(color); }

ForEachInExample01.htm

对于数组，for-each-in 循环会返回数组中的每一项。对于非 XML 对象，这个循环返回对象每个属性的值。

E4X 还添加了一个全局函数，名叫 isXMLName ()。这个函数接受一个字符串，并在这个字符串是元素或特性的有效内部名称的情况下返回 true。在使用未知字符串构建 XML 数据结构时，这个函数可以为开发人员提供方便。来看下面的例子。

alert(isXMLName("color")); //true alert(isXMLName("hello world")); //false

如果你不确定某个字符串的来源，而又需要将该字符串用作一个内部名称，那么最好在使用它之前先通过 isXMLName () 检测一下是否有效，以防发生错误。

E4X 对标准 ECMAScript 的最后一个修改是 typeof 操作符。在对 XML 对象或 XMLList 对象使用这个操作符时，typeof 返回字符串 "xml"。但在对其他对象使用这个操作符时，返回的都是 "object"，例如：

var xml = new XML(); var list = new XMLList(); var object = {}; alert(typeof xml); //"xml" alert(typeof list); //"xml" alert(typeof object); //"object"

多数情况下，都没有必要区分 XML 和 XMLList 对象。在 E4X 中，这两个对象都被看成是基本数据类型，因而也无法通过 instanceof 操作符来将它们区分开来。

19.4　全面启用 E4X

鉴于 E4X 在很多方面给标准 JavaScript 带来了不同，因此 Firefox 在默认情况下只启用 E4X 中与其他代码能够相安无事的那些特性。要想完整地启用 E4X，需要将 <script> 标签的 type 特性设置为 "text/javascript;e4x=1"，例如：

<script type="text/javascript;e4x=1" src="e4x_file.js"></script>

在打开这个「开关」之后，就会全面启用 E4X，从而能够正确地解析嵌入在 E4X 字面量中的注释和 CData 片段。在没有完整启用 E4X 的情况下使用注释和 / 或 CData 片段会导致语法错误。

19.5　小结

E4X 是以 ECMA-357 标准的形式发布的对 ECMAScript 的一个扩展。E4X 的目的是为操作 XML 数据提供与标准 ECMAScript 更相近的语法。E4X 具有下列特征。

与 DOM 不同，E4X 只用一个类型来表示 XML 中的各种节点。

XML 对象中封装了对所有节点都有用的数据和行为。为表现多个节点的集合，这个规范定义了 XMLList 类型。

另外两个类型，Namespace 和 QName，分别表现命名空间和限定名。

为便于查询 XML 结构，E4X 还修改了标准了的 ECMAScript 语法，修改的地方如下。

使用两个点（..）表示要匹配所有后代元素，使用 @字符表示应该返回一或多个特性。

星号字符（*）是一个通配符，可以匹配任意类型的节点。

所有这些查询都可以通过一组执行相同操作的方法来实现。

到 2011 年底，Firefox 还是唯一一个支持 E4X 的浏览器。尽管没有其他浏览器提供商承诺会实现 E4X，但在服务器上，由于 BEA Workshop for WebLogic 和 Yhaoo! YQL 的推动，E4X 已经取得了不小的成功。

第 20 章　JSON

本章内容

理解 JSON 语法

解析 JSON

序列化 JSON

曾经有一段时间，XML 是互联网上传输结构化数据的事实标准。Web 服务的第一次浪潮很大程度上都是建立在 XML 之上的，突出的特点是服务器与服务器间通信。然而，业界一直不乏质疑 XML 的声音。不少人认为 XML 过于烦琐、冗长。为解决这个问题，也涌现了一些方案。不过，Web 的发展方向已经改变了。

2006 年，Douglas Crockford 把 JSON（JavaScript Object Notation，JavaScript 对象表示法）作为 IETF RFC 4627 提交给 IETF，而 JSON 的应用早在 2001 年就已经开始了。JSON 是 JavaScript 的一个严格的子集，利用了 JavaScript 中的一些模式来表示结构化数据。Crockford 认为与 XML 相比，JSON 是在 JavaScript 中读写结构化数据的更好的方式。因为可以把 JSON 直接传给 eval ()，而且不必创建 DOM 对象。

关于 JSON，最重要的是要理解它是一种数据格式，不是一种编程语言。虽然具有相同的语法形式，但 JSON 并不从属于 JavaScript。而且，并不是只有 JavaScript 才使用 JSON，毕竟 JSON 只是一种数据格式。很多编程语言都有针对 JSON 的解析器和序列化器。

20.1　语法

JSON 的语法可以表示以下三种类型的值。

简单值：使用与 JavaScript 相同的语法，可以在 JSON 中表示字符串、数值、布尔值和 null。但 JSON 不支持 JavaScript 中的特殊值 undefined。

对象：对象作为一种复杂数据类型，表示的是一组有序的键值对儿。而每个键值对儿中的值可以是简单值，也可以是复杂数据类型的值。

数组：数组也是一种复杂数据类型，表示一组有序的值的列表，可以通过数值索引来访问其中的值。数组的值也可以是任意类型 —— 简单值、对象或数组。

JSON 不支持变量、函数或对象实例，它就是一种表示结构化数据的格式，虽然与 JavaScript 中表示数据的某些语法相同，但它并不局限于 JavaScript 的范畴。

20.1.1　简单值

最简单的 JSON 数据形式就是简单值。例如，下面这个值是有效的 JSON 数据：

5

这是 JSON 表示数值 5 的方式。类似地，下面是 JSON 表示字符串的方式：

"Hello world!"

JavaScript 字符串与 JSON 字符串的最大区别在于，JSON 字符串必须使用双引号（单引号会导致语法错误）。

布尔值和 null 也是有效的 JSON 形式。但是，在实际应用中，JSON 更多地用来表示更复杂的数据结构，而简单值只是整个数据结构中的一部分。

20.1.2　对象

JSON 中的对象与 JavaScript 字面量稍微有一些不同。下面是一个 JavaScript 中的对象字面量：

var person = { name: "Nicholas", age: 29 };

这虽然是开发人员在 JavaScript 中创建对象字面量的标准方式，但 JSON 中的对象要求给属性加引号。实际上，在 JavaScript 中，前面的对象字面量完全可以写成下面这样：

var object = { "name": "Nicholas", "age": 29 };

JSON 表示上述对象的方式如下：

{ "name": "Nicholas", "age": 29 }

与 JavaScript 的对象字面量相比，JSON 对象有两个地方不一样。首先，没有声明变量（JSON 中没有变量的概念）。其次，没有末尾的分号（因为这不是 JavaScript 语句，所以不需要分号）。再说一遍，对象的属性必须加双引号，这在 JSON 中是必需的。属性的值可以是简单值，也可以是复杂类型值，因此可以像下面这样在对象中嵌入对象：

{ "name": "Nicholas", "age": 29, "school": { "name": "Merrimack College", "location": "North Andover, MA" } }

这个例子在顶级对象中嵌入了学校（"school"）信息。虽然有两个 "name" 属性，但由于它们分别属于不同的对象，因此这样完全没有问题。不过，同一个对象中绝对不应该出现两个同名属性。

与 JavaScript 不同，JSON 中对象的属性名任何时候都必须加双引号。手工编写 JSON 时，忘了给对象属性名加双引号或者把双引号写成单引号都是常见的错误。

20.1.3　数组

JSON 中的第二种复杂数据类型是数组。JSON 数组采用的就是 JavaScript 中的数组字面量形式。例如，下面是 JavaScript 中的数组字面量：

var values = [25, "hi", true];

在 JSON 中，可以采用同样的语法表示同一个数组：

[25, "hi", true]

同样要注意，JSON 数组也没有变量和分号。把数组和对象结合起来，可以构成更复杂的数据集合，例如：

[ { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011 }, { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 2, year: 2009 }, { "title": "Professional Ajax", "authors": [ "Nicholas C. Zakas", "Jeremy McPeak", "Joe Fawcett" ], edition: 2, year: 2008 }, { "title": "Professional Ajax", "authors": [ "Nicholas C. Zakas", "Jeremy McPeak", "Joe Fawcett" ], edition: 1, year: 2007 }, { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 1, year: 2006 } ]

这个数组中包含一些表示图书的对象。每个对象都有几个属性，其中一个属性是 "authors"，这个属性的值又是一个数组。对象和数组通常是 JSON 数据结构的最外层形式（当然，这不是强制规定的），利用它们能够创造出各种各样的数据结构。

20.2　解析与序列化

JSON 之所以流行，拥有与 JavaScript 类似的语法并不是全部原因。更重要的一个原因是，可以把 JSON 数据结构解析为有用的 JavaScript 对象。与 XML 数据结构要解析成 DOM 文档而且从中提取数据极为麻烦相比，JSON 可以解析为 JavaScript 对象的优势极其明显。就以上一节中包含一组图书的 JSON 数据结构为例，在解析为 JavaScript 对象后，只需要下面一行简单的代码就可以取得第三本书的书名：

books[2].title

当然，这里是假设把解析后 JSON 数据结构得到的对象保存到了变量 books 中。再看看下面在 DOM 结构中查找数据的代码：

doc.getElementsByTagName("book")[2].getAttribute("title")

看看这些多余的方法调用，就不难理解为什么 JSON 能得到 JavaScript 开发人员的热烈欢迎了。从此以后，JSON 就成了 Web 服务开发中交换数据的事实标准。

20.2.1　JSON 对象

早期的 JSON 解析器基本上就是使用 JavaScript 的 eval () 函数。由于 JSON 是 JavaScript 语法的子集，因此 eval () 函数可以解析、解释并返回 JavaScript 对象和数组。ECMAScript 5 对解析 JSON 的行为进行规范，定义了全局对象 JSON。支持这个对象的浏览器有 IE 8+、Firefox 3.5+、Safari 4+、Chrome 和 Opera 10.5+。对于较早版本的浏览器，可以使用一个 shim：https://github.com/douglascrockford/JSON-js。在旧版本的浏览器中，使用 eval () 对 JSON 数据结构求值存在风险，因为可能会执行一些恶意代码。对于不能原生支持 JSON 解析的浏览器，使用这个 shim 是最佳选择。

JSON 对象有两个方法：stringify () 和 parse ()。在最简单的情况下，这两个方法分别用于把 JavaScript 对象序列化为 JSON 字符串和把 JSON 字符串解析为原生 JavaScript 值。例如：

var book = { title: "Professional JavaScript", authors: [ "Nicholas C. Zakas" ], edition: 3, year: 2011 }; var jsonText = JSON.stringify(book);

JSONStringifyExample01.htm

这个例子使用 JSON.stringify () 把一个 JavaScript 对象序列化为一个 JSON 字符串，然后将它保存在变量 jsonText 中。默认情况下，JSON.stringify () 输出的 JSON 字符串不包含任何空格字符或缩进，因此保存在 jsonText 中的字符串如下所示：

{"title":"Professional JavaScript","authors":["Nicholas C. Zakas"],"edition":3, "year":2011}

在序列化 JavaScript 对象时，所有函数及原型成员都会被有意忽略，不体现在结果中。此外，值为 undefined 的任何属性也都会被跳过。结果中最终都是值为有效 JSON 数据类型的实例属性。

将 JSON 字符串直接传递给 JSON.parse () 就可以得到相应的 JavaScript 值。例如，使用下列代码就可以创建与 book 类似的对象：

var bookCopy = JSON.parse(jsonText);

注意，虽然 book 与 bookCopy 具有相同的属性，但它们是两个独立的、没有任何关系的对象。

如果传给 JSON.parse () 的字符串不是有效的 JSON，该方法会抛出错误。

20.2.2　序列化选项

实际上，JSON.stringify () 除了要序列化的 JavaScript 对象外，还可以接收另外两个参数，这两个参数用于指定以不同的方式序列化 JavaScript 对象。第一个参数是个过滤器，可以是一个数组，也可以是一个函数；第二个参数是一个选项，表示是否在 JSON 字符串中保留缩进。单独或组合使用这两个参数，可以更全面深入地控制 JSON 的序列化。

1. 过滤结果

如果过滤器参数是数组，那么 JSON.stringify () 的结果中将只包含数组中列出的属性。来看下面的例子。

var book = { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011 }; var jsonText = JSON.stringify(book, ["title", "edition"]);

JSONStringifyExample01.htm

JSON.stringify () 的第二个参数是一个数组，其中包含两个字符串："title" 和 "edition"。这两个属性与将要序列化的对象中的属性是对应的，因此在返回的结果字符串中，就只会包含这两个属性：

{"title":"Professional JavaScript","edition":3}

如果第二个参数是函数，行为会稍有不同。传入的函数接收两个参数，属性（键）名和属性值。根据属性（键）名可以知道应该如何处理要序列化的对象中的属性。属性名只能是字符串，而在值并非键值对儿结构的值时，键名可以是空字符串。

为了改变序列化对象的结果，函数返回的值就是相应键的值。不过要注意，如果函数返回了 undefined，那么相应的属性会被忽略。还是看一个例子吧。

var book = { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011 }; var jsonText = JSON.stringify(book, function(key, value){ switch(key){ case "authors": return value.join(",") case "year": return 5000; case "edition": return undefi ned; default: return value; } });

JSONStringifyExample02.htm

这里，函数过滤器根据传入的键来决定结果。如果键为 "authors"，就将数组连接为一个字符串；如果键为 "year"，则将其值设置为 5000；如果键为 "edition"，通过返回 undefined 删除该属性。最后，一定要提供 default 项，此时返回传入的值，以便其他值都能正常出现在结果中。实际上，第一次调用这个函数过滤器，传入的键是一个空字符串，而值就是 book 对象。序列化后的 JSON 字符串如下所示：

{"title":"Professional JavaScript","authors":"Nicholas C. Zakas","year":5000}

要序列化的对象中的每一个对象都要经过过滤器，因此数组中的每个带有这些属性的对象经过过滤之后，每个对象都只会包含 "title"、"authors" 和 "year" 属性。

Firefox 3.5 和 3.6 对 JSON.stringify () 的实现有一个 bug，在将函数作为该方法的第二个参数时这个 bug 就会出现：过滤函数返回 undefined 意味着要跳过某个属性，而返回其他任何值都会在结果中包含相应的属性。Firefox 4 修复了这个 bug。

2. 字符串缩进

JSON.stringify () 方法的第三个参数用于控制结果中的缩进和空白符。如果这个参数是一个数值，那它表示的是每个级别缩进的空格数。例如，要在每个级别缩进 4 个空格，可以这样写代码：

var book = { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011 }; var jsonText = JSON.stringify(book, null, 4);

JSONStringifyExample03.htm

保存在 jsonText 中的字符串如下所示：

{ "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], "edition": 3, "year": 2011 }

不知道读者注意到没有，JSON.stringify () 也在结果字符串中插入了换行符以提高可读性。只要传入有效的控制缩进的参数值，结果字符串就会包含换行符。（只缩进而不换行意义不大。）最大缩进空格数为 10，所有大于 10 的值都会自动转换为 10。

如果缩进参数是一个字符串而非数值，则这个字符串将在 JSON 字符串中被用作缩进字符（不再使用空格）。在使用字符串的情况下，可以将缩进字符设置为制表符，或者两个短划线之类的任意字符。

var jsonText = JSON.stringify(book, null, " — -");

这样，jsonText 中的字符串将变成如下所示：

{ --"title": "Professional JavaScript", --"authors": [ ----"Nicholas C. Zakas" --], --"edition": 3, --"year": 2011 }

缩进字符串最长不能超过 10 个字符长。如果字符串长度超过了 10 个，结果中将只出现前 10 个字符。

3. toJSON () 方法

有时候，JSON.stringify () 还是不能满足对某些对象进行自定义序列化的需求。在这些情况下，可以通过对象上调用 toJSON () 方法，返回其自身的 JSON 数据格式。原生 Date 对象有一个 toJSON () 方法，能够将 JavaScript 的 Date 对象自动转换成 ISO 8601 日期字符串（与在 Date 对象上调用 toISOString () 的结果完全一样）。

可以为任何对象添加 toJSON () 方法，比如：

var book = { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011, toJSON: function(){ return this.title; } }; var jsonText = JSON.stringify(book);

JSONStringifyExample05.htm

以上代码在 book 对象上定义了一个 toJSON () 方法，该方法返回图书的书名。与 Date 对象类似，这个对象也将被序列化为一个简单的字符串而非对象。可以让 toJSON () 方法返回任何序列化的值，它都能正常工作。也可以让这个方法返回 undefined，此时如果包含它的对象嵌入在另一个对象中，会导致该对象的值变成 null，而如果包含它的对象是顶级对象，结果就是 undefined。

toJSON () 可以作为函数过滤器的补充，因此理解序列化的内部顺序十分重要。假设把一个对象传入 JSON.stringify ()，序列化该对象的顺序如下。

如果存在 toJSON () 方法而且能通过它取得有效的值，则调用该方法。否则，按默认顺序执行序列化。

如果提供了第二个参数，应用这个函数过滤器。传入函数过滤器的值是第 1 步返回的值。

对第 2 步返回的每个值进行相应的序列化。

如果提供了第三个参数，执行相应的格式化。

无论是考虑定义 toJSON () 方法，还是考虑使用函数过滤器，亦或需要同时使用两者，理解这个顺序都是至关重要的。

20.2.3　解析选项

JSON.parse () 方法也可以接收另一个参数，该参数是一个函数，将在每个键值对儿上调用。为了区别 JSON.stringify () 接收的替换（过滤）函数（replacer），这个函数被称为还原函数（reviver），但实际上这两个函数的签名是相同的 —— 它们都接收两个参数，一个键和一个值，而且都需要返回一个值。

如果还原函数返回 undefined，则表示要从结果中删除相应的键；如果返回其他值，则将该值插入到结果中。在将日期字符串转换为 Date 对象时，经常要用到还原函数。例如：

var book = { "title": "Professional JavaScript", "authors": [ "Nicholas C. Zakas" ], edition: 3, year: 2011, releaseDate: new Date(2011, 11, 1) }; var jsonText = JSON.stringify(book); var bookCopy = JSON.parse(jsonText, function(key, value){ if (key == "releaseDate"){ return new Date(value); } else { return value; } }); alert(bookCopy.releaseDate.getFullYear());

JSONParseExample02.htm

以上代码先是为 book 对象新增了一个 releaseDate 属性，该属性保存着一个 Date 对象。这个对象在经过序列化之后变成了有效的 JSON 字符串，然后经过解析又在 bookCopy 中还原为一个 Date 对象。还原函数在遇到 "releaseDate" 键时，会基于相应的值创建一个新的 Date 对象。结果就是 bookCopy.releaseDate 属性中会保存一个 Date 对象。正因为如此，才能基于这个对象调用 getFullYear () 方法。

20.3　小结

JSON 是一个轻量级的数据格式，可以简化表示复杂数据结构的工作量。JSON 使用 JavaScript 语法的子集表示对象、数组、字符串、数值、布尔值和 null。即使 XML 也能表示同样复杂的数据结果，但 JSON 没有那么烦琐，而且在 JavaScript 中使用更便利。

ECMAScript 5 定义了一个原生的 JSON 对象，可以用来将对象序列化为 JSON 字符串或者将 JSON 数据解析为 JavaScript 对象。JSON.stringify () 和 JSON.parse () 方法分别用来实现上述两项功能。这两个方法都有一些选项，通过它们可以改变过滤的方式，或者改变序列化的过程。

原生的 JSON 对象也得到了很多浏览器的支持，比如 IE8+、Firefox 3.5+、Safari 4+、Opera 10.5 和 Chrome。

第 21 章　Ajax 与 Comet

本章内容

使用 XMLHttpRequest 对象

使用 XMLHttpRequest 事件

跨域 Ajax 通信的限制

2005 年，Jesse James Garrett 发表了一篇在线文章，题为「Ajax: A new Approach to Web Applications」（http://www.adaptivepath.com/ideas/essays/archives/000385.php）。他在这篇文章里介绍了一种技术，用他的话说，就叫 Ajax，是对 Asynchronous JavaScript + XML 的简写。这一技术能够向服务器请求额外的数据而无须卸载页面，会带来更好的用户体验。Garrett 还解释了怎样使用这一技术改变自从 Web 诞生以来就一直沿用的「单击，等待」的交互模式。

Ajax 技术的核心是 XMLHttpRequest 对象（简称 XHR），这是由微软首先引入的一个特性，其他浏览器提供商后来都提供了相同的实现。在 XHR 出现之前，Ajax 式的通信必须借助一些 hack 手段来实现，大多数是使用隐藏的框架或内嵌框架。XHR 为向服务器发送请求和解析服务器响应提供了流畅的接口。能够以异步方式从服务器取得更多信息，意味着用户单击后，可以不必刷新页面也能取得新数据。也就是说，可以使用 XHR 对象取得新数据，然后再通过 DOM 将新数据插入到页面中。另外，虽然名字中包含 XML 的成分，但 Ajax 通信与数据格式无关；这种技术就是无须刷新页面即可从服务器取得数据，但不一定是 XML 数据。

实际上，Garrett 提到的这种技术已经存在很长时间了。在 Garrett 撰写那篇文章之前，人们通常将这种技术叫做远程脚本（remote scripting），而且早在 1998 年就有人采用不同的手段实现了这种浏览器与服务器的通信。再往前推，JavaScript 需要通过 Java applet 或 Flash 电影等中间层向服务器发送请求。而 XHR 则将浏览器原生的通信能力提供给了开发人员，简化了实现同样操作的任务。

在重命名为 Ajax 之后，大约是 2005 年底 2006 年初，这种浏览器与服务器的通信技术可谓红极一时。人们对 JavaScript 和 Web 的全新认识，催生了很多使用原有特性的新技术和新模式。就目前来说，熟练使用 XHR 对象已经成为所有 Web 开发人员必须掌握的一种技能。

21.1　XMLHttpRequest 对象

IE5 是第一款引入 XHR 对象的浏览器。在 IE5 中，XHR 对象是通过 MSXML 库中的一个 ActiveX 对象实现的。因此，在 IE 中可能会遇到三种不同版本的 XHR 对象，即 MSXML2.XMLHttp、MSXML2.XMLHttp.3.0 和 MXSML2.XMLHttp.6.0。要使用 MSXML 库中的 XHR 对象，需要像第 18 章讨论创建 XML 文档时一样，编写一个函数，例如：

// 适用于 IE7 之前的版本 function createXHR (){ if (typeof arguments.callee.activeXString != "string"){var versions = ["MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"], i, len; for (i=0,len=versions.length; i < len; i++){try { new ActiveXObject (versions [i]); arguments.callee.activeXString = versions [i]; break; } catch (ex){// 跳过} } } return new ActiveXObject (arguments.callee.activeXString); }

这个函数会尽力根据 IE 中可用的 MSXML 库的情况创建最新版本的 XHR 对象。

IE7+、Firefox、Opera、Chrome 和 Safari 都支持原生的 XHR 对象，在这些浏览器中创建 XHR 对象要像下面这样使用 XMLHttpRequest 构造函数。

var xhr = new XMLHttpRequest();

假如你只想支持 IE7 及更高版本，那么大可丢掉前面定义的那个函数，而只用原生的 XHR 实现。但是，如果你必须还要支持 IE 的早期版本，那么则可以在这个 createXHR () 函数中加入对原生 XHR 对象的支持。

function createXHR (){ if (typeof XMLHttpRequest != "undefined"){return new XMLHttpRequest (); } else if (typeof ActiveXObject != "undefined"){if (typeof arguments.callee.activeXString != "string"){var versions = [ "MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"], i, len; for (i=0,len=versions.length; i < len; i++){try { new ActiveXObject (versions [i]); arguments.callee.activeXString = versions [i]; break; } catch (ex){// 跳过} } } return new ActiveXObject (arguments.callee.activeXString); } else {throw new Error ("No XHR object available."); } }

XHRExample01.htm

这个函数中新增的代码首先检测原生 XHR 对象是否存在，如果存在则返回它的新实例。如果原生对象不存在，则检测 ActiveX 对象。如果这两种对象都不存在，就抛出一个错误。然后，就可以使用下面的代码在所有浏览器中创建 XHR 对象了。

var xhr = createXHR();

由于其他浏览器中对 XHR 的实现与 IE 最早的实现是兼容的，因此就可以在所有浏览器中都以相同方式使用上面创建的 xhr 对象。

21.1.1　XHR 的用法

在使用 XHR 对象时，要调用的第一个方法是 open ()，它接受 3 个参数：要发送的请求的类型（"get"、"post" 等）、请求的 URL 和表示是否异步发送请求的布尔值。下面就是调用这个方法的例子。

xhr.open("get", "example.php", false);

这行代码会启动一个针对 example.php 的 GET 请求。有关这行代码，需要说明两点：一是 URL 相对于执行代码的当前页面（当然也可以使用绝对路径）；二是调用 open () 方法并不会真正发送请求，而只是启动一个请求以备发送。

只能向同一个域中使用相同端口和协议的 URL 发送请求。如果 URL 与启动请求的页面有任何差别，都会引发安全错误。

要发送特定的请求，必须像下面这样调用 send () 方法：

xhr.open("get", "example.txt", false); xhr.send(null);

XHRExample01.htm

这里的 send () 方法接收一个参数，即要作为请求主体发送的数据。如果不需要通过请求主体发送数据，则必须传入 null，因为这个参数对有些浏览器来说是必需的。调用 send () 之后，请求就会被分派到服务器。

由于这次请求是同步的，JavaScript 代码会等到服务器响应之后再继续执行。在收到响应后，响应的数据会自动填充 XHR 对象的属性，相关的属性简介如下。

responseText：作为响应主体被返回的文本。

responseXML：如果响应的内容类型是 "text/xml" 或 "application/xml"，这个属性中将保存包含着响应数据的 XML DOM 文档。

status：响应的 HTTP 状态。

statusText：HTTP 状态的说明。

在接收到响应后，第一步是检查 status 属性，以确定响应已经成功返回。一般来说，可以将 HTTP 状态代码为 200 作为成功的标志。此时，responseText 属性的内容已经就绪，而且在内容类型正确的情况下，responseXML 也应该能够访问了。此外，状态代码为 304 表示请求的资源并没有被修改，可以直接使用浏览器中缓存的版本；当然，也意味着响应是有效的。为确保接收到适当的响应，应该像下面这样检查上述这两种状态代码：

xhr.open("get", "example.txt", false); xhr.send(null); if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); }

XHRExample01.htm

根据返回的状态代码，这个例子可能会显示由服务器返回的内容，也可能会显示一条错误消息。我们建议读者要通过检测 status 来决定下一步的操作，不要依赖 statusText，因为后者在跨浏览器使用时不太可靠。另外，无论内容类型是什么，响应主体的内容都会保存到 responseText 属性中；而对于非 XML 数据而言，responseXML 属性的值将为 null。

有的浏览器会错误地报告 204 状态代码。IE 中 XHR 的 ActiveX 版本会将 204 设置为 1223，而 IE 中原生的 XHR 则会将 204 规范化为 200。Opera 会在取得 204 时报告 status 的值为 0。

像前面这样发送同步请求当然没有问题，但多数情况下，我们还是要发送异步请求，才能让 JavaScript 继续执行而不必等待响应。此时，可以检测 XHR 对象的 readyState 属性，该属性表示请求 / 响应过程的当前活动阶段。这个属性可取的值如下。

0：未初始化。尚未调用 open () 方法。

1：启动。已经调用 open () 方法，但尚未调用 send () 方法。

2：发送。已经调用 send () 方法，但尚未接收到响应。

3：接收。已经接收到部分响应数据。

4：完成。已经接收到全部响应数据，而且已经可以在客户端使用了。

只要 readyState 属性的值由一个值变成另一个值，都会触发一次 readystatechange 事件。可以利用这个事件来检测每次状态变化后 readyState 的值。通常，我们只对 readyState 值为 4 的阶段感兴趣，因为这时所有数据都已经就绪。不过，必须在调用 open () 之前指定 onreadystatechange 事件处理程序才能确保跨浏览器兼容性。下面来看一个例子。

var xhr = createXHR(); xhr.onreadystatechange = function(){ if (xhr.readyState == 4){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } } }; xhr.open("get", "example.txt", true); xhr.send(null);

XHRAsyncExample01.htm

以上代码利用 DOM 0 级方法为 XHR 对象添加了事件处理程序，原因是并非所有浏览器都支持 DOM 2 级方法。与其他事件处理程序不同，这里没有向 onreadystatechange 事件处理程序中传递 event 对象；必须通过 XHR 对象本身来确定下一步该怎么做。

这个例子在 onreadystatechange 事件处理程序中使用了 xhr 对象，没有使用 this 对象，原因是 onreadystatechange 事件处理程序的作用域问题。如果使用 this 对象，在有的浏览器中会导致函数执行失败，或者导致错误发生。因此，使用实际的 XHR 对象实例变量是较为可靠的一种方式。

另外，在接收到响应之前还可以调用 abort () 方法来取消异步请求，如下所示：

xhr.abort();

调用这个方法后，XHR 对象会停止触发事件，而且也不再允许访问任何与响应有关的对象属性。在终止请求之后，还应该对 XHR 对象进行解引用操作。由于内存原因，不建议重用 XHR 对象。

21.1.2　HTTP 头部信息

每个 HTTP 请求和响应都会带有相应的头部信息，其中有的对开发人员有用，有的也没有什么用。XHR 对象也提供了操作这两种头部（即请求头部和响应头部）信息的方法。

默认情况下，在发送 XHR 请求的同时，还会发送下列头部信息。

Accept：浏览器能够处理的内容类型。

Accept-Charset：浏览器能够显示的字符集。

Accept-Encoding：浏览器能够处理的压缩编码。

Accept-Language：浏览器当前设置的语言。

Connection：浏览器与服务器之间连接的类型。

Cookie：当前页面设置的任何 Cookie。

Host：发出请求的页面所在的域 。

Referer：发出请求的页面的 URI。注意，HTTP 规范将这个头部字段拼写错了，而为保证与规范一致，也只能将错就错了。（这个英文单词的正确拼法应该是 referrer。）

User-Agent：浏览器的用户代理字符串。

虽然不同浏览器实际发送的头部信息会有所不同，但以上列出的基本上是所有浏览器都会发送的。使用 setRequestHeader () 方法可以设置自定义的请求头部信息。这个方法接受两个参数：头部字段的名称和头部字段的值。要成功发送请求头部信息，必须在调用 open () 方法之后且调用 send () 方法之前调用 setRequestHeader ()，如下面的例子所示。

var xhr = createXHR(); xhr.onreadystatechange = function(){ if (xhr.readyState == 4){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } } }; xhr.open("get", "example.php", true); xhr.setRequestHeader("MyHeader", "MyValue"); xhr.send(null);

XHRRequestHeadersExample01.htm

服务器在接收到这种自定义的头部信息之后，可以执行相应的后续操作。我们建议读者使用自定义的头部字段名称，不要使用浏览器正常发送的字段名称，否则有可能会影响服务器的响应。有的浏览器允许开发人员重写默认的头部信息，但有的浏览器则不允许这样做。

调用 XHR 对象的 getResponseHeader () 方法并传入头部字段名称，可以取得相应的响应头部信息。而调用 getAllResponseHeaders () 方法则可以取得一个包含所有头部信息的长字符串。来看下面的例子。

var myHeader = xhr.getResponseHeader("MyHeader"); var allHeaders xhr.getAllResponseHeaders();

在服务器端，也可以利用头部信息向浏览器发送额外的、结构化的数据。在没有自定义信息的情况下，getAllResponse- Headers () 方法通常会返回如下所示的多行文本内容：

Date: Sun, 14 Nov 2004 18:04:03 GMT Server: Apache/1.3.29 (Unix) Vary: Accept X-Powered-By: PHP/4.3.8 Connection: close Content-Type: text/html; charset=iso-8859-1

这种格式化的输出可以方便我们检查响应中所有头部字段的名称，而不必一个一个地检查某个字段是否存在。

21.1.3　GET 请求

GET 是最常见的请求类型，最常用于向服务器查询某些信息。必要时，可以将查询字符串参数追加到 URL 的末尾，以便将信息发送给服务器。对 XHR 而言，位于传入 open () 方法的 URL 末尾的查询字符串必须经过正确的编码才行。

使用 GET 请求经常会发生的一个错误，就是查询字符串的格式有问题。查询字符串中每个参数的名称和值都必须使用 encodeURIComponent () 进行编码，然后才能放到 URL 的末尾；而且所有名 - 值对儿都必须由和号（&）分隔，如下面的例子所示。

xhr.open("get", "example.php?name1=value1&name2=value2", true);

下面这个函数可以辅助向现有 URL 的末尾添加查询字符串参数：

function addURLParam(url, name, value) { url += (url.indexOf("?") == -1 ? "?" : "&"); url += encodeURIComponent(name) + "=" + encodeURIComponent(value); return url; }

这个 addURLParam () 函数接受三个参数：要添加参数的 URL、参数的名称和参数的值。这个函数首先检查 URL 是否包含问号（以确定是否已经有参数存在）。如果没有，就添加一个问号；否则，就添加一个和号。然后，将参数名称和值进行编码，再添加到 URL 的末尾。最后返回添加参数之后的 URL。

下面是使用这个函数来构建请求 URL 的示例。

