无论对 sessionStorage、globalStorage 还是 localStorage 进行操作，都会触发 storage 事件，但不作区分。

6. 限制

与其他客户端数据存储方案类似，Web Storage 同样也有限制。这些限制因浏览器而异。一般来说，对存储空间大小的限制都是以每个来源（协议、域和端口）为单位的。换句话说，每个来源都有固定大小的空间用于保存自己的数据。考虑到这个限制，就要注意分析和控制每个来源中有多少页面需要保存数据。

对于 localStorage 而言，大多数桌面浏览器会设置每个来源 5MB 的限制。Chrome 和 Safari 对每个来源的限制是 2.5MB。而 iOS 版 Safari 和 Android 版 WebKit 的限制也是 2.5MB。

对 sessionStorage 的限制也是因浏览器而异。有的浏览器对 sessionStorage 的大小没有限制，但 Chrome、Safari、iOS 版 Safari 和 Android 版 WebKit 都有限制，也都是 2.5MB。IE8 + 和 Opera 对 sessionStorage 的限制是 5MB。

有关 Web Storage 的限制，请参考 http://dev-test.nemikor.com/web-storage/support-test/。

23.3.4　IndexedDB

Indexed Database API，或者简称为 IndexedDB，是在浏览器中保存结构化数据的一种数据库。IndexedDB 是为了替代目前已被废弃的 Web SQL Database API（因为已废弃，所以本书未介绍）而出现的。IndexedDB 的思想是创建一套 API，方便保存和读取 JavaScript 对象，同时还支持查询及搜索。

IndexedDB 设计的操作完全是异步进行的。因此，大多数操作会以请求方式进行，但这些操作会在后期执行，然后如果成功则返回结果，如果失败则返回错误。差不多每一次 IndexedDB 操作，都需要你注册 onerror 或 onsuccess 事件处理程序，以确保适当地处理结果。

在得到完整支持的情况下，IndexedDB 将是一个作为 API 宿主的全局对象。由于 API 仍然可能有变化，浏览器也都使用提供商前缀，因此这个对象在 IE10 中叫 msIndexedDB，在 Firefox 4 中叫 mozIndexedDB，在 Chrome 中叫 webkitIndexedDB。为了清楚起见，本节示例中将使用 IndexedDB，而实际上每个示例前面都应该加上下面这行代码：

var indexedDB = window.indexedDB || window.msIndexedDB || window.mozIndexedDB || window.webkitIndexedDB;

IndexedDBExample01.htm

1. 数据库

IndexedDB 就是一个数据库，与 MySQL 或 Web SQL Database 等这些你以前可能用过的数据库类似。IndexedDB 最大的特色是使用对象保存数据，而不是使用表来保存数据。一个 IndexedDB 数据库，就是一组位于相同命名空间下的对象的集合。

使用 IndexedDB 的第一步是打开它，即把要打开的数据库名传给 indexDB.open ()。如果传入的数据库已经存在，就会发送一个打开它的请求；如果传入的数据库还不存在，就会发送一个创建并打开它的请求。总之，调用 indexDB.open () 会返回一个 IDBRequest 对象，在这个对象上可以添加 onerror 和 onsuccess 事件处理程序。先来看一个例子。

var request, database; request = indexedDB.open("admin"); request.onerror = function(event){ alert("Something bad happened while trying to open: " + event.target.errorCode); }; request.onsuccess = function(event){ database = event.target.result; };

IndexedDBExample01.htm

在这两个事件处理程序中，event.target 都指向 request 对象，因此它们可以互换使用。如果响应的是 onsuccess 事件处理程序，那么 event.target.result 中将有一个数据库实例对象（IDBDatabase），这个对象会保存在 database 变量中。如果发生了错误，那 event.target.errorCode 中将保存一个错误码，表示问题的性质。以下就是可能的错误码（这个错误码适合所有操作）。

IDBDatabaseException.UNKNOWN_ERR (1)：意外错误，无法归类。

IDBDatabaseException.NON_TRANSIENT_ERR (2)：操作不合法。

IDBDatabaseException.NOT_FOUND_ERR (3)：未发现要操作的数据库。

IDBDatabaseException.CONSTRAINT_ERR (4)：违反了数据库约束。

IDBDatabaseException.DATA_ERR (5)：提供给事务的数据不能满足要求。

IDBDatabaseException.NOT_ALLOWED_ERR (6)：操作不合法。

IDBDatabaseException.TRANSACTION_INACTIVE_ERR (7)：试图重用已完成的事务。

IDBDatabaseException.ABORT_ERR (8)：请求中断，未成功。

IDBDatabaseException.READ_ONLY_ERR (9)：试图在只读模式下写入或修改数据。

IDBDatabaseException.TIMEOUT_ERR (10)：在有效时间内未完成操作。

IDBDatabaseException.QUOTA_ERR (11)：磁盘空间不足。

默认情况下，IndexedDB 数据库是没有版本号的，最好一开始就为数据库指定一个版本号。为此，可以调用 setVersion () 方法，传入以字符串形式表示的版本号。同样，调用这个方法也会返回一个请求对象，需要你再指定事件处理程序。

if (database.version != "1.0"){ request = database.setVersion("1.0"); request.onerror = function(event){ alert("Something bad happened while trying to set version: " + event.target.errorCode); }; request.onsuccess = function(event){ alert("Database initialization complete. Database name: " + database.name + ", Version: " + database.version); }; } else { alert("Database already initialized. Database name: " + database.name + ", Version: " + database.version); }

IndexedDBExample01.htm

这个例子尝试把数据库的版本号设置为 1.0。第一行先检测 version 属性，看是否已经为数据库设置了相应的版本号。如果没有，就调用 setVersion () 创建修改版本的请求。如果请求成功，显示一条消息，表示版本修改成功。（在真实的项目开发中，你应该在这里建立对象存储空间。详细内容请看下一节。）

如果数据库的版本号已经被设置为 1.0，则显示一条消息，说明数据库已经初始化过了。总之，通过这种模式，就能知道你想使用的数据库是否已经设置了适当的对象存储空间。在整个 Web 应用中，随着对数据库结构的更新和修改，可能会产生很多个不同版本的数据库。

2. 对象存储空间

在建立了与数据库的连接之后，下一步就是使用对象存储空间 1。如果数据库的版本与你传入的版本不匹配，那可能就需要创建一个新的对象存储空间。在创建对象存储空间之前，必须要想清楚你想要保存什么数据类型。

1 有关系数据库经验的读者，可以把这里的对象存储空间（object storge）想象成表，而把其中保存的对象想象成表中的记录。

假设你要保存的用户记录由用户名、密码等组成，那么保存一条记录的对象应该类似如下所示：

var user = { username: "007", firstName: "James", lastName: "Bond", password: "foo" };

有了这个对象，很容易想到 username 属性可以作为这个对象存储空间的键。这个 username 必须全局唯一，而且大多数时候都要通过这个键来访问数据。这一点非常重要，因为在创建对象存储空间时，必须指定这么一个键。以下是就是为保存上述用户记录而创建对象存储空间的示例。

var store = db.createObjectStore("users", { keyPath: "username" });

IndexedDBExample02.htm

其中第二个参数中的 keyPath 属性，就是空间中将要保存的对象的一个属性，而这个属性将作为存储空间的键来使用。

好，现在有了一个对存储空间的引用。接下来可以使用 add () 或 put () 方法来向其中添加数据。这两个方法都接收一个参数，即要保存的对象，然后这个对象就会被保存到存储空间中。这两个方法的区别在空间中已经包含键值相同的对象时会体现出来。在这种情况下，add () 会返回错误，而 put () 则会重写原有对象。简单地说，可以把 add () 想象成插入新值，把 put () 想象成更新原有的值。在初始化对象存储空间时，可以使用类似下面这样的代码。

//users 中保存着一批用户对象 var i=0, len = users.length; while (i < len){store.add (users [i++]); }

IndexedDBExample02.htm

每次调用 add () 或 put () 都会创建一个新的针对这个对象存储空间的更新请求。如果想验证请求是否成功完成，可以把返回的请求对象保存在一个变量中，然后再指定 onerror 或 onsuccess 事件处理程序。

//users 中保存着一批用户对象 var i=0, request, requests = [], len = users.length; while (i < len){request = store.add (users [i++]); request.onerror = function (){ // 处理错误}; request.onsuccess = function (){ // 处理成功}; requests.push (request); }

创建了对象存储空间并向其中添加了数据之后，就该查询数据了。

3. 事务

跨过创建对象存储空间这一步之后，接下来的所有操作都是通过事务来完成的。在数据库对象上调用 transaction () 方法可以创建事务。任何时候，只要想读取或修改数据，都要通过事务来组织所有操作。在最简单的情况下，可以像下面这样创建事务 2。

2 以下示例代码中的 db 即前面示例代码中的 database，正文中提到的「数据库对象」也是指它。

var transaction = db.transaction();

如果没有参数，就只能通过事务来读取数据库中保存的对象。最常见的方式是传入要访问的一或多个对象存储空间。

var transaction = db.transaction("users");

这样就能保证只加载 users 存储空间中的数据，以便通过事务进行访问。如果要访问多个对象存储空间，也可以在第一个参数的位置上传入字符串数组。

var transaction = db.transaction(["users", "anotherStore"]);

如前所述，这些事务都是以只读方式访问数据。要修改访问方式，必须在创建事务时传入第二个参数，这个参数表示访问模式，用 IDBTransaction 接口定义的如下常量表示：READ_ONLY（0）表示只读，READ_WRITE（1）表示读写，VERSION_CHANGE（2）表示改变。IE10 + 和 Firefox 4 + 实现的是 IDBTransaction，但在 Chrome 中则叫 webkitIDBTransaction，所以使用下面的代码可以统一接口：

var IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction;

IndexedDBExample03.htm

有了这行代码，就可以更方便地为 transaction () 指定第二个参数了。

var transaction = db.transaction("users", IDBTransaction.READ_WRITE);

IndexedDBExample03.htm

这个事务能够读写 users 存储空间。

取得了事务的索引后，使用 objectStore () 方法并传入存储空间的名称，就可以访问特定的存储空间。然后，可以像以前一样使用 add () 和 put () 方法，使用 get () 可以取得值，使用 delete () 可以删除对象，而使用 clear () 则可以删除所有对象。get () 和 delete () 方法都接收一个对象键作为参数，而所有这 5 个方法都会返回一个新的请求对象。例如：

var request = db.transaction("users").objectStore("users").get("007"); request.onerror = function(event){ alert("Did not get the object!"); }; request.onsuccess = function(event){ var result = event.target.result; alert(result.firstName); //"James" };

IndexedDBExample02.htm

因为一个事务可以完成任何多个请求，所以事务对象本身也有事件处理程序：onerror 和 oncomplete。这两个事件可以提供事务级的状态信息。

transaction.onerror = function (event){// 整个事务都被取消了}; transaction.oncomplete = function (event){// 整个事务都成功完成了};

注意，通过 oncomplete 事件的事件对象（event）访问不到 get () 请求返回的任何数据。必须在相应请求的 onsuccess 事件处理程序中才能访问到数据。

4. 使用游标查询

使用事务可以直接通过已知的键检索单个对象。而在需要检索多个对象的情况下，则需要在事务内部创建游标。游标就是一指向结果集的指针。与传统数据库查询不同，游标并不提前收集结果。游标指针会先指向结果中的第一项，在接到查找下一项的指令时，才会指向下一项。

在对象存储空间上调用 openCursor () 方法可以创建游标。与 IndexedDB 中的其他操作一样，openCursor () 方法返回的是一个请求对象，因此必须为该对象指定 onsuccess 和 onerror 事件处理程序。例如：

var store = db.transaction ("users").objectStore ("users"), request = store.openCursor (); request.onsuccess = function (event){// 处理成功}; request.onerror = function (event){// 处理失败};

IndexedDBExample04.htm

在 onsuccess 事件处理程序执行时，可以通过 event.target.result 取得存储空间中的下一个对象。在结果集中有下一项时，这个属性中保存一个 IDBCursor 的实例，在没有下一项时，这个属性的值为 null。IDBCursor 的实例有以下几个属性。

direction：数值，表示游标移动的方向。默认值为 IDBCursor.NEXT（0），表示下一项。IDBCursor.NEXT_NO_DUPLICATE（1）表示下一个不重复的项，DBCursor.PREV（2）表示前一项，而 IDBCursor.PREV_NO_DUPLICATE 表示前一个不重复的项。

key：对象的键。

value：实际的对象。

primaryKey：游标使用的键。可能是对象键，也可能是索引键（稍后讨论索引键）。

要检索某一个结果的信息，可以像下面这样：

request.onsuccess = function (event){var cursor = event.target.result; if (cursor){// 必须要检查 console.log ("Key:" + cursor.key + ", Value:" + JSON.stringify (cursor.value)); } };

请记住，这个例子中的 cursor.value 是一个对象，这也是为什么在显示它之前先将它转换成 JSON 字符串的原因。

使用游标可以更新个别的记录。调用 update () 方法可以用指定的对象更新当前游标的 value。与其他操作一样，调用 update () 方法也会创建一个新请求，因此如果你想知道结果，就要为它指定 onsuccess 和 onerror 事件处理程序。

request.onsuccess = function (event){var cursor = event.target.result, value, updateRequest; if (cursor){// 必须要检查 if (cursor.key == "foo"){value = cursor.value; // 取得当前的值 value.password = "magic!"; // 更新密码 updateRequest = cursor.update (value); // 请求保存更新 updateRequest.onsuccess = function (){ // 处理成功}; updateReqeust.onerror = function (){ // 处理失败}; } } };

此时，如果调用 delete () 方法，就会删除相应的记录。与 update () 一样，调用 delete () 也返回一个请求。

request.onsuccess = function (event){var cursor = event.target.result, value, deleteRequest; if (cursor){// 必须要检查 if (cursor.key == "foo"){deleteRequest = cursor.delete (); // 请求删除当前项 deleteRequest.onsuccess = function (){ // 处理成功}; deleteRequest.onerror = function (){ // 处理失败}; } } };

如果当前事务没有修改对象存储空间的权限，update () 和 delete () 会抛出错误。

默认情况下，每个游标只发起一次请求。要想发起另一次请求，必须调用下面的一个方法。

continue (key)：移动到结果集中的下一项。参数 key 是可选的，不指定这个参数，游标移动到下一项；指定这个参数，游标会移动到指定键的位置。

advance (count)：向前移动 count 指定的项数。

这两个方法都会导致游标使用相同的请求，因此相同的 onsuccess 和 onerror 事件处理程序也会得到重用。例如，下面的例子遍历了对象存储空间中的所有项。

request.onsuccess = function (event){var cursor = event.target.result; if (cursor){// 必须要检查 console.log ("Key:" + cursor.key + ", Value:" + JSON.stringify (cursor.value)); cursor.continue (); // 移动到下一项} else {console.log ("Done!"); } };

调用 continue () 会触发另一次请求，进而再次调用 onsuccess 事件处理程序。在没有更多项可以迭代时，将最后一次调用 onsuccess 事件处理程序，此时 event.target.result 的值为 null。

5. 键范围

使用游标总让人觉得不那么理想，因为通过游标查找数据的方式太有限了。键范围（key range）为使用游标增添了一些灵活性。键范围由 IDBKeyRange 的实例表示。支持标准 IDBKeyRange 类型的浏览器有 IE10 + 和 Firefox 4+，Chrome 中的名字叫 webkitIDBKeyRange。与使用 IndexedDB 中的其他类型一样，你最好先声明一个本地的类型，同时要考虑到不同浏览器中的差异。

var IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange;

有四种定义键范围的方式。第一种是使用 only () 方法，传入你想要取得的对象的键。

var onlyRange = IDBKeyRange.only("007");

这个范围可以保证只取得键为 "007" 的对象。使用这个范围创建的游标与直接访问存储空间并调用 get ("007") 差不多。

第二种定义键范围的方式是指定结果集的下界。下界表示游标开始的位置。例如，以下键范围可以保证游标从键为 "007" 的对象开始，然后继续向前移动，直至最后一个对象。

// 从键为 "007" 的对象开始，然后可以移动到最后 var lowerRange = IDBKeyRange.lowerBound ("007");

如果你想忽略键为 "007" 的对象，从它的下一个对象开始，那么可以传入第二个参数 true：

// 从键为 "007" 的对象的下一个对象开始，然后可以移动到最后 var lowerRange = IDBKeyRange.lowerBound ("007", true);

第三种定义键范围的方式是指定结果集的上界，也就是指定游标不能超越哪个键。指定上界使用 upperRange () 方法。下面这个键范围可以保证游标从头开始，到取得键为 "ace" 的对象终止。

// 从头开始，到键为 "ace" 的对象为止 var upperRange = IDBKeyRange.upperBound ("ace");

如果你不想包含键为指定值的对象，同样，传入第二个参数 true：

// 从头开始，到键为 "ace" 的对象的上一个对象为止 var upperRange = IDBKeyRange.upperBound ("ace", true);

第四种定义键范围的方式 —— 没错，就是同时指定上、下界，使用 bound () 方法。这个方法可以接收 4 个参数：表示下界的键、表示上界的键、可选的表示是否跳过下界的布尔值和可选的表示是否跳过上界的布尔值。以下是几个例子。

// 从键为 "007" 的对象开始，到键为 "ace" 的对象为止 var boundRange = IDBKeyRange.bound ("007", "ace"); // 从键为 "007" 的对象的下一个对象开始，到键为 "ace" 的对象为止 var boundRange = IDBKeyRange.bound ("007", "ace", true); // 从键为 "007" 的对象的下一个对象开始，到键为 "ace" 的对象的上一个对象为止 var boundRange = IDBKeyRange.bound ("007", "ace", true, true); // 从键为 "007" 的对象开始，到键为 "ace" 的对象的上一个对象为止 var boundRange = IDBKeyRange.bound ("007", "ace", false, true);

无论如何，在定义键范围之后，把它传给 openCursor () 方法，就能得到一个符合相应约束条件的游标。

var store = db.transaction ("users").objectStore ("users"), range = IDBKeyRange.bound ("007", "ace"); request = store.openCursor (range); request.onsuccess = function (event){var cursor = event.target.result; if (cursor){// 必须要检查 console.log ("Key:" + cursor.key + ", Value:" + JSON.stringify (cursor.value)); cursor.continue (); // 移动到下一项} else {console.log ("Done!"); } };

这个例子输出的对象的键为 "007" 到 "ace"，比上一节最后那个例子输出的值少一些。

6. 设定游标方向

实际上，openCursor () 可以接收两个参数。第一个参数就是刚刚看到的 IDBKeyRange 的实例，第二个是表示方向的数值常量。作为第二个参数的常量是前面讲查询时介绍的 IDBCursor 中的常量。Fire fox4 + 和 Chrome 的实现又有不同，因此第一步还是在本地消除差异：

var IDBCursor = window.IDBCursor || window.webkitIDBCursor;

正常情况下，游标都是从存储空间的第一项开始，调用 continue () 或 advance () 前进到最后一项。游标的默认方向值是 IDBCursor.NEXT。如果对象存储空间中有重复的项，而你想让游标跳过那些重复的项，可以为 openCursor 传入 IDBCursor.NEXT_NO_DUPLICATE 作为第二个参数：

var store = db.transaction("users").objectStore("users"), request = store.openCursor(null, IDBCursor.NEXT_NO_DUPLICATE);

注意，openCursor () 的第一个参数是 null，表示使用默认的键范围，即包含所有对象。这个游标可以从存储空间中的第一个对象开始，逐个迭代到最后一个对象 —— 但会跳过重复的对象。

当然，也可以创建一个游标，让它在对象存储空间中向后移动，即从最后一个对象开始，逐个迭代，直至第一个对象。此时，要传入的常量是 IDBCursor.PREV 和 IDBCursor.PREV_NO_DUPLICATE。例如：

var store = db.transaction("users").objectStore("users"), request = store.openCursor(null, IDBCursor.PREV);

IndexedDBExample05.htm

使用 IDBCursor.PREV 或 IDBCursor.PREV_NO_DUPLICATE 打开游标时，每次调用 continue () 或 advance ()，都会在存储空间中向后而不是向前移动游标。

7. 索引

对于某些数据，可能需要为一个对象存储空间指定多个键。比如，若要通过用户 ID 和用户名两种方式来保存用户资料，就需要通过这两个键来存取记录。为此，可以考虑将用户 ID 作为主键，然后为用户名创建索引。

要创建索引，首先引用对象存储空间，然后调用 createIndex () 方法，如下所示。

var store = db.transaction("users").objectStore("users"), index = store.createIndex("username", "username", { unique: false});

createIndex () 的第一个参数是索引的名字，第二个参数是索引的属性的名字，第三个参数是一个包含 unique 属性的选项（options）对象。这个选项通常都必须指定，因为它表示键在所有记录中是否唯一。因为 username 有可能重复，所以这个索引不是唯一的。

createIndex () 的返回值是 IDBIndex 的实例。在对象存储空间上调用 index () 方法也能返回同一个实例。例如，要使用一个已经存在的名为 "username" 的索引，可以像下面这样取得该索引。

var store = db.transaction("users").objectStore("users"), index = store.index("username");

索引其实与对象存储空间很相似。在索引上调用 openCursor () 方法也可以创建新的游标，除了将来会把索引键而非主键保存在 event.result.key 属性中之外，这个游标与在对象存储空间上调用 openCursor () 返回的游标完全一样。来看下面的例子。

var store = db.transaction ("users").objectStore ("users"), index = store.index ("username"), request = index.openCursor (); request.onsuccess = function (event){// 处理成功};

在索引上也能创建一个特殊的只返回每条记录主键的游标，那就要调用 openKeyCursor () 方法。这个方法接收的参数与 openCursor () 相同。而最大的不同在于，这种情况下 event.result.key 中仍然保存着索引键，而 event.result.value 中保存的则是主键，而不再是整个对象。

var store = db.transaction ("users").objectStore ("users"), index = store.index ("username"), request = index.openKeyCursor (); request.onsuccess = function (event){// 处理成功 //event.result.key 中保存索引键，而 event.result.value 中保存主键};

同样，使用 get () 方法能够从索引中取得一个对象，只要传入相应的索引键即可；当然，这个方法也将返回一个请求。

var store = db.transaction ("users").objectStore ("users"), index = store.index ("username"), request = index.get ("007"); request.onsuccess = function (event){// 处理成功}; request.onerror = function (event){// 处理失败};

要根据给定的索引键取得主键，可以使用 getKey () 方法。这个方法也会创建一个新的请求，但 event.result.value 等于主键的值，而不是包含整个对象。

var store = db.transaction ("users").objectStore ("users"), index = store.index ("username"), request = index.getKey ("007"); request.onsuccess = function (event){// 处理成功 //event.result.key 中保存索引键，而 event.result.value 中保存主键};

在这个例子的 onsuccess 事件处理程序中，event.result.value 中保存的是用户 ID。

任何时候，通过 IDBIndex 对象的下列属性都可以取得有关索引的相关信息。

name：索引的名字。

keyPath：传入 createIndex () 中的属性路径。

objectStore：索引的对象存储空间。

unique：表示索引键是否唯一的布尔值。

另外，通过对象存储对象的 indexName 属性可以访问到为该空间建立的所有索引。通过以下代码就可以知道根据存储的对象建立了哪些索引。

var store = db.transaction("users").objectStore("users"), indexNames = store.indexNames, index, i = 0, len = indexNames.length; while(i < len){ index = store.index(indexNames[i++]); console.log("Index name: " + index.name + ", KeyPath: " + index.keyPath + ", Unique: " + index.unique); }

以上代码遍历了每个索引，在控制台中输出了它们的信息。

在对象存储空间上调用 deleteIndex () 方法并传入索引的名字可以删除索引。

var store = db.transaction("users").objectStore("users"); store.deleteIndex("username");

因为删除索引不会影响对象存储空间中的数据，所以这个操作没有任何回调函数。

8. 并发问题

虽然网页中的 IndexedDB 提供的是异步 API，但仍然存在并发操作的问题。如果浏览器的两个不同的标签页打开了同一个页面，那么一个页面试图更新另一个页面尚未准备就绪的数据库的问题就有可能发生。把数据库设置为新版本有可能导致这个问题。因此，只有当浏览器中仅有一个标签页使用数据库的情况下，调用 setVersion () 才能完成操作。

刚打开数据库时，要记着指定 onversionchange 事件处理程序。当同一个来源的另一个标签页调用 setVersion () 时，就会执行这个回调函数。处理这个事件的最佳方式是立即关闭数据库，从而保证版本更新顺利完成。例如：

var request, database; request = indexedDB.open("admin"); request.onsuccess = function(event){ database = event.target.result; database.onversionchange = function(){ database.close(); }; };

每次成功打开数据库，都应该指定 onversionchange 事件处理程序。

调用 setVersion () 时，指定请求的 onblocked 事件处理程序也很重要。在你想要更新数据库的版本但另一个标签页已经打开数据库的情况下，就会触发这个事件处理程序。此时，最好先通知用户关闭其他标签页，然后再重新调用 setVersion ()。例如：

var request = database.setVersion ("2.0"); request.onblocked = function (){ alert ("Please close all other tabs and try again."); }; request.onsuccess = function (){ // 处理成功，继续};

请记住，其他标签页中的 onversionchange 事件处理程序也会执行。

通过指定这些事件处理程序，就能确保你的 Web 应用妥善地处理好 IndexedDB 的并发问题。

9. 限制

对 IndexedDB 的限制很多都与对 Web Storage 的类似。首先，IndexedDB 数据库只能由同源（相同协议、域名和端口）页面操作，因此不能跨域共享信息。换句话说，www.wrox.com 与 p2p.wrox.com 的数据库是完全独立的。

其次，每个来源的数据库占用的磁盘空间也有限制。Firefox 4 + 目前的上限是每个源 50MB，而 Chrome 的限制是 5MB。移动设备上的 Firefox 最多允许保存 5MB，如果超过了这个配额，将会请求用户的许可。

Firefox 还有另外一个限制，即不允许本地文件访问 IndexedDB。Chrome 没有这个限制。如果你在本地运行本书的示例，请使用 Chrome。

23.4　小结

离线 Web 应用和客户端存储数据的能力对未来的 Web 应用越来越重要。浏览器已经能够检测到用户是否离线，并触发 JavaScript 事件以便应用做出处理。可以指定在应用缓存中保存哪些文件以便离线时使用。对于应用缓存的状态及变化，也有相应的 JavaScript API 可以调用检测。

本书还讨论了客户端存储的以下几方面内容。

以前，这种存储只能使用 cookie 完成，cookie 是一小块可以客户端设置也可以在服务器端设置的信息，每次发起请求时都会传送它。

在 JavaScript 中通过 document.cookie 可以访问 cookie。

cookie 的限制使其可以存储少量数据，然而对于大量数据效率很低。

IE 发明了一种叫做用户数据的行为，可以应用到页面的某个元素上，它有以下特点。

一旦应用后，该元素便可以从一个命名数据空间中载入数据，然后可以通过 getAttribute ()、setAttribute () 和 removeAttribute () 方法访问。

数据必须明确使用 save () 方法保存到命名数据空间中，以便能在会话之间持久化数据。

Web Storage 定义了两种用于存储数据的对象：sessionStorage 和 localStorage。前者严格用于在一个浏览器会话中存储数据，因为数据在浏览器关闭后会立即删除；后者用于跨会话持久化数据并遵循跨域安全策略。

IndexedDB 是一种类似 SQL 数据库的结构化数据存储机制。但它的数据不是保存在表中，而是保存在对象存储空间中。创建对象存储空间时，需要定义一个键，然后就可以添加数据。可以使用游标在对象存储空间中查询特定的对象。而索引则是为了提高查询速度而基于特定的属性创建的。

有了以上这些选择，就可以在客户端机器上使用 JavaScript 存储大量数据了。但你必须小心，不要在客户端存储敏感数据，因为数据缓存不会加密。

第 24 章　最佳实践

本章内容

可维护的代码

保证代码性能

部署代码

自从 2000 以来，Web 开发方面的种种规范、条例正在高速发展。Web 开发过去曾是荒芜地带，里面东西还都凑合，而现在已经演化成了完整的研究规范，并建立了种种最佳实践。随着简单的网站成长为更加复杂的 Web 应用，同时 Web 爱好者成为了有收入的专业人士，Web 开发的世界充满了各种关于最新技术和开发方法的信息。尤其是 JavaScript，它从大量的研究和推断中获益。JavaScript 的最佳实践分成若干类，并在开发过程的不同点上进行处理。

24.1　可维护性

在早期的网站中，JavaScript 主要是用于小特效或者是表单验证。而今天的 Web 应用则会有成千上万行 JavaScript 代码，执行各种复杂的过程。这种演化让开发者必须得考虑到可维护性。除了秉承较传统理念的软件工程师外，还要雇佣 JavaScript 开发人员为公司创造价值，而他们并非仅仅按时交付产品，同时还要开发智力成果在之后不断地增加价值。

编写可维护的代码很重要，因为大部分开发人员都花费大量时间维护他人代码。很难从头开始开发新代码的，很多情况下是以他人的工作成果为基础的。确保自己代码的可维护性，以便其他开发人员在此基础上更好的开展工作。

注意可维护的代码的概念并不是 JavaScript 特有的。这里的很多概念都可以广泛应用于各种编程语言，当然也有某些特定于 JavaScript 的概念。

24.1.1　什么是可维护的代码

可维护的代码有一些特征。一般来说，如果说代码是可维护的，它需要遵循以下特点。

可理解性 —— 其他人可以接手代码并理解它的意图和一般途径，而无需原开发人员的完整解释。

直观性 —— 代码中的东西一看就能明白，不管其操作过程多么复杂。

可适应性 —— 代码以一种数据上的变化不要求完全重写的方法撰写。

可扩展性 —— 在代码架构上已考虑到在未来允许对核心功能进行扩展。

可调试性 —— 当有地方出错时，代码可以给予你足够的信息来尽可能直接地确定问题所在。

对于专业人士而言，能写出可维护的 JavaScript 代码是非常重要的技能。这正是周末改改网站的爱好者和真正理解自己作品的开发人员之间的区别。

24.1.2　代码约定

一种让代码变得可维护的简单途径是形成一套 JavaScript 代码的书写约定。绝大多数语言都开发出了各自的代码约定，只要在网上一搜就能找到大量相关文档。专业的组织为开发人员制定了详尽的代码约定试图让代码对任何人都可维护。杰出的开放源代码项目有着严格的代码约定要求，这让社区中的任何人都可以轻松地理解代码是如何组织的。

由于 JavaScript 的可适应性，代码约定对它也很重要。由于和大多数面向对象语言不同，JavaScript 并不强制开发人员将所有东西都定义为对象。语言可以支持各种编程风格，从传统面向对象式到声明式到函数式。只要快速浏览一下一些开源 JavaScript 库，就能发现好几种创建对象、定义方法和管理环境的途径。

以下小节将讨论代码约定的概论。对这些主题的解说非常重要，虽然可能的解说方式会有区别，这取决于个人需求。

1. 可读性

要让代码可维护，首先它必须可读。可读性与代码作为文本文件的格式化方式有关。可读性的大部分内容都是和代码的缩进相关的。当所有人都使用一样的缩进方式时，整个项目中的代码都会更加易于阅读。通常会使用若干空格而非制表符来进行缩进，这是因为制表符在不同的文本编辑器中显示效果不同。一种不错的、很常见的缩进大小为 4 个空格，当然你也可以使用其他数量。

可读性的另一方面是注释。在大多数编程语言中，对每个方法的注释都视为一个可行的实践。因为 JavaScript 可以在代码的任何地方创建函数，所以这点常常被忽略了。然而正因如此，在 JavaScript 中为每个函数编写文档就更加重要了。一般而言，有如下一些地方需要进行注释。

函数和方法 —— 每个函数或方法都应该包含一个注释，描述其目的和用于完成任务所可能使用的算法。陈述事先的假设也非常重要，如参数代表什么，函数是否有返回值（因为这不能从函数定义中推断出来）。

大段代码 —— 用于完成单个任务的多行代码应该在前面放一个描述任务的注释。

复杂的算法 —— 如果使用了一种独特的方式解决某个问题，则要在注释中解释你是如何做的。这不仅仅可以帮助其他浏览你代码的人，也能在下次你自己查阅代码的时候帮助理解。

Hack—— 因为存在浏览器差异，JavaScript 代码一般会包含一些 hack。不要假设其他人在看代码的时候能够理解 hack 所要应付的浏览器问题。如果因为某种浏览器无法使用普通的方法，所以你需要用一些不同的方法，那么请将这些信息放在注释中。这样可以减少出现这种情况的可能性：有人偶然看到你的 hack，然后「修正」了它，最后重新引入了你本来修正了的错误。

缩进和注释可以带来更可读的代码，在未来则更容易维护。

2. 变量和函数命名

适当给变量和函数起名字对于增加代码可理解性和可维护性是非常重要的。由于很多 JavaScript 开发人员最初都只是业余爱好者，所以有一种使用无意义名字的倾向，诸如给变量起 "foo"、"bar" 等名字，给函数起 "doSomething" 这样的名字。专业 JavaScript 开发人员必须克服这些恶习以创建可维护的代码。命名的一般规则如下所示。

变量名应为名词如 car 或 person。

函数名应该以动词开始，如 getName ()。返回布尔类型值的函数一般以 is 开头，如 isEnable ()。

变量和函数都应使用合乎逻辑的名字，不要担心长度。长度问题可以通过后处理和压缩（本章后面会讲到）来缓解。

必须避免出现无法表示所包含的数据类型的无用变量名。有了合适的命名，代码阅读起来就像讲述故事一样，更容易理解。

3. 变量类型透明

由于在 JavaScript 中变量是松散类型的，很容易就忘记变量所应包含的数据类型。合适的命名方式可以一定程度上缓解这个问题，但放到所有的情况下看，还不够。有三种表示变量数据类型的方式。

第一种方式是初始化。当定义了一个变量后，它应该被初始化为一个值，来暗示它将来应该如何应用。例如，将来保存布尔类型值的变量应该初始化为 true 或者 false，将来保存数字的变量就应该初始化为一个数字，如以下例子所示：

// 通过初始化指定变量类型 var found = false; // 布尔型 var count = -1; // 数字 var name = ""; // 字符串 var person = null; // 对象

初始化为一个特定的数据类型可以很好的指明变量的类型。但缺点是它无法用于函数声明中的函数参数。

第二种方法是使用匈牙利标记法来指定变量类型。匈牙利标记法在变量名之前加上一个或多个字符来表示数据类型。这个标记法在脚本语言中很流行，曾经很长时间也是 JavaScript 所推崇的方式。JavaScript 中最传统的匈牙利标记法是用单个字符表示基本类型："o" 代表对象，"s" 代表字符串，"i" 代表整数，"f" 代表浮点数，"b" 代表布尔型。如下所示：

// 用于指定数据类型的匈牙利标记法 var bFound; // 布尔型 var iCount; // 整数 var sName; // 字符串 var oPerson; // 对象

JavaScript 中用匈牙利标记法的好处是函数参数一样可以使用。但它的缺点是让代码某种程度上难以阅读，阻碍了没有用它时代码的直观性和句子式的特质。因此，匈牙利标记法失去了一些开发者的宠爱。

最后一种指定变量类型的方式是使用类型注释。类型注释放在变量名右边，但是在初始化前面。这种方式是在变量旁边放一段指定类型的注释，如下所示：

// 用于指定类型的类型注释 var found /*:Boolean*/ = false; var count /*:int*/ = 10; var name /*:String*/ = "Nicholas"; var person /*:Object*/ = null;

类型注释维持了代码的整体可读性，同时注入了类型信息。类型注释的缺点是你不能用多行注释一次注释大块的代码，因为类型注释也是多行注释，两者会冲突，如下例所示所示：

// 以下代码不能正确运行 /* var found /*:Boolean*/ = false; var count /*:int*/ = 10; var name /*:String*/ = "Nicholas"; var person /*:Object*/ = null; */

这里，试图通过多行注释注释所有变量。类型注释与其相冲突，因为第一次出现的 /*（第二行）匹配了第一次出现的 */（第 3 行），这会造成一个语法错误。如果你想注释掉这些使用类型注释的代码行，最好在每一行上使用单行注释（很多编辑器可以帮你完成）。

这就是最常见的三种指定变量数据类型的方法。每种都有各自的优势和劣势，要自己在使用之前进行评估。最重要的是要确定哪种最适合你的项目并一致使用。

24.1.3　松散耦合

只要应用的某个部分过分依赖于另一部分，代码就是耦合过紧，难于维护。典型的问题如：对象直接引用另一个对象，并且当修改其中一个的同时需要修改另外一个。紧密耦合的软件难于维护并且需要经常重写。

因为 Web 应用所涉及的技术，有多种情况会使它变得耦合过紧。必须小心这些情况，并尽可能维护弱耦合的代码。

1. 解耦 HTML/JavaScript

一种最常见的耦合类型是 HTML/JavaScript 耦合。在 Web 上，HTML 和 JavaScript 各自代表了解决方案中的不同层次：HTML 是数据，JavaScript 是行为。因为它们天生就需要交互，所以有多种不同的方法将这两个技术关联起来。但是，有一些方法会将 HTML 和 JavaScript 过于紧密地耦合在一起。

直接写在 HTML 中的 JavaScript，使用包含内联代码的 <script> 元素或者是使用 HTML 属性来分配事件处理程序，都是过于紧密的耦合。请看以下代码。

<!-- 使用了 <script> 的紧密耦合的 HTML/JavaScript --> <script type="text/javascript"> document.write ("Hello world!"); </script> <!-- 使用事件处理程序属性值的紧密耦合的 HTML/JavaScript --> <input type="button" value="Click Me" onclick="doSomething ()" />

虽然这些从技术上来说都是正确的，但是实践中，它们将表示数据的 HTML 和定义行为的 JavaScript 紧密耦合在了一起。理想情况是，HTML 和 JavaScript 应该完全分离，并通过外部文件和使用 DOM 附加行为来包含 JavaScript。

当 HTML 和 JavaScript 过于紧密的耦合在一起时，出现 JavaScript 错误时就要先判断错误是出现在 HTML 部分还是在 JavaScript 文件中。它还会引入和代码是否可用的相关新问题。在这个例子中，可能在 doSomething () 函数可用之前，就已经按下了按钮，引发了一个 JavaScript 错误。因为任何对按钮行为的更改要同时触及 HTML 和 JavaScript，因此影响了可维护性。而这些更改本该只在 JavaScript 中进行。

HTML 和 JavaScript 的紧密耦合也可以在相反的关系上成立：JavaScript 包含了 HTML。这通常会出现在使用 innerHTML 来插入一段 HTML 文本到页面上这种情况中，如下面的例子所示：

// 将 HTML 紧密耦合到 JavaScript function insertMessage (msg){var container = document.getElementById ("container"); container.innerHTML = "<div class=\"msg\"><p class=\"post\">" + msg + "</p>" + "<p><em>Latest message above.</em></p></div>"; }

一般来说，你应该避免在 JavaScript 中创建大量 HTML。再一次重申要保持层次的分离，这样可以很容易的确定错误来源。当使用上面这个例子的时候，有一个页面布局的问题，可能和动态创建的 HTML 没有被正确格式化有关。不过，要定位这个错误可能非常困难，因为你可能一般先看页面的源代码来查找那段烦人的 HTML，但是却没能找到，因为它是动态生成的。对数据或者布局的更改也会要求更改 JavaScript，这也表明了这两个层次过于紧密地耦合了。

HTML 呈现应该尽可能与 JavaScript 保持分离。当 JavaScript 用于插入数据时，尽量不要直接插入标记。一般可以在页面中直接包含并隐藏标记，然后等到整个页面渲染好之后，就可以用 JavaScript 显示该标记，而非生成它。另一种方法是进行 Ajax 请求并获取更多要显示的 HTML，这个方法可以让同样的渲染层（PHP、JSP、Ruby 等等）来输出标记，而不是直接嵌在 JavaScript 中。

将 HTML 和 JavaScript 解耦可以在调试过程中节省时间，更加容易确定错误的来源，也减轻维护的难度：更改行为只需要在 JavaScript 文件中进行，而更改标记则只要在渲染文件中。

2. 解耦 CSS/JavaScript

另一个 Web 层则是 CSS，它主要负责页面的显示。JavaScript 和 CSS 也是非常紧密相关的：他们都是 HTML 之上的层次，因此常常一起使用。但是，和 HTML 与 JavaScript 的情况一样，CSS 和 JavaScript 也可能会过于紧密地耦合在一起。最常见的紧密耦合的例子是使用 JavaScript 来更改某些样式，如下所示：

//CSS 对 JavaScript 的紧密耦合 element.style.color = "red"; element.style.backgroundColor = "blue";

由于 CSS 负责页面的显示，当显示出现任何问题时都应该只是查看 CSS 文件来解决。然而，当使用了 JavaScript 来更改某些样式的时候，比如颜色，就出现了第二个可能已更改和必须检查的地方。结果是 JavaScript 也在某种程度上负责了页面的显示，并与 CSS 紧密耦合了。如果未来需要更改样式表，CSS 和 JavaScript 文件可能都需要修改。这就给开发人员造成了维护上的噩梦。所以在这两个层次之间必须有清晰的划分。

现代 Web 应用常常要使用 JavaScript 来更改样式，所以虽然不可能完全将 CSS 和 JavaScript 解耦，但是还是能让耦合更松散的。这是通过动态更改样式类而非特定样式来实现的，如下例所示：

//CSS 对 JavaScript 的松散耦合 element.className = "edit";

通过只修改某个元素的 CSS 类，就可以让大部分样式信息严格保留在 CSS 中。JavaScript 可以更改样式类，但并不会直接影响到元素的样式。只要应用了正确的类，那么任何显示问题都可以直接追溯到 CSS 而非 JavaScript。

第二类紧密耦合仅会在 IE 中出现（但运行于标准模式下的 IE8 不会出现），它可以在 CSS 中通过表达式嵌入 JavaScript，如下例所示：

/* JavaScript 对 CSS 的紧密耦合 */div {width: expression (document.body.offsetWidth - 10 + "px"); }

通常要避免使用表达式，因为它们不能跨浏览器兼容，还因为它们所引入的 JavaScript 和 CSS 之间的紧密耦合。如果使用了表达式，那么可能会在 CSS 中出现 JavaScript 错误。由于 CSS 表达式而追踪过 JavaScript 错误的开发人员，会告诉你在他们决定看一下 CSS 之前花了多长时间来查找错误。

再次提醒，好的层次划分是非常重要的。显示问题的唯一来源应该是 CSS，行为问题的唯一来源应该是 JavaScript。在这些层次之间保持松散耦合可以让你的整个应用更加易于维护。

3. 解耦应用逻辑／事件处理程序

每个 Web 应用一般都有相当多的事件处理程序，监听着无数不同的事件。然而，很少有能仔细得将应用逻辑从事件处理程序中分离的。请看以下例子：

function handleKeyPress(event){ event = EventUtil.getEvent(event); if (event.keyCode == 13){ var target = EventUtil.getTarget(event); var value = 5 * parseInt(target.value); if (value > 10){ document.getElementById("error-msg").style.display = "block"; } } }

这个事件处理程序除了包含了应用逻辑，还进行了事件的处理。这种方式的问题有其双重性。首先，除了通过事件之外就再没有方法执行应用逻辑，这让调试变得困难。如果没有发生预想的结果怎么办？是不是表示事件处理程序没有被调用还是指应用逻辑失败？其次，如果一个后续的事件引发同样的应用逻辑，那就必须复制功能代码或者将代码抽取到一个单独的函数中。无论何种方式，都要作比实际所需更多的改动。

较好的方法是将应用逻辑和事件处理程序相分离，这样两者分别处理各自的东西。一个事件处理程序应该从事件对象中提取相关信息，并将这些信息传送到处理应用逻辑的某个方法中。例如，前面的代码可以被重写为：

function validateValue(value){ value = 5 * parseInt(value); if (value > 10){ document.getElementById("error-msg").style.display = "block"; } } function handleKeyPress(event){ event = EventUtil.getEvent(event); if (event.keyCode == 13){ var target = EventUtil.getTarget(event); validateValue(target.value); } }

改动过的代码合理将应用逻辑从事件处理程序中分离了出来。handleKeyPress () 函数确认是按下了 Enter 键（event.keyCode 为 13），取得了事件的目标并将 value 属性传递给 validateValue () 函数，这个函数包含了应用逻辑。注意 validateValue () 中没有任何东西会依赖于任何事件处理程序逻辑，它只是接收一个值，并根据该值进行其他处理。

从事件处理程序中分离应用逻辑有几个好处。首先，可以让你更容易更改触发特定过程的事件。如果最开始由鼠标点击事件触发过程，但现在按键也要进行同样处理，这种更改就很容易。其次，可以在不附加到事件的情况下测试代码，使其更易创建单元测试或者是自动化应用流程。

以下是要牢记的应用和业务逻辑之间松散耦合的几条原则：

勿将 event 对象传给其他方法；只传来自 event 对象中所需的数据；

任何可以在应用层面的动作都应该可以在不执行任何事件处理程序的情况下进行；

任何事件处理程序都应该处理事件，然后将处理转交给应用逻辑。

牢记这几条可以在任何代码中都获得极大的可维护性的改进，并且为进一步的测试和开发制造了很多可能。

24.1.4　编程实践

书写可维护的 JavaScript 并不仅仅是关于如何格式化代码；它还关系到代码做什么的问题。在企业环境中创建的 Web 应用往往同时由大量人员一同创作。这种情况下的目标是确保每个人所使用的浏览器环境都有一致和不变的规则。因此，最好坚持以下一些编程实践。

1. 尊重对象所有权

JavaScript 的动态性质使得几乎任何东西在任何时间都可以修改。有人说在 JavaScript 没有什么神圣的东西，因为无法将某些东西标记为最终或恒定状态。这种状况在 ECMAScript 5 中通过引入防篡改对象（第 22 章讨论过）得以改变；不过，默认情况下所有对象都是可以修改的。在其他语言中，当没有实际的源代码的时候，对象和类是不可变的。JavaScript 可以在任何时候修改任意对象，这样就可以以不可预计的方式覆写默认的行为。因为这门语言没有强行的限制，所以对于开发者来说，这是很重要的，也是必要的。

也许在企业环境中最重要的编程实践就是尊重对象所有权，它的意思是你不能修改不属于你的对象。简单地说，如果你不负责创建或维护某个对象、它的对象或者它的方法，那么你就不能对它们进行修改。更具体地说：

不要为实例或原型添加属性；

不要为实例或原型添加方法；

不要重定义已存在的方法。

问题在于开发人员会假设浏览器环境按照某个特定方式运行，而对于多个人都用到的对象进行改动就会产生错误。如果某人期望叫做 stopEvent () 的函数能取消某个事件的默认行为，但是你对其进行了更改，然后它完成了本来的任务，后来还追加了另外的事件处理程序，那肯定会出现问题了。其他开发人员会认为函数还是按照原来的方式执行，所以他们的用法会出错并有可能造成危害，因为他们并不知道有副作用。

这些规则不仅仅适用于自定义类型和对象，对于诸如 Object、String、document、window 等原生类型和对象也适用。此处潜在的问题可能更加危险，因为浏览器提供者可能会在不做宣布或者是不可预期的情况下更改这些对象。

著名的 Prototype JavaScript 库就出现过这种例子：它为 document 对象实现了 getElementsByClassName () 方法，返回一个 Array 的实例并增加了一个 each () 方法。John Resig 在他的博客上叙述了产生这个问题的一系列事件。他在帖子（http://ejohn.org/blog/getelementsbyclassname-pre-prototype-16/）中说，他发现当浏览器开始内部实现 getElementsByClassName () 的时候就出现问题了，这个方法并不返回一个 Array 而是返回一个并不包含 each () 方法的 NodeList。使用 Prototype 库的开发人员习惯于写这样的代码：

document.getElementsByClassName("selected").each(Element.hide);

虽然在没有原生实现 getElementsByClassName () 的浏览器中可以正常运行，但对于支持的了浏览器就会产生错误，因为返回的值不同。你不能预测浏览器提供者在未来会怎样更改原生对象，所以不管用任何方式修改他们，都可能会导致将来你的实现和他们的实现之间的冲突。

所以，最佳的方法便是永远不修改不是由你所有的对象。所谓拥有对象，就是说这个对象是你创建的，比如你自己创建的自定义类型或对象字面量。而 Array、document 这些显然不是你的，它们在你的代码执行前就存在了。你依然可以通过以下方式为对象创建新的功能：

创建包含所需功能的新对象，并用它与相关对象进行交互；

创建自定义类型，继承需要进行修改的类型。然后可以为自定义类型添加额外功能。

现在很多 JavaScript 库都赞同并遵守这条开发原理，这样即使浏览器频繁更改，库本身也能继续成长和适应。

2. 避免全局量

与尊重对象所有权密切相关的是尽可能避免全局变量和函数。这也关系到创建一个脚本执行的一致的和可维护的环境。最多创建一个全局变量，让其他对象和函数存在其中。请看以下例子：

// 两个全局量 —— 避免！！ var name = "Nicholas"; function sayName (){ alert (name); }

这段代码包含了两个全局量：变量 name 和函数 sayName ()。其实可以创建一个包含两者的对象，如下例所示：

// 一个全局量 —— 推荐 var MyApplication = {name: "Nicholas", sayName: function (){alert (this.name); } };

这段重写的代码引入了一个单一的全局对象 MyApplication，name 和 sayName () 都附加到其上。这样做消除了一些存在于前一段代码中的一些问题。首先，变量 name 覆盖了 window.name 属性，可能会与其他功能产生冲突；其次，它有助消除功能作用域之间的混淆。调用 MyApplication.sayName () 在逻辑上暗示了代码的任何问题都可以通过检查定义 MyApplication 的代码来确定。

单一的全局量的延伸便是命名空间的概念，由 YUI（Yahoo! User Interface）库普及。命名空间包括创建一个用于放置功能的对象。在 YUI 的 2.x 版本中，有若干用于追加功能的命名空间。比如：

YAHOO.util.Dom—— 处理 DOM 的方法；

YAHOO.util.Event—— 与事件交互的方法；

YAHOO.lang—— 用于底层语言特性的方法。

对于 YUI，单一的全局对象 YAHOO 作为一个容器，其中定义了其他对象。用这种方式将功能组合在一起的对象，叫做命名空间。整个 YUI 库便是构建在这个概念上的，让它能够在同一个页面上与其他的 JavaScript 库共存。

命名空间很重要的一部分是确定每个人都同意使用的全局对象的名字，并且尽可能唯一，让其他人不太可能也使用这个名字。在大多数情况下，可以是开发代码的公司的名字，例如 YAHOO 或者 Wrox。你可以如下例所示开始创建命名空间来组合功能。

// 创建全局对象 var Wrox = {}; // 为 Professional JavaScript 创建命名空间 Wrox.ProJS = {}; // 将书中用到的对象附加上去 Wrox.ProJS.EventUtil = {...}; Wrox.ProJS.CookieUtil = {...};

在这个例子中，Wrox 是全局量，其他命名空间在此之上创建。如果本书所有代码都放在 Wrox.ProJS 命名空间，那么其他作者也应把自己的代码添加到 Wrox 对象中。只要所有人都遵循这个规则，那么就不用担心其他人也创建叫做 EventUtil 或者 CookieUtil 的对象，因为它会存在于不同的命名空间中。请看以下例子：

// 为 Professional Ajax 创建命名空间 Wrox.ProAjax = {}; // 附加该书中所使用的其他对象 Wrox.ProAjax.EventUtil = { ...}; Wrox.ProAjax.CookieUtil = {...}; //ProJS 还可以继续分别访问 Wrox.ProJS.EventUtil.addHandler (...); // 以及 ProAjax Wrox.ProAjax.EventUtil.addHandler (...);

虽然命名空间会需要多写一些代码，但是对于可维护的目的而言是值得的。命名空间有助于确保代码可以在同一个页面上与其他代码以无害的方式一起工作。

3. 避免与 null 进行比较

由于 JavaScript 不做任何自动的类型检查，所有它就成了开发人员的责任。因此，在 JavaScript 代码中其实很少进行类型检测。最常见的类型检测就是查看某个值是否为 null。但是，直接将值与 null 比较是使用过度的，并且常常由于不充分的类型检查导致错误。看以下例子：

function sortArray (values){if (values != null){// 避免！ values.sort (comparator); } }

该函数的目的是根据给定的比较子对一个数组进行排序。为了函数能正确执行，values 参数必需是数组，但这里的 if 语句仅仅检查该 values 是否为 null。还有其他的值可以通过 if 语句，包括字符串、数字，它们会导致函数抛出错误。

现实中，与 null 比较很少适合情况而被使用。必须按照所期望的对值进行检查，而非按照不被期望的那些。例如，在前面的范例中，values 参数应该是一个数组，那么就要检查它是不是一个数组，而不是检查它是否非 null。函数按照下面的方式修改会更加合适：

function sortArray (values){if (values instanceof Array){// 推荐 values.sort (comparator); } }

该函数的这个版本可以阻止所有非法值，而且完全用不着 null。

这种验证数组的技术在多框架的网页中不一定正确工作，因为每个框架都有其自己的全局对象，因此，也有自己的 Array 构造函数。如果你是从一个框架将数组传送到另一个框架，那么就要另外检查是否存在 sort () 方法。

如果看到了与 null 比较的代码，尝试使用以下技术替换：

如果值应为一个引用类型，使用 instanceof 操作符检查其构造函数；

如果值应为一个基本类型，使用 typeof 检查其类型；

如果是希望对象包含某个特定的方法名，则使用 typeof 操作符确保指定名字的方法存在于对象上。

代码中的 null 比较越少，就越容易确定代码的目的，并消除不必要的错误。

4. 使用常量

尽管 JavaScript 没有常量的正式概念，但它还是很有用的。这种将数据从应用逻辑分离出来的思想，可以在不冒引入错误的风险的同时，就改变数据。请看以下例子：

function validate(value){ if (!value){ alert("Invalid value!"); location.href = "/errors/invalid.php"; } }

在这个函数中有两段数据：要显示给用户的信息以及 URL。显示在用户界面上的字符串应该以允许进行语言国际化的方式抽取出来。URL 也应被抽取出来，因为它们有随着应用成长而改变的倾向。基本上，有着可能由于这样那样原因会变化的这些数据，那么都会需要找到函数并在其中修改代码 。而每次修改应用逻辑的代码，都可能会引入错误。可以通过将数据抽取出来变成单独定义的常量的方式，将应用逻辑与数据修改隔离开来。请看以下例子：

var Constants = { INVALID_VALUE_MSG: "Invalid value!", INVALID_VALUE_URL: "/errors/invalid.php" }; function validate(value){ if (!value){ alert(Constants.INVALID_VALUE_MSG); location.href = Constants.INVALID_VALUE_URL; } }

在这段重写过的代码中，消息和 URL 都被定义于 Constants 对象中，然后函数引用这些值。这些设置允许数据在无须接触使用它的函数的情况下进行变更。Constants 对象甚至可以完全在单独的文件中进行定义，同时该文件可以由包含正确值的其他过程根据国际化设置来生成。

关键在于将数据和使用它的逻辑进行分离。要注意的值的类型如下所示。

重复值 —— 任何在多处用到的值都应抽取为一个常量。这就限制了当一个值变了而另一个没变的时候会造成的错误。这也包含了 CSS 类名。

用户界面字符串 —— 任何用于显示给用户的字符串，都应被抽取出来以方便国际化。

URLs—— 在 Web 应用中，资源位置很容易变更，所以推荐用一个公共地方存放所有的 URL。

任意可能会更改的值 —— 每当你在用到字面量值的时候，你都要问一下自己这个值在未来是不是会变化。如果答案是「是」，那么这个值就应该被提取出来作为一个常量。

对于企业级的 JavaScript 开发而言，使用常量是非常重要的技巧，因为它能让代码更容易维护，并且在数据更改的同时保护代码。

24.2　性能

自从 JavaScript 诞生以来，用这门语言编写网页的开发人员有了极大的增长。与此同时，JavaScript 代码的执行效率也越来越受到关注。因为 JavaScript 最初是一个解释型语言，执行速度要比编译型语言慢得多。Chrome 是第一款内置优化引擎，将 JavaScript 编译成本地代码的浏览器。此后，主流浏览器纷纷效仿，陆续实现了 JavaScript 的编译执行。

即使到了编译执行 JavaScript 的新阶段，仍然会存在低效率的代码。不过，还是有一些方式可以改进代码的整体性能的。

24.2.1　注意作用域

第 4 章讨论了 JavaScript 中「作用域」的概念以及作用域链是如何运作的。随着作用域链中的作用域数量的增加，访问当前作用域以外的变量的时间也在增加。访问全局变量总是要比访问局部变量慢，因为需要遍历作用域链。只要能减少花费在作用域链上的时间，就能增加脚本的整体性能。

1. 避免全局查找

可能优化脚本性能最重要的就是注意全局查找。使用全局变量和函数肯定要比局部的开销更大，因为要涉及作用域链上的查找。请看以下函数：

function updateUI(){ var imgs = document.getElementsByTagName("img"); for (var i=0, len=imgs.length; i < len; i++){ imgs[i].title = document.title + " image " + i; } var msg = document.getElementById("msg"); msg.innerHTML = "Update complete."; }

该函数可能看上去完全正常，但是它包含了三个对于全局 document 对象的引用。如果在页面上有多个图片，那么 for 循环中的 document 引用就会被执行多次甚至上百次，每次都会要进行作用域链查找。通过创建一个指向 document 对象的局部变量，就可以通过限制一次全局查找来改进这个函数的性能：

function updateUI(){ var doc = document; var imgs = doc.getElementsByTagName("img"); for (var i=0, len=imgs.length; i < len; i++){ imgs[i].title = doc.title + " image " + i; } var msg = doc.getElementById("msg"); msg.innerHTML = "Update complete."; }

这里，首先将 document 对象存在本地的 doc 变量中；然后在余下的代码中替换原来的 document。与原来的的版本相比，现在的函数只有一次全局查找，肯定更快。

将在一个函数中会用到多次的全局对象存储为局部变量总是没错的。

2. 避免 with 语句

在性能非常重要的地方必须避免使用 with 语句。和函数类似，with 语句会创建自己的作用域，因此会增加其中执行的代码的作用域链的长度。由于额外的作用域链查找，在 with 语句中执行的代码肯定会比外面执行的代码要慢。

必须使用 with 语句的情况很少，因为它主要用于消除额外的字符。在大多数情况下，可以用局部变量完成相同的事情而不引入新的作用域。下面是一个例子：

function updateBody(){ with(document.body){ alert(tagName); innerHTML = "Hello world!"; } }

这段代码中的 with 语句让 document.body 变得更容易使用。其实可以使用局部变量达到相同的效果，如下所示：

function updateBody(){ var body = document.body alert(body.tagName); body.innerHTML = "Hello world!"; }

虽然代码稍微长了点，但是阅读起来比 with 语句版本更好，它确保让你知道 tagName 和 innerHTML 是属于哪个对象的。同时，这段代码通过将 document.body 存储在局部变量中省去了额外的全局查找。

24.2.2　选择正确方法

和其他语言一样，性能问题的一部分是和用于解决问题的算法或者方法有关的。老练的开发人员根据经验可以得知哪种方法可能获得更好的性能。很多应用在其他编程语言中的技术和方法也可以在 JavaScript 中使用。

1. 避免不必要的属性查找

在计算机科学中，算法的复杂度是使用 O 符号来表示的。最简单、最快捷的算法是常数值即 O (1)。之后，算法变得越来越复杂并花更长时间执行。下面的表格列出了 JavaScript 中常见的算法类型。

标　　记 名　　称 描　　述

O (1) 常数 不管有多少值，执行的时间都是恒定的。一般表示简单值和存储在变量中的值

O (log n) 对数 总的执行时间和值的数量相关，但是要完成算法并不一定要获取每个值。例如：二分查找

O (n) 线性 总执行时间和值的数量直接相关。例如：遍历某个数组中的所有元素

O (n2) 平方 总执行时间和值的数量有关，每个值至少要获取 n 次。例如：插入排序

常数值，即 O (1)，指代字面值和存储在变量中的值。符号 O (1) 表示无论有多少个值，需要获取常量值的时间都一样。获取常量值是非常高效的过程。请看下面代码：

var value = 5; var sum = 10 + value; alert(sum);

该代码进行了四次常量值查找：数字 5，变量 value，数字 10 和变量 sum。这段代码的整体复杂度被认为是 O (1)。

在 JavaScript 中访问数组元素也是一个 O (1) 操作，和简单的变量查找效率一样。所以以下代码和前面的例子效率一样：

var values = [5, 10]; var sum = values[0] + values[1]; alert(sum);

使用变量和数组要比访问对象上的属性更有效率，后者是一个 O (n) 操作。对象上的任何属性查找都要比访问变量或者数组花费更长时间，因为必须在原型链中对拥有该名称的属性进行一次搜索。简而言之，属性查找越多，执行时间就越长。请看以下内容：

var values = { first: 5, second: 10}; var sum = values.first + values.second; alert(sum);

这段代码使用两次属性查找来计算 sum 的值。进行一两次属性查找并不会导致显著的性能问题，但是进行成百上千次则肯定会减慢执行速度。

注意获取单个值的多重属性查找。例如，请看以下代码：

var query = window.location.href.substring(window.location.href.indexOf("?"));

在这段代码中，有 6 次属性查找：window.location.href.substring () 有 3 次，window.location.href.indexOf () 又有 3 次。只要数一数代码中的点的数量，就可以确定属性查找的次数了。这段代码由于两次用到了 window.location.href，同样的查找进行了两次，因此效率特别不好。

一旦多次用到对象属性，应该将其存储在局部变量中。第一次访问该值会是 O (n)，然而后续的访问都会是 O (1)，就会节省很多。例如，之前的代码可以如下重写：

var url = window.location.href; var query = url.substring(url.indexOf("?"));

这个版本的代码只有 4 次属性查找，相对于原始版本节省了 33%。在更大的脚本中进行这种优化，倾向于获得更多改进。

一般来讲，只要能减少算法的复杂度，就要尽可能减少。尽可能多地使用局部变量将属性查找替换为值查找。进一步讲，如果即可以用数字化的数组位置进行访问，也可以使用命名属性（诸如 NodeList 对象），那么使用数字位置。

2. 优化循环

循环是编程中最常见的结构，在 JavaScript 程序中同样随处可见。优化循环是性能优化过程中很重要的一个部分，由于它们会反复运行同一段代码，从而自动地增加执行时间。在其他语言中对于循环优化有大量研究，这些技术也可以应用于 JavaScript。一个循环的基本优化步骤如下所示。

减值迭代 —— 大多数循环使用一个从 0 开始、增加到某个特定值的迭代器。在很多情况下，从最大值开始，在循环中不断减值的迭代器更加高效。

简化终止条件 —— 由于每次循环过程都会计算终止条件，所以必须保证它尽可能快。也就是说避免属性查找或其他 O (n) 的操作。

简化循环体 —— 循环体是执行最多的，所以要确保其被最大限度地优化。确保没有某些可以被很容易移出循环的密集计算。

使用后测试循环 —— 最常用 for 循环和 while 循环都是前测试循环。而如 do-while 这种后测试循环，可以避免最初终止条件的计算，因此运行更快。

用一个例子来描述这种改动。以下是一个基本的 for 循环：

for (var i=0; i < values.length; i++){ process(values[i]); }

这段代码中变量 i 从 0 递增到 values 数组中的元素总数。假设值的处理顺序无关紧要，那么循环可以改为 i 减值，如下所示：

for (var i=values.length -1; i >= 0; i--){ process(values[i]); }

这里，变量 i 每次循环之后都会减 1。在这个过程中，将终止条件从 value.length 的 O (n) 调用简化成了 0 的 O (1) 调用。由于循环体只有一个语句，无法进一步优化。不过循环还能改成后测试循环，如下：

var i=values.length -1; if (i > -1){ do { process(values[i]); }while(--i >= 0); }

此处主要的优化是将终止条件和自减操作符组合成了单个语句。这时，任何进一步的优化只能在 process () 函数中进行了，因为循环部分已经优化完全了。

记住使用「后测试」循环时必须确保要处理的值至少有一个。空数组会导致多余的一次循环而「前测试」循环则可以避免。

3. 展开循环

当循环的次数是确定的，消除循环并使用多次函数调用往往更快 。请看一下前面的例子。如果数组的长度总是一样的，对每个元素都调用 process () 可能更优，如以下代码所示：

// 消除循环 process (values [0]); process (values [1]); process (values [2]);

这个例子假设 values 数组里面只有 3 个元素，直接对每个元素调用 process ()。这样展开循环可以消除建立循环和处理终止条件的额外开销，使代码运行得更快。

如果循环中的迭代次数不能事先确定，那可以考虑使用一种叫做 Duff 装置的技术。这个技术是以其创建者 Tom Duff 命名的，他最早在 C 语言中使用这项技术。正是 Jeff Greenberg 用 JavaScript 实现了 Duff 装置。Duff 装置的基本概念是通过计算迭代的次数是否为 8 的倍数将一个循环展开为一系列语句。请看以下代码：

//credit: Jeff Greenberg for JS implementation of Duff’s Device // 假设 values.length > 0 var iterations = Math.ceil (values.length/ 8); var startAt = values.length % 8; var i = 0; do {switch (startAt){case 0: process (values [i++]); case 7: process (values [i++]); case 6: process (values [i++]); case 5: process (values [i++]); case 4: process (values [i++]); case 3: process (values [i++]); case 2: process (values [i++]); case 1: process (values [i++]); } startAt = 0; } while (--iterations> 0);

Duff 装置的实现是通过将 values 数组中元素个数除以 8 来计算出循环需要进行多少次迭代的。然后使用取整的上限函数确保结果是整数。如果完全根据除 8 来进行迭代，可能会有一些不能被处理到的元素，这个数量保存在 startAt 变量中。首次执行该循环时，会检查 StartAt 变量看有需要多少额外调用。例如，如果数组中有 10 个值，startAt 则等于 2，那么最开始的时候 process () 则只会被调用 2 次。在接下来的循环中，startAt 被重置为 0，这样之后的每次循环都会调用 8 次 process ()。展开循环可以提升大数据集的处理速度。

由 Andrew B. King 所著的 Speed Up Your Site（New Riders，2003）提出了一个更快的 Duff 装置技术，将 do-while 循环分成 2 个单独的循环。以下是例子：

//credit: Speed Up Your Site (New Riders, 2003) var iterations = Math.floor(values.length / 8); var leftover = values.length % 8; var i = 0; if (leftover > 0){ do { process(values[i++]); } while (--leftover > 0); } do { process(values[i++]); process(values[i++]); process(values[i++]); process(values[i++]); process(values[i++]); process(values[i++]); process(values[i++]); process(values[i++]); } while (--iterations > 0);

在这个实现中，剩余的计算部分不会在实际循环中处理，而是在一个初始化循环中进行除以 8 的操作。当处理掉了额外的元素，继续执行每次调用 8 次 process () 的主循环。这个方法几乎比原始的 Duff 装置实现快上 40%。

针对大数据集使用展开循环可以节省很多时间，但对于小数据集，额外的开销则可能得不偿失。它是要花更多的代码来完成同样的任务，如果处理的不是大数据集，一般来说并不值得。

4. 避免双重解释

当 JavaScript 代码想解析 JavaScript 的时候就会存在双重解释惩罚。当使用 eval () 函数或者是 Function 构造函数以及使用 setTimeout () 传一个字符串参数时都会发生这种情况。下面有一些例子：

// 某些代码求值 —— 避免！eval ("alert ('Hello world!')"); // 创建新函数 —— 避免！var sayHi = new Function ("alert ('Hello world!')"); // 设置超时 —— 避免！setTimeout ("alert ('Hello world!')", 500);

在以上这些例子中，都要解析包含了 JavaScript 代码的字符串。这个操作是不能在初始的解析过程中完成的，因为代码是包含在字符串中的，也就是说在 JavaScript 代码运行的同时必须新启动一个解析器来解析新的代码。实例化一个新的解析器有不容忽视的开销，所以这种代码要比直接解析慢得多。

对于这几个例子都有另外的办法。只有极少的情况下 eval () 是绝对必须的，所以尽可能避免使用。在这个例子中，代码其实可以直接内嵌在原代码中。对于 Function 构造函数，完全可以直接写成一般的函数，调用 setTimeout () 可以传入函数作为第一个参数。以下是一些例子：

// 已修正 alert ('Hello world!'); // 创建新函数 —— 已修正 var sayHi = function (){ alert ('Hello world!'); }; // 设置一个超时 —— 已修正 setTimeout (function (){alert ('Hello world!'); }, 500);

如果要提高代码性能，尽可能避免出现需要按照 JavaScript 解释的字符串。

5. 性能的其他注意事项

当评估脚本性能的时候，还有其他一些可以考虑的东西。下面并非主要的问题，不过如果使用得当也会有相当大的提升。

原生方法较快 —— 只要有可能，使用原生方法而不是自己用 JavaScript 重写一个。原生方法是用诸如 C/C++ 之类的编译型语言写出来的，所以要比 JavaScript 的快很多很多。JavaScript 中最容易被忘记的就是可以在 Math 对象中找到的复杂的数学运算；这些方法要比任何用 JavaScript 写的同样方法如正弦、余弦快的多。

Switch 语句较快 —— 如果有一系列复杂的 if-else 语句，可以转换成单个 switch 语句则可以得到更快的代码。还可以通过将 case 语句按照最可能的到最不可能的顺序进行组织，来进一步优化 switch 语句。

位运算符较快 —— 当进行数学运算的时候，位运算操作要比任何布尔运算或者算数运算快。选择性地用位运算替换算数运算可以极大提升复杂计算的性能。诸如取模，逻辑与和逻辑或都可以考虑用位运算来替换。

24.2.3　最小化语句数

JavaScript 代码中的语句数量也影响所执行的操作的速度。完成多个操作的单个语句要比完成单个操作的多个语句快。所以，就要找出可以组合在一起的语句，以减少脚本整体的执行时间。这里有几个可以参考的模式。

1. 多个变量声明

有个地方很多开发人员都容易创建很多语句，那就是多个变量的声明。很容易看到代码中由多个 var 语句来声明多个变量，如下所示：

