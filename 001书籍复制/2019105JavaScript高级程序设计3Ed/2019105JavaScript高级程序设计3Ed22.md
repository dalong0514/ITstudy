var url = "example.php"; // 添加参数 url = addURLParam (url, "name", "Nicholas"); url = addURLParam (url, "book", "Professional JavaScript"); // 初始化请求 xhr.open ("get", url, false);

在这里使用 addURLParam () 函数可以确保查询字符串的格式良好，并可靠地用于 XHR 对象。

21.1.4　POST 请求

使用频率仅次于 GET 的是 POST 请求，通常用于向服务器发送应该被保存的数据。POST 请求应该把数据作为请求的主体提交，而 GET 请求传统上不是这样。POST 请求的主体可以包含非常多的数据，而且格式不限。在 open () 方法第一个参数的位置传入 "post"，就可以初始化一个 POST 请求，如下面的例子所示。

xhr.open("post", "example.php", true);

发送 POST 请求的第二步就是向 send () 方法中传入某些数据。由于 XHR 最初的设计主要是为了处理 XML，因此可以在此传入 XML DOM 文档，传入的文档经序列化之后将作为请求主体被提交到服务器。当然，也可以在此传入任何想发送到服务器的字符串。

默认情况下，服务器对 POST 请求和提交 Web 表单的请求并不会一视同仁。因此，服务器端必须有程序来读取发送过来的原始数据，并从中解析出有用的部分。不过，我们可以使用 XHR 来模仿表单提交：首先将 Content-Type 头部信息设置为 application/x-www-form-urlencoded，也就是表单提交时的内容类型，其次是以适当的格式创建一个字符串。第 14 章曾经讨论过，POST 数据的格式与查询字符串格式相同。如果需要将页面中表单的数据进行序列化，然后再通过 XHR 发送到服务器，那么就可以使用第 14 章介绍的 serialize () 函数来创建这个字符串：

function submitData(){ var xhr = createXHR(); xhr.onreadystatechange = function(){ if (xhr.readyState == 4){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } } }; xhr.open("post", "postexample.php", true); xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); var form = document.getElementById("user-info"); xhr.send(serialize(form)); }

XHRPostExample01.htm

这个函数可以将 ID 为 "user-info" 的表单中的数据序列化之后发送给服务器。而下面的示例 PHP 文件 postexample.php 就可以通过 $_POST 取得提交的数据了：

<?php header("Content-Type: text/plain"); echo <<<EOF Name: {$_POST[‘user-name’]} Email: {$_POST[‘user-email’]} EOF; ?>

postexample.php

如果不设置 Content-Type 头部信息，那么发送给服务器的数据就不会出现在 $_POST 超级全局变量中。这时候，要访问同样的数据，就必须借助 $HTTP_RAW_POST_DATA。

与 GET 请求相比，POST 请求消耗的资源会更多一些。从性能角度来看，以发送相同的数据计，GET 请求的速度最多可达到 POST 请求的两倍。

21.2　XMLHttpRequest 2 级

鉴于 XHR 已经得到广泛接受，成为了事实标准，W3C 也着手制定相应的标准以规范其行为。XMLHttpRequest 1 级只是把已有的 XHR 对象的实现细节描述了出来。而 XMLHttpRequest 2 级则进一步发展了 XHR。并非所有浏览器都完整地实现了 XMLHttpRequest 2 级规范，但所有浏览器都实现了它规定的部分内容。

21.2.1　FormData

现代 Web 应用中频繁使用的一项功能就是表单数据的序列化，XMLHttpRequest 2 级为此定义了 FormData 类型。FormData 为序列化表单以及创建与表单格式相同的数据（用于通过 XHR 传输）提供了便利。下面的代码创建了一个 FormData 对象，并向其中添加了一些数据。

var data = new FormData(); data.append("name", "Nicholas");

这个 append () 方法接收两个参数：键和值，分别对应表单字段的名字和字段中包含的值。可以像这样添加任意多个键值对儿。而通过向 FormData 构造函数中传入表单元素，也可以用表单元素的数据预先向其中填入键值对儿：

var data = new FormData(document.forms[0]);

创建了 FormData 的实例后，可以将它直接传给 XHR 的 send () 方法，如下所示：

var xhr = createXHR(); xhr.onreadystatechange = function(){ if (xhr.readyState == 4){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } } }; xhr.open("post","postexample.php", true); var form = document.getElementById("user-info"); xhr.send(new FormData(form));

XHRFormDataExample01.htm

使用 FormData 的方便之处体现在不必明确地在 XHR 对象上设置请求头部。XHR 对象能够识别传入的数据类型是 FormData 的实例，并配置适当的头部信息。

支持 FormData 的浏览器有 Firefox 4+、Safari 5+、Chrome 和 Android 3 + 版 WebKit。

21.2.2　超时设定

IE8 为 XHR 对象添加了一个 timeout 属性，表示请求在等待响应多少毫秒之后就终止。在给 timeout 设置一个数值后，如果在规定的时间内浏览器还没有接收到响应，那么就会触发 timeout 事件，进而会调用 ontimeout 事件处理程序。这项功能后来也被收入了 XMLHttpRequest 2 级规范中。来看下面的例子。

var xhr = createXHR (); xhr.onreadystatechange = function (){if (xhr.readyState == 4){try { if ((xhr.status>= 200 && xhr.status <300) || xhr.status == 304){alert (xhr.responseText); } else {alert ("Request was unsuccessful:" + xhr.status); } } catch (ex){// 假设由 ontimeout 事件处理程序处理} } }; xhr.open ("get", "timeout.php", true); xhr.timeout = 1000; // 将超时设置为 1 秒钟（仅适用于 IE8+） xhr.ontimeout = function (){ alert ("Request did not return in a second."); }; xhr.send (null);

XHRTimeoutExample01.htm

这个例子示范了如何使用 timeout 属性。将这个属性设置为 1000 毫秒，意味着如果请求在 1 秒钟内还没有返回，就会自动终止。请求终止时，会调用 ontimeout 事件处理程序。但此时 readyState 可能已经改变为 4 了，这意味着会调用 onreadystatechange 事件处理程序。可是，如果在超时终止请求之后再访问 status 属性，就会导致错误。为避免浏览器报告错误，可以将检查 status 属性的语句封装在一个 try-catch 语句当中。

在写作本书时，IE 8 + 仍然是唯一支持超时设定的浏览器。

21.2.3　overrideMimeType () 方法

Firefox 最早引入了 overrideMimeType () 方法，用于重写 XHR 响应的 MIME 类型。这个方法后来也被纳入了 XMLHttpRequest 2 级规范。因为返回响应的 MIME 类型决定了 XHR 对象如何处理它，所以提供一种方法能够重写服务器返回的 MIME 类型是很有用的。

比如，服务器返回的 MIME 类型是 text/plain，但数据中实际包含的是 XML。根据 MIME 类型，即使数据是 XML，responseXML 属性中仍然是 null。通过调用 overrideMimeType () 方法，可以保证把响应当作 XML 而非纯文本来处理。

var xhr = createXHR(); xhr.open("get", "text.php", true); xhr.overrideMimeType("text/xml"); xhr.send(null);

这个例子强迫 XHR 对象将响应当作 XML 而非纯文本来处理。调用 overrideMimeType () 必须在 send () 方法之前，才能保证重写响应的 MIME 类型。

支持 overrideMimeType () 方法的浏览器有 Firefox、Safari 4+、Opera 10.5 和 Chrome。

21.3　进度事件

Progress Events 规范是 W3C 的一个工作草案，定义了与客户端服务器通信有关的事件。这些事件最早其实只针对 XHR 操作，但目前也被其他 API 借鉴。有以下 6 个进度事件。

loadstart：在接收到响应数据的第一个字节时触发。

progress：在接收响应期间持续不断地触发。

error：在请求发生错误时触发。

abort：在因为调用 abort () 方法而终止连接时触发。

load：在接收到完整的响应数据时触发。

loadend：在通信完成或者触发 error、abort 或 load 事件后触发。

每个请求都从触发 loadstart 事件开始，接下来是一或多个 progress 事件，然后触发 error、abort 或 load 事件中的一个，最后以触发 loadend 事件结束。

支持前 5 个事件的浏览器有 Firefox 3.5+、Safari 4+、Chrome、iOS 版 Safari 和 Android 版 WebKit。Opera（从第 11 版开始）、IE 8 + 只支持 load 事件。目前还没有浏览器支持 loadend 事件。

这些事件大都很直观，但其中两个事件有一些细节需要注意。

21.3.1　load 事件

Firefox 在实现 XHR 对象的某个版本时，曾致力于简化异步交互模型。最终，Firefox 实现中引入了 load 事件，用以替代 readystatechange 事件。响应接收完毕后将触发 load 事件，因此也就没有必要去检查 readyState 属性了。而 onload 事件处理程序会接收到一个 event 对象，其 target 属性就指向 XHR 对象实例，因而可以访问到 XHR 对象的所有方法和属性。然而，并非所有浏览器都为这个事件实现了适当的事件对象。结果，开发人员还是要像下面这样被迫使用 XHR 对象变量。

var xhr = createXHR(); xhr.onload = function(){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } }; xhr.open("get", "altevents.php", true); xhr.send(null);

XHRProgressEventExample01.htm

只要浏览器接收到服务器的响应，不管其状态如何，都会触发 load 事件。而这意味着你必须要检查 status 属性，才能确定数据是否真的已经可用了。Firefox、Opera、Chrome 和 Safari 都支持 load 事件。

21.3.2　progress 事件

Mozilla 对 XHR 的另一个革新是添加了 progress 事件，这个事件会在浏览器接收新数据期间周期性地触发。而 onprogress 事件处理程序会接收到一个 event 对象，其 target 属性是 XHR 对象，但包含着三个额外的属性：lengthComputable、position 和 totalSize。其中，lengthComputable 是一个表示进度信息是否可用的布尔值，position 表示已经接收的字节数，totalSize 表示根据 Content-Length 响应头部确定的预期字节数。有了这些信息，我们就可以为用户创建一个进度指示器了。下面展示了为用户创建进度指示器的一个示例。

var xhr = createXHR(); xhr.onload = function(event){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } }; xhr.onprogress = function(event){ var divStatus = document.getElementById("status"); if (event.lengthComputable){ divStatus.innerHTML = "Received " + event.position + " of " + event.totalSize +" bytes"; } }; xhr.open("get", "altevents.php", true); xhr.send(null);

XHRProgressEventExample01.htm

为确保正常执行，必须在调用 open () 方法之前添加 onprogress 事件处理程序。在前面的例子中，每次触发 progress 事件，都会以新的状态信息更新 HTML 元素的内容。如果响应头部中包含 Content-Length 字段，那么也可以利用此信息来计算从响应中已经接收到的数据的百分比。

21.4　跨源资源共享

通过 XHR 实现 Ajax 通信的一个主要限制，来源于跨域安全策略。默认情况下，XHR 对象只能访问与包含它的页面位于同一个域中的资源。这种安全策略可以预防某些恶意行为。但是，实现合理的跨域请求对开发某些浏览器应用程序也是至关重要的。

CORS（Cross-Origin Resource Sharing，跨源资源共享）是 W3C 的一个工作草案，定义了在必须访问跨源资源时，浏览器与服务器应该如何沟通。CORS 背后的基本思想，就是使用自定义的 HTTP 头部让浏览器与服务器进行沟通，从而决定请求或响应是应该成功，还是应该失败。

比如一个简单的使用 GET 或 POST 发送的请求，它没有自定义的头部，而主体内容是 text/plain。在发送该请求时，需要给它附加一个额外的 Origin 头部，其中包含请求页面的源信息（协议、域名和端口），以便服务器根据这个头部信息来决定是否给予响应。下面是 Origin 头部的一个示例：

Origin: http://www.nczonline.net

如果服务器认为这个请求可以接受，就在 Access-Control-Allow-Origin 头部中回发相同的源信息（如果是公共资源，可以回发 "*"）。例如：

Access-Control-Allow-Origin: http://www.nczonline.net

如果没有这个头部，或者有这个头部但源信息不匹配，浏览器就会驳回请求。正常情况下，浏览器会处理请求。注意，请求和响应都不包含 cookie 信息。

21.4.1　IE 对 CORS 的实现

微软在 IE8 中引入了 XDR（XDomainRequest）类型。这个对象与 XHR 类似，但能实现安全可靠的跨域通信。XDR 对象的安全机制部分实现了 W3C 的 CORS 规范。以下是 XDR 与 XHR 的一些不同之处。

cookie 不会随请求发送，也不会随响应返回。

只能设置请求头部信息中的 Content-Type 字段。

不能访问响应头部信息。

只支持 GET 和 POST 请求。

这些变化使 CSRF（Cross-Site Request Forgery，跨站点请求伪造）和 XSS（Cross-Site Scripting，跨站点脚本）的问题得到了缓解。被请求的资源可以根据它认为合适的任意数据（用户代理、来源页面等）来决定是否设置 Access-Control- Allow-Origin 头部。作为请求的一部分，Origin 头部的值表示请求的来源域，以便远程资源明确地识别 XDR 请求。

XDR 对象的使用方法与 XHR 对象非常相似。也是创建一个 XDomainRequest 的实例，调用 open () 方法，再调用 send () 方法。但与 XHR 对象的 open () 方法不同，XDR 对象的 open () 方法只接收两个参数：请求的类型和 URL。

所有 XDR 请求都是异步执行的，不能用它来创建同步请求。请求返回之后，会触发 load 事件，响应的数据也会保存在 responseText 属性中，如下所示。

var xdr = new XDomainRequest(); xdr.onload = function(){ alert(xdr.responseText); }; xdr.open("get", "http://www.somewhere-else.com/page/"); xdr.send(null);

XDomainRequestExample01.htm

在接收到响应后，你只能访问响应的原始文本；没有办法确定响应的状态代码。而且，只要响应有效就会触发 load 事件，如果失败（包括响应中缺少 Access-Control-Allow-Origin 头部）就会触发 error 事件。遗憾的是，除了错误本身之外，没有其他信息可用，因此唯一能够确定的就只有请求未成功了。要检测错误，可以像下面这样指定一个 onerror 事件处理程序。

var xdr = new XDomainRequest(); xdr.onload = function(){ alert(xdr.responseText); }; xdr.onerror = function(){ alert("An error occurred."); }; xdr.open("get", "http://www.somewhere-else.com/page/"); xdr.send(null);

XDomainRequestExample01.htm

鉴于导致 XDR 请求失败的因素很多，因此建议你不要忘记通过 onerror 事件处理程序来捕获该事件；否则，即使请求失败也不会有任何提示。

在请求返回前调用 abort () 方法可以终止请求：

xdr.abort (); // 终止请求

与 XHR 一样，XDR 对象也支持 timeout 属性以及 ontimeout 事件处理程序。下面是一个例子。

var xdr = new XDomainRequest(); xdr.onload = function(){ alert(xdr.responseText); }; xdr.onerror = function(){ alert("An error occurred."); }; xdr.timeout = 1000; xdr.ontimeout = function(){ alert("Request took too long."); }; xdr.open("get", "http://www.somewhere-else.com/page/"); xdr.send(null);

这个例子会在运行 1 秒钟后超时，并随即调用 ontimeout 事件处理程序。

为支持 POST 请求，XDR 对象提供了 contentType 属性，用来表示发送数据的格式，如下面的例子所示。

var xdr = new XDomainRequest(); xdr.onload = function(){ alert(xdr.responseText); }; xdr.onerror = function(){ alert("An error occurred."); }; xdr.open("post", "http://www.somewhere-else.com/page/"); xdr.contentType = "application/x-www-form-urlencoded"; xdr.send("name1=value1&name2=value2");

这个属性是通过 XDR 对象影响头部信息的唯一方式。

21.4.2　其他浏览器对 CORS 的实现

Firefox 3.5+、Safari 4+、Chrome、iOS 版 Safari 和 Android 平台中的 WebKit 都通过 XMLHttpRequest 对象实现了对 CORS 的原生支持。在尝试打开不同来源的资源时，无需额外编写代码就可以触发这个行为。要请求位于另一个域中的资源，使用标准的 XHR 对象并在 open () 方法中传入绝对 URL 即可，例如：

var xhr = createXHR(); xhr.onreadystatechange = function(){ if (xhr.readyState == 4){ if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){ alert(xhr.responseText); } else { alert("Request was unsuccessful: " + xhr.status); } } }; xhr.open("get", "http://www.somewhere-else.com/page/", true); xhr.send(null);

与 IE 中的 XDR 对象不同，通过跨域 XHR 对象可以访问 status 和 statusText 属性，而且还支持同步请求。跨域 XHR 对象也有一些限制，但为了安全这些限制是必需的。以下就是这些限制。

不能使用 setRequestHeader () 设置自定义头部。

不能发送和接收 cookie。

调用 getAllResponseHeaders () 方法总会返回空字符串。

由于无论同源请求还是跨源请求都使用相同的接口，因此对于本地资源，最好使用相对 URL，在访问远程资源时再使用绝对 URL。这样做能消除歧义，避免出现限制访问头部或本地 cookie 信息等问题。

21.4.3　Preflighted Reqeusts

CORS 通过一种叫做 Preflighted Requests 的透明服务器验证机制支持开发人员使用自定义的头部、GET 或 POST 之外的方法，以及不同类型的主体内容。在使用下列高级选项来发送请求时，就会向服务器发送一个 Preflight 请求。这种请求使用 OPTIONS 方法，发送下列头部。

Origin：与简单的请求相同。

Access-Control-Request-Method：请求自身使用的方法。

Access-Control-Request-Headers：（可选）自定义的头部信息，多个头部以逗号分隔。

以下是一个带有自定义头部 NCZ 的使用 POST 方法发送的请求。

Origin: http://www.nczonline.net Access-Control-Request-Method: POST Access-Control-Request-Headers: NCZ

发送这个请求后，服务器可以决定是否允许这种类型的请求。服务器通过在响应中发送如下头部与浏览器进行沟通。

Access-Control-Allow-Origin：与简单的请求相同。

Access-Control-Allow-Methods：允许的方法，多个方法以逗号分隔。

Access-Control-Allow-Headers：允许的头部，多个头部以逗号分隔。

Access-Control-Max-Age：应该将这个 Preflight 请求缓存多长时间（以秒表示）。

例如：

Access-Control-Allow-Origin: http://www.nczonline.net Access-Control-Allow-Methods: POST, GET Access-Control-Allow-Headers: NCZ Access-Control-Max-Age: 1728000

Preflight 请求结束后，结果将按照响应中指定的时间缓存起来。而为此付出的代价只是第一次发送这种请求时会多一次 HTTP 请求。

支持 Preflight 请求的浏览器包括 Firefox 3.5+、Safari 4 + 和 Chrome。IE 10 及更早版本都不支持。

21.4.4　带凭据的请求

默认情况下，跨源请求不提供凭据（cookie、HTTP 认证及客户端 SSL 证明等）。通过将 withCredentials 属性设置为 true，可以指定某个请求应该发送凭据。如果服务器接受带凭据的请求，会用下面的 HTTP 头部来响应。

Access-Control-Allow-Credentials: true

如果发送的是带凭据的请求，但服务器的响应中没有包含这个头部，那么浏览器就不会把响应交给 JavaScript（于是，responseText 中将是空字符串，status 的值为 0，而且会调用 onerror () 事件处理程序）。另外，服务器还可以在 Preflight 响应中发送这个 HTTP 头部，表示允许源发送带凭据的请求。

支持 withCredentials 属性的浏览器有 Firefox 3.5+、Safari 4 + 和 Chrome。IE 10 及更早版本都不支持。

21.4.5　跨浏览器的 CORS

即使浏览器对 CORS 的支持程度并不都一样，但所有浏览器都支持简单的（非 Preflight 和不带凭据的）请求，因此有必要实现一个跨浏览器的方案。检测 XHR 是否支持 CORS 的最简单方式，就是检查是否存在 withCredentials 属性。再结合检测 XDomainRequest 对象是否存在，就可以兼顾所有浏览器了。

function createCORSRequest (method, url){var xhr = new XMLHttpRequest (); if ("withCredentials" in xhr){xhr.open (method, url, true); } else if (typeof XDomainRequest != "undefined"){vxhr = new XDomainRequest (); xhr.open (method, url); } else {xhr = null;} return xhr; } var request = createCORSRequest ("get", "http://www.somewhere-else.com/page/"); if (request){request.onload = function (){// 对 request.responseText 进行处理}; request.send ();}

CrossBrowserCORSRequestExample01.htm

Firefox、Safari 和 Chrome 中的 XMLHttpRequest 对象与 IE 中的 XDomainRequest 对象类似，都提供了够用的接口，因此以上模式还是相当有用的。这两个对象共同的属性 / 方法如下。

abort ()：用于停止正在进行的请求。

onerror：用于替代 onreadystatechange 检测错误。

onload：用于替代 onreadystatechange 检测成功。

responseText：用于取得响应内容。

send ()：用于发送请求。

以上成员都包含在 createCORSRequest () 函数返回的对象中，在所有浏览器中都能正常使用。

21.5　其他跨域技术

在 CORS 出现以前，要实现跨域 Ajax 通信颇费一些周折。开发人员想出了一些办法，利用 DOM 中能够执行跨域请求的功能，在不依赖 XHR 对象的情况下也能发送某种请求。虽然 CORS 技术已经无处不在，但开发人员自己发明的这些技术仍然被广泛使用，毕竟这样不需要修改服务器端代码。

21.5.1　图像 Ping

上述第一种跨域请求技术是使用 <img> 标签。我们知道，一个网页可以从任何网页中加载图像，不用担心跨域不跨域。这也是在线广告跟踪浏览量的主要方式。正如第 13 章讨论过的，也可以动态地创建图像，使用它们的 onload 和 onerror 事件处理程序来确定是否接收到了响应。

动态创建图像经常用于 ** 图像 **Ping。图像 Ping 是与服务器进行简单、单向的跨域通信的一种方式。请求的数据是通过查询字符串形式发送的，而响应可以是任意内容，但通常是像素图或 204 响应。通过图像 Ping，浏览器得不到任何具体的数据，但通过侦听 load 和 error 事件，它能知道响应是什么时候接收到的。来看下面的例子。

var img = new Image(); img.onload = img.onerror = function(){ alert("Done!"); }; img.src = "http://www.example.com/test?name=Nicholas";

ImagePingExample01.htm

这里创建了一个 Image 的实例，然后将 onload 和 onerror 事件处理程序指定为同一个函数。这样无论是什么响应，只要请求完成，就能得到通知。请求从设置 src 属性那一刻开始，而这个例子在请求中发送了一个 name 参数。

图像 Ping 最常用于跟踪用户点击页面或动态广告曝光次数。图像 Ping 有两个主要的缺点，一是只能发送 GET 请求，二是无法访问服务器的响应文本。因此，图像 Ping 只能用于浏览器与服务器间的单向通信。

21.5.2　JSONP

JSONP 是 JSON with padding（填充式 JSON 或参数式 JSON）的简写，是应用 JSON 的一种新方法，在后来的 Web 服务中非常流行。JSONP 看起来与 JSON 差不多，只不过是被包含在函数调用中的 JSON，就像下面这样。

callback({ "name": "Nicholas" });

JSONP 由两部分组成：回调函数和数据。回调函数是当响应到来时应该在页面中调用的函数。回调函数的名字一般是在请求中指定的。而数据就是传入回调函数中的 JSON 数据。下面是一个典型的 JSONP 请求。

http://freegeoip.net/json/?callback=handleResponse

这个 URL 是在请求一个 JSONP 地理定位服务。通过查询字符串来指定 JSONP 服务的回调参数是很常见的，就像上面的 URL 所示，这里指定的回调函数的名字叫 handleResponse ()。

JSONP 是通过动态 <script> 元素（要了解详细信息，请参考第 13 章）来使用的，使用时可以为 src 属性指定一个跨域 URL。这里的 <script> 元素与 <img> 元素类似，都有能力不受限制地从其他域加载资源。因为 JSONP 是有效的 JavaScript 代码，所以在请求完成后，即在 JSONP 响应加载到页面中以后，就会立即执行。来看一个例子。

function handleResponse(response){ alert("You’re at IP address " + response.ip + ", which is in " + response.city + ", " + response.region_name); } var script = document.createElement("script"); script.src = "http://freegeoip.net/json/?callback=handleResponse"; document.body.insertBefore(script, document.body.firstChild);

JSONPExample01.htm

这个例子通过查询地理定位服务来显示你的 IP 地址和位置信息。

JSONP 之所以在开发人员中极为流行，主要原因是它非常简单易用。与图像 Ping 相比，它的优点在于能够直接访问响应文本，支持在浏览器与服务器之间双向通信。不过，JSONP 也有两点不足。

首先，JSONP 是从其他域中加载代码执行。如果其他域不安全，很可能会在响应中夹带一些恶意代码，而此时除了完全放弃 JSONP 调用之外，没有办法追究。因此在使用不是你自己运维的 Web 服务时，一定得保证它安全可靠。

其次，要确定 JSONP 请求是否失败并不容易。虽然 HTML5 给 <script> 元素新增了一个 onerror 事件处理程序，但目前还没有得到任何浏览器支持。为此，开发人员不得不使用计时器检测指定时间内是否接收到了响应。但就算这样也不能尽如人意，毕竟不是每个用户上网的速度和带宽都一样。

21.5.3　Comet

Comet 是 Alex Russell1 发明的一个词儿，指的是一种更高级的 Ajax 技术（经常也有人称为「服务器推送」）。Ajax 是一种从页面向服务器请求数据的技术，而 Comet 则是一种服务器向页面推送数据的技术。Comet 能够让信息近乎实时地被推送到页面上，非常适合处理体育比赛的分数和股票报价。

1 Alex Russell 是著名 JavaScript 框架 Dojo 的创始人。

有两种实现 Comet 的方式：长轮询和流。长轮询是传统轮询（也称为短轮询）的一个翻版，即浏览器定时向服务器发送请求，看有没有更新的数据。图 21-1 展示的是短轮询的时间线。

图　21-1

长轮询把短轮询颠倒了一下。页面发起一个到服务器的请求，然后服务器一直保持连接打开，直到有数据可发送。发送完数据之后，浏览器关闭连接，随即又发起一个到服务器的新请求。这一过程在页面打开期间一直持续不断。图 21-2 展示了长轮询的时间线。

图　21-2

无论是短轮询还是长轮询，浏览器都要在接收数据之前，先发起对服务器的连接。两者最大的区别在于服务器如何发送数据。短轮询是服务器立即发送响应，无论数据是否有效，而长轮询是等待发送响应。轮询的优势是所有浏览器都支持，因为使用 XHR 对象和 setTimeout () 就能实现。而你要做的就是决定什么时候发送请求。

第二种流行的 Comet 实现是 HTTP 流。流不同于上述两种轮询，因为它在页面的整个生命周期内只使用一个 HTTP 连接。具体来说，就是浏览器向服务器发送一个请求，而服务器保持连接打开，然后周期性地向浏览器发送数据。比如，下面这段 PHP 脚本就是采用流实现的服务器中常见的形式。

<?php $i = 0; while (true){// 输出一些数据，然后立即刷新输出缓存 echo "Number is $i"; flush (); // 等几秒钟 sleep (10); $i++; }

所有服务器端语言都支持打印到输出缓存然后刷新（将输出缓存中的内容一次性全部发送到客户端）的功能。而这正是实现 HTTP 流的关键所在。

在 Firefox、Safari、Opera 和 Chrome 中，通过侦听 readystatechange 事件及检测 readyState 的值是否为 3，就可以利用 XHR 对象实现 HTTP 流。在上述这些浏览器中，随着不断从服务器接收数据，readyState 的值会周期性地变为 3。当 readyState 值变为 3 时，responseText 属性中就会保存接收到的所有数据。此时，就需要比较此前接收到的数据，决定从什么位置开始取得最新的数据。使用 XHR 对象实现 HTTP 流的典型代码如下所示。

function createStreamingClient (url, progress, finished){var xhr = new XMLHttpRequest (), received = 0; xhr.open ("get", url, true); xhr.onreadystatechange = function (){ var result; if (xhr.readyState == 3){// 只取得最新数据并调整计数器 result = xhr.responseText.substring (received); received += result.length; // 调用 progress 回调函数 progress (result); } else if (xhr.readyState == 4){finished (xhr.responseText); } }; xhr.send (null); return xhr; } var client = createStreamingClient ("streaming.php", function (data){alert ("Received:" + data); }, function (data){alert ("Done!"); });

HTTPStreamingExample01.htm

这个 createStreamingClient () 函数接收三个参数：要连接的 URL、在接收到数据时调用的函数以及关闭连接时调用的函数。有时候，当连接关闭时，很可能还需要重新建立，所以关注连接什么时候关闭还是有必要的。

只要 readystatechange 事件发生，而且 readyState 值为 3，就对 responseText 进行分割以取得最新数据。这里的 received 变量用于记录已经处理了多少个字符，每次 readyState 值为 3 时都递增。然后，通过 progress 回调函数来处理传入的新数据。而当 readyState 值为 4 时，则执行 finished 回调函数，传入响应返回的全部内容。

虽然这个例子比较简单，而且也能在大多数浏览器中正常运行（IE 除外），但管理 Comet 的连接是很容易出错的，需要时间不断改进才能达到完美。浏览器社区认为 Comet 是未来 Web 的一个重要组成部分，为了简化这一技术，又为 Comet 创建了两个新的接口。

21.5.4　服务器发送事件

SSE（Server-Sent Events，服务器发送事件）是围绕只读 Comet 交互推出的 API 或者模式。SSE API 用于创建到服务器的单向连接，服务器通过这个连接可以发送任意数量的数据。服务器响应的 MIME 类型必须是 text/event-stream，而且是浏览器中的 JavaScript API 能解析格式输出。SSE 支持短轮询、长轮询和 HTTP 流，而且能在断开连接时自动确定何时重新连接。有了这么简单实用的 API，再实现 Comet 就容易多了。

支持 SSE 的浏览器有 Firefox 6+、Safari 5+、Opera 11+、Chrome 和 iOS 4 + 版 Safari。

1. SSE API

SSE 的 JavaScript API 与其他传递消息的 JavaScript API 很相似。要预订新的事件流，首先要创建一个新的 EventSource 对象，并传进一个入口点：

var source = new EventSource("myevents.php");

注意，传入的 URL 必须与创建对象的页面同源（相同的 URL 模式、域及端口）。EventSource 的实例有一个 readyState 属性，值为 0 表示正连接到服务器，值为 1 表示打开了连接，值为 2 表示关闭了连接。

另外，还有以下三个事件。

open：在建立连接时触发。

message：在从服务器接收到新事件时触发。

error：在无法建立连接时触发。

就一般的用法而言，onmessage 事件处理程序也没有什么特别的。

source.onmessage = function (event){var data = event.data; // 处理数据};

服务器发回的数据以字符串形式保存在 event.data 中。

默认情况下，EventSource 对象会保持与服务器的活动连接。如果连接断开，还会重新连接。这就意味着 SSE 适合长轮询和 HTTP 流。如果想强制立即断开连接并且不再重新连接，可以调用 close () 方法。

source.close();

2. 事件流

所谓的服务器事件会通过一个持久的 HTTP 响应发送，这个响应的 MIME 类型为 text/eventstream。响应的格式是纯文本，最简单的情况是每个数据项都带有前缀 data:，例如：

data: foo data: bar data: foo data: bar

对以上响应而言，事件流中的第一个 message 事件返回的 event.data 值为 "foo"，第二个 message 事件返回的 event.data 值为 "bar"，第三个 message 事件返回的 event.data 值为 "foo\nbar"（注意中间的换行符）。对于多个连续的以 data: 开头的数据行，将作为多段数据解析，每个值之间以一个换行符分隔。只有在包含 data: 的数据行后面有空行时，才会触发 message 事件，因此在服务器上生成事件流时不能忘了多添加这一行。

通过 id: 前缀可以给特定的事件指定一个关联的 ID，这个 ID 行位于 data: 行前面或后面皆可：

data: foo id: 1

设置了 ID 后，EventSource 对象会跟踪上一次触发的事件。如果连接断开，会向服务器发送一个包含名为 Last-Event-ID 的特殊 HTTP 头部的请求，以便服务器知道下一次该触发哪个事件。在多次连接的事件流中，这种机制可以确保浏览器以正确的顺序收到连接的数据段。

21.5.5　Web Sockets

要说最令人津津乐道的新浏览器 API，就得数 Web Sockets 了。Web Sockets 的目标是在一个单独的持久连接上提供全双工、双向通信。在 JavaScript 中创建了 Web Socket 之后，会有一个 HTTP 请求发送到浏览器以发起连接。在取得服务器响应后，建立的连接会使用 HTTP 升级从 HTTP 协议交换为 Web Socket 协议。也就是说，使用标准的 HTTP 服务器无法实现 Web Sockets，只有支持这种协议的专门服务器才能正常工作。

由于 Web Sockets 使用了自定义的协议，所以 URL 模式也略有不同。未加密的连接不再是 http://，而是 ws://；加密的连接也不是 https://，而是 wss://。在使用 Web Socket URL 时，必须带着这个模式，因为将来还有可能支持其他模式。

使用自定义协议而非 HTTP 协议的好处是，能够在客户端和服务器之间发送非常少量的数据，而不必担心 HTTP 那样字节级的开销。由于传递的数据包很小，因此 Web Sockets 非常适合移动应用。毕竟对移动应用而言，带宽和网络延迟都是关键问题。使用自定义协议的缺点在于，制定协议的时间比制定 JavaScript API 的时间还要长。Web Sockets 曾几度搁浅，就因为不断有人发现这个新协议存在一致性和安全性的问题。Firefox 4 和 Opera 11 都曾默认启用 Web Sockets，但在发布前夕又禁用了，因为又发现了安全隐患。目前支持 Web Sockets 的浏览器有 Firefox 6+、Safari 5+、Chrome 和 iOS 4 + 版 Safari。

1. Web Sockets API

要创建 Web Socket，先实例一个 WebSocket 对象并传入要连接的 URL：

var socket = new WebSocket("ws://www.example.com/server.php");

注意，必须给 WebSocket 构造函数传入绝对 URL。同源策略对 Web Sockets 不适用，因此可以通过它打开到任何站点的连接。至于是否会与某个域中的页面通信，则完全取决于服务器。（通过握手信息就可以知道请求来自何方。）

实例化了 WebSocket 对象后，浏览器就会马上尝试创建连接。与 XHR 类似，WebSocket 也有一个表示当前状态的 readyState 属性。不过，这个属性的值与 XHR 并不相同，而是如下所示。

WebSocket.OPENING (0)：正在建立连接。

WebSocket.OPEN (1)：已经建立连接。

WebSocket.CLOSING (2)：正在关闭连接。

WebSocket.CLOSE (3)：已经关闭连接。

WebSocket 没有 readystatechange 事件；不过，它有其他事件，对应着不同的状态。readyState 的值永远从 0 开始。

要关闭 Web Socket 连接，可以在任何时候调用 close () 方法。

socket.close();

调用了 close () 之后，readyState 的值立即变为 2（正在关闭），而在关闭连接后就会变成 3。

2. 发送和接收数据

Web Socket 打开之后，就可以通过连接发送和接收数据。要向服务器发送数据，使用 send () 方法并传入任意字符串，例如：

var socket = new WebSocket("ws://www.example.com/server.php"); socket.send("Hello world!");

因为 Web Sockets 只能通过连接发送纯文本数据，所以对于复杂的数据结构，在通过连接发送之前，必须进行序列化。下面的例子展示了先将数据序列化为一个 JSON 字符串，然后再发送到服务器：

var message = { time: new Date(), text: "Hello world!", clientId: "asdfp8734rew" }; socket.send(JSON.stringify(message));

接下来，服务器要读取其中的数据，就要解析接收到的 JSON 字符串。

当服务器向客户端发来消息时，WebSocket 对象就会触发 message 事件。这个 message 事件与其他传递消息的协议类似，也是把返回的数据保存在 event.data 属性中。

socket.onmessage = function (event){var data = event.data; // 处理数据};

与通过 send () 发送到服务器的数据一样，event.data 中返回的数据也是字符串。如果你想得到其他格式的数据，必须手工解析这些数据。

3. 其他事件

WebSocket 对象还有其他三个事件，在连接生命周期的不同阶段触发。

open：在成功建立连接时触发。

error：在发生错误时触发，连接不能持续。

close：在连接关闭时触发。

WebSocket 对象不支持 DOM 2 级事件侦听器，因此必须使用 DOM 0 级语法分别定义每个事件处理程序。

var socket = new WebSocket("ws://www.example.com/server.php"); socket.onopen = function(){ alert("Connection established."); }; socket.onerror = function(){ alert("Connection error."); }; socket.onclose = function(){ alert("Connection closed."); };

在这三个事件中，只有 close 事件的 event 对象有额外的信息。这个事件的事件对象有三个额外的属性：wasClean、code 和 reason。其中，wasClean 是一个布尔值，表示连接是否已经明确地关闭；code 是服务器返回的数值状态码；而 reason 是一个字符串，包含服务器发回的消息。可以把这些信息显示给用户，也可以记录到日志中以便将来分析。

socket.onclose = function(event){ console.log("Was clean? " + event.wasClean + " Code=" + event.code + " Reason=" + event.reason); };

21.5.6　SSE 与 Web Sockets

面对某个具体的用例，在考虑是使用 SSE 还是使用 Web Sockets 时，可以考虑如下几个因素。首先，你是否有自由度建立和维护 Web Sockets 服务器？因为 Web Socket 协议不同于 HTTP，所以现有服务器不能用于 Web Socket 通信。SSE 倒是通过常规 HTTP 通信，因此现有服务器就可以满足需求。

第二个要考虑的问题是到底需不需要双向通信。如果用例只需读取服务器数据（如比赛成绩），那么 SSE 比较容易实现。如果用例必须双向通信（如聊天室），那么 Web Sockets 显然更好。别忘了，在不能选择 Web Sockets 的情况下，组合 XHR 和 SSE 也是能实现双向通信的。

21.6　安全

讨论 Ajax 和 Comet 安全的文章可谓连篇累牍，而相关主题的书也已经出了很多本了。大型 Ajax 应用程序的安全问题涉及面非常之广，但我们可以从普遍意义上探讨一些基本的问题。

首先，可以通过 XHR 访问的任何 URL 也可以通过浏览器或服务器来访问。下面的 URL 就是一个例子。

/getuserinfo.php?id=23

如果是向这个 URL 发送请求，可以想象结果会返回 ID 为 23 的用户的某些数据。谁也无法保证别人不会将这个 URL 的用户 ID 修改为 24、56 或其他值。因此，getuserinfo.php 文件必须知道请求者是否真的有权限访问要请求的数据；否则，你的服务器就会门户大开，任何人的数据都可能被泄漏出去。

对于未被授权系统有权访问某个资源的情况，我们称之为 CSRF（Cross-Site Request Forgery，跨站点请求伪造）。未被授权系统会伪装自己，让处理请求的服务器认为它是合法的。受到 CSRF 攻击的 Ajax 程序有大有小，攻击行为既有旨在揭示系统漏洞的恶作剧，也有恶意的数据窃取或数据销毁。

为确保通过 XHR 访问的 URL 安全，通行的做法就是验证发送请求者是否有权限访问相应的资源。有下列几种方式可供选择。

要求以 SSL 连接来访问可以通过 XHR 请求的资源。

要求每一次请求都要附带经过相应算法计算得到的验证码。

请注意，下列措施对防范 CSRF 攻击不起作用。

要求发送 POST 而不是 GET 请求 —— 很容易改变。

检查来源 URL 以确定是否可信 —— 来源记录很容易伪造。

基于 cookie 信息进行验证 —— 同样很容易伪造。

XHR 对象也提供了一些安全机制，虽然表面上看可以保证安全，但实际上却相当不可靠。实际上，前面介绍的 open () 方法还能再接收两个参数：要随请求一起发送的用户名和密码。带有这两个参数的请求可以通过 SSL 发送给服务器上的页面，如下面的例子所示。

xhr.open ("get", "example.php", true, "username", "password"); // 不要这样做！！

即便可以考虑这种安全机制，但还是尽量不要这样做。把用户名和密码保存在 JavaScript 代码中本身就是极为不安全的。任何人，只要他会使用 JavaScript 调试器，就可以通过查看相应的变量发现纯文本形式的用户名和密码。

21.7　小结

Ajax 是无需刷新页面就能够从服务器取得数据的一种方法。关于 Ajax，可以从以下几方面来总结一下。

负责 Ajax 运作的核心对象是 XMLHttpRequest（XHR）对象。

XHR 对象由微软最早在 IE5 中引入，用于通过 JavaScript 从服务器取得 XML 数据。

在此之后，Firefox、Safari、Chrome 和 Opera 都实现了相同的特性，使 XHR 成为了 Web 的一个事实标准。

虽然实现之间存在差异，但 XHR 对象的基本用法在不同浏览器间还是相对规范的，因此可以放心地用在 Web 开发当中。

同源策略是对 XHR 的一个主要约束，它为通信设置了「相同的域、相同的端口、相同的协议」这一限制。试图访问上述限制之外的资源，都会引发安全错误，除非采用被认可的跨域解决方案。这个解决方案叫做 CORS（Cross-Origin Resource Sharing，跨源资源共享），IE8 通过 XDomainRequest 对象支持 CORS，其他浏览器通过 XHR 对象原生支持 CORS。图像 Ping 和 JSONP 是另外两种跨域通信的技术，但不如 CORS 稳妥。

Comet 是对 Ajax 的进一步扩展，让服务器几乎能够实时地向客户端推送数据。实现 Comet 的手段主要有两个：长轮询和 HTTP 流。所有浏览器都支持长轮询，而只有部分浏览器原生支持 HTTP 流。SSE（Server-Sent Events，服务器发送事件）是一种实现 Comet 交互的浏览器 API，既支持长轮询，也支持 HTTP 流。

Web Sockets 是一种与服务器进行全双工、双向通信的信道。与其他方案不同，Web Sockets 不使用 HTTP 协议，而使用一种自定义的协议。这种协议专门为快速传输小数据设计。虽然要求使用不同的 Web 服务器，但却具有速度上的优势。

各方面对 Ajax 和 Comet 的鼓吹吸引了越来越多的开发人员学习 JavaScript，人们对 Web 开发的关注也再度升温。与 Ajax 有关的概念都还相对比较新，这些概念会随着时间推移继续发展。

Ajax 是一个非常庞大的主题，完整地讨论这个主题超出了本书的范围。要想了解有关 Ajax 的更多信息，请读者参考《Ajax 高级程序设计（第 2 版）》。

第 22 章　高级技巧

本章内容

使用高级函数

防篡改对象

Yielding Timers

JavaScript 是一种极其灵活的语言，具有多种使用风格。一般来说，编写 JavaScript 要么使用过程方式，要么使用面向对象方式。然而，由于它天生的动态属性，这种语言还能使用更为复杂和有趣的模式。这些技巧要利用 ECMAScript 的语言特点、BOM 扩展和 DOM 功能来获得强大的效果。

22.1　高级函数

函数是 JavaScript 中最有趣的部分之一。它们本质上是十分简单和过程化的，但也可以是非常复杂和动态的。一些额外的功能可以通过使用闭包来实现。此外，由于所有的函数都是对象，所以使用函数指针非常简单。这些令 JavaScript 函数不仅有趣而且强大。以下几节描绘了几种在 JavaScript 中使用函数的高级方法。

22.1.1　安全的类型检测

JavaScript 内置的类型检测机制并非完全可靠。事实上，发生错误否定及错误肯定的情况也不在少数。比如说 typeof 操作符吧，由于它有一些无法预知的行为，经常会导致检测数据类型时得到不靠谱的结果。Safari（直至第 4 版）在对正则表达式应用 typeof 操作符时会返回 "function"，因此很难确定某个值到底是不是函数。

再比如，instanceof 操作符在存在多个全局作用域（像一个页面包含多个框架）的情况下，也是问题多多。一个经典的例子（第 5 章也提到过）就是像下面这样将对象标识为数组。

var isArray = value instanceof Array;

以上代码要返回 true，value 必须是一个数组，而且还必须与 Array 构造函数在同个全局作用域中。（别忘了，Array 是 window 的属性。）如果 value 是在另个框架中定义的数组，那么以上代码就会返回 false。

在检测某个对象到底是原生对象还是开发人员自定义的对象的时候，也会有问题。出现这个问题的原因是浏览器开始原生支持 JSON 对象了。因为很多人一直在使用 Douglas Crockford 的 JSON 库，而该库定义了一个全局 JSON 对象。于是开发人员很难确定页面中的 JSON 对象到底是不是原生的。

解决上述问题的办法都一样。大家知道，在任何值上调用 Object 原生的 toString () 方法，都会返回一个 [object NativeConstructorName] 格式的字符串。每个类在内部都有一个 [[Class]] 属性，这个属性中就指定了上述字符串中的构造函数名。举个例子吧。

alert(Object.prototype.toString.call(value)); //"[object Array]"

由于原生数组的构造函数名与全局作用域无关，因此使用 toString () 就能保证返回一致的值。利用这一点，可以创建如下函数：

function isArray(value){ return Object.prototype.toString.call(value) == "[object Array]"; }

同样，也可以基于这一思路来测试某个值是不是原生函数或正则表达式：

function isFunction(value){ return Object.prototype.toString.call(value) == "[object Function]"; } function isRegExp(value){ return Object.prototype.toString.call(value) == "[object RegExp]"; }

不过要注意，对于在 IE 中以 COM 对象形式实现的任何函数，isFunction () 都将返回 false（因为它们并非原生的 JavaScript 函数，请参考第 10 章中更详细的介绍）。

这一技巧也广泛应用于检测原生 JSON 对象。Object 的 toString () 方法不能检测非原生构造函数的构造函数名。因此，开发人员定义的任何构造函数都将返回 [object Object]。有些 JavaScript 库会包含与下面类似的代码。

var isNativeJSON = window.JSON && Object.prototype.toString.call(JSON) == "[object JSON]";

在 Web 开发中能够区分原生与非原生 JavaScript 对象非常重要。只有这样才能确切知道某个对象到底有哪些功能。这个技巧可以对任何对象给出正确的结论。

请注意，Object.prototpye.toString () 本身也可能会被修改。本节讨论的技巧假设 Object.prototpye.toString () 是未被修改过的原生版本。

22.1.2　作用域安全的构造函数

第 6 章讲述了用于自定义对象的构造函数的定义和用法。你应该还记得，构造函数其实就是一个使用 new 操作符调用的函数。当使用 new 调用时，构造函数内用到的 this 对象会指向新创建的对象实例，如下面的例子所示：

function Person(name, age, job){ this.name = name; this.age = age; this.job = job; } var person = new Person("Nicholas", 29, "Software Engineer");

ScopeSafeConstructorsExample01.htm

上面这个例子中，Person 构造函数使用 this 对象给三个属性赋值：name、age 和 job。当和 new 操作符连用时，则会创建一个新的 Person 对象，同时会给它分配这些属性。问题出在当没有使用 new 操作符来调用该构造函数的情况上。由于该 this 对象是在运行时绑定的，所以直接调用 Person ()，this 会映射到全局对象 window 上，导致错误对象属性的意外增加。例如：

var person = Person("Nicholas", 29, "Software Engineer"); alert(window.name); //"Nicholas" alert(window.age); //29 alert(window.job); //"Software Engineer"

ScopeSafeConstructorsExample01.htm

这里，原本针对 Person 实例的三个属性被加到 window 对象上，因为构造函数是作为普通函数调用的，忽略了 new 操作符。这个问题是由 this 对象的晚绑定造成的，在这里 this 被解析成了 window 对象。由于 window 的 name 属性是用于识别链接目标和框架的，所以这里对该属性的偶然覆盖可能会导致该页面上出现其他错误。这个问题的解决方法就是创建一个作用域安全的构造函数。

作用域安全的构造函数在进行任何更改前，首先确认 this 对象是正确类型的实例。如果不是，那么会创建新的实例并返回。请看以下例子：

function Person(name, age, job){ if (this instanceof Person){ this.name = name; this.age = age; this.job = job; } else { return new Person(name, age, job); } } var person1 = Person("Nicholas", 29, "Software Engineer"); alert(window.name); //"" alert(person1.name); //"Nicholas" var person2 = new Person("Shelby", 34, "Ergonomist"); alert(person2.name); //"Shelby"

ScopeSafeConstructorsExample02.htm

这段代码中的 Person 构造函数添加了一个检查并确保 this 对象是 Person 实例的 if 语句，它表示要么使用 new 操作符，要么在现有的 Person 实例环境中调用构造函数。任何一种情况下，对象初始化都能正常进行。如果 this 并非 Person 的实例，那么会再次使用 new 操作符调用构造函数并返回结果。最后的结果是，调用 Person 构造函数时无论是否使用 new 操作符，都会返回一个 Person 的新实例，这就避免了在全局对象上意外设置属性。

关于作用域安全的构造函数的贴心提示。实现这个模式后，你就锁定了可以调用构造函数的环境。如果你使用构造函数窃取模式的继承且不使用原型链，那么这个继承很可能被破坏。这里有个例子：

function Polygon(sides){ if (this instanceof Polygon) { this.sides = sides; this.getArea = function(){ return 0; }; } else { return new Polygon(sides); } } function Rectangle(width, height){ Polygon.call(this, 2); this.width = width; this.height = height; this.getArea = function(){ return this.width * this.height; }; } var rect = new Rectangle(5, 10); alert(rect.sides); //undefined

ScopeSafeConstructorsExample03.htm

在这段代码中，Polygon 构造函数是作用域安全的，然而 Rectangle 构造函数则不是。新创建一个 Rectangle 实例之后，这个实例应该通过 Polygon.call () 来继承 Polygon 的 sides 属性。但是，由于 Polygon 构造函数是作用域安全的，this 对象并非 Polygon 的实例，所以会创建并返回一个新的 Polygon 对象。Rectangle 构造函数中的 this 对象并没有得到增长，同时 Polygon.call () 返回的值也没有用到，所以 Rectangle 实例中就不会有 sides 属性。

如果构造函数窃取结合使用原型链或者寄生组合则可以解决这个问题。考虑以下例子：

function Polygon(sides){ if (this instanceof Polygon) { this.sides = sides; this.getArea = function(){ return 0; }; } else { return new Polygon(sides); } } function Rectangle(width, height){ Polygon.call(this, 2); this.width = width; this.height = height; this.getArea = function(){ return this.width * this.height; }; } Rectangle.prototype = new Polygon(); var rect = new Rectangle(5, 10); alert(rect.sides); //2

ScopeSafeConstructorsExample04.htm

上面这段重写的代码中，一个 Rectangle 实例也同时是一个 Polygon 实例，所以 Polygon.call () 会照原意执行，最终为 Rectangle 实例添加了 sides 属性。

多个程序员在同一个页面上写 JavaScript 代码的环境中，作用域安全构造函数就很有用了。届时，对全局对象意外的更改可能会导致一些常常难以追踪的错误。除非你单纯基于构造函数窃取来实现继承，推荐作用域安全的构造函数作为最佳实践。

22.1.3　惰性载入函数

因为浏览器之间行为的差异，多数 JavaScript 代码包含了大量的 if 语句，将执行引导到正确的代码中。看看下面来自上一章的 createXHR () 函数。

function createXHR (){ if (typeof XMLHttpRequest != "undefined"){return new XMLHttpRequest (); } else if (typeof ActiveXObject != "undefined"){if (typeof arguments.callee.activeXString != "string"){var versions = ["MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"], i,len; for (i=0,len=versions.length; i < len; i++){try { new ActiveXObject (versions [i]); arguments.callee.activeXString = versions [i]; break; } catch (ex){// 跳过} } } return new ActiveXObject (arguments.callee.activeXString); } else {throw new Error ("No XHR object available."); } }

每次调用 createXHR () 的时候，它都要对浏览器所支持的能力仔细检查。首先检查内置的 XHR，然后测试有没有基于 ActiveX 的 XHR，最后如果都没有发现的话就抛出一个错误。每次调用该函数都是这样，即使每次调用时分支的结果都不变：如果浏览器支持内置 XHR，那么它就一直支持了，那么这种测试就变得没必要了。即使只有一个 if 语句的代码，也肯定要比没有 if 语句的慢，所以如果 if 语句不必每次执行，那么代码可以运行地更快一些。解决方案就是称之为惰性载入的技巧。

惰性载入表示函数执行的分支仅会发生一次。有两种实现惰性载入的方式，第一种就是在函数被调用时再处理函数。在第一次调用的过程中，该函数会被覆盖为另外一个按合适方式执行的函数，这样任何对原函数的调用都不用再经过执行的分支了。例如，可以用下面的方式使用惰性载入重写 createXHR ()。

function createXHR(){ if (typeof XMLHttpRequest != "undefined"){ createXHR = function(){ return new XMLHttpRequest(); }; } else if (typeof ActiveXObject != "undefined"){ createXHR = function(){ if (typeof arguments.callee.activeXString != "string"){ var versions = ["MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"], i, len; for (i=0,len=versions.length; i < len; i++){ try { new ActiveXObject(versions[i]); arguments.callee.activeXString = versions[i]; break; } catch (ex){ //skip } } } return new ActiveXObject(arguments.callee.activeXString); }; } else { createXHR = function(){ throw new Error("No XHR object available."); }; } return createXHR(); }

LazyLoadingExample01.htm

在这个惰性载入的 createXHR () 中，if 语句的每一个分支都会为 createXHR 变量赋值，有效覆盖了原有的函数。最后一步便是调用新赋的函数。下一次调用 createXHR () 的时候，就会直接调用被分配的函数，这样就不用再次执行 if 语句了。

第二种实现惰性载入的方式是在声明函数时就指定适当的函数。这样，第一次调用函数时就不会损失性能了，而在代码首次加载时会损失一点性能。以下就是按照这一思路重写前面例子的结果。

var createXHR = (function(){ if (typeof XMLHttpRequest != "undefined"){ return function(){ return new XMLHttpRequest(); }; } else if (typeof ActiveXObject != "undefined"){ return function(){ if (typeof arguments.callee.activeXString != "string"){ var versions = ["MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"], i, len; for (i=0,len=versions.length; i < len; i++){ try { new ActiveXObject(versions[i]); arguments.callee.activeXString = versions[i]; break; } catch (ex){ //skip } } } return new ActiveXObject(arguments.callee.activeXString); }; } else { return function(){ throw new Error("No XHR object available."); }; } })();

LazyLoadingExample02.htm

这个例子中使用的技巧是创建一个匿名、自执行的函数，用以确定应该使用哪一个函数实现。实际的逻辑都一样。不一样的地方就是第一行代码（使用 var 定义函数）、新增了自执行的匿名函数，另外每个分支都返回正确的函数定义，以便立即将其赋值给 createXHR ()。

惰性载入函数的优点是只在执行分支代码时牺牲一点儿性能。至于哪种方式更合适，就要看你的具体需求而定了。不过这两种方式都能避免执行不必要的代码。

22.1.4　函数绑定

另一个日益流行的高级技巧叫做函数绑定。函数绑定要创建一个函数，可以在特定的 this 环境中以指定参数调用另一个函数。该技巧常常和回调函数与事件处理程序一起使用，以便在将函数作为变量传递的同时保留代码执行环境。请看以下例子：

var handler = { message: "Event handled", handleClick: function(event){ alert(this.message); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", handler.handleClick);

在上面这个例子中，创建了一个叫做 handler 的对象。handler.handleClick () 方法被分配为一个 DOM 按钮的事件处理程序。当按下该按钮时，就调用该函数，显示一个警告框。虽然貌似警告框应该显示 Event handled，然而实际上显示的是 undefiend。这个问题在于没有保存 handler.handleClick () 的环境，所以 this 对象最后是指向了 DOM 按钮而非 handler（在 IE8 中，this 指向 window。）可以如下面例子所示，使用一个闭包来修正这个问题。

var handler = { message: "Event handled", handleClick: function(event){ alert(this.message); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", function(event){ handler.handleClick(event); });

这个解决方案在 onclick 事件处理程序内使用了一个闭包直接调用 handler.handleClick ()。当然，这是特定于这段代码的解决方案。创建多个闭包可能会令代码变得难于理解和调试。因此，很多 JavaScript 库实现了一个可以将函数绑定到指定环境的函数。这个函数一般都叫 bind ()。

一个简单的 bind () 函数接受一个函数和一个环境，并返回一个在给定环境中调用给定函数的函数，并且将所有参数原封不动传递过去。语法如下：

function bind(fn, context){ return function(){ return fn.apply(context, arguments); }; }

FunctionBindingExample01.htm

这个函数似乎简单，但其功能是非常强大的。在 bind () 中创建了一个闭包，闭包使用 apply () 调用传入的函数，并给 apply () 传递 context 对象和参数。注意这里使用的 arguments 对象是内部函数的，而非 bind () 的。当调用返回的函数时，它会在给定环境中执行被传入的函数并给出所有参数。bind () 函数按如下方式使用：

var handler = { message: "Event handled", handleClick: function(event){ alert(this.message); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", bind(handler.handleClick, handler));

FunctionBindingExample01.htm

在这个例子中，我们用 bind () 函数创建了一个保持了执行环境的函数，并将其传给 EventUtil.addHandler ()。event 对象也被传给了该函数，如下所示：

var handler = { message: "Event handled", handleClick: function(event){ alert(this.message + ":" + event.type); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", bind(handler.handleClick, handler));

FunctionBindingExample01.htm

handler.handleClick () 方法和平时一样获得了 event 对象，因为所有的参数都通过被绑定的函数直接传给了它。

ECMAScript 5 为所有函数定义了一个原生的 bind () 方法，进一步简单了操作。换句话说，你不用再自己定义 bind () 函数了，而是可以直接在函数上调用这个方法。例如：

var handler = { message: "Event handled", handleClick: function(event){ alert(this.message + ":" + event.type); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", handler.handleClick.bind(handler));

FunctionBindingExample02.htm

原生的 bind () 方法与前面介绍的自定义 bind () 方法类似，都是要传入作为 this 值的对象。支持原生 bind () 方法的浏览器有 IE9+、Firefox 4 + 和 Chrome。

只要是将某个函数指针以值的形式进行传递，同时该函数必须在特定环境中执行，被绑定函数的效用就突显出来了。它们主要用于事件处理程序以及 setTimeout () 和 setInterval ()。然而，被绑定函数与普通函数相比有更多的开销，它们需要更多内存，同时也因为多重函数调用稍微慢一点，所以最好只在必要时使用。

22.1.5　函数柯里化

与函数绑定紧密相关的主题是函数柯里化（function currying），它用于创建已经设置好了一个或多个参数的函数。函数柯里化的基本方法和函数绑定是一样的：使用一个闭包返回一个函数。两者的区别在于，当函数被调用时，返回的函数还需要设置一些传入的参数。请看以下例子。

function add(num1, num2){ return num1 + num2; } function curriedAdd(num2){ return add(5, num2); } alert(add(2, 3)); //5 alert(curriedAdd(3)); //8

这段代码定义了两个函数：add () 和 curriedAdd ()。后者本质上是在任何情况下第一个参数为 5 的 add () 版本。尽管从技术上来说 curriedAdd () 并非柯里化的函数，但它很好地展示了其概念。

柯里化函数通常由以下步骤动态创建：调用另一个函数并为它传入要柯里化的函数和必要参数。下面是创建柯里化函数的通用方式。

function curry(fn){ var args = Array.prototype.slice.call(arguments, 1); return function(){ var innerArgs = Array.prototype.slice.call(arguments); var finalArgs = args.concat(innerArgs); return fn.apply(null, finalArgs); }; }

FunctionCurryingExample01.htm

curry () 函数的主要工作就是将被返回函数的参数进行排序。curry () 的第一个参数是要进行柯里化的函数，其他参数是要传入的值。为了获取第一个参数之后的所有参数，在 arguments 对象上调用了 slice () 方法，并传入参数 1 表示被返回的数组包含从第二个参数开始的所有参数。然后 args 数组包含了来自外部函数的参数。在内部函数中，创建了 innerArgs 数组用来存放所有传入的参数（又一次用到了 slice ()）。有了存放来自外部函数和内部函数的参数数组后，就可以使用 concat () 方法将它们组合为 finalArgs，然后使用 apply () 将结果传递给该函数。注意这个函数并没有考虑到执行环境，所以调用 apply () 时第一个参数是 null。curry () 函数可以按以下方式应用。

function add(num1, num2){ return num1 + num2; } var curriedAdd = curry(add, 5); alert(curriedAdd(3)); //8

FunctionCurryingExample01.htm

在这个例子中，创建了第一个参数绑定为 5 的 add () 的柯里化版本。当调用 curriedAdd () 并传入 3 时，3 会成为 add () 的第二个参数，同时第一个参数依然是 5，最后结果便是和 8。你也可以像下面例子这样给出所有的函数参数：

function add(num1, num2){ return num1 + num2; } var curriedAdd = curry(add, 5, 12); alert(curriedAdd()); //17

FunctionCurryingExample01.htm

在这里，柯里化的 add () 函数两个参数都提供了，所以以后就无需再传递它们了。

函数柯里化还常常作为函数绑定的一部分包含在其中，构造出更为复杂的 bind () 函数。例如：

function bind(fn, context){ var args = Array.prototype.slice.call(arguments, 2); return function(){ var innerArgs = Array.prototype.slice.call(arguments); var finalArgs = args.concat(innerArgs); return fn.apply(context, finalArgs); }; }

FunctionCurryingExample02.htm

对 curry () 函数的主要更改在于传入的参数个数，以及它如何影响代码的结果。curry () 仅仅接受一个要包裹的函数作为参数，而 bind () 同时接受函数和一个 object 对象。这表示给被绑定的函数的参数是从第三个开始而不是第二个，这就要更改 slice () 的第一处调用。另一处更改是在倒数第 3 行将 object 对象传给 apply ()。当使用 bind () 时，它会返回绑定到给定环境的函数，并且可能它其中某些函数参数已经被设好。当你想除了 event 对象再额外给事件处理程序传递参数时，这非常有用，例如：

var handler = { message: "Event handled", handleClick: function(name, event){ alert(this.message + ":"+ name + ":"+ event.type); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", bind(handler.handleClick, handler, "my-btn"));

FunctionCurryingExample02.htm

在这个更新过的例子中，handler.handleClick () 方法接受了两个参数：要处理的元素的名字和 event 对象。作为第三个参数传递给 bind () 函数的名字，又被传递给了 handler.handleClick ()，而 handler.handleClick () 也会同时接收到 event 对象。

ECMAScript 5 的 bind () 方法也实现函数柯里化，只要在 this 的值之后再传入另一个参数即可。

var handler = { message: "Event handled", handleClick: function(name, event){ alert(this.message + ":" + name + ":" + event.type); } }; var btn = document.getElementById("my-btn"); EventUtil.addHandler(btn, "click", handler.handleClick.bind(handler, "my-btn"));

FunctionCurryingExample03.htm

JavaScript 中的柯里化函数和绑定函数提供了强大的动态函数创建功能。使用 bind () 还是 curry () 要根据是否需要 object 对象响应来决定。它们都能用于创建复杂的算法和功能，当然两者都不应滥用，因为每个函数都会带来额外的开销。

22.2　防篡改对象

JavaScript 共享的本质一直是开发人员心头的痛。因为任何对象都可以被在同一环境中运行的代码修改。开发人员很可能会意外地修改别人的代码，甚至更糟糕地，用不兼容的功能重写原生对象。ECMAScript 5 致力于解决这个问题，可以让开发人员定义防篡改对象（tamper-proof object）。

第 6 章讨论了对象属性的问题，也讨论了如何手工设置每个属性的 [[Configurable]]、[[Writable]]、[[Enumerable]]、[[Value]]、[[Get]] 以及 [[Set]] 特性，以改变属性的行为。类似地，ECMAScript 5 也增加了几个方法，通过它们可以指定对象的行为。

不过请注意：一旦把对象定义为防篡改，就无法撤销了。

22.2.1　不可扩展对象

默认情况下，所有对象都是可以扩展的。也就是说，任何时候都可以向对象中添加属性和方法。例如，可以像下面这样先定义一个对象，后来再给它添加一个属性。

var person = { name: "Nicholas" }; person.age = 29;

即使第一行代码已经完整定义 person 对象，但第二行代码仍然能给它添加属性。现在，使用 Object.preventExtensions () 方法可以改变这个行为，让你不能再给对象添加属性和方法。例如：

var person = { name: "Nicholas" }; Object.preventExtensions(person); person.age = 29; alert(person.age); //undefined

NonExtensibleObjectsExample01.htm

在调用了 Object.preventExtensions () 方法后，就不能给 person 对象添加新属性和方法了。在非严格模式下，给对象添加新成员会导致静默失败，因此 person.age 将是 undefined。而在严格模式下，尝试给不可扩展的对象添加新成员会导致抛出错误。

虽然不能给对象添加新成员，但已有的成员则丝毫不受影响。你仍然还可以修改和删除已有的成员。另外，使用 Object.istExtensible () 方法还可以确定对象是否可以扩展。

var person = { name: "Nicholas" }; alert(Object.isExtensible(person)); //true Object.preventExtensions(person); alert(Object.isExtensible(person)); //false

NonExtensibleObjectsExample02.htm

22.2.2　密封的对象

ECMAScript 5 为对象定义的第二个保护级别是密封对象（sealed object）。密封对象不可扩展，而且已有成员的 [[Configurable]] 特性将被设置为 false。这就意味着不能删除属性和方法，因为不能使用 Object.defineProperty () 把数据属性修改为访问器属性，或者相反。属性值是可以修改的。

要密封对象，可以使用 Object.seal () 方法。

var person = { name: "Nicholas" }; Object.seal(person); person.age = 29; alert(person.age); //undefined delete person.name; alert(person.name); //"Nicholas"

