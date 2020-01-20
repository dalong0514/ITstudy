jQuery.support

An object containing a number of properties describing the features and bugs of the current browser. Most are of interest only to plug-in writers. jQuery.support.boxModel is false in IE browsers running in quirks mode.

jQuery.trim(s):string

Return a copy of the string s, with leading and trailing whitespace trimmed off.

Name

KeyEvent — see Event

Name

Label — a <label> for a form control

Inherits from

Node, Element

Synopsis

A Label object represents a <label> element in an HTML form.

Properties

readonly Element control

The FormControl that this Label is associated with. If htmlFor is specified, this property is the control specified by that property. Otherwise, this property is the first FormControl child of the <label>.

readonly Form form

This property is a reference to the Form element that contains this label. Or, if the HTML form attribute is set, the Form element identified by that ID.

string htmlFor

This property mirrors the HTML for attribute. Since for is a reserved word in JavaScript, the name of this property is prefixed with「html」to create a legal identifier. If set, this property should specify the ID of the FormControl that this label is associated with. (It is usually simpler, however, to simply make that FormControl be a descendant of this Label.)

Name

Link — an HTML hyperlink

Inherits from

Node, Element

Synopsis

HTML links are created with <a>, <area>, and <link> elements. <a> tags are used in the body of a document to create hyperlinks. <area> tags are a rarely used feature for creating「image maps.」<link> tags are used in the <head> of a document to refer to external resources such as stylesheets and icons. The <a> and <area> elements have the same representation in JavaScript. <link> elements have a somewhat different JavaScript representation, but, for convenience, these two types of links are documented together on this page.

When a Link object that represents an <a> element is used as a string, it returns the value of its href property.

Properties

In addition to the properties listed here, a Link object also has properties that reflect the underlying HTML attributes: hreflang, media, ping, rel, sizes, target, and type. Note that the URL decomposition properties (such as host and pathname) that return portions of the link’s href are only defined for <a> and <area> elements, not for <link> elements, and that the sheet, disabled, and relList properties are only defined for <link> elements that refer to stylesheets.

boolean disabled

For <link> elements that refer to stylesheets, this property controls whether the stylesheet is applied to the document or not.

string hash

Specifies the fragment identifier of href, including the leading hash (#) mark—for example,「#results」.

string host

Specifies the hostname and port portions of href—for example,「http://www.oreilly.com:1234」.

string hostname

Specifies the hostname portion of href—for example,「http://www.oreilly.com」.

string href

Specifies the href attribute of the link. When an <a> or <area> element is used as a string, it is the value of this property that is returned.

string pathname

Specifies the path portion of href—for example,「/catalog/search.html」.

string port

Specifies the port portion of href—for example,「1234」.

string protocol

Specifies the protocol portion of href, including the trailing colon—for example,「http:」.

readonly DOMTokenList relList

Like the classList property of Element, this property makes it easy to query, set, and delete tokens from the HTML rel attribute of <link> elements.

string search

Specifies the query portion of href, including the leading question mark—for example,「?q=JavaScript&m=10」.

readonly CSSStyleSheet sheet

For <link> elements that reference stylesheets, this property represents the linked stylesheet.

string text

The plain-text content of an <a> or <area> element. A synonym for Node.textContent.

string title

All HTML elements allow a title attribute, and it usually specifies tooltip text for that element. Setting this attribute or property on a <link> element that has rel set to「alternate stylesheet」provides a name by which the user can enable or disable the stylesheet, and if the browser supports alternate stylesheets, the title you specify may appear within the browser UI in some fashion.

Name

Location — represents and controls browser location

Synopsis

The location property of the Window and Document objects refers to a Location object that represents the web address (the「location」) of the current document. The href property contains the complete URL of that document, and the other properties of the Location object each describe a portion of that URL. These properties are much like the URL properties of the Link object. When a Location object is used as a string, the value of the href property is returned. This means that you can use the expression location in place of location.href.

In addition to representing the current browser location, the Location object also controls that location. If you assign a string containing a URL to the Location object or to its href property, the web browser loads and displays that URL. You can also make the browser load a new document by setting other Location properties to alter portions of the current URL. For example, if you set the search property, the browser reloads the current URL with a new query string appended. If you set the hash property, the browser does not load a new document, but it does create a new history entry. And if the hash property identifies an element of the document, the browser scrolls the document to make that element visible.

Properties

The properties of a Location object refer to the various portions of the current document’s URL. In each of the following property descriptions, the example given is a portion of this (fictitious) URL:

http://www.oreilly.com:1234/catalog/search.html?q=JavaScript&m=10#results

string hash

The anchor portion of the URL, including the leading hash (#) mark—for example,「#results」. This portion of the document URL specifies the name of an anchor within the document.

string host

The hostname and port portions of the URL—for example,「http://www.oreilly.com:1234」.

string hostname

The hostname portion of a URL—for example,「http://www.oreilly.com」.

string href

The complete text of the document’s URL, unlike other Location properties that specify only portions of the URL. Setting this property to a new URL causes the browser to read and display the contents of the new URL. Assigning a value directly to a Location object sets this property, and using a Location object as a string uses the value of this property.

string pathname

The pathname portion of a URL—for example,「/catalog/search.html」.

string port

The port portion of a URL— for example,「1234」. Note that this property is a string, not a number.

string protocol

The protocol portion of a URL, including the trailing colon—for example,「http:」.

string search

The query portion of a URL, including the leading question mark—for example,「?q=JavaScript&m=10」.

Methods

void assign(string url)

Load and display the contents of the specified url, as if the href property had been set to url.

void reload()

Reloads the document that is currently displayed.

void replace(string url)

Load and display the contents of the specified url, replacing the current document in the browsing history so that the browser’s Back button will not take the browser back to the previously displayed document.

Name

MediaElement — a media player element

Inherits from

Node, Element

Synopsis

MediaElement is the common superclass of the <audio> and <video> elements. Those two elements define almost exactly the same API, which is described here, but see Audio and Video for audio- and video-specific details. And see Scripting Audio and Video for an introduction to these media elements.

Constants

The NETWORK constants are the possible values of the networkState, and the HAVE constants are the possible values of the readyState property.

unsigned short NETWORK_EMPTY = 0

The element has not started using the network. This would be the state before the src attribute was set.

unsigned short NETWORK_IDLE = 1

The element is not currently loading data from the network. It might have loaded the complete resource, or it might have buffered all the data it currently needs. Or it might have preload set to「none」and not yet have been asked to load or play the media.

unsigned short NETWORK_LOADING = 2

The element is currently using the network to load media data.

unsigned short NETWORK_NO_SOURCE = 3

The element is not using the network because it was not able to find a media source that it is able to play.

unsigned short HAVE_NOTHING = 0

No media data or metadata has been loaded.

unsigned short HAVE_METADATA = 1

The media metadata has been loaded, but no data for the current playback position has been loaded. This means that you can query the duration of the media or the dimensions of a video and you can seek by setting currentTime, but the browser cannot currently play the media at currentTime.

unsigned short HAVE_CURRENT_DATA = 2

Media data for currentTime has been loaded, but not enough data has been loaded to allow the media to play. For video, this typically means that the current frame has loaded, but the next one has not. This state occurs at the end of a sound or movie.

unsigned short HAVE_FUTURE_DATA = 3

Enough media data has been loaded to begin playing, but it is likely not enough to play to the end of the media without pausing to download more data.

unsigned short HAVE_ENOUGH_DATA = 4

Enough media data has been loaded that the browser is likely to be able to play to the end without pausing.

Properties

boolean autoplay

If true, the media element will automatically begin playing when it has loaded enough data. Mirrors the HTML autoplay attribute.

readonly TimeRanges buffered

The time ranges of the media data that are currently buffered.

boolean controls

If true, the media element should display a set of playback controls. Mirrors the HTML controls attribute.

readonly string currentSrc

The URL of the media data, from the src attribute or one of the <source> children of this element, or the empty string if no media data is specified.

double currentTime

The current playback time, in seconds. Set this property to make the media element skip to a new playback position.

double defaultPlaybackRate

The playback speed used for normal playback. The default is 1.0.

readonly double duration

The length, in seconds, of the media. If the duration is unknown (metadata has not been loaded, for example), this property will be NaN. If the media is a stream of indefinite duration, this property will be Infinity.

readonly boolean ended

True if the end of the media has been reached.

readonly MediaError error

This property is set when an error occurs and is null otherwise. It refers to an object whose code property describes the kind of error.

readonly double initialTime

The initial playback position, in seconds. This is usually 0, but some types of media (such as streaming media) may have a different starting point.

boolean loop

If true, the media element should automatically restart the media each time it reaches the end. This property mirrors the HTML loop attribute.

boolean muted

Specifies whether the audio is muted or not. You can set this property to mute and unmute audio. For <video> elements, you can use an audio="muted" attribute to mute the media by default.

readonly unsigned short networkState

Whether media data is currently loading or not. The legal values are listed in the Constants section above.

readonly boolean paused

true if playback is currently paused.

double playbackRate

The current playback speed. 1.0 is normal playback. Values greater than 1.0 are fast-forward. Values between 0 and 1.0 are slow-motion. Values less than 0 play the media backward. (Media is always muted when played backward, and it will also be muted when played particularly quickly or slowly.)

readonly TimeRanges played

The time ranges that have been played.

string preload

This property mirrors the HTML attribute of the same name, and you can use it to specify how much media data the browser should fetch before the user requests that the media be played. The value「none」means that no data should be preloaded. The value「metadata」means that the browser should fetch the media metadata (such as duration) but not the actual data itself. The value「auto」(or just the empty string if the preload attribute is specified with no value) means that the browser is allowed to download the entire media resource, just in case the user decides to play it.

readonly unsigned short readyState

The media’s readiness to play, based on the amount of data that has been buffered. The legal values are the HAVE_ constants defined above.

readonly TimeRanges seekable

The range or ranges of times that you can set currentTime to. When playing back simple media files, this is typically any time between 0 and duration. But for streaming media, times in the past may no longer be buffered and times in the future may not yet be available.

readonly boolean seeking

This property is true while the media element is switching to a new currentTime playback position. If a new playback position is already buffered, this property will be true only for a short time. But if the media element must download new media data, seeking will remain true for a longer time.

string src

This property mirrors the HTML src attribute of the media element. You can set this property to make the media element load new media data. Note that this property is not the same as currentSrc.

readonly Date startOffsetTime

The real-world date and time of the playback position 0, if the media metadata includes that information. (A video file might include the time at which it was recorded, for example.)

double volume

This property queries and sets the volume for audio playback. It should be a value between 0 and 1. Also see the muted property.

Event Handlers

<audio> and <video> tags define the following event handlers, which can be set as HTML attributes or as JavaScript properties. At the time of this writing, some browsers do not support these properties and require you to register your event handlers using addEventListener() (see EventTarget). Media events do not bubble and have no default action to cancel. The associated event object is a an ordinary Event.

Event HandlerInvoked When...

onabort The element has stopped loading data, typically at the user’s request. error.code is error.MEDIA_ERR_ABORTED.

oncanplay Enough media data has loaded that playback can begin, but additional buffering is likely to be required.

oncanplaythrough Enough media data has loaded that the media can probably be played all the way through without pausing to buffer more data.

ondurationchange The duration property has changed

onemptied An error or abort has caused the networkState to return to NETWORK_EMPTY.

onended Playback has stopped because the end of the media has been reached.

onerror A network or other error prevented media data from being loaded. error.code is a value other than MEDIA_ERR_ABORTED (see MediaError).

onloadeddata Data for the current playback position has loaded for the first time.

onloadedmetadata The media metadata has been loaded, and the duration and dimensions of the media are ready.

onloadstart The element begins requesting media data.

onpause The pause() method was called and playback has been paused.

onplay The play() method has been invoked, or the autoplay attribute has caused the equivalent.

onplaying The media has begun to play.

onprogress Network activity is continuing to load media data. Typically fired between 2 and 8 times per second. Note that the object associated with this event is a simple Event object, not the ProgressEvent object used by other APIs that fire events named「progress」.

onratechange The playbackRate or defaultPlaybackRate has changed.

onseeked The seeking property has changed back to false.

onseeking The script or user has requested that playback skip to an unbuffered portion of the media and playback has stopped while data loads. The seeking property is true.

onstalled The element is trying to load data, but no data is arriving.

onsuspend The element has buffered enough data and has temporarily stopped downloading.

ontimeupdate The currentTime property has changed. During normal playback, this event is fired between 4 and 60 times per second.

onvolumechange The volume or muted property has changed.

onwaiting Playback cannot begin, or playback has stopped, because there is not enough data buffered. A playing event will follow when enough data is ready.

Methods

string canPlayType(string type)

This method asks the media element whether it can play media of the specified MIME type. If the player is certain it cannot play the type, it returns the empty string. If it is confident (but not certain) that it can play the type, it returns the string「probably」. Media elements will generally not return「probably」unless type includes a codecs= parameter that lists specific media codecs. If the media element is not certain whether it will be able to play media of the specified type, this method will return「maybe」.

void load()

This method resets the media element and makes it select a media source and start loading its data. This happens automatically when the element is first inserted into the document or whenever you set the src attribute. If you add, remove, or modify the <source> descendants of the media element, however, you should call load() explicitly.

void pause()

Pauses playback of the media.

void play()

Starts playback of the media.

Name

MediaError — an <audio> or <video> error

Synopsis

When an error occurs on an <audio> or <video> tag, an error event is triggered and the error property is set to a MediaError object. The code property specifies what kind of error occurred. The following constants define the values of that property.

Constants

unsigned short MEDIA_ERR_ABORTED = 1

The user asked the browser to stop loading the media.

unsigned short MEDIA_ERR_NETWORK = 2

The media is of the right type, but a network error prevented it from being loaded.

unsigned short MEDIA_ERR_DECODE = 3

The media is of the right type, but an encoding error prevented it from being decoded and played.

unsigned short MEDIA_ERR_SRC_NOT_SUPPORTED = 4

The media specified by the src attribute is not a type that the browser can play.

Properties

readonly unsigned short code

This property describes the type of media error that occurred. Its value will be one of the constants above.

Name

MessageChannel — a pair of connected MessagePorts

Synopsis

A MessageChannel is simply a pair of connected MessagePort objects. Calling post Message() on either one triggers a message event on the other. If you want to establish a private communication channel with a Window or Worker thread, create a MessageChannel and then pass one member of the MessagePort pair to the Window or Worker (using the ports argument of postMessage()).

MessageChannel and MessagePort types are an advanced feature of HTML5 and, at the time of this writing, some browsers support cross-origin messaging (Cross-Origin Messaging) and worker threads (Web Workers) without supporting private communication channels with MessagePort.

Constructor

new MessageChannel()

This no-argument constructor returns a new MessageChannel object.

Properties

readonly MessagePort port1

readonly MessagePort port2

These are the two connected ports that define the communication channel. The two are symmetrical: retain one or the other for your code, and pass the other to the Window or Worker you want to communicate with.

Name

MessageEvent — a message from another execution context

Inherits from

Event

Synopsis

Various APIs use message events for asynchronous communication between unrelated execution contexts. The Window, Worker, WebSocket, EventSource, and MessagePort objects all define onmessage properties for handling message events. The message associated with a message event is any JavaScript value that can be cloned as described in Structured Clones. The message is wrapped in a MessageEvent object and available on the data property. The various APIs that rely on message events also define a few additional properties in the MessageEvent object. Message events do not bubble and have no default action to cancel.

Properties

readonly any data

This property holds the message that is being delivered. data can be of any type that can be cloned with the structured clone algorithm (Structured Clones): this includes core JavaScript values including objects and arrays but not functions. Client-side values such as Document and Element nodes are not allowed, although Blobs and ArrayBuffers are.

readonly string lastEventId

For message events on an EventSource (Comet with Server-Sent Events), this field contains the lastEventId string, if any, that was sent by the server.

readonly string origin

For message events on an EventSource (Comet with Server-Sent Events) or on a Window (Cross-Origin Messaging), this property contains the origin URL of the message sender.

readonly MessagePort[] ports

For message events on a Window (Cross-Origin Messaging), Worker (Web Workers), or MessagePort, this property contains an array of MessagePort objects, if any were passed in the corresponding call to postMessage().

readonly Window source

For message events on a Window (Cross-Origin Messaging), this property refers to the Window from which the message was sent.

Name

MessagePort — pass asynchronous messages

Inherits from

EventTarget

Synopsis

A MessagePort is used for asynchronous, event-based message passing, typically between JavaScript execution contexts, such as windows or worker threads. MessagePorts must be used in connected pairs: see MessageChannel. Calling postMessage() on a MessagePort triggers a message event on the MessagePort to which it is connected. The cross-origin messaging API (Cross-Origin Messaging) and Web Workers (Web Workers) also communicate using a postMessage() method and message events. Those APIs effectively use an implicit MessagePort object. Explicit use of MessageChannel and MessagePort enables the creation of additional private communication channels and can be used, for example, to allow direct communication between two sibling Worker threads.

MessageChannel and MessagePort types are an advanced feature of HTML5 and, at the time of this writing, some browsers support cross-origin messaging (Cross-Origin Messaging) and worker threads (Web Workers) without supporting private communication channels with MessagePort.

Methods

void close()

This method disconnects this MessagePort from the port to which it was connected (if any). Subsequent calls to postMessage() will have no effect, and no message events will be delivered in the future.

void postMessage(any message, [MessagePort[] ports])

Send a clone of the specified message through the port and deliver it in the form of a message event on the port to which this one is connected. If ports is specified, deliver those as part of the message event as well. message can be any value that is compatible with the structured clone algorithm (Structured Clones).

void start()

This method causes the MessagePort to start firing message events. Before this method is called, any data sent through the port is buffered. Delaying messages this way allows a script to register all of its event handlers before any messages are sent. Note, however, that you only need to call this method if you use the EventTarget method addEventListener(). If you simply set the onmessage property, start() will be called implicitly.

Event Handlers

onmessage

This property defines an event handler for message events. Message events are triggered on the MessagePort object. They do not bubble and have no default action. Note that setting this property calls the start() method to start the delivery of message events.

Name

Meter — a graphical meter or gauge

Inherits from

Node, Element

Synopsis

A Meter object represents an HTML <meter> element that displays a graphical representation of a value within a range of possible values, where the range may optionally be annotated to indicate regions that are considered low, optimum, and high.

Most of the properties of this object simply mirror the HTML attributes with the same name. The JavaScript properties are numbers, however, while the HTML attributes are strings.

<meter> is an HTML5 element that, at the time of this writing, is not yet widely supported.

Properties

readonly Form form

The Form element, if there is one, that is the ancestor of this element or that was identified with the HTML form attribute.

double high

If specified, this property indicates that values between high and max should be graphically indicated as「high」.

readonly NodeList labels

An array-like object of Label elements that are associated with this element.

double low

If specified, this property indicates that values between min and low should be graphically indicated as「low」.

double max

The maximum value that can be displayed by the <meter>. The default is 1.

double min

The minimum value that can be displayed by the <meter>. The default is 0.

double optimum

If specified, the value that should be considered an optimum value.

double value

The value that is represented by this <meter>.

Name

MouseEvent — see Event

Name

Navigator — information about the web browser

Synopsis

The Navigator object contains properties that describe the web browser your code is running in. You can use its properties to perform platform-specific customization. The name of this object is a reference to the Netscape Navigator browser, but all browsers support it. There is only a single instance of the Navigator object, which you can reference through the navigator property of any Window object.

Historically, the Navigator object has been used for「client sniffing,」to run different code depending on what browser was in use. Example 14-3 shows a simple way to do this, and the accompanying text in Browser and Screen Information describes the pitfalls of relying on the Navigator object. A better approach to cross-browser compatibility is described in Feature Testing.

Properties

readonly string appName

The name of the browser. For Netscape-based browsers, the value of this property is「Netscape」. In IE, the value of this property is「Microsoft Internet Explorer」. For compatibility with existing code, many browsers return old, spoofed information.

readonly string appVersion

Version and platform information for the browser. For compatibility with existing code, most browsers return old out-of-date values for this property.

readonly Geolocation geolocation

A reference to the Geolocation object for this browser. The methods of that object allow a script to request the current geographical location of the user.

readonly boolean onLine

This property is false if the browser will not attempt to download anything from the network. This might be because the browser is certain that the computer is not connected to the network or because the user has configured the browser to perform no networking. If the browser will attempt downloads (because the computer might be online), this property is true. The browser fires online and offline events at the Window object when the state of this property changes.

readonly string platform

The operating system and/or hardware platform on which the browser is running. Although there is no standard set of values for this property, some typical values are「Win32」,「MacPPC」, and「Linux i586」.

readonly string userAgent

The value the browser uses for the user-agent header in HTTP requests. For example:

Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.45 Safari/534.16

Methods

void registerContentHandler(string mimeType, string url, string title)

This method requests the registration of the specified url as a handler for displaying content of the specified mimeType. title is a human-readable site title that the browser may display to the user. The url argument must contain the string「%s」. When this content handler is to be used to handle a web page of the specified mimeType, the URL of that web page will be encoded and inserted into the url in place of the「%s」. Then, the browser will visit the resulting URL. This is a new feature of HTML5 and may not be implemented in all browsers.

void registerProtocolHandler(string scheme, string url, string title)

This method is like registerContentHandler(), but it registers a website to use as a handler for the URL protocol scheme. scheme should be a string like「mailto」or「sms」without a colon. This is a new feature of HTML5 and may not be implemented in all browsers.

void yieldForStorageUpdates()

Scripts that use Document.cookie or Window.localStorage or Window.sessionStorage (see Storage and Chapter 20) are not supposed to be able to observe storage changes made by concurrently running (same-origin) scripts in other windows. Browsers can (though at the time of this writing, not all browsers do) prevent concurrent updates with a locking mechanism like those used for databases. In browsers that support it, this method explicitly releases the lock, potentially unblocking concurrent scripts in other windows. Stored values retrieved after calling this method may be different than those retrieved before calling it.

Name

Node

Synopsis

All objects in a document tree (including the Document object itself) implement the Node interface, which provides the fundamental properties and methods for traversing and manipulating the tree. The parentNode property and childNodes[] array allow you to move up and down the document tree. You can enumerate the children of a given node by looping through the elements of childNodes[] or by using the firstChild and nextSibling properties (or the lastChild and previousSibling properties, to loop backward). The appendChild(), insertBefore(), removeChild(), and replaceChild() methods allow you to modify the document tree by altering the children of a node.

Every object in a document tree implements both the Node interface and a more specialized subinterface, such as Element or Text. The nodeType property specifies which subinterface a node implements. You can use this property to test the type of a node before using properties or methods of the more specialized interface. For example:

var n; // Holds the node we're working with if (n.nodeType == 1) { // Or use the constant Node.ELEMENT_NODE var tagname = n.tagName; // If the node is an Element, this is the tag name }

Constants

unsigned short ELEMENT_NODE = 1

unsigned short TEXT_NODE = 3

unsigned short PROCESSING_INSTRUCTION_NODE = 7

unsigned short COMMENT_NODE = 8

unsigned short DOCUMENT_NODE = 9

unsigned short DOCUMENT_TYPE_NODE = 10

unsigned short DOCUMENT_FRAGMENT_NODE = 11

These constants are possible values of the nodeType property. Note that these are static properties of the Node() constructor function; they are not properties of individual Node objects. Also note that they are not defined in IE8 and before. For compatibility, you can hardcode values or define your own constants.

unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01

unsigned short DOCUMENT_POSITION_PRECEDING = 0x02

unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04

unsigned short DOCUMENT_POSITION_CONTAINS = 0x08

unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10

These constants specify bits that may be on or off in the return value of compareDocumentPosition().

Properties

readonly string baseURI

This property specifies the base URL of this Node against which relative URLs are resolved. For all nodes in HTML documents, this is the URL specified by the <base> element of the document, or just the Document.URL with the fragment identifier removed.

readonly NodeList childNodes

This property is an array-like object that contains the child nodes of the current node. This property should never be null: for nodes with no children, childNodes is an array with length zero. Note that the NodeList object is live: any changes to this element’s list of children are immediately visible through the NodeList.

readonly Node firstChild

The first child of this node, or null if the node has no children.

readonly Node lastChild

The last child of this node, or null if the node has no children.

readonly Node nextSibling

The sibling node that immediately follows this one in the childNodes[] array of the parentNode, or null if there is no such node.

readonly string nodeName

The name of the node. For Element nodes, specifies the tag name of the element, which can also be retrieved with the tagName property of the Element interface. For most other types of nodes, the value is a constant string that depends on the node type.

readonly unsigned short nodeType

The type of the node—i.e., which subinterface the node implements. The legal values are defined by the previously listed constants. Since these constants are not supported by Internet Explorer, however, you may prefer to use hardcoded values instead of the constants. In HTML documents, the common values for this property are 1 for Element nodes, 3 for Text nodes, 8 for Comment nodes, and 9 for the single top-level Document node.

string nodeValue

The value of a node. For Text nodes, it holds the text content.

readonly Document ownerDocument

The Document object with which this node is associated. For Document nodes, this property is null. Note that nodes have owners even if they have not been inserted into a document.

readonly Node parentNode

The parent (or container) node of this node, or null if there is no parent. Note that the Document and DocumentFragment nodes never have parent nodes. Also, nodes that have been removed from the document, or that are newly created and have not yet been inserted into the document tree, have a parentNode of null.

readonly Node previousSibling

The sibling node that immediately precedes this one in the childNodes[] array of the parentNode, or null if there is no such node.

string textContent

For Text and Comment nodes, this property is just a synonym for the data property. For Element and DocumentFragment nodes, querying this property returns the concatenated text content of all Text node descendants. Setting this property on a Element or DocumentFragment replaces all descendants of that element or fragment with a single new Text node that holds the specified value.

Methods

Node appendChild(Node newChild)

This method adds the node newChild to the document, inserting it as the last child of this node. If newChild is already in the document tree, it is removed from the tree and then reinserted at its new location. If newChild is a DocumentFragment node, it is not inserted itself; instead, all its children are appended, in order, to the end of this node’s childNodes[] array. Note that a node from (or created by) one document cannot be inserted into a different document. That is, the ownerDocument property of newChild must be the same as the ownerDocument property of this node. (See Document.adoptNode()). This method returns the Node that was passed to it.

Node cloneNode(boolean deep)

The cloneNode() method makes and returns a copy of the node on which it is called. If passed the argument true, it recursively clones all descendants of the node as well. Otherwise, it clones only the node and none of its children. The returned node is not part of the document tree, and its parentNode property is null. When an Element node is cloned, all of its attributes are also cloned. Note, however, that event-listener functions registered on a node are not cloned.

unsigned short compareDocumentPosition(Node other)

This method compares the document position of this node to the document position of the other node and returns a number whose set bits describe the relationship between the nodes. If the two nodes are the same, no bits are set and this method returns 0. Otherwise, one or more bits will be set in the return value. The DOCUMENT_POSITION_ constants listed above give symbolic names for each of the bits, which have the following meanings:

DOCUMENT_POSITION_ ValueMeaning

DISCONNECTED 0x01 The two nodes are not in the same document, so their position cannot be compared.

PRECEDING 0x02 The other node appears before this node.

FOLLOWING 0x04 The other node comes after this node.

CONTAINS 0x08 The other node contains this node. When this bit is set, the PRECEDING bit is always also set.

CONTAINED_BY 0x10 The other node is contained by this node. When this bit is set, the FOLLOWING bit is always also set.

boolean hasChildNodes()

Returns true if this node has one or more children or false if it has none.

Node insertBefore(Node newChild, Node refChild)

This method inserts the node newChild into the document tree as a child of this node and then returns the inserted node. The new node is positioned within this node’s childNodes[] array so that it comes immediately before the refChild node. If refChild is null, newChild is inserted at the end of childNodes[], just as with the appendChild() method. Note that it is illegal to call this method with a refChild that is not a child of this node.

If newChild is already in the document tree, it is removed from the tree and then reinserted at its new position. If newChild is a DocumentFragment node, it is not inserted itself; instead, each of its children is inserted, in order, at the specified location.

boolean isDefaultNamespace(string namespace)

Returns true if the specified namespace URL is the same as the default namespace URL returned by lookupNamespaceURI(null) and false otherwise.

boolean isEqualNode(Node other)

Returns true if this node and other are identical, with equal type, tagname, attributes, and (recursively) children. Returns false if the two nodes are not equal.

boolean isSameNode(Node other)

Returns true if this node and other are the same node and false otherwise. You can also simply use the == operator.

string lookupNamespaceURI(string prefix)

This method returns the namespace URL associated with the specified namespace prefix, or null if there isn’t one. If prefix is null, it returns the URL of the default namespace.

string lookupPrefix(string namespace)

This method returns the namespace prefix associated with the specified namespace URL, or null if there is none.

void normalize()

This method normalizes the text node descendants of this node, merging adjacent nodes and removing empty nodes. Documents do not normally have empty or adjacent text nodes, but this can occur when a script adds or removes nodes.

Node removeChild(Node oldChild)

This method removes oldChild from the childNodes[] array of this node. It is an error to call this method with a node that is not a child. removeChild() returns the oldChild node after removing it. oldChild continues to be a valid node and can be reinserted into the document later.

Node replaceChild(Node newChild, Node oldChild)

This method replaces oldChild with newChild and returns oldChild. oldChild must be a child of this node. If newChild is already part of the document, it is first removed from the document before being reinserted at its new position. If newChild is a DocumentFragment, it is not inserted itself; instead, each of its children is inserted, in order, at the position formerly occupied by oldChild.

Name

NodeList — a read-only array-like object of Nodes

Synopsis

A NodeList is a read-only array-like object whose elements are Node objects (usually Elements). The length property specifies how many nodes are in the list, and you can retrieve those nodes from indexes 0 through length-1. You can also pass the desired index to the item() method instead of indexing the NodeList directly. The elements of a NodeList are always valid Node objects: NodeLists never contain null elements.

NodeLists are commonly used: the childNodes property of Node, and the return values of Document.getElementsByTagName(), Element.getElementsByTagName(), and HTMLDocument.get Elements ByName() are all NodeLists, for example. Because NodeList is an array-like object, however, we often refer to those values informally as arrays, using language like「the child Nodes[] array.」

Note that NodeList objects are usually live: they are not static snapshots but immediately reflect changes to the document tree. For example, if you have a NodeList that represents the children of a specific node and you then delete one of those children, the child is removed from your NodeList. Be careful when you are looping through the elements of a NodeList: the body of your loop can make changes to the document tree (such as deleting nodes) that can affect the contents of the NodeList!

Properties

readonly unsigned long length

The number of nodes in the NodeList.

Methods

Node item(unsigned long index)

