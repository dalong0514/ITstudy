Description

This is a quick reference for the jQuery library. See Chapter 19 for complete details on the library and for examples of its use. This reference page is organized and formatted somewhat differently than the other pages in this reference section. It uses the following conventions in the method signatures. Arguments named sel are jQuery selectors. Arguments named idx are integer indexes. Arguments named elt or elts are document elements or array-like objects of document elements. Arguments named f are callback functions and nested parentheses are used to indicate the arguments that jQuery will pass to the function you supply. Square brackets indicate optional arguments. If an optional argument is followed by an equals sign and a value, that value will be used when the argument is omitted. The return value of a function or a method follows the close parenthesis and a colon. Methods with no return value specified return the jQuery object on which they are invoked.

jQuery Factory Function

The jQuery function is a namespace for a variety of utility functions, but it is also the factory function for creating jQuery objects. jQuery() can be invoked in all of the ways shown below, but it always returns a jQuery object that represents a collection of document elements (or the Document object itself). The symbol $ is an alias for jQuery, and you can use $() instead of jQuery() in each of the forms following:

jQuery(sel [, context=document])

Returns a new jQuery object that represents the document elements that are descendants of context and match the selector string sel.

jQuery(elts)

Returns a new jQuery object that represents the specified elements. elts may be a single document element or an array or array-like object (such as a NodeList or another jQuery object) of document elements.

jQuery(html, [props])

Parses html as a string of HTML-formatted text and returns a new jQuery object that contains the one or more top-level elements in the string. If html describes a single HTML tag, props may be an object that specifies HTML attributes and event handlers for the newly created element.

jQuery(f)

Registers f as a function to be invoked when the document has loaded and is ready to be manipulated. If the document is already ready, f is invoked immediately as a method of the document object. Returns a jQuery object that contains only the document object.

jQuery Selector Grammar

The jQuery selector grammar is very similar to the CSS3 selector grammar, and it is explained in detail in jQuery Selectors. The following is a summary:

Simple tag, class and ID selectors

* tagname .classname #id

Selector Combinations

A B B as a descendant of A A > B B as a child of A A + B B as a sibling following A A ~ B B as a sibling of A

Attribute Filters

[attr] has attribute [attr=val] has attribute with value val [attr!=val] does not have attribute with value val [attr^=val] attribute begins with val [attr$=val] attribute ends with val [attr*=val] attribute includes val [attr~=val] attribute includes val as a word [attr|=val] attribute begins with val and optional hyphen

Element Type Filters

:button :header :password :submit :checkbox :image :radio :text :file :input :reset

Element State Filters

:animated :disabled :hidden :visible :checked :enabled :selected

Selection Position Filters

:eq(n) :first :last :nth(n) :even :gt(n) :lt(n) :odd

Document Position Filters

:first-child :nth-child(n) :last-child :nth-child(even) :only-child :nth-child(odd) :nth-child(xn+y)

Miscellaneous Filters

:contains(text) :not(selector) :empty :parent :has(selector)

Basic jQuery Methods and Properties

These are the basic methods and properties of jQuery objects. They don’t alter the selection or the selected elements in any way, but they allow you to query and iterate over the set of selected elements. See Queries and Query Results for details.

context

The context, or root element, under which the selection was made. This is the second argument to $() or the Document object.

each(f(idx,elt))

Invoke f once as a method of each selected element. Stops iterating if the function returns false. Returns the jQuery object on which it was invoked.

get(idx):elt

get():array

Return the selected element at the specified index in the jQuery object. You can also use regular square-bracket array indexing. With no arguments, get() is a synonym for toArray().

index():int

index(sel):int

index(elt):int

With no argument, return the index of the first selected element among its siblings. With a selector argument, return the index of the first selected element within the set of elements that match the selector sel, or -1 if it is not found. With an element argument, return the index of elt in the selected elements, or -1 if it is not found.

is(sel):boolean

Return true if at least one of the selected elements also matches sel.

length

The number of selected elements.

map(f(idx,elt)):jQuery

Invoke f once as a method of each selected element and return a new jQuery object that holds the returned values, with null and undefined values omitted and array values flattened.

selector

The selector string originally passed to $().

size():int

Return the value of the length property.

toArray():array

Return a true array of the selected elements.

jQuery Selection Methods

The methods described in this section alter the set of selected elements, by filtering them, adding new elements, or using the selected elements as starting points for new selections. In jQuery 1.4 and later, jQuery selections are always sorted in document order and do not contain duplicates. See Selection Methods.

add(sel, [context])

add(elts)

add(html)

The arguments to add() are passed to $(), and the resulting selection is merged with the current selection.

andSelf()

Add the previously selected set of elements (from the stack) to the selection.

children([sel])

Select children of the selected elements. With no argument, select all children. With a selector, select only matching children.

closest(sel, [context])

Select the closest ancestor of each selected element that matches sel and is a descendant of context. If context is omitted, the context property of the jQuery object is used.

contents()

Select all children of each selected element, including text nodes and comments.

end()

Pop the internal stack restoring the selection to the state it was in before the last selection-altering method.

eq(idx)

Select only the selected element with the specified index. In jQuery 1.4, negative indexes count from the end.

filter(sel)

filter(elts)

filter(f(idx):boolean)

Filter the selection so it only includes elements that also match the selector sel, that are included in the array-like object elts, or for which the predicate f returns true when invoked as a method of the element.

find(sel)

Select all descendants of any selected element that match sel.

first()

Select only the first selected element.

has(sel)

has(elt)

Filter the selection to include only those selected elements that have a descendant that matches sel or that are ancestors of elt.

last()

Select only the last selected element.

next([sel])

Select the next sibling of each selected element. If sel is specified, exclude those that do not match.

nextAll([sel])

Select all of the siblings following each selected element. If sel is specified, exclude those that do not match.

nextUntil(sel)

Select the siblings following each selected element up to (but not including) the first sibling that matches sel.

not(sel)

not(elts)

not(f(idx):boolean)

This is the opposite of filter(). It filters the selection to exclude elements that match sel, that are included in elts, or for which f returns true. elts may be a single element or an array-like object of elements. f is invoked as a method of each selected element.

offsetParent()

Select the nearest positioned ancestor of each selected element.

parent([sel])

Select the parent of each selected element. If sel is specified, exclude any that do not match.

parents([sel])

Select the ancestors of each selected element. If sel is specified, exclude any that do not match.

parentsUntil(sel)

Select the ancestors of each selected element up to (but not including) the first one that matches sel.

prev([sel])

Select the previous sibling of each selected element. If sel is specified, exclude those that do not match.

prevAll([sel])

Select all of the siblings before each selected element. If sel is specified, exclude those that do not match.

prevUntil(sel)

Select the siblings preceding each selected element up to (but not including) the first sibling that matches sel.

pushStack(elts)

Push the current state of the selection so that it can be restored with end(), and then select the elements in the elts array (or array-like object).

siblings([sel])

Select the siblings of each selected element, excluding the element itself. If sel is specified, exclude any siblings that do not match.

slice(startidx, [endidx])

Filter the selection to include only elements with an index greater than or equal to startidx and less than (but not equal to) endidx. Negative indexes count backward from the end of the selection. If endidx is omitted, the length property is used.

jQuery Element Methods

The methods described here query and set the HTML attributes and CSS style properties of elements. Setter callback functions with an argument named current are passed the current value of whatever it is they are computing a new value for. See jQuery Getters and Setters.

addClass(names)

addClass(f(idx,current):names)

Add the specified CSS class name or names to the class attribute of each selected element. Or invoke f as a method of each element to compute the class name or names to add.

attr(name):value

attr(name, value)

attr(name, f(idx,current):value)

attr(obj)

With one string argument, return the value of the named attribute for the first selected element. With two arguments, set the named attribute of all selected elements to the specified value or invoke f as a method of each element to compute a value. With a single object argument, use property names as attribute names and property values as attribute values or attribute computing functions.

css(name):value

css(name, value)

css(name, f(idx,current):value)

css(obj)

Like attr(), but query or set CSS style attributes instead of HTML attributes.

data():obj

data(key):value

data(key, value)

data(obj)

With no arguments, return the data object for the first selected element. With one string argument, return the value of the named property of that data object. With two arguments, set the named property of the data object of all selected elements to the specified value. With one object argument, replace the data object of all selected elements.

hasClass(name):boolean

Returns true if any of the selected elements includes name in its class attribute.

height():int

height(h)

height(f(idx,current):int)

Return the height (not including padding, border, or margin) of the first selected element, or set the height of all selected elements to h or to the value computed by invoking f as a method of each element.

innerHeight():int

Return the height plus padding of the first selected element.

innerWidth():int

Return the width plus padding of the first selected element.

offset():coords

offset(coords)

offset(f(idx,current):coords)

Return the X and Y position (in document coordinates) of the first selected element, or set the position of all selected elements to coords or to the value computed by invoking f as a method of each element. Coordinates are specified as objects with top and left properties.

offsetParent():jQuery

Select the nearest positioned ancestor of each selected element and return them in a new jQuery object.

outerHeight([margins=false]):int

Return the height plus the padding and border, and, if margins is true, the margins of the first selected element.

outerWidth([margins=false]):int

Return the width plus the padding and border, and, if margins is true, the margins of the first selected element.

position():coords

Return the position of the first selected element relative to its nearest positioned ancestor. The return value is an object with top and left properties.

removeAttr(name)

Remove the named attribute from all selected elements.

removeClass(names)

removeClass(f(idx,current):names)

Remove the specified name or names from the class attribute of all selected elements. If a function is passed instead of a string, invoke it as a method of each element to compute the name or names to be removed.

removeData([key])

Removed the named property from the data object of each selected element. If no property name is specified, remove the entire data object instead.

scrollLeft():int

scrollLeft(int)

Return the horizontal scrollbar position of the first selected element or set it for all selected elements.

scrollTop():int

scrollTop(int)

Return the vertical scrollbar position of the first selected element or set it for all selected elements.

toggleClass(names, [add])

toggleClass(f(idx,current):names, [add])

Toggle the specified class name or names in the class property of each selected element. If f is specified, invoke it as a method of each selected element to compute the name or names to be toggled. If add is true or false, add or remove the class names rather than toggling them.

val():value

val(value)

val(f(idx,current)):value

Return the form value or selection state of the first selected element, or set the value or selection state of all selected elements to value or to the value computed by invoking f as a method of each element.

width():int

width(w)

width(f(idx,current):int)

Return the width (not including padding, border, or margin) of the first selected element, or set the width of all selected elements to w or to the value computed by invoking f as a method of each element.

jQuery Insertion and Deletion Methods

The methods described here insert, delete, and replace document content. In the method signatures below, the content argument may be a jQuery object, a string of HTML, or an individual document element, and the target argument may be a jQuery object, an individual document element, or a selector string. See Getting and Setting Element Content and Altering Document Structure for further details.

after(content)

after(f(idx):content)

Insert content after each selected element, or invoke f as a method of, and insert its return value after, each selected element.

append(content)

append(f(idx,html):content)

Append content to each selected element, or invoke f as a method of, and append its return value to, each selected element.

appendTo(target):jQuery

Append the selected elements to the end of each specified target element, cloning them as necessary if there is more than one target.

before(content)

before(f(idx):content)

Like after(), but make insertions before the selected elements instead of after them.

clone([data=false]):jQuery

Make a deep copy of each of the selected elements and return a new jQuery object representing the cloned elements. If data is true, also clone the data (including event handlers) associated with the selected elements.

detach([sel])

Like remove(), but does not delete any data associated with the detached elements.

empty()

Delete the content of all selected elements.

html():string

html(htmlText)

html(f(idx,current):htmlText)

With no arguments, return the content of the first selected element as an HTML-formatted string. With one argument, set the content of all selected elements to the specified htmlText or to the value returned by invoking f as a method of those elements.

insertAfter(target):jQuery

Insert the selected elements after each target element, cloning them as necessary if there is more than one target.

insertBefore(target):jQuery

Insert the selected elements before each target element, cloning them as necessary if there is more than one target.

prepend(content)

prepend(f(idx,html):content)

Like append(), but insert content at the beginning of each selected element instead of at the end.

prependTo(target):jQuery

Like appendTo(), except that the selected elements are inserted at the beginning of the target elements instead of at the end.

remove([sel])

Remove all selected elements or all selected elements that also match sel, from the document, removing any data (including event handlers) associated with them. Note that the removed elements are no longer part of the document, but are still members of the returned jQuery object.

replaceAll(target)

Insert the selected elements into the document so that they replace each target element, cloning the selected elements as needed if there is more than one target.

replaceWith(content)

replaceWith(f(idx,html):content)

Replace each selected element with content, or invoke f as a method of each selected element, passing the element index and current HTML content, and then replace that element with the return value.

text():string

text(plainText)

text(f(idx,current):plainText)

With no arguments, return the content of the first selected element as a plain-text string. With one argument, set the content of all selected elements to the specified plainText or to the value returned by invoking f as a method of those elements.

unwrap()

Remove the parent of each selected element, replacing it with the selected element and its siblings.

wrap(wrapper)

wrap(f(idx):wrapper)

Wrap wrapper around each selected element, cloning as needed if there is more than one selected element. If a function is passed, invoke it as a method of each selected element to compute the wrapper. The wrapper may be an element, a jQuery object, a selector, or a string of HTML, but it must have a single innermost element.

wrapAll(wrapper)

Wrap wrapper around the selected elements as a group by inserting wrapper at the location of the first selected element and then copying all selected elements into the innermost element of wrapper.

wrapInner(wrapper)

wrapInner(f(idx):wrapper)

Like wrap(), but inserts wrapper (or the return value of f) around the content of each selected element rather than around the elements themselves.

jQuery Event Methods

The methods in this section are for registering event handlers and triggering events. See Handling Events with jQuery.

event-type()

event-type(f(event))

Register f as a handler for event-type, or trigger an event of event-type. jQuery defines the following convenience methods that follow this pattern:

ajaxComplete() blur() focusin() mousedown() mouseup() ajaxError() change() focusout() mouseenter() resize() ajaxSend() click() keydown() mouseleave() scroll() ajaxStart() dblclick() keypress() mousemove() select() ajaxStop() error() keyup() mouseout() submit() ajaxSuccess() focus() load() mouseover() unload()

bind(type, [data], f(event))

bind(events)

Register f as a handler for events of the specified type on each of the selected elements. If data is specified, add it to the event object before invoking f. type may specify multiple event types and may include namespaces.

If a single object is passed, treat it as a mapping of event types to handler functions, and register handlers for all the specified events on each selected element.

delegate(sel, type, [data], f(event))

Register f as a live event handler. f will be triggered when events of type type occur on an element matching sel and bubble up to any of the selected elements. If data is specified, it will be added to the event object before f is invoked.

die(type, [f(event)])

Deregister live event handlers registered with live() for events of type type on elements that match the selector string of the current selection. If a specific event handler function f is specified, only deregister that one.

hover(f(event))

hover(enter(event), leave(event))

Register event handlers for「mouseenter」and「mouseleave」events on all selected elements. If only one function is specified, it is used as the handler for both events.

live(type, [data], f(event))

Register f as a live event handler for events of type type. If data is specified, add it to the event object before invoking f. This method does not use the set of selected elements, but it does use the selector string and context object of the jQuery object. f will be triggered when type events bubble up to the context object (usually the document) and the event’s target element matches the selector. See delegate().

one(type, [data], f(event))

one(events)

Like bind(), except that the registered event handlers are automatically deregistered after they are invoked once.

ready(f())

Register f to be invoked when the document becomes ready, or invoke it immediately if the document is ready. This method does not use the selected elements and is a synonym for $(f).

toggle(f1(event), f2(event),...)

Register an「click」event handler on all selected elements that alternates (or toggles) among the specified handler functions.

trigger(type, [params])

trigger(event)

Trigger a type event on all selected elements, passing params as extra parameters to event handlers. params may be omitted, or may be a single value or an array of values. If you pass an event object, its type property specifies the event type, and any other properties are copied into the event object that is passed to the handlers.

triggerHandler(type, [params])

Like trigger(), but do not allow the triggered event to bubble or to trigger the browser’s default action.

unbind([type],[f(event)])

With no arguments, deregister all jQuery event handlers on all selected elements. With one argument, deregister all event handlers for the type events on all selected elements. With two arguments, deregister f as a handler for type events on all selected elements. type may name multiple event types and may include namespaces.

undelegate()

undelegate(sel, type, [f(event)])

With no arguments, deregister all live event handlers delegated from the selected elements. With two arguments, deregister live event handlers for type events on elements matching sel that are delegated from the selected elements. With three arguments, only deregister the single handler f.

jQuery Effects and Animation Methods

The methods described here produce visual effects and custom animations. Most return the jQuery object on which they are called. See Animated Effects.

Animation options

complete duration easing queue specialEasing step

jQuery.fx.off

Set this property to true to disable all effects and animations.

animate(props, opts)

Animate the CSS properties specified by the props object on each selected element, using the options specified by opts. See Custom Animations for details of both objects.

animate(props, [duration], [easing], [f()])

Animate the CSS properties specified by props on each selected element, using the specified duration and easing function. Invoke f as a method of each selected element when done.

clearQueue([qname="fx"])

Clear the effects queue or the named queue for each selected element.

delay(duration, [qname="fx"])

Add a delay of the specified duration to the effects queue or the named queue.

dequeue([qname="fx"])

Remove and invoke the next function on the effects queue or the named queue. It is not normally necessary to dequeue the effects queue.

fadeIn([duration=400],[f()])

fadeOut([duration=400],[f()])

Fade the selected elements in or out by animating their opacity for duration ms. When complete, invoke f, if specified, as a method of each selected element.

fadeTo(duration, opacity, [f()])

Animate the CSS opacity of the selected elements to opacity over the specified duration. When complete, invoke f, if specified, as a method of each selected element.

hide()

hide(duration, [f()])

With no arguments, hide each selected element immediately. Otherwise, animate the size and opacity of each selected element so that they are hidden after duration ms. When complete, invoke f, if specified, as a method of each selected element.

slideDown([duration=400],[f()])

slideUp([duration=400],[f()])

slideToggle([duration=400],[f()])

Show, hide, or toggle the visibility of each selected element by animating its height for the specified duration. When complete, invoke f, if specified, as a method of each selected element.

show()

show(duration, [f()])

With no arguments, show each selected element immediately. Otherwise, animate the size and opacity of each selected element so that they are fully visible after duration ms. When complete, invoke f, if specified, as a method of each selected element.

stop([clear=false], [jump=false])

Stop the current animation (if one is running) on all selected elements. If clear is true, also clear the effects queue for each element. If jump is true, jump the animation to its final value before stopping it.

toggle([show])

toggle(duration, [f()])

If show is true, show() the selected elements immediately. If show is false, hide() the selected elements immediately. If show is omitted, toggle the visibility of the elements.

If duration is specified, toggle the visibility of the selected elements with a size and opacity animation of the specified length. When complete, invoke f, if specified, as a method of each selected element.

queue([qname="fx"]):array

queue([qname="fx"], f(next))

queue([qname="fx"], newq)

With no arguments or just a queue name, return the named queue of the first selected element. With a function argument, add f to the named queue of all selected elements. With an array argument, replace the named queue of all selected elements with the newq array of functions.

jQuery Ajax Functions

Most of the jQuery Ajax-related functionality takes the form of utility functions rather than methods. These are some of the most complicated functions in the jQuery library. See Ajax with jQuery for complete details.

Ajax status codes

success error notmodified timeout parsererror

Ajax Data Types

text html xml script json jsonp

Ajax Events

ajaxStart ajaxSend ajaxSuccess ajaxError ajaxComplete ajaxStop

Ajax Options

async context global processData type beforeSend data ifModified scriptCharset url cache dataFilter jsonp success username complete dataType jsonpCallback timeout xhr contentType error password traditional

jQuery.ajax(options):XMLHttpRequest

This is the complicated but fully general Ajax function on which all of jQuery’s Ajax utilities are based. It expects a single object argument whose properties specify all details of the Ajax request and the handling of the server’s response. The most common options are described in Common Options and callback options are covered in Callbacks.

jQuery.ajaxSetup(options)

This function sets default values for jQuery’s Ajax options. Pass the same kind of options object you would pass to jQuery.ajax(). The values you specify will be used by any subsequent Ajax request that does not specify the value itself. This function has no return value.

jQuery.getJSON(url, [data], [f(object,status)]):XMLHttpRequest

Asynchronously request the specified url, adding any data that is specified. When the response is received, parse it as JSON, and pass the resulting object to the callback function f. Return the XMLHttpRequest object, if any, used for the request.

jQuery.getScript(url, [f(text,status)]):XMLHttpRequest

Asynchronously request the specified url. When the response arrives, execute it as a script, and then pass the response text to f. Return the XMLHttpRequest object, if any, used for the request. Cross-domain is allowed, but do not pass the script text to f, and do not return an XMLHttpRequest object.

jQuery.get(url, [data], [f(data,status,xhr)], [type]):XMLHttpRequest

Make an asynchronous HTTP GET request for url, adding data, if any, to the query parameter portion of that URL. When the response arrives, interpret it as data of the specified type, or according to the Content-Type header of the response, and execute it or parse it if necessary. Finally, pass the (possibly parsed) response data to the callback f along with the jQuery status code and the XMLHttpRequest object used for the request. That XMLHttpRequest object, if any, is also the return value of jQuery.get().

jQuery.post(url, [data], [f(data,status,xhr)], [type]):XMLHttpRequest

Like jQuery.get(), but make an HTTP POST request instead of a GET request.

jQuery.param(o, [old=false]):string

Serialize the names and values of the properties of o in www-form-urlencoded form, suitable for adding to a URL or passing as the body of an HTTP POST request. Most jQuery Ajax functions will do this automatically for you if you pass an object as the data parameter. Pass true as the second argument if you want jQuery 1.3–style shallow serialization.

jQuery.parseJSON(text):object

Parse JSON-formatted text and return the resulting object. jQuery’s Ajax functions use this function internally when you request JSON-encoded data.

load(url, [data], [f(text,status,xhr)])

Asynchronously request the url, adding any data that is specified. When the response arrives, interpret it as a string of HTML and insert it into each selected element, replacing any existing content. Finally, invoke f as a method of each selected element, passing the response text, the jQuery status code, and the XMLHttpRequest object used for the request.

If url includes a space, any text after the space is used as a selector, and only the portions of the response document that match that selector are inserted into the selected elements.

Unlike most jQuery Ajax utilities, load() is a method, not a function. Like most jQuery methods, it returns the jQuery object on which it was invoked.

serialize():string

Serialize the names and values of the selected forms and form elements, returning a string in www-form-urlencoded format.

jQuery Utility Functions

These are miscellaneous jQuery functions and properties (not methods). See Utility Functions for more details.

jQuery.boxModel

A deprecated synonym for jQuery.support.boxModel.

jQuery.browser

This property refers to an object that identifies the browser vendor and version. The object has the property msie for Internet Explorer, mozilla for Firefox, webkit for Safari and Chrome, and opera for Opera. The version property is the browser version number.

jQuery.contains(a,b):boolean

Returns true if document element a contains element b.

jQuery.data(elt):data

jQuery.data(elt, key):value

jQuery.data(elt, data)

jQuery.data(elt, key, value)

A low-level version of the data() method. With one element argument, return the data object for that element. With an element and a string, return the named value from that element’s data object. With an element and an object, set the data object for the element. With an element, string, and value, set the named value in the element’s data object.

jQuery.dequeue(elt, [qname="fx"])

Remove and invoke the first function in the named queue of the specified element. Same as $(elt).dequeue(qname).

jQuery.each(o, f(name,value)):o

jQuery.each(a, f(index,value)):a

Invoke f once for each property of o, passing the name and value of the property and invoking f as a method of the value. If the first argument is an array, or array-like object, invoke f as a method of each element in the array, passing the array index and element value as arguments. Iteration stops if f returns false. This function returns its first argument.

jQuery.error(msg)

Throw an exception containing msg. You can call this function from plug-ins or override (e.g. jQuery.error = alert) it when debugging.

jQuery.extend(obj):object

jQuery.extend([deep=false], target, obj...):object

With one argument, copy the properties of obj into the global jQuery namespace. With two or more arguments, copy the properties of the second and subsequent objects, in order, into the target object. If the optional deep argument is true, a deep copy is done and properties are copied recursively. The return value is the object that was extended.

jQuery.globalEval(code):void

Execute the specified JavaScript code as if it were a top-level <script>. No return value.

jQuery.grep(a, f(elt,idx):boolean, [invert=false]):array

Return a new array that contains only the elements of a for which f returns true. Or, if invert is true, return only those elements for which f returns false.

jQuery.inArray(v, a):integer

Search the array or array-like object a for an element v, and return the index at which it is found or -1.

jQuery.isArray(x):boolean

Return true only if x is a true JavaScript array.

jQuery.isEmptyObject(x):boolean

Return true only if x has no enumerable properties.

jQuery.isFunction(x):boolean

Return true only if x is a JavaScript function.

jQuery.isPlainObject(x):boolean

Return true only if x is a plain JavaScript object, such as one created by an object literal.

jQuery.isXMLDoc(x):true

Return true only if x is an XML document or an element of an XML document.

jQuery.makeArray(a):array

Return a new JavaScript array that contains the same elements as the array-like object a.

jQuery.map(a, f(elt, idx)):array

Return a new array that contains the values returned by f when invoked for each element in the array (or array-like object) a. Return values of null are ignored and returned arrays are flattened.

jQuery.merge(a,b):array

Append the elements of the array b to a, and return a. The arguments may be array-like objects or true arrays.

jQuery.noConflict([radical=false])

Restore the symbol $ to its value before the jQuery library was loaded and return jQuery. If radical is true, also restore the value of the jQuery symbol.

jQuery.proxy(f, o):function

jQuery.proxy(o, name):function

Return a function that invokes f as a method of o, or a function that invokes o[name] as a method of o.

jQuery.queue(elt, [qname="fx"], [f])

Query or set the named queue of elt, or add a new function f to that queue. Same as $(elt).queue(qname, f) .

jQuery.removeData(elt, [name]):void

Remove the named property from the data object of elt or remove the data object itself.

