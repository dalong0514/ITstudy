My current code looks like the following. How can I pass my array to the controller and what kind of parameters must my controller action accept?My controller action method looks likeI've found an solution. I use an solution of Steve Gentile, jQuery and ASP.NET MVC – sending JSON to an Action – Revisited.My ASP.NET MVC view code looks like:and my controller action is decorated with an custom attributeCode for the custom attribute can be found here (the link is broken now).Because the link is broken this is the code for the JsonFilterAttributeJsonConvert.DeserializeObject is from Json.NETLink: Serializing and Deserializing JSON with Json.NETAction Filters, jquery stringify, bleh...Peter, this functionality is native to MVC. That's one of things that makes MVC so great.And in the action,Works like a charm:If you're using jQuery 1.4+, then you want to look into setting traditional mode:As described here: http://www.dovetailsoftware.com/blogs/kmiller/archive/2010/02/24/jquery-1-4-breaks-asp-net-mvc-actions-with-array-parametersThis even works for complex objects. If you're interested, you should look into the MVC documentation about Model Binding: http://msdn.microsoft.com/en-us/library/dd410405.aspxIn .NET4.5, MVC 5 no need for widgets.Javascript:object in JS:

mechanism that does post.C#Objects: Controller:Object received:Hope this saves you some time.Towards the second half of Create REST API using ASP.NET MVC that speaks both JSON and plain XML, to quote:He then implements an action filter that maps the JSON to C# objects with code shown.First download this JavaScript code, JSON2.js, that will help us serialize the object into a string.In my example I'm posting the rows of a jqGrid via Ajax:Now on the controller:Create a JsonFilter Class (thanks to JSC reference).Create another class so the filter can parse the JSON string to the actual manipulable object: This class comissionsJS are all the rows of my jqGrid.I hope this example helps to illustrate how to post a complex object.Oh my God. not need to do anything special. only in your post section do as follows: In server use this:this link help you to done ...

await is only valid in async function

j.doe

[await is only valid in async function](https://stackoverflow.com/questions/49432579/await-is-only-valid-in-async-function)

I wrote this code in lib/helper.jsand then I tried to use it in another file   I got an error What is the issue?

2018-03-22 15:29:02Z

I wrote this code in lib/helper.jsand then I tried to use it in another file   I got an error What is the issue?The error is not refering to myfunction but to start.I use the opportunity of this question to advise you about an known anti pattern using await which is : return await.WRONGCORRECTWhen I got this error, it turned out I had a call to the map function inside my "async" function, so this error message was actually referring to the map function not being marked as "async".  I got around this issue by taking the "await" call out of the map function and coming up with some other way of getting the expected behavior.The real issue is you need to understand how async/await works here. The error is in your start function().You need to define a function as an async function to use await as await consumes promise / future / task-returning methods / functions and async marks a method / function as capable of using await. await is actually doing the same process of promise / resolve and as the function is async other task is processing in a parallel way.For more info you can refer to MDN DOCS.The current implementation of async / await only supports the await keyword inside of async functions Change your start function signature so you can use await inside start. For those interested, the proposal for top-level await is currently in Stage 2: https://github.com/tc39/proposal-top-level-awaitI had the same problem and the following block of code was giving the same error message:The problem is that the method getCommits() was async but I was passing it the argument repo which was also produced by a Promise. So, I had to add the word async to it like this: async(repo) and it started working:"await is only valid in async function"But why? 'await' explicitly turns an async call into a synchronous call, and therefore the caller cannot be async (or asyncable) - at least, not because of the call being made at 'await'.Yes, await / async was a great concept, but the implementation is completely broken.  For whatever reason, the await keyword has been implemented such that it can only be used within an async method.  This is in fact a bug, though you will not see it referred to as such anywhere but right here.  The fix for this bug would be to implement the await keyword such that it can only be used TO CALL an async function, regardless of whether the calling function is itself synchronous or asynchronous.  Due to this bug, if you use await to call a real asynchronous function somewhere in your code, then ALL of your functions must be marked as async and ALL of your function calls must use await.This essentially means that you must add the overhead of promises to all of the functions in your entire application, most of which are not and never will be asynchronous.If you actually think about it, using await in a function should require the function containing the await keyword TO NOT BE ASYNC - this is because the await keyword is going to pause processing in the function where the await keyword is found.  If processing in that function is paused, then it is definitely NOT asynchronous.So, to the developers of javascript and ECMAScript - please fix the await/async implementation as follows...

getAttribute() versus Element object properties?

P K

[getAttribute() versus Element object properties?](https://stackoverflow.com/questions/10280250/getattribute-versus-element-object-properties)

Expressions like Element.getAttribute("id") and Element.id return the same thing.Which one should be used when we need attributes of an HTMLElement object?Is there any cross browser issue with these methods like getAttribute() and setAttribute()?Or any impact on performance between directly accessing object properties vs using these attribute methods?

2012-04-23 12:09:53Z

Expressions like Element.getAttribute("id") and Element.id return the same thing.Which one should be used when we need attributes of an HTMLElement object?Is there any cross browser issue with these methods like getAttribute() and setAttribute()?Or any impact on performance between directly accessing object properties vs using these attribute methods?getAttribute retrieves the attribute of a DOM element, while el.id retrieves the property of this DOM element. They are not the same.Most of the time, DOM properties are synchronized with attributes.However, the synchronization does not guarantee the same value. A classic example is between el.href and el.getAttribute('href') for an anchor element.For example:This behavior happens because according to the W3C, the href property must be a well-formed link. Most browsers respect this standard (guess who doesn't?).There is another case for the input's checked property. The DOM property returns true or false while the attribute returns the string "checked" or an empty string.And then, there are some properties that are synchronized one-way only. The best example is the value property of an input element. Changing its value through the DOM property will not change the attribute (edit: check the first comment for more precision).Because of these reasons, I'd suggest you keep using the DOM properties, and not the attributes, as their behavior differs between the browsers.In reality, there are only two cases where you need to use the attributes:If you want a more detailed explaination, I strongly suggest you read this page. It will take you a few minutes only, but you will be delighted by the information (which I summed up here).getAttribute('attribute') normally returns the attribute value as a string, exactly as defined in the HTML source of the page.However, element.attribute could return a normalized or calculated value of the attribute. Examples:.id saves the the function call overhead. (which is very small, but you asked. ) According to this jsPerf test getAttribute is more slow than id property.PSOddly enough both statements perform very bad on IE8 (compared to other browsers).Always use the properties unless you have a specific reason not to.There are some exceptions:I've written about this subject a few times on SO:Try below example to understand this completely. For the below DIV<div class="myclass"></div>The Element.getAttribute('class') will return myclass but you have to use Element.className which retrieves it from the DOM property.One area where this makes a big difference is with css styling based on attributes.Consider the following:The div with the custom property set directly doesn't reflect the value to the attribute, and is not selected by our attribute selector (div[custom]) in the css.The div with the custom attribute set using setAttribute, however, is able to be selected using a css attribute selector, and styled accordingly.

Is it safe to delete an object property while iterating over them?

Joe Shaw

[Is it safe to delete an object property while iterating over them?](https://stackoverflow.com/questions/3463048/is-it-safe-to-delete-an-object-property-while-iterating-over-them)

When iterating over an object's properties, is it safe to delete them while in a for-in loop?For example:In many other languages iterating over an array or dictionary and deleting inside that is unsafe.  Is it okay in JS?(I am using Mozilla's Spidermonkey runtime.)

2010-08-11 21:37:25Z

When iterating over an object's properties, is it safe to delete them while in a for-in loop?For example:In many other languages iterating over an array or dictionary and deleting inside that is unsafe.  Is it okay in JS?(I am using Mozilla's Spidermonkey runtime.)The ECMAScript 5.1 standard section 12.6.4 (on for-in loops) says:So I think it's clear that the OP's code is legal and will work as expected. Browser quirks affect iteration order and delete statements in general, but not whether the OPs code will work. It's generally best only to delete the current property in the iteration - deleting other properties in the object will unpredictably cause them to be included (if already visited) or not included in the iteration, although that may or may not be a concern depending on the situation.See also:None of these really affects the OP's code though.From the Javascript/ECMAScript specification (specifically 12.6.4 The for-in Statement):

console.log javascript [Function]

Harry

[console.log javascript [Function]](https://stackoverflow.com/questions/9460826/console-log-javascript-function)

I'm trying to log a function in javascript:I want to see what the function is. Can I do that? Thanks.

2012-02-27 06:20:03Z

I'm trying to log a function in javascript:I want to see what the function is. Can I do that? Thanks.If it's a user defined function you can use:Otherwise you'll just get something like [native code] since built in functions are not written in JavaScript.Example:

Is there a way to select sibling nodes?

codingbear

[Is there a way to select sibling nodes?](https://stackoverflow.com/questions/842336/is-there-a-way-to-select-sibling-nodes)

For some performance reasons, I am trying to find a way to select only sibling nodes of the selected node. For example,If I selected inner1 node, is there a way for me to access its siblings, inner2-4 nodes?

2009-05-09 00:09:02Z

For some performance reasons, I am trying to find a way to select only sibling nodes of the selected node. For example,If I selected inner1 node, is there a way for me to access its siblings, inner2-4 nodes?Well... sure... just access the parent and then the children.or... using jQuery:Edit: Cletus as always is inspiring. I dug further. This is how jQuery gets siblings essentially: This will return the sibling immediately after it, or null no more siblings are available. Likewise, you can use previousSibling.[Edit] On second thought, this will not give the next div tag, but the whitespace after the node. Better seems to beThere also exists a previousElementSibling.Quick:https://codepen.io/anon/pen/LLoyrP?editors=1011Get the parent's children as an array, filter out this element.Edit: And to filter out text nodes (Thanks pmrotule):From 2017:

straightforward answer: element.nextElementSibling for get the right element sibling. also you have element.previousElementSibling for previous onefrom here is pretty simple to got all next sibiling have you checked the "Sibling" method in jQuery?the n.nodeType == 1 check if the element is a html node  and n!== exclude the current element.I think you can use the same function, all that code seems to be vanilla javascript.There are a few ways to do it.Either one of the following should do the trick.FYI: The jQuery code-base is a great resource for observing Grade A Javascript.Here is an excellent tool that reveals the jQuery code-base in a very streamlined way.

http://james.padolsey.com/jquery/Here's how you could get previous, next and all siblings (both sides):Use document.querySelectorAll() and Loops and iterationjQueryNative - latest, Edge13+Native (alternative) - latest, Edge13+Native - IE10+1) Add selected class to target element  2) Find all children of parent element excluding target element  3) Remove class from target elementThe following function will return an array containing all the siblings of the given element.Just pass the selected element into the getSiblings() function as it's only parameter.

Node.js app can't run on port 80 even though there's no other process blocking the port

Brian Yeh

[Node.js app can't run on port 80 even though there's no other process blocking the port](https://stackoverflow.com/questions/18947356/node-js-app-cant-run-on-port-80-even-though-theres-no-other-process-blocking-t)

I'm running an instance of Debian on Amazon EC2 with Node.js installed. If I run the code below:I get the output below which tells me there's another process listening at port 80:Now when I check to see if there's a process (as root in case anything is hidden) listening on port 80 using: I get the below output, which tells me theres nothing listening at port 80: I should note that the debian has port 80 open as an inbound rule if that makes a difference. My question is: What am I doing wrong? How come I can't identify the process listening to port 80? Why is it blocked in Debian? What steps should I take to get the code running correctly?   

2013-09-22 18:31:25Z

I'm running an instance of Debian on Amazon EC2 with Node.js installed. If I run the code below:I get the output below which tells me there's another process listening at port 80:Now when I check to see if there's a process (as root in case anything is hidden) listening on port 80 using: I get the below output, which tells me theres nothing listening at port 80: I should note that the debian has port 80 open as an inbound rule if that makes a difference. My question is: What am I doing wrong? How come I can't identify the process listening to port 80? Why is it blocked in Debian? What steps should I take to get the code running correctly?   The error code EACCES means you don't have proper permissions to run applications on that port. On Linux systems, any port below 1024 requires root access.Instead of running on port 80 you can redirect port 80 to your application's port (>1024) using This will work if your application is running on port 3000.Short answer: You can allow node access to that port using:setcap 'cap_net_bind_service=+ep' /path/to/nodejslong answerEdit:May not work on new node versionsNote that if you have apache running, you can create a reverse proxy on a vhost. If your node is running on port 8080:Of course, add server to /etc/hosts:You will need to enable the relevant apache modules:...and now you can connect to http://myLocalServer.For those looking for a quick and easy solution for a development environment, port forwarding via ssh can be a nice alternative:This forwards port 80 on localhost to port 3000 on localhost.It needs to be run as root (privileged port). To cancel it, simply hit ctrl-c in the terminal. (You can add the -f flag to have the command run in the background, but then you need to find it again to kill it).This solution requires you to have an ssh server running locally. It can be done quickly, but please bear in mind the security implications if you are on a shared network. You might want to apply at least some level of additional security (disable password & root login).I personally only ever use this on my local machine. I'm not sure how it affects the processing speed of your requests if you run this on production, maybe someone has an idea. Anyway, you would need to make sure this command keeps running all the time, which introduces more headaches. For production environments, I suggest using a reverse proxy like nginx.I have got the same error and I tried running my application using sudo and it worked for me.without sudo and with sudoUsing PORT 80 requires some special permissions. Using sudo before running statement of the app solved my problem.

for example, if you are using npm to run your app, you can type sudo npm startThe error code EACCES means you don't have proper permissions to run applications on that port.

On Linux systems, any port below 1024 requires root access.Run the program with sudo permision.

Run sudo su command before running the program.

How to format a phone number with jQuery

Xtian

[How to format a phone number with jQuery](https://stackoverflow.com/questions/8760070/how-to-format-a-phone-number-with-jquery)

I'm currently displaying phone numbers like 2124771000. However, I need the number to be formatted in a more human-readable form, for example: 212-477-1000. Here's my current HTML:

2012-01-06 15:20:07Z

I'm currently displaying phone numbers like 2124771000. However, I need the number to be formatted in a more human-readable form, for example: 212-477-1000. Here's my current HTML:Simple: http://jsfiddle.net/Xxk3F/3/Or: http://jsfiddle.net/Xxk3F/1/Note: The .text() method cannot be used on input elements. For input field text, use the .val() method.Don't forget to ensure you are working with purely integers.Here's a combination of some of these answers. This can be used for input fields. Deals with phone numbers that are 7 and 10 digits long.Live example: JSFiddleI know this doesn't directly answer the question, but when I was looking up answers this was one of the first pages I found. So this answer is for anyone searching for something similar to what I was searching for.Use a library to handle phone number. Libphonenumber by Google is your best bet.I recommend to use this package by seegno.I have provided jsfiddle link for you to format US phone numbers as 

(XXX) XXX-XXXLive example: JSFiddletry something like this..Consider libphonenumber-js (https://github.com/halt-hammerzeit/libphonenumber-js) which is a smaller version of the full and famous libphonenumber. Quick and dirty example:(If you do use a regex to avoid a library download, avoid reformat on backspace/delete will make it easier to correct typos.)An alternative solution:I found this question while googling for a way to auto-format phone numbers via a jQuery plugin. The accepted answer was not ideal for my needs and a lot has happened in the 6 years since it was originally posted. I eventually found the solution and am documenting it here for posterity.ProblemI would like my phone number html input field to auto-format (mask) the value as the user types.SolutionCheck out Cleave.js. It is a very powerful/flexible and easy way to solve this problem, and many other data masking issues.Formatting a phone number is as easy as:Input:Code:OutPut:Output :-(123) 657-8963may be this will helpyou will get +91-123-456-7890

How do I make a textarea an ACE editor?

Paul

[How do I make a textarea an ACE editor?](https://stackoverflow.com/questions/6440439/how-do-i-make-a-textarea-an-ace-editor)

I'd like to be able to convert specific textareas on a page to be ACE editors.Does anyone have any pointers please?EDIT:I have the the editor.html file working with one textarea, but as soon as I add a second, the second isn't converted to an editor.EDIT 2:I decided to scrap the idea of having several, and instead open one up in a new window. My new predicament is that when I hide() and show() the textarea, the display goes awry. Any ideas?

2011-06-22 13:12:47Z

I'd like to be able to convert specific textareas on a page to be ACE editors.Does anyone have any pointers please?EDIT:I have the the editor.html file working with one textarea, but as soon as I add a second, the second isn't converted to an editor.EDIT 2:I decided to scrap the idea of having several, and instead open one up in a new window. My new predicament is that when I hide() and show() the textarea, the display goes awry. Any ideas?As far as I understood the idea of Ace, you shouldn't make a textarea an Ace editor itself. You should create an additional div and update textarea using .getSession() function instead.htmljsor just callonly when you submit the form with the given textarea. I'm not sure whether this is the right way to use Ace, but it's the way it is used on GitHub.Duncansmart has a pretty awesome solution on his github page, progressive-ace which demonstrates one simple way to hook up an ACE editor to your page.Basically we get all <textarea> elements with the data-editor attribute and convert each to an ACE editor.  The example also sets some properties which you should customize to your liking, and demonstrates how you can use data attributes to set properties per element like showing and hiding the gutter with data-gutter.You can have multiple Ace Editors. Just give each textarea an ID and create an Ace Editor for both IDS like so:To create an editor just do:HTML:JS:CSS:They must be explicitly positioned and sized.  By show() and hide() I believe you are referring to the jQuery functions.  I'm not sure exactly how they do it, but it cannot modify the space it takes up in the DOM.  I hide and show using:If you use the css property 'display' it will not work.Check out the wiki here for how to add themes, modes, etc... https://github.com/ajaxorg/ace/wiki/Embedding---APINote: they do not have to be textareas, they can be whatever element you want.For anyone like me that was routed to this page and just wants a minimal, copy-pasteable working example of using Ace using the library from CDN:Yields:

How do I get the width and height of a HTML5 canvas?

clamp

[How do I get the width and height of a HTML5 canvas?](https://stackoverflow.com/questions/4032179/how-do-i-get-the-width-and-height-of-a-html5-canvas)

How can i get the width and height of the canvas element in JavaScript?Also, what is the "context" of the canvas I keep reading about?

2010-10-27 10:24:50Z

How can i get the width and height of the canvas element in JavaScript?Also, what is the "context" of the canvas I keep reading about?It might be worth looking at a tutorial: Firefox Canvas TutorialYou can get the width and height of a canvas element simply by accessing those properties of the element. For example: If the width and height attributes are not present in the canvas element, the default 300x150 size will be returned. To dynamically get the correct width and height use the following code:Or using the shorter object destructuring syntax:The context is an object you get from the canvas to allow you to draw into it. You can think of the context as the API to the canvas, that provides you with the commands that enable you to draw on the canvas element.Well, all the answers before aren't entirely correct. 2 of major browsers don't support those 2 properties (IE is one of them) or use them differently.Better solution (supported by most browsers, but I didn't check Safari):At least I get correct values with scrollWidth and -Height and MUST set canvas.width and height when it is resized.The answers mentioning canvas.width return the internal dimensions of the canvas, i.e. those specified when creating the element:If you size the canvas with CSS, its DOM dimensions are accessible via .scrollWidth and .scrollHeight:The context object allows you to manipulate the canvas; you can draw rectangles for example and a lot more.If you want to get the width and height, you can just use the standard HTML attributes width and height:now starting 2015 all (major?) browsers seem to alow c.width and c.height to get the canvas internal size, but:the question as the answers are missleading, because the a canvas has in principle 2 different/independent sizes.The "html" lets say CSS width/height and its own (attribute-) width/heightlook at this short example of different sizing, where I put a 200/200 canvas into a 300/100 html-element With most examples (all I saw) there is no css-size set, so theese get implizit the width and height of the (drawing-) canvas size. But that is not a must, and can produce funy results, if you take the wrong size - ie. css widht/height for inner positioning. None of those worked for me. Try this.I had a problem because my canvas was inside of a container without ID so I used this jquery code below

Stubbing a class method with Sinon.js

Paul

[Stubbing a class method with Sinon.js](https://stackoverflow.com/questions/21072016/stubbing-a-class-method-with-sinon-js)

I am trying to stub a method using sinon.js but I get the following error:Uncaught TypeError: Attempted to wrap undefined property sample_pressure as functionI also went to this question (Stubbing and/or mocking a class in sinon.js?) and copied and pasted the code but I get the same error. Here is my code:Here is the jsFiddle (http://jsfiddle.net/pebreo/wyg5f/5/) for the above code, and the jsFiddle for the SO question that I mentioned (http://jsfiddle.net/pebreo/9mK5d/1/).I made sure to include sinon in the External Resources in jsFiddle and even jQuery 1.9. What am I doing wrong?

2014-01-12 06:40:43Z

I am trying to stub a method using sinon.js but I get the following error:Uncaught TypeError: Attempted to wrap undefined property sample_pressure as functionI also went to this question (Stubbing and/or mocking a class in sinon.js?) and copied and pasted the code but I get the same error. Here is my code:Here is the jsFiddle (http://jsfiddle.net/pebreo/wyg5f/5/) for the above code, and the jsFiddle for the SO question that I mentioned (http://jsfiddle.net/pebreo/9mK5d/1/).I made sure to include sinon in the External Resources in jsFiddle and even jQuery 1.9. What am I doing wrong?Your code is attempting to stub a function on Sensor, but you have defined the function on Sensor.prototype.is essentially the same as this:but it is smart enough to see that Sensor["sample_pressure"] doesn't exist.So what you would want to do is something like these:ororThe top answer is deprecated. You should now use:Or for static methods:Or for simple cases just use returns:Or if you want to stub a method for an instance:I ran into the same error trying to mock a method of a CoffeeScript class using Sinon.Given a class like this:You can replace its method with a spy this way:Just replace spy with stub or mock as needed.Note that you'll need to replace assert.ok with whatever assertion your testing framework has.Thanks to @loganfsmyth for the tip.  I was able to get the stub to work on an Ember class method like this:

Detecting Unsaved Changes

tbreffni

[Detecting Unsaved Changes](https://stackoverflow.com/questions/155739/detecting-unsaved-changes)

I have a requirement to implement an "Unsaved Changes" prompt in an ASP .Net application.  If a user modifies controls on a web form, and attempts to navigate away before saving, a prompt should appear warning them that they have unsaved changes, and give them the option to cancel and stay on the current page.  The prompt should not display if the user hasn't touched any of the controls.Ideally I'd like to implement this in JavaScript, but before I go down the path of rolling my own code, are there any existing frameworks or recommended design patterns for achieving this?  Ideally I'd like something that can easily be reused across multiple pages with minimal changes.

2008-10-01 00:41:28Z

I have a requirement to implement an "Unsaved Changes" prompt in an ASP .Net application.  If a user modifies controls on a web form, and attempts to navigate away before saving, a prompt should appear warning them that they have unsaved changes, and give them the option to cancel and stay on the current page.  The prompt should not display if the user hasn't touched any of the controls.Ideally I'd like to implement this in JavaScript, but before I go down the path of rolling my own code, are there any existing frameworks or recommended design patterns for achieving this?  Ideally I'd like something that can easily be reused across multiple pages with minimal changes.Using jQuery:Combine with onunload/onbeforeunload methods as required.From the comments, the following references all input fields, without duplicating code:Using $(":input") refers to all input, textarea, select, and button elements.One piece of the puzzle:And another:Wrap it all up, and what do you get?You'll probably also want to change the registration of the beforeunload event handler to use LIBRARY_OF_CHOICE's event registration.In the .aspx page, you need a Javascript function to tell whether or not the form info is "dirty"and in the codebehind, add the triggers to the input fields as well as resets on the submission/cancel buttons....The following uses the browser's onbeforeunload function and jquery to capture any onchange event.  IT also looks for any submit or reset buttons to reset the flag indicating changes have occurred. Thanks for the replies everyone.  I ended up implementing a solution using JQuery and the Protect-Data plug-in.  This allows me to automatically apply monitoring to all controls on a page.There are a few caveats however, especially when dealing with an ASP .Net application:Hopefully this is helpful for anyone else who has to implement something similar.The following solution works for prototype (tested in FF, IE 6 and Safari). It uses a generic form observer (which fires form:changed when any fields of the form have been modified), which you can use for other stuff as well.Here's a javascript / jquery solution that is simple. It accounts for "undos" by the user, it is encapsulated within a function for ease of application, and it doesn't misfire on submit. Just call the function and pass the ID of your form.This function serializes the form once when the page is loaded, and again before the user leaves the page. If the two form states are different, the prompt is shown.Try it out: http://jsfiddle.net/skibulk/Ydt7Y/General Solution Supporting multiple forms in a given page (Just copy and paste in your project)Note: This solution is combined from others' solutions to create a general integrated solution.Features:I recently contributed to an open source jQuery plugin called dirtyForms. The plugin is designed to work with dynamically added HTML, supports multiple forms, can support virtually any dialog framework, falls back to the browser beforeunload dialog, has a pluggable helper framework to support getting dirty status from custom editors (a tinyMCE plugin is included), works within iFrames, and the dirty status can be set or reset at will.https://github.com/snikch/jquery.dirtyformsDetect form changes with using jQuery is very simple:I expanded on Slace's suggestion above, to include most editable elements and also excluding certain elements (with a CSS style called "srSearch" here) from causing the dirty flag to be set.window.onbeforeunload = unloadPage;This is exactly what the Fleegix.js plugin fleegix.form.diff (http://js.fleegix.org/plugins/form/diff) was created for. Serialize the initial state of the form on load using fleegix.form.toObject (http://js.fleegix.org/ref#fleegix.form.toObject) and save it in a variable, then compare with the current state using fleegix.form.diff on unload. Easy as pie.One method, using arrays to hold the variables so changes can be tracked.Here's a very simple method to detect changes, but the rest isn't as elegant.Another method which is fairly simple and small, from Farfetched Blog:In IE document.ready will not work properly it will update the values of input.so we need to bind load event inside the document.ready function that will handle for IE browser also.below is the code you should put inside the document.ready function.

in angularjs how to access the element that triggered the event?

David S.

[in angularjs how to access the element that triggered the event?](https://stackoverflow.com/questions/12994710/in-angularjs-how-to-access-the-element-that-triggered-the-event)

I use both Bootstrap and AngularJS in my web app. I'm having some difficulty getting the two to work together.I have an element, which has the attribute data-provide="typeahead"And I want to update the data-source attribute when the user inputs in the field. The function updateTypeahead is triggered correctly, but I don't have access to the element that triggered the event, unless I use $('#searchText'), which is the jQuery way, not the AngularJS way.What is the best way to get AngularJS to work with old style JS module.

2012-10-21 03:31:05Z

I use both Bootstrap and AngularJS in my web app. I'm having some difficulty getting the two to work together.I have an element, which has the attribute data-provide="typeahead"And I want to update the data-source attribute when the user inputs in the field. The function updateTypeahead is triggered correctly, but I don't have access to the element that triggered the event, unless I use $('#searchText'), which is the jQuery way, not the AngularJS way.What is the best way to get AngularJS to work with old style JS module.will not pass DOM element to the function updateTypeahead(this). Here this will refer to the scope. If you want to access the DOM element use updateTypeahead($event). In the callback function you can get the DOM element by event.target.The general Angular way to get access to an element that triggered an event is to write a directive and bind() to the desired event:or with DDO (as per @tpartee's comment below):The above directive can be used as follows:Plunker.Type into the text field, then leave/blur.  The change callback function will fire.  Inside that callback function, you have access to element.Some built-in directives support passing an $event object.  E.g., ng-*click, ng-Mouse*.  Note that ng-change does not support this event.  Although you can get the element via the $event object:this goes "deep against the Angular way" -- Misko.you can get easily like this first write event on elementand in your js file like belowI have used it as well.There is a solution using $element in the controller if you don't want to create another directive for this problem:And this will work with ng-change:if you wanna ng-model value, if you can write like this in the triggered event:

$scope.searchTextI'm not sure which version you had, but this question was asked for long time ago. Currently with Angular 1.5, I can use the ng-keypress event and debounce function from Lodash to emulate similar behavior like ng-change, so I can capture the $eventTo pass the source element in Angular 5 :

AngularJS ng-repeat with no html element

nehz

[AngularJS ng-repeat with no html element](https://stackoverflow.com/questions/12857714/angularjs-ng-repeat-with-no-html-element)

I am currently using this piece of code to render a list:However, the <div> element is causing some very minor rendering defects on some browsers.

I would like to know is there a way to do the ng-repeat without the div container, or some alternative method to achieve the same effect.

2012-10-12 11:05:30Z

I am currently using this piece of code to render a list:However, the <div> element is causing some very minor rendering defects on some browsers.

I would like to know is there a way to do the ng-repeat without the div container, or some alternative method to achieve the same effect.As Andy Joslin said they were working on comment based ng-repeats but apparently there were too many browser issues. Fortunately AngularJS 1.2 adds built-in support for repeating without adding child elements with the new directives ng-repeat-start and ng-repeat-end.Here's a little example for adding Bootstrap pagination:A full working example can be found here.John Lindquist also has a video tutorial of this over at his excellent egghead.io page.Please bear with me a second: KnockoutJS offers an ultra-convenient option of using a containerless binding syntax for its foreach binding as discussed in Note 4 of the foreach binding documentation.

http://knockoutjs.com/documentation/foreach-binding.htmlAs the Knockout documentation example illustrates, you can write your binding in KnockoutJS like this: I think it is rather unfortunate AngularJS does not offer this type of syntax.In the AngularJS way to solve ng-repeat problems, the samples I come across are of the type jmagnusson posted in his (helpful) answer. My original thought upon seeing this syntax is: really? Why is Angular forcing all this extra markup that I want nothing to do with and that is so much easier in Knockout? But then  hitautodestruct's comment in jmagnusson's answer started making me wonder: what is being generated with ng-repeat-start and ng-repeat-end on separate tags?Upon investigation of hitautodestruct's assertion, adding ng-repeat-end on to a separate tag is exactly what I would not want to do in most cases, because it generates utterly usesless elements: in this case, <li> items with nothing in them. Bootstrap 3's paginated list styles the list items so that it looks like you did not generate any superfluous items, but when you inspect the generated html, they are there. Fortunately, you do not need to do much to have a cleaner solution and a shorter amount of html: just put the ng-repeat-end declaration on the same html tag that has the ng-repeat-start.This gives 3 advantages: After further reviewing the comments in github on this issue for Angular, https://github.com/angular/angular.js/issues/1891,

you do not need to use ng-repeat-start and ng-repeat-end to achieve the same advantages. 

Instead, forking again jmagnusson's example, we can just go: So when to use ng-repeat-start and ng-repeat-end? As per the angular documentation, toFair enough; this jsbin walks through five examples of what happens when you do and when you don't use ng-repeat-end on the same tag.ngRepeat may not be enough, however you can combine that with a custom directive. You could delegate the the task of adding divider items to code if you don't mind a little bit of jQuery.Such a simple directive doesn't really need an attribute value but might give you lots of possiblities like conditionally adding a divider according to index, length, etc or something completely different.I recently had the same problem in that I had to repeat an arbitrary collection of spans and images - having an element around them was not an option - there's a simple solution however, create a "null" directive:You can then use a repeat on that Element, where element.url points to the template for that element:This will repeat any number of different templates with no container around themNote: hmm I could've sworn blind this removed the di-null element when rendering, but checking it again it doesn't...still solved my layout issues though...curioser and curioser...There is a comment directive restriction, but ngRepeat doesn't support it (since it needs an element to repeat).I think I saw the angular team say they would work on comment ng-repeats, but I'm not sure.  You should open an issue for it on the repo.  http://github.com/angular/angular.jsThere is no Angular magic way to do this, for your case you can do this, to get valid HTML, if you are using Bootstrap. Then you will get same effect as adding the li.dividerCreate a class:Now change your code to this:for a solution that really workshtmladd an angular.js directivefor a brief explanation, ng-repeat binds itself to the <remove> element and loops as it should, and because we have used ng-repeat-start / ng-repeat-end it loops a block of html not just an element.then the custom remove directive places the <remove> start and finish elements with <!--removed element-->

JavaScript - string regex backreferences

quano

[JavaScript - string regex backreferences](https://stackoverflow.com/questions/2447915/javascript-string-regex-backreferences)

You can backreference like this in JavaScript:This would (quite silly) replace "$test" with "test". But imagine I'd like to pass the resulting string of $2 into a function, which returns another value. I tried doing this, but instead of getting the string "test", I get "$2". Is there a way to achieve this?

2010-03-15 14:44:32Z

You can backreference like this in JavaScript:This would (quite silly) replace "$test" with "test". But imagine I'd like to pass the resulting string of $2 into a function, which returns another value. I tried doing this, but instead of getting the string "test", I get "$2". Is there a way to achieve this?Like this:Pass a function as the second argument to replace:This capability has been around since Javascript 1.3, according to mozilla.org.Using ESNext, quite a dummy links replacer but just to show-case how it works :Note: Previous answer was missing some code. It's now fixed + example.I needed something a bit more flexible for a regex replace to decode the unicode in my incoming JSON data:If you would have a variable amount of backreferences then the argument count (and places) are also variable. The MDN Web Docs describe the follwing syntax for sepcifing a function as replacement argument:For instance, take these regular expressions:You can't use 'arguments' variable here because it's of type Arguments and no of type Array so it doesn't have a slice() method.

Replacing callbacks with promises in Node.js

Lior Erez

[Replacing callbacks with promises in Node.js](https://stackoverflow.com/questions/28432401/replacing-callbacks-with-promises-in-node-js)

I have a simple node module which connects to a database and has several functions to receive data, for example this function:dbConnection.js:The module would be called this way from a different node module:app.js:I would like to use promises instead of callbacks in order to return the data.

So far I've read about nested promises in the following thread: Writing Clean Code With Nested Promises, but I couldn't find any solution that is simple enough for this use case.

What would be the correct way to return result using a promise?

2015-02-10 13:03:51Z

I have a simple node module which connects to a database and has several functions to receive data, for example this function:dbConnection.js:The module would be called this way from a different node module:app.js:I would like to use promises instead of callbacks in order to return the data.

So far I've read about nested promises in the following thread: Writing Clean Code With Nested Promises, but I couldn't find any solution that is simple enough for this use case.

What would be the correct way to return result using a promise?I recommend to take a look at MDN's Promise docs which offer a good starting point for using Promises. Alternatively, I am sure there are many tutorials available online.:)Note: Modern browsers already support ECMAScript 6 specification of Promises (see the MDN docs linked above) and I assume that you want to use the native implementation, without 3rd party libraries.As for an actual example...The basic principle works like this:This might seem like a lot so here is an actual example.In Node.js 7.6, the v8 JavaScript compiler was upgraded with async/await support. You can now declare functions as being async, which means they automatically return a Promise which is resolved when the async function completes execution. Inside this function, you can use the await keyword to wait until another Promise resolves.Here is an example:With bluebird you can use Promise.promisifyAll (and Promise.promisify) to add Promise ready methods to any object.And use like this:orBluebird supports a lot of features, one of them is disposers, it allows you to safely dispose of a connection after it ended with the help of Promise.using and Promise.prototype.disposer. Here's an example from my app:Then use it like this:This will automatically end the connection once the promise resolves with the value (or rejects with an Error).Node.js version 8.0.0+:You don't have to use bluebird to promisify the node API methods anymore. Because, from version 8+ you can use native util.promisify:Now, don't have to use any 3rd party lib to do the promisify. Assuming your database adapter API doesn't output Promises itself you can do something like:If the database API does support Promises you could do something like: (here you see the power of Promises, your callback fluff pretty much disappears)Using .then() to return a new (nested) promise.Call with:I used a mockup API for my Promises, your API might be different. If you show me your API I can tailor it.When setting up a promise you take two parameters, resolve and reject. In the case of success, call resolve with the result, in the case of failure call reject with the error.Then you can write:callback will be called with the result of the promise returned from getUsers, i.e. resultUsing the Q library for example:Use that native module const {promisify} = require('util'); to conver plain old callback pattern to promise pattern so you can get benfit from async/await codeBelow code works only for node -v > 8.xI use this Promisified MySQL middleware for Node.jsread this article Create a MySQL Database Middleware with Node.js 8 and Async/Awaitdatabase.jsYou must upgrade node -v > 8.x you must use async function to be able to use await.example:

Javascript Functions and default parameters, not working in IE and Chrome

Talon

[Javascript Functions and default parameters, not working in IE and Chrome](https://stackoverflow.com/questions/15178700/javascript-functions-and-default-parameters-not-working-in-ie-and-chrome)

I created a function like this:It works fine in FirefoxIn IE it gives this error on the console:

Expected ')'In Chrome it gives this error in the console:

Uncaught SyntaxError: Unexpected token =Both browsers mark the source of the error as the function creation line.

2013-03-02 19:50:04Z

I created a function like this:It works fine in FirefoxIn IE it gives this error on the console:

Expected ')'In Chrome it gives this error in the console:

Uncaught SyntaxError: Unexpected token =Both browsers mark the source of the error as the function creation line.You can't do this, but you can instead do something like:This is often shortened to something like:UpdateThe above is true for ECMAScript <= 5. ES6 has proposed Default parameters. So the above could instead read:   That's not a valid ECMAScript syntax, but it is a valid syntax for Mozilla's superset of features they add to their implementation of the language. Default parameter assignment syntax is likely coming in ECMAScript 6.Javascript does not allow a "default" specifier.A quick way of doing what you would want is changing:to the following:The code you provided won't run in Chrome < version 49:

https://kangax.github.io/compat-table/es6/#test-default_function_parameters You used valid ECMAScript 2015 syntax: In my opinion, the best way to use ES2015 features is to bundle assets with Browserify or WebPack, with a step for using Babel to trans-compile ES2015 to ES5. That way you don't have to worry about that ES2015 browser compatibility chart. It's a pain to get started the first time, but worth it.In your case, you have an other alternative to be sure that your variable is a boolean:Default value is undefined, and true == undefined => false, so your default value will be false :)

What is the fastest factorial function in JavaScript? [closed]

Ken

[What is the fastest factorial function in JavaScript? [closed]](https://stackoverflow.com/questions/3959211/what-is-the-fastest-factorial-function-in-javascript)

Looking for a really fast implementation of factorial function in JavaScript. Any suggests?

2010-10-18 12:40:18Z

Looking for a really fast implementation of factorial function in JavaScript. Any suggests?You can search for (1...100)! on WolframAlpha to pre-calculate the factorial sequence.The first 100 numbers are:If you still want to calculate the values yourself, you can use memoization:I thought it would be useful to add a working example of lazy iterative factorial function that uses big numbers to get exact result with memoization and cache as comparisonI assume you would use some kind of closure to limit variable name visibility.Ref : BigNumber

Sandbox : JsFiddleYou should use a loop. Here are two versions benchmarked by calculating the factorial of 100 for 10.000 times.RecursiveIterative Live at : http://jsfiddle.net/xMpTv/My results show:

- Recursive ~ 150 milliseconds

- Iterative ~ 5 milliseconds..I still think Margus's answer is the best one. However if you want to calculate the factorials of numbers within the range 0 to 1 (ie the gamma function) as well, then you cannot use that approach because the lookup table will have to contain infinite values.However, you can approximate the values of the factorials, and it's pretty fast, faster than recursively calling itself or looping it at least (especially when values start to get bigger).A good approximation method is Lanczos's oneHere is an implementation in JavaScript (ported from a calculator I wrote months ago):You can now do cool stuff like factorial(0.41), etc however accuracy might be a little off, after all, it is an approximation of the result.Lookup table is the obvious way to go, if you're working with natural numbers.

To calculate any factorial in real-time, you can speed it with a cache, saving the numbers you've calculated before. Something like:You can precalculate some values in order to speed it even more.Here is my solution:It's the simplest way (less characters / lines) I've found, only a function with one code line.Edit:

If you really want to save some chars you can go with an Arrow Function (21 bytes):short and easy recursive function (you could do it with a loop, too, but I don't think that would make any difference in performance):for a very large n, you could use the stirlings approximation - but that will only give you an approximate value.EDIT: a comment on why I'm getting a downvote for this would have been nice...EDIT2: this would be the soulution using a loop (which would be the better choice):I think the best solution would be to use the cached values, as Margus mentioned and use the stirlings approximation for larger values (assumed you have to be realy fast and don't have to be that exact on such big numbers).Just One line with ES6 Behold, the memoizer, which takes any single-argument function and memoizes it. Turns out to be marginally faster than @xPheRe's solution, including the limit on the size of the cache and associated checking, because I use shortcircuiting and so on.Approximately 25x faster on my machine in Chrome than the recursive version, and 10% faster than xPheRe's.I came across this post. Inspired by all contributions here I came up with my own version, which has two features that I haven't seen discussed before:

1) A check to ensure the argument is a non-negative integer

2) Making a unit out of the cache and the function to make it one self contained bit of code.

For fun, I tried to make it as compact as possible. Some may find that elegant, others may think it terribly obscure. Anyway, here it is:You can either pre fill the cache, or allow it to be filled as the calls go by. But the initial element (for fact(0) must be present or it will break. Enjoy :)I think that this loop-based version might be the fastest factorial function.And here is my reasoning:It is very simple using ES6const factorial = n => n ?  (n * factorial(n-1)) : 1;See an example hereHere is one solution:Using ES6 you can achieve it both fast and short:The code to calculate factorial depends on your requirements.  Regarding points 1 and 4, it is often more useful to have a function to evaluate the log of the factorial directly rather than to have a function to evaluate factorial itself.Here's a blog post that discusses these issues.  Here is some C# code for computing log factorial that would be trivial to port to JavaScript.  But it may not be best for your needs depending on your answers to the questions above.This is a compact loop-based versionOr you might override Math object (recursive version):Or join both approaches ...Exploiting the fact that Number.MAX_VALUE < 171!, we can simply use a complete lookup table consisting of just 171 compact array elements taking up less than 1.4 kilobytes of memory.A fast lookup function with runtime complexity O(1) and minimal array access overhead would then look as follows:This is as precise and as fast as it gets using the Number datatype. Computing the lookup table in Javascript - as some other answers suggest - will reduce precision when n! > Number.MAX_SAFE_INTEGER.Compressing the runtime table via gzip reduces its size on disk from about 3.6 to 1.8 kilobytes.One line answer:This is working example uses BigInt, because many answers here all escape the safe boundary of Number (MDN) almost right away. It's not the fastest but it's simple and thus clearer for adapting other optimizations (like a cache of the first 100 numbers).Using ES6 features, can write code on ONE line & without recursion  : Just for completeness, here is a recursive version that would allow 

tail call optimization. I'm not sure if tail call optimizations are performed in JavaScript though..To call it:This is an iterative solution that uses less stack space and save previously computed values in a self-memoizing way:Also note that I am adding this to the Math object which is an object literal so there is no prototype.  Rather just binding these to the function directly.I believe the following is the most sustainable and efficient piece of code from the comments above. You can use this in your global application js architecture... and, not worry about writing it in multiple namespaces (since its a task which probably doesn't need much augmenting). I've included 2 method names (based on preference) but both can be used as they're just references.This does the caching of the first 100 values on the fly, and does not introduce an external variable into scope for the cache, storing the values as properties of the function object itself, which means that if you know factorial(n) has already been calculated, you can simply refer to it as factorial[n], which is slightly more efficient.  Running these first 100 values will take sub-millisecond time in modern browsers.Here is an implementation which calculates both positive and negative factorials.

It's fast and simple.Here's one I made myself, don't use numbers over 170 or under 2.Here is my codeCached loop should be fastest (at least when called multiple times)After reviewing the input from other members (excluding the Log advice, although I may implement that later) I went ahead and threw together a script that is fairly simple. I started with a simple uneducated JavaScript OOP example and built a little class to handle factorials. I then implemented my version of the Memoization that was suggested above. I also implemented the shorthand Factorialization however I made a small error adjustment; I changed the "n<2" to "n<3". "n<2" would still process n=2 which would be a waste, because you would iterate for a 2*1=2; this is a waste in my opinion. I altered it to "n<3"; because if n is 1 or 2 it will simply return n, if it is 3 or more it will evaluate normally. Of course as rules apply, I placed my functions in descending order of assumed execution. I added in the bool(true|false) option to allow quick altering between memo'ed and normal execution (You just never know when you want to swap around on your page without needing to change the "style")

As I said before the memoized factorials variable is set with the 3 starting positions, taking 4 characters, and minimizing wasteful calculations. Everything past the third iteration you are handling double digit math plus. I figure if you where a stickler enough about it you would run on a factorial table (as implemented).What have I planned after this?

local&|session storage to allow for a case by case cache of needed iterations, essentially handling the "table" issue spoken above. This would also massively save database and server side space. However, if you go with localStorage you would essentially be sucking up space on your users computer simply to store a list of numbers and make their screen LOOK faster, however over a long period of time with an immense need this would be slow. I am thinking sessionStorage (clearing after Tab leaves) would be a much better route. Possibly combine this with a self balancing server/local dependent cache?

User A needs X iterations.

User B need Y iterations.

X+Y/2=Amount needed locally cached.

Then just detect and fiddle with load-time and execute-time benchmarks live for every user until it adjusts itself to optimization for the site itself.

Thanks!Edit 3:Here is one using newer javascript functions fill, map, reduce and constructor  (and fat arrow syntax):Edit: updated to handle n === 0

convert string into array of integers

Nick Craver

[convert string into array of integers](https://stackoverflow.com/questions/4291447/convert-string-into-array-of-integers)

I want to convert the following string '14 2' into an array of two integers.

How can I do it ?

2010-11-27 11:41:12Z

I want to convert the following string '14 2' into an array of two integers.

How can I do it ?You can .split() to get an array of strings, then loop through to convert them to numbers, like this:The +myArray[i] is just  a quick way to do the number conversion, if you're sure they're integers you can just do:A quick one for modern browsers:SO...older thread, I know, but...@RoccoMusolino had a nice catch; here's an alternative:TL;DR:WRONG: "5 6 note this foo".split(" ").map(Number).filter(Boolean); // [5, 6]There is a subtle flaw in the more elegant solutions listed here, specifically @amillara and @Marcus' otherwise beautiful answers.The problem occurs when an element of the string array isn't integer-like, perhaps in a case without validation on an input. For a contrived example...The problem:Since you obviously want a PURE int array, that's a problem. Honestly, I didn't catch this until I copy-pasted SO code into my script... :/

The (slightly-less-baller) fix:So, now even when you have crap int string, your output is a pure integer array. The others are really sexy in most cases, but I did want to offer my mostly rambly w'actually. It is still a one-liner though, to my credit...Hope it saves someone time!An alternative to Tushar Gupta answer would be :In code golf you save 1 character.

Here the "+" is "unary plus" operator, works like parseInt.First split the string on spaces:Then convert the result array of strings into integers:The point against parseInt-approach:There's no need to use lambdas and/or give radix parameter to parseInt, just use parseFloat or Number instead.Reasons:Notice: In Firefox parseInt works about 4 times faster, but still slower than others. In total: +e < Number < parseFloat < parseIntJust for fun I thought I'd throw a forEach(f()) solution in too.Better one line solution: us the split function:

Get distance between two points in canvas

Anagmate

[Get distance between two points in canvas](https://stackoverflow.com/questions/20916953/get-distance-between-two-points-in-canvas)

I have canvas drawing tab and want lineWidth to be based on distance between two last mousemove coordinate updates. I will make translation of distance to width myself, I just need to know how to get distance between those points (I already have coordinates of those pointes).

2014-01-04 04:37:29Z

I have canvas drawing tab and want lineWidth to be based on distance between two last mousemove coordinate updates. I will make translation of distance to width myself, I just need to know how to get distance between those points (I already have coordinates of those pointes).You can do it with pythagoras theoremIf you have two points (x1, y1) and (x2, y2)

then you can calculate the difference in x and difference in y, lets call them a and b.Note that Math.hypot is part of the ES2015 standard. There's also a good polyfill on the MDN doc for this feature.So getting the distance becomes as easy as Math.hypot(x2-x1, y2-y1).http://en.wikipedia.org/wiki/Euclidean_distanceIf you have the coordinates, use the formula to calculate the distance:If your platform supports the ** operator, you can instead use that:The distance between two coordinates x and y!

x1 and y1 is the first point/position, x2 and y2 is the second point/position!i tend to use this calculation a lot in things i make, so i like to add it to the Math object:Update:this approach is especially happy making when you end up in situations something akin to this (i often do):that horrid thing becomes the much more manageable:

Current time formatting with Javascript

Seong Lee

[Current time formatting with Javascript](https://stackoverflow.com/questions/14638018/current-time-formatting-with-javascript)

I want to get current time in a specific format with javascript.With the function below and calling it will give me 

Fri Feb 01 2013 13:56:40 GMT+1300 (New Zealand Daylight Time)

but I want to format it like

Friday 2:00pm

1 Feb 2013Of course, code above doesn't have any formatting logic but I have not come across with any "working" formatters yet.

2013-02-01 01:00:42Z

I want to get current time in a specific format with javascript.With the function below and calling it will give me 

Fri Feb 01 2013 13:56:40 GMT+1300 (New Zealand Daylight Time)

but I want to format it like

Friday 2:00pm

1 Feb 2013Of course, code above doesn't have any formatting logic but I have not come across with any "working" formatters yet.A JavaScript Date has several methods allowing you to extract its parts:getFullYear() - Returns the 4-digit year

getMonth() - Returns a zero-based integer (0-11) representing the month of the year.

getDate() - Returns the day of the month (1-31).

getDay() - Returns the day of the week (0-6).  0 is Sunday, 6 is Saturday.

getHours() - Returns the hour of the day (0-23).

getMinutes() - Returns the minute (0-59).

getSeconds() - Returns the second (0-59).

getMilliseconds() - Returns the milliseconds (0-999).

getTimezoneOffset() - Returns the number of minutes between the machine local time and UTC.There are no built-in methods allowing you to get localized strings like "Friday", "February", or "PM".  You have to code that yourself.  To get the string you want, you at least need to store string representations of days and months:Then, put it together using the methods above:I have a date format function I like to include in my standard library.  It takes a format string parameter that defines the desired output.  The format strings are loosely based on .Net custom Date and Time format strings.  For the format you specified the following format string would work:  "dddd h:mmtt d MMM yyyy".Demo: jsfiddle.net/BNkkB/1Here is my full date formatting function:You may want to try Documentation2017 update: use toLocaleDateString and toLocaleTimeString to format dates and times. The first parameter passed to these methods is a locale value, such as en-us. The second parameter, where present, specifies formatting options, such as the long form for the weekday.Please refer below link for more details.Date and Time Strings (JavaScript)You can use my port of strftime:Sample usage:The latest code is available here: https://github.com/thdoan/strftimeLook at the internals of the Date class and you will see that you can extract all the bits (date, month, year, hour, etc).http://www.w3schools.com/jsref/jsref_obj_date.aspFor something like Fri 23:00 1 Feb 2013 the code is like:**** Modified 2019-05-29 to keep 3 downvoters happyThere are many great libraries out there, for those interestedThere really shouldn't be a need these days to invent your own formatting specifiers. 2.39KB minified. One file. https://github.com/rhroyston/clock-jsCurrent Time isTo work with the base Date class you can look at MDN for its methods (instead of W3Schools due to this reason). There you can find a good description about every method useful to access each single date/time component and informations relative to whether a method is deprecated or not.Otherwise you can look at Moment.js that is a good library to use for date and time processing. You can use it to manipulate date and time (such as parsing, formatting, i18n, etc.).Usage & result:For this true mysql style use this function below: 2019/02/28 15:33:12ISO8601 (eg: HH:MM:SS , 07:55:55 , or 18:50:30)

on chrome : on edge : })();05:12:00

Check if a string is html or not

user1240679

[Check if a string is html or not](https://stackoverflow.com/questions/15458876/check-if-a-string-is-html-or-not)

I have a certain string for which I want to check if it is a html or not. I am using regex for the same but not getting the proper result.I validated my regex and it works fine here.Here's the fiddle but the regex isn't running in there. http://jsfiddle.net/wFWtc/On my machine, the code runs fine but I get a false instead of true as the result.

What am missing here?

2013-03-17 08:23:53Z

I have a certain string for which I want to check if it is a html or not. I am using regex for the same but not getting the proper result.I validated my regex and it works fine here.Here's the fiddle but the regex isn't running in there. http://jsfiddle.net/wFWtc/On my machine, the code runs fine but I get a false instead of true as the result.

What am missing here?A better regex to use to check if a string is HTML is:For example:In fact, it's so good, that it'll return true for every string passed to it, which is because every string is HTML. Seriously, even if it's poorly formatted or invalid, it's still HTML.If what you're looking for is the presence of HTML elements, rather than simply any text content, you could use something along the lines of:It won't help you parse the HTML in any way, but it will certainly flag the string as containing HTML elements.Method #1. Here is the simple function to test if the string contains HTML data:The idea is to allow browser DOM parser to decide if provided string looks like an HTML or not. As you can see it simply checks for ELEMENT_NODE (nodeType of 1).I made a couple of tests and looks like it works:This solution will properly detect HTML string, however it has side effect that img/vide/etc. tags will start downloading resource once parsed in innerHTML.Method #2. Another method uses DOMParser and doesn't have loading resources side effects:

Notes:1. Array.from is ES2015 method, can be replaced with [].slice.call(doc.body.childNodes).2. Arrow function in some call can be replaced with usual anonymous function.A little bit of validation with:This searches for empty tags (some predefined) and / terminated XHTML empty tags and validates as HTML because of the empty tag OR will capture the tag name and attempt to find it's closing tag somewhere in the string to validate as HTML.Explained demo: http://regex101.com/r/cX0eP2Update:Complete validation with:  This does proper validation as it contains ALL HTML tags, empty ones first followed by the rest which need a closing tag.Explained demo here: http://regex101.com/r/pE1mT5zzzzBov's answer above is good, but it does not account for stray closing tags, like for example:A version that also catches closing tags could be this:Here's a sloppy one-liner that I use from time to time:It will basically return true for strings containing a < followed by ANYTHING followed by >.By ANYTHING, I mean basically anything except an empty string.It's not great, but it's a one-liner.UsageAs you can see it's far from perfect, but might do the job for you in some cases.All of the answers here are over-inclusive, they just look for < followed by >. There is no perfect way to detect if a string is HTML, but you can do better. Below we look for end tags, and will be much tighter and more accurate:And here it is in action:If you're creating a regex from a string literal you need to escape any backslashes:This is not necessary if you use a regex literal, but then you need to escape forward slashes:Also your jsfiddle didn't work because you assigned an onload handler inside another onload handler - the default as set in the Frameworks & Extensions panel on the left is to wrap the JS in an onload. Change that to a nowrap option and fix the string literal escaping and it "works" (within the constraints everybody has pointed out in comments): http://jsfiddle.net/wFWtc/4/As far as I know JavaScript regular expressions don't have back-references. So this part of your expression:won't work in JS (but would work in some other languages)./<\/?[^>]*>/.test(str) Only detect whether it contains html tags, may be a xmlWith jQuery:Using jQuery in this case, the simplest form would be:If $(testString).length = 1, this means that there is one HTML tag inside textStging.My solution is There are fancy solutions involving utilizing the browser itself to attempt to parse the text, identifying if any DOM nodes were constructed, which will be… slow. Or regular expressions which will be faster, but… potentially inaccurate. There are also two very distinct questions arising from this problem:Is the string part of an HTML document, containing HTML element markup or encoded entities? This can be used as an indicator that the string may require bleaching / sanitization or entity decoding:You can see this pattern in use against all of the examples from all existing answers at the time of this writing, plus some… rather hideous WYSIWYG- or Word-generated sample text and a variety of character entity references.The HTML specification is shockingly loose as to what it considers an HTML document.  Browsers go to extreme lengths to parse almost any garbage text as HTML.  Two approaches: either just consider everything HTML (since if delivered with a text/html Content-Type, great effort will be expended to try to interpret it as HTML by the user-agent) or look for the prefix marker:In terms of "well-formedness", that, and almost nothing else is "required".  The following is a 100% complete, fully valid HTML document containing every HTML element you think is being omitted:Yup.  There are explicit rules on how to form "missing" elements such as <html>, <head>, and <body>. Though I find it rather amusing that SO's syntax highlighting failed to detect that properly without an explicit hint.

Javascript dynamically invoke object method from string

Mikulas Dite

[Javascript dynamically invoke object method from string](https://stackoverflow.com/questions/9854995/javascript-dynamically-invoke-object-method-from-string)

Can I dynamically call an object method having the method name as a string? I would imagine it like this:

2012-03-24 19:51:43Z

Can I dynamically call an object method having the method name as a string? I would imagine it like this:if the name of the property is stored in a variable, use []Properties of objects can be accessed through the array notation:method can be call with eval

    eval("foo." + method + "()");

might not be very good way.When we call a function inside an object, we need provide the name of the function as a String.

Parsing JSON from XmlHttpRequest.responseJSON

chanux

[Parsing JSON from XmlHttpRequest.responseJSON](https://stackoverflow.com/questions/1973140/parsing-json-from-xmlhttprequest-responsejson)

I'm trying to parse a bit.ly JSON response in javascript.I get the JSON via XmlHttpRequest.I do this in a firefox addon. When I run I get the error "jsonResponse is undefined" for the line var bitlyUrl = jsonResponse.results[url].shortUrl;. Am I doing anything wrong in parsing JSON here? Or what is wrong with this code?

2009-12-29 05:59:41Z

I'm trying to parse a bit.ly JSON response in javascript.I get the JSON via XmlHttpRequest.I do this in a firefox addon. When I run I get the error "jsonResponse is undefined" for the line var bitlyUrl = jsonResponse.results[url].shortUrl;. Am I doing anything wrong in parsing JSON here? Or what is wrong with this code?New ways I: fetchTL;DR I'd recommend this way as long as you don't have to send synchronous requests or support old browsers.A long as your request is asynchronous you can use the Fetch API to send HTTP requests. The fetch API works with promises, which is a nice way to handle asynchronous workflows in JavaScript. With this approach you use fetch() to send a request and ResponseBody.json() to parse the response:Compatibility: The Fetch API is not supported by IE11 as well as Edge 12 & 13. However, there are polyfills.New ways II: responseTypeAs Londeren has written in his answer, newer browsers allow you to use the responseType property to define the expected format of the response. The parsed response data can then be accessed via the response property:Compatibility: responseType = 'json' is not supported by IE11.The classic wayThe standard XMLHttpRequest has no responseJSON property, just responseText and responseXML. As long as bitly really responds with some JSON to your request, responseText should contain the JSON code as text, so all you've got to do is to parse it with JSON.parse():Compatibility: This approach should work with any browser that supports XMLHttpRequest and JSON.JSONHttpRequestIf you prefer to use responseJSON, but want a more lightweight solution than JQuery, you might want to check out my JSONHttpRequest. It works exactly like a normal XMLHttpRequest, but also provides the responseJSON property. All you have to change in your code would be the first line:JSONHttpRequest also provides functionality to easily send JavaScript objects as JSON. More details and the code can be found here: http://pixelsvsbytes.com/2011/12/teach-your-xmlhttprequest-some-json/.Full disclosure: I'm the owner of Pixels|Bytes. I think my script is a good solution to the problem, so I posted it here. Please leave a comment, if you want me to remove the link.You can simply set xhr.responseType = 'json';Documentation for responseTypeNote: I've only tested this in Chrome.it adds a prototype function to the XMLHttpRequest .. XHR2,in XHR 1 you probably just need to replace this.response with this.responseTextto return the json in xhr2EDIT If you plan to use XHR with arraybuffer or other response types then you have to check if the response is a string.in any case you have to add more checks e.g. if it's not able to parse the json.I think you have to include jQuery to use responseJSON.Without jQuery, you could try with responseText and try like eval("("+req.responseText+")");UPDATE:Please read the comment regarding eval, you can test with eval, but don't use it in working extension.OR use json_parse : it does not use evalUse nsIJSON if this is for a FF extension:For a webpage, just use JSON.parse instead of Components.classes["@mozilla.org/dom/json;1"].createInstance(Components.interfaces.nsIJSON.decode

Prevent automatic browser scroll on refresh

ThomasReggi

[Prevent automatic browser scroll on refresh](https://stackoverflow.com/questions/7035331/prevent-automatic-browser-scroll-on-refresh)

If you go to a page a and scroll around then refresh the page will refresh at the spot where you left it. This is great, however this also occurs on pages where there is a anchor location in the url. An example would be if you clicked on a link http://example.com/post/244#comment5 and refreshed the page after looking around you would not be at the anchor and the page jumps around. Is there any way to prevent this with javascript? So that no-matter-what you would always navigate to the anchor.

2011-08-12 03:35:40Z

If you go to a page a and scroll around then refresh the page will refresh at the spot where you left it. This is great, however this also occurs on pages where there is a anchor location in the url. An example would be if you clicked on a link http://example.com/post/244#comment5 and refreshed the page after looking around you would not be at the anchor and the page jumps around. Is there any way to prevent this with javascript? So that no-matter-what you would always navigate to the anchor.This solution is no longer recommended due to changes in browser behavior. See other answers.Basically, if an anchor is used we bind to the windows scroll event. The idea being that the first scroll event has to belong to the automatic repositioning done by the browser. When this occurs we do our own repositioning and then remove the bound event. This prevents subsequent page scrolls from borking the system.On Chrome, even if you force scrollTop to 0 it will jump afterwards after the first scroll event.You should bind the scroll to this:So the browser is tricked to believe that it was on the beginning before the refresh.To disable automatic scroll restoration just add this tag to head section.It's not supported by IE. Browser compatibility.After number of failures finally I managed to do the trick. anzo is correct here as using beforeunload will make the page jump to top when a user reloads the page or clicks a link. So unload is the clearly way to do this.Javascript way(Thanks ProfNandaa): EDIT: 16/07/2015The jump issue is still there with Firefox even with unload event.Here's a a more general approach. Instead of trying to prevent the browser from scrolling (or jumping to the top as it would look like) I just restore the previous position on the page.

I.e. I'm recording the current y-offset of the page in localStorage and scroll to this position once the page has loaded.You can just put a # at the end so the page will load at the top.Works on all browsers, mobile and desktop, because it is so simple.});// This loads the page with a # at the end.You should be able to.Onload, check if window.location.hash has a value. If it does, grab the element with an id that matches the hash value. Find the position of the element (recursive calls to offsetTop/offsetLeft) and then pass those values into the window.scrollTo(x, y) method.This should scroll the page to the desired element.

Check if a div does NOT exist with javascript

Wilson

[Check if a div does NOT exist with javascript](https://stackoverflow.com/questions/10886190/check-if-a-div-does-not-exist-with-javascript)

Checking if a div exists is fairly simpleBut how can I check if a div with the given id does not exist?

2012-06-04 18:22:50Z

Checking if a div exists is fairly simpleBut how can I check if a div with the given id does not exist?The statement document.getElementById("given-id") returns null if an element with given-id doesn't exist, and null is falsy meaning that it translates to false when evaluated in an if-statement. (other falsy values)Try getting the element with the ID and check if the return value is null:If you're using jQuery, you can do:Check both my JavaScript and JQuery code :JavaScript:JQuery:getElementById returns null if there is no such element.That works with :There's an even better solution. You don't even need to check if the element returns null. You can simply do this:That code will only log exists to console if the element actually exists in the DOM.I do below and check if id exist and execute function if exist.All these answers do NOT take into account that you asked specifically about a DIV element.@see https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector

How do I normalize CSS3 Transition functions across browsers?

methodofaction

[How do I normalize CSS3 Transition functions across browsers?](https://stackoverflow.com/questions/5023514/how-do-i-normalize-css3-transition-functions-across-browsers)

Webkit's transition end event is called webkitTransitionEnd, Firefox is transitionEnd, opera is oTransitionEnd. What is a good way of tackling all of them in pure JS? Should I do browser sniffing? or implement each one separately? Some other way that hasn't occurred to me?i.e.:or 

2011-02-16 23:33:29Z

Webkit's transition end event is called webkitTransitionEnd, Firefox is transitionEnd, opera is oTransitionEnd. What is a good way of tackling all of them in pure JS? Should I do browser sniffing? or implement each one separately? Some other way that hasn't occurred to me?i.e.:or There's a technique used in Modernizr, improved:Then you can just call this function whenever you need the transition end event:As per Matijs comment, the easiest way to detect transition events is with a library, jquery in this case:In library-less javascript it gets a bit verbose:UpdateThe following is a cleaner way of doing it, and doesn't require modernizrAlternativelyThis is based on the code suggested by Modernizr, but with the extra event for newer versions of Opera.http://modernizr.com/docs/#prefixedIf you use jQuery and Bootstrap $.support.transition.end will return the right event for the current browser.It is defined in Bootstrap and used in its animation callbacks, though the jQuery docs say not to rely on these properties:As of 2015, this one-liner should do the deal (IE 10+, Chrome 1+, Safari 3.2+, FF 4+ and Opera 12+):-Attaching the event listener is simple:-Here is a more cleaner wayThe second is the way to go. Only one of those events will fire in every browser, so you can set all of them and it'll work.google closure makes sure you don't have to do this.  If you have an element:looking at the source of goog.events.eventtype.js, TRANSITIONEND is calculated by looking at the useragent:I use code like this (with jQuery)That lets me use JS to add things by specifying vP concatentated with the property, and if it didn't hit a browser it just uses the standard. The events lets me easily bind like so:jquery override:and usage like:Accepted answer is correct but you don't have to re-create that element again-and-again-and...Build a global variable and add the function(s):

Vue.js img src concatenate variable and text

ketom

[Vue.js img src concatenate variable and text](https://stackoverflow.com/questions/40255291/vue-js-img-src-concatenate-variable-and-text)

I want to concatenate Vue.js variable with image URL.What I computed:If I build for android:ElseHow can I concatenate the computed variable with the URL?I tried it:

2016-10-26 06:35:54Z

I want to concatenate Vue.js variable with image URL.What I computed:If I build for android:ElseHow can I concatenate the computed variable with the URL?I tried it:You can't use curlies (moustache tags) in attributes. Use the following to concat data:Or the short version:Read more on dynamic attributes in the Vue docs.In another case I'm able to use template literal ES6 with backticks,

so for yours could be set as:just try if you handel this from dataBase try :

Copy all files from directory to another with Grunt.js copy

Evan Hobbs

[Copy all files from directory to another with Grunt.js copy](https://stackoverflow.com/questions/18966485/copy-all-files-from-directory-to-another-with-grunt-js-copy)

I'm trying to copy all the files in a directory to another directory as part of my build process. It works fine for individual files that I specify explicitly but when I try to copy the whole directory it does weird things like copies the full directory structure (or nothing at all). Here is the relevant part from my GruntFile.js:Specifically it's the last line that I can't get to work:

2013-09-23 18:42:25Z

I'm trying to copy all the files in a directory to another directory as part of my build process. It works fine for individual files that I specify explicitly but when I try to copy the whole directory it does weird things like copies the full directory structure (or nothing at all). Here is the relevant part from my GruntFile.js:Specifically it's the last line that I can't get to work:The flatten: true option as in this answer might work for some cases, but it seems to me that the more common requirement (as in my case) is to copy a folder and its sub-folder structure, as-is, to dest. It seems that in most cases if you have sub-folders, they are probably being referenced that way in code.  The key to doing this is the cwd option, which will preserve folder structure relative to the specified working directory:This task will maintain folder structure if you specify a file glob. What you want is the flatten option which will remove the structure.Find the rest of the available options in the Github repo. Hope this helps.I would like to add that changing the format of the glob in src will modify how the copy works.As pointed out by bmoeskau above, the following will copy everything inside dist/ and move it to path/to/dir (overwriting the destination if it already exists). Note however, that:Will only copy files inside dist/ as well as directories, but will not copy the contents of those directories to the destination.Also, the following with src: '*/*' will only copy directories with contents inside dist/. That is, files just inside dist/ will not be copied.Finally, same as above, but src: '**/**' will copy only files inside dist/ as well as files inside dist/ subdirectories to path/to/dir. So there will be no folders inside the destination.Had to use egdy instead curly braces for the files segment (in Coffeescript)...If you are developing with angular yeoman , then this is the better way to copy with grunt.

expand: true is required when using cwd. <%= yeoman.app %> is just the app route ('.').

Check whether user has a Chrome extension installed

Brad

[Check whether user has a Chrome extension installed](https://stackoverflow.com/questions/6293498/check-whether-user-has-a-chrome-extension-installed)

I am in the process of building a Chrome extension, and for the whole thing to work the way I would like it to, I need an external JavaScript script to be able to detect if a user has my extension installed. For example: A user installs my plugin, then goes to a website with my script on it. The website detects that my extension is installed and updates the page accordingly.Is this possible?

2011-06-09 13:27:16Z

I am in the process of building a Chrome extension, and for the whole thing to work the way I would like it to, I need an external JavaScript script to be able to detect if a user has my extension installed. For example: A user installs my plugin, then goes to a website with my script on it. The website detects that my extension is installed and updates the page accordingly.Is this possible?I am sure there is a direct way (calling functions on your extension directly, or by using the JS classes for extensions), but an indirect method (until something better comes along):Have your Chrome extension look for a specific DIV or other element on your page, with a very specific ID.For example:Do a getElementById and set the innerHTML to the version number of your extension or something.  You can then read the contents of that client-side.Again though, you should use a direct method if there is one available.EDIT: Direct method found!!Use the connection methods found here:  https://developer.chrome.com/extensions/extension#global-eventsUntested, but you should be able to do...Chrome now has the ability to send messages from the website to the extension.So in the extension background.js (content.js will not work) add something like:This will then let you make a call from the website:You can then check the hasExtension variable. The only drawback is the call is asynchronous, so you have to work around that somehow.Edit:

As mentioned below, you'll need to add an entry to the manifest.json listing the domains that can message your addon. Eg:Another method is to expose a web-accessible resource, though this will allow any website to test if your extension is installed.Suppose your extension's ID is aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, and you add a file (say, a transparent pixel image) as test.png in your extension's files.Then, you expose this file to the web pages with web_accessible_resources manifest key:In your web page, you can try to load this file by its full URL (in an <img> tag, via XHR, or in any other way):If the file loads, then the extension is installed. If there's an error while loading this file, then the extension is not installed.Of note: if there is an error while loading this file, said network stack error will appear in the console with no possibility to silence it. When Chromecast used this method, it caused quite a bit of controversy because of this; with the eventual very ugly solution of simply blacklisting very specific errors from Dev Tools altogether by the Chrome team.Important note: this method will not work in Firefox WebExtensions. Web-accessible resources inherently expose the extension to fingerprinting, since the URL is predictable by knowing the ID. Firefox decided to close that hole by assigning an instance-specific random URL to web accessible resources:However, while the extension can use runtime.getURL() to obtain this address, you can't hard-code it in your website.I thought I would share my research on this.

I needed to be able to detect if a specific extension was installed for some file:/// links to work.

I came across this article here

This explained a method of getting the manifest.json of an extension.I adjusted the code a bit and came up with:With this you should be able to use Ext_Detect(ExtensionName,ExtensionID) to detect the installation of any number of extensions.Another possible solution if you own the website is to use inline installation.  I know this an old question but this way was introduced in Chrome 15 and so I thought Id list it for anyone only now looking for an answer.I used the cookie method:In my manifest.js file I included a content script that only runs on my site:in my js/mysite.js I have one line:and in my index.html page I look for that cookie.You could have the extension set a cookie and have your websites JavaScript check if that cookie is present and update accordingly. This and probably most other methods mentioned here could of course be cirvumvented by the user, unless you try and have the extension create custom cookies depending on timestamps etc, and have your application analyze them server side to see if it really is a user with the extension or someone pretending to have it by modifying his cookies.There's another method shown at this Google Groups post. In short, you could try detecting whether the extension icon loads successfully. This may be helpful if the extension you're checking for isn't your own.Webpage interacts with extension through background script.manifest.json:page.html:Your extension could interact with the website (e.g. changing variables) and your website could detect this.But there should be a better way to do this. I wonder how Google is doing it on their extension gallery (already installed applications are marked).Edit:The gallery use the chrome.management.get function. Example:But you can only access the method from pages with the right permissions.A lot of the answers here so far are Chrome only or incur an HTTP overhead penalty. The solution that we are using is a little different:This will allow the code in install_notifier.js to run on that site (if you didn't already have permissions there).Add something like this to install_notifier.js (note that this is using a closure to keep the variables from being global, but that's not strictly necessary):Your message could say anything, but it's useful to send the version so you know what you're dealing with. Then...Add this to your website somewhere:This works in Firefox and Chrome, and doesn't incur HTTP overhead or manipulate the page.If you have control over the Chrome extension, you can try what I did:And then:It feels a little hacky, but I couldn't get the other methods to work, and I worry about Chrome changing its API here. It's doubtful this method will stop working any time soon.You could also use a cross-browser method what I have used.

Uses the concept of adding a div.in your content script (whenever the script loads, it should do this)in your website you assert something like,And throw appropriate message.If you're trying to detect any extension from any website,

This post helped: https://ide.hey.network/post/5c3b6c7aa7af38479accc0c7Basically, the solution would be to simply try to get a specific file (manifest.json or an image) from the extension by specifying its path. Here's what I used. Definitely working:

detect ipad/iphone webview via javascript

sod

[detect ipad/iphone webview via javascript](https://stackoverflow.com/questions/4460205/detect-ipad-iphone-webview-via-javascript)

Is there a way to differ via javascript if the website runs inside the ipad safari or inside an application WebView?

2010-12-16 11:20:00Z

Is there a way to differ via javascript if the website runs inside the ipad safari or inside an application WebView?This uses a combination of window.navigator.userAgent and window.navigator.standalone. It can distinguish between all four states relating to an iOS web app: safari (browser), standalone (fullscreen), uiwebview, and not iOS.Demo: http://jsfiddle.net/ThinkingStiff/6qrbn/Running in UIWebViewRunning in Safari on iPadRunning in Safari on Mac OS XRunning in Chrome on Mac OS XRunning in FireFox on Mac OS XI think that you can just use the User-Agent.UPDATEPage browsed using iPhone Safari I will try in a second with UIWebViewThe difference is that the Safari one says Safari/6531.22.7SolutionYeah:I've tried all these solutions but didn't work in my case,

I was going to detect Telegram inside Webview.

I've noticed Safari is changing phone style text to a link with "tel:" prefix, so I've used this to write this code, you can test it : jsfiddleNeoneye's solution does not work anymore (see comments) and can be simplified.

On the other hand, testing only "Safari" in the UA adresses much more than the ios handheld devices.This is the test i'm using :For the Spring of 2018 none of proposed method worked for me so I came up with a new approach (which is not userAgent based):https://gist.github.com/BorisChumichev/7c0ea033daf33da73306a396ffa174d1You are welcome to extend the code for iPad devices too, I think it should do the trick.Worked well for Telegram, Facebook, VK webviews.Working 15.02.19Another solution for detecting webviews on iOS is checking for the support / existence of navigator.mediaDevices.In my case I didn't need to catch all webviews, but those that don't support camera / microphone input (Reminder: Alerts don't trigger in Webview, so make sure to change something in the dom for debug purposes)I know this code will check if it is being accessed from an icon added to the home screen:but I'm not sure how it would react in a UIWebView. The only other solution I could think of is getting the user agent or using - (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType and replacing the query string of the page you are accessing with something the page uses to identify that it is being accessed from a web view.Would suggest using Modernizr, and checking for indexeddb like this. You could cross-check that with user agent configuration (device, OS, browser, etc), but pure feature detection seems more recommended.Last time I needed this (JUST for WebView purposes), I used this check:I have found a simple solution to detect iPhone or iPad. This works for me fine.Try With IOS 13I don't think there's anything specific you can use in client-side Javascript, but if you have control over what the originating UIWebView can do, you might want to consider playing with the user agent string it generates, and testing for that in your client-side Javascript instead? A bit of a hack I know, but hey… This question may give some pointers on tweaking the user agent:Change User Agent in UIWebView (iPhone SDK)@ Sod, 

Well i don’t have answer, but i am not convinced why you want to check, Since, browser engine whether its safari ( Browser ) or Application will be same its Webkit only, 

Yes Application can configure the Browser engine capabilities like, whether application wants to run JS or Display Image etc… I believe, you must check for certain property whether Flash supported by Browser or whether browser displays image or not, or probably may be you would like to check the screen size, 

What is useState() in React?

Hemadri Dasari

[What is useState() in React?](https://stackoverflow.com/questions/53165945/what-is-usestate-in-react)

I am currently learning hooks concept in React and trying to understand below example.The above example increments the counter on the handler function parameter itself. What if I want to modify count value inside event handler functionConsider below example

2018-11-06 04:56:10Z

I am currently learning hooks concept in React and trying to understand below example.The above example increments the counter on the handler function parameter itself. What if I want to modify count value inside event handler functionConsider below exampleReact hooks are a new way (still being developed) to access the core features of react such as state without having to use classes, in your example if you want to increment a counter directly in the handler function without specifying it directly in the onClick prop, you could do something like:and onClick:Let's quickly explain what is going on in this line:useState(0) returns a tuple where the first parameter count is the current state of the counter and setCounter is the method that will allow us to update the counter's state. We can use the setCounter method to update the state of count anywhere - In this case we are using it inside of the setCount function where we can do more things; the idea with hooks is that we are able to keep our code more functional and avoid class based components if not desired/needed.I wrote a complete article about hooks with multiple examples (including counters) such as this codepen, I made use of useState, useEffect, useContext, and custom hooks. I could get into more details about how hooks work on this answer but the documentation does a very good job explaining the state hook and other hooks in detail, hope it helps.update: Hooks are not longer a proposal, since version 16.8 they're now available to be used, there is a section in React's site that answers some of the FAQ.useState is one of build-in react hooks available in 0.16.7 version.useState should be used only inside functional components. useState is the way if we need an internal state and don't need to implement more complex logic such as lifecycle methods.Please note that useState hook callback for updating the state behaves differently than components this.setState. To show you the difference I prepared two examples.New object is created when setUserInfo callback is used. Notice we lost lastName key value. To fixed that we could pass function inside useState.See example:For more about useState see official documentation.The syntax of useState hook is straightforward.const [value, setValue] = useState(defaultValue)If you are not familiar with this syntax, go here.I would recommend you reading the documentation.There are excellent explanations with decent amount of examples.useState is one of the hooks available in React v16.8.0. It basically lets you turn your otherwise non-stateful/functional components to one that can have its own state.At the very basic level, it's used this way:This then lets you call setLoading passing a boolean value.

It's a cool way of having "stateful" functional component.useState() is a React hook. Hooks make possible to use state and mutability inside function components.While you can't use hooks inside classes you can wrap your class component with a function one and use hooks from it. This is a great tool for migrating components from class to function form. Here is a complete example:For this example I will use a counter component. This is it:It is a simple class component with a count state, and state update is done by methods. This is very common pattern in class components. The first thing is to wrap it with a function component with just the same name, that delegate all its properties to the wrapped component. Also you need to render the wrapped component in the function return. Here it is:This is exactly the same component, with the same behavior, same name and same properties. Now lets lift the counting state to the function component. This is how it goes:Note that the method inc is still there, it wont hurt anybody, in fact is dead code. This is the idea, just keep lifting state up. Once you finished you can remove the class component:While this makes possible to use hooks inside class components, I would not recommend you to do so except if you migrating like I did in this example. Mixing function and class components will make state management a mess. I hope this helpsBest RegardsHooks are a new feature in React v16.7.0-alpha useState is the「Hook」. useState() set the default value of the any variable and manage in function component(PureComponent functions).  ex : const [count, setCount] = useState(0); set the default value of count 0. and u can use setCount to increment or decrement the value. onClick={() => setCount(count + 1)} increment the count value.DOCuseState() is an example built-in React hook that lets you use states in your functional components. This was not possible before React 16.7.The useState function is a built in hook that can be imported from the react package. It allows you to add state to your functional components. Using the useState hook inside a function component, you can create a piece of state without switching to class components.Thanks loelsonk,  i did so

Generate unique random numbers between 1 and 100

dotty

[Generate unique random numbers between 1 and 100](https://stackoverflow.com/questions/2380019/generate-unique-random-numbers-between-1-and-100)

How can I generate some unique random numbers between 1 and 100 using JavaScript?

2010-03-04 14:34:09Z

How can I generate some unique random numbers between 1 and 100 using JavaScript?For example: To generate 8 unique random numbers and store them to an array, you can simply do this:Generate permutation of 100 numbers and then choose serially.Use Knuth Shuffle(aka the Fisher-Yates shuffle) Algorithm.JavaScript:CODE COPIED FROM LINK.EDIT:Improved code:Potential problem:Suppose we have array of 100 numbers {e.g. [1,2,3...100]} and we stop swapping after 8 swaps;

then most of the times array will look like {1,2,3,76,5,6,7,8,...numbers here will be shuffled ...10}.Because every number will be swapped with probability 1/100 so 

prob. of swapping first 8 numbers is 8/100 whereas prob. of swapping other 92 is 92/100.But if we run algorithm for full array then we are sure (almost)every entry is swapped.Otherwise we face a question : which 8 numbers to choose?The above techniques are good if you want to avoid a library, but depending if you would be alright with a library, I would suggest checking out Chance for generating random stuff in JavaScript.Specifically to solve your question, using Chance it's as easy as:Disclaimer, as the author of Chance, I am a bit biased ;)To avoid any long and unreliable shuffles, I'd do the following...Voila - no repeated numbers.I may post some actual code later, if anybody is interested.Edit: It's probably the competitive streak in me but, having seen the post by @Alsciende, I couldn't resist posting the code that I promised.Modern JS Solution using Set (and average case O(n))Another simpler approach is to generate an 100 items array with ascending numbers and sort it randomly. This leads actually to a really short and (in my opinion) simple snippet.I would do this:This is a very generic function I have written to generate random unique/non-unique integers for an array. Assume the last parameter to be true in this scenario for this answer.Here the 'tempObj' is a very useful obj since every random number generated will directly check in this tempObj if that key already exists, if not, then we reduce the i by one since we need 1 extra run since the current random number already exists.In your case, run the followingThat's all.Shuffling the numbers from 1 to 100 is the right basic strategy, but if you need only 8 shuffled numbers, there's no need to shuffle all 100 numbers.I don't know Javascript very well, but I believe it's easy to create an array of 100 nulls quickly.  Then, for 8 rounds, you swap the n'th element of the array (n starting at 0) with a randomly selected element from n+1 through 99.  Of course, any elements not populated yet mean that the element would really have been the original index plus 1, so that's trivial to factor in.  When you're done with the 8 rounds, the first 8 elements of your array will have your 8 shuffled numbers.Same permutation algorithm as The Machine Charmer, but with a prototyped implementation. Better suited to large number of picks. Uses js 1.7 destructuring assignment if available.Edit:

An other proposition, better suited to small number of picks, based on belugabob's answer. To guarantee uniqueness, we remove the picked numbers from the array.for arrays with holes like this [,2,,4,,6,7,,]

because my problem was to fill these holes. So I modified it as per my need :)the following modified solution worked for me :)The best earlier answer is the answer by sje397. You will get as good random numbers as you can get, as quick as possible.My solution is very similar to his solution. However, sometimes you want the random numbers in random order, and that is why I decided to post an answer. In addition, I provide a general function.shorter than other answers I've seenHere is my ES6 version I cobbled together. I'm sure it can be a little more consolidated.How about using object properties as a hash table? This way your best scenario is to only randomize 8 times. It would only be effective if you want a small part of the range of numbers. It's also much less memory intensive than Fisher-Yates because you don't have to allocate space for an array.I then found out that Object.keys(obj) is an ECMAScript 5 feature so the above is pretty much useless on the internets right now. Fear not, because I made it ECMAScript 3 compatible by adding a keys function like this.if you need more unique you must generate a array(1..100).above code is  faster:

extractUniqueRandomArray(50)=>

[2, 79, 38, 59, 63, 42, 52, 22, 78, 50, 39, 77, 1, 88, 40, 23, 48, 84, 91, 49, 4, 54, 93, 36, 100, 82, 62, 41, 89, 12, 24, 31, 86, 92, 64, 75, 70, 61, 67, 98, 76, 80, 56, 90, 83, 44, 43, 47, 7, 53]Adding another better version of same code (accepted answer) with JavaScript 1.6 indexOf function. Do not need to loop thru whole array every time you are checking the duplicate.Older version of Javascript can still use the version at topPS: Tried suggesting an update to the wiki but it was rejected. I still think it may be useful for others.This is my personal solution :It randomly generates 8 unique array values (between 0 and 7), then displays them using an alert box.I think this method is different from methods given in most of the answers, so I thought I might add an answer here (though the question was asked 4 years ago). 

 We generate 100 random numbers, and tag each of them with numbers from 1 to 100. Then we sort these tagged random numbers, and the tags get shuffled randomly. Alternatively, as needed in this question, one could do away with just finding top 8 of the tagged random numbers. Finding top 8 items is cheaper than sorting the whole array.

 One must note here, that the sorting algorithm influences this algorithm. If the sorting algorithm used is stable, there is slight bias in favor of smaller numbers. Ideally, we would want the sorting algorithm to be unstable and not even biased towards stability (or instability) to produce an answer with perfectly uniform probability distribution.This can handle generating upto 20 digit UNIQUE random numberJSjsFiddleThis solution uses the hash which is much more performant O(1) than checking if the resides in the array. It has extra safe checks too. Hope it helps.Implementing this as a generator makes it pretty nice to work with. Note, this implementation differs from ones that require the entire input array to be shuffled first. I chose to implement sample in a way that does not mutate the input array, but you could easily argue that a mutating implementation is favourable.For example, the shuffle function might wish to mutate the original input array. Or you might wish to sample from the same input at various times, updating the input each time.sample is no longer a pure function because of the array input mutation, but in certain circumstances (demonstrated above) it might make more sense.Another reason I chose a generator instead of a function that just returns an array is because you may want to continue sampling until some specific condition.Perhaps I want the first prime number from a list of 1,000,000 random numbers.Because we're working with a generator, this task is trivialThis will continuously sample 1 random number at a time, x, check if it's prime, then return x if it is. If the list of numbers is exhausted before a prime is found, NaN is returned.Note:This answer was originally shared on another question that was closed as a duplicate of this one. Because it's very different from the other solutions provided here, I've decided to share it here as wellUsing a Set is your fastest option.  Here is a generic function for getting a unique random that uses a callback generator.  Now it's fast and reusable.You can also do it with a one liner like this:[...((add, set) => add(set, add))((set, add) => set.size < 8 ? add(set.add(Math.floor(Math.random()*100) + 1), add) : set, new Set())]

How to getElementByClass instead of GetElementById with JavaScript?

Alan

[How to getElementByClass instead of GetElementById with JavaScript?](https://stackoverflow.com/questions/1933602/how-to-getelementbyclass-instead-of-getelementbyid-with-javascript)

I'm trying to toggle the visibility of certain DIV elements on a website depending on the class of each DIV. I'm using a basic JavaScript snippet to toggle them. The problem is that the script only uses getElementById, as getElementByClass is not supported in JavaScript. And unfortunately I do have to use class and not id to name the DIVs because the DIV names are dynamically generated by my XSLT stylesheet using certain category names.I know that certain browsers now support getElementByClass, but since Internet Explorer doesn't I don't want to go that route.I've found scripts using functions to get elements by class (such as #8 on this page: http://www.dustindiaz.com/top-ten-javascript/), but I can't figure out how to integrate them with with my toggle script.Here's the HTML code. The DIVs themselves are missing since they are generated on page load with XML/XSLT.Main Question: How do I get the below Toggle script to get Element by Class instead of get Element by ID?

2009-12-19 17:38:46Z

I'm trying to toggle the visibility of certain DIV elements on a website depending on the class of each DIV. I'm using a basic JavaScript snippet to toggle them. The problem is that the script only uses getElementById, as getElementByClass is not supported in JavaScript. And unfortunately I do have to use class and not id to name the DIVs because the DIV names are dynamically generated by my XSLT stylesheet using certain category names.I know that certain browsers now support getElementByClass, but since Internet Explorer doesn't I don't want to go that route.I've found scripts using functions to get elements by class (such as #8 on this page: http://www.dustindiaz.com/top-ten-javascript/), but I can't figure out how to integrate them with with my toggle script.Here's the HTML code. The DIVs themselves are missing since they are generated on page load with XML/XSLT.Main Question: How do I get the below Toggle script to get Element by Class instead of get Element by ID?Modern browsers have support for document.getElementsByClassName. You can see the full breakdown of which vendors provide this functionality at caniuse. If you're looking to extend support into older browsers, you may want to consider a selector engine like that found in jQuery or a polyfill.You'll want to check into jQuery, which will allow the following:Google offers a hosted jQuery source-file, so you can reference it and be up-and-running in moments. Include the following in your page:The getElementsByClassName method is now natively supported by the most recent versions of Firefox, Safari, Chrome, IE and Opera, you could make a function to check if a native implementation is available, otherwise use the Dustin Diaz method:Usage:Acyually by using getElementsByClassName, it returns an array of multiple classes. Because same class name could be used in more than one instance inside same HTML page. We use array element id to target the class we need, in my case, it's first instance of the given class name.So I've used [0]Use it to access class in Javascript.adding to CMS's answer, this is a more generic approach of toggle_visibility I've just used myself:My solution:First create "<style>" tags with an ID.Then, I create a function in JavaScript like this:Worked like a charm for me.Append IDs at the class declaration

Is there a function to deselect all text using JavaScript?

NoodleOfDeath

[Is there a function to deselect all text using JavaScript?](https://stackoverflow.com/questions/6562727/is-there-a-function-to-deselect-all-text-using-javascript)

Is there a function in javascript to just deselect all selected text? I figure it's got to be a simple global function like document.body.deselectAll(); or something.

2011-07-03 12:00:34Z

Is there a function in javascript to just deselect all selected text? I figure it's got to be a simple global function like document.body.deselectAll(); or something.Try this:This will clear a selection in regular HTML content in any major browser. It won't clear a selection in a text input or <textarea> in Firefox.Here's a version that will clear any selection, including within text inputs and textareas:Demo: http://jsfiddle.net/SLQpM/23/For Internet Explorer, you can use the empty method of the document.selection object:For a cross-browser solution, see this answer:Clear a selection in FirefoxFor a textarea element with at least 10 characters the following will make a small selection and then after a second and a half deselect it:

How to create a column range chart in Highcharts using range and navigator functions?

AabinGunz

[How to create a column range chart in Highcharts using range and navigator functions?](https://stackoverflow.com/questions/28088958/how-to-create-a-column-range-chart-in-highcharts-using-range-and-navigator-funct)

I have a requirement to plot run  history of a task in Highcharts.  It needs to show that run history of the tasks as a horizontal bar.  There are additional requirements which I've added as an update below. Recently I found out that inverted option is not supported in StockChart and that only navigator & rangeSelector are available in StockChart.  Therefore I am using those functions.So in order to achieve the requirement I created something similar to this jsfiddle example (found somewhere while browsing don't remember the source) and ended up with this plunker link with help from my previous question, thanks to Pawel FusUpdating question to avoid confusionAdditional requirements:Show only those tasks which ran in a particular date and time range. In case there are too many runs, such as more than 10 run, then there needs to be a way to display only 10 tasks visibly with a y-axis that is scrollable to show other tasks.

plunker link to the problemProblem explanation of above plunker.If you check the screenshot below from above plunker, the time range is from 12/12/2014 09:32:26 to 12/12/2014 10:32:26 and there are only 2 tasks that has run m_ARRAYV_SALES_ZIG1_CALL2_VOD__C_OB & m_ZIG2_HCP_MERGE_IB_CN. However I can see another task in between LILLY_C which did not even ran in this date time range. (In actual data there are more than 10 tasks that clutters this chart which does not even fall under this date time range)Also if you notice at the bottom most right corner time shifted from 09:38 to 19:20. 19:20 is the end time for m_ZIG2_HCP_MERGE_IB_CN task.

Below is my chart options

2015-01-22 12:37:05Z

I have a requirement to plot run  history of a task in Highcharts.  It needs to show that run history of the tasks as a horizontal bar.  There are additional requirements which I've added as an update below. Recently I found out that inverted option is not supported in StockChart and that only navigator & rangeSelector are available in StockChart.  Therefore I am using those functions.So in order to achieve the requirement I created something similar to this jsfiddle example (found somewhere while browsing don't remember the source) and ended up with this plunker link with help from my previous question, thanks to Pawel FusUpdating question to avoid confusionAdditional requirements:Show only those tasks which ran in a particular date and time range. In case there are too many runs, such as more than 10 run, then there needs to be a way to display only 10 tasks visibly with a y-axis that is scrollable to show other tasks.

plunker link to the problemProblem explanation of above plunker.If you check the screenshot below from above plunker, the time range is from 12/12/2014 09:32:26 to 12/12/2014 10:32:26 and there are only 2 tasks that has run m_ARRAYV_SALES_ZIG1_CALL2_VOD__C_OB & m_ZIG2_HCP_MERGE_IB_CN. However I can see another task in between LILLY_C which did not even ran in this date time range. (In actual data there are more than 10 tasks that clutters this chart which does not even fall under this date time range)Also if you notice at the bottom most right corner time shifted from 09:38 to 19:20. 19:20 is the end time for m_ZIG2_HCP_MERGE_IB_CN task.

Below is my chart optionsSo after a few hours of digging, I have just found out the culprit (or I really hope so). The problem is your definition of yAxis label formatter:You don't actually check if you should display the label according to task.intervals (see json.js). A simple update (Plunker) of the formatter seems to work:See Plunker for demo.Meaning of the yAxis labels is: Show label if you see a run in the graph or if there is a run on the right of the graph. Please modify the conditionas you see fit.Disclaimer: I don't use Highcharts, so this answer tries to explain the problem and not to suggest a Highcharts-way of solving the problem.Lessons learned:

How to send a message to a particular client with socket.io

Nizar B.

[How to send a message to a particular client with socket.io](https://stackoverflow.com/questions/17476294/how-to-send-a-message-to-a-particular-client-with-socket-io)

I'm starting with socket.io + node.js, I know how to send a message locally and to broadcast socket.broadcast.emit() function:- all the connected clients receive the same message.Now, I would like to know how to send a private message to a particular client, I mean one socket for a private chat between 2 person (Client-To-Client stream). Thanks.

2013-07-04 18:22:21Z

I'm starting with socket.io + node.js, I know how to send a message locally and to broadcast socket.broadcast.emit() function:- all the connected clients receive the same message.Now, I would like to know how to send a private message to a particular client, I mean one socket for a private chat between 2 person (Client-To-Client stream). Thanks.When a user connects, it should send a message to the server with a username which has to be unique, like an email. A pair of username and socket should be stored in an object like this:On the client, emit an object to the server with the following data:On the server, listen for messages. When a message is received, emit the data to the receiver.On the client, listen for emits from the server called 'receivedMessage', and by reading the data you can handle who it came from and the message that was sent. You can use socket.io rooms. From the client side emit an event ("join" in this case, can be anything) with any unique identifier (email, id).Client Side:Now, from the server side use that information to create an unique room for that userServer Side:So, now every user has joined a room named after user's email. So if you want to send a specific user a message you just have toServer Side:The last thing left to do on the client side is listen to the "new_msg" event.Client Side:I hope you get the idea.SURE:

Simply,This is what you need :whenever a user joined to the server, socket details will be generated including ID. This is the ID really helps to send a message to particular people.first we need to store all the socket.ids in array,here name is the receiver name.

Example:So, now we can get that socket.id with the receiver name whenever we are sending message:for this we need to know the receivername. You need to emit receiver name to the server.final thing is:Hope this works well for you.Good Luck!!You can refer to socket.io rooms. 

When you handshaked socket - you can join him to named room, for instance "user.#{userid}". After that, you can send private message to any client by convenient name, for instance:In operation above we send "new_message" to user "125".thanks.In a project of our company we are using "rooms" approach and it's name is a combination of user ids of all users in a conversation as a unique identifier (our implementation is more like facebook messenger), example:|id | name

|1  | Scott

|2  | Susan"room" name will be "1-2" (ids are ordered Asc.) and on disconnect socket.io automatically cleans up the room this way you send messages just to that room and only to online (connected) users (less packages sent throughout the server). Let me make it simpler with socket.io rooms. request a server with a unique identifier to join a server. here we are using an email as a unique identifier.Client Socket.io When the user joined a server, create a room for that userServer Socket.ioNow we are all set with joining. let emit something to from the server to room, so that user can listen.Server Socket.ioLet finalize the topic with listening to message event to the client sideThe reference from  Socket.io rooms

ReactJS: setTimeout() not working?

jbarradas

[ReactJS: setTimeout() not working?](https://stackoverflow.com/questions/36270422/reactjs-settimeout-not-working)

Having this code in mind: Isn't the state supposed to change only after 3 seconds? It's changing immediately. My main goal here is to change the state every 3 seconds (with setInterval()), but since it was not working, I tried setTimeout(), which is not working either. Any lights on this? Thanks!

2016-03-28 20:17:18Z

Having this code in mind: Isn't the state supposed to change only after 3 seconds? It's changing immediately. My main goal here is to change the state every 3 seconds (with setInterval()), but since it was not working, I tried setTimeout(), which is not working either. Any lights on this? Thanks!DoOtherwise, you are passing the result of setState to setTimeout.The above would also work because the ES6 arrow function does not change the context of this.Anytime we create a timeout we should s clear it on componentWillUnmount, if it hasn't fired yet.I know this is a little old, but is important to notice that React recomends to clear the interval when the component unmounts: https://reactjs.org/docs/state-and-lifecycle.htmlSo I like to add this answer to this discussion:setState is being invoked immediately due to the parenthesis! Wrap it in an anonymous function, then call it:Here how you call timeout without calling additional functions.Uses function.prototype.bind()setTimeout takes the location of the function and keeps it in the context.Probably uses the same bind method at some pointThe setTimeout only takes the location of the function and the function already has the context? Anyway, it works!NOTE: These work with any function you use in js.Your code scope (this) will be your window object, not your react component, and that is why setTimeout(this.setState({position: 1}), 3000) will crash this way.That comes from javascript not React, it is js closureSo, in order to bind your current react component scope, do this:Or if your browser supports es6 or your projs has support to compile es6 to es5, try arrow function as well, as arrow func is to fix 'this' issue:There's a 3 ways to access the scope inside of the 'setTimeout' functionFirst,Second is to use ES6 arrow function, cause arrow function didn't have itself scope(this)Third one is to bind the scope inside of the functionYou did syntax declaration error, use proper setTimeout declaration 

Iterating over every property of an object in javascript using Prototype?

OverloadUT

[Iterating over every property of an object in javascript using Prototype?](https://stackoverflow.com/questions/587881/iterating-over-every-property-of-an-object-in-javascript-using-prototype)

Is there a way to iterate over every property of an object using the Prototype JavaScript framework?Here's the situation: I am getting an AJAX response in JSON that looks something like this:If I evaluate that json response in to a variable response, I want to be able to iterate over each property in the response.barobj object to see which indexes are true and which are false.Prototype has both Object.keys() and Object.values() but oddly seems to not have a simple Object.each() function! I could take the results of Object.keys() and Object.values() and cross-reference the other as I iterate through one, but that is such a hack that I am sure there is a proper way to do it!

2009-02-25 21:15:42Z

Is there a way to iterate over every property of an object using the Prototype JavaScript framework?Here's the situation: I am getting an AJAX response in JSON that looks something like this:If I evaluate that json response in to a variable response, I want to be able to iterate over each property in the response.barobj object to see which indexes are true and which are false.Prototype has both Object.keys() and Object.values() but oddly seems to not have a simple Object.each() function! I could take the results of Object.keys() and Object.values() and cross-reference the other as I iterate through one, but that is such a hack that I am sure there is a proper way to do it!You have to first convert your object literal to a Prototype Hash:There's no need for Prototype here: JavaScript has for..in loops. If you're not sure that no one messed with Object.prototype, check hasOwnProperty() as well, ieYou should iterate over the keys and get the values using square brackets.See: How do I enumerate the properties of a javascript object?EDIT: Obviously, this makes the question a duplicate.

Remove all classes except one

DarkGhostHunter

[Remove all classes except one](https://stackoverflow.com/questions/5363289/remove-all-classes-except-one)

Well, I know that with some jQuery actions, we can add a lot of classes to a particular div:Let's say that with some clicks and other things, the div gets a lot of classesSo, how I can remove all the classes except one? The only idea I have come up is with this:While removeClass() kills all the classes, the div get screwed up, but adding just after that addClass('cleanstate') it goes back to normal. The other solution is to put an ID attribute with the base CSS properties so they don't get deleted, what also improves performance, but i just want to know another solution to get rid of all except ".cleanstate"I'm asking this because, in the real script, the div suffers various changes of classes.

2011-03-19 16:26:22Z

Well, I know that with some jQuery actions, we can add a lot of classes to a particular div:Let's say that with some clicks and other things, the div gets a lot of classesSo, how I can remove all the classes except one? The only idea I have come up is with this:While removeClass() kills all the classes, the div get screwed up, but adding just after that addClass('cleanstate') it goes back to normal. The other solution is to put an ID attribute with the base CSS properties so they don't get deleted, what also improves performance, but i just want to know another solution to get rid of all except ".cleanstate"I'm asking this because, in the real script, the div suffers various changes of classes.Instead of doing it in 2 steps, you could just reset the entire value at once with attr by overwriting all of the class values with the class you want:Sample: http://jsfiddle.net/jtmKK/1/Use attr to directly set the class attribute to the specific value you want:With plain old JavaScript, not JQuery:Sometimes you need to keep some of the classes due to CSS animation, because as soon as you remove all classes, animation may not work. Instead, you can keep some classes and remove the rest like this:regarding to robs answer and for and for the sake of completeness you can also use querySelector with vanillaWhat if if you want to keep one or more than one classes and want classes except these. These solution would not work where you don't want to remove all classes add that perticular class again.

Using attr and removeClass() resets all classes in first instance and then attach that perticular class again. If you using some animation on classes which are being reset again, it will fail.If you want to simply remove all classes except some class then this is for you.

My solution is for: removeAllExceptTheseThis will not reset all classes, it will remove only necessary.

I needed it in my project where I needed to remove only not matching classes.You can use it $(".third").removeClassesExceptThese(["first", "second"]);

How to create JSON string in JavaScript?

indianwebdevil

[How to create JSON string in JavaScript?](https://stackoverflow.com/questions/8963693/how-to-create-json-string-in-javascript)

In a code something like this, I am trying to create JSON string just to play around. It's throwing error, but if I put all the name, age, married in one single line (line 2) it doesn't. Whats the problem?

2012-01-22 18:57:27Z

In a code something like this, I am trying to create JSON string just to play around. It's throwing error, but if I put all the name, age, married in one single line (line 2) it doesn't. Whats the problem?Javascript doesn't handle Strings over multiple lines.You will need to concatenate those:You can also use template literals in ES6 and above: (See here for the documentation)The way i do it is:I guess this way can reduce chances for errors.The function JSON.stringify will turn your json object into a string:In case the browser does not implement it (IE6/IE7), use the JSON2.js script. It's safe as it uses the native implementation if it exists.This can be pretty easy and simpleUse JSON.stringify:I think this way helps you...There is a "official" JSON implementation http://www.json.org/js.html by Crockford: https://github.com/douglascrockford/JSON-jsjson strings can't have line breaks in them. You'd have to make it all one line: {"key":"val","key2":"val2",etc....}.But don't generate JSON strings yourself. There's plenty of libraries that do it for you, the biggest of which is jquery.

Google Maps API v3: How to remove an Event Listener?

mp_

[Google Maps API v3: How to remove an Event Listener?](https://stackoverflow.com/questions/1544151/google-maps-api-v3-how-to-remove-an-event-listener)

How do I remove the 'bounds_changed' Event listener in Google Maps API v3?

2009-10-09 14:33:06Z

How do I remove the 'bounds_changed' Event listener in Google Maps API v3?Usually you can find answers to such questions in Google Maps API documentation.As Andrew said, addListener returns a handle which you can use later to remove the listener. That's because a single event can have many listeners and to remove them you must save a reference to each of attached listeners.There's also a function which removes all of the listeners at the same time:Here's the Google Maps API reference where you can read about it.addListener returns a handle which you can later pass to removeListener:This seems to work in the current release.If you couldnt hold the listener object somehow you could remove listener(s) directly as google.maps.event.clearListeners(objectListened, 'event');Ex: google.maps.event.clearListeners(map, 'bounds_changed');

How to remove element from array in forEach loop?

novicePrgrmr

[How to remove element from array in forEach loop?](https://stackoverflow.com/questions/24812930/how-to-remove-element-from-array-in-foreach-loop)

I am trying to remove an element in an array in a forEach loop, but am having trouble with the standard solutions I've seen. This is what I'm currently trying:I know it's getting into the if because I'm seeing YippeeeeeE!!!!!!!!!!!!! in the console. MY PROBLEM: I know that my for loop and if logic are sound, but my attempt to remove the current element from the array is failing.UPDATE:Tried out Xotic750's answer, and the element is still not being removed:Here is the function in my code:Here is the output where the array is still not removed:So obviously it is going into the if statement as directed, but it's also obvious that the [• • •] is still there.

2014-07-17 20:28:22Z

I am trying to remove an element in an array in a forEach loop, but am having trouble with the standard solutions I've seen. This is what I'm currently trying:I know it's getting into the if because I'm seeing YippeeeeeE!!!!!!!!!!!!! in the console. MY PROBLEM: I know that my for loop and if logic are sound, but my attempt to remove the current element from the array is failing.UPDATE:Tried out Xotic750's answer, and the element is still not being removed:Here is the function in my code:Here is the output where the array is still not removed:So obviously it is going into the if statement as directed, but it's also obvious that the [• • •] is still there.It looks like you are trying to do this?Iterate and mutate an array using Array.prototype.splice

Which works fine for simple case where you do not have 2 of the same values as adjacent array items, other wise you have this problem.So what can we do about this problem when iterating and mutating an array? Well the usual solution is to work in reverse. Using ES3 while but you could use for sugar if preferredOk, but you wanted you wanted to use ES5 iteration methods. Well and option would be to use Array.prototype.filter but this does not mutate the original array but creates a new one, so while you can get the correct answer it is not what you appear to have specified.We could also use ES5 Array.prototype.reduceRight, not for its reducing property by rather its iteration property, i.e. iterate in reverse.Or we could use ES5 Array.protoype.indexOf like so.But you specifically want to use ES5 Array.prototype.forEach, so what can we do? Well we need to use Array.prototype.slice to make a shallow copy of the array and Array.prototype.reverse so we can work in reverse to mutate the original array.Finally ES6 offers us some further alternatives, where we do not need to make shallow copies and reverse them. Notably we can use Generators and Iterators. However support is fairly low at present.Something to note in all of the above is that, if you were stripping NaN from the array then comparing with equals is not going to work because in Javascript NaN === NaN is false. But we are going to ignore that in the solutions as it it yet another unspecified edge case.So there we have it, a more complete answer with solutions that still have edge cases. The very first code example is still correct but as stated, it is not without issues.Use Array.prototype.filter instead of forEach:Although Xotic750's answer provides several good points and possible solutions, sometimes simple is better.You know the array being iterated on is being mutated in the iteration itself (i.e. removing an item => index changes), thus the simplest logic is to go backwards in an old fashioned for (à la C language):If you really think about it, a forEach is just syntactic sugar for a for loop... So if it's not helping you, just please stop breaking your head against it.You could also use indexOf instead to do thisI understood that you want to remove from the array using a condition and have another array that has items removed from the array. Is right?How about this?Hope this help...By the way, I compared 'for-loop' to 'forEach'.If remove in case a string contains 'f', a result is different.And remove by each iteration, also a result is different.The following will give you all the elements which is not equal to your special characters!  Here is how you should do it:

Sequelize.js delete query?

lakenen

[Sequelize.js delete query?](https://stackoverflow.com/questions/8402597/sequelize-js-delete-query)

Is there a way to write a delete/deleteAll query like findAll?For example I want to do something like this (assuming MyModel is a Sequelize model...):

2011-12-06 15:40:58Z

Is there a way to write a delete/deleteAll query like findAll?For example I want to do something like this (assuming MyModel is a Sequelize model...):For anyone using Sequelize version 3 and above, use:Sequelize Documentation - Sequelize TutorialI've searched deep into the code, step by step into the following files:https://github.com/sdepold/sequelize/blob/master/test/Model/destroy.jshttps://github.com/sdepold/sequelize/blob/master/lib/model.js#L140https://github.com/sdepold/sequelize/blob/master/lib/query-interface.js#L207-217https://github.com/sdepold/sequelize/blob/master/lib/connectors/mysql/query-generator.jsWhat I found:There isn't a deleteAll method, there's a destroy() method you can call on a record, for example:Don't know if the question is still relevant but I have found the following on Sequelize's documentation.http://sequelizejs.com/blog/state-of-v1-7-0Hope it helps!This example shows how to you promises instead of callback.Check this link out for more info

http://docs.sequelizejs.com/en/latest/api/model/#destroyoptions-promiseintegerIn new version, you can try something like thisI wrote something like this for Sails a while back, in case it saves you some time:Example usage:Source:from: orm.js.Hope that helps!Here's a ES6 using Await / Async example:Please note that I'm using the !! Bang Bang Operator on the result of the await which will change the result into a Boolean.

jQuery xml error ' No 'Access-Control-Allow-Origin' header is present on the requested resource.'

Bazinga777

[jQuery xml error ' No 'Access-Control-Allow-Origin' header is present on the requested resource.'](https://stackoverflow.com/questions/19821753/jquery-xml-error-no-access-control-allow-origin-header-is-present-on-the-req)

I am working on this personal project of mine just for fun where I want to read an xml file which is located at http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml  and parse the xml and use it to convert values between the currencies. So far I have come up with the code below which is pretty basic in order to read the xml but I get the following error.I don't see anything wrong with my code so I am hoping someone could point out what I am doing wrong with my code and how I could fix it. 

2013-11-06 20:07:53Z

I am working on this personal project of mine just for fun where I want to read an xml file which is located at http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml  and parse the xml and use it to convert values between the currencies. So far I have come up with the code below which is pretty basic in order to read the xml but I get the following error.I don't see anything wrong with my code so I am hoping someone could point out what I am doing wrong with my code and how I could fix it. You won't be able to make an ajax call to http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml from a file deployed at http://run.jsbin.com due to the same-origin policy.As the source (aka origin) page and the target URL are at different domains (run.jsbin.com and www.ecb.europa.eu), your code is actually attempting to make a Cross-domain (CORS) request, not an ordinary GET.In a few words, the same-origin policy says that browsers should only allow ajax calls to services at the same domain of the HTML page.A page at http://www.example.com/myPage.html can only directly request services that are at http://www.example.com, like http://www.example.com/api/myService. If the service is hosted at another domain (say http://www.ok.com/api/myService), the browser won't make the call directly (as you'd expect). Instead, it will try to make a CORS request.To put it shortly, to perform a (CORS) request* across different domains, your browser:

* The above depicts the steps in a simple request, such as a regular GET with no fancy headers. If the request is not simple (like a POST with application/json as content type), the browser will hold it a moment, and, before fulfilling it, will first send an OPTIONS request to the target URL. Like above, it only will continue if the response to this OPTIONS request contains the CORS headers. This OPTIONS call is known as preflight request.

** I'm saying almost because there are other differences between regular calls and CORS calls. An important one is that some headers, even if present in the response, will not be picked up by the browser if they aren't included in the Access-Control-Expose-Headers header.Was it just a typo? Sometimes the JavaScript code has just a typo in the target domain. Have you checked? If the page is at www.example.com it will only make regular calls to www.example.com! Other URLs, such as api.example.com or even example.com or www.example.com:8080 are considered different domains by the browser! Yes, if the port is different, then it is a different domain!Add the headers. The simplest way to enable CORS is by adding the necessary headers (as Access-Control-Allow-Origin) to the server's responses. (Each server/language has a way to do that - check some solutions here.)Last resort: If you don't have server-side access to the service, you can also mirror it (through tools such as reverse proxies), and include all the necessary headers there.There's a kind of hack-tastic way to do it if you have php enabled on your server. Change this line:to this line:and then in the php script (if you have permission to use the file_get_contents() function):Php doesn't seem to mind if that url is from a different origin. Like I said, this is a hacky answer, and I'm sure there's something wrong with it, but it works for me.Edit:

If you want to cache the result in php, here's the php file you would use:Caching code take from here.

In Javascript/jQuery what does (e) mean?

shrewdbeans

[In Javascript/jQuery what does (e) mean?](https://stackoverflow.com/questions/10323392/in-javascript-jquery-what-does-e-mean)

I am new to JavaScript/jQuery and I've been learning how to make functions. A lot of functions have cropped up with (e) in brackets. Let me show you what I mean:It always appears that the function doesn't even use the value of (e), so why is it there so often?

2012-04-25 20:39:41Z

I am new to JavaScript/jQuery and I've been learning how to make functions. A lot of functions have cropped up with (e) in brackets. Let me show you what I mean:It always appears that the function doesn't even use the value of (e), so why is it there so often?e is the short var reference for event object which will be passed to event handlers.The event object essentially has lot of interesting methods and properties that can be used in the event handlers. In the example you have posted is a click handler which is a MouseEventDEMO - Mouse Events DEMO uses e.which and e.typeSome useful references:http://api.jquery.com/category/events/http://www.quirksmode.org/js/events_properties.htmlhttp://www.javascriptkit.com/jsref/event.shtmlhttp://www.quirksmode.org/dom/events/index.htmlhttp://www.w3.org/TR/DOM-Level-3-Events/#event-types-listThe little '(e)' thing is actually part of broader scope of something in Javascript called an event handling function. Every event handling function receives an event object. For the purpose of this discussion, think of an object as a "thing" that holds a bunch of properties (variables) and methods (functions), much like objects in other languages. The handle, the 'e' inside the little (e) thing, is like a variable that allows you to interact with the object (and I use the term variable VERY loosely).Consider the following jQuery examples:What's happening?

When a user clicks on the element with the id "#someLink" (probably an anchor tag), call an anonymous function, "function(e)", and assign the resulting object to a handler, "e". Now take that handler and call one of its methods, "e.preventDefault()", which should prevent the browser from performing the default action for that element.Note: The handle can pretty much be named anything you want (i.e. 'function(billybob)'). The 'e' stands for 'event', which seems to be pretty standard for this type of function.Although 'e.preventDefault()' is probably the most common use of the event handler, the object itself contains many properties and methods that can be accessed via the event handler.Some really good information on this topic can be found at jQuery's learning site, http://learn.jquery.com. Pay special attention to the Using jQuery Core and Events sections.e doesn't have any special meaning. It's just a convention to use e as function parameter name when the parameter is event.It can be as well.The e argument is short for the event object. For example, you might want to create code for anchors that cancels the default action. To do this you would write something like:This means when an <a> tag is clicked, prevent the default action of the click event.While you may see it often, it's not something you have to use within the function even though you have specified it as an argument.In that example, e is just a parameter for that function, but it's the event object that gets passed in through it.In jQuery e short for event, the current event object. It's usually passed as a  parameter for the event function to be fired.Demo: jQuery Events In the demo I used eI may as well have used eventSame thing! Programmers are lazy we use a lot of shorthand, partly it decreases our work, partly is helps with readability. Understanding that will help you understand the mentality of writing code. Today I just wrote a post about "Why do we use the letters like「e」in e.preventDefault()?" and I think my answer will make some sense...At first,let us see the syntax of addEventListenerNormally it will be:

target.addEventListener(type, listener[, useCapture]);And the definition of the parameters of addEventlistener are:(From MDN)But I think there is one thing should be remarked:

When you use Javascript function as the listener, the object that implements the Event interface(object event) will be automatically assigned to the "first parameter" of the function.So,if you use function(e) ,the object will be assigned to "e" because "e" is the only parameter of the function(definitly the first one !),then you can use e.preventDefault to prevent something....let us try the example as below:the result will be : [object MouseEvent]5 and you will prevent the click event.but if you remove the comment sign like :you will get : 8 and an error:"Uncaught TypeError: e.preventDefault is not a function

    at HTMLInputElement. (VM409:69)".Certainly,the click event will not be prevented this time.Because the "e" was defined again in the function.However,if you change the code to:every thing will work propertly again...you will get 8 and the click event be prevented...Therefore, "e" is just a parameter of your function and you need an "e" in you function() to receive the "event object" then perform e.preventDefault(). This is also the reason why you can change the "e" to any words that is not reserved by js.It's a reference to the current event objectIn reference to the above code

$(this) is the element which as some variable.

click is the event that needs to be performed.

the parameter e is automatically passed from js to your function which holds the value of $(this) value and can be used further in your code to do some operation.

javascript variable reference/alias

gpilotino

[javascript variable reference/alias](https://stackoverflow.com/questions/1686990/javascript-variable-reference-alias)

Is it possible in javascript to assign an alias/reference to a local var someway?I mean something C-like:= EDIT =Is it possible to alias arguments.callee in this code?:

2009-11-06 11:22:46Z

Is it possible in javascript to assign an alias/reference to a local var someway?I mean something C-like:= EDIT =Is it possible to alias arguments.callee in this code?:In JavaScript, primitive types such as integers and strings are passed by value whereas objects are passed by reference. So in order to achieve this you need to use an object:To some degree this is possible, you can create an alias to a variable using closures:Whether you can alias something depends on the data type.  Objects, arrays, and functions will be handled by reference and aliasing is possible.  Other types are essentially atomic, and the variable stores the value rather than a reference to a value.arguments.callee is a function, and therefore you can have a reference to it and modify that shared object.Note that if in the above code you were to say self = function() {return 42;}; then self would then refer to a different object than arguments.callee, which remains a reference to foo.  When you have a compound object, the assignment operator replaces the reference, it does not change the referred object.  With atomic values, a case like y++ is equivalent to y = y + 1, which is assigning a 'new' integer to the variable.edit to my previous answer: if you want to count a function's invocations, you might want to try:Here, c serves as the counter, and you do not have to use arguments.callee.Expanding on user187291's post, you could also use getters/setters to get around having to use functions.in 2019 I need to write minified jquery plugins so I need it too this alias and so testing these examples and others ,from other sources,I found a way without copy in the memory of whe entire object ,but creating only a reference.

I tested this already with firefox and watching task manager's tab memory on firefox before.

The code is:

download file using an ajax request

Manuel Di Iorio

[download file using an ajax request](https://stackoverflow.com/questions/20830309/download-file-using-an-ajax-request)

I want to send an  "ajax download request" when I click on a button, so I tried in this way:javascript:download.php:but doesn't work as expected, how can I do ? Thank you in advance

2013-12-29 21:35:10Z

I want to send an  "ajax download request" when I click on a button, so I tried in this way:javascript:download.php:but doesn't work as expected, how can I do ? Thank you in advanceUpdate April 27, 2015Up and coming to the HTML5 scene is the download attribute. It's supported in Firefox and Chrome, and soon to come to IE11. Depending on your needs, you could use it instead of an AJAX request (or using window.location) so long as the file you want to download is on the same origin as your site.You could always make the AJAX request/window.location a fallback by using some JavaScript to test if download is supported and if not, switching it to call window.location.Original answerYou can't have an AJAX request open the download prompt since you physically have to navigate to the file to prompt for download. Instead, you could use a success function to navigate to download.php. This will open the download prompt but won't change the current page.Even though this answers the question, it's better to just use window.location and avoid the AJAX request entirely.You actually don't need ajax at all for this. If you just set "download.php" as the href on the button, or, if it's not a link use:The browser should recognise the binary download and not load the actual page but just serve the file as a download.To make the browser downloads a file you need to make the request like that:Cross browser solution, tested on Chrome, Firefox, Edge, IE11.In the DOM, add an hidden link tag:Then:It is possible. You can have the download started from inside an ajax function, for example, just after the .csv file is created.I have an ajax function that exports a database of contacts to a .csv file, and just after it finishes, it automatically starts the .csv file download. So, after I get the responseText and everything is Ok, I redirect browser like this:My download.php file looks like this:There is no page refresh whatsoever and the file automatically starts downloading. NOTE - Tested in the following browsers:I prefer location.assign(url);Complete syntax example:developer.mozilla.org/en-US/docs/Web/API/Location.assignDecoding a filename from the header is a little bit more complex...This solution is not very different from those above, but for me it works very well and i think it's clean.I suggest to base64 encode the file server side (base64_encode(), if you are using PHP) and send the base64 encoded data to the clientOn the client you do this:This code puts the encoded data in a link and simulates a click on the link, then it removes it.Your needs are covered by 

 window.location('download.php');

But I think that you need to pass the file to be downloaded, not always download the same file, and that's why you are using a request, one option is to create a php file as simple as showfile.php and do a request likeshowfile.phpwhere file is the file name passed via Get or Post in the request and then catch the response in a function simply there is another solution to download a web page in ajax. But I am referring to a page that must first be processed and then downloaded.First you need to separate the page processing from the results download.1) Only the page calculations are made in the ajax call.I hope this solution can be useful for many, as it was for me.

Declaring a boolean in JavaScript using just var

mrblah

[Declaring a boolean in JavaScript using just var](https://stackoverflow.com/questions/653921/declaring-a-boolean-in-javascript-using-just-var)

If I declare a JavaScript boolean variable like this:And then initialize it with either true or 1, is that safe?  Or will initializing it with 1 make the variable a number?

2009-03-17 11:58:46Z

If I declare a JavaScript boolean variable like this:And then initialize it with either true or 1, is that safe?  Or will initializing it with 1 make the variable a number?Types are dependent to your initialization:But take a look at this example: Your variables' type depends on the assigned value in JavaScript.No it is not safe. You could later do var IsLoggedIn = "Foo"; and JavaScript will not throw an error.It is possible to doYou can also pass the non boolean variable into the new Boolean() and it will make IsLoggedIn boolean. As this very useful tutorial says:If you want IsLoggedIn to be treated as a boolean you should initialize as follows:If you initialize it with var IsLoggedIn=1; then it will be treated as an integer.However at any time the variable IsLoggedIn could refer to a different data type:This will not cause an error.You can use and test uninitialized variables at least for their 'definedness'. 

Like this:Furthermore, there are many possibilites: if you're not interested in exact types use the '==' operator (or ![variable] / !![variable]) for comparison (that is what Douglas Crockford calls 'truthy' or 'falsy' I think). In that case assigning true or 1 or '1' to the unitialized variable always returns true when asked. Otherwise [if you need type safe comparison] use '===' for comparison.PS: you can't test 'definedness' for nonexisting variables though. So:gives a reference Error ('HelloWorld is not defined')(is there a better word for 'definedness'? Pardon my dutch anyway;~)Variables in Javascript don't have a type. Non-zero, non-null, non-empty and true are "true". Zero, null, undefined, empty string and false are "false".There's a Boolean type though, as are literals true and false.How about something like this:Then you can use it like this:I have not tested it for performance, but converting from type to type should not happen too often otherwise you open your app up to instability big time!The variable will become what ever type you assign it.  Initially it is undefined.  If you assign it 'true' it will become a string, if you assign it true it will become a boolean, if you assign it 1 it will become a number.  Subsequent assignments may change the type of the variable later.

How to pass event as argument to an inline event handler in JavaScript?

user1643156

[How to pass event as argument to an inline event handler in JavaScript?](https://stackoverflow.com/questions/16404327/how-to-pass-event-as-argument-to-an-inline-event-handler-in-javascript)

There are some similar questions have been asked.But in my code, I'm trying to get child elements who's been clicked, like a or span.So what is the correct way to pass event as an argument to event handler, or how to get event inside handler without passing an argument?I'm aware of addEventListener and jQuery, please provide a solution for passing event to inline event hander.

2013-05-06 17:52:36Z

There are some similar questions have been asked.But in my code, I'm trying to get child elements who's been clicked, like a or span.So what is the correct way to pass event as an argument to event handler, or how to get event inside handler without passing an argument?I'm aware of addEventListener and jQuery, please provide a solution for passing event to inline event hander.to pass the event object:to get the clicked child element (should be used with event parameter:to pass the element itself (DOMElement):see live example on jsFiddleSince inline events are executed as functions you can simply use arguments.and The 'event' that is mentioned in the accepted answer is actually the name of the argument passed to the function. It has nothing to do with the global event.You don't need to pass this, there already is the event object passed by default automatically, which contains event.target which has the object it's coming from. You can lighten your syntax: This:Will work with this: You don't need to instantiate the event object, it's already there. Try it out. And event.target will contain the entire object calling it, which you were referencing as "this" before. Now if you dynamically trigger doSomething() from somewhere in your code, you will notice that event is undefined. This is because it wasn't triggered from an event of clicking. So if you still want to artificially trigger the event, simply use dispatchEvent:Then doSomething() will see event and event.target as per usual!No need to pass this everywhere, and you can keep your function signatures free from wiring information and simplify things. 

Angular ng-if=「」with multiple arguments

David Karlsson

[Angular ng-if=「」with multiple arguments](https://stackoverflow.com/questions/18988198/angular-ng-if-with-multiple-arguments)

I am trying to get started on angular development. And after reviewing the documentation some questions persist. How do i best write a ng-if with multiple arguments corresponding to if( a && b) or if( a || b ) 

2013-09-24 17:27:46Z

I am trying to get started on angular development. And after reviewing the documentation some questions persist. How do i best write a ng-if with multiple arguments corresponding to if( a && b) or if( a || b ) It is possible. http://plnkr.co/edit/UKNoaaJX5KG3J7AswhLV?p=previewFor people looking to do if statements with multiple 'or' values.Yes, it's possible.

for example checkout:Just to clarify, be aware bracket placement is important!These can be added to any HTML tags... span, div, table, p, tr, td etc.AngularJSAngular2+It's best practice not to do calculations directly within ngIfs, so assign the variables within your component, and do any logic there.

Unobtrusive JavaScript: <script> at the top or the bottom of the HTML code?

e-satis

[Unobtrusive JavaScript: <script> at the top or the bottom of the HTML code?](https://stackoverflow.com/questions/143486/unobtrusive-javascript-script-at-the-top-or-the-bottom-of-the-html-code)

I've recently read the Yahoo manifesto Best Practices for Speeding Up Your Web Site. They recommend to put the JavaScript inclusion at the bottom of the HTML code when we can.But where exactly and when?Should we put it before closing </html> or after ? And above all, when should we still put it in the <head> section?

2008-09-27 12:02:28Z

I've recently read the Yahoo manifesto Best Practices for Speeding Up Your Web Site. They recommend to put the JavaScript inclusion at the bottom of the HTML code when we can.But where exactly and when?Should we put it before closing </html> or after ? And above all, when should we still put it in the <head> section?There are two possibilities for truly unobtrusive scripts:The second one can be faster as the original Yahoo research showed some browsers try to load script files when they hit the script tag and therefore don't load the rest of the page until they have finished. However, if your script has a 'ready' portion which must execute as soon as the DOM is ready you may need to have it in the head. Another issue is layout - if your script is going to change the page layout you want it loaded as early as possible so your page does not spend a long time redrawing itself in front of your users.If the external script site is on another domain (like external widgets) it may be worth putting it at the bottom to avoid it delaying loading of the page. And for any performance issues do your own benchmarks - what may be true at one time when a study is done might change with your own local setup or changes in browsers.It's never so cut and dry - Yahoo recommends putting the scripts just before the closing </body> tag, which will create the illusion that the page loads faster on an empty cache (since the scripts won't block downloading the rest of the document). 

However, if you have some code you want to run on page load, it will only start executing after the entire page has loaded. If you put the scripts in the <head> tag, they would start executing before - so on a primed cache the page would actually appear to load faster.Also, the privilege of putting scripts at the bottom of the page is not always available. If you need to include inline scripts in your views that depend on a library or some other JavaScript code being loaded before, you must load those dependencies in the <head> tag.All in all Yahoo's recommendations are interesting but not always applicable and should be considered on a case-by-case basis.As others have said, place it before the closing body html tags.The other day we had numerous calls from clients complaining their sites were extremely slow. We visited them locally and found they took 20-30 seconds to load a single page. Thinking it was the servers performing badly, we logged on - but both web and sql servers were ~0% activity.After a few minutes, we realised an external site was down, which we were linking to for Javascript tracking tags. This meant browsers were hitting the script tag in the head section of the site and waiting to download the script file.So, for 3rd party/external scripts at least, I'd recommend putting them as the last thing on the page. Then if they were unavailable, the browser would at least load the page up until that point - and the user would be oblivious to it.To summarize, based on the suggestions above:If you want to tinker with the position of your scripts, YSlow is a great tool for giving you a flavour if it's going to improve or hurt performance.  Putting javascript in certain document positions can really kill page load times.http://developer.yahoo.com/yslow/No it should not be after the </html> as that would be invalid. The best place to put scripts is right before the </body>This is basically because most browsers stop rendering the page while they eval the script that you provide. So its OK to put non-blocking code anywhere in the page (I'm mainly thinking of things that attach functions to the onLoad event, since event binding is so fast as to effectively be free). A big killer here is at the beginning of the page putting in some ad server script, which can prevent any of the page loading before the ads have totally downloaded, making your page load times balloon If you put it at the bottom, it loads last, hence speeding up the speed that the user can see the page. It does need to be before the final </html> though otherwise it won't be part of the DOM.If the code is needed instantly though, then put it in the head.It's best to put things like blog widgets at the bottom so that if they don't load, it doesn't affect the usability of the page.

Calling a javascript function recursively

Samthere

[Calling a javascript function recursively](https://stackoverflow.com/questions/7065120/calling-a-javascript-function-recursively)

I can create a recursive function in a variable like so:With this, functionHolder(3); would output 3 2 1 0. Let's say I did the following:copyFunction(3); would output 3 2 1 0 as above. If I then changed functionHolder as follows:Then functionHolder(3); would give Stop counting!, as expected.copyFunction(3); now gives 3 Stop counting! as it refers to functionHolder, not the function (which it itself points to). This could be desirable in some circumstances, but is there a way to write the function so that it calls itself rather than the variable that holds it?That is, is it possible to change only the line functionHolder(counter-1); so that going through all these steps still gives 3 2 1 0 when we call copyFunction(3);? I tried this(counter-1); but that gives me the error this is not a function.

2011-08-15 12:51:31Z

I can create a recursive function in a variable like so:With this, functionHolder(3); would output 3 2 1 0. Let's say I did the following:copyFunction(3); would output 3 2 1 0 as above. If I then changed functionHolder as follows:Then functionHolder(3); would give Stop counting!, as expected.copyFunction(3); now gives 3 Stop counting! as it refers to functionHolder, not the function (which it itself points to). This could be desirable in some circumstances, but is there a way to write the function so that it calls itself rather than the variable that holds it?That is, is it possible to change only the line functionHolder(counter-1); so that going through all these steps still gives 3 2 1 0 when we call copyFunction(3);? I tried this(counter-1); but that gives me the error this is not a function.You can give a function expression a name that is actually private and is only visible from inside of the function ifself:Here myself is visible only inside of the function itself.You can use this private name to call the function recursively.See 13. Function Definition of the ECMAScript 5 spec:Please note that Internet Explorer up to version 8 doesn't behave correctly as the name is actually visible in the enclosing variable environment, and it references a duplicate of the actual function (see patrick dw's comment below).Alternatively you could use arguments.callee to refer to the current function:The 5th edition of ECMAScript forbids use of arguments.callee() in strict mode, however:You can access the function itself using arguments.callee [MDN]:This will break in strict mode, however.You can use the Y-combinator: (Wikipedia)And you can use it as this:I know this is an old question, but I thought I'd present one more solution that could be used if you'd like to avoid using named function expressions. (Not saying you should or should not avoid them, just presenting another solution)Notice that the counter counts "backwards" in regards to what slug's value is. This is because of the position at which we are logging these values, as the function recurs before logging -- so, we essentially keep nesting deeper and deeper into the call-stack before logging takes place.Once the recursion meets the final call-stack item, it trampolines "out" of the function calls, whereas, the first increment of counter occurs inside of the last nested call.I know this is not a "fix" on the Questioner's code, but given the title I thought I'd generically exemplify Recursion for a better understanding of recursion, outright.

Recommended JavaScript HTML template library for JQuery? [closed]

Shiva

[Recommended JavaScript HTML template library for JQuery? [closed]](https://stackoverflow.com/questions/449780/recommended-javascript-html-template-library-for-jquery)

Any suggestions on which HTML template library would go well with JQuery?  Googling turns up quite a number of libraries but I'm not sure whether there is a well recognized library that would stand the test of time.

2009-01-16 07:48:09Z

Any suggestions on which HTML template library would go well with JQuery?  Googling turns up quite a number of libraries but I'm not sure whether there is a well recognized library that would stand the test of time.Well, to be frank, client-side templating is very hot nowadays, but quite a jungle.the most popular are, I believe: there are plenty others, but you have to test them to see what suits you, and your project style, best.Personally, I have a hard time with adding a new syntax and set of logic (mixing logic and template, hello??), and went pure js. Every single one of my templates is stored in it's own html file (./usersTable.row.html). I use templates only when ajaxing content, and I have few "logic" js files, one for tables, one for div, one for lists. and not even one for select's options (where i use another method).Each time I tried to do something more complex, I found out the code was less clear and taking me more time to stabilize than doing it the "old" way. Logic in the template is an utter non-sense in my opinion, and adding it's own syntax adds only very-hard-to-trace bugs.jTemplatesThere is a reasonable discussion document on this topic here, which covers a range of templating tools. Not specific to jQuery, though.jQuery Templates Plugin created by Microsoft and accepted as an official jQuery plugin. But note that it’s now deprecated.I would check out json2html, it forgoes having to write HTML snippets and relies instead on JSON transforms to convert JSON object array's into unstructured lists.  Very fast and uses DOM creation.A couple years ago i built IBDOM: http://ibdom.sf.net/ | As of december 2009, it supports jQuery binding if you get it straight from the trunk.orAlso, you can now put all the "data:propName" markers in class="data:propName other classnames" attributes, so you don't have to litter your application's content with those markers.I've yet to update a bunch of the documentation on there to reflect my recent enhancements, but the i've had various versions of this framework in production since 2007.To skeptics of this question:Back when Microsoft invented with IE5 what we now know as XmlHttpRequest and the "ajax" pattern, part of the promise behind this was to purely exchange data between a web browser and the server. That data was to be encapsulated in XML, because in 1999/2000, XML was simply just so very hot. Beyond retrieving an xml document over the network with a call-back mechanism, MS's MSXML ActiveX component also supported a pre-draft implementation of what we now know as XSL-T and XPath.Combining retrieving HTTP/XML, XPath, and XSL-T, afforded developers tremendous creativity to build rich "documents" which behaved as "applications", purely sending, and more importantly, retrieving data from the server.Why is this a useful pattern? It depends on how complex your user interface is, and how much you care about its maintainability.When building a visually very rich semantically marked-up interface with advanced CSS, the last thing you want to do is chunk-out pieces of markup into "mini-controller/views", just so you can .innerHTML a document fragment into the main document, and here's why.One key tenet of keeping an advanced html/css user interface manageable, is to preserve its validation at least during its active phase of development. If your markup validates, you can focus on your CSS bugs. Now, if fragments of markup end-up getting injected during various stages of user-interaction, it all becomes very unwieldy to manage, and the whole thing gets brittle.The idea was to have all of your markup UI constructs in a single document, retrieve ONLY DATA over the network, and use a solid framework which will at the very least simply inject your data into your markup constructs, and at the most replicate markup constructs which you flagged as repeatable.This was possible with XSL-T and XPath in IE5+, but virtually no other browsers. Some F/OSS browser frameworks have been dabbling with XPath but it's not quite something we can rely on just yet.So what's the next best thing to achieve such pattern? IBDOM. Get data from your server, inject it in your document. effortlessly.You should get a look on Javascript-Templates, this is a small template engine used within the famous jQuery File Upload plugin, and developed by the same author, Sebastian Tschan (@blueimp)https://github.com/blueimp/JavaScript-TemplatesFollow the usage guide made by Sebastian, just remove this lineReplace it with this oneDon't forget to add the div result tag in you HTML file tooEnjoy

Adding a custom header to HTTP request using angular.js

trentclowater

[Adding a custom header to HTTP request using angular.js](https://stackoverflow.com/questions/15598917/adding-a-custom-header-to-http-request-using-angular-js)

I am a novice to angular.js, and I am trying to add some headers to a request:I've looked at all the documentation, and this seems to me like it should be correct.When I use a local file for the URL in the $http.get, I see the following HTTP request on the network tab in Chrome:As you can see, both of the headers were added correctly. But when I change the URL to the one shown in the $http.get above (except using the real address, not example.com), then I get:The only difference in code between these two is one is for the first the URL is a local file, and for the second the URL is a remote server. If you look at the second Request header, there is no Authentication header, and the Accept appears to be using a default instead of the one specified. Also, the first line now says OPTIONS instead of GET (although Access-Control-Request-Method is GET).Any idea what is wrong with the above code, or how to get the additional headers included using when not using a local file as a data source?

2013-03-24 13:16:45Z

I am a novice to angular.js, and I am trying to add some headers to a request:I've looked at all the documentation, and this seems to me like it should be correct.When I use a local file for the URL in the $http.get, I see the following HTTP request on the network tab in Chrome:As you can see, both of the headers were added correctly. But when I change the URL to the one shown in the $http.get above (except using the real address, not example.com), then I get:The only difference in code between these two is one is for the first the URL is a local file, and for the second the URL is a remote server. If you look at the second Request header, there is no Authentication header, and the Accept appears to be using a default instead of the one specified. Also, the first line now says OPTIONS instead of GET (although Access-Control-Request-Method is GET).Any idea what is wrong with the above code, or how to get the additional headers included using when not using a local file as a data source?I took what you had, and added another X-Testing headerAnd in the Chrome network tab, I see them being sent. Are you not seeing them from the browser, or on the server?  Try the browser tooling or a debug proxy and see what is being sent out.Basic authentication using HTTP POST method:...and GET method call with header:If you want to add your custom headers to ALL requests, you can change the defaults on $httpProvider to always add this header…my suggestion will be add a function call settings like this

inside the function check the header which is appropriate for it. I am sure it will definitely work. it is perfectly working for me.then call your data like thisWhat you see for OPTIONS request is fine. Authorisation headers are not exposed in it.But in order for basic auth to work you need to add: withCredentials = true; to your var config.From the AngularJS $http documentation:And what's the answer from the server? It should reply a 204 and then really send the GET you are requesting.In the OPTIONS the client is checking if the server allows CORS requests. If it gives you something different than a 204 then you should configure your server to send the correct Allow-Origin headers.The way you are adding headers is the right way to do it.Chrome is preflighting the request to look for CORS headers. If the request is acceptable, it will then send the real request. If you're doing this cross-domain, you will simply have to deal with it or else find a way to make the request non-cross-domain. This is by design.Ref: AJAX in Chrome sending OPTIONS instead of GET/POST/PUT/DELETE?For me the following explanatory snippet worked. Perhaps you shouldn't use ' for header name?I'm using $http.ajax(), though I wouldn't expect that to be a game changer.

How do websites know they're not the default home page or search provider?

Tennyson H

[How do websites know they're not the default home page or search provider?](https://stackoverflow.com/questions/34195660/how-do-websites-know-theyre-not-the-default-home-page-or-search-provider)

As far as I'm aware, there is no public API exposure of a browser's default homepage/search provider. So how does Google know to display this? It only comes around when Google's not the default homepage / default search provider on my browser.

I can only assume they're inferring from numerous variables, such as the referrer. I wasn't able to successfully dig down into Google's compiled JavaScript. I'm not even sure if it's detected client-side or server-side. I'm on Firefox 44, but I've seen these banners on Chrome, too. 

2015-12-10 07:05:06Z

As far as I'm aware, there is no public API exposure of a browser's default homepage/search provider. So how does Google know to display this? It only comes around when Google's not the default homepage / default search provider on my browser.

I can only assume they're inferring from numerous variables, such as the referrer. I wasn't able to successfully dig down into Google's compiled JavaScript. I'm not even sure if it's detected client-side or server-side. I'm on Firefox 44, but I've seen these banners on Chrome, too. Simply there is no way to do that with JavaScript because the "default search/homepage" is a user's preference and you do not have access to that without user's permission  because  that would be a security/privacy issue.What Google does at every user visit is show a promo ad with a close icon and a go button with instructions on how to set it as the default homepage. On click of any one of them, it creates 2 cookies so that next time it will check your cookies and make the promos disappear. Even  when Google is your homepage and you clear your cookies then a banner is still there to promote Google as your homepage.I have checked this with Firefox, not aware of Chrome.I don't know what Google does, exactly, but what I would do:Note that the "special parameter" does happen in the "searchbox-initiated search" scenario: there is a parameter sourceid which likely means "source of search."In my Firefox (v42), the "Come here often?" box appears even when I have Google set as the default search provider.In Safari I get a box in the same location that says "A better way to browse the web: Get Google Chrome"In Opera and Chrome I get no box at all, even if I change my default search provider to something other than Google.So, I believe all they're doing is browser detection in the JavaScript, using the UserAgent object.

What events does an <input type=「number」/> fire when it's value is changed?

Ian Oxley

[What events does an <input type=「number」/> fire when it's value is changed?](https://stackoverflow.com/questions/3940258/what-events-does-an-input-type-number-fire-when-its-value-is-changed)

Just wondering whether anyone knows what events an HTML5 <input type="number" /> element fires when its up / down arrows are clicked:I'm already using an onblur for when the focus leaves the input field.

2010-10-15 07:26:57Z

Just wondering whether anyone knows what events an HTML5 <input type="number" /> element fires when its up / down arrows are clicked:I'm already using an onblur for when the focus leaves the input field.change would be the event that is fired when the field's value changes.I think the HTML5 event input would also fire.I found that for jQuery the following code covered keyboard input, mousewheel changes and button clicks in Chrome, and also handled keyboard input in FirefoxI found that onkeyup and onchange covered everything in Chrome 19.

This handles direct value input, up down arrow keypress, clicking the buttons and scrolling the mousewheel.onchange alone would be sufficient in Chrome, but other browsers that only render the field as a text box need the onkeyup binding, which works perfectly to read the new value.Binding the mousewheel event separately was less successful. The event fired too early - before the field value was updated - and therefore always gave the field's previous valueThe onchange event fires on blur but the oninput event fires as you type. Maybe you might want to put a timer on the oninput event and fire your onchange event when the user has stopped typing for a second?There is a current bug in Edge preventing change or input from firing when using the arrow keys in a number input.

How can one tell the version of React running at runtime in the browser?

leojh

[How can one tell the version of React running at runtime in the browser?](https://stackoverflow.com/questions/36994564/how-can-one-tell-the-version-of-react-running-at-runtime-in-the-browser)

Is there a way to know the runtime version of React in the browser?

2016-05-03 02:22:28Z

Is there a way to know the runtime version of React in the browser?React.version is what you are looking for.It is undocumented though (as far as I know) so it may not be a stable feature (i.e. though unlikely, it may disappear or change in future releases).Example with React imported as a scriptExample with React imported as a moduleObviously, if you import React as a module, it won't be in the global scope. The above code is intended to be bundled with the rest of your app, e.g. using webpack. It will virtually never work if used in a browser's console (it is using bare input).This second approach is the recommended one. Most websites will use it. create-react-app does this (it's using webpack behind the scene). In this case, React is encapsulated and is generally not accessible at all outside the bundle (e.g. in a browser's console). Open Chrome Dev Tools or equivalent and run require('React').version in the console. That works on websites like Facebook as well to find out what version they are using.From the command line:It is not certain that any global ECMAScript variables have been exported and html/css does not necessarily indicate React. So look in the .js.Method 1: Look in ECMAScript:The version number is exported by both modules react-dom and react but those names are often removed by bundling and the version hidden inside an execution context that cannot be accessed. A clever break point may reveal the value directly, or you can search the ECMAScript:Method 2: Use a DOM breakpoint:The version is also injected into React dev tools, but as far as I know not displayed anywhere.In index.js file, simply replace App component with "React.version".

E.g.I have checked this with React v16.8.1Open the console, then run window.React.version. This worked for me in Safari and Chrome while upgrading from 0.12.2 to 16.2.0.For an app created with create-react-app I managed to see the version:The app was deployed without source map.In an existing project a simple way to see the React version is to go to a render method of any component and add:<p>{React.version}</p>This assumes you import React like this: import React from 'react'With the React Devtools installed you can run this from the browser console:Which outputs something like:

Is it possible to get the index you're sorting over in Underscore.js?

contactmatt

[Is it possible to get the index you're sorting over in Underscore.js?](https://stackoverflow.com/questions/12179855/is-it-possible-to-get-the-index-youre-sorting-over-in-underscore-js)

I'm using the JS library Underscore and in particular using the _.each and _.sortby library calls.  I'm wondering if there's any possible way to get the index of the value within the iterator delegate

2012-08-29 14:08:18Z

I'm using the JS library Underscore and in particular using the _.each and _.sortby library calls.  I'm wondering if there's any possible way to get the index of the value within the iterator delegateIndex is actually available like;You can get the index of the current iteration by adding another parameter to your iterator function, e.g.If you'd rather transform your array, then the iterator parameter of underscore's map function is also passed the index as a second argument. So:... returns:The iterator of _.each is called with 3 parameters (element, index, list). So yes, for _.each you cab get the index.You can do the same in sortByI think it's worth mentioning how the Underscore's _.each() works internally. The _.each(list, iteratee) checks if the passed list is an array object, or an object.In the case that the list is an array, iteratee arguments will be a list element and index as in the following example:On the other hand, if the list argument is an object the iteratee will take a list element and a key:For reference this is the _.each() code from Underscore.js 1.8.3More generally, under most circumstances, underscore functions that take a list and argument as the first two arguments,  provide access to the list index as the next to last argument to the iterator.  This is an important distinction when it comes to the two underscore functions, _.reduce and _.reduceRight, that take 'memo' as their third argument -- in the case of these two the index will not be the second argument, but the third:So if you wanted you could get the index using underscore itself: _.last(_.initial(arguments)).  A possible exception (I haven't tried) is _.map, as it can take an object instead of a list: "If list is a JavaScript object, iterator's arguments will be (value, key, list)." -- see: http://underscorejs.org/#mapWhen available, I believe that most lodash array functions will show the iteration. But sorting isn't really an iteration in the same way: when you're on the number 66, you aren't processing the fourth item in the array until it's finished. A custom sort function will loop through an array a number of times, nudging adjacent numbers forward or backward, until the everything is in its proper place.

Bootstrap: Open Another Modal in Modal

AlexioVay

[Bootstrap: Open Another Modal in Modal](https://stackoverflow.com/questions/19528173/bootstrap-open-another-modal-in-modal)

So, I'm using this code to open another modal window in a current opened modal window:What happens is, that for like 500ms the scrollbar will duplicate. I guess because the current modal is still fading out. However it looks very un-smooth and stuttering.I would appreciate any suggestions to solve this issue. Also, is the way building this in an onclick-event unprofessional?I'm working with the bootstrap version 3.0.Edit: I guess it's neccesary to reduce the time of fading out a modal. How is this possible?

2013-10-22 20:54:41Z

So, I'm using this code to open another modal window in a current opened modal window:What happens is, that for like 500ms the scrollbar will duplicate. I guess because the current modal is still fading out. However it looks very un-smooth and stuttering.I would appreciate any suggestions to solve this issue. Also, is the way building this in an onclick-event unprofessional?I'm working with the bootstrap version 3.0.Edit: I guess it's neccesary to reduce the time of fading out a modal. How is this possible?data-dismiss makes the current modal window force closedata-toggle opens up a new modal with the href content inside itordo let us know if it works.My solution does not close the lower modal, but truly stacks on top of it.  It preserves scrolling behavior correctly.  Tested in Bootstrap 3.  For modals to stack as expected, you need to have them ordered in your Html markup from lowest to highest.UPDATE: When you have stacked modals, all the backdrops appear below the lowermost modal.  You can fix that by adding the following CSS:This will give the appearance of a modal backdrop below the topmost visible modal.  That way it grays out your lower modals underneath.To open another modal window in a current opened modal window,

you can use bootstrap-modalbootstrap-modal DEMOtry thisYou can actually detect when the old modal closes by calling the hidden.bs.modal event:For more info: http://getbootstrap.com/javascript/#modals-eventsUpdate for 2018 -- Using Bootstrap 4I found most of the answers seem to have a lot of unnecessary jQuery. To open a modal from another modal can be done simply by using the events that Bootstrap provides such as show.bs.modal. You may also want some CSS to handle the backdrop overlays. Here are the 3 open modal from another scenarios...Open modal from another modal (keep 1st modal open)A potential issue in this case is that the backdrop from the 2nd modal hides the 1st modal. To prevent this, make the 2nd modal data-backdrop="static", and add some CSS to fix the z-indexes of the backdrops...https://www.codeply.com/go/NiFzSCukVlOpen modal from another modal (close 1st modal)This is similar to the above scenario, but since we are closing the 1st modal when the 2nd is opened, there is no need for the backdrop CSS fix. A simple function that handles the 2nd modals show.bs.modal event closes the 1st modal.https://www.codeply.com/go/ejaUJ4YANzOpen modal inside another modalThe last multiple modals scenario is opening the 2nd modal inside the 1st modal. In this case the markup for the 2nd is placed inside the 1st. No extra CSS or jQuery is needed.https://www.codeply.com/go/iSbjqubiynModals in Modal:Working on a project that has a lot of modals calling other modals and a few HTML guys that might not know to initiate it everytime for each button.

Came to a similar conclusion as @gmaggio, begrudgingly after going the long way around first.EDIT: Now supports modals called via javascript.EDIT: Opening a scrolling modal from another modal now works.Just place the modal calling button in as normal, and if it is picked up to be inside a modal, it will close the current one first before opening the one specified in data-target.

Note that relatedTarget is provided by Bootstrap.I also added the following to smooth out the fading a bit:

I am sure more can be done though.Twitter docs says custom code is required...This works with no extra JavaScript, 

though, custom CSS would be highly recommended...Try this:This simple hack works for me.For someone who use bootstrap 4

https://jsfiddle.net/helloroy/tmm9juoh/For bootstrap 4, to expand on @helloroy's answer I used the following;-The advantage of the above is that it won't have any effect when there is only one modal, it only kicks in for multiples. Secondly, it delegates the handling to the body to ensure future modals which are not currently generated are still catered for.UpdateMoving to a js/css combined solution improves the look - the fade animation continues to work on the backdrop;-combined with the following css;-This will handle modals nested up to 4 deep which is more than I need.I also had some trouble with my scrollable modals, so I did something like this:It will serve for any modal whithin a modal that comes to appear.

Note that the first its closed so the second can appear.

No changes in the Bootstrap structure.I went kind of a different route all together, I decided to "De-Nest" them. Maybe someone will find this handy...My code works well

using data-dismiss.Close the first Bootstrap modal and open the new modal dynamically.Why not just change the content of the modal body?In the modal just put a link or a buttonIf you just want to switch beetween 2 modals:In the modal just put a link or a buttontry this:The answer given by H Dog is great, but this approach was actually giving me some modal flicker in Internet Explorer 11. 

Bootstrap will first hide the modal removing the 'modal-open' class, and then (using H Dogs solution) we add the 'modal-open' class again. I suspect this is somehow causing the flicker I was seeing, maybe due to some slow HTML/CSS rendering.Another solution is to prevent bootstrap in removing the 'modal-open' class from the body element in the first place. 

Using Bootstrap 3.3.7, this override of the internal hideModal function works perfectly for me.In this override, the 'modal-open' class is only removed when there are no visible modals on the screen. And you prevent one frame of removing and adding a class to the body element.Just include the override after bootstrap have been loaded.

How to get visitor's location (i.e. country) using geolocation? [duplicate]

Gal

[How to get visitor's location (i.e. country) using geolocation? [duplicate]](https://stackoverflow.com/questions/3489460/how-to-get-visitors-location-i-e-country-using-geolocation)

I'm trying to extend the native geolocation functionso that I can use the visitor's country name (perhaps return an informative array).So far all I've been able to find are functions that display a google maps interface but none actually gave what I want, except for this library which worked well in this example but for some reason didn't work on my computer. I'm not sure why that went wrong there.Anyways, do you know how I can simply return an array containing information like country, city, etc. from latitude and longitude values?

2010-08-15 22:02:17Z

I'm trying to extend the native geolocation functionso that I can use the visitor's country name (perhaps return an informative array).So far all I've been able to find are functions that display a google maps interface but none actually gave what I want, except for this library which worked well in this example but for some reason didn't work on my computer. I'm not sure why that went wrong there.Anyways, do you know how I can simply return an array containing information like country, city, etc. from latitude and longitude values?You don't need to locate the user if you only need their country. You can look their IP address up in any IP-to-location service (like maxmind). This will be accurate most of the time.If you really need to get their location, you can get their lat/lng with that method, then query Google's or Yahoo's reverse geocoding service.You can use my service, http://ipinfo.io, for this. It will give you the client IP, hostname, geolocation information (city, region, country, area code, zip code etc) and network owner. Here's a simple example that logs the city and country:Here's a more detailed JSFiddle example that also prints out the full response information, so you can see all of the available details: http://jsfiddle.net/zK5FN/2/The location will generally be less accurate than the native geolocation details, but it doesn't require any user permission.You can use your IP address to get your 'country', 'city', 'isp' etc...

Just use one of the web-services that provide you with a simple api like http://ip-api.com which provide you a JSON service at http://ip-api.com/json. Simple send a Ajax (or Xhr) request and then parse the JSON to get whatever data you need.See ipdata.co a service I built that is fast and has reliable performance thanks to having 10 global endpoints each able to handle >10,000 requests per second!This snippet will return the details of your current ip. To lookup other ip addresses, simply append the ip to the https://api.ipdata.co?api-key=test url eg.The API also provides an is_eu field indicating whether the user is in an EU country.Here's the fiddle; https://jsfiddle.net/ipdata/6wtf0q4g/922/I also wrote this detailed analysis of 8 of the best IP Geolocation APIs.A very easy to use service is provided by ws.geonames.org. Here's an example URL:And here's some (jQuery) code which I've added to your code:Try it on jsfiddle.net ...you can't get city location by ip.

here you can get country with jquery:A free and easy to use service is provided at Webtechriser (click here to read the article) (called wipmania). This one is a JSONP service and requires plain javascript coding with HTML. It can also be used in JQuery. I modified the code a bit to change the output format and this is what I've used and found to be working: (it's the code of my HTML page)PLEASE NOTE: This service gets the location of the visitor without prompting the visitor to choose whether to share their location, unlike the HTML 5 geolocation API (the code that you've written). Therefore, privacy is compromised. So, you should make judicial use of this service.For developers looking for a full-featured geolocation utility, you can have a look at geolocator.js (I'm the author).Example below will first try HTML5 Geolocation API to obtain the exact coordinates. If fails or rejected, it will fallback to Geo-IP look-up. Once it gets the coordinates, it will reverse-geocode the coordinates into an address.It supports geo-location (via HTML5 or IP lookups), geocoding, address look-ups (reverse geocoding), distance & durations, timezone information and more...You can use ip-api.io to get visitor's location. It supports IPv6.As a bonus it allows to check whether ip address is a tor node, public proxy or spammer. JavaScript Code:jQuery Code:

find the array index of an object with a specific key value in underscore

mheavers

[find the array index of an object with a specific key value in underscore](https://stackoverflow.com/questions/21631127/find-the-array-index-of-an-object-with-a-specific-key-value-in-underscore)

In underscore, I can successfully find an item with a specific key valuebut how do I find what array index that object occurred at?

2014-02-07 15:07:35Z

In underscore, I can successfully find an item with a specific key valuebut how do I find what array index that object occurred at?I don't know if there is an existing underscore method that does this, but you can achieve the same result with plain javascript.Then you can just do:var data = tv[tv.getIndexBy("id", 2)]findIndex was added in 1.8:See: http://underscorejs.org/#findIndexAlternatively, this also works, if you don't mind making another temporary list:See: http://underscorejs.org/#pluckIf you want to stay with underscore so your predicate function can be more flexible, here are 2 ideas.Since the predicate for _.find receives both the value and index of an element, you can use side effect to retrieve the index, like this:Looking at underscore source, this is how _.find is implemented:To make this a findIndex function, simply replace the line result = value; with result = index; This is the same idea as the first method. I included it to point out that underscore uses side effect to implement _.find as well.Lo-Dash, which extends Underscore, has findIndex method, that can find the index of a given instance, or by a given predicate, or according to the properties of a given object.In your case, I would do:Give it a try.If your target environment supports ES2015 (or you have a transpile step, eg with Babel), you can use the native Array.prototype.findIndex().Given your example

you can use indexOf method from lodashKeepin' it simple:Or, for non-haters, the CoffeeScript variant:This is to help lodash users. check if your key is present by doing:The simplest solution is to use lodash:const _ = require('lodash');If you're expecting multiple matches and hence need an array to be returned, try:If the property value is unique and you need the index of the match, try:I got similar case but in contrary is to find the used key based on index of a given object's. I could find solution in underscore using Object.values to returns object in to an array to get the occurred index.

How can I detect if Flash is installed and if not, display a hidden div that informs the user?

KingNestor

[How can I detect if Flash is installed and if not, display a hidden div that informs the user?](https://stackoverflow.com/questions/998245/how-can-i-detect-if-flash-is-installed-and-if-not-display-a-hidden-div-that-inf)

How can I use javascript/jQuery/etc to detect if Flash is installed and if it isn't, display a div that contains information informing the user that they need to install flash?

2009-06-15 20:38:13Z

How can I use javascript/jQuery/etc to detect if Flash is installed and if it isn't, display a div that contains information informing the user that they need to install flash?Use swfobject. it replaces a div with the flash if it is installed.

see: http://code.google.com/p/swfobject/If swfobject won't suffice, or you need to create something a little more bespoke, try this:It works with 7 and 8.@Drewid's answer didn't work in my Firefox 25 if the flash plugin is just disabled but installed.@invertedSpear's comment in that answer worked in firefox but not in any IE version.So combined both their code and got this. Tested in Google Chrome 31, Firefox 25, IE 8-10. Thanks Drewid and invertedSpear :)You can use navigator.mimeTypes.jqplugin: http://code.google.com/p/jqplugin/You should also be able to use..with the swfobject-Plugin.I used Adobe's detection kit, originally suggested by justpassinby. Their system is nice because it detects the version number and compares it for you against your 'required version'One bad thing is it does an alert showing the detected version of flash, which isn't very user friendly. All of a sudden a box pops up with some seemingly random numbers.Some modifications you might want to consider:Very very minified version of http://www.featureblend.com/javascript-flash-detection-library.html (only boolean flash detection)

javascript remove「disabled」attribute from html input

Jam Ville

[javascript remove「disabled」attribute from html input](https://stackoverflow.com/questions/11719961/javascript-remove-disabled-attribute-from-html-input)

How can I remove the "disabled" attribute from an HTML input using javascript?at onClick I want my input tag to not consist of "disabled" attribute.

2012-07-30 10:49:38Z

How can I remove the "disabled" attribute from an HTML input using javascript?at onClick I want my input tag to not consist of "disabled" attribute.Set the element's disabled property to false:If you're using jQuery, the equivalent would be:For several input fields, you may access them by class instead:Where document could be replaced with a form, for instance, to find only the elements inside that form. You could also use getElementsByTagName('input') to get all input elements. In your for iteration, you'd then have to check that inputs[i].type == 'text'.Why not just remove that attribute?To set the disabled to false using the name property of the input:code of the previous answers don't seem to work in inline mode, but there is a workaround: method 3.see demo https://jsfiddle.net/eliz82/xqzccdfg/

Override twitter bootstrap Textbox Glow and Shadows

Fady Kamal

[Override twitter bootstrap Textbox Glow and Shadows](https://stackoverflow.com/questions/12200544/override-twitter-bootstrap-textbox-glow-and-shadows)

I want to remove the Blue glow of the textbox and the border, but i don't know how to override any of the js or the css of it, check HereEDIT 1I want to do this because i am using the jquery plugin Tag-it and i am using twitter bootstrap also, the plugin uses a hidden textField to add the tags, but when i am using twitter bootstrap it appears as a textbox with glow inside a textbox which is a little bit odd

2012-08-30 15:37:25Z

I want to remove the Blue glow of the textbox and the border, but i don't know how to override any of the js or the css of it, check HereEDIT 1I want to do this because i am using the jquery plugin Tag-it and i am using twitter bootstrap also, the plugin uses a hidden textField to add the tags, but when i am using twitter bootstrap it appears as a textbox with glow inside a textbox which is a little bit oddYou can also override the default Bootstrap setting to use your own colorssets to bootstrap unfocused styleAfter doing some digging, I think they changed it in the latest bootstrap.  The below code worked for me, its not simple box its form-control that I was using that was causing the issue.  Go to Customize Bootstrap, look for @input-border-focus, enter your desired color code, scroll down and click "Compile and Download".if you think you can't handle the css class then simply add style to the textfieldthis will remove the border and the focus blue shadow.http://jsfiddle.net/pE5mQ/64/On bootstrap 3 there is a small top shodow on ios, could be removed with this:Got it from hereVendor prefixes aren't necessary at this point, unless you're supporting legacy browsers, and you could simplify your selectors by just referring to all inputs rather than each of the individual types.HTML CSS

Play an audio file using jQuery when a button is clicked

Suresh Pattu

[Play an audio file using jQuery when a button is clicked](https://stackoverflow.com/questions/8489710/play-an-audio-file-using-jquery-when-a-button-is-clicked)

I am trying to play an audio file when I click the button, but it's not working, my html code is:my JavaScript is :I have created a Fiddle for that too.

2011-12-13 13:02:35Z

I am trying to play an audio file when I click the button, but it's not working, my html code is:my JavaScript is :I have created a Fiddle for that too.You can play audio with <audio> tag or <object> or <embed>. 

Lazy loading(load when you need it) the sound is the best approach if its size is small. You can create the audio element dynamically, when its loaded you can start it with .play() and pause it with .pause().We will use canplay event to detect our file is ready to be played. There is no .stop() function for audio elements. We can only pause them. And when we want to start from the beginning of the audio file we change its .currentTime. We will use this line in our example audioElement.currentTime = 0;. To achieve .stop() function we first pause the file then reset its time.We may want to know the length of the audio file and the current playing time. We already learnt .currentTimeabove, to learn its length we use .duration.The actual answer, in jQuery, is It doesn't work with $("#myAudioElement").play() like you would expect. The official reason is that incorporating it into jQuery would add a play() method to every single element, which would cause unnecessary overhead. So instead you have to refer to it by its position in the array of DOM elements that you're retrieving with $("#myAudioElement"), aka 0.This quote is from a bug that was submitted about it, which was closed as "feature/wontfix":For anyone else following along, I've simply taken Ahmet's answer and updated the original asker's jsfiddle here, substituting:forlinking in a freely available mp3 off the web. Thank you for sharing the easy solution!I here have a nice and versatile solution with a fallback:After that you can initialize as many audio as you like:Now you can reach the initialized audio element whereever you like with simple event calls likeJSFiddle DemonstrationThis is what I use with JQuery:What about:

JSX not allowed in files with extension ' .js' with eslint-config-airbnb

Mendes

[JSX not allowed in files with extension ' .js' with eslint-config-airbnb](https://stackoverflow.com/questions/43031126/jsx-not-allowed-in-files-with-extension-js-with-eslint-config-airbnb)

I've installed eslint-config-airbnb that is supposed to pre configure ESLINT for React:My .eslintrc extending its configuration:Unfortunatelly I'm getting the following error when linting a .js file with React JSX code inside it:Wasn't eslint-config-airbnb configured react to support JSX already, as stated ? What should be done to remove that error ?

2017-03-26 16:06:17Z

I've installed eslint-config-airbnb that is supposed to pre configure ESLINT for React:My .eslintrc extending its configuration:Unfortunatelly I'm getting the following error when linting a .js file with React JSX code inside it:Wasn't eslint-config-airbnb configured react to support JSX already, as stated ? What should be done to remove that error ?Either change your file extensions to .jsx as mentioned or disable the jsx-filename-extension rule. You can add the following to your config to allow .js extensions for JSX.It's work for me. hope to help you.If you don't want to change your file extension, you can export a function that returns jsx, and then import and call that function in your js file.and thenCall me a dummy if it does not work for youTo expound on Martin's answer, it seems that it is not possible, currently, to use JSX in React Native.  A PR was created but reverted due to concerns about fragmentation and unknown consequences of having things like index.ios.jsx.  I'm not sure how AirBnb works around this or if they do, but I have used basically the same rules block as Martin.Following React documentation: Following Airbnb's style guide:You could do this:

jQuery select option elements by value

rapt

[jQuery select option elements by value](https://stackoverflow.com/questions/7290950/jquery-select-option-elements-by-value)

I have a select element wrapped by a span element. I am not allowed to use the select id but I am allowed to use the span id.

I am trying to write a javascript/jquery function in which the input is a number i, which is one of the values of the select's options. The function will turn the relevant option to selected.I wrote something as follows (this does not completely work, which is why I am posting this question):Thanks!

2011-09-03 03:22:29Z

I have a select element wrapped by a span element. I am not allowed to use the select id but I am allowed to use the span id.

I am trying to write a javascript/jquery function in which the input is a number i, which is one of the values of the select's options. The function will turn the relevant option to selected.I wrote something as follows (this does not completely work, which is why I am posting this question):Thanks!Here's the simplest solution with a clear selector:With jQuery > 1.6.1 should be better to use this syntax:Just wrap your option in $(option) to make it act the way you want it to.  You can also make the code shorter by doing here is the fiddle http://jsfiddle.net/hRFYF/You can use .val() to select the value, like the following:Here is a jsfiddle: https://jsfiddle.net/tweissin/uscq42xh/8/To get the value just use this:this will fetch the values

moment.js - UTC gives wrong date

brg

[moment.js - UTC gives wrong date](https://stackoverflow.com/questions/17855842/moment-js-utc-gives-wrong-date)

Why does moment.js UTC always show the wrong date. For example from chrome's developer console:Both of them will return "2013-07-17" why is it returning 17th instead of 18th, that was passed in.But if I use momentjs without the utc: I get back "2013-07-18" which is what I also expect when using moment.js UTC.Does this mean we cannot get the correct date when using moment.js UTC?

2013-07-25 10:44:40Z

Why does moment.js UTC always show the wrong date. For example from chrome's developer console:Both of them will return "2013-07-17" why is it returning 17th instead of 18th, that was passed in.But if I use momentjs without the utc: I get back "2013-07-18" which is what I also expect when using moment.js UTC.Does this mean we cannot get the correct date when using moment.js UTC?By default, MomentJS parses in local time. If only a date string (with no time) is provided, the time defaults to midnight.In your code, you create a local date and then convert it to the UTC timezone (in fact, it makes the moment instance switch to UTC mode), so when it is formatted, it is shifted (depending on your local time) forward or backwards.If the local timezone is UTC+N (N being a positive number), and you parse a date-only string, you will get the previous date.Here are some examples to illustrate it (my local time offset is UTC+3 during DST):If you want the date-time string interpreted as UTC, you should be explicit about it:or, as Matt Johnson mentions in his answer, you can (and probably should) parse it as a UTC date in the first place using moment.utc() and include the format string as a second argument to prevent ambiguity.To go the other way around and convert a UTC date to a local date, you can use the local() method, as follows:Both Date and moment will parse the input string in the local time zone of the browser by default.  However Date is sometimes inconsistent with this regard.  If the string is specifically YYYY-MM-DD, using hyphens, or if it is YYYY-MM-DD HH:mm:ss, it will interpret it as local time.   Unlike Date, moment will always be consistent about how it parses.The correct way to parse an input moment as UTC in the format you provided would be like this:Refer to this documentation.If you want to then format it differently for output, you would do this:You do not need to call toString explicitly.Note that it is very important to provide the input format.  Without it, a date like 01-04-2013 might get processed as either Jan 4th or Apr 1st, depending on the culture settings of the browser.

Good Example of JavaScript's Prototype-Based Inheritance

Alex Reisner

[Good Example of JavaScript's Prototype-Based Inheritance](https://stackoverflow.com/questions/2064731/good-example-of-javascripts-prototype-based-inheritance)

I have been programming with OOP languages for over 10 years but I'm learning JavaScript now and it's the first time I've encountered prototype-based inheritance. I tend to learn fastest by studying good code. What's a well-written example of a JavaScript application (or library) that properly uses prototypal inheritance? And can you describe (briefly) how/where prototypal inheritance is used, so I know where to start reading?

2010-01-14 14:28:15Z

I have been programming with OOP languages for over 10 years but I'm learning JavaScript now and it's the first time I've encountered prototype-based inheritance. I tend to learn fastest by studying good code. What's a well-written example of a JavaScript application (or library) that properly uses prototypal inheritance? And can you describe (briefly) how/where prototypal inheritance is used, so I know where to start reading?Douglas Crockford has a nice page on JavaScript Prototypal Inheritance:Dean Edward's Base.js, Mootools's Class or John Resig's Simple Inheritance works are ways to do classical inheritance in JavaScript.As mentioned, the movies by Douglas Crockford give a good explanation about the why and it covers the how. But to put it in a couple of lines of JavaScript:The problem with this approach however, is that it will re-create the object every time you create one. Another approach is to declare your objects on the prototype stack, like so:There is a slight downside when it comes to introspection. Dumping testOne, will result in less useful information. Also the private property "privateVariable" in "testOne" is shared in all instances, als helpfully mentioned in the replies by  shesek.I would take a look at YUI, and at Dean Edward's Base library: http://dean.edwards.name/weblog/2006/03/base/For YUI you can take a quick look at the lang module, esp. the YAHOO.lang.extend method. And then, you can browse the source of some widgets or utilities and see how they use that method.There's also Microsoft's ASP.NET Ajax library, http://www.asp.net/ajax/.There are a lot of good MSDN articles around as well, including Create Advanced Web Applications With Object-Oriented Techniques.This is the clearest example I've found, from Mixu's Node book (http://book.mixu.net/node/ch6.html):ES6 class and extendsES6 class and extends are just syntax sugar for previously possible prototype chain manipulation, and so arguably the most canonical setup.First learn more about the prototype chain and . property lookup at: https://stackoverflow.com/a/23877420/895245Now let's deconstruct what happens:Simplified diagram without all predefined objects:I suggest looking at PrototypeJS' Class.create:

Line 83 @ http://prototypejs.org/assets/2009/8/31/prototype.jsThe best examples I've seen are in Douglas Crockford's JavaScript: The Good Parts. It's definitely worth buying to help you get a balanced view on the language.Douglas Crockford is responsible for the JSON format and works at Yahoo as a JavaScript guru.There is a snippet JavaScript Prototype-based Inheritance with ECMAScript version specific implementations. It will automatically choose which to use between ES6, ES5 and ES3 implementations according to current runtime.Adding an example of Prototype based inheritance in Javascript.ES6 uses far easier implementation of inheritance witn the use of constructor and super keywords.

How can I make sure that my JavaScript files delivered over a CDN are not altered?

baba26

[How can I make sure that my JavaScript files delivered over a CDN are not altered?](https://stackoverflow.com/questions/38700923/how-can-i-make-sure-that-my-javascript-files-delivered-over-a-cdn-are-not-altere)

I am working on a scenario in which some JavaScript files are to be hosted on a CDN. I want to have some mechanism so that when these file are downloaded on user side, I can ensure that the files were not tampered with and are indeed coming from the specified CDN. I understand that the task is very easy if I am using SSL, but still, I want to ensure that the right files are served even on HTTP without SSL.As far as I could search, there is no existing mechanism like digital signature for JavaScript files which is supported across platforms. Perhaps it's not needed?Is there some method built in to browsers to verify the author of the JavaScript files? Is there anything I can do to do this in a secure way?

2016-08-01 14:04:08Z

I am working on a scenario in which some JavaScript files are to be hosted on a CDN. I want to have some mechanism so that when these file are downloaded on user side, I can ensure that the files were not tampered with and are indeed coming from the specified CDN. I understand that the task is very easy if I am using SSL, but still, I want to ensure that the right files are served even on HTTP without SSL.As far as I could search, there is no existing mechanism like digital signature for JavaScript files which is supported across platforms. Perhaps it's not needed?Is there some method built in to browsers to verify the author of the JavaScript files? Is there anything I can do to do this in a secure way?As a matter of fact, a feature like this is currently being drafted under the name of Subresource Integrity. Look into the integrity attribute of the <script> tag. While not yet fully adopted across the board, it fulfills just this purpose.SourceSourceExample:Note however that this will not protect you against Man in the Middle attacks if you are transferring your resources via plain HTTP. In this case, the hash code can be spoofed by the attacker, rendering the defense against manipulated script files useless.For this reason, you should always use secure HTTPS connections instead of plain HTTP in addition to the security measures described above.You're looking for subresource integrity checks.For example, here's the jQuery CDN snippet:Disclaimer: As always, you should only consider these mechanisms to be of any use when using https, as they can easily be disabled via MitM with httpIn addition to the mechanism in the above answers, you can also use the content-security policy http response headers on the parent page.http://www.html5rocks.com/en/tutorials/security/content-security-policy/This mechanism has been around for quite some time, so the browser support is likely pretty good, just be sure to check. Additionally, if you want to ensure that older non-compliant browsers are not insecure, you can include a synchronous redirect script at the top of the page that is not allowed by the policy.There's an important point about what this kind of signing can and cannot do.  It can protect the user from hypothetical attacks in which someone modifies your code.  It cannot assure your site that your code is the code being executed.  In other words, you still can't trust anything that comes to your site from the client.If your adversary model permits an attacker to modify JavaScript files as they are delivered from a CDN, then your adversary model permits an attacker to modify the referring source as it is delivered to remove any attempt at verification, to alter the source address to other than the CDN, and/or to remove the reference to the JavaScript entirely.And lets not open the can of worms of how your application can determine whether the user's resolver is or is not correctly resolving to the CDN via HTTP requests (or any other mechanism that doesn't have a verified chain of trust)./etc/hosts:You can ensure this with Subresource Integrity. Many public CDNs include SRI hashes in the embeddable code offered on CDN websites. For example, on PageCDN, when you click on jquery file on the jQuery CDN page, you get the option to either copy the URL or use the script tag that contains SRI hash as below:On page load, browser will issue a request for this resource and on completion of request it will match the hash of the received file with the one given as the integrity value in script tag. If both hashes do not match, browser will discard the jquery file.At the moment, this feature is supported by 91% of browsers worldwide. More details on caniuse.

Is possible to debug dynamic loading JavaScript by some debugger like WebKit, FireBug or IE8 Developer Tool?

Soul_Master

[Is possible to debug dynamic loading JavaScript by some debugger like WebKit, FireBug or IE8 Developer Tool?](https://stackoverflow.com/questions/1705952/is-possible-to-debug-dynamic-loading-javascript-by-some-debugger-like-webkit-fi)

From my recent question, I already created some JavaScript function for dynamic loading partial view. So, I can't debug any dynamic loading JavaScript. Because all of loaded JavaScript will be evaluated by "eval" function.However, I found some way to create new JavaScript by using the following script to dynamically create script into header of current document. All loaded scripts will be displayed in HTML DOM (that you can use any debugger to find it).By the way, most debugger (IE8 Developer Toolbar, Firebug and Google Chrome) can’t set breakpoint in any dynamic script. Because debuggable script must be loaded at the first time after page is loaded. Do you have idea for debugging in dynamic script content or file?Update 1 - Add sourcecode for testing You can use the following xhtml file for trying to debug someVariable value.From answer, I just test it in FireBug. The result should be displayed like below images.alt text http://d7cgnq.bay.livefilestore.com/y1pJGV27qEARXzZhsMMhPD5z0OxAtnkQK8eKeEXMAxuHjsuWeAq1aGl7sTISRNqVv3lw8ghyxE_GorlwSJDvTql0m0ugSGXPaY-/undebugable-firebug-html.PNGPlease look at "dynamicLoadingScript" script that is added after page load.alt text http://d7cgnq.bay.livefilestore.com/y1pz_RwqjgeVqe2mAlUZha0PalpPdP0X5AiwJcQhYahERlnbPDdZpb-_d1e96Q-14raSDMJOBsdcV9jsi4B5yCUDqm41Wc3h0yk/undebugable-firebug-script.PNGBut it does not found in script tab of FireBugUpdate 2 - Create Debug Breakpoint in dynamic loading scriptalt text http://d7cgnq.bay.livefilestore.com/y1peKdIMOztXss-pc8PlJEmaGov_0ShYnLsuDdK5OLETbCG0UpkX6Te29w0YW2pNKaD_0ANAiizh2GdGPAAp_1q0JWAETo4Qoiw/Debugger-VS2010.pngalt text http://d7cgnq.bay.livefilestore.com/y1pUeHaHoTXj0WBl74fnTrXwdr_y7s7h8jNKfslSONgshzZBpUddGHNBWA9cXRabo3HAl3QazeozrCABo7pNVQc1Acl-UXXbHFE/Debugger-GoogleChrome.pngBoth of the above images show inserting "debugger;" statement in some line of script can fire breakpoint in dynamic loading script. However, both debuggers do not show any code at breakpoint. Therefore, it is useless for doing this.Thanks,

2009-11-10 06:14:09Z

From my recent question, I already created some JavaScript function for dynamic loading partial view. So, I can't debug any dynamic loading JavaScript. Because all of loaded JavaScript will be evaluated by "eval" function.However, I found some way to create new JavaScript by using the following script to dynamically create script into header of current document. All loaded scripts will be displayed in HTML DOM (that you can use any debugger to find it).By the way, most debugger (IE8 Developer Toolbar, Firebug and Google Chrome) can’t set breakpoint in any dynamic script. Because debuggable script must be loaded at the first time after page is loaded. Do you have idea for debugging in dynamic script content or file?Update 1 - Add sourcecode for testing You can use the following xhtml file for trying to debug someVariable value.From answer, I just test it in FireBug. The result should be displayed like below images.alt text http://d7cgnq.bay.livefilestore.com/y1pJGV27qEARXzZhsMMhPD5z0OxAtnkQK8eKeEXMAxuHjsuWeAq1aGl7sTISRNqVv3lw8ghyxE_GorlwSJDvTql0m0ugSGXPaY-/undebugable-firebug-html.PNGPlease look at "dynamicLoadingScript" script that is added after page load.alt text http://d7cgnq.bay.livefilestore.com/y1pz_RwqjgeVqe2mAlUZha0PalpPdP0X5AiwJcQhYahERlnbPDdZpb-_d1e96Q-14raSDMJOBsdcV9jsi4B5yCUDqm41Wc3h0yk/undebugable-firebug-script.PNGBut it does not found in script tab of FireBugUpdate 2 - Create Debug Breakpoint in dynamic loading scriptalt text http://d7cgnq.bay.livefilestore.com/y1peKdIMOztXss-pc8PlJEmaGov_0ShYnLsuDdK5OLETbCG0UpkX6Te29w0YW2pNKaD_0ANAiizh2GdGPAAp_1q0JWAETo4Qoiw/Debugger-VS2010.pngalt text http://d7cgnq.bay.livefilestore.com/y1pUeHaHoTXj0WBl74fnTrXwdr_y7s7h8jNKfslSONgshzZBpUddGHNBWA9cXRabo3HAl3QazeozrCABo7pNVQc1Acl-UXXbHFE/Debugger-GoogleChrome.pngBoth of the above images show inserting "debugger;" statement in some line of script can fire breakpoint in dynamic loading script. However, both debuggers do not show any code at breakpoint. Therefore, it is useless for doing this.Thanks,It would also be possible to use chrome for the same. Chrome has a feature where you can specify a parser attribute and make the piece of dynamic JS appear as a file which can then be browsed to and break points set. the attribute that needs to be set is where dynamicScript.js is the name of the file that should show up in the script file browser. More information here Paul Irish also talks about it briefly in his excellent talk on Tooling & The Webapp Development StackTry adding a "debugger;" statement in the javascript you're adding dynamically. This should cause it to halt at that line regardless of breakpoint settings.Yes, It is (now) possible to debug dynamically loaded JavaScript using Google Chrome!    No need to add extra debugger; or any other attribute for dynamically loaded JS file. Just follow the below steps to debug:   My tech lead just showed a super-easy way to debug dynamically loaded Javascript methods.As an example, I'm loading JS file when I click on a button using  ajaxcall.   I'm using google chrome for that purpose.In chrome at scripts tab you can enable 'pause on all exceptions'And then put somewhere in your code line try{throw ''} catch(e){}. Chrome will stop execution when it reaches this line.EDIT: modified image so it would be clearer what I'm talking about.I think you might need to give the eval'd code a "name" like this:http://blog.getfirebug.com/2009/08/11/give-your-eval-a-name-with-sourceurl/If you do, I think it's likely the debugger approach from "update 2" should work then.UPDATE: the syntax for sourceUrl has been changed (@ is replaced by #) to avoid errors on unsupported browsers (read: IE). DetailsUsing Chrome(12.0.742.112) with the code you provided plus a debugger statement like thisworks for me.May its more tangible if you bind the selector change to an event on your partial view instead of creating script elements in the html body ( doesnt feel right ).You could do something like thisThis code would always add a limiting selector to all jQuery select operations done while the mouse is in a certain element given the HTML isnt to messed up.(Still seems hackerish, may be someone has a better solution)cheersIn Firebug, you should be able to see that script after the page is loaded and the script is injected. When you do, you can set a breakpoint in the appropriate place, and it'll be preserved when you refresh the page.Dynamicly loaded Javascript still has to be parsed by the browser this is where WebKit, or FireBug debugger is sat so it's subject to the debugger no matter what, i think this is the same for the developer tools in IE8,So your code is subject is to the debugger so where your getting a problem will not be in that file or text if it does not errorThe other thing is script.text = "alert('Test!');"; is not valid so it wont work in all browsers what you want is script.innerHTML = "alert('Test!');"; even though its innerHTML it means code inside the HTML Tags not the HTML inside just the most use people use it for this so it gets explained wrongEDITED FOR UPDATE TWOAnd on Second update using Chrome i did thisgo to about:blank

Open the console up and past in then it will break and open the script tab with about:blank shown (nothing to see)Then on the right hand side show the call stack list, then click on the second (anonymous function) and it will show you.So on your file you will have a (anonymous function) that is the code your running and you will see the break point in there. so you know your in the right one.Using Google Chrome (or Safari) Developers Tool, you can run JavaScript line by line.

Developer Tool > Scripts > Choose which script you want to debug > pause sign on the right side

Or set breakpoints by click the line numberOne option I like to use it adding a console.log('') statement in my code. Once this statement appears in the console a line number is associated with it. You can click that number to go to the location in the source and set a breakpoint. The drawback to this approach is that breakpoints are not preserved across page reloads and you have to run through the code before you can add a debugger.For current Google Chrome browser or other modern browsers, you can easily search for any evaluated code with developer tool like the following images.Create some breakpoint and execute function to test it.

How do I zip two arrays in JavaScript? [duplicate]

userMod2

[How do I zip two arrays in JavaScript? [duplicate]](https://stackoverflow.com/questions/22015684/how-do-i-zip-two-arrays-in-javascript)

I have 2 arrays:What I want to get as a result is:It seems simple but I just can't figure out.I want the result to be one array with each of the elements from the two arrays zipped together.

2014-02-25 13:30:32Z

I have 2 arrays:What I want to get as a result is:It seems simple but I just can't figure out.I want the result to be one array with each of the elements from the two arrays zipped together.Use the map method:

DEMOUsing Array.prototype.map()Using for loop

What values can a constructor return to avoid returning this?

Thomas Eding

[What values can a constructor return to avoid returning this?](https://stackoverflow.com/questions/1978049/what-values-can-a-constructor-return-to-avoid-returning-this)

What are the exact circumstances for which a return statement in Javascript can return a value other than this when a constructor is invoked using the new keyword?Example:If I'm not mistaken, if something is a non-function primitive, this will be returned. Otherwise something is returned. Is this correct?In other words, what values can something take to cause (new Foo () instanceof Foo) === false?

2009-12-30 02:08:28Z

What are the exact circumstances for which a return statement in Javascript can return a value other than this when a constructor is invoked using the new keyword?Example:If I'm not mistaken, if something is a non-function primitive, this will be returned. Otherwise something is returned. Is this correct?In other words, what values can something take to cause (new Foo () instanceof Foo) === false?The exact condition is described on the [[Construct]] internal property, which is used by the new operator:From the ECMA-262 3rd. Edition Specification:Look at steps 7 and 8, the new object will be returned only if the

type of Result(6) (the value returned from the F constructor

function) is not an Object.Concrete examples

http://jsbin.com/zivivucahi/1/edit?html,js,console,outputI couldn't find any documentation on the matter, but I think you're correct. For example, you can return new Number(5) from a constructor, but not the literal 5 (which is ignored and this is returned instead).Trying to put a few points in simpler words.In javascript, when you use a new keyword on a function and if,As a side note, the return value or this is just part of the equation.For example, consider this:As you can see, .valueOf() is internally used and can be exploited for fun and profit. You can even create side effects, for example:I can imagine this must have some sort of practical application. And it doesn't have to be explicitly a Number either, if you add .valueOf to any object it can behave as a number:You can exploit this to make an object that always returns a new GUID, for instance.When you are using the new keyword, an object is created. Then the function is called to initialise the object.There is nothing that the function can do to prevent the object being created, as that is done before the function is called.

How can I set Image source with base64

poppel

[How can I set Image source with base64](https://stackoverflow.com/questions/16449445/how-can-i-set-image-source-with-base64)

I want to set the Image source to a base64 source but it does not work:JSfiddle.net/NT9KBthe JavaScript

2013-05-08 20:17:32Z

I want to set the Image source to a base64 source but it does not work:JSfiddle.net/NT9KBthe JavaScriptTry using setAttribute instead:Real answer:

(And make sure you remove the line-breaks in the base64.)In case you prefer to use jQuery to set the image from Base64:Your problem are the cr (carriage return) http://jsfiddle.net/NT9KB/210/you can use: 

How to have different return values for multiple calls on a Jasmine spy

mikhail

[How to have different return values for multiple calls on a Jasmine spy](https://stackoverflow.com/questions/26898613/how-to-have-different-return-values-for-multiple-calls-on-a-jasmine-spy)

Say I'm spying on a method like this:The function under test calls util.foo multiple times.Is it possible to have the spy return true the first time it's called, but return false the second time? Or is there a different way to go about this?

2014-11-12 23:25:35Z

Say I'm spying on a method like this:The function under test calls util.foo multiple times.Is it possible to have the spy return true the first time it's called, but return false the second time? Or is there a different way to go about this?You can use spy.and.returnValues (as Jasmine 2.4).for exampleThere is some thing you must be careful about, there is another function will similar spell returnValue without s, if you use that, jasmine will not warn you.For older versions of Jasmine, you can use spy.andCallFake for Jasmine 1.3 or spy.and.callFake for Jasmine 2.0, and you'll have to keep track of the 'called' state, either through a simple closure, or object property, etc.If you wish to write a spec for each call you can also use beforeAll instead of beforeEach :

Javascript: Extend a Function

Adam

[Javascript: Extend a Function](https://stackoverflow.com/questions/4578424/javascript-extend-a-function)

The main reason why I want it is that I want to extend my initialize function.Something like this:So I want to extend a function like I extend a class in PHP.And I would like to extend it from other files too, so for example I have the original init function in main.js and the extended function in extended.js.

2011-01-02 12:48:25Z

The main reason why I want it is that I want to extend my initialize function.Something like this:So I want to extend a function like I extend a class in PHP.And I would like to extend it from other files too, so for example I have the original init function in main.js and the extended function in extended.js.With a wider view of what you're actually trying to do and the context in which you're doing it, I'm sure we could give you a better answer than the literal answer to your question.But here's a literal answer:If you're assigning these functions to some property somewhere, you can wrap the original function and put your replacement on the property instead:If your functions aren't already on an object, you'd probably want to put them there to facilitate the above. For instance:But there are such better ways to do that. Like for instance, providing a means of registering init functions.(Much of the above could be written a bit more compactly, but I wanted to use clear names like publicSymbols rather than my usual pubs or anonymous object literal. You can write it a lot more compactly if you want to have anonymous functions, but I don't much care for anonymous functions.)There are several ways to go about this, it depends what your purpose is, if you just want to execute the function as well and in the same context, you can use .apply():If you want to replace it with a newer init, it'd look like this:The other methods are great but they don't preserve any prototype functions attached to init. To get around that you can do the following (inspired by the post from Nick Craver).Another option could be:This is very simple and straight forward. Look at the code. Try to grasp the basic concept behind javascript extension.First let us extend javascript function.You can extend this function by creating child function in following wayNow you can use Child function as follows,We can also create Javascript Function by extending Javascript classes, like this.Let us extend this class with Child function like this,Again you can use Child function as follows to get similar result,Javascript is very easy language. We can do almost anything. Happy JavaScripting... Hope I was able to give you an idea to use in your case.But in your specific case, it's easier to extend the global onload function:I actually really like your question, it's making me think about different use cases.For javascript events, you really want to add and remove handlers - but for extendFunction, how could you later remove functionality? I could easily add a .revert method to extended functions, so init = init.revert() would return the original function. Obviously this could lead to some pretty bad code, but perhaps it lets you get something done without touching a foreign part of the codebase.

Why「$().ready(handler)」is not recommended?

gdoron is supporting Monica

[Why「$().ready(handler)」is not recommended?](https://stackoverflow.com/questions/10753306/why-readyhandler-is-not-recommended)

From the jQuery API docs site for ready After doing homework - reading and playing with the source code, I have no idea why is not recommended.  The first and third ways, are exactly the same, the third option calls the ready function on a cached jQuery object with document:But the ready function has no interaction with the selector of the selected node elements, The ready source code:As you can see, it justs add the callback to an internal queue( readyList) and doesn't change or use the elements in the set. This lets you call the ready function on every jQuery object.Like:Finally... to my question: Why $().ready(handler) is not recommended?

2012-05-25 11:03:30Z

From the jQuery API docs site for ready After doing homework - reading and playing with the source code, I have no idea why is not recommended.  The first and third ways, are exactly the same, the third option calls the ready function on a cached jQuery object with document:But the ready function has no interaction with the selector of the selected node elements, The ready source code:As you can see, it justs add the callback to an internal queue( readyList) and doesn't change or use the elements in the set. This lets you call the ready function on every jQuery object.Like:Finally... to my question: Why $().ready(handler) is not recommended?I got an official answer from one of the jQuery developers:$().ready(fn) only works because $() used to be  a shortcut to $(document)   (jQuery <1.4)

So $().ready(fn) was a readable code.But people used to do things like $().mouseover() and all sorts of other madness.

and people had to do $([]) to get an empty jQuery objectSo in 1.4 we changed it so $() gives an empty jQuery and we just made $().ready(fn) work so as not to break a lot of code$().ready(fn) is literally now just patched in core to make it work properly for the legacy case.The best place for the ready function is $.ready(fn), but it's a really old design decision and that is what we have now.I asked him:His answer was:Since the different options do pretty much the same thing as you point out, it's time to put on the library writer hat and make some guesses.Update #2: Digging at the source, it seems that at some point in the 1.4 branch $() was changed to match $([]), while in 1.3 it behaved like $(document). This change would reinforce the above justifications.I would say its simply the fact that $() returns an empty object whereas $(document) does not so your applying ready() to different things; it still works, but I would say its not intuitive. More than likely this is just a documentation bug and should be fixed, the only downside to using $().ready(handler) is it's readability. Sure, argue that $(handler) is just as unreadable. I agree, that's why I don't use it.You can also argue that one method is faster than another. However, how often do you call this method enough times in a row on a single page to notice a difference?Ultimately it comes down to personal preference. There is no downside to using $().ready(handler) other than the readability argument. I think the documentation is miss-leading in this case.Just to make it patently obvious that there is some inconsistency in the three, plus I added the fourth often used form: (function($) {}(jQuery));With this markup:and this code:The displayed results of the div from the last statement are: 0:9:9:9:undefinedSO, only the Handler and Doc versions are consistent with the jQuery convention of returning something of use as they get the document selector and with the Passed form you must return something (I wouldn't do this I would think, but put it in just to show "inside" it has something).Here is a fiddle version of this for the curious: http://jsfiddle.net/az85G/I think this is really more for readability than anything else.This one isn't as expressive asPerhaps they are trying to promote some form of idiomatic jQuery.

Which Box2D JavaScript library should I use? [closed]

a paid nerd

[Which Box2D JavaScript library should I use? [closed]](https://stackoverflow.com/questions/7628078/which-box2d-javascript-library-should-i-use)

There are a few different ports of Box2D for JavaScript. Which one is the best?Any ideas which version http://chrome.angrybirds.com/ uses, if any?

2011-10-02 17:40:54Z

There are a few different ports of Box2D for JavaScript. Which one is the best?Any ideas which version http://chrome.angrybirds.com/ uses, if any?Here's what I've found:There's also a similar discussion on gamedev.stackexchange.com.I'd say that the winner is kripken/box2d.js.This question and its best answer are from 2011. One recent new option is box2.js, an Emscripten translation of the C++ code to Javascript. As of August 2013 it's more up-to-date than the other ports I've found, and the demos seem to work.LiquidFun (With JS Bindings)LiquidFun is, at the time I'm posting this, the most recent port to JS. It has all the features of Box2D and liquid physics features. It's ported using emscripten, so performance is decent.google/liquidfungoogle/liquidfun/tree/master/liquidfun/Box2D/lfjsProbably the best place to keep up to date with Box2D JavaScript ports is the official forum: http://box2d.org/forum/viewforum.php?f=22JSBox2D looks like a good start.I would definitely have a look into Matter.js, which seems very well built and very quick. I'm going down this path. http://brm.io/matter-jsBox2d-html5 is also another box2d port including Google's LiquidFun) and active update.Box2DWeb supports most of the API from the original C++ Box2D except chain shapes. :/It is the most widely used Javascript Box2D. If you need the API documentation for Box2DWeb, check out Box2DFlash. http://www.box2dflash.org/docs/2.1a/reference/Box2DWeb is auto generated from Box2DFlash using a compiler. So the API is the same.I doubt Box2DWeb will get any update in the future anymore as Box2DFlash has shown no activities anymore. You can see the author's rational on why he decided not to write a direct Box2D --> Box2DWeb port.https://code.google.com/p/box2dweb/wiki/Roadmap

Focus Next Element In Tab Index

JadziaMD

[Focus Next Element In Tab Index](https://stackoverflow.com/questions/7208161/focus-next-element-in-tab-index)

I am trying to move the focus to the next element in the tab sequence based upon the current element which has focus. Thus far I have not turned up anything in my searches.Of course the nextElementByTabIndex is the key part for this to work. How do I find the next element in the tab sequence? The solution would need to be based using JScript and not something like JQuery.

2011-08-26 17:04:59Z

I am trying to move the focus to the next element in the tab sequence based upon the current element which has focus. Thus far I have not turned up anything in my searches.Of course the nextElementByTabIndex is the key part for this to work. How do I find the next element in the tab sequence? The solution would need to be based using JScript and not something like JQuery.Without jquery:

First of all, on your tab-able elements, add class="tabable" this will let us select them later.

(Do not forget the "." class selector prefix in the code below)I've never implemented this, but I've looked into a similar problem, and here's what I would try.First, I would see if you could simply fire a keypress event for the Tab key on the element that currently has focus. There may be a different way of doing this for different browsers.Referencing the jQuery implementation, you must:Listening for Tab and Shift+Tab are probably well-covered elsewhere on the web, so I'll skip that part.Knowing which elements are tab-able is trickier. Basically, an element is tab-able if it is focusable and does not have the attribute tabindex="-1" set. So then we must ask which elements are focusable. The following elements are focusable:Furthermore, an element is focusable only if:More details are in another Stack Overflow answer. The tab order of elements in a document is controlled by the tabindex attribute. If no value is set, the tabindex is effectively 0.The tabindex order for the document is: 1, 2, 3, …, 0.Initially, when the body element (or no element) has focus, the first element in the tab order is the lowest non-zero tabindex. If multiple elements have the same tabindex, you then go in document order until you reach the last element with that tabindex. Then you move to the next lowest tabindex and the process continues. Finally, finish with those elements with a zero (or empty) tabindex. Here's something I build for this purpose:I created a simple jQuery plugin which does just this. It uses the ':tabbable' selector of jQuery UI to find the next 'tabbable' element and selects it.Example usage:The core of the answer lies on finding the next element:Usage:Notice I don't care about prioritizing tabIndex. As mentioned in a comment above, I don't think that any browsers expose tab order information. Here a simplified approximation of what the browser does to get the next element in tab order:This only considers some tags and ignores tabindex attribute but might be enough depending on what you are trying to achieve.It seems that you can check the tabIndex property of an element to determine if it is focusable. An element that is not focusable has a tabindex of "-1".Then you just need to know the rules for tab stops:Here is an example of how to build the list of tab stops, in sequence, using pure Javascript:We first walk the DOM, collecting up all tab stops in sequence with their index. We then assemble the final list. Notice that we add the items with tabIndex="0" at the very end of the list, after the items with a tabIndex of 1, 2, 3, etc.For a fully working example, where you can tab around using the "enter" key, check out this fiddle.Tabbable is a small JS package that gives you a list of all tabbable elements in tab order. So you could find your element within that list, then focus on the next list entry.The package correctly handles the complicated edge cases mentioned in other answers (e.g., no ancestor can be display: none). And it doesn't depend on jQuery!As of this writing (version 1.1.1), it has the caveats that it doesn't support IE8, and that browser bugs prevent it from handling contenteditable correctly.This is my first post on SO, so I don't have enough reputation to comment the accepted answer, but I had to modify the code to the following:The changing of var to constant is non-critical. The main change is that we get rid of the selector that checks tabindex != "-1". Then later, if the element has the attribute tabindex AND it is set to "-1", we do NOT consider it focussable.The reason I needed to change this was because when adding tabindex="-1" to an <input>, this element was still considered focussable because it matches the "input[type=text]:not([disabled])" selector. My change is equivalent to "if we are a non-disabled text input, and we have a tabIndex attribute, and the value of that attribute is -1, then we should not be considered focussable.I believe that when the author of the accepted answer edited their answer to account for the tabIndex attribute, they did not do so correctly. Please let me know if this is not the caseI checked above solutions and found them quite lengthy.

It can be accomplished with just one line of code:or here currentElement may be any i.e. document.activeElement or this if current element is in function's context.I tracked tab and shift-tab events with keydown eventonce you have cursor direction then you can use nextElementSibling.focus or previousElementSibling.focus methodsDid you specify your own tabIndex values for each element you want to cycle through?

if so, you can try this:You are using jquery, right?Hope this is helpful.then use simple javascriptHere is a more complete version of focusing on the next element. It follows the spec guidelines and sorts the list of elements correctly by using tabindex. Also a reverse variable is defined if you want to get the previous element. This is a potential enhancement to the great solution that  @Kano and @Mx offered. If you want to preserve TabIndex ordering, add this sort in the middle:You can call this:Tab: Shift+Tab:I modify jquery.tabbable PlugIn to complete.

How do I Geocode 20 addresses without receiving an OVER_QUERY_LIMIT response?

Michiel van Oosterhout

[How do I Geocode 20 addresses without receiving an OVER_QUERY_LIMIT response?](https://stackoverflow.com/questions/2419219/how-do-i-geocode-20-addresses-without-receiving-an-over-query-limit-response)

Using the Google Geocoder v3, if I try to geocode 20 addresses, I get an OVER_QUERY_LIMIT unless I time them to be ~1 second apart, but then it takes 20 seconds before my markers are all placed.Is there any other way to do it, other than storing the coordinates in advance?

2010-03-10 17:49:34Z

Using the Google Geocoder v3, if I try to geocode 20 addresses, I get an OVER_QUERY_LIMIT unless I time them to be ~1 second apart, but then it takes 20 seconds before my markers are all placed.Is there any other way to do it, other than storing the coordinates in advance?No, there is not really any other way : if you have many locations and want to display them on a map, the best solution is to :This is, of course, considering that you have a lot less creation/modification of locations than you have consultations of locations.

Yes, it means you'll have to do a bit more work when saving the locations -- but it also means :You actually do not have to wait a full second for each request.  I found that if I wait 200 miliseconds between each request I am able to avoid the OVER_QUERY_LIMIT response and the user experience is passable.  With this solution you can load 20 items in 4 seconds.Unfortunately this is a restriction of the Google maps service.I am currently working on an application using the geocoding feature, and I'm saving each unique address on a per-user basis.  I generate the address information (city, street, state, etc) based on the information returned by Google maps, and then save the lat/long information in the database as well. This prevents you from having to re-code things, and gives you nicely formatted addresses.Another reason you want to do this is because there is a daily limit on the number of addresses that can be geocoded from a particular IP address. You don't want your application to fail for a person for that reason.I'm facing the same problem trying to geocode 140 addresses. My workaround was adding usleep(100000) for each loop of next geocoding request. If status of the request is OVER_QUERY_LIMIT, the usleep is increased by 50000 and request is repeated, and so on.And of cause all received data (lat/long) are stored in XML file not to run request every time the page is loading.EDIT:Forgot to say that this solution is in pure js, the only thing you need is a browser that supports promises https://developer.mozilla.org/it/docs/Web/JavaScript/Reference/Global_Objects/PromiseFor those who still needs to accomplish such, I've written my own solution that combines promises with timeouts.Code:Please note that it's just a part of a bigger library I wrote to handle google maps stuff, hence comments may be confusing.Usage is quite simple, the approach, however, is slightly different: instead of looping and resolving one address at a time, you will need to pass an array of addresses to the class and it will handle the search by itself, returning a promise which, when resolved, returns an array containing all the resolved (and unresolved) address.Example:Console output:Object returned:The whole magic happens here:Basically, it loops every item with a delay of 750 milliseconds between each of them, hence every 750 milliseconds an address is controlled.I've made some further testings and I've found out that even at 700 milliseconds I was sometimes getting the QUERY_LIMIT error, while with 750 I haven't had any issue at all.In any case, feel free to edit the 750 above if you feel you are safe by handling a lower delay.Hope this helps someone in the near future ;)I have just tested Google Geocoder and got the same problem as you have. 

I noticed I only get the OVER_QUERY_LIMIT status once every 12 requests

So I wait for 1 second (that's the minimum delay to wait)

It slows down the application but less than waiting 1 second every requestWith the basic holdOn method :Hope it helps

Why does canvas.toDataURL() throw a security exception?

pop850

[Why does canvas.toDataURL() throw a security exception?](https://stackoverflow.com/questions/2390232/why-does-canvas-todataurl-throw-a-security-exception)

Did I not get enough sleep or what? This following codeis throwing this error: There's no way this shouldn't work! Can anyone explain this, please?

2010-03-05 22:00:18Z

Did I not get enough sleep or what? This following codeis throwing this error: There's no way this shouldn't work! Can anyone explain this, please?In the specs it says:If the image is coming from another server I don't think you can use toDataURL()Setting cross origin attribute on the image objects worked for me (i was using fabricjs)For those using fabricjs, here's how to patch Image.fromUrlIf the image is hosted on a host that sets either of Access-Control-Allow-Origin or Access-Control-Allow-Credentials, you can use Cross Origin Resource Sharing (CORS). See here (the crossorigin attribute) for more details.Your other option is for your server to have an endpoint that fetches and serves an image. (eg. http://your_host/endpoint?url=URL)

The downside of that approach being latency and theoretically unnecessary fetching.If there are more alternate solutions, I'd be interested in hearing about them.Seems there is a way to prevent that if image hosting able to provide the following HTTP headers for the image resources and browser supports CORS:It is stated here: http://www.w3.org/TR/cors/#use-casesFinally i found the solution. Just need add the crossOrigin as third param in fromURL funcI had the same problem and all the images are hosted in the same domain... So, if someone is having the same problem, here is how I solved:I had two buttons: one to generate the canvas and another one to generate the image from the canvas. It only worked for me, and sorry that I don't know why, when I wrote all the code on the first button. So when I click it generate the canvas and the image at the same time...I always have this security problem when the codes were on different functions... =/I was able to make it work using this:Write this on first line of your .htaccess on your source serverThen when creating an <img> element, do it as follows:You can't put spaces in your IDUpdateMy guess is that image is on a different server than where you're executing the script. I was able to duplicate your error when running it on my own page, but it worked fine the moment I used an image hosted on the same domain. So it's security related - put the image on your site. Anyone know why this is the case?If you are simply drawing some images on a canvas, make sure you are loading the images from the same domain.www.example.com is different to example.com So make sure your images and the url you have in your address bar are the same, www or not.I'm using fabric.js and could resolve this by using toDatalessJSON instead of toDataURL:Edit: Nevermind. This results in just the background image being exported to JPG, without the drawing on top so it was not entirely useful after all.

Using $window or $location to Redirect in AngularJS

Thorbjørn Kappel Hansen

[Using $window or $location to Redirect in AngularJS](https://stackoverflow.com/questions/24794115/using-window-or-location-to-redirect-in-angularjs)

The app I am working on contains various states (using ui-router), where some states require you to be logged in, others are publicly available.I have created a method that validly checks whether a user is logged in, what I am currently having issues with is actually redirecting to our login-page when necessary. It should be noted that the login page is not currently placed within the AngularJS app.The console.log shows the intended url properly. The line after that, I have tried practically everything from $window.open to window.location.href and no matter what I've tried no redirect happens.EDIT (RESOLVED):Found the issue. The variable landingUrl was set to 'domain.com/login', which would not work with 

$window.location.href (which was one of the things I tried). However after changing the code toit now works.

2014-07-17 02:54:15Z

The app I am working on contains various states (using ui-router), where some states require you to be logged in, others are publicly available.I have created a method that validly checks whether a user is logged in, what I am currently having issues with is actually redirecting to our login-page when necessary. It should be noted that the login page is not currently placed within the AngularJS app.The console.log shows the intended url properly. The line after that, I have tried practically everything from $window.open to window.location.href and no matter what I've tried no redirect happens.EDIT (RESOLVED):Found the issue. The variable landingUrl was set to 'domain.com/login', which would not work with 

$window.location.href (which was one of the things I tried). However after changing the code toit now works.I believe the way to do this is $location.url('/RouteTo/Login');Edit for ClaritySay my route for my login view was /Login, I would say $location.url('/Login') to navigate to that route.For locations outside of the Angular app (i.e. no route defined), plain old JavaScript will serve:It seems that for full page reload $window.location.href is the preferred way. https://docs.angularjs.org/guide/$locationIt might help you! demoAngularJs Code-sampleHTML Code-sampleNot sure from what version, but I use 1.3.14 and you can just use:No need to inject $location or $window in the controller and no need to get the current host address.You have to put:<html ng-app="urlApp" ng-controller="urlCtrl"> This way the angular function can access into "window" object

Get current clipboard content? [closed]

Gabriele Cirulli

[Get current clipboard content? [closed]](https://stackoverflow.com/questions/6413036/get-current-clipboard-content)

I'd like to know a way to make my script detect the content of the clipboard and paste it into a text field when the page is opened, with no input from the user. How can it be done?

2011-06-20 14:45:44Z

I'd like to know a way to make my script detect the content of the clipboard and paste it into a text field when the page is opened, with no input from the user. How can it be done?window.clipboardData.getData('Text') will work in some browsers.  However, many browsers where it does work will prompt the user as to whether or not they wish the web page to have access to the clipboard.Depending on when you read this, the new clipboard API may be available, via navigator.clipboard. It can be used like so:Or with async syntax:const text = await navigator.clipboard.readText();Keep in mind that this will prompt the user with a permission request dialog box, so no funny business possible.(NOTE: This will not work if called from the console, but will require a direct user action such as pressing a button, thanks @Artur)More on thatSpecYou can useto get the content of user's clipboard in IE. However, in other browser you may need to use flash to get the content, since there is no standard interface to access the clipboard. May be you can have try this plugin Zero ClipboardFollowing will give you the selected content as well as updating the clipboard.Bind the element id with copy event and then get the selected text. You could replace or modify the text. Get the clipboard and set the new text. To get the exact formatting you need to set the type as "text/hmtl". You may also bind it to the document instead of element.

Dealing with float precision in Javascript [duplicate]

Jeroen

[Dealing with float precision in Javascript [duplicate]](https://stackoverflow.com/questions/11695618/dealing-with-float-precision-in-javascript)

I have a large amount of numeric values y in javascript.  I want to group them by rounding them down to the nearest multiple of x and convert the result to a string. How do I get around the annoying floating point precision?  For example:Two things I have tried:and:

2012-07-27 21:03:42Z

