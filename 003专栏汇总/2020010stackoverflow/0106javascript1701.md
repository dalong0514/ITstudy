Programmatically trigger「select file」dialog box

tamakisquare

[Programmatically trigger「select file」dialog box](https://stackoverflow.com/questions/8595389/programmatically-trigger-select-file-dialog-box)

I have a hidden file input element. Is it possible to trigger its select file dialog box from a button's click event?

2011-12-21 19:44:01Z

I have a hidden file input element. Is it possible to trigger its select file dialog box from a button's click event?If you're looking to have your own button to upload a file instead of using <input type="file" />, you can do something like:Note that I used visibility: hidden, instead of display: none. You cannot call the click event on a non-displayed file input.Most answers here are lacking a useful information:Yes, you can programmatically click the input element using jQuery/JavaScript, but only if you do it in an event handler belonging to an event THAT WAS STARTED BY THE USER!So, for example, nothing will happen if you, the script, programmatically click the button in an ajax callback, but if you put the same line of code in an event handler that was raised by the user, it will work.P.S. The debugger; keyword disrupts the browse window if it is before the programmatical click ...at least in chrome 33...Just for the record, there is an alternative solution that does not require javascript. It is a bit of a hack, exploiting the fact that clicking on a label sets the focus on the associated input.You need a <label> with a proper for attribute (points to the input), optionnaly styled like a button (with bootstrap, use btn btn-default). When the user clicks the label, the dialog opens, example :I'm not sure how browsers handle clicks on type="file" elements (security concerns and all), but this should work:I've tested this JSFiddle in Chrome, Firefox and Opera and they all show the file browse dialog.I wrap the input[type=file] in a label tag, then style the label to your liking, and hide the input.Purely CSS Solution. Natively the only way is by creating an <input type="file"> element and then simulating a click, unfortunately.There's a tiny plugin (shameless plug) which will take the pain away of having to do this all the time: file-dialog The best solution, works in all browsers.. even on mobile.Hiding the input file type causes problems with browsers, opacity is the best solution because it isn't hiding, just not showing. :)There is no cross browser way of doing it, for security reasons. What people usually do is overlay the input file over something else and set it's visibility to hidden so it gets triggered on it's own. More info here.Make sure you are using binding to get component props in REACTUsing jQuery you can call click() to simulate a click.This worked for me:For those who want the same but are using React

How to validate date with format「mm/dd/yyyy」in JavaScript?

matt

[How to validate date with format「mm/dd/yyyy」in JavaScript?](https://stackoverflow.com/questions/6177975/how-to-validate-date-with-format-mm-dd-yyyy-in-javascript)

I want to validate the date format on an input using the format mm/dd/yyyy.I found below codes in one site and then used it but it doesn't work:Any suggestion about what could be wrong?

2011-05-30 15:11:02Z

I want to validate the date format on an input using the format mm/dd/yyyy.I found below codes in one site and then used it but it doesn't work:Any suggestion about what could be wrong?I think Niklas has the right answer to your problem. Besides that, I think the following date validation function is a little bit easier to read:I would use Moment.js for date validation.Jsfiddle: http://jsfiddle.net/q8y9nbu5/true value is for strict parsing credit to @Andrey Prokhorov which meansUse the following regular expression to validate:This is working for me for MM/dd/yyyy.All credits go to elian-ebbingJust for the lazy ones here I also provide a customized version of the function for the format yyyy-mm-dd.You could use Date.parse()You can read in MDN documentationAnd check if the result of Date.parse isNaNPlease take a look when is recommended to use Date.parse in MDNIt appears to be working fine for mm/dd/yyyy format dates, example:http://jsfiddle.net/niklasvh/xfrLm/The only problem I had with your code was the fact that:Had a space inside the brackets, before the element ID. Changed it to:Without any further details regarding the type of data that isn't working, there isn't much else to give input on.The function will return true if the given string is in the right format('MM/DD/YYYY') else it will return false. (I found this code online & modified it a little)Here is one snippet to check for valid date:It's ok if you want to check validate dd/MM/yyyy Find in the below code which enables to perform the date validation for any of the supplied format to validate start/from and end/to dates. There could be some better approaches but have come up with this. Note supplied date format and date string go hand in hand.Below is the HTML snippetI pulled most of this code from another post found here. I have modified it for my purposes. This works well for what I need. It may help with your situation.Similar to Elian Ebbing answer, but support "\", "/", ".", "-", " " delimitersMoment is really a good one to resolve it. I don't see reason to add complexity just to check date... take a look on moment : http://momentjs.com/HTML :Script :First string date is converted to js date format and converted into string format again, then it is compared with original string.returns true for a valid date string.returns the literal 'Invalid Date' for any invalid date_string.Note: Please see the comment's below.

How to resize Twitter Bootstrap modal dynamically based on the content

Erdem Ece

[How to resize Twitter Bootstrap modal dynamically based on the content](https://stackoverflow.com/questions/16152275/how-to-resize-twitter-bootstrap-modal-dynamically-based-on-the-content)

I have database content which has different types of data, such as Youtube videos, Vimeo videos, text, Imgur pictures, etc. All of them have different heights and widths. All I have found while searching the Internet is changing the size to only one parameter. It has to be same as the content in the popup. This is my HTML code. I also use Ajax to call the content.

2013-04-22 16:39:10Z

I have database content which has different types of data, such as Youtube videos, Vimeo videos, text, Imgur pictures, etc. All of them have different heights and widths. All I have found while searching the Internet is changing the size to only one parameter. It has to be same as the content in the popup. This is my HTML code. I also use Ajax to call the content.Since your content must be dynamic you can set the css properties of the modal dynamically on show event of the modal which will re-size the modal overriding its default specs. Reason being bootstrap applies a max-height to the modal body with the css rule as below:So you can add inline styles dynamically using jquery css method: For newer versions of bootstrap use show.bs.modalFor older versions of bootstrap use showor use a css rule to override:and add this class autoModal to your target modals.Change the content dynamically in the fiddle, you will see the modal getting resized accordingly. DemoNewer version of bootstrap see the available event names.Older version of bootstrap modal events  supported.This worked for me, none of the above worked.I couldn't get PSL's answer working for me so I found all I have to do is set the div holding the modal content with style="display: table;". The modal content itself says how big it wants to be and the modal accommodates it.There are many ways to do this if you want to write css then add followingIn case if you want to add inline Don't add display:table; to modal-content class. it done your job but disposition your modal for large size see following screenshots.

first image is if you add style to modal-dialog

if you add style to modal-content. it looks dispositioned.

for bootstrap 3 use likeSimple Css work for me You can do that if you use jquery dialog plugin from gijgo.com and set the width to auto.You can also allow the users to control the size if you set resizable to true. You can see a demo about this at http://gijgo.com/Dialog/Demos/bootstrap-modal-resizableI simply override the css:A simple CSS solution that will vertically and horizontally center the modal:set width:fit-content on the modal div.For Bootstrap 2 Auto adjust model height dynamicallyI had the same problem with bootstrap 3 and the modal-body div's height not wanting to be greater than 442px.  This was all the css needed to fix it in my case:Mine Solution was just to add below style.

<div class="modal-body" style="clear: both;overflow: hidden;">As of Bootstrap 4 - it has a style of:so if you are looking to resize the modal width to some-width larger, I would suggest using this in your css for example:Note that setting width: 87vw; will not override bootstrap's max-width: 500px;.

How to create dynamic href in react render function?

Connor Leech

[How to create dynamic href in react render function?](https://stackoverflow.com/questions/31567729/how-to-create-dynamic-href-in-react-render-function)

I am rendering a list of posts. For each post I would like to render an anchor tag with the post id as part of the href string.How do I do it so that each post has href's of /posts/1, /posts/2 etc?

2015-07-22 15:35:26Z

I am rendering a list of posts. For each post I would like to render an anchor tag with the post id as part of the href string.How do I do it so that each post has href's of /posts/1, /posts/2 etc?Use string concatenation:The JSX syntax allows either to use strings or expressions ({...}) as values. You cannot mix both. Inside an expression you can, as the name suggests, use any JavaScript expression to compute the value.You can use ES6 backtick syntax tooMore info on es6 template literalsIn addition to Felix's answer, would work well too. This is nice because it's all in one string.Could you please try this ?Create another item in post such as post.link then assign the link to it before send post to the render function.So, the above render function should be following instead.

How to display loading message when an iFrame is loading?

Jacob

[How to display loading message when an iFrame is loading?](https://stackoverflow.com/questions/8626638/how-to-display-loading-message-when-an-iframe-is-loading)

I have an iframe that loads a third party website which is extremely slow to load.Is there a way I can display a loading message while that iframe loads the user doesn't see a large blank space?PS. Note that the iframe is for a third party website so I can't modify / inject anything on their page.

2011-12-24 20:12:35Z

I have an iframe that loads a third party website which is extremely slow to load.Is there a way I can display a loading message while that iframe loads the user doesn't see a large blank space?PS. Note that the iframe is for a third party website so I can't modify / inject anything on their page.I have done the following css approach:I think that this code is going to help:JS:HTML:CSS:If it's only a placeholder you are trying to achieve: a crazy approach is to inject text as an svg-background. It allows for some flexbility, and from what I've read the browser support should be fairly decent (haven't tested it though):html:css:What can you change?Inside the background-value:Example on fiddlePros:Cons:I would only recommend this only if it's absolutely necessary to show text as a placeholder in an iframe which requires a little bit of flexbility (multiple languages, ...). Just take a moment and reflect on it: is all this really necessary? If I had a choice, I'd go for @Christina's methodHere's a quick solution for most of the cases:CSS:You can use an animated loading GIF if you want to,HTML:Using the onload event you can remove the loading image after the source page is loaded inside your iframe.If you are not using jQuery, just put an id into the div and replace this part of code:by something like this:All the best!Yes, you could use a transparent div positioned over the iframe area, with a loader gif as only background. Then you can attach an onload event to the iframe:You can use as belowI have followed the following approachFirst, add sibling divand then when the iframe completed loading

Is there a HTML opposite to <noscript>?

Re0sless

[Is there a HTML opposite to <noscript>?](https://stackoverflow.com/questions/30319/is-there-a-html-opposite-to-noscript)

Is there a tag in HTML that will only display its content if JavaScript is enabled? I know <noscript> works the opposite way around, displaying its HTML content when JavaScript is turned off. But I would like to only display a form on a site if JavaScript is available, telling them why they can't use the form if they don't have it.The only way I know how to do this is with the document.write(); method in a script tag, and it seems a bit messy for large amounts of HTML.

2008-08-27 14:44:02Z

Is there a tag in HTML that will only display its content if JavaScript is enabled? I know <noscript> works the opposite way around, displaying its HTML content when JavaScript is turned off. But I would like to only display a form on a site if JavaScript is available, telling them why they can't use the form if they don't have it.The only way I know how to do this is with the document.write(); method in a script tag, and it seems a bit messy for large amounts of HTML.You could have an invisible div that gets shown via JavaScript when the page loads.Easiest way I can think of:No document.write, no scripts, pure CSS.I don't really agree with all the answers here about embedding the HTML beforehand and hiding it with CSS until it is again shown with JS. Even w/o JavaScript enabled, that node still exists in the DOM. True, most browsers (even accessibility browsers) will ignore it, but it still exists and there may be odd times when that comes back to bite you.My preferred method would be to use jQuery to generate the content. If it will be a lot of content, then you can save it as an HTML fragment (just the HTML you will want to show and none of the html, body, head, etc. tags) then use jQuery's ajax functions to load it into the full page.First of all, always separate content, markup and behaviour!Now, if you're using the jQuery library (you really should, it makes JavaScript a lot easier), the following code should do:This will give you an additional class on the body when JS is enabled.

Now, in CSS, you can hide the area when the JS class is not available, and show the area when JS is available.Alternatively, you can add no-js as the the default class to your body tag, and use this code:Remember that it is still displayed if CSS is disabled.I have a simple and flexible solution, somewhat similar to Will's (but with the added benefit of being valid html):Give the body element a class of "jsOff". Remove (or replace) this with JavaScript. Have CSS to hide any elements with a class of "jsOnly" with a parent element with a class of "jsOff".This means that if JavaScript is enabled, the "jsOff" class will be removed from the body. This will mean that elements with a class of "jsOnly" will not have a parent with a class of "jsOff" and so will not match the CSS selector that hides them, thus they will be shown.If JavaScript is disabled, the "jsOff" class will not be removed from the body. Elements with "jsOnly" will have a parent with "jsOff" and so will match the CSS selector that hides them, thus they will be hidden.Here's the code:It's valid html. It is simple. It's flexible.Just add the "jsOnly" class to any element that you want to only display when JS is enabled.Please note that the JavaScript that removes the "jsOff" class should be executed as early as possible inside the body tag. It cannot be executed earlier, as the body tag will not be there yet. It should not be executed later as it will mean that elements with the "jsOnly" class may not be visible right away (as they will match the CSS selector that hides them until the "jsOff" class is removed from the body element).This could also provide a mechanism for js-only styling (e.g. .jsOn .someClass{}) and no-js-only styling (e.g. .jsOff .someOtherClass{}). You could use it to provide an alternative to <noscript>:You could also use Javascript to load content from another source file and output that. That may be a bit more black box-is than you're looking for though. Here's an example for the hidden div way:(You'd probably have to tweak it for poor IE, but you get the idea.)My solution.css:.js:.html:Alex's article springs to mind here, however it's only applicable if you're using ASP.NET - it could be emulated in JavaScript however but again you'd have to use document.write();You could set the visibility of a paragraph|div to 'hidden'.Then in the 'onload' function, you could set the visibility to 'visible'.Something like:<body onload="javascript:document.getElementById(rec).style.visibility=visible">

<p style="visibility: visible" id="rec">This text to be hidden unless javascript available.</p>There isn't a tag for that. You would need to use javascript to show the text. Some people already suggested using JS to dynamically set CSS visible. You could also dynamically generate the text with document.getElementById(id).innerHTML = "My Content" or dynamically creating the nodes, but the CSS hack is probably the most straightforward to read.In the decade since this question was asked, the HIDDEN attribute was added to HTML. It allows one to directly hide elements without using CSS. As with CSS-based solutions, the element must be un-hidden by script:

Responding with a JSON object in Node.js (converting object/array to JSON string)

climboid

[Responding with a JSON object in Node.js (converting object/array to JSON string)](https://stackoverflow.com/questions/5892569/responding-with-a-json-object-in-node-js-converting-object-array-to-json-string)

I'm a newb to back-end code and I'm trying to create a function that will respond to me a JSON string. I currently have this from an exampleThis basically just prints the string "random numbers that should come in the form of JSON". What I want this to do is respond with a JSON string of whatever numbers. Do I need to put a different content-type? should this function pass that value to another one say on the client side?Thanks for your help!

2011-05-05 04:06:25Z

I'm a newb to back-end code and I'm trying to create a function that will respond to me a JSON string. I currently have this from an exampleThis basically just prints the string "random numbers that should come in the form of JSON". What I want this to do is respond with a JSON string of whatever numbers. Do I need to put a different content-type? should this function pass that value to another one say on the client side?Thanks for your help!Using res.json with Express:Alternatively:If you alert(JSON.stringify(objToJson)) you will get {"response":"value"}You have to use the JSON.stringify() function included with the V8 engine that node uses.Edit: As far as I know, IANA has officially registered a MIME type for JSON as application/json in RFC4627.  It is also is listed in the Internet Media Type list here.Per JamieL's answer to another post:in express there may be application-scoped JSON formatters.after looking at express\lib\response.js, I'm using this routine:

How to host material icons offline?

Luke Tan

[How to host material icons offline?](https://stackoverflow.com/questions/37270835/how-to-host-material-icons-offline)

My apologies if this is a very simple question, but how do you use google material icons without a  ?I would like my app to be able to display the icons even when the user does not have an internet connection

2016-05-17 08:25:43Z

My apologies if this is a very simple question, but how do you use google material icons without a  ?I would like my app to be able to display the icons even when the user does not have an internet connectionMethod 2. Self hosting Developer GuideDownload the latest release from github (assets: zip file), unzip, and copy the iconfont folder, containing the material design icons files, into your local project -- https://github.com/google/material-design-icons/releasesYou only need to use the iconfont folder from the archive: it contains the icons fonts in the different formats (for multiple browser support) and boilerplate css.NPM / Bower PackagesGoogle officially has a Bower and NPM dependency option -- follow Material Icons Guide 1Using bower : bower install material-design-icons --saveUsing NPM : npm install material-design-icons --saveMaterial Icons : Alternatively look into Material design icon font and CSS framework for self hosting the icons, from @marella's https://marella.me/material-icons/NoteI'm building for Angular 4/5 and often working offline and so the following worked for me.  First install the NPM:Then add the following to styles.css:The upper approaches does not work for me. 

I download the files from github, but the browser did not load the fonts.What I did was to open the material icon source link:https://fonts.googleapis.com/icon?family=Material+Iconsand I saw this markup:I open the woff font url link https://fonts.gstatic.com/s/materialicons/v22/2fcrYFNaTjcS6g4U3t-Y5ZjZjT5FdEJ140U2DJYC3mY.woff2and download the woff2 file. Then I replace the woff2 file path with the new one in material-icons.cssThat makes thing works for me.If you use webpack project, afteryou just need toThis may be an easy SolutionGet this repository that is a fork of the original repository Google published.Install it with bower or npmImport the css File on your HTML PageorTest: Add an icon inside body tag of your HTML FileIf you see the face icon, you are OK.If does not work, try add this .. as prefix to node_modules path:My recipe has three steps:I've created material-design-icons-iconfont to address these major issues:It depends on how you pack your web application (webpack/gulp/bower/...), you'll need to import the .css/.scss file (and might change the relative fonts path)Import Using SCSSImport in one of your sass filesLater on, reference your desired icon <i class="material-icons"> + icon-id + </i> It comes with a light demo page to assist searching and copy-pasting fontsI have tried to compile everything that needs to be done for self-hosting icons in my answer.

You need to follow these 4 simple steps.Note : The address provided in src:url(...) should be with respect to the 'CSS File' and not the index.html file. For example it can be  src : url(../myicons/MaterialIcons-Regular.woff2)Click here to see all the icons that can be used.After you have done npm install material-design-icons, add this in your main CSS file: With angular clior material-design-icons-iconfont is the latest updated version of the icons. angular-material-icons is not updated for a long timeWait wait wait install to be done and then add it to angular.json -> projects -> architect -> stylesor if you installed material-desing-icons-iconfont thenOn http://materialize.com/icons.html the style header information you include in the page,you can go to the actual Hyperlink and make localized copies to use icons offline.Here's how.NB: You will download two Files in all icon.css and somefile.woff.<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> .Save page as whatever_filename.css. Default is icon.csssrc: local('Material Icons'), local('MaterialIcons-Regular'), url(https://fonts.gstatic.com/s/materialicons/v22/2fcrYFNaTjcS6g4U3t-Y5ZjZjT5FdEJ140U2DJYC3mY.woff2) https://fonts.gstatic.com/s/materialicons/v22/2fcrYFNaTjcS6g4U3t-Y5ZjZjT5FdEJ140U2DJYC3mY.woff2 . Your browser will automatically download it. Save it in your CSS folder.The question title asks how to host material icons offline but the body clarifies that the objective is to use the material icons offline (emphasis mine).Using your own copy of the material icons files is a valid approach/implementation.  Another, for those that can use a service worker is to let the service worker take care of it.  That way you don't have the hassle of obtaining a copy and keeping it up to date.For example, generate a service worker using Workbox, using the simplest approach of running workbox-cli and accepting the defaults, then append the following text to the generated service worker:You can then check it was cached in Chrome using F12 > Application > Storage > IndexedDB and look for an entry with googleapis in the name.2019 Update here:To self host your material icons, the Regular ones, Rounded, Sharp, all the variants.

Go get them from this repo:

https://github.com/petergng/material-icon-fontFor some reason I dont know why these fonts are not easily accessible from Google repositories.But here you go.After downloading the package, go to bin folder and you'll see the four variants.

Of course, it is up to you to use whichever.To use them, create a css file and

1. Generate a font face for each variant you need:The url will link to where the icons are located in your project.This will make both 

.material-icons-outlined, 

and 

.material-icons classes use the same defaults.

If you want to to use .material-icons-sharp, just append it to the two class names.Again, to use more variant, like Sharp, just add its block like the two above.Once done...go to your html and use your newly minted icons.<i class="material-icons-outlined">hourglass_empty</i><i class="material-icons">phone</i>Kaloyan Stamatov method is the best.

First go to https://fonts.googleapis.com/icon?family=Material+Icons. and copy the css file.

the content look like this paste the source of the font to the browser to download the woff2 file 

https://fonts.gstatic.com/s/materialicons/v37/flUhRq6tzZclQEJ-Vdg-IuiaDsNc.woff2

Then replace the file in the original source. You can rename it if you want

No need to download 60MB file from github.Dead simple

My code looks like this }while materialIcon.woff2 is the downloaded and replaced woff2 file.Install npm package   Put css file path to styles.css fileAdded this to the web config and the error went awayandworked also for me with Angular Material 8

How can I change the current URL?

leora

[How can I change the current URL?](https://stackoverflow.com/questions/3846935/how-can-i-change-the-current-url)

I have the following code that changes the pages from within JavaScript:But it doesn't change the top URL, so when someone clicks the back button it doesn't go back to the previous page.How can I have JavaScript change the top URL as well so the browser back button works.

2010-10-02 18:08:31Z

I have the following code that changes the pages from within JavaScript:But it doesn't change the top URL, so when someone clicks the back button it doesn't go back to the previous page.How can I have JavaScript change the top URL as well so the browser back button works.https://developer.mozilla.org/en-US/docs/Web/API/document.locationSimple assigning to window.location or window.location.href should be fine:However, your new URL will cause the browser to load the new page, but it sounds like you'd like to modify the URL without leaving the current page.  You have two options for this:Hmm, I would useI'm not exactly sure if that is what you mean.If you just want to update the relative path you can also dowindow.location.pathname = '/relative-link'"http://domain.com" -> "http://domain.com/relative-link"

DateTime to javascript date

AJ.

[DateTime to javascript date](https://stackoverflow.com/questions/2404247/datetime-to-javascript-date)

From another answer on Stackoverflow is a conversion from Javascript date to .net DateTime:But how to do the reverse? DateTime to Javascript Date?

2010-03-08 19:50:54Z

From another answer on Stackoverflow is a conversion from Javascript date to .net DateTime:But how to do the reverse? DateTime to Javascript Date?Try:Edit: true UTC is better, but then we need to be consistentAlthough, on second thoughts it does not matter, as long as both dates are in the same time zone.JavaScript Date constructor accepts number of milliseconds since Unix epoch (1 January 1970 00:00:00 UTC). Here’s C# extension method that converts .Net DateTime object to JavaScript date:JavaScript Usage:With Moment.js simply use:Where netDateTime is your DateTime variable serialized, something like "/Date(1456956000000+0200)/".You can try this in your Action:And this in your Ajax success:Or this in your View: (Javascript plus C#)This should do the  trick:I know this is a little late, but here's the solution I had to come up with for handling dates when you want to be timezone independent.  Essentially it involves converting everything to UTC.From Javascript to Server: Send out dates as epoch values with the timezone offset removed.The server then recieves 1420070400000 as the date epoch.On the Server side, convert that epoch value to a datetime object:At this point the date is just the date/time provided by the user as they provided it.  Effectively it is UTC.Going the other way:When the server pulls data from the database, presumably in UTC, get the difference as an epoch (making sure that both date objects are either local or UTC):orWhen javascript receives this value, create a new date object.  However, this date object is going to be assumed local time, so you need to offset it by the current timezone:As far as I know, this should work for any time zone where you need to display dates that are timezone independent.This method is working for me:If you use MVC with razor    -----Razor/C#---JavascriptGood luckIn order to convert the date to JS date(all numbers):Another late answer, but this is missing here. If you want to handle conversion of serialized /Date(1425408717000)/ in javascript, you can simply call:Source: amirsahib

Javascript: Using integer as key in associative array?

Claudiu

[Javascript: Using integer as key in associative array?](https://stackoverflow.com/questions/2002923/javascript-using-integer-as-key-in-associative-array)

When I create a new javascript array, and use an integer as a key, each element of that array up to the integer is created as undefined.

for example:will output 2298 undefined's and one 'Some string'.How should I get javascript to use 2300 as a string instead of an integer, or how should I keep it from instanciating 2299 empty indices?

2010-01-04 23:03:20Z

When I create a new javascript array, and use an integer as a key, each element of that array up to the integer is created as undefined.

for example:will output 2298 undefined's and one 'Some string'.How should I get javascript to use 2300 as a string instead of an integer, or how should I keep it from instanciating 2299 empty indices?Use an object, as people are saying. However, note that you can not have integer keys. JavaScript will convert the integer to a string. The following outputs 20, not undefined:You can just use an object:As people say javascript will convert an string of number to integer so is not possible to use directly on an associative array, but objects will work for you in similar way I think.You can create your object:and add the values as array works:this will give you:After that you can access it like array in other languages getting the key:I hope this is useful! I have tested and works.If the use-case is storing data in a collection then ES6 provides the Map type.It's only heavier to initialize.Here is an example:Result:Compiling other answers:When using a number as a new property's key, the number turns into a string: When accessing the property's value using the same number, the number is turned into a string again:When getting the keys from the object, though, they aren't going to be turned back into numbers:ES6 allows the use of the Map object (documentation, a comparison with Object). If your code is meant to be interpreted locally or the ES6 compatibility table looks green enough for your purposes, consider using a Map:No type conversion is performed, for better and for worse:Try using an Object, not an Array:Use an object instead of an array.  Arrays in JavaScript are not associative arrays.  They are objects with magic associated with any properties whose names look like integers.  That magic is not what you want if you're not using them as a traditional array-like structure.Get the value for an associative array property when the property name is an integer:Starting with an Associative Array where the property names are integers:Push items to the array:Loop through array and do something with the property value.Console output should look like this:As you can see, you can get around the associative array limitation and have a property name be an integer.NOTE:  The associative array in my example is the json you would have if you serialized a Dictionary<string, string>[] object.Sometimes i use a prefixes for my keys. For example:Now you have no Problem accessing them. Use an object - with an integer as the key - rather than an array.

MAC addresses in JavaScript

Adhip Gupta

[MAC addresses in JavaScript](https://stackoverflow.com/questions/3385/mac-addresses-in-javascript)

I know that we can get the MAC address of a user via IE (ActiveX objects).Is there a way to obtain a user's MAC address using JavaScript?

2008-08-06 13:43:44Z

I know that we can get the MAC address of a user via IE (ActiveX objects).Is there a way to obtain a user's MAC address using JavaScript?I concur with all the previous answers that it would be a privacy/security vulnerability if you would be able to do this directly from Javascript. There are two things I can think of:The quick and simple answer is No.Javascript is quite a high level language and does not have access to this sort of information.No you cannot get the MAC address in JavaScript, mainly because the MAC address uniquely identifies the running computer so it would be a security vulnerability.Now if all you need is a unique identifier, I suggest you create one yourself using some cryptographic algorithm and store it in a cookie.If you really need to know the MAC address of the computer AND you are developing for internal applications, then I suggest you use an external component to do that: ActiveX for IE, XPCOM for Firefox (installed as an extension).Nope. The reason ActiveX can do it is because ActiveX is a little application that runs on the client's machine.I would imagine access to such information via JavaScript would be a security vulnerability.If this is for an intranet application and all of the clients use DHCP, you can query the DHCP server for the MAC address for a given IP address.i was looking for the same problem and stumbled upon the following code.How to get Client MAC address(Web):To get the client MAC address only way we can rely on JavaScript and Active X control of Microsoft.It is only work in IE if Active X enable for IE. As the ActiveXObject is not available with the Firefox, its not working with the firefox and is working fine in IE.This script is for IE only:

Weird behavior with objects & console.log [duplicate]

dan-klasson

[Weird behavior with objects & console.log [duplicate]](https://stackoverflow.com/questions/23429203/weird-behavior-with-objects-console-log)

This code:Produces the following output in Chrome:Fiddle: http://jsfiddle.net/2kpnV/Why is that?

2014-05-02 13:21:02Z

This code:Produces the following output in Chrome:Fiddle: http://jsfiddle.net/2kpnV/Why is that?Examining objects via console.log happens in an asynchronous manner. The console receives a reference to the object synchronously, but does not display the properties of the object until it is expanded (in some cases, depending on the browser and whether you have dev tools open when the log happens). If the object has been modified before examining it in the console, the data shown will have the updated values.For example, Chrome will show a little i in a box which, when hovered, says:to let you know what you're looking at.One trick for logging in these cases is to log the individual values:Or JSON encode the object reference:Redefining console.log will solve the problem.

Is there a good way to attach JavaScript objects to HTML elements?

user47741

[Is there a good way to attach JavaScript objects to HTML elements?](https://stackoverflow.com/questions/1402693/is-there-a-good-way-to-attach-javascript-objects-to-html-elements)

I want to associate a JavaScript object with an HTML element. Is there a simple way to do this?I noticed HTML DOM defines a setAttribute method and it looks like this is defined for arbitrary attribute name. However this can only set string values. (You can of course use this to store keys into a dictionary.)Specifics (though I'm mostly interested in the general question):Specifically, I have HTML elements representing nodes in a tree and I'm trying to enable drag-and-drop, but the jQuery drop event will only give me the elements being dragged and dropped.The normal pattern for getting information to event handlers seems to be to create the HTML elements at the same time as you are creating JavaScript objects and then to define event handlers by closing over these JavaScript objects - however this doesn't work too well in this case (I could have a global object that gets populated when a drag begins... but this feels slightly nasty).

2009-09-09 23:35:43Z

I want to associate a JavaScript object with an HTML element. Is there a simple way to do this?I noticed HTML DOM defines a setAttribute method and it looks like this is defined for arbitrary attribute name. However this can only set string values. (You can of course use this to store keys into a dictionary.)Specifics (though I'm mostly interested in the general question):Specifically, I have HTML elements representing nodes in a tree and I'm trying to enable drag-and-drop, but the jQuery drop event will only give me the elements being dragged and dropped.The normal pattern for getting information to event handlers seems to be to create the HTML elements at the same time as you are creating JavaScript objects and then to define event handlers by closing over these JavaScript objects - however this doesn't work too well in this case (I could have a global object that gets populated when a drag begins... but this feels slightly nasty).Have you looked at the jQuery data() method?  You can assign complex objects to the element if you want or you can leverage that method to hold a reference to an object (or some other data) at the very least.JavaScript objects can have arbitrary properties assigned to them, there's nothing special you have to do to allow it. This includes DOM elements; although this behaviour is not part of the DOM standard, it has been the case going back to the very first versions of JavaScript and is totally reliable.

jQuery - prevent default, then continue default

StackOverflowNewbie

[jQuery - prevent default, then continue default](https://stackoverflow.com/questions/14375144/jquery-prevent-default-then-continue-default)

I have a form that, when submitted, I need to do some additional processing before it should submit the form. I can prevent default form submission behavior, then do my additional processing (it's basically calling Google Maps API and adding a few hidden fields to the form) -- and then I need the form to submit.Is there a way to "prevent default", then some point later "continue default?"

2013-01-17 08:47:02Z

I have a form that, when submitted, I need to do some additional processing before it should submit the form. I can prevent default form submission behavior, then do my additional processing (it's basically calling Google Maps API and adding a few hidden fields to the form) -- and then I need the form to submit.Is there a way to "prevent default", then some point later "continue default?"When you bind the .submit() event to the form, and you do the things you want to do before returning (true), these things happen prior to the actual submission.For example:Simple exampleAnother example on jquery.com: http://api.jquery.com/submit/#entry-examplesUse jQuery.one() It does what you want and you don't need to worry about multiple submit.i would just do..call  preventDefault at first and use submit() function later.. if u just need to submit the formUsing this way You will do a endless Loop on Your JS.

to do a better way you can use the followingI hope it helps!

Thanks!This is, IMHO, the most generic and robust solution (if your actions are user-triggered, eg 'user clicks on a button'):As an example, note this elegant solution to adding "Are you sure?" popup to any button just by decorating a button with an attribute.

We will conditionally continue default behavior if the user doesn't opt out.1.

Let's add to every button that we want an "are you sure" popup a warning text:2.

Attach handlers to ALL such buttons:That's it.Good Luck...You can use e.preventDefault() which will stop the current operation.than you can do$("#form").submit();In a pure Javascript way, you can submit the form after preventing default.This is because HTMLFormElement.submit() never calls the onSubmit(). So we're relying on that specification oddity to submit the form as if it doesn't have a custom onsubmit handler here.See this fiddle for a synchronous request. Waiting for an async request to finish up is just as easy:You can check out my fiddle for an example of an asynchronous request.And if you are down with promises: And here's that request."Validation injection without submit looping":I just want to check reCaptcha and some other stuff before HTML5 validation, so I did something like that (the validation function returns true or false):

Javascript/jQuery: Set Values (Selection) in a multiple Select

Zwen2012

[Javascript/jQuery: Set Values (Selection) in a multiple Select](https://stackoverflow.com/questions/16582901/javascript-jquery-set-values-selection-in-a-multiple-select)

I have a multiple select:I load data from my database. Then I have a string like this:How can I set this Values in the multiple select? Already tried change the string in an array and put it as value in the multiple, but doesnt work...!

Can someone help me with this? THANKS!!!

2013-05-16 08:48:40Z

I have a multiple select:I load data from my database. Then I have a string like this:How can I set this Values in the multiple select? Already tried change the string in an array and put it as value in the multiple, but doesnt work...!

Can someone help me with this? THANKS!!!Iterate through the loop using the value in a dynamic selector that utilizes the attribute selector.Working Example http://jsfiddle.net/McddQ/1/in jQuery:or in pure JavaScript:jQuery does significant abstraction here.Just provide the jQuery val function with an array of values:And to get the selected values in the same format:Note: Array#from transforms an array-like object into an array and then you are able to use Array.prototype functions on it, like find or map.Basically do a values.split(',') and then loop through the resulting array and set the Select. For some reason you don't use jQuery nor ES6? This might help you:this is error in some answers for replace |this correction is correct but the | In the end it should look like this \|

How do I fire an event when a iframe has finished loading in jQuery?

Alex Andronov

[How do I fire an event when a iframe has finished loading in jQuery?](https://stackoverflow.com/questions/30005/how-do-i-fire-an-event-when-a-iframe-has-finished-loading-in-jquery)

I have to load a PDF within a page.Ideally I would like to have a loading animated gif which is replaced once the PDF has loaded.

2008-08-27 12:52:29Z

I have to load a PDF within a page.Ideally I would like to have a loading animated gif which is replaced once the PDF has loaded.I'm pretty certain that it cannot be done.Pretty much anything else than PDF works, even Flash. (Tested on Safari, Firefox 3, IE 7)Too bad.Have you tried:This did it for me (not pdf, but another "onload resistant" content): Hope this helps.I am trying this and seems to be working for me:

http://jsfiddle.net/aamir/BXe8C/Bigger pdf file:

http://jsfiddle.net/aamir/BXe8C/1/have you tried .ready instead?I tried an out of the box approach to this, I havent tested this for PDF content but it did work for normal HTML based content, heres how:Step 1: Wrap your Iframe in a div wrapper    Step 2: Add a background image to your div wrapper:Step 3: in ur iframe tag add  ALLOWTRANSPARENCY="false" The idea is to show the loading animation in the wrapper div till the iframe loads after it has loaded the iframe would cover the loading animation. Give it a try.Using both jquery Load and Ready neither seemed to really match when the iframe was TRULY ready.I ended up doing something like thisWhere #loader is an absolutely positioned div over top the iframe with a spinner gif.@Alex aw that's a bummer. What if in your iframe you had an html document that looked like:Definitely a hack, but it might work for Firefox. Although I wonder if the load event would fire too soon in that case.Here is what I do for any action and it works in Firefox, IE, Opera, and Safari.I had to show a loader while pdf in iFrame is loading so what i come up with:I'm showing a loader. Once I'm sure that customer can see my loader, i'm calling onCompllet loaders method that loads an iframe. Iframe has an "onLoad" event. Once PDF is loaded it triggers onloat event where i'm hiding the loader :)The important part:iFrame has "onLoad" event where you can do what you need (hide loaders etc.)If you can expect the browser's open/save interface to pop up for the user once the download is complete, then you can run this when you start the download:When the dialogue pops up on top of the page, the blur event will trigger.Since after the pdf file is loaded, the iframe document will have a new DOM element <embed/>, so we can do the check like this:The solution I have applied to this situation is to simply place an absolute loading image in the DOM, which will be covered by the iframe layer after the iframe is loaded.The z-index of the iframe should be (loading's z-index + 1), or just higher.For example:Hope this helps if no javaScript solution did. I do think that CSS is best practice for these situations.Best regards.

adding and removing classes in angularJs using ng-click

NewKidOnTheBlock

[adding and removing classes in angularJs using ng-click](https://stackoverflow.com/questions/20460369/adding-and-removing-classes-in-angularjs-using-ng-click)

I am trying to work how to add a class with ngClick. I have uploaded up my code onto plunker Click here. Looking at the angular documentation i can't figure out the exact way it should be done. Below is a snippet of my code. Can someone guide me in the right directionController

2013-12-08 23:03:16Z

I am trying to work how to add a class with ngClick. I have uploaded up my code onto plunker Click here. Looking at the angular documentation i can't figure out the exact way it should be done. Below is a snippet of my code. Can someone guide me in the right directionControllerYou just need to bind a variable into the directive "ng-class" and change it from the controller. Here is an example of how to do this:Here is the example working on jsFiddleI want to add or remove "active" class in my code dynamically on ng-click, here what I have done.There is a simple and clean way of doing this with only directives.you can also do that in a directive, if you want to remove the previous class and add a new classand in your template:You have it exactly right, all you have to do is set selectedIndex in your ng-click.Here is how I implemented a set of buttons that change the ng-view, and highlights the button of the currently selected view.and this in my controller.I used Zack Argyle's suggestion above to get this, which I find very elegant:CSS:HTML:If you prefer separation of concerns such that logic for adding and removing classes happens on the controller, you can do thiscontrollerHTMLCSS I can't believe how complex everyone is making this. This is actually very simple. Just paste this into your html (no directive./controller changes required - "bg-info" is a bootstrap class):for Reactive forms -HTML fileTS file 

Node.js project naming conventions for files & folders

Rudiger

[Node.js project naming conventions for files & folders](https://stackoverflow.com/questions/18927298/node-js-project-naming-conventions-for-files-folders)

What are the naming conventions for files and folders in a large Node.js project?Should I capitalize, camelCase, or under-score?Ie. is this considered valid?

2013-09-20 23:30:08Z

What are the naming conventions for files and folders in a large Node.js project?Should I capitalize, camelCase, or under-score?Ie. is this considered valid?After some years with node, I can say that there are no conventions for the directory/file structure. However most (professional) express applications use a setup like:An example which uses this setup is nodejs-starter.I personally changed this setup to:In my opinion, the latter matches better with the Unix-style directory structure (whereas the former mixes this up a bit).I also like this pattern to separate files:lib/index.jslib/static/index.jsThis allows decoupling neatly all source code without having to bother dependencies. A really good solution for fighting nasty Javascript. A real-world example is nearby which uses this setup.Update (filenames):Regarding filenames most common are short, lowercase filenames. If your file can only be described with two words most JavaScript projects use an underscore as the delimiter.Update (variables):Regarding variables, the same "rules" apply as for filenames. Prototypes or classes, however, should use camelCase.Update (styleguides):Use kebab-case for all package, folder and file names.You should imagine that any folder or file might be extracted to its own package some day. Packages cannot contain uppercase letters.Therefore, camelCase should never be used. This leaves snake_case and kebab-case.kebab-case is by far the most common convention today. The only use of underscores is for internal node packages, and this is simply a convention from the early days.There are no conventions. There are some logical structure.The only one thing that I can say:

Never use camelCase file and directory names. Why? It works but on Mac and Windows there are no different between someAction and some action. I met this problem, and not once. I require'd a file like this:But sadly I created a file with full of lowercase: lib/ishidden.js. It worked for me on mac. It worked fine on mac of my co-worker. Tests run without errors. After deploy we got a huge error:Oh yeah. It's a linux box. So camelCase directory structure could be dangerous. It's enough for a colleague who is developing on Windows or Mac.So use underscore (_) or dash (-) separator if you need.Based on 'Google JavaScript Style Guide'Most people use camelCase in JS. If you want to open-source anything, I suggest you to use this one :-)Node.js doesn't enforce any file naming conventions (except index.js). And the Javascript language in general doesn't either. You can find dozens of threads here which suggest camelCase, hyphens and underscores, any of which work perfectly well. So its up to you. Choose one and stick with it.According to me: For files, use lower camel case if module.exports is an object, I mean a singleton module. This is also applicable to JSON files as they are also in a way single ton. Use upper camel case if module.exports returns a constructor function where it acts like a class. For folders use short names. If there is need to have multiple words, let it be completely lower case separated by "-" so that it works across all platforms consistently.

JavaScript moving element in the DOM

core

[JavaScript moving element in the DOM](https://stackoverflow.com/questions/1363650/javascript-moving-element-in-the-dom)

Let's say I have three <div> elements on a page. How can I swap positions of the first and third <div>? jQuery is fine.

2009-09-01 17:23:41Z

Let's say I have three <div> elements on a page. How can I swap positions of the first and third <div>? jQuery is fine.Trivial with jQueryIf you want to do it repeatedly, you'll need to use different selectors since the divs will retain their ids as they are moved around.There's no need to use a library for such a trivial task:This takes account of the fact that getElementsByTagName returns a live NodeList that is automatically updated to reflect the order of the elements in the DOM as they are manipulated.You could also use:and there are various other possible permutations, if you feel like experimenting:for example :-)Use modern vanilla JS! Way better/cleaner than previously. No need to reference a parent.Browser Support - 92% Global as of Sept '19and use it like this:if you don't want to use jQuery you could easily adapt the function.This function may seem strange, but it heavily relies on standards in order to function properly. In fact, it may seem to function better than the jQuery version that tvanfosson posted which seems to do the swap only twice.What standards peculiarities does it rely on?Jquery approach mentioned on the top will work.

You can also use JQuery and CSS .Say for e.g on Div one you have applied class1 and div2 you have applied class class2 (say for e.g each class of css provides specific position on the browser), now you can interchange the classes use jquery or javascript (that will change the position)Sorry for bumping this thread

I stumbled over the "swap DOM-elements" problem and played around a bitThe result is a jQuery-native "solution" which seems to be really pretty (unfortunately i don't know whats happening at the jQuery internals when doing this)The Code:The jQuery documentation says that insertAfter() moves the element and doesn't clone it

What type is the 'return' keyword?

Arnab Das

[What type is the 'return' keyword?](https://stackoverflow.com/questions/36690704/what-type-is-the-return-keyword)

We use return statements optionally in JavaScript functions. It's a keyword. But what is the actual type of return itself. Actually I got confused, seeing the example:Output:So, we can pass comma separated expressions into the return statement. Is this a function?And starting with this, can we take a wild guess that every keyword in JavaScript are ultimately a function?I've written a small blog as a gist of this discussion. You may want to check it here.

2016-04-18 09:55:31Z

We use return statements optionally in JavaScript functions. It's a keyword. But what is the actual type of return itself. Actually I got confused, seeing the example:Output:So, we can pass comma separated expressions into the return statement. Is this a function?And starting with this, can we take a wild guess that every keyword in JavaScript are ultimately a function?I've written a small blog as a gist of this discussion. You may want to check it here.It doesn't have a type, it isn't a value.Attempting typeof return; will give you Unexpected token return.No, while parenthesis can be used to call a function, here they are a grouping operator containing a couple of expressions seperated by a comma operator.A more useful demonstration would be:Which outputs 0 because the result of a + b is ignored (it is on the LHS of the comma operator) and a - b is returned.I'm kinda shocked that no one here has directly referenced the spec:So, because of the spec, your example reads:return ( GetValue(exprRef) )where

exprRef = console.log(a + b), console.log(arguments)Which according to the spec on the comma operator......means that every expression will get evaluated until the last item in the comma list, which becomes the assignment expression.  So your code return (console.log(a + b) , console.log(arguments)) is going to1.)  print the result of a + b2.)  Nothing is left to execute, so execute the next expression which3.)  prints the arguments, and because console.log() doesn't specify a 

return statement 4.)  Evaluates to undefined5.)  Which is then returned to the caller.  So the correct answer is, return doesn't have a type, it only returns the result of some expression.  For the next question:  No.  The comma in JavaScript is an operator, defined to allow you to combine multiple expressions into a single line, and is defined by the spec to return the evaluated expression of whatever is last in your list.  You still don't believe me?  Play with that code here and mess with the last value in the list.  It will always return the last value in the list, in your case it just happens to be undefined.For your final question, Again, no.  Functions have a very specific definition in the language.  I won't reprint it here because this answer is already getting extremely long.Testing what happens when you return parenthesiesed values:Gives the answer 2, so it appears that a comma separated list of values evaluates to the last element in the list.Really, the parenthesis are irrelevant here, they're grouping operations instead of signifying a function call. What's possibly surprising, though, is that the comma is legal here. I found an interesting blog post on how the comma is deal with here:https://javascriptweblog.wordpress.com/2011/04/04/the-javascript-comma-operator/return is not a function. It's the continuation of the function in which it occurs. Think about the statement alert (2 * foo(bar)); where foo is the name of a function. When you're evaluating it, you see that you have to set aside the rest of the statement for a moment to concentrate on evaluating foo(bar). You could visualize the part you set aside as something like alert (2 * _), with a blank to fill in. When you know what the value of foo(bar) is, you pick it up again. The thing you set aside was the continuation of the call foo(bar). Calling return feeds a value to that continuation. When you evaluate a function inside foo, the rest of foo waits for that function to reduce to a value, and then foo picks up again. You still have a goal to evaluate foo(bar), it's just paused. When you evaluate return inside foo, no part of foo waits around for a value. return doesn't reduce to a value at the place inside foo where you used it. Instead, it causes the entire call foo(bar) to reduce to a value, and the goal "evaluate foo(bar)" is deemed complete and blown away.People don't usually tell you about continuations when you're new to programming. They think of it as an advanced topic, just because there are some very advanced things that people eventually do with continuations. But the truth is, you're using them all along, every time you call a function. the return here is a red herring. Perhaps interesting ist the following variation:which outputs as the last lineas the function does not actually return anything. (It would return the return value of the second console.log, if it had one).As it is, the code is exactly identical toAn interesting way to understand the return statement is through the void operator

Take a look at this codeSince the return statement takes one argument that is [[expression]] and return this to the caller on the stack i.e. arguments.callee.caller it will then execute void(expression) and then return undefined that is the evaluation of the void operator.

setState vs replaceState in React.js

myusuf

[setState vs replaceState in React.js](https://stackoverflow.com/questions/23293626/setstate-vs-replacestate-in-react-js)

I am new to React.js Library and I was going over some of the tutorials and I came across:The Description given is not very clear (IMO).Similarly,I tried this.setState({data: someArray}); followed by this.replaceState({test: someArray}); and then console.logged them and I found that state now had both data and test.Then, I tried this.setState({data: someArray}); followed by this.setState({test: someArray}); and then console.logged them and I found that state again had both data and test.So, what exactly is the difference between the two ?

2014-04-25 12:48:07Z

I am new to React.js Library and I was going over some of the tutorials and I came across:The Description given is not very clear (IMO).Similarly,I tried this.setState({data: someArray}); followed by this.replaceState({test: someArray}); and then console.logged them and I found that state now had both data and test.Then, I tried this.setState({data: someArray}); followed by this.setState({test: someArray}); and then console.logged them and I found that state again had both data and test.So, what exactly is the difference between the two ?With setState the current and previous states are merged.  With replaceState, it throws out the current state, and replaces it with only what you provide.  Usually setState is used unless you really need to remove keys for some reason; but setting them to false/null is usually a more explicit tactic.While it's possible it could change; replaceState currently uses the object passed as the state, i.e. replaceState(x), and once it's set this.state === x.  This is a little lighter than setState, so it could be used as an optimization if thousands of components are setting their states frequently.

 I asserted this with this test case.If your current state is {a: 1}, and you call this.setState({b: 2}); when the state is applied, it will be {a: 1, b: 2}.  If you called this.replaceState({b: 2}) your state would be {b: 2}.Side note: State isn't set instantly, so don't do this.setState({b: 1}); console.log(this.state) when testing.Definition by example:Take note of this from the docs, though: Same goes for replaceState() According to the docs, replaceState might get deprecated:Since replaceState is now deprecated, here is a very simple workaround. Though it is probably quite seldom that you would / should resort to needing this.To remove the state:Or, alternatively, if you don't want to have multiple calls to setStateEssentially, all previous keys in the state now return undefined, which can very easily be filtered with an if statement:  In JSX:Finally, to "replace" the state, simply combine the new state object with a copy of the old state that has been undefined, and set it as state:  

Webpack loaders vs plugins; what's the difference?

Tim Perkins

[Webpack loaders vs plugins; what's the difference?](https://stackoverflow.com/questions/37452402/webpack-loaders-vs-plugins-whats-the-difference)

What is the difference between loaders and plugins in webpack? The documentation for plugins just says:I know that babel uses a loader for jsx/es2015 transforms, but it looks like other common tasks (copy-webpack-plugin, for example) use plugins instead.

2016-05-26 05:37:01Z

What is the difference between loaders and plugins in webpack? The documentation for plugins just says:I know that babel uses a loader for jsx/es2015 transforms, but it looks like other common tasks (copy-webpack-plugin, for example) use plugins instead.Loaders do the pre-processing transformation of virtually any file format when you use sth like require("my-loader!./my-awesome-module") in your code. Compared to plugins, they are quite simple as they (a) expose only one single function to webpack and (b) are not able to influence the actual build process.Plugins on the other hand can deeply integrate into webpack because they can register hooks within webpacks build system and access (and modify) the compiler, and how it works, as well as the compilation. Therefore, they are more powerful, but also harder to maintain.Adding complementary and simpler answer.Loaders:Loaders work at the individual file level during or before the bundle is generated.Plugins:Plugins work at bundle or chunk level and usually work at the end of the bundle generation process.  Plugins can also modify how the bundles themselves are created. Plugins have more powerful control than loaders.Just for an example you can clearly see in below image where loaders are working and where plugins are working -

References: 

Article and 

ImageAt its core, webpack is just a file bundler. Considering a very simple scenario (no code splitting), this could mean just the following actions(on a high level):When you examine the above steps closely, this resonates with what a Java compiler(or any compiler) does. There are differences of course but those don't matter to understand loaders and plugins.Loaders: are here because webpack promises to bundle together any file type. Since webpack at its core is only capable enough to bundle js files, this promise meant that the webpack core team had to incorporate build flows which allowed external code to transform a particular file type in a way that webpack could consume.  These external code are called loaders and they typically run during step 1 and 3 above. Thus, since the stage at which these loaders need to run is obvious, they don't require hooks and neither do they influence the build process(since the build or bundle only happens at step 4).So Loaders prepare the stage for compilation and they sort of extend the flexibility of the webpack compiler.Plugins:are here because even though webpack doesn't directly promise variable output, the world wants it and webpack does allow it.Since webpack at its core is just a bundler and yet goes through several steps and sub-steps in doing so, these steps can be utilised to build in additional functionality.The production build process(minifying and writing to file system), which is a native capability of webpack compiler, for e.g., can be treated as an extension of its core capability(which is just bundling) and can be treated like a native plugin. Had they not provided it, someone else would have done it.Looking at the native plugin above, it appears as if the webpack bundling or compilation can be broken down into core bundling process, plus a lot of native plugin processes which we can turn off or customise or extend. This meant allowing external code to join in the bundling process at specific points that they can choose from (called hooks).Plugins therefore influence the output and sort of extend the capability of webpack compiler.Loaders work at a file level. They can write template, process some code to transpile it depending on your convenience, etc.Plugins work at a system level. They can work on pattern, file system handling (name, path), etc.

How to set a Javascript object values dynamically?

Umut KIRGÖZ

[How to set a Javascript object values dynamically?](https://stackoverflow.com/questions/6439915/how-to-set-a-javascript-object-values-dynamically)

It's difficult to explain the case by words, let me give an example:How can I set a variable property with variable value in a JavaScript object?

2011-06-22 12:35:02Z

It's difficult to explain the case by words, let me give an example:How can I set a variable property with variable value in a JavaScript object?That should work. You mixed up the name of the variable and its value. But indexing an object with strings to get at its properties works fine in JavaScript.orBoth of these are interchangeable.Edit: I'm guessing you meant myObj[prop] = value, instead of myObj[name] = value. Second syntax works fine: http://jsfiddle.net/waitinforatrain/dNjvb/1/You can get the property the same way as you set it.You set the value

foo["bar"] = "baz";To get the value

foo["bar"]will return "baz".You could also create something that would be similar to a value object (vo);SomeModelClassNameVO.js;Than you can just do;When you create an object myObj as you have, think of it more like a dictionary. In this case, it has two keys, name, and age.You can access these dictionaries in two ways:You should be able to access it as a property without any problems. However, to access it as an array, you'll need to treat the key like a string.Otherwise, javascript will assume that name is a variable, and since you haven't created  a variable called name, it won't be able to access the key you're expecting.simple as this

myObj.name = value;

How to go to a specific file in Chrome Developer Tools?

Alpha

[How to go to a specific file in Chrome Developer Tools?](https://stackoverflow.com/questions/14608075/how-to-go-to-a-specific-file-in-chrome-developer-tools)

I am developing a web application with a heavy front-end approach. By using Dojo and the AMD-way, I currently have testing screens which may easily load over a hundred different javascript files.When I want to debug for any specific problem, or verify if I am seeing an old version of a specific file, I find it really hard to find my files in the Sources tab in the Chrome Developer Tools.Is there any shortcut or action I can make that will let me type the name of a file and will take me to the source of that file?

2013-01-30 15:50:08Z

I am developing a web application with a heavy front-end approach. By using Dojo and the AMD-way, I currently have testing screens which may easily load over a hundred different javascript files.When I want to debug for any specific problem, or verify if I am seeing an old version of a specific file, I find it really hard to find my files in the Sources tab in the Chrome Developer Tools.Is there any shortcut or action I can make that will let me type the name of a file and will take me to the source of that file?While in the sources tab use CTRL+O (⌘+O for Mac) to search scripts, stylesheets and snippets by filename.(use CTRL+SHIFT+O to filter/navigate to a JavaScript function/CSS rule when viewing a file)[Chrome Devtools Cheatsheet]CTRL + P brings up the search input in Windows.⌘ + P — in Mac.In Windows: Use CTRL+SHIFT+F  to search for content in files.Use CTRL+SHIFT+O  to search for file names.Mac: Command + O

Windows: Ctrl + O

Are HTML comments inside script tags a best practice? [closed]

AndreiM

[Are HTML comments inside script tags a best practice? [closed]](https://stackoverflow.com/questions/808816/are-html-comments-inside-script-tags-a-best-practice)

The following practice is fairly commonplace in the inline JavaScript I have to work with:I know that the point is to prevent browsers that are incompatible with JavaScript from rendering the source, but is this still a best practice today? The vast majority of browsers used today can interpret JavaScript; even modern mobile devices usually don't have trouble.As for the 'why not?' question: I recently had to spend several hours debugging an issue where someone had left off the '//' in front of a '-->' at the end of a script tag buried deep in some pages, and this was causing mysterious JavaScript errors.What do you do? Is this still considered a 'best practice?'

2009-04-30 20:16:17Z

The following practice is fairly commonplace in the inline JavaScript I have to work with:I know that the point is to prevent browsers that are incompatible with JavaScript from rendering the source, but is this still a best practice today? The vast majority of browsers used today can interpret JavaScript; even modern mobile devices usually don't have trouble.As for the 'why not?' question: I recently had to spend several hours debugging an issue where someone had left off the '//' in front of a '-->' at the end of a script tag buried deep in some pages, and this was causing mysterious JavaScript errors.What do you do? Is this still considered a 'best practice?'The important thing is that nowadays, whether a particular browser supports JavaScript or not is irrelevant (clearly the great majority do) - it is irrelevant because almost all understand script blocks, which means that they know to ignore the JavaScript even if they can't interpret it.Matt Kruse gives a slightly more detailed explanation on his JavaScript Toolbox site for why specifically not to use HTML comments within script blocks.Quoted from that page:

In the ancient days of javascript (1995), some browsers like Netscape 1.0 didn't have any support or knowledge of the script tag. So when javascript was first released, a technique was needed to hide the code from older browsers so they wouldn't show it as text in the page. The 'hack' was to use HTML comments within the script block to hide the code.

Using HTML Comments In Script Is Bad

No browsers in common use today are ignorant of the <script> tag, so hiding of javascript source is no longer necessary. In fact, it can be considered harmful for the following reasons:

I've stopped doing it.  At some point you just have to let go of your NCSA Mosaic.As per W3C Recommendation it was mainly useful to hide the script data from USER AGENTS.Quoted from the W3c page :Commenting scripts in JavaScript The JavaScript engine allows the string "<!--" to occur at the start of a SCRIPT element, and ignores further characters until the end of the line. JavaScript interprets "//" as starting a comment extending to the end of the current line. This is needed to hide the string "-->" from the JavaScript parser.No, it is a hangover from a workaround used when the script element was first introduced. No browser fails to understand the script element today (even if it understands it as "Script that should be ignored because scripting is turned off or unsupported").In XHTML, they are actively harmful.I wrote something about the history of it a while back.Stopped using this a while back. Also, according to Douglas Crockford, you can drop the type attribute from your script tags since the only scripting language available in most browsers is JavaScript.If you are typing manually, I suggest you always use external js files, that would help so much.Regarding your concern: most browsers are JavaScript safe today. However sometimes people may write simple parsers to fetch a HTML directly - and I must say, the safe quote is really helpful for those clients. Also some non-JS clients like old Lynx would get benefits from this.If you do not include literal text between script tags- that is, if you load scripts from src files, you can forget about the comments.I would recommend using a CDATA section, as described in this question.I stopped doing that ages ago. You really don't need it in this day and age.I don't do it but the other day I went to validate my password protected site at w3c. So I had to use their direct input method. It complained about my javascript, so I put the comments back in everything was fine.

Detect when an image fails to load in Javascript

sazr

[Detect when an image fails to load in Javascript](https://stackoverflow.com/questions/9815762/detect-when-an-image-fails-to-load-in-javascript)

Is there a way to determine if a image path leads to an actual image, Ie, detect when an image fails to load in Javascript.For a web app, I am parsing a xml file and dynamically creating HTML images from a list of image paths. Some image paths may no longer exist on the server so I want to fail gracefully by detecting which images fail to load and deleting that HTML img element.Note JQuery solutions wont be able to be used(the boss doesn't want to use JQuery, yes I know dont get me started). I know of a way in JQuery to detect when an image is loaded, but not whether it failed.My code to create img elements but how can I detect if the img path leads to a failed to load image?

2012-03-22 02:50:43Z

Is there a way to determine if a image path leads to an actual image, Ie, detect when an image fails to load in Javascript.For a web app, I am parsing a xml file and dynamically creating HTML images from a list of image paths. Some image paths may no longer exist on the server so I want to fail gracefully by detecting which images fail to load and deleting that HTML img element.Note JQuery solutions wont be able to be used(the boss doesn't want to use JQuery, yes I know dont get me started). I know of a way in JQuery to detect when an image is loaded, but not whether it failed.My code to create img elements but how can I detect if the img path leads to a failed to load image?You could try the following code. I can't vouch for browser compatibility though, so you'll have to test that.And my sympathies for the jQuery-resistant boss!The answer is nice, but it introduces one problem. Whenever you assign onload or onerror directly, it may replace the callback that was assigned earlier. That is why there's a nice method that "registers the specified listener on the EventTarget it's called on" as they say on MDN. You can register as many listeners as you want on the same event.Let me rewrite the answer a little bit.Because the external resource loading process is asynchronous, it would be even nicer to use modern JavaScript with promises, such as the following.This:With jQuery this is working for me :And I can use this picture everywhere on my website regardless of the size of it with the following CSS3 property :For missing background images, I also added the following on each background-image declaration :Another solution is to detect missing image with Apache before to send to browser and remplace it by the default no-img.png content.Here's a function I wrote for another answer: Javascript Image Url Verify.  I don't know if it's exactly what you need, but it uses the various techniques that you would use which include handlers for onload, onerror, onabort and a general timeout.Because image loading is asynchronous, you call this function with your image and then it calls your callback sometime later with the result.just like below:

JSLint: was used before it was defined

Chun ping Wang

[JSLint: was used before it was defined](https://stackoverflow.com/questions/9621162/jslint-was-used-before-it-was-defined)

Hi I have the 3 javascript files.In file1.js I have I get an error 'jQuery' was used before it was defined. 

and 'document' was used before it was defined. How do I safely get rid of this warning.  If I do then in my utility.js if it is used, it would be null in IE and ok in firefox. What is the best solution to this?

2012-03-08 16:29:17Z

Hi I have the 3 javascript files.In file1.js I have I get an error 'jQuery' was used before it was defined. 

and 'document' was used before it was defined. How do I safely get rid of this warning.  If I do then in my utility.js if it is used, it would be null in IE and ok in firefox. What is the best solution to this?From the documentationExample:As Quentin says, there's a /*global*/ directive.Here is an example (put this at the top of the file):Make sure the initial global statement is on the same line as /*, or else it breaks. 

comparing ECMA6 sets for equality

williamcodes

[comparing ECMA6 sets for equality](https://stackoverflow.com/questions/31128855/comparing-ecma6-sets-for-equality)

How do you compare two javascript sets? I tried using == and === but both return false.These two sets are equivalent, because by definition, sets do not have order (at least not usually). I've looked at the documentation for Set on MDN and found nothing useful. Anyone know how to do this?

2015-06-30 03:04:31Z

How do you compare two javascript sets? I tried using == and === but both return false.These two sets are equivalent, because by definition, sets do not have order (at least not usually). I've looked at the documentation for Set on MDN and found nothing useful. Anyone know how to do this?Try this:A more functional approach would be:The all function works for all iterable objects (e.g. Set and Map).If Array.from was more widely supported then we could have implemented the all function as:Hope that helps.You can also try:lodash provides _.isEqual(), which does deep comparisons.  This is very handy if you don't want to write your own.  As of lodash 4, _.isEqual() properly compares Sets.The other answer will work fine; here is another alternative.However, be aware that this does not do deep equality comparison. Sowill return false. If the above two sets are to be considered equal, we need to iterate through both sets doing deep quality comparisons on each element. We stipulate the existence of a deepEqual routine. Then the logic would beWhat this does: for each member of s1, look for a deeply equal member of s2. If found, delete it so it can't be used again. The two sets are deeply equal if all the elements in s1 are found in s2, and s2 is exhausted. Untested.You may find this useful: http://www.2ality.com/2015/01/es6-set-operations.html.None of these solutions bring「back」the expected functionality to a data structure such as set of sets. In its current state, the Javascript Set is useless for this purpose because the superset will contain duplicate subsets, which Javascript wrongly sees as distinct. The only solution I can think of is converting each subset to Array, sorting it and then encoding as String (for example JSON).Comparing two objects with ==, ===When using == or === operator to compare two objects, you will always get false unless those object reference the same object. For example:Otherwise, == equates to false even though the object contains the same values:You may need to consider manual comparisonIn ECMAScript 6, you may convert sets to arrays beforehand so you can spot the difference between them:NOTE: Array.from is one of the standard ECMAScript 6 features but it is not widely supported in modern browsers. Check the compatibility table here : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/from#Browser_compatibilityI created a quick polyfill for Set.prototype.isEqual()Github Gist - Set.prototype.isEqualBased on the accepted answer, assuming support of Array.from, here is a one-liner:The reason why your approach returns false is because you are comparing two different objects (even if they got the same content), thus comparing two different objects (not references, but objects) always returns you falsy.The following approach merges two sets into one and just stupidly compares the size. If it's the same, it's the same: Upside: It's very simple and short. No external library only vanilla JSDownside: It's probably going to be a slower than just iterating over the values and you need more space.I follow this approach in tests :If sets contains only primitive data types or object inside sets have reference equality, then there is simpler wayconst isEqualSets = (set1, set2) => (set1.size === set2.size) && (set1.size === new Set([...set1, ...set2]).size);Very slight modification based on @Aadit M Shah's answer: If anyone else is having an issue as I did due to some quirk of the latest babel, had to add an explicit conditional here.(Also for plural I think are is just a bit more intuitive to read aloud 🙃)1) Check if sizes are equal . If not, then they are not equal.2) iterate over each elem of A and check in that exists in B. If one fails return unequal3) If the above 2 conditions fails that means they are equal.2) Method 2

How to 'minify' Javascript code

KalEl

[How to 'minify' Javascript code](https://stackoverflow.com/questions/1737388/how-to-minify-javascript-code)

JQuery has two versions for download, one is Production (19KB, Minified and Gzipped), and the other is Development (120KB, Uncompressed Code).Now the compact 19kb version, if you download it, you will see is still a javascript executable code. How did they compactify it? And how can I 'minify' my code like that too?

2009-11-15 12:11:23Z

JQuery has two versions for download, one is Production (19KB, Minified and Gzipped), and the other is Development (120KB, Uncompressed Code).Now the compact 19kb version, if you download it, you will see is still a javascript executable code. How did they compactify it? And how can I 'minify' my code like that too?DIY MinificationNo minifier can compress properly a bad code. In this example i just wanna show how much a minifier does.What you should do before you minifyAnd regarding jQuery... i don't use jQuery.jQuery is for old browsers,it was made for compatibility reasons .. check caniuse.com, almost everything works on every browser (also ie10 is standardized now) , i think now it's just here to slow down your web application...if you like the $() you should create your own simple function.And why bother to compress your code if your clients need to download the 100kb jquery script everythime?how big is your uncompressed code? 5-6kb..? Not to talk about the tons of plugins you add to to make it easier.  Original CodeWhen you write a function you have an idea, start to write stuff and sometimes you end up with something like the following code.The code works.Now most people stop thinking and add this to a minifier and publish it.Here iss the minified code (i added the new lines)Minified using (http://javascript-minifier.com/)But are all those vars , ifs, loops & definitions necessary?Most of the time NO !OPTIONAL (increases the performance & shorter code)Now if a minifier can compress the code your doing it wrong.No minifier can compress properly a bad code. DIYIt does exactly the same thing as the codes above.Performancehttp://jsperf.com/diyminifyYou always need to think what you need:Before you say "Noone would write code like the one below" go and check the first 10 questions in here ... Here are some common examples i see every ten minutes.Want a reusable conditionAlert yes only if it existsAlert yes or noConvert a number to a string or viceversaRound a numberFloor a numberswitch casetry catchmore ifbut indexOf is slow read this https://stackoverflow.com/a/30335438/2450730numbers Some nice articles/sites i found about bitwise/shorthand:http://mudcu.be/journal/2011/11/bitwise-gems-and-other-optimizations/http://www.140byt.es/http://www.jquery4u.com/javascript/shorthand-javascript-techniques/There are also many jsperf sites showing the performance of shorthand & bitwsie if you search with your favorite searchengine.I could go one for hours.. but i think it's enough for now. if you have some questions just ask.And rememberNo minifier can compress properly a bad code. You could use one of the many available javascript minifiers.Google just made available a javascript compiler that can minify your code, elimiated dead code branches and more optimizations.google javascript compilerRegards

KAlong with minifying you can base64 encode it too. It makes your file much more compressed. I'm sure you have seen js files that are wrapped inside an eval() function with parameters (p,a,c,k,e,r) passed. I read it in this article  How to Minify a Javascript File?I have written a tiny script which calls a API to get your script minified, check it out:Usage:I recently needed to perform the same task.  While the compressors listed at The JavaScript CompressorRater do a great job and the tool is very useful, the compressors were not playing nice with some jQuery code I am using ($.getScript and jQuery.fn checks).  Even the Google Closure Compressor choked on the same lines.  While I could have eventually ironed out the kinks it was far to much squinting to do constantly.The one that finally worked without issue was UglifyJS (thanks @Aries51), and the compression was only slightly less than all the others.  And similar to Google it has a HTTP API.  Packer is also nice and has language implementation in Perl, PHP, and .NET.There are currently 2 ways of minifying your code:http://yui.github.io/yuicompressor/Many such tools are available for Node and npm as well - it's good practice to automate the mnification of Javascript with Grunt.http://www.modify-anything.com/

get keys of json-object in JavaScript [duplicate]

user1027167

[get keys of json-object in JavaScript [duplicate]](https://stackoverflow.com/questions/8430336/get-keys-of-json-object-in-javascript)

I have a json-object in JavaScript and I want to get the used keys in it. My JavaScript-Code looks like this:And I want a loop that alerts me 'person' and 'age', which are the keys of the first object in the json-Array.

2011-12-08 11:31:16Z

I have a json-object in JavaScript and I want to get the used keys in it. My JavaScript-Code looks like this:And I want a loop that alerts me 'person' and 'age', which are the keys of the first object in the json-Array.[What you have is just an object, not a "json-object". JSON is a textual notation. What you've quoted is JavaScript code using an array initializer and an object initializer (aka, "object literal syntax").]If you can rely on having ECMAScript5 features available, you can use the Object.keys function to get an array of the keys (property names) in an object. All modern browsers have Object.keys (including IE9+).The rest of this answer was written in 2011. In today's world, A) You don't need to polyfill this unless you need to support IE8 or earlier (!), and B) If you did, you wouldn't do it with a one-off you wrote yourself or grabbed from an SO answer (and probably shouldn't have in 2011, either). You'd use a curated polyfill, possibly from es5-shim or via a transpiler like Babel that can be configured to include polyfills (which may come from es5-shim).Here's the rest of the answer from 2011:Note that older browsers won't have it. If not, this is one of the ones you can supply yourself:That uses a for..in loop (more info here) to loop through all of the property names the object has, and uses Object.prototype.hasOwnProperty to check that the property is owned directly by the object rather than being inherited.(I could have done it without the self-executing function, but I prefer my functions to have names, and to be compatible with IE you can't use named function expressions [well, not without great care]. So the self-executing function is there to avoid having the function declaration create a global symbol.)EDITObject has a property keys, returns an Array of keys from that ObjectChrome, FF & Safari supports Object.keysThe working code 

How to get all selected values from <select multiple=multiple>?

Kyle

[How to get all selected values from <select multiple=multiple>?](https://stackoverflow.com/questions/11821261/how-to-get-all-selected-values-from-select-multiple-multiple)

Seemed odd I couldn't find this one already asked, but here it goes!I have an html  as follows:How do I get all the values(an array?) that the user has selected in javascript?For example, if the user has selected Lunch and Snacks, I want an array of { 2, 4 }.This seems like it should be a very simple task but I can't seem to do it. Thanks.

2012-08-06 00:17:12Z

Seemed odd I couldn't find this one already asked, but here it goes!I have an html  as follows:How do I get all the values(an array?) that the user has selected in javascript?For example, if the user has selected Lunch and Snacks, I want an array of { 2, 4 }.This seems like it should be a very simple task but I can't seem to do it. Thanks.The usual way:From the docs:Unless a question asks for JQuery the question should be first answered in standard javascript as many people do not use JQuery in their sites.From RobG How to get all selected values of a multiple select box using JavaScript?:Actually, I found the best, most-succinct, fastest, and most-compatible way using pure JavaScript (assuming you don't need to fully support IE lte 8) is the following:UPDATE (2017-02-14):An even more succinct way using ES6/ES2015 (for the browsers that support it):If you wanna go the modern way, you can do this:The ... operator maps iterable (HTMLOptionsCollection) to the array.If you're just interested in the values, you can add a map() call:$('#select-meal-type :selected') will contain an array of all of the selected items.​First, use Array.from to convert the HTMLCollection object to an array.Try this:Demofiddleif you want as you expressed with breaks after each value;If you need to respond to changes, you can try this:The [].slice.call(e.target.selectedOptions) is needed because e.target.selectedOptions returns a HTMLCollection, not an Array. That call converts it to Array so that we can then apply the map function, which extract the values.Update October 2019The following should work "stand-alone" on all modern browsers without any dependencies or transpilation.Something like the following would be my choice:It's short, it's fast on modern browsers, and we don't care whether it's fast or not on 1% market share browsers.Note, selectedOptions has wonky behavior on some browsers from around 5 years ago, so a user agent sniff isn't totally out of line here.Works everywhere without jquery:

Bootstrap Modals keep adding padding-right to body after closed

phuwin

[Bootstrap Modals keep adding padding-right to body after closed](https://stackoverflow.com/questions/32862394/bootstrap-modals-keep-adding-padding-right-to-body-after-closed)

I am using bootstrap and Parse framework to build a small webapp. But those Bootstrap modals keep adding padding-right to body after closed. How to solve this?I tried to put this code in my javascript: 

But it doesn't work. Does anybody know how to fix this?My code:

I am using bootstrap and Parse framework to build a small webapp. But those Bootstrap modals keep adding padding-right to body after closed. How to solve this?

2015-09-30 09:20:35Z

I am using bootstrap and Parse framework to build a small webapp. But those Bootstrap modals keep adding padding-right to body after closed. How to solve this?I tried to put this code in my javascript: 

But it doesn't work. Does anybody know how to fix this?My code:

I am using bootstrap and Parse framework to build a small webapp. But those Bootstrap modals keep adding padding-right to body after closed. How to solve this?This might be a glitch from Bootstrap modal. From my tests, it seems like the problem is that #adminPanel is being initialized while #loginModal has not been totally closed yet. The workarounds can be removing the animation by removing the fade class on #adminPanel and #loginModal or set a timeout (~500ms) before calling $('#adminPanel').modal();. Hope this helps.I have just used the css fix below and it is working for meJust changed toA pure css solution that keeps the bootstrap functionality as it should be. The problem is caused by a function in the bootstrap jQuery that adds a bit of padding-right when a modal window opens, if there is a scroll bar on the page. That stops your body content shifting around when the modal opens, and it's a nice feature. But it's causing this bug.A lot of the other solutions given here break that feature, and make your content shift slightly about when the modal opens. This solution will preserve the feature of the bootstrap modal not shifting content around, but fix the bug. If you're more concerned about the padding-right related thing then you can do thisjQuery:this will addClass to your body and then using this CSS:and this will help you to get rid of padding-right.But if you're also concerned about the hiding scroll then you've to add this too:CSS:Here's the JSFiddlePlease have a look, it will do the trick for you.Just open bootstrap.min.cssFind this line (default)and change it asIt will work for every modal of the site. You can do overflow:auto; if you want to keep scrollbar as it is while opening modal dialog.I had this same problem for a VERY long time. None of the answers here worked! But the following fixed it!There are two events that fire on closing of a modal, first it's hide.bs.modal, and then it's hidden.bs.modal. You should be able to use just one.easy fixadd this class Its a override but worksI just removed the fade class and change the class fade effect with animation.css. I hope this will help.removeAttr won't work you will to remove the CSS property like this:With no property value, the property is removed.I'm loading the default bootstrap 3.3.0 CSS and had a similar problem.

Solved by adding this CSS:body.modal-open { overflow:inherit; padding-right:inherit !important; }The !important is because bootstrap modal javascript adds 15px of padding to the right programatically. My guess is that it's to compensate for the scrollbar, but I do not want that.With Bootstrap 4 this worked for me:I have same problem with Bootstrap 3.3.7 and my solution for fixed navbar: Adding this style to your custom css.it will make your modal showed while scroll window still working.

thanks, hope this will help you tooI know this is an old question, but none of the answers from here removed the problem in my similar situations and I thought it would be useful for some developers to read my solution too.I use to add some CSS to the body when a modal is opened, in the websites where it is still used bootstrap 3.My solution does not require any additional CSS.As pointed by @Orland, one event is still happening when the other starts. My solution is about starting the second event (showing the adminPanel modal) only when the first one is finished (hiding the loginModal modal).You can accomplish that by attaching a listener to the hidden.bs.modal event of your loginModal modal like below:And, when necessary, just hide the loginModal modal.Of couse you can implement your own logic inside the listener in order to decide to show or not the adminPanel modal.You can get more info about Bootstrap Modal Events here.Good luck.Bootstrap models add that padding-right to the body if the body is overflowing.On bootstrap 3.3.6 (the version I'm using) this is the function responsible for adding that padding-right to the body element:

https://github.com/twbs/bootstrap/blob/v3.3.6/dist/js/bootstrap.js#L1180A quick workaround is to simply overwrite that function after calling the bootstrap.js file:This fixed the issue for me.This is what worked for me:Just remove the data-target from the button and load the modal using jQuery. jQuery:I dug into the bootstrap javascript and found that the Modal code sets the right padding in a function called adjustDialog() which is defined on the Modal prototype and exposed on jQuery. Placing the following code somewhere to override this function to do nothing did the trick for me (although I don't know what the consequence of not setting this is yet!!)

$.fn.modal.Constructor.prototype.adjustDialog = function () { };

This can solve the problemThis is a bootstrap bug and fixed in v4-dev: https://github.com/twbs/bootstrap/pull/18441

till then adding below CSS class should help.I had that same problem using modals and ajax. It was because the JS file was referenced twice, both in the first page and in the page called by ajax, so when modal was closed, it called the JS event twice that, by default, adds a padding-right of 17px.Worked for me. Note that the Scrollbar is forced in body - but if you have a "scrolling" page anyways, it doesn't matter (?)Try this It will add the padding right 0px to the body after the modal close.It occurs when you open a modal that previous modal is not completely closed yet. To fix it just open new modal at the time that all modal are completely closed, check codes below:(Bootstrap v3.3.7)

From my browser inspector i saw that this is directly set in the element style property, witch overrides class properties.I tryed to 'reset' the paddig-right value when the modal is showing with :But it comes back as soon as the window is resized :( (probablly from the pluggin script).This solution worked for me :As @Orland says if you are using some effect like fade then there we need to wait before displaying the modal, this is a bit hacky but will do the trick.I hope there is still someone who needs this answer. There is a function called resetScrollbar() in bootstrap.js, for some stupid reason the developers decided to add the scrollbar dimensions to the body's padding right. so technically if you just set right-padding to an empty string it will fix the problemI have tried so many things but worked small thing for me.

How to select first parent DIV using jQuery?

Adam

[How to select first parent DIV using jQuery?](https://stackoverflow.com/questions/7089229/how-to-select-first-parent-div-using-jquery)

The parent in the above situation is an ankor.If I wanted to get the first parent DIV of $(this) what would the code look like?* Basically I want to get the classes of the first parent DIV of $(this).thx

2011-08-17 07:27:34Z

The parent in the above situation is an ankor.If I wanted to get the first parent DIV of $(this) what would the code look like?* Basically I want to get the classes of the first parent DIV of $(this).thxUse .closest() to traverse up the DOM tree up to the specified selector.Use .closest(), which gets the first ancestor element that matches the given selector 'div':EDIT:As @Shef noted, .closest() will return the current element if it happens to be a DIV also. To take that into account, use .parent() first:This gets parent if it is a div. Then it gets class.Keep it simple!two of the best options areand of course you can find the class attr by

Why define an anonymous function and pass it jQuery as the argument?

Matt Roberts

[Why define an anonymous function and pass it jQuery as the argument?](https://stackoverflow.com/questions/10371539/why-define-an-anonymous-function-and-pass-it-jquery-as-the-argument)

I'm looking through the excellent peepcode demo code from the backbone.js screencasts. In it, the backbone code is all enclosed in an anonymous function that is passed the jQuery object:In my own backbone code, I've just wrapped all my code in the jQuery DOM 'ready' event:What's the point/advantage of the first approach? Doing it this way creates an anonymous function that is then executed immediately with the jQuery object being passed as the function argument, effectively ensuring that $ is the jQuery object. Is this the only point - to guarantee that jQuery is bound to '$' or are there other reasons to do this?

2012-04-29 10:50:27Z

I'm looking through the excellent peepcode demo code from the backbone.js screencasts. In it, the backbone code is all enclosed in an anonymous function that is passed the jQuery object:In my own backbone code, I've just wrapped all my code in the jQuery DOM 'ready' event:What's the point/advantage of the first approach? Doing it this way creates an anonymous function that is then executed immediately with the jQuery object being passed as the function argument, effectively ensuring that $ is the jQuery object. Is this the only point - to guarantee that jQuery is bound to '$' or are there other reasons to do this?The two blocks of code you have shown are dramatically different in when and why they execute. They are not exclusive of each other. They do not serve the same purpose.This is a "JavaScript Module" pattern, implemented with an immediately invoking function.The purpose of this code is to provide "modularity", privacy and encapsulation for your code. The implementation of this is a function that is immediately invoked by the calling (jQuery) parenthesis. The purpose of passing jQuery in to the parenthesis is to provide local scoping to the global variable. This helps reduce the amount of overhead of looking up the $ variable, and allows better compression / optimization for minifiers in some cases.Immediately invoking functions are executed, well, immediately. As soon as the function definition is complete, the function is executed. This is an alias to jQuery's "DOMReady" function: http://api.jquery.com/ready/jQuery's "DOMReady" function executes when the DOM is ready to be manipulated by your JavaScript code.It's bad form to define your Backbone code inside of jQuery's DOMReady function, and potentially damaging to your application performance. This function does not get called until the DOM has loaded and is ready to be manipulated. That means you're waiting until the browser has parsed the DOM at least once before you are defining your objects. It's a better idea to define your Backbone objects outside of a DOMReady function. I, among many others, prefer to do this inside of a JavaScript Module pattern so that I can provide encapsulation and privacy for my code. I tend to use the "Revealing Module" pattern (see the first link above) to provide access to the bits that I need outside of my module.By defining your objects outside of the DOMReady function, and providing some way to reference them, you are allowing the browser to get a head start on processing your JavaScript, potentially speeding up the user experience. It also makes the code more flexible as you can move things around without having to worry about creating more DOMREady functions when you do move things.You're likely going to use a DOMReady function, still, even if you define your Backbone objects somewhere else. The reason is that many Backbone apps need to manipulate the DOM in some manner. To do this, you need to wait until the DOM is ready, therefore you need to use the DOMReady function to start your application after it has been defined.You can find plenty of examples of this around the web, but here's a very basic implementation, using both a Module and the DOMReady function:As a minor sidenote, sending in $ as an argument to an anonymous function makes $ local to that function which has a small positive performance implication if the $ function is called a lot. This is because javascript searches the local scope for variables first and then traverses down all the way to the window scope (where $ usually lives).It ensures you can always use $ inside that closure even if $.noConflict() was used.Without this closure you'd be supposed to use jQuery instead of $ the whole time.It is to avoid a potential conflict of the $ variable.

If something else defines a variable named $, your plugin may use the wrong definitionRefer to http://docs.jquery.com/Plugins/Authoring#Getting_Started for more detailsUse both.The self invoking function in which you pass in jQuery to prevent library conflicts, and to just make sure jQuery is available as you would expect with $. And the .ready() shortcut method as required to run javascript only after DOM has loaded:

How to make jQuery to not round value returned by .width()?

MoDFoX

[How to make jQuery to not round value returned by .width()?](https://stackoverflow.com/questions/3603065/how-to-make-jquery-to-not-round-value-returned-by-width)

I've searched around and couldn't find this. I'm trying to get the width of a div, but if it has a decimal point it rounds the number. Example: If I do $('#container').width(); it will return 543 instead of 543.5. How do I get it to not round the number and return the full 543.5 (or whatever number it is).

2010-08-30 18:18:54Z

I've searched around and couldn't find this. I'm trying to get the width of a div, but if it has a decimal point it rounds the number. Example: If I do $('#container').width(); it will return 543 instead of 543.5. How do I get it to not round the number and return the full 543.5 (or whatever number it is).Use the native Element.getBoundingClientRect rather than the style of the element. It was introduced in IE4 and is supported by all browsers:Note: For IE8 and below, see the "Browser Compatibility" notes in the MDN docs.Just wanted to add my experience here, though the question's old: The consensus above seems to be that jQuery's rounding is effectively just as good as an unrounded calculation -- but that doesn't seem to be the case in something I've been doing.My element has a fluid width, generally, but content that changes dynamically via AJAX. Before switching the content, I temporarily lock the dimensions of the element so my layout doesn't bounce around during the transition. I've found that using jQuery like this:is causing some funniness, like there are sub-pixel differences between the actual width and the calculated width. (Specifically, I will see a word jump from one line of text to another, indicating the the width has been changed, not just locked.) From another question -- Getting the actual, floating-point width of an element -- I found out that window.getComputedStyle(element).width will return an unrounded calculation. So I changed the above code to something likeAnd with THAT code -- no funny bouncing! That experience seems to suggest that the unrounded value actually does matter to the browser, right? (In my case, Chrome Version 26.0.1410.65.)Ross Allen's answer is a good starting point but using getBoundingClientRect().width will also include the padding and the border width which ain't the case the the jquery's width function:If your intent is to get the width value with the precision, you'll have to remove the padding and the border like this:You can use getComputedStyle for it: Use the following to get an accurate width:

How to tell if node.js is installed or not

user1340052

[How to tell if node.js is installed or not](https://stackoverflow.com/questions/10475651/how-to-tell-if-node-js-is-installed-or-not)

I've recently installed node.js and I have no idea how to run applications. I installed node.js but couldn't find further instructions. What does one really need to do? I wanted to see if it was actually working. So I executed a script called hello.js. It went as such:Now where would this be logged to? EditI'm running this .js through a .php script.

2012-05-07 01:14:32Z

I've recently installed node.js and I have no idea how to run applications. I installed node.js but couldn't find further instructions. What does one really need to do? I wanted to see if it was actually working. So I executed a script called hello.js. It went as such:Now where would this be logged to? EditI'm running this .js through a .php script.Open a terminal window.

Type:This will display your nodejs version.Navigate to where you saved your script and input:This will run your script.open a terminal and enterthis will tell you the version of the nodejs installed, then run nodejs simple by enteringPrompt must be change. Enter following,command line must prompt the following output if the installation was successfulPlease try this command node --version or node -v, either of which should return something like v4.4.5.(This is for windows OS but concept can be applied to other OS)Running command node -v will be able to confirm if it is installed, however it will not be able to confirm if it is NOT installed. (Executable may not be on your PATH)Two ways you can check if it is actually installed:or If you don't have it installed, get it from here https://nodejs.org/en/download/Open the command prompt in Windows or terminal in Linux and Mac.TypeIf node is install it will show its version.For eg.,Else download it from nodejs.orgCtrl + R - to open the command line 

and then writes:Check the node version using node -v.

Check the npm version using npm -v. If these commands gave you version number you are good to go with NodeJs developmentCreate a Directory using mkdir NodeJs. Inside the NodeJs folder create a file using touch index.js. Open your index.js either using vi or in your favourite text editor. Type in console.log('Welcome to NodesJs.') and save it. Navigate back to your saved file and type node index.js. If you see Welcome to NodesJs. you did a nice job and you are up with NodeJs.

Missing Javascript「.map」file for Underscore.js when loading ASP.NET web page [duplicate]

Robert Oschler

[Missing Javascript「.map」file for Underscore.js when loading ASP.NET web page [duplicate]](https://stackoverflow.com/questions/18429625/missing-javascript-map-file-for-underscore-js-when-loading-asp-net-web-page)

I have a web page that is part of a ASP.NET web site running on Azure.  It's run fine for quite a while now.  Out of the blue, I am suddenly having a problem with the browser trying to download a ".map" for Underscore.js.  I did some reading and apparently JQuery creates ".map" files as debugging aids for Javascript source files (".js").  However, if I look at the Scripts directory for my web site I see that this only happens for some JQuery source files and not all and I am not sure what the pattern is.However, why would the browser be trying to load a "map" file for Underscore.js which is not part of JQuery?  Also, why would this suddenly start happening?  I added Underscore.js to the web page quite some time ago and never had this problem before.  The exact error I get when I look in the Chrome Debugger Console tab is:GET http://myazureapp.cloudapp.net/Scripts/underscore-min.map 404 (Not Found) Scripts/underscore-min.map:1

2013-08-25 13:45:58Z

I have a web page that is part of a ASP.NET web site running on Azure.  It's run fine for quite a while now.  Out of the blue, I am suddenly having a problem with the browser trying to download a ".map" for Underscore.js.  I did some reading and apparently JQuery creates ".map" files as debugging aids for Javascript source files (".js").  However, if I look at the Scripts directory for my web site I see that this only happens for some JQuery source files and not all and I am not sure what the pattern is.However, why would the browser be trying to load a "map" file for Underscore.js which is not part of JQuery?  Also, why would this suddenly start happening?  I added Underscore.js to the web page quite some time ago and never had this problem before.  The exact error I get when I look in the Chrome Debugger Console tab is:GET http://myazureapp.cloudapp.net/Scripts/underscore-min.map 404 (Not Found) Scripts/underscore-min.map:1What you're experiencing is source mapping. This allows you to debug with readable code in your browser's developer tools when working with minified JS files.The minified version of Underscore has this line at the end of the file:Your browser's developers tools will try to download underscore-min.map when encountering this line.If you want to get rid of the error, either:

How can I wait for set of asynchronous callback functions?

codersarepeople

[How can I wait for set of asynchronous callback functions?](https://stackoverflow.com/questions/10004112/how-can-i-wait-for-set-of-asynchronous-callback-functions)

I have code that looks something like this in javascript:After ALL of those async calls are done, I want to calculate the min over all of the arrays.How can I wait for all of them?My only idea right now is to have an array of booleans called done, and set done[i] to true in the ith callback function, then say while(not all are done) {}edit: I suppose one possible, but ugly solution, would be to edit the done array in each callback, then call a method if all other done are set from each callback, thus the last callback to complete will call the continuing method.Thanks in advance.

2012-04-04 02:14:00Z

I have code that looks something like this in javascript:After ALL of those async calls are done, I want to calculate the min over all of the arrays.How can I wait for all of them?My only idea right now is to have an array of booleans called done, and set done[i] to true in the ith callback function, then say while(not all are done) {}edit: I suppose one possible, but ugly solution, would be to edit the done array in each callback, then call a method if all other done are set from each callback, thus the last callback to complete will call the continuing method.Thanks in advance.You haven't been very specific with your code, so I'll make up a scenario.  Let's say you have 10 ajax calls and you want to accumulate the results from those 10 ajax calls and then when they have all completed you want to do something.  You can do it like this by accumulating the data in an array and keeping track of when the last one has finished:Manual CounterNote: error handling is important here (not shown because it's specific to how you're making your ajax calls).  You will want to think about how you're going to handle the case when one ajax call never completes, either with an error or gets stuck for a long time or times out after a long time.jQuery PromisesAdding to my answer in 2014.  These days, promises are often used to solve this type of problem since jQuery's $.ajax() already returns a promise and $.when() will let you know when a group of promises are all resolved and will collect the return results for you:ES6 Standard PromisesAs specified in kba's answer: if you have an environment with native promises built-in (modern browser or node.js or using babeljs transpile or using a promise polyfill), then you can use ES6-specified promises.  See this table for browser support.  Promises are supported in pretty much all current browsers, except IE.If doAjax() returns a promise, then you can do this:If you need to make a non-promise async operation into one that returns a promise, you can "promisify" it like this:And, then use the pattern above:Bluebird PromisesIf you use a more feature rich library such as the Bluebird promise library, then it has some additional functions built in to make this easier:Checking in from 2015: We now have native promises in most recent browser (Edge 12, Firefox 40, Chrome 43, Safari 8, Opera 32 and Android browser 4.4.4 and iOS Safari 8.4, but not Internet Explorer, Opera Mini and older versions of Android).If we want to perform 10 async actions and get notified when they've all finished, we can use the native Promise.all, without any external libraries:You can use jQuery's Deferred object along with the when method.You can emulate it like this:then each async call does this:while in each asynch call back at the end of the method you add this line:In other words, you emulate a count-down-latch functionality.This is the most neat way in my opinion.Promise.allFetchAPI(for some reason Array.map doesn't work inside .then functions for me. But you can use a .forEach and [].concat() or something similar)Use an control flow library like after

Array.sort() doesn't sort numbers correctly [duplicate]

Some Guy

[Array.sort() doesn't sort numbers correctly [duplicate]](https://stackoverflow.com/questions/7000851/array-sort-doesnt-sort-numbers-correctly)

In Chrome 14, and Firefox 5 (haven't tested other browsers), the following code doesn't sort the numbers correctly:It returns 10,100,20,30,60I've tried different numbers, and it always acts as if the 0s aren't there and sorts the numbers correctly otherwise. Anyone know why?

2011-08-09 18:17:32Z

In Chrome 14, and Firefox 5 (haven't tested other browsers), the following code doesn't sort the numbers correctly:It returns 10,100,20,30,60I've tried different numbers, and it always acts as if the 0s aren't there and sorts the numbers correctly otherwise. Anyone know why?You're getting a lexicographical sort (e.g. convert objects to strings, and sort them in dictionary order), which is the default sort behavior in Javascript:https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/sortIn the ECMAscript specification (the normative reference for the generic Javascript), ECMA-262, 3rd ed., section 15.4.4.11, the default sort order is lexicographical, although they don't come out and say it, instead giving the steps for a conceptual sort function that calls the given compare function if necessary, otherwise comparing the arguments when converted to strings:These can be confusing.... check this link out.The default sort for arrays in Javascript is an alphabetical search. If you want a numerical sort, try something like this:You can use a sort function :Look at http://www.javascriptkit.com/javatutors/arraysort.shtml try this:

to remove first and last element in array

Mohan Ram

[to remove first and last element in array](https://stackoverflow.com/questions/4644139/to-remove-first-and-last-element-in-array)

How to remove first and last element in an array?For example:Expected output array:

2011-01-10 06:06:28Z

How to remove first and last element in an array?For example:Expected output array:See all methods for an Array.Creates a 1 level deep copy.Let go of the original array.Thanks to @Tim for pointing out the spelling errata.Here, -1 denotes the last element in an array and 1 denotes the second element.I use splice method.To remove last element also you can do it this way:See Remove last item from array to see more comments about it.push() adds a new element to the end of an array.

pop() removes an element from the end of an array.unshift() adds a new element to the beginning of an array.

shift() removes an element from the beginning of an array.To remove first element from an array arr , use arr.shift()

To remove last element from an array arr , use arr.pop()You can use Array.prototype.reduce().Code:To remove element from array is easy just do the followingThis can be done with lodash _.tail and _.dropRight:Say you have array named list. The Splice() function can be used for both adding and removing item in that array in specific index i.e that can be in the beginning or in the end or at any index. On the contrary there are another function name shift() and pop() which is capable of removing only the first and last item in the array. You used

Fruits.shift() method to first element remove .

Fruits.pop() method used for last element remove one by one if you used button click.

 Fruits.slice( start position, delete element)You also used slice method for remove element in middle  start.To remove the first and last element of an array is by using the built-in method of an array i.e shift() and pop() the fruits.shift() get the first element of the array as "Banana"  while fruits.pop() get the last element of the array as "Mango". so the remaining element of the array will be ["Orange", "Apple"]

How to ISO 8601 format a Date with Timezone Offset in JavaScript?

Meow

[How to ISO 8601 format a Date with Timezone Offset in JavaScript?](https://stackoverflow.com/questions/17415579/how-to-iso-8601-format-a-date-with-timezone-offset-in-javascript)

Goal: Find the local time and UTC time offset then construct the URL in following format.Example URL: /Actions/Sleep?duration=2002-10-10T12:00:00−05:00The format is based on the W3C recommendation:

http://www.w3.org/TR/xmlschema11-2/#dateTimeThe documentation says:So based on my understanding, I need to find my local time by new Date() then use getTimezoneOffset() function to compute the difference then attach it to the end of string.1.Get local time with formatoutput2.Get UTC time offset by houroutput3.Construct URL (time part only)output:The above output means my local time is 2013/07/02 9am and difference from UTC is 7 hours (UTC is 7 hours ahead of local time)So far it seems to work but what if getTimezoneOffset() returns negative value like -120?I'm wondering how the format should look like in such case because I cannot figure out from W3C document. Thanks in advance.

2013-07-02 00:19:16Z

Goal: Find the local time and UTC time offset then construct the URL in following format.Example URL: /Actions/Sleep?duration=2002-10-10T12:00:00−05:00The format is based on the W3C recommendation:

http://www.w3.org/TR/xmlschema11-2/#dateTimeThe documentation says:So based on my understanding, I need to find my local time by new Date() then use getTimezoneOffset() function to compute the difference then attach it to the end of string.1.Get local time with formatoutput2.Get UTC time offset by houroutput3.Construct URL (time part only)output:The above output means my local time is 2013/07/02 9am and difference from UTC is 7 hours (UTC is 7 hours ahead of local time)So far it seems to work but what if getTimezoneOffset() returns negative value like -120?I'm wondering how the format should look like in such case because I cannot figure out from W3C document. Thanks in advance.The below should work properly, and for all browsers (thanks to @MattJohnson for the tip)getTimezoneOffset() returns the opposite sign of the format required by the spec that you referenced.This format is also known as ISO8601, or more precisely as RFC3339.In this format, UTC is represented with a Z while all other formats are represented by an offset from UTC.  The meaning is the same as JavaScript's, but the order of subtraction is inverted, so the result carries the opposite sign.Also, there is no method on the native Date object called format, so your function in #1 will fail unless you are using a library to achieve this.  Refer to this documentation.If you are seeking a library that can work with this format directly, I recommend trying moment.js.  In fact, this is the default format, so you can simply do this:This is a well-tested, cross-browser solution, and has many other useful features.I think it is worth considering that you can get the requested info with just a single API call to the standard library...You would have to do text swapping if you want to add the 'T' delimiter, remove the 'GMT-', or append the ':00' to the end.But then you can easily play with the other options if you want to eg. use 12h time or omit the seconds etc.Note that I'm using Sweden as locale because it is one of the countries that uses ISO 8601 format.  I think most of the ISO countries use this 'GMT-4' format for the timezone offset other then Canada which uses the time zone abbreviation eg. "EDT" for eastern-daylight-time.You can get the same thing from the newer standard i18n function "Intl.DateTimeFormat()"

 but you have to tell it to include the time via the options or it will just give date.This is my function for the clients timezone, it's lite weight and simpleCheck this:Just my two sends hereI was facing this issue with datetimes so what I did is this:Then save date to db to be able to compare it from some query.To install moment-timezoneNo moment.js needed: Here's a full round trip answer, from an input type of "datetime-local" which outputs an ISOLocal string to UTCseconds at GMT and back:My answer is a slight variation for those who just want today's date in the local timezone in the YYYY-MM-DD format.Let me be clear:My Goal: get today's date in the user's timezone but formatted as ISO8601 (YYYY-MM-DD)Here is the code:This works because the Sweden locale uses the ISO 8601 format.

How to get collection of keys in javascript dictionary? [duplicate]

FreeVice

[How to get collection of keys in javascript dictionary? [duplicate]](https://stackoverflow.com/questions/10654992/how-to-get-collection-of-keys-in-javascript-dictionary)

I have dictionary:Now, I need to show it in dropdownlist. How to get collection of keys in my dictionary?

2012-05-18 14:58:41Z

I have dictionary:Now, I need to show it in dropdownlist. How to get collection of keys in my dictionary?Use Object.keys() or shim it in older browsers...If you wanted values, there is Object.values() and if you want key and value, you can use Object.entries(), often paired with Array.prototype.forEach() like this...Alternatively, considering your use case, maybe this will do it...One option is using Object.keys():It works fine for modern browsers (however, IE supports it starting from version 9 only).To add compatible support you can copy the code snippet provided in MDN.to loop through the "dictionary" (we call it object in JS), use a for in loop:This will work in all JavaScript implementations:Like others mentioned before you may use Object.keys, but it may not work in older engines. So you can use the following monkey patch:Simply use Object.keys():With a modern JS engine you can use Object.keys(driversCounter)for new browsers: Object.keys( MY_DICTIONARY ) will return an array of keys. Else you may want to go the old school way:As others have said, you could use Object.keys(), but who cares about older browsers, right?Well, I do.Try this. array_keys from PHPJS ports PHP's handy array_keys function so it can be used in JS. At a glance, it uses Object.keys if supported, but handles the case where it isn't very easily. It even includes filtering the keys based on values you might be looking for (optional) and a toggle for whether or not to use strict comparison === versus typecasting comparison == (optional)if you can use JQuery thenhere follows the answer:and this way you wouldn't have to worry if the browser supports Object.keys method or not.A different approach would be to using multi-dimensional arrays:and access the value by driverCounter[k][j], where j=0,1 in the case.

Add it in a drop down list by:

When serving JavaScript files, is it better to use the application/javascript or application/x-javascript

Matthew Flaschen

[When serving JavaScript files, is it better to use the application/javascript or application/x-javascript](https://stackoverflow.com/questions/876561/when-serving-javascript-files-is-it-better-to-use-the-application-javascript-or)

The whole question fits in the title. And to add some context: I'm not asking what is the best according to what the specs are saying, but rather what works the best given the mix of browsers deployed nowadays.Some data points:

2009-05-18 07:29:00Z

The whole question fits in the title. And to add some context: I'm not asking what is the best according to what the specs are saying, but rather what works the best given the mix of browsers deployed nowadays.Some data points:That said, browsers often ignore the content-type sent by the server and pay a lot of attention to the type attribute (and some may not yet recognise application/javascript).My recommendation:NB: the HTML specification contradicts the MIME standard, and there is an effort to change it back to text/javascript so this may change in future.In most situations, the mime type the server sends makes no practical difference.  I would go with application/javascript, which is also recommended by an RFC.If you choose to use application/javascript for js in your pages, IE7 and IE8 will not run your script!  Blame Microsoft all you want, but if you want most people to run your pages use text/javascript.It used to be language="javacript". Then it changed to type="text/javascript". Now it is type="application/javacript". Ok this is getting dumb. Some of the older browsers don't recognize the new application/javascript, but still recognize the older text/javascript. I plan to continue using this, or else I'll waste hours of my time trying to change EVERY instance of text/javascript into application/javascript.

Now some day the opposite might be true. Some day the newest browsers might reject the old technique in order to be strictly standard's compliant.

But until people viewing my website start complaining that "ever since upgrading my browser, about 50% of your website disappeared", I have no motive to change the code in my website.It has been "text/javascript" but this is obsolete (see the IANA List) and now it should be "application/javascript" (see another IANA List).Here's the 2020 answer to this question.text/javascript is the correct JavaScript MIME type per the HTML Standard, which states:And also:Work is underway to reflect this reality in an RFC at the IETF level: https://datatracker.ietf.org/doc/draft-ietf-dispatch-javascript-mjs/Any claim that "text/javascript is the obsolete one" is saying so based on RFC 4329, which both the HTML Standard and the abovementioned IETF draft (i.e. an upcoming RFC) are explicitly correcting.

Strange behavior for Map, parseInt [duplicate]

Ben McCormick

[Strange behavior for Map, parseInt [duplicate]](https://stackoverflow.com/questions/14528397/strange-behavior-for-map-parseint)

I saw this example of strange JavaScript behavior on twitterevaluates tocould somebody explain this behavior?  I verified it in chrome and firebugcorrectly returns an array of 10s as integers.  Is this an improper use of map(), a bug with parseInt, or something else?

2013-01-25 18:47:38Z

I saw this example of strange JavaScript behavior on twitterevaluates tocould somebody explain this behavior?  I verified it in chrome and firebugcorrectly returns an array of 10s as integers.  Is this an improper use of map(), a bug with parseInt, or something else?parseInt receives two arguments: string and radix:while map handler's second argument is index:parseInt uses the first two arguments being passed in by map, and uses the second argument to specify the radix.Here's what's happening in your code:Here's a link to MDN on parseInt: https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/parseInt.From MDN:parseInt() takes two arguments. The value and the radix. That means that the parseInt() function is being called with unintended parameters.

Why is 'this' undefined inside class method when using promises? [duplicate]

SteamDev

[Why is 'this' undefined inside class method when using promises? [duplicate]](https://stackoverflow.com/questions/34930771/why-is-this-undefined-inside-class-method-when-using-promises)

I have a javascript class, and each method returns a Q promise. I want to know why this is undefined in method2 and method3. Is there a more correct way to write this code?I can fix this by using bind:But not entirely sure why bind is necessary; is .then() killing this off?

2016-01-21 17:46:47Z

I have a javascript class, and each method returns a Q promise. I want to know why this is undefined in method2 and method3. Is there a more correct way to write this code?I can fix this by using bind:But not entirely sure why bind is necessary; is .then() killing this off?this is always the object the method is called on. However, when passing the method to then(), you are not calling it! The method will be stored somewhere and called from there later. If you want to preserve this, you will have to do it like this:or if you have to do it the pre-ES6 way, you need to preserve this before:Promise handlers are called in the context of the global object (window) by default. When in strict mode (use strict;), the context is undefined. This is what's happening to method2 and method3.For method1, you're calling method1 as this.method1(). This way of calling it calls it in the context of the this object which is your instance. That's why the context inside method1 is the instance.Basically, you're passing it a function reference with no context reference. The this context is determined in a few ways:In your example, you're passing a function reference, so at it's invocation it's implied to be a global function or one without context. Using .bind resolves this by creating a new function where this is explicitly set.*This is only true in non-strict mode. In strict mode, this is set to undefined.**Assuming the function you're using hasn't been manually bound.One way functions get their context (this) is from the object on which they are invoked (which is why method1 has the right context - it's invoked on this). You are passing a reference to the function itself to then. You can imagine that the implementation of then looks something like this:In that example callback is a reference to your function. It doesn't have any context. As you've already noted you can get around that by binding the function to a context before you pass it to then.

How to specify an array of objects as a parameter or return value in JSDoc?

Ray

[How to specify an array of objects as a parameter or return value in JSDoc?](https://stackoverflow.com/questions/14611995/how-to-specify-an-array-of-objects-as-a-parameter-or-return-value-in-jsdoc)

In JSDoc, the best documentation I can find shows to use the following if you have an array of a specific type (such as an array of strings) as:How would you replace the below question marks specify an array of objects?

2013-01-30 19:20:26Z

In JSDoc, the best documentation I can find shows to use the following if you have an array of a specific type (such as an array of strings) as:How would you replace the below question marks specify an array of objects?You should be more specific what you mean by JSDoc - this is a generic term covering pretty much all the JavaDoc-style documentation tools for JavaScript.The syntax you used for array of strings looks like the one supported by Google Closure Compiler.Using this, an array of Objects would be:Or just an array of anything - this should work with pretty much all doc tools:jsdoc-toolkit, JSDoc 3, and JSDuck support the following syntax to denote an array of objects:In case you know the keys and the variable type of the values you can also do:or

How to get an object's properties in JavaScript / jQuery?

Saiful

[How to get an object's properties in JavaScript / jQuery?](https://stackoverflow.com/questions/4079274/how-to-get-an-objects-properties-in-javascript-jquery)

In JavaScript / jQuery, if I alert some object, I get either [object] or  [object Object]Is there any way to know:?

2010-11-02 15:35:29Z

In JavaScript / jQuery, if I alert some object, I get either [object] or  [object Object]Is there any way to know:?You can look up an object's keys and values by either invoking JavaScript's native for in loop:or using jQuery's .each() method:With the exception of six primitive types, everything in ECMA-/JavaScript is an object. Arrays; functions; everything is an object. Even most of those primitives are actually also objects with a limited selection of methods. They are cast into objects under the hood, when required. To know the base class name, you may invoke the Object.prototype.toString method on an object, like this:The above will output [object Array].There are several other class names, like [object Object], [object Function], [object Date], [object String], [object Number], [object Array], and [object Regex].The simple answer is that [object] indicates a host object that has no internal class.  A host object is an object that is not part of the ECMAScript implementation you're working with, but is provided by the host as an extension.  The DOM is a common example of host objects, although in most newer implementations DOM objects inherit from the native Object and have internal class names (such as HTMLElement, Window, etc).  IE's proprietary ActiveXObject is another example of a host object.[object] is most commonly seen when alerting DOM objects in Internet Explorer 7 and lower, since they are host objects that have no internal class name.

  You can get the "type" (internal class) of object using Object.prototype.toString.  The specification requires that it always returns a string in the format [object [[Class]]], where [[Class]] is the internal class name such as Object, Array, Date, RegExp, etc.  You can apply this method to any object (including host objects), usingMany isArray implementations use this technique to discover whether an object is actually an array (although it's not as robust in IE as it is in other browsers).In ECMAScript 3, you can iterate over enumerable properties using a for...in loop.  Note that most built-in properties are non-enumerable.  The same is true of some host objects.  In ECMAScript 5, you can get an array containing the names of all non-inherited properties using Object.getOwnPropertyNames(obj).  This array will contain non-enumerable and enumerable property names.I hope this doesn't count as spam. I humbly ended up writing a function after endless debug sessions: http://github.com/halilim/Javascript-Simple-Object-InspectUsageorGet FireBug for Mozilla Firefox.use console.log(obj);Spotlight.js is a great library for iterating over the window object and other host objects looking for certain things.You'll like it for this. Scanning object for first intance of a determinated prop:

Checking user's homepage in Internet Explorer

Ufuk Hacıoğulları

[Checking user's homepage in Internet Explorer](https://stackoverflow.com/questions/15813851/checking-users-homepage-in-internet-explorer)

Google displays a popup that asks if you want to set your home page as google.com. It's quite normal, when I say OK it sets it as google.com. After that however, I don't get the popup anymore. As far as I know, nobody should be able to retrieve the value of my homepage because it's a private info. But somehow Google is tracking it. I get the popup back when I set my homepage as a different site. I deleted the cookies but even then it is only displayed when I set homepage as another site.I tested this behavior on IE8 & IE9. The popup never shows up in Firefox and Chrome.

2013-04-04 14:19:06Z

Google displays a popup that asks if you want to set your home page as google.com. It's quite normal, when I say OK it sets it as google.com. After that however, I don't get the popup anymore. As far as I know, nobody should be able to retrieve the value of my homepage because it's a private info. But somehow Google is tracking it. I get the popup back when I set my homepage as a different site. I deleted the cookies but even then it is only displayed when I set homepage as another site.I tested this behavior on IE8 & IE9. The popup never shows up in Firefox and Chrome.Internet Explorer makes it possible to ask it whether a given URL is the home page, it's detailed on this MSDN page. That links to this example page demonstrating the API.The code Google uses can be viewed here:They are using the proprietary isHomePage method to check if google.com is your homepage. More info here.The following css code is the culprit. behavior: url(#default#homePage) url(#default#userData);this is why I don't really like IE. The behavior url(#default#userData) tells the browser to store this as session information on the client side or browser memory. More information here: http://msdn.microsoft.com/en-us/library/ms533015(v=vs.85).aspx

Use of @ symbol in Node module names [duplicate]

Derek Janni

[Use of @ symbol in Node module names [duplicate]](https://stackoverflow.com/questions/36293481/use-of-symbol-in-node-module-names)

I'm looking at some code from a coworker wrote and she's using the @ symbol in require statements. This is the first line of one of these files:When I try to run this code, I get an error:Which I frankly expect, there's nothing that looks like this in my directory for require to recognize! It seems like there's some magic going on here, which I hate.All I can guess is that either this is some obscure npm or Node trick that I haven't been exposed to, or maybe that there's some other dark art of configuration that I'm not getting. Any info appreciated, even if it's just an explanation of how @ works with require.Other ideas: Chef is involved somewhere in this whole thing, so that might be relevant. Update: 99% certain this is an issue with the way npm config works at this point, but still unsure of how to go about fixing it. Update2 based on some stuff I uncovered: 

2016-03-29 19:31:09Z

I'm looking at some code from a coworker wrote and she's using the @ symbol in require statements. This is the first line of one of these files:When I try to run this code, I get an error:Which I frankly expect, there's nothing that looks like this in my directory for require to recognize! It seems like there's some magic going on here, which I hate.All I can guess is that either this is some obscure npm or Node trick that I haven't been exposed to, or maybe that there's some other dark art of configuration that I'm not getting. Any info appreciated, even if it's just an explanation of how @ works with require.Other ideas: Chef is involved somewhere in this whole thing, so that might be relevant. Update: 99% certain this is an issue with the way npm config works at this point, but still unsure of how to go about fixing it. Update2 based on some stuff I uncovered: Scoped packages in npm are preceded by an '@' symbol: https://docs.npmjs.com/misc/scopeThe docs include additional information on requiring scoped packages:

https://docs.npmjs.com/misc/scope#requiring-scoped-packagesSo I solved this one myself.Turns out @company/config is one of our private NPM repositories, hosted on npm and defined by this alias to an internal GitHub repository: it had nothing to do with how require works. Using @ may or may not be a protocol that I was unaware of for private NPM repos, keep that in mind if you run into this.The @ scope is indicates package ownershipFrom the official documentation is at: https://docs.npmjs.com/about-scopesThe main advantage of scopes I've seen so far is that each scope is controlled by npm account of an organization / user, much like GitHub usernames / organization names.This way, it makes it easy to determine if the package you are looking at belongs to an organization you trust, or if it is a third party tool.For example, if you see a package:then you know that it comes from the user / group that controls the Angular team and can be trusted.On the other hand, the same could not be said about:TODO: the web UI / URL scheme is really wonky, how do you easily link: https://www.npmjs.com/package/@angular/cli to the corresponding organization / user page, presumably https://www.npmjs.com/~angular ? By searching the page source, the only hit for that URL is under "collaborators", but that contains other collaborators as well: https://www.npmjs.com/~angular-cli and https://www.npmjs.com/~google-wombotSee also: What is the meaning of the "at" (@) prefix on npm packages?Apart from scoped packages, the '@' can arise due to module-alias package in npm. Through module aliasing you can use frequently used modules without requiring its entire path. Also its effective when directory structure is long. e.g.) require('../../../../some/very/deep/module')Instead you can use: var module = require('@deep/module')In package.json you can provide the modules for which you are providing alias:And in the main file of the app use this:Refer here for detailed info: module-aliasWhen you call require() it reads a route. Since there seems to be no problem if you name a folder as @company, you should be able to require something with an @. Your coworker may have wanted to keep @company/config.js for herself because configurations usually are personal and could not be the same for another user. require will call files inside your project folder, with a detail:I created a route @company/config inside my test project folder. It only allowed me to require it using ./@company/config. Only when i moved the folder inside node_modules, it allowed me to require('@company/config');. I wouldn't recommend to put any module inside node_modules, it's just a 'container' for npm packages. Try to create a new config file and change the require route or simply delete the require and create a config object in your main file.

Logging Clientside JavaScript Errors on Server [closed]

MADMap

[Logging Clientside JavaScript Errors on Server [closed]](https://stackoverflow.com/questions/119432/logging-clientside-javascript-errors-on-server)

Im running a ASP.NET Site where I have problems to find some JavaScript Errors just with manual testing.Is there a possibility to catch all JavaScript Errors on the Clientside and log them on the Server i.e. in the EventLog (via Webservice or something like that)?

2008-09-23 06:43:11Z

Im running a ASP.NET Site where I have problems to find some JavaScript Errors just with manual testing.Is there a possibility to catch all JavaScript Errors on the Clientside and log them on the Server i.e. in the EventLog (via Webservice or something like that)?You could try setting up your own handler for the onerror event and use XMLHttpRequest to tell the server what went wrong, however since it's not part of any specification, support is somewhat flaky.Here's an example from Using XMLHttpRequest to log JavaScript errors:Short answer: Yes, it is possible.Longer answer: People have already written about how you can (at least partially) solve this issue by writing your own code. However, do note that there are services out there that seems to have made sure the JS code needed works in many browsers. I've found the following:I can't speak for any of these services as I haven't tried them yet.I have just implemented server side error logging on javascript errors on a project at work. There is a mixture of legacy code and new code using jQuery. I use a combination of window.onerror and wrapping the jQuery event handlers and onready function with an error handling function (see: JavaScript Error Tracking: Why window.onerror Is Not Enough).Once I have caught the error, I add some extra properties to it (url, browser, etc) and then post it back to the server using an ajax call.On the server I have a small page which just takes the posted arguments and outputs them to our normal server logging framework.I would like to open source the code for this (as a jQuery plugin). If anyone is interested let me know, it would help to convince the bosses!If you use Google Analytics, you can log javascript errors into Google Analytics Events.See this app: http://siteapps.com/app/log_javascript_errors_with_ga-181Hope it helps.Also I recomend using TraceTool utility, it comes with JavaScript support and is very handy for JS monitoring.If you're wanting to log the client-side errors back to the server you're going to have to do some kind of server processing. Best bet would be to have a web service which you can access via JavaScript (AJAX) and you pass your error log info to it.Doesn't 100% solve the problem cuz if the problem is with the web server hosting the web service you're in trouble, you're other option would be to send the info via a standard page via a query string, One method of doing that is via dynamically generating Image tags (which are then removed) as the browser will try and load the source of an image. It gets around cross-domain JavaScript calls nicely though. Keep in mind that you're in trouble if someone has images turned off ;)I've been using Appfail recently, which captures both asp.net and JavaScript errorsYou could potentially make an Ajax call to the server from a try/catch, but that's probably about the best you can do.May I suggest JavaScript unit testing instead?  Possibly with JSUnit?

Safari in ios8 is scrolling screen when fixed elements get focus

Sam Saffron

[Safari in ios8 is scrolling screen when fixed elements get focus](https://stackoverflow.com/questions/29001977/safari-in-ios8-is-scrolling-screen-when-fixed-elements-get-focus)

In IOS8 Safari there is a new bug with position fixed.If you focus a textarea that is in a fixed panel, safari will scroll you to the bottom of the page. This makes all sorts of UIs impossible to work with, since you have no way of entering text into textareas without scrolling your page all the way down and losing your place. Is there any way to workaround this bug cleanly? 

2015-03-12 04:39:08Z

In IOS8 Safari there is a new bug with position fixed.If you focus a textarea that is in a fixed panel, safari will scroll you to the bottom of the page. This makes all sorts of UIs impossible to work with, since you have no way of entering text into textareas without scrolling your page all the way down and losing your place. Is there any way to workaround this bug cleanly? Based on this good analysis of this issue, I've used this in html and body elements in css:I think it's working great for me.The best solution I could come up with is to switch to using position: absolute; on focus and calculating the position it was at when it was using position: fixed;. The trick is that the focus event fires too late, so touchstart must be used.The solution in this answer mimics the correct behavior we had in iOS 7 very closely.The body element must have positioning in order to ensure proper positioning when the element switches to absolute positioning.The following code is a basic example for the provided test-case, and can be adapted for your specific use-case.Here is the same code without the hack for comparison.If the position: fixed; element has any other parent elements with positioning besides body, switching to position: absolute; may have unexpected behavior. Due to the nature of position: fixed; this is probably not a major issue, since nesting such elements is not common.While the use of the touchstart event will filter out most desktop environments, you will probably want to use user-agent sniffing so that this code will only run for the broken iOS 8, and not other devices such as Android and older iOS versions. Unfortunately, we don't yet know when Apple will fix this issue in iOS, but I would be surprised if it is not fixed in the next major version.I found a method that works without the need to change to position absolute!Full uncommented codeBreaking it downFirst you need to have the fixed input field toward the top of the page in the HTML (it's a fixed element so it should semantically make sense to have it near the top anyway):Then you need to save the current scroll position into global variables:Then you need a way to detect iOS devices so it doesn't affect things that don't need the fix (function taken from https://stackoverflow.com/a/9039885/1611058)Now that we have everything we need, here is the fix :)I was able to fix this for select inputs by adding an event listener to the necessary select elements, then scrolling by an offset of one pixel when the select in question gains focus.This isn't necessarily a good solution, but it's much simpler and more reliable than the other answers I've seen here. The browser seems to re-render/re-calculate the position: fixed; attribute based on the offset supplied in the window.scrollBy() function.Much like Mark Ryan Sallee suggested, I found that dynamically changing the height and overflow of my background element is the key - this gives Safari nothing to scroll to.So after the modal's opening animation finishes, change the background's styling:When you close the modal change it back:While other answers are useful in simpler contexts, my DOM was too complicated (thanks SharePoint) to use the absolute/fixed position swap.Cleanly? no.I recently had this problem myself with a fixed search field in a sticky header, the best you can do at the moment is keep the scroll position in a variable at all times and upon selection make the fixed element's position absolute instead of fixed with a top position based on the document's scroll position. This is however very ugly and still results in some strange back and forth scrolling before landing on the right place, but it is the closest I could get.Any other solution would involve overriding the default scroll mechanics of the browser.This is now fixed in iOS 10.3! Hacks should no longer be needed. Haven't dealt with this particular bug, but maybe put an overflow: hidden; on the body when the text area is visible (or just active, depending on your design). This may have the effect of not giving the browser anywhere "down" to scroll to.A possible solution would be to replace the input field.codepenNone of these solutions worked for me because my DOM is complicated and I have dynamic infinite scroll pages, so I had to create my own.Background: I am using a fixed header and an element further down that sticks below it once the user scrolls that far down. This element has a search input field. In addition, I have dynamic pages added during forward and backwards scroll.Problem: In iOS, anytime the user clicked on the input in the fixed element, the browser would scroll all the way to the top of the page. This not only caused undesired behavior, it also triggered my dynamic page add at the top of the page.Expected Solution: No scroll in iOS (none at all) when the user clicks on the input in the sticky element.Solution:Requirements: JQuery mobile is required for the startsroll and stopscroll functions to work.Debounce is included to smooth out any lag created by the sticky element.Tested in iOS10.I just jumped over something like this yesterday by setting height of #a to max visible height (body height was in my case) when #b is visibleex: ps: sorry for late example, just noticed it was needed.I had the issue, below lines of code resolved it for me -

How to template If-Else structures in data-bound views?

Jensen Ching

[How to template If-Else structures in data-bound views?](https://stackoverflow.com/questions/11553999/how-to-template-if-else-structures-in-data-bound-views)

I constantly find myself using this idiom in KO-based HTML templates:Is there a better/cleaner way to do conditionals in KO, or is there a better approach than just using traditional if-else constructs?Also, I would just like to point out that some versions of Internet Explorer (IE 8/9) don't parse the above example correctly. Please see this SO question for more information. The quick summary is, don't use comments (virtual bindings) inside table tags to support IE. Use the tbody instead:

2012-07-19 04:33:32Z

I constantly find myself using this idiom in KO-based HTML templates:Is there a better/cleaner way to do conditionals in KO, or is there a better approach than just using traditional if-else constructs?Also, I would just like to point out that some versions of Internet Explorer (IE 8/9) don't parse the above example correctly. Please see this SO question for more information. The quick summary is, don't use comments (virtual bindings) inside table tags to support IE. Use the tbody instead:There are a couple different ways that you can handle this type of code.The getCellTemplate function could live wherever, but would be given the item ($data) as the first argument and would return the name of the template to use.One approach is to use named templates (which can support passing arguments):Another option is use my switch/case plugin, which would work like this:To avoid recalculation of knockout binding when using combination of if: / ifnot: you can use them in conjunction with 'with:' constructionThere is now also the knockout-else binding/plugin (that I wrote to address this issue).

jQuery parent of a parent

bloudermilk

[jQuery parent of a parent](https://stackoverflow.com/questions/966408/jquery-parent-of-a-parent)

I am currently trying to find the parent of a parent of an element. I have a link being clicked that is in a <td>, and I'd like to get the <tr> object.Why wont "$(this).parent().parent()" work? What will?Thanks,

BrendanEdit: It appears an error in my syntax was throwing the whole thing off. "$(this).parent().parent()" does in fact work, but I wound up going with $(this).closest('tr')" because it seems like the most efficient solution.

2009-06-08 19:05:52Z

I am currently trying to find the parent of a parent of an element. I have a link being clicked that is in a <td>, and I'd like to get the <tr> object.Why wont "$(this).parent().parent()" work? What will?Thanks,

BrendanEdit: It appears an error in my syntax was throwing the whole thing off. "$(this).parent().parent()" does in fact work, but I wound up going with $(this).closest('tr')" because it seems like the most efficient solution.The best way would probably be using closest:Check out the documentation:It should work. You can also try $(this).parents(tag) , where tag is the tag you want to find.For example:Will find the closest tr "up the chain".That should work... you might tryThe .parents(selector) says get all ancestors that match the selectorand the :eq(1) says find the oneth (zero-indexed, so the second) element in the listThis snippet has performed for me in the past: Post some code for us to see if there might be another problem somewhere...also try If you have any sort of id/class for the parent, you can use parents() but that will give you all parents up to the < body > unless you filter() or stop it some other way likeHope this helps someone :)Try wrapping the $(this).parent() into an jQuery object like $($(this).parent()) I often find the need to do this to make sure I have a valid jquery object. From there you should be able to get a hold of the parents parent, or using the prev() perhaps..closest() is not always best option specially when you have same element construct.You can do parent of a parent and it's very easy:etc.

Removing legend on charts with chart.js v2

Zeliax

[Removing legend on charts with chart.js v2](https://stackoverflow.com/questions/36749509/removing-legend-on-charts-with-chart-js-v2)

I'm making a homepage using, Bootstrap, JQuery and Chart.js (v2). I had my implementation working using v1, but recently just got into Bower and downloaded v2 using that.I'm making a grid of 4 columns each containing a pie chart, however the scaling in v2 is sort of confusing for me to get working. I want the charts to be responsive so they scale properly with the smaller devices such as tablets and smartphones, and one of my problems is getting rid of the legend of the charts as well as the hover information when hovering the mouse over the sections of my chart.If I remove the empty "labels" field the chart doesn't work anymore. And by the looks of it there is a small spacing at the top of the chart which could indicate that the headers are written, but they are just empty strings.Does anyone have an idea of how to remove the legend, and the hover description? I simply can't get my head around how this is usedI will get my hands around a jsfiddle as soon as I get time!EDIT: Link to the docs: https://nnnick.github.io/Chart.js/docs-v2/#getting-started

2016-04-20 16:11:45Z

I'm making a homepage using, Bootstrap, JQuery and Chart.js (v2). I had my implementation working using v1, but recently just got into Bower and downloaded v2 using that.I'm making a grid of 4 columns each containing a pie chart, however the scaling in v2 is sort of confusing for me to get working. I want the charts to be responsive so they scale properly with the smaller devices such as tablets and smartphones, and one of my problems is getting rid of the legend of the charts as well as the hover information when hovering the mouse over the sections of my chart.If I remove the empty "labels" field the chart doesn't work anymore. And by the looks of it there is a small spacing at the top of the chart which could indicate that the headers are written, but they are just empty strings.Does anyone have an idea of how to remove the legend, and the hover description? I simply can't get my head around how this is usedI will get my hands around a jsfiddle as soon as I get time!EDIT: Link to the docs: https://nnnick.github.io/Chart.js/docs-v2/#getting-startedThe options object can be added to the chart when the new Chart object is created.You can change options by using Chart.defaults.global in your javascript file. So you want to change legend and tooltip options. Here is a working fiddler.You simply need to add that line 

legend: {

    display: false

        }

How to add facebook share button on my website?

Sahibjot Singh

[How to add facebook share button on my website?](https://stackoverflow.com/questions/16463030/how-to-add-facebook-share-button-on-my-website)

I have this code that suppose to work, but doesn't work. If this helps you in anyway that would be great.I want to add facebook share button on my website, that should just post my website's content on the wall. who want to share it.I have researched a lot but did not get anything. Pleas help me in this. Thanks in advance.

2013-05-09 13:31:22Z

I have this code that suppose to work, but doesn't work. If this helps you in anyway that would be great.I want to add facebook share button on my website, that should just post my website's content on the wall. who want to share it.I have researched a lot but did not get anything. Pleas help me in this. Thanks in advance.You don't need all that code. All you need are the following lines:Documentation can be found at https://developers.facebook.com/docs/reference/plugins/share-links/You can do this by using asynchronous Javascript SDK provided by facebookHave a look at the following codeFB Javascript SDK initializationNote: Remember to replace YOUR APP ID with your facebook AppId. If you don't have facebook AppId and you don't know how to create please check this Add JQuery Library, I would preferred Google LibraryAdd share dialog box (You can customize this dialog box by  setting up parametersNow finally add image buttonFor more detailed kind of information. please click hereYou can read more about share button here on Facebook developers websiteWorking JSFIDDLE Also take a look at custom Facebook Share button JSFIDDLEInclude Facebook JavaScript SDK code right after the opening <body> tagAnd place below code wherever you want to show Facebook Share buttonCheck working JSFIDDLEFor Facebook share with an image without an API and using a # to deep link into a sub page, the trick was to share the image as picture= 

The variable mainUrl would be http://yoururl.com/ You can Trigger a Share Dialog using the FB.ui function with the share method parameter to share a link. This dialog is available in the Facebook SDKs for JavaScript, iOS, and Android by performing a full redirect to a URL. You can trigger this call:You can also include open graph meta tags on the page at this URL to customise the story that is shared back to Facebook.Note that response.error_message will appear only if someone using your app has authenticated your app with Facebook Login.Also you can directly share link with call by having Javascript Facebook SDK.If you are using the URL redirect dialog implementation, then this will be a full page display, shown within Facebook.com. This display type is called page.

If you are using one of our iOS or Android SDKs to invoke the dialog, this is automatically specified and chooses an appropriate display type for the device.

If you are using the Facebook SDK for JavaScript, this will default to a modal iframe type for people logged into your app or async when using within a game on Facebook.com, and a popup window for everyone else. You can also force the popup or page types when using the Facebook SDK for JavaScript, if necessary.

Mobile web apps will always default to the touch display type.

share ParametersFor your own specific server or different pages & image button you could use something like this (PHP only)I cannot share the snippet with this but you will get the idea...

How to remove/change JQuery UI Autocomplete Helper text?

user1236048

[How to remove/change JQuery UI Autocomplete Helper text?](https://stackoverflow.com/questions/13011127/how-to-remove-change-jquery-ui-autocomplete-helper-text)

It seems that this is a new feature in JQuery UI 1.9.0, because I used JQuery UI plenty of times before and this text never poped up. Couldn't find anything related on the API documentation. So using an basic autocomplete example with local source When the search matches it shows this related helper text: How can I disable it in a nice way, not by removing it with JQuery selectors.

2012-10-22 12:07:24Z

It seems that this is a new feature in JQuery UI 1.9.0, because I used JQuery UI plenty of times before and this text never poped up. Couldn't find anything related on the API documentation. So using an basic autocomplete example with local source When the search matches it shows this related helper text: How can I disable it in a nice way, not by removing it with JQuery selectors.I know this has been asnwered but just wanted to give an implementation example:This is used for accessibility, an easy way to hide it is with CSS:Or (see Daniel's comment bellow)The top answer here achieves the desired visual effect, but defeats the object of jQuery having ARIA support, and is a bit dickish to users who rely upon it! Those who've mentioned that jQuery CSS hides this for you are correct, and this is the style which does that:Copy that into your stylesheet instead of removing the message, please :).According to this blog:So if you go to github and look at the autocomplete source code, around line 571 you'll see where this is actually implemented.Adding the jquery css also worked to remove the instructional text.Since this is in there for accessibility reasons it's probably best to hide it with CSS.However, I would suggest:Rather than:As the former will hide the item off-screen, but still allow screen-readers to read it, whereas display:none does not.Well, this question is a bit older, but the text does not show up at all when you include the according css file:Of course you have to insert an actual theme instead of YOUR_THEME_HERE e.g. "smoothness"Style it how the jQuery theme itself styles it. A lot of the other answers suggest including a whole stylesheet, but if you just want the relevant CSS, this is how it's done in http://code.jquery.com/ui/1.9.0/themes/smoothness/jquery-ui.css:Adding this code right after the autocomplete in your script will push the annoying helper off the page, but the people using screen readers will still benefit from it: I'm not a fan of manipulating CSS with JS but in this case I think it makes sense. The JS code created the problem in the first place, and the problem will be solved a few lines below in the same file. IMO this is better than solving the problem in a separate CSS file which might be edited by other people who don't know why the .ui-helper-hidden-accessible class was modified that way.The jQuery CSS .ui-helper-hidden-accessible is in the themes/base/core.css file.  You should include this file (at a minimum) in your stylesheets for forward compatibility.

Javascript Reduce an empty array

agusgambina

[Javascript Reduce an empty array](https://stackoverflow.com/questions/23359173/javascript-reduce-an-empty-array)

When I reduce the array, I am trying to get the number zero, but I dont clearly understand the behaviour of the functionresultseems that if the array is empty I can't reduce itresultIf the only element in the array is an empty string, retrieves an empty string

2014-04-29 08:15:50Z

When I reduce the array, I am trying to get the number zero, but I dont clearly understand the behaviour of the functionresultseems that if the array is empty I can't reduce itresultIf the only element in the array is an empty string, retrieves an empty stringThe second parameter is for initial value.or using ES6:Both behaviors are according to the spec.You cannot reduce an empty array unless you explicitly provide an initial "accumulated" value as the second argument:If the array has at least one element then providing an initial value is optional. However, if one is not provided then the first element of the array is used as the initial value and reduce continues to process the rest of the array elements by invoking your callback. In your case the array only contains a single element, so that element becomes the initial value and also final value, since there are no more elements to be processed through the callback.

How to pass parameters to a view

vikmalhotra

[How to pass parameters to a view](https://stackoverflow.com/questions/7803138/how-to-pass-parameters-to-a-view)

I have a series of buttons which when clicked display a popup menu positioned just below the button. I want to pass the position of button to the view. How can I do that?

2011-10-18 06:13:31Z

I have a series of buttons which when clicked display a popup menu positioned just below the button. I want to pass the position of button to the view. How can I do that?You just need to pass the extra parameter when you construct the MenuView. No need to add the initialize function.And then, in MenuView, you can use this.options.position.UPDATE: As @mu is too short states, since 1.1.0, Backbone Views no longer automatically attach options passed to the constructor as this.options, but you can do it yourself if you prefer.So in your initialize method, you can save the options passed as this.options:or use some finer ways as described by @Brave Dave.Add an options argument to initialize:And then pass in some options when you create your view:For more information: http://backbonejs.org/#View-constructorAs of backbone 1.1.0, the options argument is no longer attached automatically to the view (see issue 2458 for discussion). You now need to attach the options of each view manually:Alternatively you can use this mini plugin to auto-attach white-listed options, like so:pass from other location Add an options argument to initialize in view you are getting that passed variable,to get the value 

use - Use this.options to retrieve argumentr in view    Working Example: http://jsfiddle.net/Cpn3g/1771/

Prevent form redirect OR refresh on submit?

Ian Storm Taylor

[Prevent form redirect OR refresh on submit?](https://stackoverflow.com/questions/1263852/prevent-form-redirect-or-refresh-on-submit)

I've searched through a bunch of pages, but can't find my problem, so I had to make a post.I have a form that has a submit button, and when submitted I want it to NOT refresh OR redirect. I just want jQuery to perform a function.Here's the form:And here is the jQuery:I've tried with and without an action element on the form, but don't know what I'm doing wrong. What has annoyed me more is that I have an example that does it perfectly:

Example PageIf you want to see my problem live, goto stormink.net (my site) and check out the sidebar where it says "Send me and email" and "RSS Subscription". Both are forms that I'm trying to get this to work on.

2009-08-12 01:50:00Z

I've searched through a bunch of pages, but can't find my problem, so I had to make a post.I have a form that has a submit button, and when submitted I want it to NOT refresh OR redirect. I just want jQuery to perform a function.Here's the form:And here is the jQuery:I've tried with and without an action element on the form, but don't know what I'm doing wrong. What has annoyed me more is that I have an example that does it perfectly:

Example PageIf you want to see my problem live, goto stormink.net (my site) and check out the sidebar where it says "Send me and email" and "RSS Subscription". Both are forms that I'm trying to get this to work on.Just handle the form submission on the submit event, and return false:You don't need any more the onclick event on the submit button:Here:Instead of using the onClick event, you'll use bind an 'click' event handler using jQuery to the submit button (or whatever button), which will take submitClick as a callback. We pass the event to the callback to call preventDefault, which is what will prevent the click from submitting the form.In the opening tag of your form, set an action attribute like so:It looks like you're missing a return false.If you want to see the default browser errors being displayed, for example, those triggered by HTML attributes (showing up before any client-code JS treatment):You should use the submit event instead of the click event. In this case a popup will be automatically displayed requesting "Please fill out this field". Even with preventDefault:As someone mentioned previously, return false would stop propagation (i.e. if there are more handlers attached to the form submission, they would not be executed), but, in this case, the action triggered by the browser will always execute first. Even with a return false at the end.So if you want to get rid of these default pop-ups, use the click event on the submit button:An alternative solution would be to not use form tag and handle click event on submit button through jquery. This way there wont be any page refresh but at the same time there is a downside that "enter" button for submission wont work and also on mobiles you wont get a go button( a style in some mobiles). So stick to use of form tag and use the accepted answer.

Uncaught TypeError: Cannot use 'in' operator to search for 'length' in

Iván Alberto Fontalvo Salgado

[Uncaught TypeError: Cannot use 'in' operator to search for 'length' in](https://stackoverflow.com/questions/30269461/uncaught-typeerror-cannot-use-in-operator-to-search-for-length-in)

This is the error I receive when I try to do a $.each to this JSON object :I have also tried to do the same with stringify, but I receive the same error:If I remove parameters ___DDSESSIONID\\u003d06CBEC9D1A53616EFF703A8C71FBC2B4%3A%2FMobilTest from the object the $.each works fine. Why might this be happening?Thanks in advance.

2015-05-15 22:07:21Z

This is the error I receive when I try to do a $.each to this JSON object :I have also tried to do the same with stringify, but I receive the same error:If I remove parameters ___DDSESSIONID\\u003d06CBEC9D1A53616EFF703A8C71FBC2B4%3A%2FMobilTest from the object the $.each works fine. Why might this be happening?Thanks in advance.The in operator only works on objects. You are using it on a string. Make sure your value is an object before you using $.each. In this specific case, you have to parse the JSON:maybe you forget to add parameter dataType:'json' in your $.ajax 

How can I erase all inline styles with javascript and leave only the styles specified in the css style sheet?

Matt

[How can I erase all inline styles with javascript and leave only the styles specified in the css style sheet?](https://stackoverflow.com/questions/1229688/how-can-i-erase-all-inline-styles-with-javascript-and-leave-only-the-styles-spec)

If I have the following in my html:And this in my css style sheet:Is there any way, with javascript/jquery, to remove all of the inline styles and leave only the styles specified by the css style sheet?

2009-08-04 20:14:59Z

If I have the following in my html:And this in my css style sheet:Is there any way, with javascript/jquery, to remove all of the inline styles and leave only the styles specified by the css style sheet?$('div').attr('style', '');or$('div').removeAttr('style'); (From Andres's Answer)To make this a little smaller, try this:$('div[style]').removeAttr('style');This should speed it up a little because it checks that the divs have the style attribute.Either way, this might take a little while to process if you have a large amount of divs, so you might want to consider other methods than javascript.Plain JavaScript:You don't need jQuery to do something trivial like this. Just use the .removeAttribute() method.Assuming you are just targeting a single element, you can easily use the following: (example)If you are targeting multiple elements, just loop through the selected collection of elements: (example)Array.prototype.forEach() - IE9 and above / .querySelectorAll() - IE 8 (partial) IE9 and above.I was using the $('div').attr('style', ''); technique and it wasn't working in IE8.I outputted the style attribute using alert() and it was not stripping out inline styles..removeAttr ended up doing the trick in IE8.If you need to just empty the style of an element then: element.style.cssText = null;This should do good. Hope it helps!This can be accomplished in two steps:1: select the element you want to change by either tagname, id, class etc.var element = document.getElementsByTagName('h2')[0];element.removeAttribute('style');You could also try listing the css in the style sheet as !important 

How can I open a link in a new window?

Chris

[How can I open a link in a new window?](https://stackoverflow.com/questions/2827637/how-can-i-open-a-link-in-a-new-window)

I have a click handler for a specific link, inside that I want to do something similar to the following:I need this to actually open the url in a new window though, how do I do this?

2010-05-13 14:38:00Z

I have a click handler for a specific link, inside that I want to do something similar to the following:I need this to actually open the url in a new window though, how do I do this?You can like:jQuery:You could also set the target to _blank actually.Here's how to force the target inside a click handler:you will need to use  window.open(url);references:

http://www.htmlcodetutorial.com/linking/linking_famsupp_120.html

http://www.w3schools.com/jsref/met_win_open.aspYou can also use the jquery prop() method for this. I just found an interesting solution to this issue. I was creating spans which contain information based on the return from a web service. I thought about trying to put a link around the span so that if I clicked on it, the "a" would capture the click.But I was trying to capture the click with the span... so I thought why not do this when I created the span.I then bound a click handler to the span which created a link based on the 'data-href' attribute:This successfully allowed me to click on a span and open a new window with a proper url.What's wrong with <a href="myurl.html" target="_blank">My Link</a>? No Javascript needed...this solution also considered the case that url is empty and disabled(gray) the empty link.Be aware if you want to execute AJAX requests inside the event handler function for the click event. For some reason Chrome (and maybe other browsers) will not open a new tab/window.This is not a very nice fix but it works:CSS:HTML:Javascript:Live example: http://jsfiddle.net/7eRLb/Microsoft IE does not support a name as second argument.Problem is window name. This will work:Microsoft only allows the following arguments, If using that argument at all:Check this Microsoft site 

Global variables in Javascript and ESLint

marco_sap

[Global variables in Javascript and ESLint](https://stackoverflow.com/questions/41552041/global-variables-in-javascript-and-eslint)

I have got multiple javascript files and I have defined some global variable in a file which loads before the others.

As a consequence all of the files loaded after the first have access to the global variable.

However ESLint shows the global variable as "not defined". I don't want to change the rules of ESLint and I would like to find an elegant way to get rid of these error messages.

Any clue?

Thanks

2017-01-09 16:05:48Z

I have got multiple javascript files and I have defined some global variable in a file which loads before the others.

As a consequence all of the files loaded after the first have access to the global variable.

However ESLint shows the global variable as "not defined". I don't want to change the rules of ESLint and I would like to find an elegant way to get rid of these error messages.

Any clue?

ThanksI don't think hacking ESLint rules per file is a great idea.You should rather define globals in .eslintrc or package.json. For .eslintrc:For package.json:PSReading documentation is a virtue mandatory for developershttps://eslint.org/docs/user-guide/configuring#specifying-globalsYou can add globals either per file or in your config.

If you don't want to change your config, you'll have to add the used globals in every file.http://eslint.org/docs/2.0.0/user-guide/configuring#specifying-globals

JSON.parse vs. eval()

Kevin Major

[JSON.parse vs. eval()](https://stackoverflow.com/questions/1843343/json-parse-vs-eval)

My Spider Sense warns me that using eval() to parse incoming JSON is a bad idea.  I'm just wondering if JSON.parse() - which I assume is a part of JavaScript and not a browser-specific function - is more secure.

2009-12-03 22:14:53Z

My Spider Sense warns me that using eval() to parse incoming JSON is a bad idea.  I'm just wondering if JSON.parse() - which I assume is a part of JavaScript and not a browser-specific function - is more secure.You are more vulnerable to attacks if using eval:  JSON is a subset of Javascript and json.parse just parses JSON whereas eval would leave the door open to all JS expressions.All JSON.parse implementations most likely use eval()JSON.parse is based on Douglas Crockford's solution, which uses eval() right there on line 497.The advantage of JSON.parse is that it verifies the argument is correct JSON syntax.Not all browsers have native JSON support so there will be times where you need to use eval()  to the JSON string. Use JSON parser from http://json.org as that handles everything a lot easier for you.Eval() is an evil but against some browsers its a necessary evil but where you can avoid it, do so!!!!!There is a difference between what JSON.parse() and eval() will accept. Try eval on this:var x = "{\"shoppingCartName\":\"shopping_cart:2000\"}"See this example.If you parse the JSON with eval, you're allowing the string being parsed to contain absolutely anything, so instead of just being a set of data, you could find yourself executing function calls, or whatever. Also, JSON's parse accepts an aditional parameter, reviver, that lets you specify how to deal with certain values, such as datetimes (more info and example in the inline documentation here)JSON is just a subset of JavaScript. But eval evaluates the full JavaScript language and not just the subset that’s JSON.

How do I post form data with fetch api?

Zack

[How do I post form data with fetch api?](https://stackoverflow.com/questions/46640024/how-do-i-post-form-data-with-fetch-api)

My code:I tried to post my form using fetch api, and the body it sends is like:(I don't know why the number in boundary is changed every time it sends...)I would like it to send the data with "Content-Type": "application/x-www-form-urlencoded", what should I do? Or if I just have to deal with it, how do I decode the data in my controller?To whom answer my question, I know I can do it with:What I want is something like $("#form").serialize() in jQuery (w/o using jQuery) or the way to decode mulitpart/form-data in controller. Thanks for your answers though.

2017-10-09 06:27:17Z

My code:I tried to post my form using fetch api, and the body it sends is like:(I don't know why the number in boundary is changed every time it sends...)I would like it to send the data with "Content-Type": "application/x-www-form-urlencoded", what should I do? Or if I just have to deal with it, how do I decode the data in my controller?To whom answer my question, I know I can do it with:What I want is something like $("#form").serialize() in jQuery (w/o using jQuery) or the way to decode mulitpart/form-data in controller. Thanks for your answers though.To quote MDN on FormData (emphasis mine):So when using FormData you are locking yourself into multipart/form-data. There is no way to send a FormData object as the body and not sending data in the multipart/form-data format.If you want to send the data as application/x-www-form-urlencoded you will either have to specify the body as an URL-encoded string, or pass a URLSearchParams object. The latter unfortunately cannot be directly initialized from a form element. If you don’t want to iterate through your form elements yourself (which you could do using HTMLFormElement.elements), you could also create a URLSearchParams object from a FormData object:Note that you do not need to specify a Content-Type header yourself.As noted by monk-time in the comments, you can also create URLSearchParams and pass the FormData object directly, instead of appending the values in a loop:This still has some experimental support in browsers though, so make sure to test this properly before you use it.ClientDo not set the content-type header.ServerUse the FromForm attribute to specify that binding source is form data.You can set body to an instance of URLSearchParams with query string passed as argumentUse FormData and fetch to grab and send data

Javascript: How to check if a string is empty? [duplicate]

Andrew

[Javascript: How to check if a string is empty? [duplicate]](https://stackoverflow.com/questions/2381456/javascript-how-to-check-if-a-string-is-empty)

I know this is really basic, but I am new to javascript and can't find an answer anywhere.How can I check if a string is empty?

2010-03-04 17:40:39Z

I know this is really basic, but I am new to javascript and can't find an answer anywhere.How can I check if a string is empty?I check length.If you want to know if it's an empty string use === instead of ==.This is because === will only return true if the values on both sides are of the same type, in this case a string.for example:

(false == "")  will return true, and (false === "") will return false.This should work:But for a better check:

Running a command in a Grunt Task

JuanO

[Running a command in a Grunt Task](https://stackoverflow.com/questions/10456865/running-a-command-in-a-grunt-task)

I'm using Grunt (task-based command line build tool for JavaScript projects) in my project. I've created a custom tag and I am wondering if it is possible to run a command into it.To clarify, I'm trying to use Closure Templates and "the task" should call the jar file to pre-compile the Soy file to a javascript file.I'm running this jar from command line, but I want to set it as a task.

2012-05-04 22:20:37Z

I'm using Grunt (task-based command line build tool for JavaScript projects) in my project. I've created a custom tag and I am wondering if it is possible to run a command into it.To clarify, I'm trying to use Closure Templates and "the task" should call the jar file to pre-compile the Soy file to a javascript file.I'm running this jar from command line, but I want to set it as a task.Alternatively you could load in grunt plugins to help this:grunt-shell example:or grunt-exec example:Check out grunt.util.spawn:I've found a solution so I'd like to share with you.I'm using grunt under node so, to call terminal commands you need to require 'child_process' module.For example,If you are using the latest grunt version (0.4.0rc7 at the time of this writing) both grunt-exec and grunt-shell fail (they don't seem to be updated to handle the latest grunt). On the other hand, child_process's exec is async, which is a hassle.I ended up using Jake Trent's solution, and adding shelljs as a dev dependency on my project so I could just run tests easily and synchronously:Guys are pointing child_process, but try to use execSync to see output..For async shell commands working with Grunt 0.4.x use https://github.com/rma4ok/grunt-bg-shell.

Are Javascript arrays sparse?

Berry

[Are Javascript arrays sparse?](https://stackoverflow.com/questions/1510778/are-javascript-arrays-sparse)

That is, if I use the current time as an index into the array:will the interpreter instantiate all the elements from 0 to now?  Do different browsers do it differently?I remember there used to be a bug in the AIX kernel, which would create pseudo-ttys on request, but if you did, say, "echo > /dev/pty10000000000" it would create /dev/pty0, /dev/pty1, .... and then fall over dead.  It was fun at trade shows, but I don't want this to happen to my customers.

2009-10-02 17:09:09Z

That is, if I use the current time as an index into the array:will the interpreter instantiate all the elements from 0 to now?  Do different browsers do it differently?I remember there used to be a bug in the AIX kernel, which would create pseudo-ttys on request, but if you did, say, "echo > /dev/pty10000000000" it would create /dev/pty0, /dev/pty1, .... and then fall over dead.  It was fun at trade shows, but I don't want this to happen to my customers.How exactly JavaScript arrays are implemented differs from browser to browser, but they generally fall back to a sparse implementation - most likely the same one used for property access of regular objects - if using an actual array would be inefficient.You'll have to ask someone with more knowledge about specific implementations to answer what excatly triggers the shift from dense to sparse, but your example should be perfectly safe. If you want to get a dense array, you should call the constructor with an explicit length argument and hope you'll actually get one.See this answer for a more detailed description by olliej.Yes, they are. They are actually hash tables internally, so you can use not only large integers but also strings, floats, or other objects. All keys get converted to strings via toString() before being added to the hash. You can confirm this with some test code:Displays:Notice how I used for...in syntax, which only gives you the indices that are actually defined. If you use the more common for (var i = 0; i < array.length; ++i) style of iteration then you will obviously have problems with non-standard array indices.You could avoid the issue by using a javascript syntax designed for this sort of thing.  You can treat it as a dictionary, yet the "for ... in ... " syntax will let you grab them all.Javascript objects are sparse, and arrays are just specialized objects with an auto-maintained length property (which is actually one larger than the largest index, not the number of defined elements) and some additional methods.  You are safe either way; use an array if you need it's extra features, and an object otherwise.The answer, as is usually true with JavaScript, is "it's a bit wierder...."Memory usage is not defined and any implementation is allowed to be stupid.  In theory, const a = []; a[1000000]=0; could burn megabytes of memory, as could const a = [];.  In practice, even Microsoft avoids those implementations.Justin Love points out, the length attribute is the highest index set.  BUT its only updated if the index is an integer.So, the array is sparse.  BUT built-in functions like reduce(), Math.max(), and "for ... of" will walk through the entire range of possible integer indices form 0 to the length, visiting many that return 'undefined'.  BUT 'for ... in' loops might do as you expect, visiting only the defined keys.Here's an example using Node.js:giving:But.  There are more corner cases with Arrays not yet mentioned.They can be but they don't always have to be, and they can perform better when they're not.Here's a discussion about how to test for index sparseness in an array instance:

https://benmccormick.org/2018/06/19/code-golf-sparse-arrays/This code golf (fewest characters) winner is:Basically walking the array for indexed entries while decrementing the length value and returning the hardened !! boolean of the falsy/truthy numerical result (if the accumulator is decremented all the way to zero, the index is fully populated and not sparse). Charles Merriam's caveats above should be considered as well and this code doesn't address them, but they apply to hashed string entries which can happen when assigning elements with arr[var]= (something) where var wasn't an integer.On reason to care about index sparseness is its effects on performance, which can differ between script engines, there's a great discussion about array creation/.initialization here:

What’s the difference between "Array()" and "[]" while declaring a JavaScript array?A recent answer to that post has a link to this deep dive into how V8 tries to optimize arrays by tagging them to avoid (re-)testing for characteristics like sparseness: https://v8.dev/blog/elements-kinds. The blog post is from Sept '17 and the material is subject to some change, but the breakdown to implications for day-to-day development is useful and clear.Sparseness (or denseness) can be confirmed empirically for NodeJS with the non-standard process.memoryUsage().Sometimes node is clever enough to keep the array sparse:Sometimes node chooses to make it dense (this behavior might well be optimized in future):Then sparse again:So perhaps using a dense array to get a feel for the original AIX kernel bug might need to be forced with a range-alike:Because why not make it fall over?

AngularJS seed: putting JavaScript into separate files (app.js, controllers.js, directives.js, filters.js, services.js)

ChrisDevo

[AngularJS seed: putting JavaScript into separate files (app.js, controllers.js, directives.js, filters.js, services.js)](https://stackoverflow.com/questions/16771812/angularjs-seed-putting-javascript-into-separate-files-app-js-controllers-js)

I'm using the angular-seed template to structure my application. Initially I put all my JavaScript code into a single file, main.js. This file contained my module declaration, controllers, directives, filters, and services. The application works fine like this, but I'm worried about scalability and maintainability as my application becomes more complex. I noticed that the angular-seed template has separate files for each of these, so I've attempted to distribute my code from the single main.js file into each of the other files mentioned in the title to this question and found in the app/js directory of the angular-seed template.My question is: how do I manage the dependencies to get the application to work? The existing documentation found here isn't very clear in this regard since each of the examples given shows a single JavaScript source file.An example of what I have is:How do I manage the dependencies?Thanks in advance.

2013-05-27 11:06:36Z

I'm using the angular-seed template to structure my application. Initially I put all my JavaScript code into a single file, main.js. This file contained my module declaration, controllers, directives, filters, and services. The application works fine like this, but I'm worried about scalability and maintainability as my application becomes more complex. I noticed that the angular-seed template has separate files for each of these, so I've attempted to distribute my code from the single main.js file into each of the other files mentioned in the title to this question and found in the app/js directory of the angular-seed template.My question is: how do I manage the dependencies to get the application to work? The existing documentation found here isn't very clear in this regard since each of the examples given shows a single JavaScript source file.An example of what I have is:How do I manage the dependencies?Thanks in advance.The problem is caused from you "redeclaring" your application module in all your separate files.This is what the app module declaration (not sure declaration is the right term) looks like:This is what assignment (not sure if assignment is the right term either) to your application module looks like:Notice the lack of square brackets.So, the former version, one with the square brackets, should only be used once, usually in your app.js or main.js. All other associated files — controllers, directives, filters … — should use the latter version, the one without the square brackets.I hope that makes sense. Cheers!If you're wanting to put your different parts of your application (filters, services, controllers) in different physical files, there are two things you have to do:So, your app.js would look like this:And in each individual file:All of this can be combined into one call:The important part is that you shouldn't redefine angular.module('myApp'); that would cause it to be overwritten when you instantiate your controllers, probably not what you want.You get the error because you didn't define myApp.services yet. What I did so far is putting all the initial definitions in one file and then use them in another. Like for your example I would put in:app.jsThat should get rid of the error, though I think you should have a read on the article Eduard Gamonal mentioned in one of the comments.

How does this obfuscated JavaScript work?

Alexander

[How does this obfuscated JavaScript work?](https://stackoverflow.com/questions/18834309/how-does-this-obfuscated-javascript-work)

How does the following JavaScript work?I understand that it is minified code. I have tried de-obfuscating it a little, but I can't get a clear concept of how it achieves this effect.  I can see that it is using Strings for iteration of some kind, use of the Date object, strange string manipulation, Math functions, then the code prints itself. How could the same effect be rewritten with a minimal example?JSFiddle

2013-09-16 17:54:54Z

How does the following JavaScript work?I understand that it is minified code. I have tried de-obfuscating it a little, but I can't get a clear concept of how it achieves this effect.  I can see that it is using Strings for iteration of some kind, use of the Date object, strange string manipulation, Math functions, then the code prints itself. How could the same effect be rewritten with a minimal example?JSFiddleForeword: I beautified and annotated the code extensively at http://jsfiddle.net/WZXYr/2/Consider the outermost layer:A code string is stored in the variable z. The assignment operator returns the value assigned, so the code string also is passed as an argument into eval.The code string z runs inside of eval. The code is extremely obtuse, even when cleaned up, but it seems to:At the end of the code, there is a call to setTimeout(z), which asynchronously evaluates the code string z. This repeat invocation of z allows the code to loop.Simple example:Here's a super-simple version (http://jsfiddle.net/5QXn8/):Note that my final output isn't quite right -- I haven't accounted for the backslashes toward the end -- but it should still give you a pretty good idea of how the technique works generally.Here is the annotated source. Ps: I'm the author ;)Here is another manually deobfuscated version, moving all initialisation out of expression into own statements:Here is what happens:Here is an other example:(demo at jsfiddle.net)It has all the releveant things you need for this kind of animation:A string with the all the code is evaluated, and a timeout makes the loop;

The string is stored in a variable named z and in the middle of the code, between  comments /* and */there is an "Earth ASCII Art".

The code parses the comments and changes the document content, keeping the js and updating the art. Bellow is just the code sliced:

How to have multiple data-bind attributes on one element?

user960567

[How to have multiple data-bind attributes on one element?](https://stackoverflow.com/questions/10700020/how-to-have-multiple-data-bind-attributes-on-one-element)

I need to have multiple data bindings on one element. For example, I want a href as well as a html data-binding on one a tag. I have tried this,But this doesn't work. It seems knockout only supports binding one data-bind property? How to bind both the href, the inner html, and a custom "data-prop" attribute on one element?

2012-05-22 10:13:58Z

I need to have multiple data bindings on one element. For example, I want a href as well as a html data-binding on one a tag. I have tried this,But this doesn't work. It seems knockout only supports binding one data-bind property? How to bind both the href, the inner html, and a custom "data-prop" attribute on one element?Like this:You use comma-separated bindings - the attribute is the same as passing an object: Or, if you're asking about multiple attr bindings at once:This is how I implemented the source attribute and click event using data-bind. You may find it useful.I simply use:for a checkbox element.you can use multiple properties using ,   like belowobject like this 

Best practices for reducing Garbage Collector activity in Javascript

UpTheCreek

[Best practices for reducing Garbage Collector activity in Javascript](https://stackoverflow.com/questions/18364175/best-practices-for-reducing-garbage-collector-activity-in-javascript)

I have a fairly complex Javascript app, which has a main loop that is called 60 times per second.  There seems to be a lot of garbage collection going on (based on the 'sawtooth' output from the Memory timeline in the Chrome dev tools) - and this often impacts the performance of the application.So, I'm trying to research best practices for reducing the amount of work that the garbage collector has to do.  (Most of the information I've been able to find on the web regards avoiding memory leaks, which is a slightly different question - my memory is getting freed up, it's just that there's too much garbage collection going on.)  I'm assuming that this mostly comes down to reusing objects as much as possible, but of course the devil is in the details.The app is structured in 'classes' along the lines of John Resig's Simple JavaScript Inheritance.I think one issue is that some functions can be called thousands of times per second (as they are used hundreds of times during each iteration of the main loop), and perhaps the local working variables in these functions (strings, arrays, etc.) might be the issue.I'm aware of object pooling for larger/heavier objects (and we use this to a degree), but I'm looking for techniques that can be applied across the board, especially relating to functions that are called very many times in tight loops.What techniques can I use to reduce the amount of work that the garbage collector must do?And, perhaps also - what techniques can be employed to identify which objects are being garbage collected the most? (It's a farly large codebase, so comparing snapshots of the heap has not been very fruitful)

2013-08-21 17:40:47Z

I have a fairly complex Javascript app, which has a main loop that is called 60 times per second.  There seems to be a lot of garbage collection going on (based on the 'sawtooth' output from the Memory timeline in the Chrome dev tools) - and this often impacts the performance of the application.So, I'm trying to research best practices for reducing the amount of work that the garbage collector has to do.  (Most of the information I've been able to find on the web regards avoiding memory leaks, which is a slightly different question - my memory is getting freed up, it's just that there's too much garbage collection going on.)  I'm assuming that this mostly comes down to reusing objects as much as possible, but of course the devil is in the details.The app is structured in 'classes' along the lines of John Resig's Simple JavaScript Inheritance.I think one issue is that some functions can be called thousands of times per second (as they are used hundreds of times during each iteration of the main loop), and perhaps the local working variables in these functions (strings, arrays, etc.) might be the issue.I'm aware of object pooling for larger/heavier objects (and we use this to a degree), but I'm looking for techniques that can be applied across the board, especially relating to functions that are called very many times in tight loops.What techniques can I use to reduce the amount of work that the garbage collector must do?And, perhaps also - what techniques can be employed to identify which objects are being garbage collected the most? (It's a farly large codebase, so comparing snapshots of the heap has not been very fruitful)A lot of the things you need to do to minimize GC churn go against what is considered idiomatic JS in most other scenarios, so please keep in mind the context when judging the advice I give.Allocation happens in modern interpreters in several places:Avoid doing those, and pool and reuse objects where possible.Specifically, look out for opportunities to:I suggested using JSON.stringify to create outgoing network messages.  Parsing input messages using JSON.parse obviously involves allocation, and lots of it for large messages.  If you can represent your incoming messages as arrays of primitives, then you can save a lot of allocations.  The only other builtin around which you can build a parser that does not allocate is String.prototype.charCodeAt.  A parser for a complex format that only uses that is going to be hellish to read though.The Chrome developer tools have a very nice feature for tracing memory allocation.  It's called the Memory Timeline.  This article describes some details.  I suppose this is what you're talking about re the "sawtooth"?  This is normal behavior for most GC'ed runtimes.  Allocation proceeds until a usage threshold is reached triggering a collection.  Normally there are different kinds of collections at different thresholds.Garbage collections are included in the event list associated with the trace along with their duration. On my rather old notebook, ephemeral collections are occurring at about 4Mb and take 30ms.  This is 2 of your 60Hz loop iterations.  If this is an animation, 30ms collections are probably causing stutter.  You should start here to see what's going on in your environment: where the collection threshold is and how long your collections are taking. This gives you a reference point to assess optimizations. But you probably won't do better than to decrease the frequency of the stutter by slowing the allocation rate, lengthening the interval between collections. The next step is to use the Profiles | Record Heap Allocations feature to generate a catalog of allocations by record type.  This will quickly show which object types are consuming the most memory during the trace period, which is equivalent to allocation rate.  Focus on these in descending order of rate.  The techniques are not rocket science.  Avoid boxed objects when you can do with an unboxed one. Use global variables to hold and reuse single boxed objects rather than allocating fresh ones in each iteration. Pool common object types in free lists rather than abandoning them. Cache string concatenation results that are likely reusable in future iterations.  Avoid allocation just to return function results by setting variables in an enclosing scope instead.  You will have to consider each object type in its own context to find the best strategy.  If you need help with specifics, post an edit describing details of the challenge you're looking at.I advise against perverting your normal coding style throughout an application in a shotgun attempt to produce less garbage.  This is for the same reason you should not optimize for speed prematurely.  Most of your effort plus much of the added complexity and obscurity of code will be meaningless.  As a general principle you'd want to cache as much as possible and do as little creating and destroying for each run of your loop.The first thing that pops in my head is to reduce the use of anonymous functions (if you have any) inside your main loop. Also it'd be easy to fall into the trap of creating and destroying objects that are passed into other functions. I'm by no means a javascript expert, but I would imagine that this:would run much faster than this:Is there ever any downtime for your program? Maybe you need it to run smoothly for a second or two (e.g. for an animation) and then it has more time to process? If this is the case I could see taking objects that would normally be garbage collected throughout the animation and keeping a reference to them in some global object. Then when the animation ends you can clear all the references and let the garbage collector do it's work.Sorry if this is all a bit trivial compared to what you've already tried and thought of.I'd make one or few objects in the global scope (where I'm sure garbage collector is not allowed to touch them), then I'd try to refactor my solution to use those objects to get the job done, instead of using local variables.Of course it couldn't be done everywhere in the code, but generally that's my way to avoid garbage collector.P.S. It might make that specific part of code a little bit less maintainable.  

What is the fastest or most elegant way to compute a set difference using Javascript arrays?

Matt Ball

[What is the fastest or most elegant way to compute a set difference using Javascript arrays?](https://stackoverflow.com/questions/1723168/what-is-the-fastest-or-most-elegant-way-to-compute-a-set-difference-using-javasc)

Let A and B be two sets. I'm looking for really fast or elegant ways to compute the set difference (A - B or A \B, depending on your preference) between them. The two sets are stored and manipulated as Javascript arrays, as the title says.Notes:Edit: I noticed a comment about sets containing duplicate elements. When I say "set" I'm referring to the mathematical definition, which means (among other things) that they do not contain duplicate elements.

2009-11-12 15:42:39Z

Let A and B be two sets. I'm looking for really fast or elegant ways to compute the set difference (A - B or A \B, depending on your preference) between them. The two sets are stored and manipulated as Javascript arrays, as the title says.Notes:Edit: I noticed a comment about sets containing duplicate elements. When I say "set" I'm referring to the mathematical definition, which means (among other things) that they do not contain duplicate elements.if don't know if this is most effective, but perhaps the shortestUpdated to ES6:Well, 7 years later, with ES6's Set object it's quite easy (but still not as compact as python's A - B), and reportedly faster than indexOf for large arrays:You can use an object as a map to avoid linearly scanning B for each element of A as in user187291's answer:The non-standard toSource() method is used to get unique property names; if all elements already have unique string representations (as is the case with numbers), you can speed up the code by dropping the toSource() invocations.The shortest, using jQuery, is:I would hash the array B, then keep values from the array A not present in B:Incorporating the idea from Christoph and assuming a couple of non-standard iteration methods on arrays and objects/hashes (each and friends), we can get set difference, union and intersection in linear time in about 20 lines total:This assumes that each and filter are defined for arrays, and that we have two utility methods: The select() is loosely inspired by Common Lisp, and is merely filter() and map() rolled into one. (It would be better to have them defined on Object.prototype, but doing so wrecks havoc with jQuery, so I settled for static utility methods.)Performance: Testing withgives two sets with 50,000 and 66,666 elements. With these values A-B takes about 75ms, while union and intersection are about 150ms each. (Mac Safari 4.0, using Javascript Date for timing.)I think that's decent payoff for 20 lines of code.Using Underscore.js (Library for functional JS)Some simple functions, borrowing from @milan's answer:Usage: As for the fasted way, this isn't so elegant but I've run some tests to be sure.  Loading one array as an object is far faster to process in large quantities:Results:However, this works with strings only.  If you plan to compare numbered sets you'll want to map results with parseFloat.This works, but I think another one is much more shorter, and elegant too

Javascript Shorthand for getElementById

Fox Wilson

[Javascript Shorthand for getElementById](https://stackoverflow.com/questions/6398787/javascript-shorthand-for-getelementbyid)

Is there any shorthand for the JavaScript document.getElementById? Or is there any way I can define one? It gets repetitive retyping that over and over.

2011-06-18 20:42:52Z

Is there any shorthand for the JavaScript document.getElementById? Or is there any way I can define one? It gets repetitive retyping that over and over.Here I used $, but you can use any valid variable name.To save an extra character you could pollute the String prototype like this:It works in some browsers and you can access elements this way:I have chosen the name of the property almost randomly. If you actually wanted to use this shorthand I would suggest coming up with something easier to type.You can easily create shorthand easily yourself:A quick alternative to contribute:Then just do:There's a catch, it doesn't work in browsers that don't let you extend prototypes (e.g. IE6).(Shorthand for not only getting element by ID, but also getting element by class :P)I use something likeUsage : _(".test") returns all elements with class name test, and _("#blah") returns an element with id blah.id's are saved to the window.HTMLJSis the same as writing:I don't suggest using the former method as it is not common practice. There are several good answers here and several are dancing around jQuery-like syntax, but not one mentions actually using jQuery.  If you're not against trying it, check out jQuery.  It let's you select elements super easy like this.. By ID:By CSS class: By element type: There's none built-in.If you don't mind polluting the global namespace, why not:EDIT - I changed the function name to be something unusual, but short and not otherwise clashing with jQuery or anything else that uses a bare $ sign.Yes, it gets repetitive to use the same function over and over each time with a different argument:So a nice thing would be a function that takes all those arguments at the same time:Then you would have references to all your elements stored in one object:But you would still have to list all those ids.You could simplify it even more if you want all elements with ids:But it would be pretty expensive to call this function if you have many elements.So, theoretically, if you would use the with keyword you could write code like this:But I don't want to promote the use of with. Probably there's a better way to do it.Well, you could create a shorthand function, that's what I do.and then when you wanted to get it, you just doAlso, another useful trick that I found, is that if you want to get the value or innerHTML of an item ID, you can make functions like this: I actually made a kind of mini javascript library based on this whole idea.

Here it is.I frequently use:I think it's better than a external function (e.g. $() or byId()) because you can do things like this:Btw, don't use jQuery for this, jQuery is much, much slower than document.getElementById(), an external function like $() or byId(), or my method:  http://jsperf.com/document-getelementbyid-vs-jquery/5I wrote this yesterday and found it quite useful.This is how you use it.If this is on your own site, consider using a library like jQuery to give you this and many other useful shorthands that also abstract away browser differences. Personally, if I wrote enough code to be bothered by the longhand, I would include jQuery.In jQuery, the syntax would be $("#someid"). If you then want the actual DOM element and not the jQuery wrapper, it's $("#someid")[0], but you could most likely do whatever you're after with the jQuery wrapper.Or, if you're using this in a browser developer console, research their built-in utilities. As someone else mentioned, the Chrome JavaScript console includes a $("someid") method, and you can also click an element in the developer tools "Elements" view and then reference it with $0 from the console. The previously selected element becomes $1 and so on.If the only issue here is typing, maybe you should just get yourself a JavaScript editor with intellisense.If the purpose is to get shorter code, then you could consider a JavaScript library like jQuery, or you can just write your own shorthand functions, like:I used to do the above for better performance. What I learnt last year is that with compression techniques the server does it automatically for you, so my shortening technique was actually making my code heavier. Now I am just happy with typing the whole document.getElementById.If you are asking for a shorthand function... or Arrow functions make is shorter.wrap the document.querySelectorAll ... a jquery like selectWell, if the id of the element does not compete with any properties of the global object, you don't have to use any function.edit: But you don't want to make use of this 'feature'.Another wrapper:This, in case you don't want to use the unthinkable, see above.

How do I read the contents of a Node.js stream into a string variable?

obrienmd

[How do I read the contents of a Node.js stream into a string variable?](https://stackoverflow.com/questions/10623798/how-do-i-read-the-contents-of-a-node-js-stream-into-a-string-variable)

I'm hacking on a Node program that uses smtp-protocol to capture SMTP emails and act on the mail data. The library provides the mail data as a stream, and I don't know how to get that into a string.I'm currently writing it to stdout with stream.pipe(process.stdout, { end: false }), but as I said, I need the stream data in a string instead, which I can use once the stream has ended.How do I collect all the data from a Node.js stream into a string?

2012-05-16 17:42:10Z

I'm hacking on a Node program that uses smtp-protocol to capture SMTP emails and act on the mail data. The library provides the mail data as a stream, and I don't know how to get that into a string.I'm currently writing it to stdout with stream.pipe(process.stdout, { end: false }), but as I said, I need the stream data in a string instead, which I can use once the stream has ended.How do I collect all the data from a Node.js stream into a string?The key is to use the data and end events of a Readable Stream. Listen to these events:When you receive the data event, add the new chunk of data to a Buffer created to collect the data.When you receive the end event, convert the completed Buffer into a string, if necessary. Then do what you need to do with it.Another way would be to convert the stream to a promise (refer to the example below) and use then (or await) to assign the resolved value to a variable. Hope this is more useful than the above answer:Note that string concatenation is not the most efficient way to collect the string parts, but it is used for simplicity (and perhaps your code does not care about efficiency).Also, this code may produce unpredictable failures for non-ASCII text (it assumes that every character fits in a byte), but perhaps you do not care about that, either.None of the above worked for me. I needed to use the Buffer object:I'm using usually this simple function to transform a stream into a string:Usage example:From the nodejs documentation you should do this - always remember a string without knowing the encoding is just a bunch of bytes:And yet another one for strings using promises:Usage:remove the .toString() to use with binary Data if required.Streams don't have a simple .toString() function (which I understand) nor something like a .toStringAsync(cb) function (which I don't understand).So I created my own helper function:I had more luck using like that :I use node v9.11.1 and the readstream is the response from a http.get callback.The cleanest solution may be to use the "string-stream" package, which converts a stream to a string with a promise.Easy way with the popular (over 5m weekly downloads) and lightweight get-stream library:https://www.npmjs.com/package/get-streamWhat about something like a stream reducer ?Here is an example using ES6 classes how to use one.This worked for me and is based on Node v6.7.0 docs:Well done Sebastian J above.I had the "buffer problem" with a few lines of test code I had, and added the encoding information and it solved it, see below.softwareinputoutputsoftwareinputoutputAll the answers listed appear to open the Readable Stream in flowing mode which is not the default in NodeJS and can have limitations since it lacks backpressure support that NodeJS provides in Paused Readable Stream Mode. 

Here is an implementation using Just Buffers, Native Stream and Native Stream Transforms and support for Object ModeUsing the quite popular stream-buffers package which you probably already have in your project dependencies, this is pretty straightforward:In my case, the content type response headers was Content-Type: text/plain. So, I've read the data from Buffer like:

how to make twitter bootstrap submenu to open on the left side?

kovpack

[how to make twitter bootstrap submenu to open on the left side?](https://stackoverflow.com/questions/12187554/how-to-make-twitter-bootstrap-submenu-to-open-on-the-left-side)

I was trying to create twitter bootstrap submenu in dropdown menu, but I've got a problem: I have dropdown menu in the top right corner of the page and that menu has one more submenu. However, when submenu opens - it does not fit in the window and goes too much to the right, so that user can see only first letters. How to make that submenu to open not to the right, but to the left?

2012-08-29 22:48:37Z

I was trying to create twitter bootstrap submenu in dropdown menu, but I've got a problem: I have dropdown menu in the top right corner of the page and that menu has one more submenu. However, when submenu opens - it does not fit in the window and goes too much to the right, so that user can see only first letters. How to make that submenu to open not to the right, but to the left?The simplest way would be to add the pull-left class to your dropdown-submenujsfiddle: DEMOIf I've understood this right, bootstrap provides a CSS class for just this case. Add 'pull-right' to the menu 'ul':..and the end result is that the menu options appear right-aligned, in line with the button they drop down from.Curent class .dropdown-submenu > .dropdown-menu have left: 100%;. So, if you want to open submenu on the left side, override those settings to negative left position. For example left: -95%;. Now you will get submenu on the left side, and you can tweak other settings to get perfect preview.Here is DEMOEDIT: OP's question and my answer are from august 2012. Meanwhile, Bootstrap changed, so now you have .pull-left class. Back then, my answer was correct. Now you don't have to manually set css, you have that .pull-left class.EDIT 2: Demos aren't working, because Bootstrap changed their URL's. Just change external resources in jsfiddle and replace them with new ones.If you are using bootstrap v4 there is a new way to do that.You should use .dropdown-menu-right on  the .dropdown-menu element.Link to code: https://getbootstrap.com/docs/4.0/components/dropdowns/#menu-itemsThe correct way to do the task is:I have created a javascript function that looks if he has enough space on the right side.

If it has he will show it on the right side, else he will display it on the left sideTested in:Javascript:because I don't want to add this fix on every menu items I created a new class on it.

place the fixed-menu on the ul:I hope this works out for you.ps. little bug in safari and chrome, first hover will place it to mutch to the left will update this post if I fixed it.If you have only one level and you use bootstrap 3 add pull-right to the ul elementActually - if you are ok with floating the dropdown wrapper - I've found it to be as easy as to add navbar-right to the dropdown.This seems like cheating, since it's not in a navbar, but it works fine for me.You can then further customize the floating with a pull-left directly in the dropdown...... or as a wrapper around it ...If you're using LESS CSS, I wrote a little mixin to move the dropdown with the connecting arrow:Then to move a .dropdown-menu with an id of dropdown-menu-x for example, you can do:I have created a javascript function that looks if he has enough space on the right side. If it has he will show it on the right side, else he will display it on the left side. Again if it has has enough space on the right side, it will show right side. it is a loop... });Are you using the latest version of bootstrap? I have adapted the html from the Fluid Layout example as shown below. I added a drop down and placed it furthest to the right hand side by adding the pull-right class. When hovering over the drop down menu it is automatically pulled to the left and nothing is hidden - all the menu text is visible. I have not used any custom css.

removeEventListener on anonymous functions in JavaScript

bitkid

[removeEventListener on anonymous functions in JavaScript](https://stackoverflow.com/questions/4950115/removeeventlistener-on-anonymous-functions-in-javascript)

I have an object that has methods in it. These methods are put into the object inside an anonymous function. It looks like this:(there is a lot more code, but this is enough to show the problem)Now I want to stop the event listener in some cases. Therefore I am trying to do a removeEventListener but I can't figure out how to do this. I have read in other questions that it is not possible to call removeEventListener on anonymous functions, but is this also the case in this situation?I have a method in t created inside the anonymous function and therefore I thought it was possible. Looks like this:Why can't I do this?Is there any other (good) way to do this?Bonus info; this only has to work in Safari, hence the missing IE support.

2011-02-09 20:31:39Z

I have an object that has methods in it. These methods are put into the object inside an anonymous function. It looks like this:(there is a lot more code, but this is enough to show the problem)Now I want to stop the event listener in some cases. Therefore I am trying to do a removeEventListener but I can't figure out how to do this. I have read in other questions that it is not possible to call removeEventListener on anonymous functions, but is this also the case in this situation?I have a method in t created inside the anonymous function and therefore I thought it was possible. Looks like this:Why can't I do this?Is there any other (good) way to do this?Bonus info; this only has to work in Safari, hence the missing IE support.I believe that is the point of an anonymous function, it lacks a name or a way to reference it.If I were you I would just create a named function, or put it in a variable so you have a reference to it.You can then remove it byif you are inside the actual function, you can use arguments.callee as a reference to the function. as in:EDIT:

This will not work if you are working in strict mode ("use strict";)A version of Otto Nascarella's solution that works in strict mode is:May be several anonymous functions, keydown1Warning: only works in Chrome Dev Tools & cannot be used in code: linkin modern browsers you can to the following...https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener#ParametersSince receiving feedback from Andy (quite right, but as with many examples, I wished to show a contextual expansion of the idea), here's a less complicated exposition:This allows an effectively anonymous function structure, avoids the use of the practically deprecated callee, and allows easy removal.Incidentally: The removal of the script element immediately after setting the listener is a cute trick for hiding code one would prefer wasn't starkly obvious to prying eyes (would spoil the surprise ;-)So the method (more simply) is:This is not ideal as it removes all, but might work for your needs:Node.cloneNode()JavaScript: addEventListener

method registers the specified listener on the EventTarget(Element|document|Window) it's called on.EventTarget.addEventListener(event_type, handler_function, Bubbling|Capturing);Mouse, Keyboard events Example test in WebConsole:removeEventListener 

method removes the event listener previously registered with EventTarget.addEventListener().caniuseTo give a more up-to-date approach to this:I have stumbled across the same problem and this was the best solution I could get:Please keep in mind I have only tested this for the window element and for the 'mousemove' event, so there could be some problems with this approach.Possibly not the best solution in terms of what you are asking. I have still not determined an efficient method for removing anonymous function declared inline with the event listener invocation. I personally use a variable to store the <target> and declare the function outside of the event listener invocation eg:const target = document.querySelector('<identifier>');function myFunc(event) {

  function code;

}target.addEventListener('click', myFunc);Then to remove the listener:target.removeEventListener('click', myFunc);Not the top recommendation you will receive but to remove anonymous functions the only solution I have found useful is to remove then replace the HTML element. I am sure there must be a better vanilla JS method but I haven't seen it yet.I know this is a fairly old thread, but thought I might put in my two cents for those who find it useful.The script (apologies about the uncreative method names): And you can use it like so:

Remove first Item of the array (like popping from stack) [duplicate]

Raihan

[Remove first Item of the array (like popping from stack) [duplicate]](https://stackoverflow.com/questions/29605929/remove-first-item-of-the-array-like-popping-from-stack)

I have list of items created via ng-repeat. I also have Delete button.

Clicking delete button removes last item of the array one by one. PlunkerBut I want to remove items one by one starting from the first item. How can I do that? I used this for removing list Items:Is there any way I can remove from the top? 

2015-04-13 12:57:25Z

I have list of items created via ng-repeat. I also have Delete button.

Clicking delete button removes last item of the array one by one. PlunkerBut I want to remove items one by one starting from the first item. How can I do that? I used this for removing list Items:Is there any way I can remove from the top? The easiest way is using shift(). If you have an array, the shift function shifts everything to the left.Just use arr.slice(startingIndex, endingIndex).If you do not specify the endingIndex, it returns all the items starting from the index provided.In your case arr=arr.slice(1).PlunkerMade changes to .. now it will remove from the topThere is a function called shift().

It will remove the first element of your array.There is some good documentation and examples.

How to set selected value of jquery select2?

ClearBoth

[How to set selected value of jquery select2?](https://stackoverflow.com/questions/25187926/how-to-set-selected-value-of-jquery-select2)

This belong to codes prior to select2 version 4I have a simple code of select2 that get data from ajaxThis code is working, however, I need to set a value on it as if in edit mode. When user select a value first time, it will be saved and when he needs to edit that value it must appear in the same select menu (select2) to select the value previously selected but I can't find a way. UPDATE:The HTML code:Select2 programmatic access does not work with this.

2014-08-07 16:45:52Z

This belong to codes prior to select2 version 4I have a simple code of select2 that get data from ajaxThis code is working, however, I need to set a value on it as if in edit mode. When user select a value first time, it will be saved and when he needs to edit that value it must appear in the same select menu (select2) to select the value previously selected but I can't find a way. UPDATE:The HTML code:Select2 programmatic access does not work with this.To dynamically set the "selected" value of a Select2 component:Where the second parameter is an object with expected values.UPDATE:This does work, just wanted to note that in the new select2, "a_key" is "text" in a standard select2 object. so: {id: 100, text: 'Lorem Ipsum'} Example: Thanks to @NoobishProIf you use select2 without AJAX you can do as follow:You can also do so:For select2 v4 you can append directly an option/s as follow:Or with JQuery:other exampleHtml:JavaScript:jsfiddleAlso as I tried, when use ajax in select2, the programmatic control methods for set new values in select2 does not work for me!

Now I write these code for resolve the problem:You can test complete sample code in here link: https://jsfiddle.net/NabiKAZ/2g1qq26v/32/

In this sample code there is a ajax select2 and you can set new value with a button.Try this append then select. Doesn't duplicate the option upon AJAX call.In the current version on select2 -  v4.0.1 you can set the value like this:I did like this-For Ajax, use $(".select2").val("").trigger("change"). That should solve the problem.I think you need the initSelection function HTMLJSsource: https://select2.github.io/options.htmlIn Select2 V.4use   $('selector').select2().val(value_to_select).trigger('change');I think it should workI solved my problem with this simple code. Where #select_location_id is an ID of select box and value is value of an option listed in select2 box.An Phan's answer worked for me:But adding the change trigger the eventyou can use this code :where 2 in "number:2" and 3 in "number:3" are id field in object arraySet the value and trigger the change event immediately.I did something like this to preset elements in select2 ajax dropdownYou should use:If you are using an Input box, you must set the "multiple" property with its value as "true". For example,In select2 < version4 there is the option initSelection() for remote data loading, through which it is possible to set initial value for the input as in edit mode.Source Documentation : Select2 - 3.5.3Sometimes, select2() will be loading firstly, and that makes the control not to show previously selected value correctly. Putting a delay for some seconds can resolve this problem.Just to add to anyone else who may have come up with the same issue with me.I was trying to set the selected option of my dynamically loaded options (from AJAX) and was trying to set one of the options as selected depending on some logic.My issue came because I wasn't trying to set the selected option based on the ID which needs to match the value, not the value matching the name!For multiple values something like this:which will translate to something like thisThis may help someone loading select2 data from AJAX while loading data for editing (applicable for single or multi-select): During my form/model load  :Call to select data for Select2:and if you may be having issues with encoding you may change as your requirement:if you are getting your values from ajax, before calling confirm that the ajax call has completed, using the jquery function whenYou can use this code:Put your desired value instead of PakistanHope It will work :)Nice and easy:And you change id_city to your select's id.Edit: After Glen's comment I realize I should explain why and how it worked for me:I had made select2 working really nice for my form. The only thing I couldn't make work was to show the current selected value when editing. It was searching a third party API, saving new and editing old records. After a while I realized I didn't need to set the value correctly, only the label inside field, because if the user doesn't change the field, nothing happens. After searching and looking to a lot of people having trouble with it, I decided make it with pure Javascript. It worked and I posted to maybe help someone. I also suggest to set a timer for it.

jQuery: Select data attributes that aren't empty?

Shpigford

[jQuery: Select data attributes that aren't empty?](https://stackoverflow.com/questions/10641258/jquery-select-data-attributes-that-arent-empty)

I'm trying to select all elements that have a data-go-to attribute that is not empty.I've tried $('[data-go-to!=""]') but oddly enough it seems to be selecting every single element on the page if I do that.

2012-05-17 18:15:26Z

I'm trying to select all elements that have a data-go-to attribute that is not empty.I've tried $('[data-go-to!=""]') but oddly enough it seems to be selecting every single element on the page if I do that.tryUPDATE:For the sake of not leading anyone astray, this answer will work in older versions of jQuery but is not future-proof.  Since @gmo and @siva's answers both seem to be working with later versions I defer to (and encourage you to upvote) their answers....and of course hope you have a fantastic day.Just as further reference, and an up-to-date (may'14) (aug'15) (sep'16) (apr'17) (mar'18)...

Answer that works with:  PS: more combinations are possible...* Snippet is running jQuery v2.1.1I'm not sure about a simple selector, but you could use filter():JS Fiddle demo.References:Has 'data-attributename' and its value is not empty: Has 'data-attributename' empty or not:JS Fiddle exampleAccording to the documentation 

this should do it:not([attr="value"])DEMOHope this helpsJSBIN Using :not, .not(), :empty etc will only check if the element itself is empty, not the data attribute. For that you will have to filter based on the data attributes value.FIDDLEThis works for meTry this :This works for me:

How to mock localStorage in JavaScript unit tests?

Anthony Sottile

[How to mock localStorage in JavaScript unit tests?](https://stackoverflow.com/questions/11485420/how-to-mock-localstorage-in-javascript-unit-tests)

Are there any libraries out there to mock localStorage?I've been using Sinon.JS for most of my other javascript mocking and have found it is really great.My initial testing shows that localStorage refuses to be assignable in firefox (sadface) so I'll probably need some sort of hack around this :/My options as of now (as I see) are as follows:What do you think of these approaches and do you think there are any other better ways to go about this?  Either way I'll put the resulting "library" that I end up making on github for open source goodness.

2012-07-14 16:24:45Z

Are there any libraries out there to mock localStorage?I've been using Sinon.JS for most of my other javascript mocking and have found it is really great.My initial testing shows that localStorage refuses to be assignable in firefox (sadface) so I'll probably need some sort of hack around this :/My options as of now (as I see) are as follows:What do you think of these approaches and do you think there are any other better ways to go about this?  Either way I'll put the resulting "library" that I end up making on github for open source goodness.Here is a simple way to mock it with Jasmine:If you want to mock the local storage in all your tests, declare the beforeEach() function shown above in the global scope of your tests (the usual place is a specHelper.js script).just mock the global localStorage / sessionStorage (they have the same API) for your needs.

For example:And then what you actually do, is something like that:Also consider the option to inject dependencies in an object's constructor function.In line with mocking and unit testing, I like to avoid testing the storage implementation. For instance no point in checking if length of storage increased after you set an item, etc. Since it is obviously unreliable to replace methods on the real localStorage object, use a "dumb" mockStorage and stub the individual methods as desired, such as:This is what I do...The current solutions will not work in Firefox. This is because localStorage is defined by the html spec as being not modifiable. You can however get around this by accessing localStorage's prototype directly.The cross browser solution is to mock the objects on Storage.prototype e.g.instead of spyOn(localStorage, 'setItem') use taken from bzbarsky and  teogeos's replies here https://github.com/jasmine/jasmine/issues/299I just wrote one:Only in global context. With a wrapper function as above, it works just fine.Here is an exemple using sinon spy and mock:Overwriting the localStorage property of the global window object as suggested in some of the answers won't work in most JS engines, because they declare the localStorage data property as not writable and not configurable.However I found out that at least with PhantomJS's (version 1.9.8) WebKit version you could use the legacy API __defineGetter__ to control what happens if localStorage is accessed. Still it would be interesting if this works in other browsers as well.The benefit of this approach is that you would not have to modify the code you're about to test.You don't have to pass the storage object to each method that uses it. Instead, you can use a configuration parameter for any module that touches the storage adapter.Your old moduleYour new module with config "wrapper" functionWhen you use the module in testing codeThe MockStorage class might look like thisWhen using your module in production code, instead pass the real localStorage adapterI decided to reiterate my comment to Pumbaa80's answer as separate answer so that it'll be easier to reuse it as a library.I took Pumbaa80's code, refined it a bit, added tests and published it as an npm module here:

https://www.npmjs.com/package/mock-local-storage.Here is a source code:

https://github.com/letsrock-today/mock-local-storage/blob/master/src/mock-localstorage.jsSome tests:

https://github.com/letsrock-today/mock-local-storage/blob/master/test/mock-localstorage.jsModule creates mock localStorage and sessionStorage on the global object (window or global, which of them is defined).In my other project's tests I required it with mocha as this: mocha -r mock-local-storage to make global definitions available for all code under test.Basically, code looks like follows:Note that all methods added via Object.defineProperty so that them won't be iterated, accessed or removed as regular items and won't count in length. Also I added a way to register callback which is called when an item is about to be put into object. This callback may be used to emulate quota exceeded error in tests.I found that I did not need to mock it. I could change the actual local storage to the state I wanted it via setItem, then just query the values to see if it changed via getItem. It's not quite as powerful as mocking as you can't see how many times something was changed, but it worked for my purposes.Unfortunately, the only way we can mock the localStorage object in a test scenario is to change the code we're testing.  You have to wrap your code in an anonymous function (which you should be doing anyway) and use "dependency injection" to pass in a reference to the window object.  Something like:Then, inside of your test, you can specify:This is how I like to do it. Keeps it simple.

Check if character is number?

lisovaccaro

[Check if character is number?](https://stackoverflow.com/questions/8935632/check-if-character-is-number)

I need to check whether justPrices[i].substr(commapos+2,1).The string is something like: "blabla,120"In this case it would check whether '0' is a number. How can this be done?

2012-01-20 01:12:54Z

I need to check whether justPrices[i].substr(commapos+2,1).The string is something like: "blabla,120"In this case it would check whether '0' is a number. How can this be done?You could use comparison operators to see if it is in the range of digit characters:you can either use parseInt and than check with isNaNor if you want to work directly on your string you can use regexp like this:EDIT: Blender's updated answer is the right answer here if you're just checking a single character (namely !isNaN(parseInt(c, 10))). My answer below is a good solution if you want to test whole strings.Here is jQuery's isNumeric implementation (in pure JavaScript), which works against full strings:The comment for this function reads:I think we can trust that these chaps have spent quite a bit of time on this!  Commented source here. Super geek discussion here.I wonder why nobody has posted a solution like:with an invocation like:You can use this:Here, I compared it to the accepted method: http://jsperf.com/isdigittest/5 . I didn't expect much, so I was pretty suprised, when I found out that accepted method was much slower. Interesting thing is, that while accepted method is faster correct input (eg. '5') and slower for incorrect (eg. 'a'), my method is exact opposite (fast for incorrect and slower for correct).Still, in worst case, my method is 2 times faster than accepted solution for correct input and over 5 times faster for incorrect input.I think it's very fun to come up with ways to solve this. Below are some.

(All functions below assume argument is a single character. Change to n[0] to enforce it)Simple functionIf you are testing single characters, then:will return true or false depending on whether c is a digit or not.I suggest a simple regex.If you're looking for just the last character in the string:And the regex is even simpler if you are just checking a single char as an input:The shortest solution is: You can apply these as well:if you want to check more than 1 chatacter, you might use next variantsRegular Expression:Comparison:Check if it is not NaNoutput without strict mode:output with strict mode:Try:This seems to work:Static binding:Prototype binding:It will check single characters, as well as whole strings to see if they are numeric.SourceSource codeYou can try this (worked in my case)If you want to test if the first char of a string is an int:If you want to test if the char is a int:A simple solution by leveraging language's dynamic type checking:see test cases belowThis function works for all test cases that i could find.

It's also faster than:As far as I know, easiest way is just to multiply by 1:Multiplication by one makes a number from any numeric string (as you have only one character it will always be an integer from 0 to 9) and a NaN for any other string.Similar to one of the answers above, I usedThis blogpost sheds some more light on this check if a string is numeric in Javascript | Typescript & ES6 Just use isFinite

How to create a toggle button in Bootstrap

Megan Sime

[How to create a toggle button in Bootstrap](https://stackoverflow.com/questions/13511368/how-to-create-a-toggle-button-in-bootstrap)

I originally created a web app in HTML, CSS and JavaScript, then was asked to create it again in Bootstrap too. I've done it all fine, but I had toggle buttons in the web app that have changed back to radio (originally checkbox) buttons instead of the toggle buttons I had originally.The code for the buttons is:and the JavaScript and CSS files that the HTML page is linked to are:Is there a way to change the code so I can get the toggle button back?

2012-11-22 11:05:41Z

I originally created a web app in HTML, CSS and JavaScript, then was asked to create it again in Bootstrap too. I've done it all fine, but I had toggle buttons in the web app that have changed back to radio (originally checkbox) buttons instead of the toggle buttons I had originally.The code for the buttons is:and the JavaScript and CSS files that the HTML page is linked to are:Is there a way to change the code so I can get the toggle button back?An excellent (unofficial) Bootstrap Switch is available. It uses radio types or checkboxes as switches. A type attribute has been added since V.1.8.Source code is available on Github.I would not recommend to use those kind of old Switch buttons now, as they always seemed to suffer of usability issues as pointed by many people. Please consider having a look at modern Switches like this one from the React Component framework (not Bootstrap related, but can be integrated in Bootstrap grid and UI though).Other implementations exist for Angular, View or jQuery.If you don't mind changing your HTML, you can use the data-toggle attribute on <button>s. See the Single toggle section of the button examples:Bootstrap 3 has options to create toggle buttons based on checkboxes or radio buttons: http://getbootstrap.com/javascript/#buttonsCheckboxesRadio buttonsFor these to work you must initialize .btns with Bootstrap's Javascript:I've been trying to activate 'active' class manually with javascript. It's not as usable as a complete library, but for easy cases seems to be enough:If you think carefully, 'active' class is used by bootstrap when the button is being pressed, not before or after that (our case), so there's no conflict in reuse the same class.Try this example and tell me if it fails: http://jsbin.com/oYoSALI/1/edit?html,js,outputIf you want to keep a small code base, and you are only going to be needing the toggle button for a small part of the application. I would suggest instead maintain you're javascript code your self (angularjs, javascript, jquery) and just use plain CSS.Good toggle button generator: https://proto.io/freebies/onoff/Here this very usefull For Bootstrap Toggle Button . Example in code snippet!! and jsfiddle below.Update 2020 For Bootstrap 4I recommended bootstrap4-toggle in 2020.You can use the CSS Toggle Switch library. Just include the CSS and program the JS yourself:

http://ghinda.net/css-toggle-switch/bootstrap.htmlYou can use the Material Design Switch for Bootstrap 3.3.0 http://bootsnipp.com/snippets/featured/material-design-switchBootstrap 4 solutionbootstrap 4 ships built-in toggle. Here is the documentation.

https://getbootstrap.com/docs/4.3/components/forms/#switchesIn case someone is still looking for a nice switch/toggle button, I followed Rick's suggestion and created a simple angular directive around it, angular-switch. Besides preferring a Windows styled switch, the total download is also much smaller (2kb vs 23kb minified css+js) compared to angular-bootstrap-switch and bootstrap-switch mentioned above together. You would use it as follows. First include the required js and css file: And enable it in your angular app:Now you are ready to use it as follows: 

How to iterate object in JavaScript? [duplicate]

Piyush

[How to iterate object in JavaScript? [duplicate]](https://stackoverflow.com/questions/15496508/how-to-iterate-object-in-javascript)

I have this object. I want to iterate this object in JavaScript. How is this possible?

2013-03-19 10:08:02Z

I have this object. I want to iterate this object in JavaScript. How is this possible?You can do it with the below code. You first get the data array using dictionary.data and assign it to the data variable. After that you can iterate it using a normal for loop. Each row will be a row object in the array.You can follow similar approach to iterate the image array. There's this way too (new to EcmaScript5):Same approach for imagesSomething like that:Use dot notation and/or bracket notation to access object properties and for loops to iterate arrays:You can also iterate arrays using for..in loops; however, properties added to Array.prototype may show through, and you may not necessarily get array elements in their correct order, or even in any consistent order.Using a generator function you could iterate over deep key-values. Using for and foreach loop  Here's all the options you have:

setInterval in a React app

Jose

[setInterval in a React app](https://stackoverflow.com/questions/36299174/setinterval-in-a-react-app)

I'm still fairly new at React, but I've been grinding along slowly and I've encountered something I'm stuck on. I am trying to build a "timer" component in React, and to be honest I don't know if I'm doing this right (or efficiently). In my code below, I set the state to return an object { currentCount: 10 } and have been toying with componentDidMount, componentWillUnmount, and render and I can only get the state to "count down" from 10 to 9. Two-part question: What am I getting wrong? And, is there a more efficient way of going about using setTimeout (rather than using componentDidMount & componentWillUnmount)?Thank you in advance.

2016-03-30 03:34:03Z

I'm still fairly new at React, but I've been grinding along slowly and I've encountered something I'm stuck on. I am trying to build a "timer" component in React, and to be honest I don't know if I'm doing this right (or efficiently). In my code below, I set the state to return an object { currentCount: 10 } and have been toying with componentDidMount, componentWillUnmount, and render and I can only get the state to "count down" from 10 to 9. Two-part question: What am I getting wrong? And, is there a more efficient way of going about using setTimeout (rather than using componentDidMount & componentWillUnmount)?Thank you in advance.I see 4 issues with your code:Let's try to fix that:This would result in a timer that decreases from 10 to -N. If you want timer that decreases to 0, you can use slightly modified version:Updated 10-second countdown using class Clock extends ComponentUpdated 10-second countdown using Hooks (a new feature proposal that lets you use state and other React features without writing a class. They’re currently in React v16.7.0-alpha).Thanks @dotnetom, @greg-herbowiczIf it returns "this.state is undefined" - bind timer function:

How can I get the timezone name in JavaScript?

Mike Thomsen

[How can I get the timezone name in JavaScript?](https://stackoverflow.com/questions/9772955/how-can-i-get-the-timezone-name-in-javascript)

I know how to get the timezone offset, but what I need is the ability to detect something like "America/New York." Is that even possible from JavaScript or is that something I am going to have to guestimate based on the offset?

2012-03-19 15:27:04Z

I know how to get the timezone offset, but what I need is the ability to detect something like "America/New York." Is that even possible from JavaScript or is that something I am going to have to guestimate based on the offset?The Internationalization API supports getting the user timezone, and is supported in all current browsers.Keep in mind that on some older browser versions that support the Internationalization API, the timeZone property is set to undefined rather than the user’s timezone string. As best as I can tell, at the time of writing (July 2017) all current browsers except for IE11 will return the user timezone as a string.You can use this script. 

http://pellepim.bitbucket.org/jstz/Fork or clone repository here.

https://bitbucket.org/pellepim/jstimezonedetectOnce you include the script, you can get the list of timezones in -  jstz.olson.timezones variable. And following code is used to determine client browser's timezone.Enjoy jstz!Most upvoted answer is probably the best way to get the timezone, however, Intl.DateTimeFormat().resolvedOptions().timeZone returns IANA timezone name by definition, which is in English.If you want the timezone's name in current user's language, you can parse it from Date's string representation like so:Tested in Chrome and Firefox.Ofcourse, this will not work as intended in some of the environments. For example, node.js returns a GMT offset (e.g. GMT+07:00) instead of a name. But I think it's still readable as a fallback.P.S. Won't work in IE11, just as the Intl... solution.You can simply write your own code by using the mapping table here:

http://www.timeanddate.com/time/zones/or, use moment-timezone library:

http://momentjs.com/timezone/docs/See zone.name; // America/Los_Angelesor, this library:

https://github.com/Canop/tzdetect.jsTry this code refer from hereRetrieve timezone by name (i.e. "America/New York")In javascript , the Date.getTimezoneOffset() method returns the time-zone offset from UTC, in minutes, for the current locale.Moment'timezone will be a useful tool.

http://momentjs.com/timezone/Convert Dates Between Timezones

How to post an array of complex objects with JSON, jQuery to ASP.NET MVC Controller?

JSC

[How to post an array of complex objects with JSON, jQuery to ASP.NET MVC Controller?](https://stackoverflow.com/questions/320291/how-to-post-an-array-of-complex-objects-with-json-jquery-to-asp-net-mvc-control)

My current code looks like the following. How can I pass my array to the controller and what kind of parameters must my controller action accept?My controller action method looks like

2008-11-26 10:56:35Z

