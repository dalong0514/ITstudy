<form> Form <style> Style

<iframe> IFrame <td> TableCell

<img> Image <tr> TableRow

<input> Input <tbody>, <tfoot>, <thead> TableSection

<label> Label <table> Table

<a>, <area>, <link> Link <textarea> TextArea

<meter> Meter <video> Video

<option> Option

The HTML elements that do not have reference pages of their own are those whose only properties simply mirror the HTML attributes of the element. The following attributes are legal on any HTML element, and are therefore properties of all Element objects:

AttributeDescription

accessKey keyboard shortcut

class CSS class: see the className and classList properties above.

contentEditable Whether element content is editable.

contextMenu The ID of a <menu> element to display as a context menu. Supported only by IE at the time of this writing.

dir Text direction:「ltr」or「rtl」.

draggable A boolean attribute set on elements that are drag sources for the Drag-and-Drop API.

dropzone An attribute set on elements that are drop targets for the Drag-and-Drop API.

hidden A boolean attribute set on elements that should not be displayed.

id A unique identifier for the element.

lang The primary language of the text in the element.

spellcheck Whether element text should have spelling checked.

style Inline CSS styles for the element. See the style property above.

tabIndex Specifies the focus order of the element.

title Tooltip text for the element.

The following HTML elements define no attributes other than the global attributes above:

<abbr> <code> <footer> <hr> <rt> <sup>

<address> <datalist> <h1> <i> <ruby> <tbody>

<article> <dd> <h2> <kbd> <s> <tfoot>

<aside> <dfn> <h3> <legend> <samp> <thead>

<b> <div> <h4> <mark> <section> <title>

<bdi> <dl> <h5> <nav> <small> <tr>

<bdo> <dt> <h6> <noscript> <span> <ul>

<br> <em> <head> <p> <strong> <var>

<caption> <figcaption> <header> <pre> <sub> <wbr>

<cite> <figure> <hgroup> <rp> <summary>

The remaining HTML elements, and the attributes they support, are listed below. Note that this table only lists attributes other than the global attributes described above. Also note that this table includes elements that also have their own reference page:

ElementAttributes

<a> href, target, ping, rel, media, hreflang, type

<area> alt, coords, shape, href, target, ping, rel, media, hreflang, type

<audio> src, preload, autoplay, loop, controls

<base> href, target

<blockquote> cite

<body> onafterprint, onbeforeprint, onbeforeunload, onblur, onerror, onfocus, onhashchange, onload, onmessage, onoffline, ononline, onpagehide, onpageshow, onpopstate, onredo, onresize, onscroll, onstorage, onundo, onunload

<button> autofocus, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, name, type, value

<canvas> width, height

<col> span

<colgroup> span

<command> type, label, icon, disabled, checked, radiogroup

<del> cite, datetime

<details> open

<embed> src, type, width, height,

<fieldset> disabled, form, name

<form> accept-charset, action, autocomplete, enctype, method, name, novalidate, target

<html> manifest

<iframe> src, srcdoc, name, sandbox, seamless, width, height

<img> alt, src, usemap, ismap, width, height

<input> accept, alt, autocomplete, autofocus, checked, dirname, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, height, list, max, maxlength, min, multiple, name, pattern, placeholder, readonly, required, size, src, step, type, value, width

<ins> cite, datetime

<keygen> autofocus, challenge, disabled, form, keytype, name

<label> form, for

<li> value

<link> href, rel, media, hreflang, type, sizes

<map> name

<menu> type, label

<meta> name, http-equiv, content, charset

<meter> value, min, max, low, high, optimum, form

<object> data, type, name, usemap, form, width, height

<ol> reversed, start

<optgroup> disabled, label

<option> disabled, label, selected, value

<output> for, form, name

<param> name, value

<progress> value, max, form

<q> cite

<script> src, async, defer, type, charset

<select> autofocus, disabled, form, multiple, name, required, size

<source> src, type, media

<style> media, type, scoped

<table> summary

<td> colspan, rowspan, headers

<textarea> autofocus, cols, disabled, form, maxlength, name, placeholder, readonly, required, rows, wrap

<th> colspan, rowspan, headers, scope

<time> datetime, pubdate

<track> default, kind, label, src, srclang

<video> src, poster, preload, autoplay, loop, controls, width, height

Name

ErrorEvent — an uncaught exception from a worker thread

Inherits from

Event

Synopsis

When an uncaught exception occurs in a Worker thread, and the exception is not handled by the onerror function in the WorkerGlobalScope, that exception causes a nonbubbling error event to be triggered on the Worker object. The event has an ErrorEvent object associated with it to provide details about the exception that occurred. Calling preventDefault() on the ErrorEvent object (or returning false from the event handler) will prevent the error from propagating further to containing threads and may also prevent it from being displayed in an error console.

Properties

readonly string filename

The URL of the JavaScript file in which the exception was originally thrown.

readonly unsigned long lineno

The line number within that file at which the exception was thrown.

readonly string message

A message describing the exception.

Name

Event — details for standard events, IE events and jQuery events

Synopsis

When an event handler is invoked, it is passed an Event object whose properties give details about the event, such as the type of event and the element on which it occurred. The methods of this Event object can control the propagation of the event. All modern browsers implement a standard event model, except IE, which, in version 8 and before, defines its own incompatible model. This page documents the standard event object properties and methods and the IE alternatives to them, and also covers the jQuery event object, which emulates a standard event object for IE. Read more about events in Chapter 17 and more about jQuery events in Handling Events with jQuery.

In the standard event model, different kinds of events have different kinds of event objects associated with them: mouse events have a MouseEvent object with mouse-related properties, for example, and keyboard events have a KeyEvent with key-related properties. Both the MouseEvent and KeyEvent types share a common Event superclass. In the IE and jQuery event models, however, a single Event object type is used for all events that can occur on Element objects. Event properties that are specific to keyboard events won’t have a useful value when a mouse event occurs, but those properties will still be defined. For simplicity, this page collapses the event hierarchy and documents the properties for all events that can be delivered to Element objects (and that then bubble up to the Document and Window objects).

Originally, almost all client-side JavaScript events were triggered on document elements, and it is therefore natural to lump the properties of document-related event objects together like this. But HTML5 and related standards introduce a number of new event types that are triggered on objects that are not document elements. These event types often have Event types of their own, and those types are covered on their own reference pages. See BeforeUnloadEvent, CloseEvent, ErrorEvent, HashChangeEvent, MessageEvent, PageTransitionEvent, PopStateEvent, ProgressEvent, and StorageEvent.

Most of those event object types extend Event. Other new HTML5-related event types do not define an event object type of their own—the object associated with those events is just an ordinary Event object. This page documents that「ordinary」Event object plus the properties of some of its subtypes. The properties marked with an asterisk in the list below are the ones that are defined by the Event type itself. These are the properties that are inherited by event types like MessageEvent and are the properties that are defined for simple, ordinary events like the load event of the Window object and the playing event of a MediaElement object.

Constants

These constants define the values of the eventPhase property. That property, and these constants, are not supported in the IE event model.

unsigned short CAPTURING_PHASE = 1

The event is being dispatched to capturing event handlers registered on ancestors of its target.

unsigned short AT_TARGET = 2

The event is being dispatched at its target.

unsigned short BUBBLING_PHASE = 3

The event is bubbling and is being dispatched on ancestors of its target.

Properties

The properties listed here are defined by the standard event model for Event objects and also for the event objects associated with mouse and key events. Properties from the IE and jQuery event models are also listed. Properties with an asterisk are defined directly by Event and are universally available on any standard Event object, regardless of the event type.

readonly boolean altKey

Whether the Alt key was held down when the event occurred. Defined for mouse and key events and also by IE events.

readonly boolean bubbles*

true if the event is of a type that bubbles (unless stopPropagation() is called); false otherwise. Not defined by IE events.

readonly unsigned short button

Which mouse button changed state during a mousedown, mouseup, or click event. A value of 0 indicates the left button, a value of 2 indicates the right button, and a value of 1 indicates the middle mouse button. Note that this property is defined when a button changes state; it is not used to report whether a button is held down during a mousemove event, for example. Also, this property is not a bitmap: it cannot tell you if more than one button is held down. Finally, some browsers only generate events for left button clicks.

IE events define an incompatible button property. In that browser, this property is a bit mask: the 1 bit is set if the left button was pressed, the 2 bit is set if the right button was pressed, and the 4 bit is set if the middle button (of a three-button mouse) was pressed. jQuery does not emulate the standard button property in IE, but see the which property instead.

readonly boolean cancelable*

true if the default action associated with the event can be canceled with prevent Default() ; false otherwise. Defined by all standard event types, but not by IE events.

boolean cancelBubble

In the IE event model, if an event handler wants to stop an event from being propagated up to containing objects, it must set this property to true. Use the stopPropagation() method for standard events.

readonly integer charCode

For keypress events, this property is the Unicode encoding of the printable character that was generated. This property is 0 for nonprinting function keys and is not used for keydown and keyup events. Use String.fromCharCode() to convert this value to a string. Most browsers set keyCode to the same value as this property for keypress events. In Firefox, however, keyCode is undefined for keypress events and you must use charCode. This property is nonstandard and is not defined in IE events or emulated by jQuery.

readonly long clientX

readonly long clientY

The X and Y coordinates of the mouse pointer relative to the client area, or browser window. Note that these coordinates do not take document scrolling into account; if an event occurs at the very top of the window, clientY is 0 regardless of how far down the document has been scrolled. These properties are defined for all types of mouse events. These properties are defined for IE events as well as standard events. See also pageX and pageY.

readonly boolean ctrlKey

Whether the Ctrl key was held down when the event occurred. Defined for mouse and key events and also by IE events.

readonly EventTarget currentTarget*

The Element, Document, or Window that is currently handling this event. During capturing and bubbling, this is different from target. Not defined by IE events but emulated by jQuery events.

readonly DataTransfer dataTransfer

For drag-and-drop events, this property specifies the DataTransfer object that coordinates the entire drag-and-drop operation. Drag-and-drop events are a kind of mouse event; any event that has this property set will also have clientX, clientY, and other mouse event properties. The drag-and-drop events are dragstart; drag and drag end on the drag source; and dragenter, dragover, dragleave, and drop on the drop target. See DataTransfer and Drag and Drop Events for details on drag-and-drop operations.

readonly boolean defaultPrevented*

true if defaultPrevented() has been called on this event or false otherwise. This is a new addition to the standard event model and may not be implemented in all browsers. (jQuery events define an isDefaultPrevented() method that works like this property.)

readonly long detail

A numeric detail about the event. For click, mousedown, and mouseup events, this field is the click count: 1 for a single-click, 2 for a double-click, 3 for a triple-click, and so on. In Firefox, DOMMouseScroll events use this property to report mousewheel scroll amounts.

readonly unsigned short eventPhase*

The current phase of event propagation. The value is one of the three constants defined above. Not supported by IE events.

readonly boolean isTrusted*

true if this event was created and dispatched by the browser or false if it is a synthetic event that was created and dispatched by JavaScript code. This is a relatively new addition to the standard event model and may not be implemented by all browsers.

readonly Element fromElement

For mouseover and mouseout events in IE, fromElement refers to the object from which the mouse pointer is moving. For standard events, use the relatedTarget property.

readonly integer keyCode

The virtual keycode of the key that was pressed. This property is used for all types of keyboard events. Keycodes may be browser-, OS-, and keyboard-hardware-dependent. Typically, when a key displays a printing character on it, the virtual keycode for that key is the same as the encoding of the character. Key codes for nonprinting function keys may vary more, but see Example 17-8 for a set of commonly used codes. This property has not been standardized but is defined by all browsers, including IE.

readonly boolean metaKey

Whether the Meta key was held down when the event occurred. Defined for mouse and key events and also by IE events.

readonly integer offsetX, offsetY

For IE events, these properties specify the coordinates at which the event occurred within the coordinate system of the event’s source element (see srcElement). Standard events have no equivalent properties.

readonly integer pageX, pageY

These nonstandard, but widely supported, properties are like clientX and clientY, but use document coordinates rather than window coordinates. IE events do not define these properties, but jQuery emulates them for all browsers.

readonly EventTarget relatedTarget*

Refers to an event target (usually a document element) that is related to the target node of the event. For mouseover events, it is the element the mouse left when it moved over the target. For mouseout events, it is the element the mouse entered when leaving the target. This property is not defined by IE events but is emulated by jQuery events. See the IE properties fromElement and toElement.

boolean returnValue

For IE events, set this property to false to cancel the default action of the source element on which the event occurred. For standard events, use the preventDefault() method instead.

readonly long screenX, screenY

For mouse events, these properties specify the X and Y coordinates of the mouse pointer relative to the upper left corner of the user’s monitor. These properties are not generally useful but are defined for all types of mouse events and are supported by standard events and IE events.

readonly boolean shiftKey

Whether the Shift key was held down when the event occurred. Defined for mouse and key events and also by IE events.

readonly EventTarget srcElement

For IE events, this property specifies the object on which the event was triggered. For standard events, use target instead.

readonly EventTarget target*

The target object for this event—i.e., the object on which the event was triggered. (All objects that can be event targets implement the methods of EventTarget.) This property is not defined for IE events, but it is emulated by jQuery events. See srcElement.

readonly unsigned long timeStamp*

A number that specifies the date and time at which the event occurred or that can at least be used to determine the order in which two events occurred. Many browsers return a timestamp that you can pass to the Date() constructor. In Firefox 4 and before, however, this property is some other kind of timestamp, such as the number of milliseconds since the computer was booted. IE events do not support it. jQuery sets this property to a timestamp in the format returned by Date.getTime().

Element toElement

For mouseover and mouseout events in IE, toElement refers to the object into which the mouse pointer is moving. For standard events, use relatedTarget instead.

readonly string type*

The name of the event that this Event object represents. This is the name under which the event handler was registered or the name of the event-handler property with the leading「on」removed—for example,「click」,「load」, or「submit」. This property is defined by standard events and IE events.

readonly Window view

The window (called a「view」for historical reasons) in which the event was generated. This property is defined for all standard user-interface events, such as mouse and keyboard events. It is not supported in IE events.

readonly integer wheelDelta

For mousewheel events, this property specifies the amount of scrolling that has occurred in the Y axis. Different browsers set different values on this property: see Mousewheel Events for details. This is a nonstandard property but is supported by all browsers, including IE8 and before.

readonly integer wheelDeltaX

readonly integer wheelDeltaY

For mousewheel events in browsers that support two-dimensional mouse wheels, these properties specify the amount of scrolling in the X and Y dimensions. See Mousewheel Events for an explanation of how to interpret these properties. If wheelDeltaY is defined, it will have the same value as the wheelDelta property.

readonly integer which

This nonstandard legacy property is supported by browsers other than IE and is emulated in jQuery. For mouse events, it is one more than the button property: 1 means the left button, 2 means the middle button, and 3 means the right button. For key events, it has the same value as keyCode.

Methods

All of these methods are defined by the Event class itself, so they are each available on any standard Event object.

void initEvent(string type, boolean bubbles, boolean cancelable)

This method initializes the type, bubbles, and cancelable properties of an Event object. Create a new event object by passing the string「Event」to the createEvent() method of Document. Then, after initializing it with this method, dispatch it on any EventTarget by passing it to the dispatchEvent() method of that target. The other standard event properties (besides type, bubbles, and cancelable) will be initialized by the dispatch. If you want to create, initialize, and dispatch a more complicated synthetic event, you’ll have to pass a different argument (such as「MouseEvent」) to createEvent() and then initialize the event object with a type-specific initializing function such as initMouseEvent() (not documented in this book).

void preventDefault()

Tells the web browser not to perform the default action associated with this event, if there is one. If the event is not of a type that is cancelable, this method has no effect. This method is not defined on IE event objects, but is emulated by jQuery. In the IE event model, set the returnValue property to false instead.

void stopImmediatePropagation()

Like stopPropagation(), but in addition, prevent the invocation of any other handlers registered on the same document element. This method is a new addition to the standard event model and may not be implemented in all browsers. It is not supported in the IE event model but is emulated by jQuery.

void stopPropagation()

Stops the event from propagating any further through the capturing, target, or bubbling phases of event propagation. After this method is called, any other event handlers for the same event on the same node are called, but the event is not dispatched to any other nodes. This method is not supported in the IE event model, but it is emulated by jQuery. In IE, set cancelBubble to true instead of calling stopPropagation().

Proposed Properties

The properties listed here are proposed by the current draft of the DOM Level 3 Events specification. They address key areas of incompatibility among today’s browsers but are not yet (at the time of this writing) implemented by any browsers. If implemented interoperably they will make it much easier to write portable code to handle text input events, key events, and mouse events.

readonly unsigned short buttons

This property is like IE’s version of the button property described above.

readonly string char

For keyboard events, this property holds the character string (which may have more than one character) generated by the event.

readonly string data

For textinput events, this property specifies the text that was input.

readonly unsigned long deltaMode

For wheel events, this property specifies the appropriate interpretation of the deltaX, deltaY, and deltaZ properties. The value of this property will be one of these constants: DOM_DELTA_PIXEL, DOM_DELTA_LINE, DOM_DELTA_PAGE. The value of this property is determined in a platform-dependent way. It may depend on system preferences or on keyboard modifiers held down during the wheel event.

readonly long deltaX, deltaY, deltaZ

For wheel events, these properties specify how much the mousewheel rotated around each of its three possible axes.

readonly unsigned long inputMethod

For textinput events, this property specifies how the text was input. The value will be one of these constants: DOM_INPUT_METHOD_UNKNOWN, DOM_INPUT_METHOD_KEYBOARD, DOM_INPUT_METHOD_PASTE, DOM_INPUT_METHOD_DROP, DOM_INPUT_METHOD_IME, DOM_INPUT_METHOD_OPTION, DOM_INPUT_METHOD_HANDWRITING, DOM_INPUT_METHOD_VOICE, DOM_INPUT_METHOD_MULTIMODAL, DOM_INPUT_METHOD_SCRIPT.

readonly string key

For keyboard events that generate characters, this property has the same value as char. If the keyboard event did not generate characters, this property holds the name of the key (such as「Tab」or「Down」) that was pressed.

readonly string locale

For keyboard events and textinput events, this property specifies a language code (such as「en-GB」) that identifies the locale for which the keyboard was configured, if that information is known.

readonly unsigned long location

For keyboard events, this property specifies the keyboard location of the key that was pressed. The value will be one of these constants: DOM_KEY_LOCATION_STANDARD, DOM_KEY_LOCATION_LEFT, DOM_KEY_LOCATION_RIGHT, DOM_KEY_LOCATION_NUMPAD, DOM_KEY_LOCATION_MOBILE, DOM_KEY_LOCATION_JOYSTICK.

readonly boolean repeat

For keyboard events, this property will be true if the event was caused because a key was held down long enough to begin repeating.

Proposed Method

Like the Proposed Properties listed above, the method listed here has been proposed in a draft standard but not yet implemented by any browsers.

boolean getModifierState(string modifier)

For mouse and keyboard events, this method returns true if the specified modifier key was held down when the event occurred, or false otherwise. modifier may be one of the strings「Alt」,「AltGraph」,「CapsLock」,「Control」,「Fn」,「Meta」,「NumLock」,「Scroll」,「Shift」,「SymbolLock」, and「Win」.

Name

EventSource — a Comet connection to an HTTP server

Inherits from

EventTarget

Synopsis

An EventSource represents a long-lived HTTP connection through which a Web server can「push」textual messages. To use these「Server Sent Events」, pass the server URL to the EventSource() constructor and then register a message event handler on the resulting Event Source object.

Server Sent Events are new, and at the time of this writing, are not supported in all browsers.

Constructor

new EventSource(string url)

Creates a new EventSource object connected to the web server at the specified url. url is interpreted relative to the URL of the containing document.

Constants

These constants define the possible values of the readyState property.

unsigned short CONNECTING = 0

The connection is being set up, or the connection closed and the EventSource is re-connecting.

unsigned short OPEN = 1

The connection is open and events are being dispatched.

unsigned short CLOSED = 2

The connection was closed, either because close() was called or a fatal error occurred and it is not possible to reconnect.

Properties

readonly unsigned short readyState

The state of the connection. The constants above define the possible values.

readonly string url

The absolute URL to which the EventSource is connected.

Methods

void close()

This method closes the connection. Once this method is called, the EventSource object can no longer be used. If you need to connect again, create a new EventSource.

Event Handlers

Network communication is asynchronous, so EventSource triggers events when the connection opens, when an error occurs, and when messages arrive from the server. You can register event handlers on the properties listed here, or you can use the methods of EventTarget instead. EventSource events are all dispatched on the EventSource object itself. They do not bubble and have no default action that can be canceled.

onerror

Triggered when an error occurs. The associated event object is a simple Event.

onmessage

Triggered when a message arrives from the server. The associated event object is an MessageEvent, and the text of the server’s message is available through the data property of that object.

onopen

Triggered when the connection opens. The associated event object is a simple Event.

Name

EventTarget — an object that receives events

Synopsis

Objects that have events fired on them or objects to which events bubble need to have a way to define handlers for those events. These objects typically define event handler registration properties whose names begin with「on」, and they also typically define the methods described here. Event handler registration is a surprisingly complex topic. See Registering Event Handlers for details, and note, in particular, that IE8 and before use different methods, described in a special section following, than all other browsers do.

Methods

void addEventListener(string type, function listener, [boolean useCapture])

This method registers the specified listener function as an event handler for events of the specified type. type is an event name string and does not include an「on」prefix. The use Capture argument should be true if this is a capturing event handler (see addEventListener()) being registered on a document ancestor of the true event target. Note that some browsers still require you to pass a third argument to this function, and you must pass false to register an ordinary noncapturing handler.

boolean dispatchEvent(Event event)

This method dispatches a synthetic event to this event target. Create a new Event object with document.createEvent(), passing the event name (such as「event」for simple events). Next, call the event initialization method for the Event object you created: for a simple event, this will be initEvent() (see Event). Next, pass the initialized event to this method to dispatch it. In modern browsers, every Event object has an isTrusted property. That property will be false for any synthetic event dispatched by JavaScript.

Every kind of event object defines a type-specific initialization method. Those methods are infrequently used, have long and cumbersome argument lists, and are not documented in this book. If you need to create, initialize, and dispatch synthetic events of some type more complex than a basic Event, you’ll have to look up the initialization method online.

void removeEventListener(string type, function listener, [boolean useCapture])

This method removes a registered event listener function. It takes the same arguments as addEventListener().

Internet Explorer Methods

IE8 and before do not support addEventListener() and removeEventListener(). Instead, they implement these two methods, which are quite similar. (attachEvent() lists a few important differences.)

void attachEvent(string type, function listener)

Register the specified listener function as an event handler for events of the specified type. Note that this method expects type to include the prefix「on」before the event name.

void detachEvent(string type, function listener)

This method works like attachEvent() in reverse.

Name

FieldSet — a <fieldset> in an HTML form

Inherits from

Node, Element, FormControl

Synopsis

The FieldSet object represents a <fieldset> in an HTML <form>. FieldSets implement most, but not all, of the properties and methods of FormControl.

Properties

boolean disabled

true if the FieldSet is disabled. Disabling a FieldSet disables the form controls it contains.

readonly HTMLFormControlsCollection elements

An array-like object of all form controls contained within this <fieldset>.

Name

File — a file in the local filesystem

Inherits from

Blob

Synopsis

A File is a Blob that has a name and possibly also a modification date. It represents a file in the local file system. Obtain a user-selected file from the files array of an <input type=file> element, or from the files array of the DataTransfer object associated with the Event object that accompanies a drop event.

You can also obtain File objects that represent files in a private, sandboxed filesystem, as described in The Filesystem API. The filesystem API is not stable at the time of this writing, however, and it is not documented in this reference section.

You can upload the contents of a file to a server with a FormData object or by passing the File to XMLHttpRequest.send(), but there is not much else you can do with the File object itself. Use FileReader to read the contents of a File (or of any Blob).

Properties

readonly Date lastModifiedDate

The modification date of the file, or null if it is not available.

readonly string name

The name of the file (but not its path).

Name

FileError — error while reading a file

Synopsis

A FileError object represents an error that occurred when reading a file with FileReader or FileReaderSync. If the synchronous API is used, the FileError object is thrown. If the asynchronous API is used, the FileError object is the value of the error property of the FileReader object when the error event is dispatched.

Note that the FileWriter API (which is described in The Filesystem API, but is not stable enough to document in this reference section) adds new error code constants to this object.

Constants

The FileError error codes are the following:

unsigned short NOT_FOUND_ERR = 1

The file does not exist. (Perhaps it was deleted after the user selected it, but before your program attempted to read it.)

unsigned short SECURITY_ERR = 2

Unspecified security issues prevent the browser from allowing your code to read the file.

unsigned short ABORT_ERR = 3

The attempt to read the file was aborted.

unsigned short NOT_READABLE_ERR = 4

The file is not readable, perhaps because its permissions have changed or because another process has locked it.

unsigned short ENCODING_ERR = 5

A call to readAsDataURL() failed because the file was too long to encode in a data:// URL.

Properties

readonly unsigned short code

This property specifies what kind of error occurred. Its value is one of the constants above.

Name

FileReader — asynchronously read a File or Blob

Inherits from

EventTarget

Synopsis

A FileReader defines an asynchronous API for reading the content of a File or any Blob. To read a file, follow these steps:

Create a FileReader with the FileReader() constructor.

Define whichever event handlers you need.

Pass your File or Blob object to one of the four read methods.

When your onload handler is triggered, the file contents are available as the result property. Or, if the onerror handler is triggered, the error property refers to a FileError object that provides more information.

When the read is complete, you can reuse the FileReader object or discard it and create new ones as needed.

See FileReaderSync for a synchronous API that you can use in worker threads.

Constructor

new FileReader()

Create a new FileReader object with the FileReader() constructor, which expects no arguments.

Constants

These constants are the values of the readyState property:

unsigned short EMPTY = 0

No read method has been called yet.

unsigned short LOADING = 1

A read is in progress.

unsigned short DONE = 2

A read has completed successfully or with an error.

Properties

readonly FileError error

If an error occurs during a read, this property will refer to a FileError that describes the error.

readonly unsigned short readyState

This property describes the current state of the FileReader. Its value will be one of the three constants listed above.

readonly any result

If the read completed successfully, this property will hold the File or Blob contents as a string or ArrayBuffer (depending on which read method was called). When readyState is LOADING or when a progress event is fired, this property may contain partial contents of the File or Blob. If no read method has been called or if an error has occurred, this property will be null.

Methods

void abort()

This method aborts a read. It sets readyState to DONE, sets result to null, and sets error to a FileError object with a code of FileError.ABORT_ERR. Then it fires an abort event and a loadend event.

void readAsArrayBuffer(Blob blob)

Asynchronously read the bytes of blob and make them available as an ArrayBuffer on the result property.

void readAsBinaryString(Blob blob)

Asynchronously read the bytes of blob, encode them as a JavaScript binary string, and set the result property to the resulting string. Each「character」in a JavaScript binary string has a character code between 0 and 255. Use String.charCodeAt() to extract these byte values. Note that binary strings are an inefficient representation of binary data: when possible you should use ArrayBuffers instead.

void readAsDataURL(Blob blob)

Asynchronously read the bytes of blob, encode them (along with the type of the Blob) into a data:// URL, and set the result property to the resulting string.

void readAsText(Blob blob, [string encoding])

Asynchronously read the bytes of blob and decode them using the specified encoding into a string of Unicode text and then set the result property to that decoded string. If encoding is not specified, UTF-8 will be used (UTF-16 encoded text is also automatically detected and decoded if it begins with a Byte Order Mark).

Event Handlers

Like all asynchronous APIs, FileReader is event based. You can use the handler properties listed here to register event handlers, or you can use the EventTarget methods implemented by FileReader.

FileReader events are triggered on the FileReader object itself. They do not bubble and have no default action to cancel. FileReader event handlers are always passed a ProgressEvent object. A successful read begins with a loadstart event, followed by zero or more progress events, a load event, and a loadend event. A unsuccessful read begins with a loadstart event, followed by zero or more progress events, an error or abort event, and a loadend event.

onabort

Triggered if the read is aborted with the abort() method.

onerror

Triggered if an error of some sort occurs. The error property of the FileReader will refer to a FileError object that has an error code.

onload

Triggered when the File or Blob has been successfully read. The result property of the FileReader holds the File or Blob content, in a representation that depends on the read method that was called.

onloadend

Every call to a FileReader read method eventually produces a load event, an error event, or an abort event. The FileReader also triggers a loadend event after each of these events for the benefit of scripts that want to listen for only one event instead of listening for all three.

onloadstart

Triggered after a read method is invoked but before any data has been read.

onprogress

Triggered approximately 20 times a second while File or Blob data is being read. The ProgressEvent object will specify how many bytes have been read, and the result property of the FileReader may contain a representation of those bytes.

Name

FileReaderSync — synchronously read a File or Blob

Synopsis

FileReaderSync is a synchronous version of the FileReader API, available only to Worker threads. The synchronous API is easier to use than the asynchronous one: simply create a FileReaderSync() object and then call one of its read methods, which will either return the contents of the File or Blob or throw a FileError object instead.

Constructor

new FileReaderSync()

Create a new FileReaderSync object with the FileReaderSync() constructor, which expects no arguments.

Methods

These methods throw a FileError object if the read fails for any reason.

ArrayBuffer readAsArrayBuffer(Blob blob)

Read the bytes of blob and return them as an ArrayBuffer.

string readAsBinaryString(Blob blob)

Read the bytes of blob, encode them as a JavaScript binary string (see String.fromCharCode()), and return that binary string.

string readAsDataURL(Blob blob)

Read the bytes of blob, and encode those bytes, along with the type property of blob into a data:// URL, and then return that URL.

string readAsText(Blob blob, [string encoding])

Read the bytes of blob, decode them into text using the specified encoding (or using UTF-8 or UTF-16 if no encoding is specified), and return the resulting string.

Name

Form — a <form> in an HTML document

Inherits from

Node, Element

Synopsis

The Form object represents a <form> element in an HTML document. The elements property is an HTMLCollection that provides convenient access to all elements of the form. The submit() and reset() methods allow a form to be submitted or reset under program control.

Each form in a document is represented as an element of the document.forms[] array. The elements of a form (buttons, input fields, checkboxes, and so on) are collected in the array-like object Form.elements. Named form controls can be referenced directly by name: the control name is used as a property name on the Form object. Thus, to refer to an Input element with a name attribute of「phone」within a form f, you might use the JavaScript expression f.phone.

See HTML Forms for more on HTML forms. See FormControl, FieldSet, Input, Label, Select, and TextArea for more on the form controls that can appear in a form.

This page documents HTML5 form features which, at the time of this writing, were not yet widely implemented.

Properties

Most of the properties listed here simply mirror the HTML attributes of the same name.

