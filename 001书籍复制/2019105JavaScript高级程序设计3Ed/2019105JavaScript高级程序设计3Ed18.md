因为创建比较麻烦，所以径向渐变并不那么容易控制。不过，一般来说，让起点圆和终点圆保持为同心圆的情况比较多，这时候只要考虑给两个圆设置不同的半径就好了。

15.2.9　模式

模式其实就是重复的图像，可以用来填充或描边图形。要创建一个新模式，可以调用 createPattern () 方法并传入两个参数：一个 HTML <img> 元素和一个表示如何重复图像的字符串。其中，第二个参数的值与 CSS 的 background-repeat 属性值相同，包括 "repeat"、"repeat-x"、"repeat-y" 和 "no-repeat"。看一个例子。

var image = document.images [0], pattern = context.createPattern (image, "repeat"); // 绘制矩形 context.fillStyle = pattern; context.fillRect (10, 10, 150, 150);

2DFillRectPatternExample01.htm

需要注意的是，模式与渐变一样，都是从画布的原点 (0,0) 开始的。将填充样式（fillStyle）设置为模式对象，只表示在某个特定的区域内显示重复的图像，而不是要从某个位置开始绘制重复的图像。上面的代码会得到如图 15-13 所示的结果。

图　15-13

createPattern () 方法的第一个参数也可以是一个 < video> 元素，或者另一个 <canvas> 元素。

15.2.10　使用图像数据

2D 上下文的一个明显的长处就是，可以通过 getImageData () 取得原始图像数据。这个方法接收 4 个参数：要取得其数据的画面区域的 x 和 y 坐标以及该区域的像素宽度和高度。例如，要取得左上角坐标为 (10,5)、大小为 50×50 像素的区域的图像数据，可以使用以下代码：

var imageData = context.getImageData(10, 5, 50, 50);

这里返回的对象是 ImageData 的实例。每个 ImageData 对象都有三个属性：width、height 和 data。其中 data 属性是一个数组，保存着图像中每一个像素的数据。在 data 数组中，每一个像素用 4 个元素来保存，分别表示红、绿、蓝和透明度值。因此，第一个像素的数据就保存在数组的第 0 到第 3 个元素中，例如：

var data = imageData.data, red = data[0], green = data[1], blue = data[2], alpha = data[3];

数组中每个元素的值都介于 0 到 255 之间（包括 0 和 255）。能够直接访问到原始图像数据，就能够以各种方式来操作这些数据。例如，通过修改图像数据，可以像下面这样创建一个简单的灰阶过滤器。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var context = drawing.getContext ("2d"), image = document.images [0], imageData, data, i, len, average, red, green, blue, alpha; // 绘制原始图像 context.drawImage (image, 0, 0); // 取得图像数据 imageData = context.getImageData (0, 0, image.width, image.height); data = imageData.data; for (i=0, len=data.length; i < len; i+=4){red = data [i]; green = data [i+1]; blue = data [i+2]; alpha = data [i+3]; // 求得 rgb 平均值 average = Math.floor ((red + green + blue) / 3); // 设置颜色值，透明度不变 data [i] = average; data [i+1] = average; data [i+2] = average; } // 回写图像数据并显示结果 imageData.data = data; context.putImageData (imageData, 0, 0); }

2DImageDataExample01.htm

这个例子首先在画面上绘制了一幅图像，然后取得了原始图像数据。其中的 for 循环遍历了图像数据中的每一个像素。这里要注意的是，每次循环控制变量 i 都递增 4。在取得每个像素的红、绿、蓝颜色值后，计算出它们的平均值。再把这个平均值设置为每个颜色的值，结果就是去掉了每个像素的颜色，只保留了亮度接近的灰度值（即彩色变黑白）。在把 data 数组回写到 imageData 对象后，调用 putImageData () 方法把图像数据绘制到画布上。最终得到了图像的黑白版。

当然，通过操作原始像素值不仅能实现灰阶过滤，还能实现其他功能。要了解通过操作原始图像数据实现过滤器的更多信息，请参考 Ilmari Heikkinen 的文章「Making Image Filters with Canvas」（基于 Canvas 的图像过滤器）：http://www.html5rocks.com/en/tutorials/canvas/imagefilters/。

只有在画布「干净」的情况下（即图像并非来自其他域），才可以取得图像数据。如果画布「不干净」，那么访问图像数据时会导致 JavaScript 错误。

15.2.11　合成

还有两个会应用到 2D 上下文中所有绘制操作的属性：globalAlpha 和 globalCompositionOperation。其中，globalAlpha 是一个介于 0 和 1 之间的值（包括 0 和 1），用于指定所有绘制的透明度。默认值为 0。如果所有后续操作都要基于相同的透明度，就可以先把 globalAlpha 设置为适当值，然后绘制，最后再把它设置回默认值 0。下面来看一个例子。

// 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 修改全局透明度 context.globalAlpha = 0.5; // 绘制蓝色矩形 context.fillStyle = "rgba (0,0,255,1)"; context.fillRect (30, 30, 50, 50); // 重置全局透明度 context.globalAlpha = 0;

2DGlobalAlphaExample01.htm

在这个例子中，我们把蓝色矩形绘制到了红色矩形上面。因为在绘制蓝色矩形前，globalAlpha 已经被设置为 0.5，所以蓝色矩形会呈现半透明效果，透过它可以看到下面的红色矩形。

第二个属性 globalCompositionOperation 表示后绘制的图形怎样与先绘制的图形结合。这个属性的值是字符串，可能的值如下。

source-over（默认值）：后绘制的图形位于先绘制的图形上方。

source-in：后绘制的图形与先绘制的图形重叠的部分可见，两者其他部分完全透明。

source-out：后绘制的图形与先绘制的图形不重叠的部分可见，先绘制的图形完全透明。

source-atop：后绘制的图形与先绘制的图形重叠的部分可见，先绘制图形不受影响。

destination-over：后绘制的图形位于先绘制的图形下方，只有之前透明像素下的部分才可见。

destination-in：后绘制的图形位于先绘制的图形下方，两者不重叠的部分完全透明。

destination-out：后绘制的图形擦除与先绘制的图形重叠的部分。

destination-atop：后绘制的图形位于先绘制的图形下方，在两者不重叠的地方，先绘制的图形会变透明。

lighter：后绘制的图形与先绘制的图形重叠部分的值相加，使该部分变亮。

copy：后绘制的图形完全替代与之重叠的先绘制图形。

xor：后绘制的图形与先绘制的图形重叠的部分执行「异或」操作。

这个合成操作实际上用语言或者黑白图像是很难说清楚的。要了解每个操作的具体效果，请参见 https://developer.mozilla.org/samples/canvas-tutorial/6_1_canvas_composite.html。推荐使用 IE9 + 或 Firefox 4 + 访问前面的网页，因为这两款浏览器对 Canvas 的实现最完善。下面来看一个例子。

// 绘制红色矩形 context.fillStyle = "#ff0000"; context.fillRect (10, 10, 50, 50); // 设置合成操作 context.globalCompositeOperation = "destination-over"; // 绘制蓝色矩形 context.fillStyle = "rgba (0,0,255,1)"; context.fillRect (30, 30, 50, 50);

2DGlobalCompositeOperationExample01.htm

如果不修改 globalCompositionOperation，那么蓝色矩形应该位于红色矩形之上。但把 globalCompositionOperation 设置为 "destination-over" 之后，红色矩形跑到了蓝色矩形上面。

在使用 globalCompositionOperation 的情况下，一定要多测试一些浏览器。因为不同浏览器对这个属性的实现仍然存在较大的差别。Safari 和 Chrome 在这方面还有问题，至于有什么问题，大家可以比较在打开上述页面的情况下，IE9 + 和 Firefox 4 + 与它们有什么差异。

15.3　WebGL

WebGL 是针对 Canvas 的 3D 上下文。与其他 Web 技术不同，WebGL 并不是 W3C 制定的标准，而是由 Khronos Group 制定的。其官方网站是这样介绍的：「Khronos Group 是一个非盈利的由会员资助的协会，专注于为并行计算以及各种平台和设备上的图形及动态媒体制定无版税的开放标准。」Khronos Group 也设计了其他图形处理 API，比如 OpenGL ES 2.0。浏览器中使用的 WebGL 就是基于 OpenGL ES 2.0 制定的。

OpenGL 等 3D 图形语言是非常复杂的，本书不可能介绍其中每一个概念。熟悉 OpenGL ES 2.0 的读者可能会觉得 WebGL 更好理解一些，因为好多概念是相通的。

本节将适当地介绍 OpenGL ES 2.0 的一些概念，尽力解释其中的某些部分在 WebGL 中的实现。要全面了解 OpenGL，请访问 www.opengl.org。要全面学习 WebGL，请参考 www.learningwebgl.com，其中包含非常棒的系列教程 1。

1 中文翻译版请参考 http://www.hiwebgl.com/?p=42。

15.3.1　类型化数组

WebGL 涉及的复杂计算需要提前知道数值的精度，而标准的 JavaScript 数值无法满足需要。为此，WebGL 引入了一个概念，叫类型化数组（typed arrays）。类型化数组也是数组，只不过其元素被设置为特定类型的值。

类型化数组的核心就是一个名为 ArrayBuffer 的类型。每个 ArrayBuffer 对象表示的只是内存中指定的字节数，但不会指定这些字节用于保存什么类型的数据。通过 ArrayBuffer 所能做的，就是为了将来使用而分配一定数量的字节。例如，下面这行代码会在内存中分配 20B。

var buffer = new ArrayBuffer(20);

创建了 ArrayBuffer 对象后，能够通过该对象获得的信息只有它包含的字节数，方法是访问其 byteLength 属性：

var bytes = buffer.byteLength;

虽然 ArrayBuffer 对象本身没有多少可说的，但对 WebGL 而言，使用它是极其重要的。而且，在涉及视图的时候，你才会发现它原来还是很有意思的。

1. 视图

使用 ArrayBuffer（数组缓冲器类型）的一种特别的方式就是用它来创建数组缓冲器视图。其中，最常见的视图是 DataView，通过它可以选择 ArrayBuffer 中一小段字节。为此，可以在创建 DataView 实例的时候传入一个 ArrayBuffer、一个可选的字节偏移量（从该字节开始选择）和一个可选的要选择的字节数。例如：

// 基于整个缓冲器创建一个新视图 var view = new DataView (buffer); // 创建一个开始于字节 9 的新视图 var view = new DataView (buffer, 9); // 创建一个从字节 9 开始到字节 18 的新视图 var view = new DataView (buffer, 9, 10);

实例化之后，DataView 对象会把字节偏移量以及字节长度信息分别保存在 byteOffset 和 byteLength 属性中。

alert(view.byteOffset); alert(view.byteLength);

通过这两个属性可以在以后方便地了解视图的状态。另外，通过其 buffer 属性也可以取得数组缓冲器。

读取和写入 DataView 的时候，要根据实际操作的数据类型，选择相应的 getter 和 setter 方法。下表列出了 DataView 支持的数据类型以及相应的读写方法。

数据类型 getter setter

有符号 8 位整数 getInt8 (byteOffset) setInt8 (byteOffset, value)

无符号 8 位整数 getUint8 (byteOffset) setUint8 (byteOffset, value)

有符号 16 位整数 getInt16 (byteOffset,littleEndian) setInt16 (byteOffset, value,littleEndian)

无符号 16 位整数 getUint16 (byteOffset,littleEndian) setUint16 (byteOffset,value, littleEndian)

有符号 32 位整数 getInt32 (byteOffset,littleEndian) setInt32 (byteOffset, value,littleEndian)

无符号 32 位整数 getUint32 (byteOffset,littleEndian) setUint32 (byteOffset,value, littleEndian)

32 位浮点数 getFloat32 (byteOffset,littleEndian) setFloat32 (byteOffset,value, littleEndian)

64 位浮点数 getFloat64 (byteOffset,littleEndian) setFloat64 (byteOffset,value, littleEndian)

所有这些方法的第一个参数都是一个字节偏移量，表示要从哪个字节开始读取或写入。不要忘了，要保存有些数据类型的数据，可能需要不止 1B。比如，无符号 8 位整数要用 1B，而 32 位浮点数则要用 4B。使用 DataView，就需要你自己来管理这些细节，即要明确知道自己的数据需要多少字节，并选择正确的读写方法。例如：

var buffer = new ArrayBuffer (20), view = new DataView (buffer), value; view.setUint16 (0, 25); view.setUint16 (2, 50); // 不能从字节 1 开始，因为 16 位整数要用 2B value = view.getUint16 (0);

DataViewExample01.htm

以上代码把两个无符号 16 位整数保存到了数组缓冲器中。因为每个 16 位整数要用 2B，所以保存第一个数的字节偏移量为 0，而保存第二个数的字节偏移量为 2。

用于读写 16 位或更大数值的方法都有一个可选的参数 littleEndian。这个参数是一个布尔值，表示读写数值时是否采用小端字节序（即将数据的最低有效位保存在低内存地址中），而不是大端字节序（即将数据的最低有效位保存在高内存地址中）。如果你也不确定应该使用哪种字节序，那不用管它，就采用默认的大端字节序方式保存即可。

因为在这里使用的是字节偏移量，而非数组元素数，所以可以通过几种不同的方式来访问同一字节。例如：

var buffer = new ArrayBuffer(20), view = new DataView(buffer), value; view.setUint16(0, 25); value = view.getInt8(0); alert(value); //0

DataViewExample02.htm

在这个例子中，数值 25 以 16 位无符号整数的形式被写入，字节偏移量为 0。然后，再以 8 位有符号整数的方式读取该数据，得到的结果是 0。这是因为 25 的二进制形式的前 8 位（第一个字节）全部是 0，如图 15-14 所示。

图　15-14

可见，虽然 DataView 能让我们在字节级别上读写数组缓冲器中的数据，但我们必须自己记住要将数据保存到哪里，需要占用多少字节。这样一来，就会带来很多工作量，因此类型化视图也就应运而生。

2. 类型化视图

类型化视图一般也被称为类型化数组，因为它们除了元素必须是某种特定的数据类型外，与常规的数组无异。类型化视图也分几种，而且它们都继承了 DataView。

Int8Array：表示 8 位二补整数。

Uint8Array：表示 8 位无符号整数。

Int16Array：表示 16 位二补整数。

Uint16Array：表示 16 位无符号整数。

Int32Array：表示 32 位二补整数。

Uint32Array：表示 32 位无符号整数。

Float32Array：表示 32 位 IEEE 浮点值。

Float64Array：表示 64 位 IEEE 浮点值。

每种视图类型都以不同的方式表示数据，而同一数据视选择的类型不同有可能占用一或多字节。例如，20B 的 ArrayBuffer 可以保存 20 个 Int8Array 或 Uint8Array，或者 10 个 Int16Array 或 Uint16Array，或者 5 个 Int32Array、Uint32Array 或 Float32Array，或者 2 个 Float64Array。

由于这些视图都继承自 DataView，因而可以使用相同的构造函数参数来实例化。第一个参数是要使用 ArrayBuffer 对象，第二个参数是作为起点的字节偏移量（默认为 0），第三个参数是要包含的字节数。三个参数中只有第一个是必需的。下面来看几个例子。

// 创建一个新数组，使用整个缓冲器 var int8s = new Int8Array (buffer); // 只使用从字节 9 开始的缓冲器 var int16s = new Int16Array (buffer, 9); // 只使用从字节 9 到字节 18 的缓冲器 var uint16s = new Uint16Array (buffer, 9, 10);

能够指定缓冲器中可用的字节段，意味着能在同一个缓冲器中保存不同类型的数值。比如，下面的代码就是在缓冲器的开头保存 8 位整数，而在其他字节中保存 16 位整数。

// 使用缓冲器的一部分保存 8 位整数，另一部分保存 16 位整数 var int8s = new Int8Array (buffer, 0, 10); var uint16s = new Uint16Array (buffer, 11, 10);

每个视图构造函数都有一个名为 BYTES_PER_ELEMENT 的属性，表示类型化数组的每个元素需要多少字节。因此，Uint8Array.BYTES_PER_ELEMENT 就是 1，而 Float32Array.BYTES_PER_ELEMENT 则为 4。可以利用这个属性来辅助初始化。

// 需要 10 个元素空间 var int8s = new Int8Array (buffer, 0, 10 * Int8Array.BYTES_PER_ELEMENT); // 需要 5 个元素空间 var uint16s = new Uint16Array (buffer, int8s.byteOffset + int8s.byteLength, 5 * Uint16Array.BYTES_PER_ELEMENT);

以上代码基于同一个数组缓冲器创建了两个视图。缓冲器的前 10B 用于保存 8 位整数，而其他字节用于保存无符号 16 位整数。在初始化 Uint16Array 的时候，使用了 Int8Array 的 byteOffset 和 byteLength 属性，以确保 uint16s 开始于 8 位数据之后。

如前所述，类型化视图的目的在于简化对二进制数据的操作。除了前面看到的优点之外，创建类型化视图还可以不用首先创建 ArrayBuffer 对象。只要传入希望数组保存的元素数，相应的构造函数就可以自动创建一个包含足够字节数的 ArrayBuffer 对象，例如：

// 创建一个数组保存 10 个 8 位整数（10 字节） var int8s = new Int8Array (10); // 创建一个数组保存 10 个 16 位整数（20 字节） var int16s = new Int16Array (10);

另外，也可以把常规数组转换为类型化视图，只要把常规数组传入类型化视图的构造函数即可：

// 创建一个数组保存 5 个 8 位整数（10 字节） var int8s = new Int8Array ([10, 20, 30, 40, 50]);

这是用默认值来初始化类型化视图的最佳方式，也是 WebGL 项目中最常用的方式。

以这种方式来使用类型化视图，可以让它们看起来更像 Array 对象，同时也能确保在读写信息的时候使用正确的数据类型。

使用类型化视图时，可以通过方括号语法访问每一个数据成员，可以通过 length 属性确定数组中有多少元素。这样，对类型化视图的迭代与对 Array 对象的迭代就是一样的了。

for (var i=0, len=int8s.length; i < len; i++){ console.log("Value at position " + i + " is " + int8s[i]); }

当然，也可以使用方括号语法为类型化视图的元素赋值。如果为相应元素指定的字节数放不下相应的值，则实际保存的值是最大可能值的模。例如，无符号 16 位整数所能表示的最大数值是 65535，如果你想保存 65536，那实际保存的值是 0；如果你想保存 65537，那实际保存的值是 1，依此类推。

var uint16s = new Uint16Array(10); uint16s[0] = 65537; alert(uint16s[0]); //1

数据类型不匹配时不会抛出错误，所以你必须自己保证所赋的值不会超过相应元素的字节限制。

类型化视图还有一个方法，即 subarray ()，使用这个方法可以基于底层数组缓冲器的子集创建一个新视图。这个方法接收两个参数：开始元素的索引和可选的结束元素的索引。返回的类型与调用该方法的视图类型相同。例如：

var uint16s = new Uint16Array(10), sub = uint16s.subarray(2, 5);

在以上代码中，sub 也是 Uint16Array 的一个实例，而且底层与 uint16s 都基于同一个 ArrayBuffer。通过大视图创建小视图的主要好处就是，在操作大数组中的一部分元素时，无需担心意外修改了其他元素。

类型化数组是 WebGL 项目中执行各种操作的重要基础。

15.3.2　WebGL 上下文

目前，在支持的浏览器中，WebGL 的名字叫 "experimental-webgl"，这是因为 WebGL 规范仍然未制定完成。制定完成后，这个上下文的名字就会变成简单的 "webgl"。如果浏览器不支持 WebGL，那么取得该上下文时会返回 null。在使用 WebGL 上下文时，务必先检测一下返回值。

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var gl = drawing.getContext ("experimental-webgl"); if (gl){// 使用 WebGL} }

WebGLExample01.htm

一般都把 WebGL 上下文对象命名为 gl。大多数 WebGL 应用和示例都遵守这一约定，因为 OpenGL ES 2.0 规定的方法和值通常都以 "gl" 开头。这样做也可以保证 JavaScript 代码与 OpenGL 程序更相近。

取得了 WebGL 上下文之后，就可以开始 3D 绘图了。如前所述，WebGL 是 OpenGL ES 2.0 的 Web 版，因此本节讨论的概念实际上就是 OpenGL 概念在 JavaScript 中的实现。

通过给 getContext () 传递第二个参数，可以为 WebGL 上下文设置一些选项。这个参数本身是一个对象，可以包含下列属性。

alpha：值为 true，表示为上下文创建一个 Alpha 通道缓冲区；默认值为 true。

depth：值为 true，表示可以使用 16 位深缓冲区；默认值为 true。

stencil：值为 true，表示可以使用 8 位模板缓冲区；默认值为 false。

antialias：值为 true，表示将使用默认机制执行抗锯齿操作；默认值为 true。

premultipliedAlpha：值为 true，表示绘图缓冲区有预乘 Alpha 值；默认值为 true。

preserveDrawingBuffer：值为 true，表示在绘图完成后保留绘图缓冲区；默认值为 false。建议确实有必要的情况下再开启这个值，因为可能影响性能。

传递这个选项对象的方式如下：

var drawing = document.getElementById ("drawing"); // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){var gl = drawing.getContext ("experimental-webgl", { alpha: false}); if (gl){// 使用 WebGL} }

WebGLExample01.htm

大多数上下文选项只在高级技巧中使用。很多时候，各个选项的默认值就能满足我们的要求。

如果 getContext () 无法创建 WebGL 上下文，有的浏览器会抛出错误。为此，最好把调用封装到一个 try-catch 块中。

Insert IconMargin [download] var drawing = document.getElementById ("drawing"), gl; // 确定浏览器支持 <canvas> 元素 if (drawing.getContext){try { gl = drawing.getContext ("experimental-webgl"); } catch (ex) {// 什么也不做} if (gl){// 使用 WebGL} else {alert ("WebGL context could not be created."); } }

WebGLExample01.htm

1. 常量

如果你熟悉 OpenGL，那肯定会对各种操作中使用非常多的常量印象深刻。这些常量在 OpenGL 中都带前缀 GL_。在 WebGL 中，保存在上下文对象中的这些常量都没有 GL_前缀。比如说，GL_COLOR_BUFFER_BIT 常量在 WebGL 上下文中就是 gl.COLOR_BUFFER_BIT。WebGL 以这种方式支持大多数 OpenGL 常量（有一部分常量是不支持的）。

2. 方法命名

OpenGL（以及 WebGL）中的很多方法都试图通过名字传达有关数据类型的信息。如果某方法可以接收不同类型及不同数量的参数，看方法名的后缀就可以知道。方法名的后缀会包含参数个数（1 到 4）和接收的数据类型（f 表示浮点数，i 表示整数）。例如，gl.uniform4f () 意味着要接收 4 个浮点数，而 gl.uniform3i () 则表示要接收 3 个整数。

也有很多方法接收数组参数而非一个个单独的参数。这样的方法其名字中会包含字母 v（即 vector，矢量）。因此，gl.uniform3iv () 可以接收一个包含 3 个值的整数数组。请大家记住以上命名约定，这样对理解后面关于 WebGL 的讨论很有帮助。

3. 准备绘图

在实际操作 WebGL 上下文之前，一般都要使用某种实色清除 <canvas>，为绘图做好准备。为此，首先必须使用 clearColor () 方法来指定要使用的颜色值，该方法接收 4 个参数：红、绿、蓝和透明度。每个参数必须是一个 0 到 1 之间的数值，表示每种分量在最终颜色中的强度。来看下面的例子。

gl.clearColor(0,0,0,1); //black gl.clear(gl.COLOR_BUFFER_BIT);

WebGLExample01.htm

以上代码把清理颜色缓冲区的值设置为黑色，然后调用了 clear () 方法，这个方法与 OpenGL 中的 glClear () 等价。传入的参数 gl.COLOR_BUFFER_BIT 告诉 WebGL 使用之前定义的颜色来填充相应区域。一般来说，都要先清理缓冲区，然后再执行其他绘图操作。

4. 视口与坐标

开始绘图之前，通常要先定义 WebGL 的视口（viewport）。默认情况下，视口可以使用整个 <canvas> 区域。要改变视口大小，可以调用 viewport () 方法并传入 4 个参数：（视口相对于 < canvas> 元素的）x 坐标、y 坐标、宽度和高度。例如，下面的调用就使用了 <canvas> 元素：

gl.viewport(0, 0, drawing.width, drawing.height);

视口坐标与我们通常熟悉的网页坐标不一样。视口坐标的原点 (0,0) 在 <canvas> 元素的左下角，x 轴和 y 轴的正方向分别是向右和向上，可以定义为 (width-1, height-1)，如图 15-15 所示。

图　15-15

知道怎么定义视口大小，就可以只在 <canvas> 元素的部分区域中绘图。来看下面的例子。

// 视口是 <canvas> 左下角的四分之一区域 gl.viewport (0, 0, drawing.width/2, drawing.height/2); // 视口是 <canvas> 左上角的四分之一区域 gl.viewport (0, drawing.height/2, drawing.width/2, drawing.height/2); // 视口是 <canvas> 右下角的四分之一区域 gl.viewport (drawing.width/2, 0, drawing.width/2, drawing.height/2);

另外，视口内部的坐标系与定义视口的坐标系也不一样。在视口内部，坐标原点 (0,0) 是视口的中心点，因此视口左下角坐标为 (-1,-1)，而右上角坐标为 (1,1)，如图 15-16 所示。

图　15-16

如果在视口内部绘图时使用视口外部的坐标，结果可能会被视口剪切。比如，要绘制的形状有一个顶点在 (1,2)，那么该形状在视口右侧的部分会被剪切掉。

5. 缓冲区

顶点信息保存在 JavaScript 的类型化数组中，使用之前必须转换到 WebGL 的缓冲区。要创建缓冲区，可以调用 gl.createBuffer ()，然后使用 gl.bindBuffer () 绑定到 WebGL 上下文。这两步做完之后，就可以用数据来填充缓冲区了。例如：

var buffer = gl.createBuffer(); gl.bindBuffer(gl.ARRAY_BUFFER, buffer); gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([0, 0.5, 1]), gl.STATIC_DRAW);

调用 gl.bindBuffer () 可以将 buffer 设置为上下文的当前缓冲区。此后，所有缓冲区操作都直接在 buffer 中执行。因此，调用 gl.bufferData () 时不需要明确传入 buffer 也没有问题。最后一行代码使用 Float32Array 中的数据初始化了 buffer（一般都是用 Float32Array 来保存顶点信息）。如果想使用 drawElements () 输出缓冲区的内容，也可以传入 gl.ELEMENT_ARRAY_BUFFER。

gl.bufferData () 的最后一个参数用于指定使用缓冲区的方式，取值范围是如下几个常量。

gl.STATIC_DRAW：数据只加载一次，在多次绘图中使用。

gl.STREAM_DRAW：数据只加载一次，在几次绘图中使用。

gl.DYNAMIC_DRAW：数据动态改变，在多次绘图中使用。

如果不是非常有经验的 OpenGL 程序员，多数情况下将缓冲区使用方式设置为 gl.STATIC_DRAW 即可。

在包含缓冲区的页面重载之前，缓冲区始终保留在内存中。如果你不想要某个缓冲区了，可以直接调用 gl.deleteBuffer () 释放内存：

gl.deleteBuffer(buffer);

6. 错误

JavaScript 与 WebGL 之间的一个最大的区别在于，WebGL 操作一般不会抛出错误。为了知道是否有错误发生，必须在调用某个可能出错的方法后，手工调用 gl.getError () 方法。这个方法返回一个表示错误类型的常量。可能的错误常量如下。

gl.NO_ERROR：上一次操作没有发生错误（值为 0）。

gl.INVALID_ENUM：应该给方法传入 WebGL 常量，但却传错了参数。

gl.INVALID_VALUE：在需要无符号数的地方传入了负值。

gl.INVALID_OPERATION：在当前状态下不能完成操作。

gl.OUT_OF_MEMORY：没有足够的内存完成操作。

gl.CONTEXT_LOST_WEBGL：由于外部事件（如设备断电）干扰丢失了当前 WebGL 上下文。

每次调用 gl.getError () 方法返回一个错误值。第一次调用后，后续对 gl.getError () 的调用可能会返回另一个错误值。如果发生了多个错误，需要反复调用 gl.getError () 直至它返回 gl.NO_ERROR。在执行了很多操作的情况下，最好通过一个循环来调用 getError ()，如下所示：

var errorCode = gl.getError(); while(errorCode){ console.log("Error occurred: " + errorCode); errorCode = gl.getError(); }

如果 WebGL 脚本输出不正确，那在脚本中放几行 gl.getError () 有助于找出问题所在。

7. 着色器

着色器（shader）是 OpenGL 中的另一个概念。WebGL 中有两种着色器：顶点着色器和片段（或像素）着色器。顶点着色器用于将 3D 顶点转换为需要渲染的 2D 点。片段着色器用于准确计算要绘制的每个像素的颜色。WebGL 着色器的独特之处也是其难点在于，它们并不是用 JavaScript 写的。这些着色器是使用 GLSL（OpenGL Shading Language，OpenGL 着色语言）写的，GLSL 是一种与 C 和 JavaScript 完全不同的语言。

8. 编写着色器

GLSL 是一种类 C 语言，专门用于编写 OpenGL 着色器。因为 WebGL 是 OpenGL ES 2.0 的实现，所以 OpenGL 中使用的着色器可以直接在 WebGL 中使用。这样就方便了将桌面图形应用移植到浏览器中。

每个着色器都有一个 main () 方法，该方法在绘图期间会重复执行。为着色器传递数据的方式有两种：Attribute 和 Uniform。通过 Attribute 可以向顶点着色器中传入顶点信息，通过 Uniform 可以向任何着色器传入常量值。Attribute 和 Uniform 在 main () 方法外部定义，分别使用关键字 attribute 和 uniform。在这两个值类型关键字之后，是数据类型和变量名。下面是一个简单的顶点着色器的例子。

//OpenGL 着色语言 // 着色器，作者 Bartek Drozdz，摘自他的文章 //http://www.netmagazine.com/tutorials/get-started-webgl-draw-square attribute vec2 aVertexPosition; void main () { gl_Position = vec4 (aVertexPosition, 0.0, 1.0); }

WebGLExample02.htm

这个顶点着色器定义了一个名为 aVertexPosition 的 Attribute，这个 Attribute 是一个数组，包含两个元素（数据类型为 vec2），表示 x 和 y 坐标。即使只接收到两个坐标，顶点着色器也必须把一个包含四方面信息的顶点赋值给特殊变量 gl_Position。这里的着色器创建了一个新的包含四个元素的数组（vec4），填补缺失的坐标，结果是把 2D 坐标转换成了 3D 坐标。

除了只能通过 Uniform 传入数据外，片段着色器与顶点着色器类似。以下是片段着色器的例子。

//OpenGL 着色语言 // 着色器，作者 Bartek Drozdz，摘自他的文章 //http://www.netmagazine.com/tutorials/get-started-webgl-draw-square uniform vec4 uColor; void main () { gl_FragColor = uColor;}

WebGLExample02.htm

片段着色器必须返回一个值，赋给变量 gl_FragColor，表示绘图时使用的颜色。这个着色器定义了一个包含四方面信息（vec4）的统一的颜色 uColor。从以上代码看，这个着色器除了把传入的值赋给 gl_FragColor 什么也没做。uColor 的值在这个着色器内部不能改变。

OpenGL 着色语言比这里看到的还要复杂。专门讲解这门语言的书有很多，本节只是从辅助使用 WebGL 的角度简要介绍一下该语言。要了解更多信息，请参考 Randi J. Rost 编著的 OpenGL Shading Language（Addison-Wesley,2006）。

9. 编写着色器程序

浏览器不能理解 GLSL 程序，因此必须准备好字符串形式的 GLSL 程序，以便编译并链接到着色器程序。为便于使用，通常是把着色器包含在页面的 <script> 标签内，并为该标签指定一个自定义的 type 属性。由于无法识别 type 属性值，浏览器不会解析 <script> 标签中的内容，但这不影响你读写其中的代码。例如：

<script type="x-webgl/x-vertex-shader" id="vertexShader"> attribute vec2 aVertexPosition; void main() { gl_Position = vec4(aVertexPosition, 0.0, 1.0); } </script> <script type="x-webgl/x-fragment-shader" id="fragmentShader"> uniform vec4 uColor; void main() { gl_FragColor = uColor; } </script>

WebGLExample02.htm

然后，可以通过 text 属性提取出 <script> 元素的内容：

var vertexGlsl = document.getElementById("vertexShader").text, fragmentGlsl = document.getElementById("fragmentShader").text;

复杂一些的 WebGL 应用可能会通过 Ajax（详见第 21 章）动态加载着色器。而使用着色器的关键是要有字符串形式的 GLSL 程序。

取得了 GLSL 字符串之后，接下来就是创建着色器对象。要创建着色器对象，可以调用 gl.createShader () 方法并传入要创建的着色器类型（gl.VERTEX_SHADER 或 gl.FRAGMENT_SHADER）。编译着色器使用的是 gl.compileShader ()。请看下面的例子。

var vertexShader = gl.createShader(gl.VERTEX_SHADER); gl.shaderSource(vertexShader, vertexGlsl); gl.compileShader(vertexShader); var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER); gl.shaderSource(fragmentShader, fragmentGlsl); gl.compileShader(fragmentShader);

WebGLExample02.htm

以上代码创建了两个着色器，并将它们分别保存在 vertexShader 和 fragmentShader 中。而使用下列代码，可以把这两个对象链接到着色器程序中。

var program = gl.createProgram(); gl.attachShader(program, vertexShader); gl.attachShader(program, fragmentShader); gl.linkProgram(program);

WebGLExample02.htm

第一行代码创建了程序，然后调用 attachShader () 方法又包含了两个着色器。最后调用 gl.linkProgram () 则把两个着色器封装到了变量 program 中。链接完程序之后，就可以通过 gl.useProgram () 方法通知 WebGL 使用这个程序了。

gl.useProgram(program);

调用 gl.useProgram () 方法后，所有后续的绘图操作都将使用这个程序。

10. 为着色器传入值

前面定义的着色器都必须接收一个值才能工作。为了给着色器传入这个值，必须先找到要接收这个值的变量。对于 Uniform 变量，可以使用 gl.getUniformLocation ()，这个方法返回一个对象，表示 Uniform 变量在内存中的位置。然后可以基于变量的位置来赋值。例如：

var uColor = gl.getUniformLocation(program, "uColor"); gl.uniform4fv(uColor, [0, 0, 0, 1]);

WebGLExample02.htm

第一行代码从 program 中找到 Uniform 变量 uColor，返回了它在内存中的位置。第二行代码使用 gl.uniform4fv () 给 uColor 赋值。

对于顶点着色器中的 Attribute 变量，也是差不多的赋值过程。要找到 Attribute 变量在内存中的位置，可以调用 gl.getAttribLocation ()。取得了位置之后，就可以像下面这样赋值了：

var aVertexPosition = gl.getAttribLocation(program, "aVertexPosition"); gl.enableVertexAttribArray(aVertexPosition); gl.vertexAttribPointer(aVertexPosition, itemSize, gl.FLOAT, false, 0, 0);

WebGLExample02.htm

在此，我们取得了 aVertexPosition 的位置，然后又通过 gl.enableVertexAttribArray () 启用它。最后一行创建了指针，指向由 gl.bindBuffer () 指定的缓冲区，并将其保存在 aVertexPosition 中，以便顶点着色器使用。

11. 调试着色器和程序

与 WebGL 中的其他操作一样，着色器操作也可能会失败，而且也是静默失败。如果你想知道着色器或程序执行中是否发生了错误，必须亲自询问 WebGL 上下文。

对于着色器，可以在操作之后调用 gl.getShaderParameter ()，取得着色器的编译状态：

if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)){ alert(gl.getShaderInfoLog(vertexShader)); }

WebGLExample02.htm

这个例子检测了 vertexShader 的编译状态。如果着色器编译成功，调用 gl.getShaderParameter () 会返回 true。如果返回的是 false，说明编译期间发生了错误，此时调用 gl.getShaderInfoLog () 并传入相应的着色器就可以取得错误消息。错误消息就是一个表示问题所在的字符串。无论是顶点着色器，还是片段着色器，都可以使用 gl.getShaderParameter () 和 gl.getShaderInfoLog () 方法。

程序也可能会执行失败，因此也有类似的方法 ——gl.getProgramParameter ()，可以用来检测执行状态。最常见的程序失败发生在链接过程中，要检测链接错误，可以使用下列代码。

if (!gl.getProgramParameter(program, gl.LINK_STATUS)){ alert(gl.getProgramInfoLog(program)); }

WebGLExample02.htm

与 gl.getShaderParameter () 类似，gl.getProgramParameter () 返回 true 表示链接成功，返回 false 表示链接失败。同样，也有一个 gl.getProgramInfoLog () 方法，用于捕获程序失败的消息。

以上介绍的这些方法主要在开发过程中用于调试。只要没有依赖外部代码，就可以放心地把它们从产品代码中删除。

12. 绘图

WebGL 只能绘制三种形状：点、线和三角。其他所有形状都是由这三种基本形状合成之后，再绘制到三维空间中的。执行绘图操作要调用 gl.drawArrays () 或 gl.drawElements () 方法，前者用于数组缓冲区，后者用于元素数组缓冲区。

gl.drawArrays () 或 gl.drawElements () 的第一个参数都是一个常量，表示要绘制的形状。可取值的常量范围包括以下这些。

gl.POINTS：将每个顶点当成一个点来绘制。

gl.LINES：将数组当成一系列顶点，在这些顶点间画线。每个顶点既是起点也是终点，因此数组中必须包含偶数个顶点才能完成绘制。

gl.LINE_LOOP：将数组当成一系列顶点，在这些顶点间画线。线条从第一个顶点到第二个顶点，再从第二个顶点到第三个顶点，依此类推，直至最后一个顶点。然后再从最后一个顶点到第一个顶点画一条线。结果就是一个形状的轮廓。

gl.LINE_STRIP：除了不画最后一个顶点与第一个顶点之间的线之外，其他与 gl.LINE_LOOP 相同。

gl.TRIANGLES：将数组当成一系列顶点，在这些顶点间绘制三角形。除非明确指定，每个三角形都单独绘制，不与其他三角形共享顶点。

gl.TRIANGLES_STRIP：除了将前三个顶点之后的顶点当作第三个顶点与前两个顶点共同构成一个新三角形外，其他都与 gl.TRIANGLES 相同。例如，如果数组中包含 A、B、C、D 四个顶点，则第一个三角形连接 ABC，而第二个三角形连接 BCD。

gl. TRIANGLES_FAN：除了将前三个顶点之后的顶点当作第三个顶点与前一个顶点及第一个顶点共同构成一个新三角形外，其他都与 gl.TRIANGLES 相同。例如，如果数组中包含 A、B、C、D 四个顶点，则第一个三角形连接 ABC，而第二个三角形连接 ACD。

gl.drawArrays () 方法接收上面列出的常量中的一个作为第一个参数，接收数组缓冲区中的起始索引作为第二个参数，接收数组缓冲区中包含的顶点数（点的集合数）作为第三个参数。下面的代码使用 gl.drawArrays () 在画布上绘制了一个三角形。

// 假设已经使用本节前面定义的着色器清除了视口 // 定义三个顶点以及每个顶点的 x 和 y 坐标 var vertices = new Float32Array ([0, 1, 1, -1, -1, -1]), buffer = gl.createBuffer (), vertexSetSize = 2, vertexSetCount = vertices.length/vertexSetSize, uColor, aVertexPosition; // 把数据放到缓冲区 gl.bindBuffer (gl.ARRAY_BUFFER, buffer); gl.bufferData (gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW); // 为片段着色器传入颜色值 uColor = gl.getUniformLocation (program, "uColor"); gl.uniform4fv (uColor, [ 0, 0, 0, 1]); // 为着色器传入顶点信息 aVertexPosition = gl.getAttribLocation (program, "aVertexPosition"); gl.enableVertexAttribArray (aVertexPosition); gl.vertexAttribPointer (aVertexPosition, vertexSetSize, gl.FLOAT, false, 0, 0); // 绘制三角形 gl.drawArrays (gl.TRIANGLES, 0, vertexSetCount);

WebGLExample02.htm

这个例子定义了一个 Float32Array，包含三组顶点（每个顶点由两点表示）。这里关键是要知道顶点的大小及数量，以便将来计算时使用。把 vertexSetSize 设置为 2 之后，就可以计算出 vertexSetCount 的值。把顶点的信息保存在缓冲区中后，又把颜色信息传给了片段着色器。

接下来，给顶点着色器传入顶点大小以及 gl.FLOAT，后者表示顶点坐标是浮点数。传入的第四个参数是一个布尔值，false 在此表示坐标不是标准化的。第五个参数是步长值（stride value），表示取得下一个值的时候，要跳过多少个数组元素。除非你真需要跳过数组元素，否则传入 0 即可。最后一个参数是起点偏移量，值为 0 表示从第一个元素开始。

最后一步就是使用 gl.drawArrays () 绘制三角形。传入 gl.TRIANGLES 作为第一个参数，表示在 (0,1)、(1,-1) 和 (-1,-1) 点之间绘制三角形，并使用传给片段着色器的颜色来填充它。第二个参数是缓冲区中的起点偏移量，最后一个参数是要读取的顶点总数。这次绘图操作的结果如图 15-17 所示。

图　15-17

通过修改 gl.drawArrays () 的第一个参数，可以修改绘制三角形的方式。图 15-18 展示了传入不同的参数后可能得到的结果。

图　15-18

13. 纹理

WebGL 的纹理可以使用 DOM 中的图像。要创建一个新纹理，可以调用 gl.createTexture ()，然后再将一幅图像绑定到该纹理。如果图像尚未加载到内存中，可能需要创建一个 Image 对象的实例，以便动态加载图像。图像加载完成之前，纹理不会初始化，因此，必须在 load 事件触发后才能设置纹理。例如：

var image = new Image (), texture; image.src = "smile.gif"; image.onload = function (){texture = gl.createTexture (); gl.bindTexture (gl.TEXTURE_2D, texture); gl.pixelStorei (gl.UNPACK_FLIP_Y_WEBGL, true); gl.texImage2D (gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image); gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST); gl.texParameteri (gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST); // 清除当前纹理 gl.bindTexture (gl.TEXTURE_2D, null); }

除了使用 DOM 中的图像之外，以上步骤与在 OpenGL 中创建纹理的步骤相同。最大的差异是使用 gl.pixelStore1 () 设置像素存储格式。gl.UNPACK_FLIP_Y_WEBGL 是 WebGL 独有的常量，在加载 Web 中的图像时，多数情况下都必须使用这个常量。这主要是因为 GIF、JPEG 和 PNG 图像与 WebGL 使用的坐标系不一样，如果没有这个标志，解析图像时就会发生混乱。

用作纹理的图像必须与包含页面来自同一个域，或者是保存在启用了 CORS（Cross-Origin Resource Sharing，跨域资源共享）的服务器上。第 21 章将讨论 CORS。

图像、加载到 <video> 元素中的视频，甚至其他 <canvas> 元素都可以用作纹理。跨域资源限制同样适用于视频。

14. 读取像素

与 2D 上下文 类似，通过 WebGL 上下文也能读取像素值。读取像素值的方法 readPixels () 与 OpenGL 中的同名方法只有一点不同，即最后一个参数必须是类型化数组。像素信息是从帧缓冲区读取的，然后保存在类型化数组中。readPixels () 方法的参数有：x、 y、宽度、高度、图像格式、数据类型和类型化数组。前 4 个参数指定读取哪个区域中的像素。图像格式参数几乎总是 gl.RGBA。数据类型参数用于指定保存在类型化数组中的数据的类型，但有以下限制。

如果类型是 gl.UNSIGNED_BYTE，则类型化数组必须是 Uint8Array。

如果类型是 gl.UNSIGNED_SHORT_5_6_5、gl.UNSIGNED_SHORT_4_4_4_4 或 gl.UNSIGNED_SHORT_5_5_5_1，则类型化数组必须是 Uint16Array。

下面是一个简单的例子。

var pixels = new Uint8Array(25*25); gl.readPixels(0, 0, 25, 25, gl.RGBA, gl.UNSIGNED_BYTE, pixels);

以上代码从帧缓冲区中读取了 25×25 像素的区域，将读取到的像素信息保存到了 pixels 数组中。其中，每个像素的颜色由 4 个数组元素表示，分别代表红、绿、蓝和透明度。每个数组元素的值介于 0 到 255 之间（包含 0 和 255）。不要忘了根据返回的数据大小初始化类型化数组。

在浏览器绘制更新的 WebGL 图像之前调用 readPixels () 不会有什么意外。绘制发生后，帧缓冲区会恢复其原始的干净状态，而调用 readPixels () 返回的像素数据反映的就是清除缓冲区后的状态。如果你想在绘制发生后读取像素数据，那在初始化 WebGL 上下文时必须传入适当的 preserveDrawingBuffer 选项（前面讨论过）。

var gl = drawing.getContext("experimental-webgl", { preserveDrawingBuffer: true; });

设置这个标志的意思是让帧缓冲区在下一次绘制之前，保留其最后的状态。这个选项会导致性能损失，因此能不用最好不要用。

15.3.3　支持

Firefox 4 + 和 Chrome 都实现了 WebGL API。Safari 5.1 也实现了 WebGL，但默认是禁用的。WebGL 比较特别的地方在于，某个浏览器的某个版本实现了它，并不一定意味着就真能使用它。某个浏览器支持 WebGL，至少意味着两件事：首先，浏览器本身必须实现了 WebGL API；其次，计算机必须升级显示驱动程序。运行 Windows XP 等操作系统的一些老机器，其驱动程序一般都不是最新的。因此，这些计算机中的浏览器都会禁用 WebGL。从稳妥的角度考虑，在使用 WebGL 之前，最好检测其是否得到了支持，而不是只检测特定的浏览器版本。

大家别忘了，WebGL 还是一个正在制定和发展中的规范。不管是函数名、函数签名，还是数据类型，都有可能改变。可以说，WebGL 目前只适合实验性地学习，不适合真正开发和应用。

15.4　小结

HTML5 的 <canvas> 元素提供了一组 JavaScript API，让我们可以动态地创建图形和图像。图形是在一个特定的上下文中创建的，而上下文对象目前有两种。第一种是 2D 上下文，可以执行原始的绘图操作，比如：

设置填充、描边颜色和模式

绘制矩形

绘制路径

绘制文本

创建渐变和模式

第二种是 3D 上下文，即 WebGL 上下文。WebGL 是从 OpenGL ES 2.0 移植到浏览器中的，而 OpenGL ES 2.0 是游戏开发人员在创建计算机图形图像时经常使用的一种语言。WebGL 支持比 2D 上下文更丰富和更强大的图形图像处理能力，比如：

用 GLSL（OpenGL Shading Language，OpenGL 着色语言）编写的顶点和片段着色器

支持类型化数组，即能够将数组中的数据限定为某种特定的数值类型

创建和操作纹理

目前，主流浏览器的较新版本大都已经支持 <canvas> 标签。同样地，这些版本的浏览器基本上也都支持 2D 上下文。但对于 WebGL 而言，目前还只有 Firefox 4 + 和 Chrome 支持它。

第 16 章　HTML5 脚本编程

本章内容

使用跨文档消息传递

拖放 API

音频与视频

本书前面讨论过，HTML5 规范定义了很多新 HTML 标记。为了配合这些标记的变化，HTML5 规范也用显著篇幅定义了很多 JavaScript API。定义这些 API 的用意就是简化此前实现起来困难重重的任务，最终简化创建动态 Web 界面的工作。

16.1　跨文档消息传递

跨文档消息传送（cross-document messaging），有时候简称为 XDM，指的是在来自不同域的页面间传递消息。例如，www.wrox.com 域中的页面与位于一个内嵌框架中的 p2p.wrox.com 域中的页面通信。在 XDM 机制出现之前，要稳妥地实现这种通信需要花很多工夫。XDM 把这种机制规范化，让我们能既稳妥又简单地实现跨文档通信。

XDM 的核心是 postMessage () 方法。在 HTML5 规范中，除了 XDM 部分之外的其他部分也会提到这个方法名，但都是为了同一个目的：向另一个地方传递数据。对于 XDM 而言，「另一个地方」指的是包含在当前页面中的 <iframe> 元素，或者由当前页面弹出的窗口。

postMessage () 方法接收两个参数：一条消息和一个表示消息接收方来自哪个域的字符串。第二个参数对保障安全通信非常重要，可以防止浏览器把消息发送到不安全的地方。来看下面的例子。

// 注意：所有支持 XDM 的浏览器也支持 iframe 的 contentWindow 属性 var iframeWindow = document.getElementById ("myframe").contentWindow; iframeWindow.postMessage ("A secret", "http://www.wrox.com");

最后一行代码尝试向内嵌框架中发送一条消息，并指定框架中的文档必须来源于 "http://www.wrox.com" 域。如果来源匹配，消息会传递到内嵌框架中；否则，postMessage () 什么也不做。这一限制可以避免窗口中的位置在你不知情的情况下发生改变。如果传给 postMessage () 的第二个参数是 "*"，则表示可以把消息发送给来自任何域的文档，但我们不推荐这样做。

接收到 XDM 消息时，会触发 window 对象的 message 事件。这个事件是以异步形式触发的，因此从发送消息到接收消息（触发接收窗口的 message 事件）可能要经过一段时间的延迟。触发 message 事件后，传递给 onmessage 处理程序的事件对象包含以下三方面的重要信息。

data：作为 postMessage () 第一个参数传入的字符串数据。

origin：发送消息的文档所在的域，例如 "http://www.wrox.com"。

source：发送消息的文档的 window 对象的代理。这个代理对象主要用于在发送上一条消息的窗口中调用 postMessage () 方法。如果发送消息的窗口来自同一个域，那这个对象就是 window。

接收到消息后验证发送窗口的来源是至关重要的。就像给 postMessage () 方法指定第二个参数，以确保浏览器不会把消息发送给未知页面一样，在 onmessage 处理程序中检测消息来源可以确保传入的消息来自已知的页面。基本的检测模式如下。

EventUtil.addHandler (window, "message", function (event){// 确保发送消息的域是已知的域 if (event.origin == "http://www.wrox.com"){// 处理接收到的数据 processMessage (event.data); // 可选：向来源窗口发送回执 event.source.postMessage ("Received!", "http://p2p.wrox.com"); } });

还是要提醒大家，event.source 大多数情况下只是 window 对象的代理，并非实际的 window 对象。换句话说，不能通过这个代理对象访问 window 对象的其他任何信息。记住，只通过这个代理调用 postMessage () 就好，这个方法永远存在，永远可以调用。

XDM 还有一些怪异之处。首先，postMessage () 的第一个参数最早是作为「永远都是字符串」来实现的。但后来这个参数的定义改了，改成允许传入任何数据结构。可是，并非所有浏览器都实现了这一变化。为保险起见，使用 postMessage () 时，最好还是只传字符串。如果你想传入结构化的数据，最佳选择是先在要传入的数据上调用 JSON.stringify ()，通过 postMessage () 传入得到的字符串，然后再在 onmessage 事件处理程序中调用 JSON.parse ()。

在通过内嵌框架加载其他域的内容时，使用 XDM 是非常方便的。因此，在混搭（mashup）和社交网络应用中，这种传递消息的方法极为常用。有了 XDM，包含 <iframe> 的页面可以确保自身不受恶意内容的侵扰，因为它只通过 XDM 与嵌入的框架通信。而 XDM 也可以在来自相同域的页面间使用。

支持 XDM 的浏览器有 IE8+、Firefox 3.5+、Safari 4+、Opera、Chrome、iOS 版 Safari 及 Android 版 WebKit。XDM 已经作为一个规范独立出来，现在它的名字叫 Web Messaging，官方页面是 http://dev.w3.org/html5/postmsg/。

16.2　原生拖放

最早在网页中引入 JavaScript 拖放功能的是 IE4。当时，网页中只有两种对象可以拖放：图像和某些文本。拖动图像时，把鼠标放在图像上，按住鼠标不放就可以拖动它。拖动文本时，要先选中文本，然后可以像拖动图像一样拖动被选中的文本。在 IE 4 中，唯一有效的放置目标是文本框。到了 IE5，拖放功能得到扩展，添加了新的事件，而且几乎网页中的任何元素都可以作为放置目标。IE5.5 更进一步，让网页中的任何元素都可以拖放。（IE6 同样也支持这些功能。）HTML5 以 IE 的实例为基础制定了拖放规范。Firefox 3.5、Safari 3 + 和 Chrome 也根据 HTML5 规范实现了原生拖放功能。

说到拖放，最有意思的恐怕就是能够在框架间、窗口间，甚至在应用间拖放网页元素了。浏览器对拖放的支持为实现这些功能提供了便利。

16.2.1　拖放事件

通过拖放事件，可以控制拖放相关的各个方面。其中最关键的地方在于确定哪里发生了拖放事件，有些事件是在被拖动的元素上触发的，而有些事件是在放置目标上触发的。拖动某元素时，将依次触发下列事件：

dragstart

drag

dragend

按下鼠标键并开始移动鼠标时，会在被拖放的元素上触发 dragstart 事件。此时光标变成「不能放」符号（圆环中有一条反斜线），表示不能把元素放到自己上面。拖动开始时，可以通过 ondragstart 事件处理程序来运行 JavaScript 代码。

触发 dragstart 事件后，随即会触发 drag 事件，而且在元素被拖动期间会持续触发该事件。这个事件与 mousemove 事件相似，在鼠标移动过程中，mousemove 事件也会持续发生。当拖动停止时（无论是把元素放到了有效的放置目标，还是放到了无效的放置目标上），会触发 dragend 事件。

上述三个事件的目标都是被拖动的元素。默认情况下，浏览器不会在拖动期间改变被拖动元素的外观，但你可以自己修改。不过，大多数浏览器会为正被拖动的元素创建一个半透明的副本，这个副本始终跟随着光标移动。

当某个元素被拖动到一个有效的放置目标上时，下列事件会依次发生：

dragenter

dragover

dragleave 或 drop

只要有元素被拖动到放置目标上，就会触发 dragenter 事件（类似于 mouseover 事件）。紧随其后的是 dragover 事件，而且在被拖动的元素还在放置目标的范围内移动时，就会持续触发该事件。如果元素被拖出了放置目标，dragover 事件不再发生，但会触发 dragleave 事件（类似于 mouseout 事件）。如果元素被放到了放置目标中，则会触发 drop 事件而不是 dragleave 事件。上述三个事件的目标都是作为放置目标的元素。

16.2.2　自定义放置目标

在拖动元素经过某些无效放置目标时，可以看到一种特殊的光标（圆环中有一条反斜线），表示不能放置。虽然所有元素都支持放置目标事件，但这些元素默认是不允许放置的。如果拖动元素经过不允许放置的元素，无论用户如何操作，都不会发生 drop 事件。不过，你可以把任何元素变成有效的放置目标，方法是重写 dragenter 和 dragover 事件的默认行为。例如，假设有一个 ID 为 "droptarget" 的 <div> 元素，可以用如下代码将它变成一个放置目标。

var droptarget = document.getElementById("droptarget"); EventUtil.addHandler(droptarget, "dragover", function(event){ EventUtil.preventDefault(event); }); EventUtil.addHandler(droptarget, "dragenter", function(event){ EventUtil.preventDefault(event); });

以上代码执行后，你就会发现当拖动着元素移动到放置目标上时，光标变成了允许放置的符号。当然，释放鼠标也会触发 drop 事件。

在 Firefox 3.5 + 中，放置事件的默认行为是打开被放到放置目标上的 URL。换句话说，如果是把图像拖放到放置目标上，页面就会转向图像文件；而如果是把文本拖放到放置目标上，则会导致无效 URL 错误。因此，为了让 Firefox 支持正常的拖放，还要取消 drop 事件的默认行为，阻止它打开 URL：

EventUtil.addHandler(droptarget, "drop", function(event){ EventUtil.preventDefault(event); });

16.2.3　dataTransfer 对象

只有简单的拖放而没有数据变化是没有什么用的。为了在拖放操作时实现数据交换，IE 5 引入了 dataTransfer 对象，它是事件对象的一个属性，用于从被拖动元素向放置目标传递字符串格式的数据。因为它是事件对象的属性，所以只能在拖放事件的事件处理程序中访问 dataTransfer 对象。在事件处理程序中，可以使用这个对象的属性和方法来完善拖放功能。目前，HTML5 规范草案也收入了 dataTransfer 对象。

dataTransfer 对象有两个主要方法：getData () 和 setData ()。不难想象，getData () 可以取得由 setData () 保存的值。setData () 方法的第一个参数，也是 getData () 方法唯一的一个参数，是一个字符串，表示保存的数据类型，取值为 "text" 或 "URL"，如下所示：

// 设置和接收文本数据 event.dataTransfer.setData ("text", "some text"); var text = event.dataTransfer.getData ("text"); // 设置和接收 URL event.dataTransfer.setData ("URL", "http://www.wrox.com/"); var url = event.dataTransfer.getData ("URL");

IE 只定义了 "text" 和 "URL" 两种有效的数据类型，而 HTML5 则对此加以扩展，允许指定各种 MIME 类型。考虑到向后兼容，HTML5 也支持 "text" 和 "URL"，但这两种类型会被映射为 "text/plain" 和 "text/uri-list"。

实际上，dataTransfer 对象可以为每种 MIME 类型都保存一个值。换句话说，同时在这个对象中保存一段文本和一个 URL 不会有任何问题。不过，保存在 dataTransfer 对象中的数据只能在 drop 事件处理程序中读取。如果在 ondrop 处理程序中没有读到数据，那就是 dataTransfer 对象已经被销毁，数据也丢失了。

在拖动文本框中的文本时，浏览器会调用 setData () 方法，将拖动的文本以 "text" 格式保存在 dataTransfer 对象中。类似地，在拖放链接或图像时，会调用 setData () 方法并保存 URL。然后，在这些元素被拖放到放置目标时，就可以通过 getData () 读到这些数据。当然，作为开发人员，你也可以在 dragstart 事件处理程序中调用 setData ()，手工保存自己要传输的数据，以便将来使用。

将数据保存为文本和保存为 URL 是有区别的。如果将数据保存为文本格式，那么数据不会得到任何特殊处理。而如果将数据保存为 URL，浏览器会将其当成网页中的链接。换句话说，如果你把它放置到另一个浏览器窗口中，浏览器就会打开该 URL。

Firefox 在其第 5 个版本之前不能正确地将 "url" 和 "text" 映射为 "text/uri-list" 和 "text/plain"。但是却能把 "Text"（T 大写）映射为 "text/plain"。为了更好地在跨浏览器的情况下从 dataTransfer 对象取得数据，最好在取得 URL 数据时检测两个值，而在取得文本数据时使用 "Text"。

var dataTransfer = event.dataTransfer; // 读取 URL var url = dataTransfer.getData ("url") ||dataTransfer.getData ("text/uri-list"); // 读取文本 var text = dataTransfer.getData ("Text");

DataTransferExample01.htm

注意，一定要把短数据类型放在前面，因为 IE 10 及之前的版本仍然不支持扩展的 MIME 类型名，而它们在遇到无法识别的数据类型时，会抛出错误。

16.2.4　dropEffect 与 effectAllowed

利用 dataTransfer 对象，可不光是能够传输数据，还能通过它来确定被拖动的元素以及作为放置目标的元素能够接收什么操作。为此，需要访问 dataTransfer 对象的两个属性：dropEffect 和 effectAllowed。

其中，通过 dropEffect 属性可以知道被拖动的元素能够执行哪种放置行为。这个属性有下列 4 个可能的值。

"none"：不能把拖动的元素放在这里。这是除文本框之外所有元素的默认值。

"move"：应该把拖动的元素移动到放置目标。

"copy"：应该把拖动的元素复制到放置目标。

"link"：表示放置目标会打开拖动的元素（但拖动的元素必须是一个链接，有 URL）。

在把元素拖动到放置目标上时，以上每一个值都会导致光标显示为不同的符号。然而，要怎样实现光标所指示的动作完全取决于你。换句话说，如果你不介入，没有什么会自动地移动、复制，也不会打开链接。总之，浏览器只能帮你改变光标的样式，而其他的都要靠你自己来实现。要使用 dropEffect 属性，必须在 ondragenter 事件处理程序中针对放置目标来设置它。

dropEffect 属性只有搭配 effectAllowed 属性才有用。effectAllowed 属性表示允许拖动元素的哪种 dropEffect，effectAllowed 属性可能的值如下。

"uninitialized"：没有给被拖动的元素设置任何放置行为。

"none"：被拖动的元素不能有任何行为。

"copy"：只允许值为 "copy" 的 dropEffect。

"link"：只允许值为 "link" 的 dropEffect。

"move"：只允许值为 "move" 的 dropEffect。

"copyLink"：允许值为 "copy" 和 "link" 的 dropEffect。

"copyMove"：允许值为 "copy" 和 "move" 的 dropEffect。

"linkMove"：允许值为 "link" 和 "move" 的 dropEffect。

"all"：允许任意 dropEffect。

必须在 ondragstart 事件处理程序中设置 effectAllowed 属性。

假设你想允许用户把文本框中的文本拖放到一个 <div> 元素中。首先，必须将 dropEffect 和 effectAllowed 设置为 "move"。但是，由于 <div> 元素的放置事件的默认行为是什么也不做，所以文本不可能自动移动。重写这个默认行为，就能从文本框中移走文本。然后你就可以自己编写代码将文本插入到 <div> 中，这样整个拖放操作就完成了。如果你将 dropEffect 和 effectAllowed 的值设置为 "copy"，那就不会自动移走文本框中的文本。

Firefox 5 及之前的版本在处理 effectAllowed 属性时有一个问题，即如果你在代码中设置了这个属性的值，那不一定会触发 drop 事件。

16.2.5　可拖动

默认情况下，图像、链接和文本是可以拖动的，也就是说，不用额外编写代码，用户就可以拖动它们。文本只有在被选中的情况下才能拖动，而图像和链接在任何时候都可以拖动。

让其他元素可以拖动也是可能的。HTML5 为所有 HTML 元素规定了一个 draggable 属性，表示元素是否可以拖动。图像和链接的 draggable 属性自动被设置成了 true，而其他元素这个属性的默认值都是 false。要想让其他元素可拖动，或者让图像或链接不能拖动，都可以设置这个属性。例如：

<!-- 让这个图像不可以拖动 --> <img src="smile.gif" draggable="false" alt="Smiley face"> <!-- 让这个元素可以拖动 --> <div draggable="true">...</div>

支持 draggable 属性的浏览器有 IE 10+、Firefox 4+、Safari 5 + 和 Chrome。Opera 11.5 及之前的版本都不支持 HTML5 的拖放功能。另外，为了让 Firefox 支持可拖动属性，还必须添加一个 ondragstart 事件处理程序，并在 dataTransfer 对象中保存一些信息。

在 IE9 及更早版本中，通过 mousedown 事件处理程序调用 dragDrop () 能够让任何元素可拖动。而在 Safari 4 及之前版本中，必须额外给相应元素设置 CSS 样式–khtml-user-drag: element。

16.2.6　其他成员

HTML5 规范规定 dataTransfer 对象还应该包含下列方法和属性。

addElement (element)：为拖动操作添加一个元素。添加这个元素只影响数据（即增加作为拖动源而响应回调的对象），不会影响拖动操作时页面元素的外观。在写作本书时，只有 Firefox 3.5 + 实现了这个方法。

clearData (format)：清除以特定格式保存的数据。实现这个方法的浏览器有 IE、Fireforx 3.5+、Chrome 和 Safari 4+。

setDragImage (element, x, y)：指定一幅图像，当拖动发生时，显示在光标下方。这个方法接收的三个参数分别是要显示的 HTML 元素和光标在图像中的 x、y 坐标。其中，HTML 元素可以是一幅图像，也可以是其他元素。是图像则显示图像，是其他元素则显示渲染后的元素。实现这个方法的浏览器有 Firefox 3.5+、Safari 4 + 和 Chrome。

types：当前保存的数据类型。这是一个类似数组的集合，以 "text" 这样的字符串形式保存着数据类型。实现这个属性的浏览器有 IE10+、Firefox 3.5 + 和 Chrome。

16.3　媒体元素

随着音频和视频在 Web 上的迅速流行，大多数提供富媒体内容的站点为了保证跨浏览器兼容性，不得不选择使用 Flash。HTML5 新增了两个与媒体相关的标签，让开发人员不必依赖任何插件就能在网页中嵌入跨浏览器的音频和视频内容。这两个标签就是 <audio> 和 <video>。

这两个标签除了能让开发人员方便地嵌入媒体文件之外，都提供了用于实现常用功能的 JavaScript API，允许为媒体创建自定义的控件。这两个元素的用法如下。

<!-- 嵌入视频 --> <video src="conference.mpg" id="myVideo">Video player not available.</video> <!-- 嵌入音频 --> <audio src="song.mp3" id="myAudio">Audio player not available.</audio>

使用这两个元素时，至少要在标签中包含 src 属性，指向要加载的媒体文件。还可以设置 width 和 height 属性以指定视频播放器的大小，而为 poster 属性指定图像的 URI 可以在加载视频内容期间显示一幅图像。另外，如果标签中有 controls 属性，则意味着浏览器应该显示 UI 控件，以便用户直接操作媒体。位于开始和结束标签之间的任何内容都将作为后备内容，在浏览器不支持这两个媒体元素的情况下显示。

因为并非所有浏览器都支持所有媒体格式，所以可以指定多个不同的媒体来源。为此，不用在标签中指定 src 属性，而是要像下面这样使用一或多个 <source> 元素。

<!-- 嵌入视频 --> <video id="myVideo"> <source src="conference.webm" type="video/webm; codecs='vp8, vorbis'"> <source src="conference.ogv" type="video/ogg; codecs='theora, vorbis'"> <source src="conference.mpg"> Video player not available. </video> <!-- 嵌入音频 --> <audio id="myAudio"> <source src="song.ogg" type="audio/ogg"> <source src="song.mp3" type="audio/mpeg"> Audio player not available. </audio>

关于视频和音频编解码器的内容超出了本书讨论的范围。作者在此只想告诉大家，不同的浏览器支持不同的编解码器，因此一般来说指定多种格式的媒体来源是必需的。支持这两个媒体元素的浏览器有 IE9+、Firefox 3.5+、Safari 4+、Opera 10.5+、Chrome、iOS 版 Safari 和 Android 版 WebKit。

16.3.1　属性

<video> 和 <audio> 元素都提供了完善的 JavaScript 接口。下表列出了这两个元素共有的属性，通过这些属性可以知道媒体的当前状态。

属　　性 数据类型 说　　明

autoplay 布尔值 取得或设置 autoplay 标志

buffered 时间范围 表示已下载的缓冲的时间范围的对象

bufferedBytes 字节范围 表示已下载的缓冲的字节范围的对象

bufferingRate 整数 下载过程中每秒钟平均接收到的位数

bufferingThrottled 布尔值 表示浏览器是否对缓冲进行了节流

controls 布尔值 取得或设置 controls 属性，用于显示或隐藏浏览器内置的控件

currentLoop 整数 媒体文件已经循环的次数

currentSrc 字符串 当前播放的媒体文件的 URL

currentTime 浮点数 已经播放的秒数

defaultPlaybackRate 浮点数 取得或设置默认的播放速度。默认值为 1.0 秒

duration 浮点数 媒体的总播放时间（秒数）

ended 布尔值 表示媒体文件是否播放完成

loop 布尔值 取得或设置媒体文件在播放完成后是否再从头开始播放

muted 布尔值 取得或设置媒体文件是否静音

networkState 整数 表示当前媒体的网络连接状态：0 表示空，1 表示正在加载，2 表示正在加载元数据，3 表示已经加载了第一帧，4 表示加载完成

paused 布尔值 表示播放器是否暂停

playbackRate 浮点数 取得或设置当前的播放速度。用户可以改变这个值，让媒体播放速度变快或变慢，这与 defaultPlaybackRate 只能由开发人员修改的 defaultPlaybackRate 不同

played 时间范围 到目前为止已经播放的时间范围

readyState 整数 表示媒体是否已经就绪（可以播放了）。0 表示数据不可用，1 表示可以显示当前帧，2 表示可以开始播放，3 表示媒体可以从头到尾播放

seekable 时间范围 可以搜索的时间范围

seeking 布尔值 表示播放器是否正移动到媒体文件中的新位置

src 字符串 媒体文件的来源。任何时候都可以重写这个属性

start 浮点数 取得或设置媒体文件中开始播放的位置，以秒表示

totalBytes 整数 当前资源所需的总字节数

videoHeight 整数 返回视频（不一定是元素）的高度。只适用于 <video>

videoWidth 整数 返回视频（不一定是元素）的宽度。只适用于 <video>

volume 浮点数 取得或设置当前音量，值为 0.0 到 1.0

其中很多属性也可以直接在 <audio> 和 <video> 元素中设置。

16.3.2　事件

除了大量属性之外，这两个媒体元素还可以触发很多事件。这些事件监控着不同的属性的变化，这些变化可能是媒体播放的结果，也可能是用户操作播放器的结果。下表列出了媒体元素相关的事件。

