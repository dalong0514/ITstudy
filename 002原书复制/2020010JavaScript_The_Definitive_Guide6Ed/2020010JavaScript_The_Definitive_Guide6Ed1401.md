oldValue

Holds the old value of an existing item that changed or was deleted, or null if a new item was inserted.

storageArea

This property will equal either the localStorage or the sessionStorage property of the target Window object.

url

The URL (as a string) of the document whose script made this storage change.

Finally, note that localStorage and the storage event can serve as a broadcast mechanism by which a browser sends a message to all windows that are currently visiting the same website. If a user requests that a website stop performing animations, for example, the site might store that preference in localStorage so that it can honor it in future visits. And by storing the preference, it generates an event that allows other windows displaying the same site to honor the request as well. As another example, imagine a web-based image editing application that allows the user to display tool palettes in separate windows. When the user selects a tool, the application uses localStorage to save the current state and to generate a notification to other windows that a new tool has been selected.

Cookies

A cookie is a small amount of named data stored by the web browser and associated with a particular web page or website. Cookies were originally designed for server-side programming, and at the lowest level, they are implemented as an extension to the HTTP protocol. Cookie data is automatically transmitted between the web browser and web server, so server-side scripts can read and write cookie values that are stored on the client. This section demonstrates how client-side scripts can also manipulate cookies using the cookie property of the Document object.

Why「Cookie?」

The name「cookie」does not have a lot of significance, but it is not used without precedent. In the annals of computing history, the term「cookie」or「magic cookie」has been used to refer to a small chunk of data, particularly a chunk of privileged or secret data, akin to a password, that proves identity or permits access. In JavaScript, cookies are used to save state and can establish a kind of identity for a web browser. Cookies in JavaScript do not use any kind of cryptography, however, and are not secure in any way (although transmitting them across an https: connection helps).

The API for manipulating cookies is a very old one, which means that it is universally supported. Unfortunately, the API is also quite cryptic. There are no methods involved: cookies are queried, set, and deleted by reading and writing the cookie property of the Document object using specially formatted strings. The lifetime and scope of each cookie can be individually specified with cookie attributes. These attributes are also specified with specially formatted strings set on the same cookie property.

The subsections that follow explain the cookie attributes that specify lifetime and scope, and then demonstrate how to set and query cookie values in JavaScript. The section concludes with an example that implements the Storage API on top of cookies.

Determining Whether Cookies Are Enabled

Cookies have gotten a bad reputation for many web users because of the unscrupulous use of third-party cookies—cookies associated with the images on a web page rather than the web page itself. Third-party cookies enable an ad-hosting company to track a user from one client site to another client site, for example, and the privacy implications of this practice cause some users to disable cookies in their web browsers. Before using cookies in your JavaScript code, you may want to first check that they are enabled. In most browsers, you can do this by checking the navigator.cookieEnabled property. If true, cookies are enabled, and if false, cookies are disabled (although nonpersistent cookies that last for only the current browsing session may still be enabled). This is not a standard property, and if you find that it is undefined in the browser your code is running in, you must test for cookie support by trying to write, read, and delete a test cookie using the techniques explained below.

Cookie Attributes: Lifetime and Scope

In addition to a name and a value, each cookie has optional attributes that control its lifetime and scope. Cookies are transient by default; the values they store last for the duration of the web browser session but are lost when the user exits the browser. Note that this is a subtly different lifetime than sessionStorage: cookies are not scoped to a single window, and their default lifetime is the same as the entire browser process, not the lifetime of any one window. If you want a cookie to last beyond a single browsing session, you must tell the browser how long (in seconds) you would like it to retain the cookie by specifying a max-age attribute. If you specify a lifetime, the browser will store cookies in a file and delete them only once they expire.

Cookie visibility is scoped by document origin as localStorage and sessionStorage are, and also by document path. This scope is configurable through cookie attributes path and domain. By default, a cookie is associated with, and accessible to, the web page that created it and any other web pages in the same directory or any subdirectories of that directory. If the web page http://www.example.com/catalog/index.html creates a cookie, for example, that cookie is also visible to http://www.example.com/catalog/order.html and http://www.example.com/catalog/widgets/index.html, but it is not visible to http://www.example.com/about.html.

This default visibility behavior is often exactly what you want. Sometimes, though, you’ll want to use cookie values throughout a website, regardless of which page creates the cookie. For instance, if the user enters his mailing address in a form on one page, you may want to save that address to use as the default the next time he returns to the page and also as the default in an entirely unrelated form on another page where he is asked to enter a billing address. To allow this usage, you specify a path for the cookie. Then, any web page from the same web server whose URL begins with the path prefix you specified can share the cookie. For example, if a cookie set by http://www.example.com/catalog/widgets/index.html has its path set to「/catalog」, that cookie is also visible to http://www.example.com/catalog/order.html. Or, if the path is set to「/」, the cookie is visible to any page on the http://www.example.com web server.

Setting the path of a cookie to「/」gives scoping like that of localStorage and also specifies that the browser must transmit the cookie name and value to the server whenever it requests any web page on the site. Note that cookie path attribute should not be treated as any kind of access-control mechanism. If a web page wants to read the cookies from some other page of the same website, it can simply load that other page into a hidden <iframe> and read the cookies from the framed document. The same-origin policy (The Same-Origin Policy) prevents this kind of cookie-snooping from happening across sites, but it is perfectly legal for documents from the same site.

By default, cookies are scoped by document origin. Large websites may want cookies to be shared across subdomains, however. For example, the server at order.example.com may need to read cookie values set from catalog.example.com. This is where the domain attribute comes in. If a cookie created by a page on catalog.example.com sets its path attribute to「/」and its domain attribute to「.example.com」, that cookie is available to all web pages on catalog.example.com, orders.example.com, and any other server in the example.com domain. If the domain attribute is not set for a cookie, the default is the hostname of the web server that serves the page. Note that you cannot set the domain of a cookie to a domain other than the domain of your server.

The final cookie attribute is a boolean attribute named secure that specifies how cookie values are transmitted over the network. By default, cookies are insecure, which means that they are transmitted over a normal, insecure HTTP connection. If a cookie is marked secure, however, it is transmitted only when the browser and server are connected via HTTPS or another secure protocol.

Storing Cookies

To associate a transient cookie value with the current document, simply set the cookie property to a string of the form:

name=value

For example:

document.cookie = "version=" + encodeURIComponent(document.lastModified);

The next time you read the cookie property, the name/value pair you stored is included in the list of cookies for the document. Cookie values cannot include semicolons, commas, or whitespace. For this reason, you may want to use the core JavaScript global function encodeURIComponent() to encode the value before storing it in the cookie. If you do this, you’ll have to use the corresponding decodeURIComponent() function when you read the cookie value.

A cookie written with a simple name/value pair lasts for the current web-browsing session but is lost when the user exits the browser. To create a cookie that can last across browser sessions, specify its lifetime (in seconds) with a max-age attribute. You can do this by setting the cookie property to a string of the form:

name=value; max-age=seconds

The following function sets a cookie with an optional max-age attribute:

// Store the name/value pair as a cookie, encoding the value with // encodeURIComponent() in order to escape semicolons, commas, and spaces. // If daysToLive is a number, set the max-age attribute so that the cookie // expires after the specified number of days. Pass 0 to delete a cookie. function setCookie(name, value, daysToLive) { var cookie = name + "=" + encodeURIComponent(value); if (typeof daysToLive === "number") cookie += "; max-age=" + (daysToLive*60*60*24); document.cookie = cookie; }

Similarly, you can set the path, domain, and secure attributes of a cookie by appending strings of the following format to the cookie value before that value is written to the cookie property:

; path=path ; domain=domain ; secure

To change the value of a cookie, set its value again using the same name, path, and domain along with the new value. You can change the lifetime of a cookie when you change its value by specifying a new max-age attribute.

To delete a cookie, set it again using the same name, path, and domain, specifying an arbitrary (or empty) value, and a max-age attribute of 0.

Reading Cookies

When you use the cookie property in a JavaScript expression, the value it returns is a string that contains all the cookies that apply to the current document. The string is a list of name = value pairs separated from each other by a semicolon and a space. The cookie value does not include any of the attributes that may have been set for the cookie. In order to make use of the document.cookie property, you must typically call the split() method to break it into individual name=value pairs.

Once you have extracted the value of a cookie from the cookie property, you must interpret that value based on whatever format or encoding was used by the cookie’s creator. You might, for example, pass the cookie value to decodeURIComponent() and then to JSON.parse().

Example 20-1 defines a getCookie() function that parses the document.cookie property and returns an object whose properties specify the name and values of the document’s cookies.

Example 20-1. Parsing the document.cookies property

// Return the document's cookies as an object of name/value pairs. // Assume that cookie values are encoded with encodeURIComponent(). function getCookies() { var cookies = {}; // The object we will return var all = document.cookie; // Get all cookies in one big string if (all === "") // If the property is the empty string return cookies; // return an empty object var list = all.split("; "); // Split into individual name=value pairs for(var i = 0; i < list.length; i++) { // For each cookie var cookie = list[i]; var p = cookie.indexOf("="); // Find the first = sign var name = cookie.substring(0,p); // Get cookie name var value = cookie.substring(p+1); // Get cookie value value = decodeURIComponent(value); // Decode the value cookies[name] = value; // Store name and value in object } return cookies; }

Cookie Limitations

Cookies are intended for storage of small amounts of data by server-side scripts, and that data is transferred to the server each time a relevant URL is requested. The standard that defines cookies encourages browser manufacturers to allow unlimited numbers of cookies of unrestricted size but does not require browsers to retain more than 300 cookies total, 20 cookies per web server, or 4 KB of data per cookie (both name and value count toward this 4 KB limit). In practice, browsers allow many more than 300 cookies total, but the 4 KB size limit may still be enforced by some.

Storage with Cookies

Example 20-2 demonstrates how to implement the methods of the Storage API on top of cookies. Pass the desired max-age and path attributes to the CookieStorage() constructor, and then use the resulting object as you would use localStorage or sessionStorage. Note, though, that the example does not implement the storage event and it does not automatically store and retrieve values when you set and query properties of the CookieStorage object.

Example 20-2. Implementing the Storage API using cookies

/* * CookieStorage.js * This class implements the Storage API that localStorage and sessionStorage * do, but implements it on top of HTTP Cookies. */ function CookieStorage(maxage, path) { // Arguments specify lifetime and scope // Get an object that holds all cookies var cookies = (function() { // The getCookies() function shown earlier var cookies = {}; // The object we will return var all = document.cookie; // Get all cookies in one big string if (all === "") // If the property is the empty string return cookies; // return an empty object var list = all.split("; "); // Split into individual name=value pairs for(var i = 0; i < list.length; i++) { // For each cookie var cookie = list[i]; var p = cookie.indexOf("="); // Find the first = sign var name = cookie.substring(0,p); // Get cookie name var value = cookie.substring(p+1); // Get cookie value value = decodeURIComponent(value); // Decode the value cookies[name] = value; // Store name and value } return cookies; }()); // Collect the cookie names in an array var keys = []; for(var key in cookies) keys.push(key); // Now define the public properties and methods of the Storage API // The number of stored cookies this.length = keys.length; // Return the name of the nth cookie, or null if n is out of range this.key = function(n) { if (n < 0 || n >= keys.length) return null; return keys[n]; }; // Return the value of the named cookie, or null. this.getItem = function(name) { return cookies[name] || null; }; // Store a value this.setItem = function(key, value) { if (!(key in cookies)) { // If no existing cookie with this name keys.push(key); // Add key to the array of keys this.length++; // And increment the length } // Store this name/value pair in the set of cookies. cookies[key] = value; // Now actually set the cookie. // First encode value and create a name=encoded-value string var cookie = key + "=" + encodeURIComponent(value); // Add cookie attributes to that string if (maxage) cookie += "; max-age=" + maxage; if (path) cookie += "; path=" + path; // Set the cookie through the magic document.cookie property document.cookie = cookie; }; // Remove the specified cookie this.removeItem = function(key) { if (!(key in cookies)) return; // If it doesn't exist, do nothing // Delete the cookie from our internal set of cookies delete cookies[key]; // And remove the key from the array of names, too. // This would be easier with the ES5 array indexOf() method. for(var i = 0; i < keys.length; i++) { // Loop through all keys if (keys[i] === key) { // When we find the one we want keys.splice(i,1); // Remove it from the array. break; } } this.length--; // Decrement cookie length // Finally actually delete the cookie by giving it an empty value // and an immediate expiration date. document.cookie = key + "=; max-age=0"; }; // Remove all cookies this.clear = function() { // Loop through the keys, removing the cookies for(var i = 0; i < keys.length; i++) document.cookie = keys[i] + "=; max-age=0"; // Reset our internal state cookies = {}; keys = []; this.length = 0; }; }

IE userData Persistence

IE5 and later enable client-side storage by attaching a proprietary「DHTML behavior」to a document element. You can do that with code like this:

var memory = document.createElement("div"); // Create an element memory.id = "_memory"; // Give it a name memory.style.display = "none"; // Never display it memory.style.behavior = "url('#default#userData')"; // Attach a magic behavior document.body.appendChild(memory); // Add it to the document

Once you add the「userData」behavior to an element, that element gets new load() and save() methods. Call load() to load stored data. You must pass a string to this method—it is like a file name, identifying a particular batch of stored data. When data is loaded, the name/value pairs become available as attributes of the element, and you can query them with getAttribute(). To save new data, set attributes with set Attribute() and then call the save() method. To delete a value, use removeAttribute() and save(). Here is an example, using the memory element initialized above:

memory.load("myStoredData"); // Load a named batch of saved data var name = memory.getAttribute("username"); // Get one piece of stored data if (!name) { // If it wasn't defined name = prompt("What is your name?); // Get user input memory.setAtttribute("username", name); // Set it as an attribute memory.save("myStoredData"); // And save it for next time }

By default, data saved with userData has an indefinite lifetime and lasts until you delete it. But you can specify an expiration date by setting the expires property. For example, you might add the following lines to the previous code to specify an expiration date 100 days in the future:

var now = (new Date()).getTime(); // Now, in milliseconds var expires = now + 100 * 24 * 60 * 60 * 1000; // 100 days from now in ms expires = new Date(expires).toUTCString(); // Convert it to a string memory.expires = expires; // Set userData expiration

IE userData is scoped to documents in the same directory as the document that set it. This is a narrower scope than cookies, which also make cookies available to documents in subdirectories of the original directory. The userData mechanism does not have any equivalent of the cookie path and domain attributes to widen the scope of the data.

userData allows much more data to be stored than cookies do, but much less than localStorage and sessionStorage do.

Example 20-3 implements the getItem(), setItem(), and removeItem() methods of the Storage API on top of IE’s userData. (It does not implement key() or clear(), because userData does not define a way to iterate through all stored items.)

Example 20-3. A partial Storage API based on IE’s userData

function UserDataStorage(maxage) { // Create a document element and install the special userData // behavior on it so it gets save() and load() methods. var memory = document.createElement("div"); // Create an element memory.style.display = "none"; // Never display it memory.style.behavior = "url('#default#userData')"; // Attach magic behavior document.body.appendChild(memory); // Add to the document // If maxage is specified, expire the userData in maxage seconds if (maxage) { var now = new Date().getTime(); // The current time var expires = now + maxage * 1000; // maxage seconds from now memory.expires = new Date(expires).toUTCString(); } // Initialize memory by loading saved values. // The argument is arbitrary, but must also be passed to save() memory.load("UserDataStorage"); // Load any stored data this.getItem = function(key) { // Retrieve saved values from attributes return memory.getAttribute(key) || null; }; this.setItem = function(key, value) { memory.setAttribute(key,value); // Store values as attributes memory.save("UserDataStorage"); // Save state after any change }; this.removeItem = function(key) { memory.removeAttribute(key); // Remove stored value attribute memory.save("UserDataStorage"); // Save new state }; }

Because the code in Example 20-3 can only work in IE, you might use IE conditional comments to prevent browsers other than IE from loading it:

<!--[if IE]> <script src="UserDataStorage.js"></script> <![endif]-->

Application Storage and Offline Webapps

HTML5 adds an「application cache」that web applications can use to store themselves locally in a user’s browser. localStorage and sessionStorage store data for a web application, but the application cache stores the application itself—all the files (HTML, CSS, JavaScript, images, and so on) the application needs to run. The application cache is different from a web browser’s regular cache: it isn’t cleared when the user clears the regular cache. And cached applications aren’t cleared out on a LRU (least-recently used) basis as they might be in an ordinary fixed-size cache. Applications aren’t temporarily stored in the cache: they’re installed there, and they remain there until they uninstall themselves or the user deletes them. The application cache is really not a cache at all: a better name would be「application storage.」

The reason to allow web applications to be locally installed is to guarantee their availability when offline (such as when on an airplane or when a cellphone isn’t receiving a signal). Web applications that work while offline install themselves in the application cache, use localStorage to store their data, and have a synchronization mechanism to transfer stored data to the server when they go back online. We’ll see an example offline webapp in Offline Web Applications. First, however, we’ll see how an application can install itself in the application cache.

The Application Cache Manifest

In order to install an application in the application cache, you must create a manifest: a file that lists all of the URLs the application requires. Then, simply link the main HTML page of your application to the manifest by setting the manifest attribute of the <html> tag:

<!DOCTYPE HTML> <html manifest="myapp.appcache"> <head>...</head> <body>...</body> </html>

Manifest files must begin with the string「CACHE MANIFEST」as their first line. The lines that follow should list URLs to be cached, one URL per line. Relative URLs are relative to the URL of the manifest file. Blank lines are ignored. Lines that begin with # are comments and are ignored. Comments may have space before them, but they cannot follow any nonspace characters on the same line. Here is a simple manifest file:

CACHE MANIFEST # The line above identifies the file type. This line is a comment # The lines below specify the resources the application needs to run myapp.html myapp.js myapp.css images/background.png

Cache Manifest MIME Type

By convention, application cache manifest files are given the filename extension .appcache. This is a convention only, however, and to actually identify the file type, the web server must serve a manifest with MIME type「text/cache-manifest」. If the server sets the manifest’s Content-Type header to any other MIME type, your application will not be cached. You may have to configure your web server to use this MIME type by, for example, creating an Apache .htaccess file in the web app directory.

It is the manifest file that serves as the identity of the cached application. If a web app has more than one web page (more than one HTML file that the user can link to), each one of these pages should use the <html manifest=> attribute to link to the manifest file. The fact that these pages all link to the same manifest file makes it clear that they are all to be cached together as part of the same web app. If there are only a few HTML pages in the application, it is conventional to list those pages explicitly in the manifest file. But this is not required: any file that links to the manifest file will be considered part of the web app and will be cached along with it.

A simple manifest like the one shown above must list all of the resources required by the web application. Once a web app has been downloaded the first time and cached, any subsequent loads will be from the cache. When an application is loaded from the cache, any resources it requires must be listed in the manifest. Resources that are not listed will not be loaded. This policy simulates being offline. If a simple cached application can run from the cache, it will also be able to run while the browser is offline. More complicated web apps cannot, in general, cache every single resource they require. They can still use the application cache if they have a more complex manifest.

Complex manifests

When an application is loaded from the application cache, only resources listed in its manifest file will be loaded. The example manifest file shown previously lists resources one URL at a time. Manifest files actually have a more complicated syntax than that example shows, and there are two other ways to list resources in a manifest file. Special section header lines are used to identify the type of manifest entry that follows the header. Simple cache entries like those shown above go in a「CACHE:」section, which is the default section. The other two sections begin with the headers「NETWORK:」and「FALLBACK:」. (A manifest can have any number of sections and can switch back and forth between sections as needed.)

The「NETWORK:」section specifies URLs that must never be cached and should always be retrieved from the network. You might list server-side scripts here, for example. The URLs in a「NETWORK:」section are actually URL prefixes. A resource whose URL begins with any one of these prefixes will be loaded from the network. If the browser is offline, that attempt will fail, of course. The「NETWORK:」section allows a wildcard URL「*」. If you use this wildcard, the browser will attempt to load any resource not mentioned in the manifest from the network. This effectively defeats the rule that says that cached applications must list all their resources in the manifest.

The manifest entries in the「FALLBACK:」section include two URLs on each line. The second URL is loaded and is stored in the cache. The first URL is a prefix. URLs matching this prefix will not be cached, but they will be loaded from the network when possible. If the attempt to load such a URL fails, the cached resource specified by the second URL will be used instead. Imagine a web application that includes a number of video tutorials. Because these videos are very large, they are not appropriate to cache locally. For offline use, a manifest file could fall back on a text-based help file instead.

Here is a more complicated cache manifest:

CACHE MANIFEST CACHE: myapp.html myapp.css myapp.js FALLBACK: videos/ offline_help.html NETWORK: cgi/

Cache Updates

When you load a web application that has been cached, all of its files come directly from the cache. If the browser is online, it will also asynchronously check to see if the manifest file has changed. If it has changed, the new manifest file, and all the files it references, are downloaded and reinstalled in the application cache. Note that the browser does not check to see whether any of the cached files have changed: only the manifest. If you modify a cached JavaScript file, for example, and want sites that have cached your web app to update their cache, you must update the manifest. Since the list of files required by your app has not changed, the easiest way to do this is by updating a version number:

CACHE MANIFEST # MyApp version 1 (change this number to make browsers redownload the files) MyApp.html MyApp.js

Similarly, if you want a web app to uninstall itself from the application cache, you should delete the manifest file on the server, so that requests for it return an HTTP 404 Not Found error, and modify your HTML file or files so that they no longer link to the manifest.

Note that the browser checks the manifest and updates the cache asynchronously, after (or while) loading the cached copy of an application. For simple web apps, this means that after you update the manifest, the user must load the application twice before he sees the new version: the first load loads the old version from the cache and then updates the cache. Then the second load loads the new version from the cache.

The browser fires a number of events during the cache update process, and you can register handlers to track the process and provide feedback to the user. For example:

applicationCache.onupdateready = function() { var reload = confirm("A new version of this application is available\n" + "and will be used the next time you reload.\n" + "Do you want to reload now?"); if (reload) location.reload(); }

Note that this event handler is registered on the ApplicationCache object that is the value of the applicationCache property of the Window. Browsers that support an application cache will define this property. In addition to the updateready event shown above, there are seven other application cache events you can monitor. Example 20-4 shows simple handlers that display messages to the user informing them of the progress of the cache update and of the current cache status.

Example 20-4. Handling application cache events

// The event handlers below all use this function to display status messages. // Since the handlers all display status messages this way, they return false // to cancel the event and prevent the browser from displaying its own status. function status(msg) { // Display the message in the document element with id "statusline" document.getElementById("statusline").innerHTML = msg; console.log(msg); // And also in the console for debugging } // Each time the application is loaded, it checks its manifest file. // The checking event is always fired first when this process begins. window.applicationCache.onchecking = function() { status("Checking for a new version."); return false; }; // If the manifest file has not changed, and the app is already cached, // the noupdate event is fired and the process ends. window.applicationCache.onnoupdate = function() { status("This version is up-to-date.") return false; }; // If the application is not already cached, or if the manifest has changed, // the browser downloads and caches everything listed in the manifest. // The downloading event signals the start of this download process. window.applicationCache.ondownloading = function() { status("Downloading new version"); window.progresscount = 0; // Used in the progress handler below return false; }; // progress events are fired periodically during the downloading process, // typically once for each file downloaded. window.applicationCache.onprogress = function(e) { // The event object should be a progress event (like those used by XHR2) // that allows us to compute a completion percentage, but if not, // we keep count of how many times we've been called. var progress = ""; if (e && e.lengthComputable) // Progress event: compute percentage progress = " " + Math.round(100*e.loaded/e.total) + "%" else // Otherwise report # of times called progress = " (" + ++progresscount + ")" status("Downloading new version" + progress); return false; }; // The first time an application is downloaded into the cache, the browser // fires the cached event when the download is complete. window.applicationCache.oncached = function() { status("This application is now cached locally"); return false; }; // When an already-cached application is updated, and the download is complete // the browser fires "updateready". Note that the user will still be seeing // the old version of the application when this event arrives. window.applicationCache.onupdateready = function() { status("A new version has been downloaded. Reload to run it"); return false; }; // If the browser is offline and the manifest cannot be checked, an "error" // event is fired. This also happens if an uncached application references // a manifest file that does not exist window.applicationCache.onerror = function() { status("Couldn't load manifest or cache application"); return false; }; // If a cached application references a manifest file that does not exist, // an obsolete event is fired and the application is removed from the cache. // Subsequent loads are done from the network rather than from the cache. window.applicationCache.onobsolete = function() { status("This application is no longer cached. " + "Reload to get the latest version from the network."); return false; };

Each time an HTML file with a manifest attribute is loaded, the browser fires a checking event and loads the manifest file from the network. The events that follow the checking event are different in different situations:

No update available

If the application is already in the cache, and the manifest file has not changed, the browser fires a noupdate event.

Update available

If an application is cached, and its manifest file has changed, the browser fires a downloading event and begins downloading and caching all the files listed in the manifest. As this download occurs, it fires progress events. And when the download is complete, it fires an updateready event.

First load of new application

If the application is not yet in the cache, downloading and progress events are fired as they are for the cache update case above. Once this initial download is complete, however, the browser fires a cached event rather than an updateready event.

Browser is offline

If the browser is offline, it cannot check the manifest and it fires an error event. This also happens when an application that has not yet been cached refers to a manifest file that does not exist.

Manifest not found

If the browser is online and the application is already cached, but the manifest file returns a 404 Not Found error, it fires an obsolete event and removes the application from the cache.

Note that all of these events are cancelable. The handlers in Example 20-4 returns false to cancel the default action associated with the events. This prevents browsers from displaying their own cache status messages. (At the time of this writing, browsers do not display any such messages.)

As an alternative to the event handlers, an application can also use the application Cache. status property to determine the cache status. There are six possible values for this property:

ApplicationCache.UNCACHED (0)

This application does not have a manifest attribute: it is not cached.

ApplicationCache.IDLE (1)

The manifest has been checked and this application is cached and up to date.

ApplicationCache.CHECKING (2)

The browser is checking the manifest file.

ApplicationCache.DOWNLOADING (3)

The browser is downloading and caching files listed in the manifest.

ApplicationCache.UPDATEREADY (4)

A new version of the application has been downloaded and cached.

ApplicationCache.OBSOLETE (5)

The manifest no longer exists and the cache will be deleted.

The ApplicationCache object also defines two methods. update() explicitly invokes the cache update algorithm to check for a new version of the application. This causes the browser to run through the same manifest check (and fire the same events) as it does when an application is first loaded.

The swapCache() method is trickier. Recall that when the browser downloads and caches an updated version of an application, the user is still running the out-of-date version. If the user reloads the app, she’ll see the new version. But if the user does not reload, the old version must still run correctly. And notice that the old version may still be loading resources from the cache: it might be using XMLHttpRequest to request files, for example, and these requests must be satisfied by files in the old version of the cache. Therefore, the browser must generally keep the old version of the cache until the user reloads the application.

The swapCache() method tells the browser that it can discard the old cache and satisfy any future requests from the new cache. Note that this does not reload the application: HTML files, images, scripts, and so on that have already been loaded are not changed. But any future requests will come from the new version of the cache. This can cause version-skew issues and is not generally a good idea unless your app is carefully designed to allow it. Imagine, for example, an application that does nothing but display a splash screen of some sort while the browser is checking the manifest. When it sees the noupdate event, it goes ahead and loads the application’s start page. If it sees a downloading event, it displays appropriate progress feedback while the cache is updated. And when it gets an updateready event, it calls swapCache() and then loads the updated start page from the latest version of the cache.

Note that it only makes sense to call swapCache() when the status property has the value ApplicationCache.UPDATEREADY or ApplicationCache.OBSOLETE. (Calling swap Cache() when the status is OBSOLETE discards the obsolete cache immediately, and satisfies all future requests via the network.) If you call swapCache() when status has any other value, it will throw an exception.

Offline Web Applications

An offline web application is one that installs itself in the application cache so that it is always available, even when the browser is offline. For the simplest cases—things like clocks and fractal generators—this is all a web app needs to do to become an offline web app. But most nontrivial web apps need to upload data to the server as well: even simple game apps might want to upload a user’s high score to the server. Apps that need to upload data to a server can be offline web apps if they use localStorage to store application data, and then upload it when an Internet connection is available. Synchronizing data between local storage and the server can be the trickiest part of converting a web app for offline use, especially when the user might be accessing the data from more than one device.

In order to work offline, a web application needs to be able to tell whether it is offline or online and needs to know when the state of the Internet connection changes. To check whether the browser is online, a web app can use the navigator.onLine property. And to detect changes in the connection state, it can register handlers for online and offline events on the Window object.

This chapter concludes with a simple offline web app that demonstrates these techniques. The app is called PermaNote—it is a simple note application that saves the user’s text to localStorage and by uploading it to the server whenever an Internet connection is available.[51] PermaNote only allows the user to edit a single note, and it ignores authorization and authentication issues—it assumes the server has some way of distinguishing one user from another, but does not include any kind of login screen. The PermaNote implementation consists of three files. Example 20-5 is the cache manifest. It lists the other two files and specifies that the URL「note」should not be cached: that is the URL we use to read and write the note to the server.

Example 20-5. permanote.appcache

CACHE MANIFEST # PermaNote v8 permanote.html permanote.js NETWORK: note

Example 20-6 is the second PermaNote file: it is an HTML file that defines a very simple editor UI. It displays a <textarea> element with a row of buttons across the top and a status line for messages along the bottom. Notice that the <html> tag has a manifest attribute.

Example 20-6. permanote.html

<!DOCTYPE HTML> <html manifest="permanote.appcache"> <head> <title>PermaNote Editor</title> <script src="permanote.js"></script> <style> #editor { width: 100%; height: 250px; } #statusline { width: 100%; } </style> </head> <body> <div id="toolbar"> <button id="savebutton" onclick="save()">Save</button> <button onclick="sync()">Sync Note</button> <button onclick="applicationCache.update()">Update Application</button> </div> <textarea id="editor"></textarea> <div id="statusline"></div> </body> </html>

Finally, Example 20-7 lists the JavaScript code that makes the PermaNote web application work. It defines a status() function for displaying messages on the status line, a save() function for saving the current version of the note to the server, and a sync() function for making sure that the server’s copy and the local copy are in sync. The save() and sync() functions use scripted HTTP techniques from Chapter 18. (Interestingly, the save() function uses the HTTP「PUT」method instead of the much more common POST method.)

In addition to these three basic functions, Example 20-7 defines event handlers. In order to keep the local copy and the server’s copy of the note synchronized, the app requires quite a few event handlers:

onload

Try to sync with the server, in case there is a newer version of the note there, and once synchronization is complete, enable the editor window.

The save() and sync() functions make HTTP requests, and they register an onload handler on the XMLHttpRequest object to be notified when the upload or download is complete.

onbeforeunload

Save the current version of the note to the server if it has not been uploaded.

oninput

Whenever the text in the <textarea> changes, save it in localStorage, and start a timer. If the user stops editing for 5 seconds, save the note to the server.

onoffline

When the browser goes offline, display a message in the status line.

ononline

When the browser comes back online, synchronize with the server, checking for a newer version, and saving the current version.

onupdateready

If a new version of the cached application is ready, display a message in the status line to let the user know.

onnoupdate

If the application cache has not changed, let the user know that he or she is running the current version.

With that overview of PermaNote’s event-driven logic, here is Example 20-7.

Example 20-7. permanote.js

// Some variables we need throughout var editor, statusline, savebutton, idletimer; // The first time the application loads window.onload = function() { // Initialize local storage if this is the first time if (localStorage.note == null) localStorage.note = ""; if (localStorage.lastModified == null) localStorage.lastModified = 0; if (localStorage.lastSaved == null) localStorage.lastSaved = 0; // Find the elements that are the editor UI. Initialize global variables. editor = document.getElementById("editor"); statusline = document.getElementById("statusline"); savebutton = document.getElementById("savebutton"); editor.value = localStorage.note; // Initialize editor with saved note editor.disabled = true; // But don't allow editing until we sync // Whenever there is input in the textarea editor.addEventListener("input", function (e) { // Save the new value in localStorage localStorage.note = editor.value; localStorage.lastModified = Date.now(); // Reset the idle timer if (idletimer) clearTimeout(idletimer); idletimer = setTimeout(save, 5000); // Enable the save button savebutton.disabled = false; }, false); // Each time the application loads, try to sync up with the server sync(); }; // Save to the server before navigating away from the page window.onbeforeunload = function() { if (localStorage.lastModified > localStorage.lastSaved) save(); }; // If we go offline, let the user know window.onoffline = function() { status("Offline"); } // When we come online again, sync up. window.ononline = function() { sync(); }; // Notify the user if there is a new version of this application available. // We could also force a reload here with location.reload() window.applicationCache.onupdateready = function() { status("A new version of this application is available. Reload to run it"); }; // Also let the user know if there is not a new version available. window.applicationCache.onnoupdate = function() { status("You are running the latest version of the application."); }; // A function to display a status message in the status line function status(msg) { statusline.innerHTML = msg; } // Upload the note text to the server (if we're online). // Will be automatically called after 5 seconds of inactivity whenever // the note has been modified. function save() { if (idletimer) clearTimeout(idletimer); idletimer = null; if (navigator.onLine) { var xhr = new XMLHttpRequest(); xhr.open("PUT", "/note"); xhr.send(editor.value); xhr.onload = function() { localStorage.lastSaved = Date.now(); savebutton.disabled = true; }; } } // Check for a new version of the note on the server. If a newer // version is not found, save the current version to the server. function sync() { if (navigator.onLine) { var xhr = new XMLHttpRequest(); xhr.open("GET", "/note"); xhr.send(); xhr.onload = function() { var remoteModTime = 0; if (xhr.status == 200) { var remoteModTime = xhr.getResponseHeader("Last-Modified"); remoteModTime = new Date(remoteModTime).getTime(); } if (remoteModTime > localStorage.lastModified) { status("Newer note found on server."); var useit = confirm("There is a newer version of the note\n" + "on the server. Click Ok to use that version\n"+ "or click Cancel to continue editing this\n"+ "version and overwrite the server"); var now = Date.now(); if (useit) { editor.value = localStorage.note = xhr.responseText; localStorage.lastSaved = now; status("Newest version downloaded."); } else status("Ignoring newer version of the note."); localStorage.lastModified = now; } else status("You are editing the current version of the note."); if (localStorage.lastModified > localStorage.lastSaved) { save(); } editor.disabled = false; // Re-enable the editor editor.focus(); // And put cursor in it } } else { // If we are currently offline, we can't sync status("Can't sync while offline"); editor.disabled = false; editor.focus(); } }

* * *

[51] This example was loosely inspired by Halfnote, by Aaron Boodman. Halfnote was one of the first offline web apps.

Chapter 21. Scripted Media and Graphics

This chapter describes how to use JavaScript to manipulate images, control audio and video streams, and draw graphics. Scripting Images explains traditional JavaScript techniques for visual effects such as image rollovers in which one static image is replaced by another when the mouse pointer moves over it. Scripting Audio and Video covers the HTML5 <audio> and <video> elements and their JavaScript APIs.

After these first two sections on images, audio and video, the chapter moves on to cover two powerful technologies for drawing client-side graphics. The ability to dynamically generate sophisticated graphics in the browser is important for several reasons:

The code used to produce graphics on the client side is typically much smaller than the images themselves, creating a substantial bandwidth savings.

Dynamically generating graphics from real-time data uses a lot of CPU cycles. Offloading this task to the client reduces the load on the server, potentially saving on hardware costs.

Generating graphics on the client is consistent with modern web application architecture in which servers provide data and clients manage the presentation of that data.

SVG: Scalable Vector Graphics explains Scalable Vector Graphics, or SVG. SVG is an XML-based language for describing graphics, and SVG drawings can be created and scripted using JavaScript and the DOM. Finally, Graphics in a <canvas> covers the HTML5 <canvas> element and its full-featured JavaScript API for client-side drawing. The <canvas> element is a revolutionary technology, and this chapter covers it in detail.

Scripting Images

Web pages include images using the HTML <img> element. Like all HTML elements, an <img> element can be scripted: setting the src property to a new URL causes the browser to load (if necessary) and display a new image. (You can also script the width and height of an image, which will make the browser shrink or enlarge the image, but that technique is not demonstrated here.)

The ability to dynamically replace one image with another in an HTML document opens the door to a number of special effects. One common use for image replacement is to implement image rollovers, in which an image changes when the mouse pointer moves over it. When you make images clickable by placing them inside your hyperlinks, rollover effects are a powerful way to invite the user to click on the image. (Similar effects can be achieved without scripting using the CSS :hover pseudoclass to alter the background image of an element.) The following HTML fragment is a simple example: it creates an image that changes when the mouse moves over it:

<img src="images/help.gif" onmouseover="this.src='images/help_rollover.gif'" onmouseout="this.src='images/help.gif'">

The event handlers of the <img> element set the src property when the mouse moves over or out of the image. Image rollovers are strongly associated with clickability, so this <img> element should still be enclosed in an <a> element or given an onclick event handler.

In order to be useful, image rollovers (and similar effects) need to be responsive. This means that you need some way to ensure that the necessary images are「prefetched」into the browser’s cache. Client-side JavaScript defines a special-purpose API for this purpose: to force an image to be cached, create an offscreen Image object using the Image() constructor. Next, load an image into it by setting the src property of this object to the desired URL. This image is not added to the document, so it does not become visible, but the browser nevertheless loads and caches the image data. Later, when the same URL is used for an onscreen image, it can be quickly loaded from the browser’s cache, rather than slowly loaded over the network.

The image-rollover code fragment shown in the previous section did not prefetch the rollover image it used, so the user might notice a delay in the rollover effect the first time she moves the mouse over the image. To fix this problem, modify the code as follows:

<script>(new Image()).src = "images/help_rollover.gif";</script> <img src="images/help.gif" onmouseover="this.src='images/help_rollover.gif'" onmouseout="this.src='images/help.gif'">

Unobtrusive Image Rollovers

The image rollover code just shown requires one <script> element and two JavaScript event-handler attributes to implement a single rollover effect. This is a perfect example of obtrusive JavaScript: the amount of JavaScript code is so large that it effectively obscures the HTML. Example 21-1 shows an unobtrusive alternative that allows you to create image rollovers by simply specifying a data-rollover attribute (see Dataset Attributes) on any <img> element. Note that this example uses the onLoad() function of Example 13-5. It also uses the document.images[] array (see Selecting Elements by Type) to find all <img> elements in the document.

Example 21-1. Unobtrusive Image Rollovers

/** * rollover.js: unobtrusive image rollovers. * * To create image rollovers, include this module in your HTML file and * use the data-rollover attribute on any <img> element to specify the URL of * the rollover image. For example: * * <img src="normal_image.png" data-rollover="rollover_image.png"> * * Note that this module requires onLoad.js */ onLoad(function() { // Everything in one anonymous function: no symbols defined // Loop through all images, looking for the data-rollover attribute for(var i = 0; i < document.images.length; i++) { var img = document.images[i]; var rollover = img.getAttribute("data-rollover"); if (!rollover) continue; // Skip images without data-rollover // Ensure that the rollover image is in the cache (new Image()).src = rollover; // Define an attribute to remember the default image URL img.setAttribute("data-rollout", img.src); // Register the event handlers that create the rollover effect img.onmouseover = function() { this.src = this.getAttribute("data-rollover"); }; img.onmouseout = function() { this.src = this.getAttribute("data-rollout"); }; } });

Scripting Audio and Video

HTML5 introduces <audio> and <video> elements that are, in theory, as easy to use as the <img> element. In HTML5-enabled browsers, you no longer need to use plug-ins (like Flash) to embed sounds and movies in your HTML documents:

<audio src="background_music.mp3"/> <video src="news.mov" width=320 height=240/>

In practice, the use of these elements is trickier than this, since browser vendors have not been able to agree on a standard audio and video codec that all will support, so you typically end up using <source> elements to specify multiple media sources in different formats:

<audio id="music"> <source src="music.mp3" type="audio/mpeg"> <source src="music.ogg" type='audio/ogg; codec="vorbis"'> </audio>

Note that <source> elements have no content: there is no closing </source> tag, and you do not need to end them with />

Browsers that support <audio> and <video> elements will not render these element’s content. But browsers that do not support them do render their content, so you can put fallback content (such as an <object> element that invokes the Flash plug-in) inside:

<video id="news" width=640 height=480 controls preload> <!-- WebM format for Firefox and Chrome --> <source src="news.webm" type='video/webm; codecs="vp8, vorbis"'> <!-- H.264 format for IE and Safari --> <source src="news.mp4" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'> <!-- Fall back on the Flash plugin --> <object width=640 height=480 type="application/x-shockwave-flash" data="flash_movie_player.swf"> <!-- Param elements here configure the Flash movie player you're using --> <!-- Text is the ultimate fallback content --> <div>video element not supported and Flash plugin not installed.</div> </object> </video>

<audio> and <video> elements support a controls attribute. If present (or if the corresponding JavaScript property is set to true), they display a set of playback controls that includes play and pause buttons, a volume control, and so on. In addition, however, the <audio> and <video> elements expose an API that gives scripts the power to control media playback, and you can use this API to add simple sound effects to your web application or to create your own custom control panels for sound and video. Although their visual appearance is very different, the <audio> and <video> elements share essentially the same API (the only real difference between them is that the <video> element has width and height properties) and almost everything that follows in this section applies to both elements.

The Audio() constructor

<audio> elements don’t have any visual appearance in the document unless you set the controls attribute. And just as you can create an offscreen image with the Image() constructor, the HTML5 media API allows you to create an offscreen audio element with the Audio() constructor, passing a source URL as the argument:

new Audio("chime.wav").play(); // Load and play a sound effect

The return value of the Audio() constructor is the same kind of object you’d get when querying an <audio> element from the document, or creating a new one with document. createElement("audio"). Note that this is an audio-only feature of the media API: there is no corresponding Video() constructor.

Despite the frustrating requirement to define media in multiple file formats, the ability to play audio and video natively in the browser, without the use of plug-ins, is a powerful new feature in HTML5. Note that the problem of media codecs and browser compatibility is beyond the scope of this book. The subsections that follow focus only on the JavaScript API for working with audio and video streams.

Type Selection and Loading

If you want to test whether a media element can play a particular type of media, pass the media MIME type (possibly including a codec parameter) to the canPlayType() method. The element returns the empty string (a falsy value) if it cannot play that media type. Otherwise, it returns the string「maybe」or「probably」. Because of the complicated nature of audio and video codecs, a player cannot in general be more certain than「probably」that it can play a particular media type without actually downloading the media and trying:

var a = new Audio(); if (a.canPlayType("audio/wav")) { a.src = "soundeffect.wav"; a.play(); }

When you set the src property of a media element, it begins the process of loading that media. (That process won’t go very far unless preload is「auto」.) Setting src when some other media is loading or playing will abort the loading or playing of the old media. If you add <source> elements to a media element instead of setting the src attribute, the element cannot know when you have inserted a complete set of elements, and it will not begin choosing among the <source> elements and loading data until you explicitly call the load() method.

Controlling Media Playback

The most important methods of the <audio> and <video> elements are play() and pause(), which start and stop playback of the media:

// When the document has loaded, start playing some background music window.addEventListener("load", function() { document.getElementById("music").play(); }, false);

In addition to starting and stopping sound and video, you can skip (or「seek」) to a desired location within the media by setting the currentTime property. This property specifies the time in seconds to which the player should skip, and it can be set while the media is playing or while it is paused. (The initialTime and duration properties give the legal range of values for currentTime; more about those properties follows.)

The volume property specifies playback volume as a number between 0 (silent) and 1 (maximum volume). The muted property can be set to true to mute playback or set to false to resume playing sound at the specified volume level.

The playbackRate property specifies the speed at which the media is played. A value of 1.0 is the normal speed. Values greater than 1 are「fast forward」and values between 0 and 1 are「slow motion.」Negative values are supposed to play the sound or video backward, but browsers do not support that feature at the time of this writing. <audio> and <video> elements also have a defaultPlaybackRate property. Whenever the play() method is invoked, the playbackRate property is set to defaultPlaybackRate.

Note that the currentTime, volume, muted, and playbackRate properties are not only for controlling media playback. If an <audio> or <video> element has the controls attribute, it displays player controls, giving the user control over playback. In that case, a script might query properties like muted and currentTime to discover how the media is being played.

The HTML attributes controls, loop, preload, and autoplay affect audio and video playback and can also be set and queried as JavaScript properties. controls specifies whether playback controls are displayed in the browser. Set this property to true to display controls or false to hide controls. The loop property is a boolean that specifies whether the media should play in a loop (true) or stop when it reaches the end (false). The preload property specifies whether (or how much) media content should be preloaded before the user starts playing the media. The value「none」means no data should be preloaded. The value「metadata」means that metadata such as duration, bitrate, and frame size should be loaded, but not media data itself. Browsers typically load metadata if you do not specify a preload attribute. The preload value「auto」means that the browser should preload as much of the media as it deems appropriate. Finally, the autoplay property specifies whether the media should begin to play automatically when a sufficient amount has been buffered. Setting autoplay to true obviously implies that the browser should preload media data.

Querying Media Status

<audio> and <video> elements have a number of read-only properties that describe the current state of the media and of the player. paused is true if the player is paused. seeking is true if the player is skipping to a new playback position. ended is true if the player has reached the end of the media and has stopped. (ended never becomes true if loop is true.)

The duration property specifies the duration of the media in seconds. If you query this property before the media metadata has been loaded, it returns NaN. For streaming media, such as Internet radio, with an indefinite duration, this property returns Infinity.

The initialTime property specifies the start time of the media, in seconds. For media clips of fixed duration, this is usually 0. For streaming media, this property gives the earliest time for which data is still buffered and which it is possible to seek back to. currentTime can never be set to less than initialTime.

Three other properties provide a finer-grained view of the media timeline and its playback and buffering status. The played property returns the time range or ranges that have been played. The buffered property returns the time range or ranges that are currently buffered, and the seekable property returns the time range or ranges that the player can currently seek to. (You might use these properties to implement a progress bar that illustrates the currentTime and duration along with how much of the media has played and how much is buffered.)

played, buffered, and seekable are TimeRanges objects. Each object has a length property that specifies the number of ranges it represents and start() and end() methods that return the start and end times (in seconds) of a numbered range. In the most common case of a single contiguous range of times, you’d use start(0) and end(0). Assuming that no seeking has happened and media is buffered from the beginning, for example, you might use code like this to determine what percentage of a resource was buffered:

var percent_loaded = Math.floor(song.buffered.end(0) / song.duration * 100);

Finally, three more properties, readyState, networkState, and error, give low-level status details about <audio> and <video> elements. Each of the properties has a numeric value, and constants are defined for each of the legal values. Note that these constants are defined on the media object (or the error object) itself. You might use one in code like this:

if (song.readyState === song.HAVE_ENOUGH_DATA) song.play();

readyState specifies how much media data has been loaded, and therefore, how ready the element is to begin playing that data. The values for this property and their meanings are as follows:

ConstantValueDescription

HAVE_NOTHING 0 No media data or metadata has been loaded.

HAVE_METADATA 1 The media metadata has been loaded, but no data for the current playback position has been loaded. This means that you can query the duration of the media or the dimensions of a video and you can seek by setting currentTime, but the browser cannot currently play the media at currentTime.

HAVE_CURRENT_DATA 2 Media data for currentTime has been loaded, but not enough data has been loaded to allow the media to play. For video, this typically means that the current frame has loaded, but the next one has not. This state occurs at the end of a sound or movie.

HAVE_FUTURE_DATA 3 Enough media data has been loaded to begin playing, but it is likely not enough to play to the end of the media without pausing to download more data.

HAVE_ENOUGH_DATA 4 Enough media data has been loaded that the browser is likely to be able to play to the end without pausing.

The networkState property specifies whether (or why not) a media element is using the network:

ConstantValueDescription

NETWORK_EMPTY 0 The element has not started using the network. This would be the state before the src attribute was set, for example.

NETWORK_IDLE 1 The element is not currently loading data from the network. It might have loaded the complete resource, or might have buffered all the data it currently needs. Or it might have preload set to「none」and not yet have been asked to load or play the media.

NETWORK_LOADING 2 The element is currently using the network to load media data.

NETWORK_NO_SOURCE 3 The element was not able to find a media source that it is able to play.

When an error occurs in media loading or playback, the browser sets the error property of the <audio> or <video> element. If no error has occurred, error is null. Otherwise, it is an object with a numeric code property that describes the error. The error object also defines constants that describe the possible error codes:

ConstantValueDescription

MEDIA_ERR_ABORTED 1 The user asked the browser to stop loading the media

MEDIA_ERR_NETWORK 2 The media is of the right type, but a network error prevented it from being loaded.

MEDIA_ERR_DECODE 3 The media is of the right type, but an encoding error prevented it from being decoded and played.

MEDIA_ERR_SRC_NOT_SUPPORTED 4 The media specified by the src attribute is not a type that the browser can play.

You might use the error property with code like this:

if (song.error.code == song.error.MEDIA_ERR_DECODE) alert("Can't play song: corrupt audio data.");

Media Events

<audio> and <video> are fairly complex elements—they must respond to user interaction with their playback controls, to network activity, and even, during playback, to the simple passage of time—and we’ve just seen that these elements have quite a few properties that define their current state. Like most HTML elements, <audio> and <video> fire events whenever their state changes. Because these elements have such a complicated state, they can fire quite a few events.

The table below summarizes the 22 media events, loosely in the order in which they are likely to occur. There are no event registration properties for these events. Use the addEventListener() method of the <audio> or <video> element to register handler functions.

Event TypeDescription

loadstart Triggered when the element begins requesting media data. networkState is NETWORK_LOADING.

progress Network activity is continuing to load media data. networkState is NETWORK_LOADING. Typically fired between 2 and 8 times per second.

loadedmetadata The media metadata has been loaded, and the duration and dimensions of the media are ready. readyState has changed to HAVE_METADATA for the first time.

loadeddata Data for the current playback position has loaded for the first time, and readyState has changed to HAVE_CURRENT_DATA.

canplay Enough media data has loaded that playback can begin, but additional buffering is likely to be required. readyState is HAVE_FUTURE_DATA .

canplaythrough Enough media data has loaded that the media can probably be played all the way through without pausing to buffer more data. readyState is HAVE_ENOUGH_DATA .

suspend The element has buffered enough data and has temporarily stopped downloading. networkState has changed to NETWORK_IDLE.

stalled The element is trying to load data, but no data is arriving. networkState remains at NETWORK_LOADING.

play The play() method has been invoked, or the autoplay attribute has caused the equivalent. If sufficient data has loaded, this event will be followed by a playing event. Otherwise a waiting event will follow.

waiting Playback cannot begin, or playback has stopped, because there is not enough data buffered. A playing event will follow when enough data is ready.

playing The media has begun to play.

timeupdate The currentTime property has changed. During normal playback, this event is fired between 4 and 60 times per second, possibly depending on system load and how long the event handlers are taking to complete.

pause The pause() method was called and playback has been paused.

seeking The script or user has requested that playback skip to an unbuffered portion of the media and playback has stopped while data loads. The seeking property is true.

seeked The seeking property has changed back to false.

ended Playback has stopped because the end of the media has been reached.

durationchange The duration property has changed

volumechange The volume or muted property has changed.

ratechange The playbackRate or defaultPlaybackRate has changed.

abort The element has stopped loading data, typically at the user’s request. error.code is MEDIA_ERR_ABORTED.

error A network or other error prevented media data from being loaded. error.code is a value other than MEDIA_ERR_ABORTED.

emptied An error or abort has caused the networkState to return to NETWORK_EMPTY.

SVG: Scalable Vector Graphics

SVG is an XML grammar for graphics. The word「vector」in its name indicates that it is fundamentally different from raster image formats, such as GIF, JPEG, and PNG, that specify a matrix of pixel values. Instead, an SVG「image」is a precise, resolution-independent (hence「scalable」) description of the steps necessary to draw the desired graphic. Here is what a simple SVG file looks like:

<!-- Begin an SVG figure and declare our namespace --> <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"> <!-- Coordinate system for figure --> <defs> <!-- Set up some definitions we'll use --> <linearGradient id="fade"> <!-- a color gradient named "fade" --> <stop offset="0%" stop-color="#008"/> <!-- Start a dark blue --> <stop offset="100%" stop-color="#ccf"/> <!-- Fade to light blue --> </linearGradient> </defs> <!-- Draw a rectangle with a thick black border and fill it with the fade --> <rect x="100" y="200" width="800" height="600" stroke="black" stroke-width="25" fill="url(#fade)"/> </svg>

Figure 21-1 shows what this SVG file looks like when rendered graphically.

SVG is a large and moderately complex grammar. In addition to simple shape-drawing primitives, it includes support for arbitrary curves, text, and animation. SVG graphics can even incorporate JavaScript scripts and CSS stylesheets to add behavior and presentation information. This section shows how client-side JavaScript code (embedded in HTML, not in SVG) can dynamically draw graphics using SVG. It includes examples of SVG drawing but can only scratch the surface of what is possible with SVG. Full details about SVG are available in the comprehensive, but quite readable, specification. The specification is maintained by the W3C at http://www.w3.org/TR/SVG/. Note that the specification includes a complete Document Object Model for SVG documents. This section manipulates SVG graphics using the standard XML DOM and does not use the SVG DOM at all.

At the time of this writing, all current browsers except IE support SVG (and IE9 will support it). In the latest browsers, you can display SVG images using an ordinary <img> element. Some slightly older browsers (such as Firefox 3.6) do not support this and require the use of an <object> element:

<object data="sample.svg" type="image/svg+xml" width="100" height="100"/>

Figure 21-1. A simple SVG graphic

When used with an <img> or <object> element, SVG is just another image format, and it is not particularly interesting to JavaScript programmers. It is more useful to embed SVG images directly within your documents, so they can be scripted. Since SVG is an XML grammar, you can embed it within XHTML documents like this:

<?xml version="1.0"?> <html xmlns="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg"> <!-- declare HTML as default namespace and SVG with "svg:" prefix --> <body> This is a red square: <svg:svg width="10" height="10"> <svg:rect x="0" y="0" width="10" height="10" fill="red"/> </svg:svg> This is a blue circle: <svg:svg width="10" height="10"> <svg:circle cx="5" cy="5" r="5" fill="blue"/> </svg:svg> </body> </html>

This technique works in all current browsers except IE. Figure 21-2 shows how Firefox renders this XHTML document.

Figure 21-2. SVG graphics in an XHTML document

HTML5 minimizes the distinction between XML and HTML and allows SVG (and MathML) markup to appear directly in HTML files, without namespace declarations or tag prefixes:

<!DOCTYPE html> <html> <body> This is a red square: <svg width="10" height="10"> <rect x="0" y="0" width="10" height="10" fill="red"/> </svg> This is a blue circle: <svg width="10" height="10"> <circle cx="5" cy="5" r="5" fill="blue"/> </svg> </body> </html>

At the time of this writing, direct embedding of SVG into HTML works only in the very newest browsers.

Since SVG is an XML grammar, drawing SVG graphics is simply a matter of using the DOM to create appropriate XML elements. Example 21-2 is a listing of a pieChart() function that creates the SVG elements to produce the pie chart shown in Figure 21-3.

Figure 21-3. An SVG pie chart built with JavaScript

Example 21-2. Drawing a pie chart with JavaScript and SVG

/** * Create an <svg> element and draw a pie chart into it. * Arguments: * data: an array of numbers to chart, one for each wedge of the pie. * width,height: the size of the SVG graphic, in pixels * cx, cy, r: the center and radius of the pie * colors: an array of HTML color strings, one for each wedge * labels: an array of labels to appear in the legend, one for each wedge * lx, ly: the upper-left corner of the chart legend * Returns: * An <svg> element that holds the pie chart. * The caller must insert the returned element into the document. */ function pieChart(data, width, height, cx, cy, r, colors, labels, lx, ly) { // This is the XML namespace for svg elements var svgns = "http://www.w3.org/2000/svg"; // Create the <svg> element, and specify pixel size and user coordinates var chart = document.createElementNS(svgns, "svg:svg"); chart.setAttribute("width", width); chart.setAttribute("height", height); chart.setAttribute("viewBox", "0 0 " + width + " " + height); // Add up the data values so we know how big the pie is var total = 0; for(var i = 0; i < data.length; i++) total += data[i]; // Now figure out how big each slice of pie is. Angles in radians. var angles = [] for(var i = 0; i < data.length; i++) angles[i] = data[i]/total*Math.PI*2; // Loop through each slice of pie. startangle = 0; for(var i = 0; i < data.length; i++) { // This is where the wedge ends var endangle = startangle + angles[i]; // Compute the two points where our wedge intersects the circle // These formulas are chosen so that an angle of 0 is at 12 o'clock // and positive angles increase clockwise. var x1 = cx + r * Math.sin(startangle); var y1 = cy - r * Math.cos(startangle); var x2 = cx + r * Math.sin(endangle); var y2 = cy - r * Math.cos(endangle); // This is a flag for angles larger than than a half circle // It is required by the SVG arc drawing component var big = 0; if (endangle - startangle > Math.PI) big = 1; // We describe a wedge with an <svg:path> element // Notice that we create this with createElementNS() var path = document.createElementNS(svgns, "path"); // This string holds the path details var d = "M " + cx + "," + cy + // Start at circle center " L " + x1 + "," + y1 + // Draw line to (x1,y1) " A " + r + "," + r + // Draw an arc of radius r " 0 " + big + " 1 " + // Arc details... x2 + "," + y2 + // Arc goes to to (x2,y2) " Z"; // Close path back to (cx,cy) // Now set attributes on the <svg:path> element path.setAttribute("d", d); // Set this path path.setAttribute("fill", colors[i]); // Set wedge color path.setAttribute("stroke", "black"); // Outline wedge in black path.setAttribute("stroke-width", "2"); // 2 units thick chart.appendChild(path); // Add wedge to chart // The next wedge begins where this one ends startangle = endangle; // Now draw a little matching square for the key var icon = document.createElementNS(svgns, "rect"); icon.setAttribute("x", lx); // Position the square icon.setAttribute("y", ly + 30*i); icon.setAttribute("width", 20); // Size the square icon.setAttribute("height", 20); icon.setAttribute("fill", colors[i]); // Same fill color as wedge icon.setAttribute("stroke", "black"); // Same outline, too. icon.setAttribute("stroke-width", "2"); chart.appendChild(icon); // Add to the chart // And add a label to the right of the rectangle var label = document.createElementNS(svgns, "text"); label.setAttribute("x", lx + 30); // Position the text label.setAttribute("y", ly + 30*i + 18); // Text style attributes could also be set via CSS label.setAttribute("font-family", "sans-serif"); label.setAttribute("font-size", "16"); // Add a DOM text node to the <svg:text> element label.appendChild(document.createTextNode(labels[i])); chart.appendChild(label); // Add text to the chart } return chart; }

The code in Example 21-2 is relatively straightforward. There is a little math to convert the data being charted into pie-wedge angles. The bulk of the example, however, is DOM code that creates SVG elements and sets attributes on those elements. In order to work with browsers that do not fully support HTML5, this example treats SVG as an XML grammar and uses the SVG namespace and the DOM method create ElementNS() instead of createElement().

The most opaque part of this example is the code that draws the actual pie wedges. The element used to display each wedge is <svg:path>. This SVG element describes arbitrary shapes comprised of lines and curves. The shape description is specified by the d attribute of the <svg:path> element. The value of this attribute uses a compact grammar of letter codes and numbers that specify coordinates, angles, and other values. The letter M, for example, means「move to」and is followed by X and Y coordinates. The letter L means「line to」and draws a line from the current point to the coordinates that follow it. This example also uses the letter A to draw an arc. This letter is followed by seven numbers describing the arc. The precise details are not important here, but you can look them up in the specification at http://www.w3.org/TR/SVG/.

Note that the pieChart() function returns an <svg> element that contains a description of the pie chart, but it does not insert that element into the document. The caller is expected to do that. The pie chart in Figure 21-3 was created using a file like this:

<html> <head> <script src="PieChart.js"></script> </head> <body onload="document.body.appendChild( pieChart([12, 23, 34, 45], 640, 400, 200, 200, 150, ['red','blue','yellow','green'], ['North','South', 'East', 'West'], 400, 100)); "> </body> </html>

Example 21-3 is another scripted SVG example: it uses SVG to display an analog clock. (See Figure 21-4.) Rather than dynamically building the tree of SVG elements from scratch, however, it starts with a static SVG image of a clock embedded in the HTML page. This static graphic includes two SVG <line> elements that represent the hour hand and the minute hand. Both lines point straight up, and the static image displays the time 12:00. To turn this image into a functioning clock, we use JavaScript to set a transform attribute on each of <line> elements, rotating them by the appropriate angles so that the clock displays the current time.

Figure 21-4. An SVG clock

Note that Example 21-3 embeds SVG markup directly into an HTML5 file and does not use XML namespaces within an XHTML file. This means that as shown here it will work only with browsers that support direct embedding of SVG. By converting the HTML file to XHTML, however, this same technique works in older SVG-capable browsers.

Example 21-3. Displaying the time by manipulating an SVG image

<!DOCTYPE HTML> <html> <head> <title>Analog Clock</title> <script> function updateTime() { // Update the SVG clock graphic to show current time var now = new Date(); // Current time var min = now.getMinutes(); // Minutes var hour = (now.getHours() % 12) + min/60; // Fractional hours var minangle = min*6; // 6 degrees per minute var hourangle = hour*30; // 30 degrees per hour // Get SVG elements for the hands of the clock var minhand = document.getElementById("minutehand"); var hourhand = document.getElementById("hourhand"); // Set an SVG attribute on them to move them around the clock face minhand.setAttribute("transform", "rotate(" + minangle + ",50,50)"); hourhand.setAttribute("transform", "rotate(" + hourangle + ",50,50)"); // Update the clock again in 1 minute setTimeout(updateTime, 60000); } </script> <style> /* These CSS styles all apply to the SVG elements defined below */ #clock { /* styles for everything in the clock */ stroke: black; /* black lines */ stroke-linecap: round; /* with rounded ends */ fill: #eef; /* on a light blue gray background */ } #face { stroke-width: 3px;} /* clock face outline */ #ticks { stroke-width: 2; } /* lines that mark each hour */ #hourhand {stroke-width: 5px;} /* wide hour hand */ #minutehand {stroke-width: 3px;} /* narrow minute hand */ #numbers { /* how to draw the numbers */ font-family: sans-serif; font-size: 7pt; font-weight: bold; text-anchor: middle; stroke: none; fill: black; } </style> </head> <body onload="updateTime()"> <!-- viewBox is coordinate system, width and height are on-screen size --> <svg id="clock" viewBox="0 0 100 100" width="500" height="500"> <defs> <!-- Define a filter for drop-shadows --> <filter id="shadow" x="-50%" y="-50%" width="200%" height="200%"> <feGaussianBlur in="SourceAlpha" stdDeviation="1" result="blur" /> <feOffset in="blur" dx="1" dy="1" result="shadow" /> <feMerge> <feMergeNode in="SourceGraphic"/><feMergeNode in="shadow"/> </feMerge> </filter> </defs> <circle id="face" cx="50" cy="50" r="45"/> <!-- the clock face --> <g id="ticks"> <!-- 12 hour tick marks --> <line x1='50' y1='5.000' x2='50.00' y2='10.00'/> <line x1='72.50' y1='11.03' x2='70.00' y2='15.36'/> <line x1='88.97' y1='27.50' x2='84.64' y2='30.00'/> <line x1='95.00' y1='50.00' x2='90.00' y2='50.00'/> <line x1='88.97' y1='72.50' x2='84.64' y2='70.00'/> <line x1='72.50' y1='88.97' x2='70.00' y2='84.64'/> <line x1='50.00' y1='95.00' x2='50.00' y2='90.00'/> <line x1='27.50' y1='88.97' x2='30.00' y2='84.64'/> <line x1='11.03' y1='72.50' x2='15.36' y2='70.00'/> <line x1='5.000' y1='50.00' x2='10.00' y2='50.00'/> <line x1='11.03' y1='27.50' x2='15.36' y2='30.00'/> <line x1='27.50' y1='11.03' x2='30.00' y2='15.36'/> </g> <g id="numbers"> <!-- Number the cardinal directions--> <text x="50" y="18">12</text><text x="85" y="53">3</text> <text x="50" y="88">6</text><text x="15" y="53">9</text> </g> <!-- Draw hands pointing straight up. We rotate them in the code. --> <g id="hands" filter="url(#shadow)"> <!-- Add shadows to the hands --> <line id="hourhand" x1="50" y1="50" x2="50" y2="24"/> <line id="minutehand" x1="50" y1="50" x2="50" y2="20"/> </g> </svg> </body> </html>

Graphics in a <canvas>

The <canvas> element has no appearance of its own but creates a drawing surface within the document and exposes a powerful drawing API to client-side JavaScript. The canvas element is standardized by HTML5 but has been around for longer than that. It was introduced by Apple in Safari 1.3, and it has been supported by Firefox since version 1.5 and Opera since version 9. It is also supported in all versions of Chrome. The <canvas> element is not supported by IE before IE9, but it can be reasonably well emulated in IE6, 7, and 8 using the open source ExplorerCanvas project at http://code.google.com/p/explorercanvas/.

An important difference between the <canvas> element and SVG is that with the canvas you create drawings by calling methods and with SVG you create drawings by building a tree of XML elements. These two approaches are equivalently powerful: either one can be simulated with the other. On the surface, they are quite different, however, and each has its strengths and weaknesses. An SVG drawing, for example, is easily edited by removing elements from its description. To remove an element from the same graphic in a <canvas>, it is often necessary to erase the drawing and redraw it from scratch. Since the Canvas drawing API is JavaScript-based and relatively compact (unlike the SVG grammar), it is documented completely in this book. See Canvas, CanvasRenderingContext2D, and related entries in the client-side reference section.

Most of the Canvas drawing API is defined not on the <canvas> element itself, but instead on a「drawing context」object obtained with the getContext() method of the canvas. Call getContext() with the argument「2d」to obtain a CanvasRenderingContext2D object that you can use to draw two-dimensional graphics into the canvas. It is important to understand that the canvas element and its context object are two very different objects. Because it has such a long class name, I do not often refer to the CanvasRenderingContext2D object by name, instead simply calling it the「context object」. Similarly, when I write about the「Canvas API,」I usually mean「the methods of the CanvasRenderingContext2D object.」

3D Graphics in a Canvas

At the time of this writing, browser vendors are starting to implement a 3D graphics API for the <canvas> element. The API is known as WebGL, and it is a JavaScript binding to the OpenGL standard API. To obtain a context object for 3D graphics, pass the string「webgl」to the getContext() method of the canvas. WebGL is a large, complicated, and low-level API that is not documented in this book: web developers are more likely to use utility libraries built on top of WebGL than to use the WebGL API directly.

As a simple example of the Canvas API, the following code draws a red square and blue circle into <canvas> elements to produce output like the SVG graphics shown in Figure 21-2 :

<body> This is a red square: <canvas id="square" width=10 height=10></canvas>. This is a blue circle: <canvas id="circle" width=10 height=10></canvas>. <script> var canvas = document.getElementById("square"); // Get first canvas element var context = canvas.getContext("2d"); // Get 2D drawing context context.fillStyle = "#f00"; // Set fill color to red context.fillRect(0,0,10,10); // Fill a square canvas = document.getElementById("circle"); // Second canvas element context = canvas.getContext("2d"); // Get its context context.beginPath(); // Begin a new "path" context.arc(5, 5, 5, 0, 2*Math.PI, true); // Add a circle to the path context.fillStyle = "#00f"; // Set blue fill color context.fill(); // Fill the path </script> </body>

We’ve seen that SVG describes complex shapes as a「path」of lines and curves that can be drawn or filled. The Canvas API also uses the notion of a path. Instead of describing a path as a string of letters and numbers, a path is defined by a series of method calls, such as the beginPath() and arc() invocations in the code above. Once a path is defined, other methods, such as fill(), operate on that path. Various properties of the context object, such as fillStyle, specify how these operations are performed. The subsections that follow explain:

How to define paths, how to draw or「stroke」the outline of a path, and how to fill the interior of a path.

How to set and query the graphics attributes of the canvas context object, and how to save and restore the current state of those attributes.

Canvas dimensions, the default canvas coordinate system, and how to transform that coordinate system.

The various curve-drawing methods defined by the Canvas API.

Some special-purpose utility methods for drawing rectangles.

How to specify colors, work with transparency, and draw with color gradients and repeating image patterns.

The attributes that control line width and the appearance of line endpoints and vertexes.

How to draw text in a <canvas>.

How to「clip」graphics so that no drawing is done outside of a region you specify.

How to add drop shadows to your graphics.

How to draw (and optionally scale) images into a canvas, and how to extract the contents of a canvas as an image.

How to control the compositing process by which newly drawn (translucent) pixels are combined with the existing pixels in the canvas.

How to query and set the raw red, green, blue, and alpha (transparency) values of the pixels in the canvas.

How to determine whether a mouse event occurred above something you’ve drawn in a canvas.

The section ends with a practical example that uses <canvas> elements to render small inline charts known as sparklines.

Much of the <canvas> example code that follows operates on a variable c. This variable holds the CanvasRenderingContext2D object of the canvas, but the code to initialize that variable is not typically shown. In order to make these examples run, you would need to add HTML markup to define a canvas with appropriate width and height attributes, and then add code like this to initialize the variable c:

var canvas = document.getElementById("my_canvas_id"); var c = canvas.getContext('2d');

The figures that follow were all generated by JavaScript code drawing into a <canvas> element—typically into a large offscreen canvas to produce high-resolution print-quality graphics.

Drawing Lines and Filling Polygons

To draw lines on a canvas and to fill the areas enclosed by those lines, you begin by defining a path. A path is a sequence of one or more subpaths. A subpath is a sequence of two or more points connected by line segments (or, as we’ll see later, by curve segments). Begin a new path with the beginPath() method. Begin a new subpath with the moveTo() method. Once you have established the starting point of a subpath with moveTo(), you can connect that point to a new point with a straight line by calling lineTo(). The following code defines a path that includes two line segments:

c.beginPath(); // Start a new path c.moveTo(100, 100); // Begin a subpath at (100,100) c.lineTo(200, 200); // Add a line from (100,100) to (200,200) c.lineTo(100, 200); // Add a line from (200,200) to (100,200)

The code above simply defines a path; it does not draw anything on the canvas. To draw (or「stroke」) the two line segments in the path, call the stroke() method, and to fill the area defined by those line segments, call fill():

c.fill(); // Fill a triangular area c.stroke(); // Stroke two sides of the triangle

The code above (along with some additional code to set line widths and fill colors) produced the drawing shown in Figure 21-5.

Figure 21-5. A simple path, filled and stroked

Notice that the subpath defined above is「open」. It consists of just two line segments and the end point is not connected back to the starting point. This means that it does not enclose a region. The fill() method fills open subpaths by acting as if a straight line connected the last point in the subpath to the first point in the subpath. That is why the code above fills a triangle, but strokes only two sides of the triangle.

If you wanted to stroke all three sides of the triangle above, you would call the closePath() method to connect the end point of the subpath to the start point. (You could also call lineTo(100,100), but then you end up with three line segments that share a start and end point but are not truly closed. When drawing with wide lines, the visual results are better if you use closePath().)

There are two other important points to notice about stroke() and fill(). First, both methods operate on all subpaths in the current path. Suppose we had added another subpath in the code above:

c.moveTo(300,100); // Begin a new subpath at (300,100); c.lineTo(300,200); // Draw a vertical line down to (300,200);

If we then called stroke(), we would draw two connected edges of a triangle and a disconnected vertical line.

The second point to note about stroke() and fill() is that neither one alters the current path: you can call fill() and the path will still be there when you call stroke(). When you are done with a path and want to begin another, you must remember to call beginPath(). If you don’t, you’ll end up adding new subpaths to the existing path and you may end up drawing those old subpaths over and over again.

Example 21-4 defines a function for drawing regular polygons and demonstrates the use of moveTo(), lineTo(), and closePath() for defining subpaths and of fill() and stroke() for drawing those paths. It produces the drawing shown in Figure 21-6.

Figure 21-6. Regular polygons

Example 21-4. Regular polygons with moveTo(), lineTo() and closePath()

// Define a regular polygon with n sides, centered at (x,y) with radius r. // The vertices are equally spaced along the circumference of a circle. // Put the first vertex straight up or at the specified angle. // Rotate clockwise, unless the last argument is true. function polygon(c,n,x,y,r,angle,counterclockwise) { angle = angle || 0; counterclockwise = counterclockwise || false; c.moveTo(x + r*Math.sin(angle), // Begin a new subpath at the first vertex y - r*Math.cos(angle)); // Use trigonometry to compute position var delta = 2*Math.PI/n; // Angular distance between vertices for(var i = 1; i < n; i++) { // For each of the remaining vertices angle += counterclockwise?-delta:delta; // Adjust angle c.lineTo(x + r*Math.sin(angle), // Add line to next vertex y - r*Math.cos(angle)); } c.closePath(); // Connect last vertex back to the first } // Start a new path and add polygon subpaths c.beginPath(); polygon(c, 3, 50, 70, 50); // Triangle polygon(c, 4, 150, 60, 50, Math.PI/4); // Square polygon(c, 5, 255, 55, 50); // Pentagon polygon(c, 6, 365, 53, 50, Math.PI/6); // Hexagon polygon(c, 4, 365, 53, 20, Math.PI/4, true); // Small square inside the hexagon // Set some properties that control how the graphics will look c.fillStyle = "#ccc"; // Light gray interiors c.strokeStyle = "#008"; // outlined with dark blue lines c.lineWidth = 5; // five pixels wide. // Now draw all the polygons (each in its own subpath) with these calls c.fill(); // Fill the shapes c.stroke(); // And stroke their outlines

Notice that this example draws a hexagon with a square inside it. The square and the hexagon are separate subpaths, but they overlap. When this happens (or when a single subpath intersects itself), the canvas needs to be able to determine which regions are inside the path and which are outside. The canvas uses a test known as the「nonzero winding rule」to achieve this. In this case, the interior of the square is not filled because the square and the hexagon were drawn in the opposite directions: the vertexes of the hexagon were connected with line segments moving clockwise around the circle. The vertexes of the square were connected counterclockwise. Had the square been drawn clockwise as well, the call to fill() would have filled the interior of the square as well.

The Nonzero Winding Rule

To test whether a point P is inside a path, using the nonzero winding rule, imagine a ray drawn from P, in any direction, off to infinity (or, more practically, to some point outside of the path’s bounding box). Now initialize a counter to zero and enumerate all places where the path crosses the ray. Each time the path crosses the ray in a clockwise direction, add one to the count. Each time the path crosses the ray counterclockwise, subtract one from the count. If, after all crossings have been enumerated, the count is nonzero, the point P is inside the path. If, on the other hand, the count is zero, P is outside the path.

Graphics Attributes

Example 21-4 set the properties fillStyle, strokeStyle, and lineWidth on the context object of the canvas. These properties are graphics attributes that specify the color to be used by fill(), the color to be used by stroke(), and the width of the lines to be drawn by stroke(). Notice that these parameters are not passed to the fill() and stroke() methods, but are instead part of the general graphics state of the canvas. If you define a method that draws a shape and do not set these properties yourself, the caller of your method can define the color of the shape by setting the strokeStyle and fillStyle properties before calling your method. This separation of graphics state from drawing commands is fundamental to the Canvas API and is akin to the separation of presentation from content achieved by applying CSS stylesheets to HTML documents.

The Canvas API defines 15 graphics attribute properties on the CanvasRenderingContext2D object. These properties are listed in Table 21-1 and explained in detail in the relevant sections below.

Table 21-1. Graphics attributes of the Canvas API

PropertyMeaning

fillStyle the color, gradient, or pattern for fills

font the CSS font for text-drawing commands

globalAlpha transparency to be added to all pixels drawn

globalCompositeOperation how to combine new pixels with the ones underneath

lineCap how the ends of lines are rendered

lineJoin how vertexes are rendered

lineWidth the width of stroked lines

miterLimit maximum length of acute mitered vertexes

textAlign horizontal alignment of text

textBaseline vertical alignment of text

shadowBlur how crisp or fuzzy shadows are

shadowColor the color of drop shadows

shadowOffsetX the horizontal offset of shadows

shadowOffsetY the vertical offset of shadows

strokeStyle the color, gradient, or pattern for lines

Since the Canvas API defines graphics attributes on the context object, you might be tempted to call getContext() multiple times to obtain multiple context objects. If you could do this, you could define different attributes on each context: each context would then be like a different brush and would paint with a different color or draw lines of different widths. Unfortunately, you cannot use the canvas in this way. Each <canvas> element has only a single context object, and every call to getContext() returns the same CanvasRenderingContext2D object.

Although the Canvas API only allows you to define a single set of graphics attributes at a time, it does allow you to save the current graphics state so that you can alter it and then easily restore it later. The save() method pushes the current graphics state onto a stack of saved states. The restore() method pops the stack and restores the most recently saved state. All of the properties listed in Table 21-1 are part of the saved state, as are the current transformation and clipping region (both are explained below). Importantly, the currently defined path and the current point are not part of the graphics state and cannot be saved and restored.

If you need more flexibility than a simple stack of graphics states allows, you may find it helpful to define utility methods like the ones shown in Example 21-5.

Example 21-5. Graphics state management utilities

// Revert to the last saved graphics state, but don't pop the stack. CanvasRenderingContext2D.prototype.revert = function() { this.restore(); // Restore the old graphics state. this.save(); // Save it again so we can go back to it. return this; // Allow method chaining. }; // Set the graphics attributes specified by the properties of the object o. // Or, if no argument is passed, return the current attributes as an object. // Note that this does not handle the transformation or clipping region. CanvasRenderingContext2D.prototype.attrs = function(o) { if (o) { for(var a in o) // For each property in o this[a] = o[a]; // Set it as a graphics attribute return this; // Enable method chaining } else return { fillStyle: this.fillStyle, font: this.font, globalAlpha: this.globalAlpha, globalCompositeOperation: this.globalCompositeOperation, lineCap: this.lineCap, lineJoin: this.lineJoin, lineWidth: this.lineWidth, miterLimit: this.miterLimit, textAlign: this.textAlign, textBaseline: this.textBaseline, shadowBlur: this.shadowBlur, shadowColor: this.shadowColor, shadowOffsetX: this.shadowOffsetX, shadowOffsetY: this.shadowOffsetY, strokeStyle: this.strokeStyle }; };

Canvas Dimensions and Coordinates

The width and height attributes of the <canvas> element and the corresponding width and height properties of the Canvas object specify the dimensions of the canvas. The default canvas coordinate system places the origin (0,0) at the upper left corner of the canvas. X coordinates increase to the right and Y coordinates increase as you go down the screen. Points on the canvas can be specified using floating-point values, and these are not automatically rounded to integers—the Canvas uses anti-aliasing techniques to simulate partially filled pixels.

The dimensions of a canvas are so fundamental that they cannot be altered without completely resetting the canvas. Setting either the width or height properties of a Canvas (even setting them to their current value) clears the canvas, erases the current path, and resets all graphics attributes (including current transformation and clipping region) to their original state.

Despite this fundamental importance of canvas dimensions, they do not necessarily match either the on-screen size of the canvas or the number of pixels that make up the canvas drawing surface. Canvas dimensions (and also the default coordinate system) are measured in CSS pixels. CSS pixels are usually the same thing as regular pixels. On high-resolution displays, however, implementations are allowed to map multiple device pixels to single CSS pixels. This means that the rectangle of pixels that the canvas draws into may be larger than the canvas’s nominal dimensions. You need to be aware of this when working with the pixel-manipulation features (see Pixel Manipulation) of the canvas, but the distinction between virtual CSS pixels and actual hardware pixels does not otherwise have any effect on the canvas code you write.

By default, a <canvas> is displayed on-screen at the size (in CSS pixels) specified by its HTML width and height attributes. Like any HTML element, however, a <canvas> element can have its on-screen size specified by CSS width and height style attributes. If you specify an on-screen size that is different than the actual dimensions of the canvas, the pixels of the canvas are automatically scaled as needed to fit the screen dimensions specified by the CSS attributes. The on-screen size of the canvas does not affect the number of CSS or hardware pixels reserved in the canvas bitmap and the scaling that is done is an image scaling operation. If the on-screen dimensions are substantially larger than the actual dimensions of the canvas, this results in pixelated graphics. This is an issue for graphic designers and does not affect canvas programming.

Coordinate System Transforms

As noted above, the default coordinate system of a canvas places the origin in the upper left corner, has X coordinates increasing to the right, and has Y coordinates increasing downward. In this default system, the coordinates of a point map directly to a CSS pixel (which then maps directly to one or more device pixels). Certain canvas operations and attributes (such as extracting raw pixel values and setting shadow offsets) always use this default coordinate system. In addition to the default coordinate system, however, every canvas has a「current transformation matrix」as part of its graphics state. This matrix defines the current coordinate system of the canvas. In most canvas operations, when you specify the coordinates of a point, it is taken to be a point in the current coordinate system, not in the default coordinate system. The current transformation matrix is used to convert the coordinates you specified to the equivalent coordinates in the default coordinate system.

The setTransform() method allows you to set a canvas’s transformation matrix directly, but coordinate system transformations are usually easier to specify as a sequence of translations, rotations, and scaling operations. Figure 21-7 illustrates these operations and their effect on the canvas coordinate system. The program that produced the figure drew the same set of axes seven times in a row. The only thing that changed each time was the current transform. Notice that the transforms affect the text as well as the lines that are drawn.

Figure 21-7. Coordinate system transformations

The translate() method simply moves the origin of the coordinate system left, right, up, or down. The rotate() method rotates the axes clockwise by the specified angle. (The Canvas API always specifies angles in radians. To convert degrees to radians, divide by 180 and multiply by Math.PI.) The scale() method stretches or contracts distances along the X or Y axes.

Passing a negative scale factor to the scale() method flips that axis across the origin, as if it were reflected in a mirror. This is what was done in the lower left of Figure 21-7: translate() was used to move the origin to the bottom left corner of the canvas, and then scale() was used to flip the Y axis around so that Y coordinates increase as we go up the page. A flipped coordinate system like this is familiar from algebra class and may be useful for plotting data points on charts. Note, however, that it makes text difficult to read!

Understanding transformations mathematically

I find it easiest to understand transforms geometrically, thinking about translate(), rotate(), and scale() as transforming the axes of the coordinate system as illustrated in Figure 21-7. It is also possible to understand transforms algebraically, as equations that map the coordinates of a point (x,y) in the transformed coordinate system back to the coordinates of the same point (x',y') in the previous coordinate system.

The method call c.translate(dx,dy) can be described with these equations:

x' = x + dx; // An X coordinate of 0 in the new system is dx in the old y' = y + dy;

Scaling operations have similarly simple equations. A call c.scale(sx,sy) can be described like this:

x' = sx * x; y' = sy * y;

Rotations are more complicated. The call c.rotate(a) is described by these trigonometric equations:

x' = x * cos(a) - y * sin(a); y' = y * cos(a) + x * sin(a);

Notice that the order of transformations matters. Suppose we start with the default coordinate system of a canvas, and then translate it, and then scale it. In order to map the point (x,y) in the current coordinate system back to the point (x'',y'') in the default coordinate system, we must first apply the scaling equations to map the point to an intermediate point (x', y') in the translated but unscaled coordinate system, and then use the translation equations to map from this intermediate point to (x'',y''). The result is this:

x'' = sx*x + dx; y'' = sy*y + dy;

If, on the other hand, we’d called scale() before calling translate(), the resulting equations would be different:

x'' = sx*(x + dx); y'' = sy*(y + dy);

The key thing to remember when thinking algebraically about sequences of transformations is that you must work backward from the last (most recent) transformation to the first. When thinking geometrically about transformed axes, however, you work forward from first transformation to last.

The transformations supported by the canvas are known as affine transforms. Affine transforms may modify the distances between points and the angles between lines, but parallel lines always remain parallel after an affine transformation—it is not possible, for example, to specify a fish-eye lens distortion with an affine transform. An arbitrary affine transform can be described by the six parameters a through f in these equations:

x' = ax + cy + e y' = bx + dy + f

You can apply an arbitrary transformation to the current coordinate system by passing those six parameters to the transform() method. Figure 21-7 illustrates two types of transformations—shears and rotations about a specified point—that you can implement with the transform() method like this:

// Shear transform: // x' = x + kx*y; // y' = y + ky*x; function shear(c,kx,ky) { c.transform(1, ky, kx, 1, 0, 0); } // Rotate theta radians clockwise around the point (x,y) // This can also be accomplished with a translate,rotate,translate sequence function rotateAbout(c,theta,x,y) { var ct = Math.cos(theta), st = Math.sin(theta); c.transform(ct, -st, st, ct, -x*ct-y*st+x, x*st-y*ct+y); }

The setTransform() method takes the same arguments as transform(), but instead of transforming the current coordinate system, it ignores the current system, transforms the default coordinate system, and makes the result the new current coordinate system. setTransform() is useful to temporarily reset the canvas to its default coordinate system:

c.save(); // Save current coordinate system c.setTransform(1,0,0,1,0,0); // Revert to the default coordinate system // Perform operations using default CSS pixel coordinates c.restore(); // Restore the saved coordinate system

Transformation example

Example 21-6 demonstrates the power of coordinate system transformations by using the translate(), rotate(), and scale() methods recursively to draw a Koch snowflake fractal. The output of this example appears in Figure 21-8, which shows Koch snowflakes with 0, 1, 2, 3, and 4 levels of recursion.

Figure 21-8. Koch snowflakes

The code that produces these figures is elegant, but its use of recursive coordinate system transformations makes it somewhat difficult to understand. Even if you don’t follow all the nuances, note that the code includes only a single invocation of the lineTo() method. Every single line segment in Figure 21-8 is drawn like this:

c.lineTo(len, 0);

The value of the variable len does not change during the execution of the program, so the position, orientation, and length of each of the line segments is determined by translations, rotations, and scaling operations.

Example 21-6. A Koch snowflake with transformations

var deg = Math.PI/180; // For converting degrees to radians // Draw a level-n Koch Snowflake fractal on the canvas context c, // with lower-left corner at (x,y) and side length len. function snowflake(c, n, x, y, len) { c.save(); // Save current transformation c.translate(x,y); // Translate origin to starting point c.moveTo(0,0); // Begin a new subpath at the new origin leg(n); // Draw the first leg of the snowflake c.rotate(-120*deg); // Now rotate 120 degrees counterclockwise leg(n); // Draw the second leg c.rotate(-120*deg); // Rotate again leg(n); // Draw the final leg c.closePath(); // Close the subpath c.restore(); // And restore original transformation // Draw a single leg of a level-n Koch snowflake. // This function leaves the current point at the end of the leg it has // drawn and translates the coordinate system so the current point is (0,0). // This means you can easily call rotate() after drawing a leg. function leg(n) { c.save(); // Save the current transformation if (n == 0) { // Nonrecursive case: c.lineTo(len, 0); // Just draw a horizontal line } // _ _ else { // Recursive case: draw 4 sub-legs like: \/ c.scale(1/3,1/3); // Sub-legs are 1/3rd the size of this leg leg(n-1); // Recurse for the first sub-leg c.rotate(60*deg); // Turn 60 degrees clockwise leg(n-1); // Second sub-leg c.rotate(-120*deg); // Rotate 120 degrees back leg(n-1); // Third sub-leg c.rotate(60*deg); // Rotate back to our original heading leg(n-1); // Final sub-leg } c.restore(); // Restore the transformation c.translate(len, 0); // But translate to make end of leg (0,0) } } snowflake(c,0,5,115,125); // A level-0 snowflake is an equilateral triangle snowflake(c,1,145,115,125); // A level-1 snowflake is a 6-sided star snowflake(c,2,285,115,125); // etc. snowflake(c,3,425,115,125); snowflake(c,4,565,115,125); // A level-4 snowflake looks like a snowflake! c.stroke(); // Stroke this very complicated path

Drawing and Filling Curves

A path is a sequence of subpaths, and a subpath is a sequence of connected points. In the paths we defined in Drawing Lines and Filling Polygons, those points were connected with straight line segments, but that need not always be the case. The CanvasRenderingContext2D object defines a number of methods that add a new point to the subpath and connect the current point to that new point with a curve:

arc()

This method adds an arc to the current subpath. It connects the current point to the beginning of the arc with a straight line, and then connects the beginning of the arc to the end of the arc with a portion of a circle, leaving the end of the arc as the new current point. The arc to be drawn is specified with six parameters: the X and Y coordinates of the center of a circle, the radius of the circle, the start and end angles of the arc, and the direction (clockwise or counterclockwise) of the arc between those two angles.

arcTo()

This method draws a straight line and a circular arc just like the arc() method does, but it specifies the arc to be drawn using different parameters. The arguments to arcTo() specify points P1 and P2 and a radius. The arc that is added to the path has the specified radius and is tangent to the line between the current point and P1 and also the line between P1 and P2. This unusual-seeming method of specifying arcs is actually quite useful for drawing shapes with rounded corners. If you specify a radius of 0, this method just draws a straight line from the current point to P1. With a nonzero radius, however, it draws a straight line from the current point in the direction of P1 then curves that line around in a circle until it is heading in the direction of P2.

bezierCurveTo()

This method adds a new point P to the subpath and connects it to the current point with a cubic Bezier curve. The shape of the curve is specified by two「control points」C1 and C2. At the start of the curve (at the current point), the curve heads in the direction of C1. At the end of the curve (at point P), the curve arrives from the direction of C2. In between these points the direction of the curve varies smoothly. The point P becomes the new current point for the subpath.

quadraticCurveTo()

