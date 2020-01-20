You most commonly obtain a Document object via the document property of a Window. Document objects are also available through the contentDocument property of IFrame elements or the ownerDocument property of any Node.

Most of the properties of a Document object provide access to elements of the document or to other important objects associated with the document. A number of Document methods do the same thing: provide a way to look up elements within the document tree. Many other Document methods are「factory methods」that create elements and related objects.

Documents, like the Elements they contain, are event targets. They implement the methods defined by EventTarget, and they also support quite a few event handler properties.

You can create new Document objects by using the createDocument() and createHTML Document() methods of the DOMImplementation:

document.implementation.createHTMLDocument("New Doc");

It is also possible to load an HTML or XML file from the network and parse it into a Document object. See the responseXML property of the XMLHttpRequest object.

The reference entry for HTMLDocument, which appeared in previous versions of this book, has been merged into this page. Note that some of the properties, methods, and event handlers described here are HTML-specific and will not work for XML documents.

Properties

In addition to the properties listed here, you can also use the value of the name attribute of <iframe>, <form>, and <img> elements as document properties. The value of these properties is the named Element or a NodeList of such elements. For named <iframe> elements, however, the property refers to the Window object of the <iframe>. See Selecting Elements by Name for details.

readonly Element activeElement

The document element that currently has the keyboard focus.

Element body

For HTML documents, this element refers to the <body> Element. (For documents that define framesets, this property refers to the outermost <frameset> instead.)

readonly string characterSet

The character encoding of this document.

string charset

The character encoding of this document. This is like characterSet, but you can set it to change the encoding.

readonly string compatMode

This property is the string「BackCompat」if the document is being rendered in CSS「quirks mode」for backward compatibility with very old browsers. Otherwise, this property is「CSS1Compat」.

string cookie

This property allows you to read, create, modify, and delete the cookie or cookies that apply to the current document. A cookie is a small amount of named data stored by the web browser. It gives web browsers a「memory」so they can use data input on one page in another page or recall user preferences across web browsing sessions. Cookie data is automatically transmitted between web browser and web server when appropriate so server-side scripts can read and write cookie values. Client-side JavaScript code can also read and write cookies with this property. Note that this is a read/write property but the value you read from it is not, in general, the same as the value you write. See Cookies for details.

readonly string defaultCharset

The browser’s default character set.

readonly Window defaultView

The web browser Window object in which this document is displayed.

string designMode

If this property is「on」, the entire document is editable. If it is「off」, the entire document is not editable. (But elements with their contenteditable property set may still be editable, of course.) See Editable Content.

string dir

For HTML documents, this property mirrors the dir attribute of the <html> element. It is the same, therefore, as documentElement.dir.

readonly DocumentType doctype

The DocumentType node that represents the document’s <!DOCTYPE>.

readonly Element documentElement

The root element of the document. For HTML documents, this property is always the Element object representing the <html> tag. This root element is also available through the childNodes[] array inherited from Node, but it is not generally the first element of that array. See also the body property.

string domain

The hostname of the server from which the document was loaded, or null if there is none. You can set this property to a suffix of itself in order to relax the same-origin policy and grant access to documents served from related domains. See Relaxing the same-origin policy for details.

readonly HTMLCollection embeds

An array-like object of <embed> elements in the document.

readonly HTMLCollection forms

An array-like object of all Form elements in the document.

readonly Element head

For HTML documents, this property refers to the <head> element.

readonly HTMLCollection images

An array-like object of all Image elements in the document.

readonly DOMImplementation implementation

The DOMImplementation object for this document.

readonly string lastModified

Specifies the date and time of the most recent modification to the document. This value comes from the Last-Modified HTTP header that is optionally sent by the web server.

readonly HTMLCollection links

An array-like object of all hyperlinks in the document. This HTMLCollection contains all <a> and <area> elements that have href attributes, and does not include <link> elements. See Link.

readonly Location location

A synonym for Window.location.

readonly HTMLCollection plugins

A synonym for the embeds property.

readonly string readyState

This property is the string「loading」if the document is still loading and「complete」if it is fully loaded. The browser fires a readystatechange event at the Document when this property changes to「complete」.

readonly string referrer

The URL of the document that linked to this document, or null if this document was not accessed through a hyperlink or if the web server did not report the referring document. This property allows client-side JavaScript to access the HTTP referer header. Note the spelling difference, however: the HTTP header has three r’s, and the JavaScript property has four r’s.

readonly HTMLCollection scripts

An array-like object of all the <script> elements in the document.

readonly CSSStyleSheet[] styleSheets

A collection of objects representing all stylesheets embedded in or linked into a document. In HTML documents, this includes stylesheets defined with <link> and <style> tags.

string title

The plain-text content of the <title> tag for this document.

readonly string URL

The URL from which the document was loaded. This value is often the same as the location.href property, but if a script changes the fragment identifier (the location. hash property), the location property and the URL property will no longer refer to the same URL. Don’t confuse Document.URL with Window.URL.

Methods

Node adoptNode(Node node)

This method removes node from whatever document it is currently part of and changes its ownerDocument property to this document, making it ready for insertion into this document. Contrast this with importNode(), which copies a node from another document without removing it.

void close()

Closes a document stream opened with the open() method, forcing any buffered output to be displayed.

Comment createComment(string data)

Create and return a new Comment node with the specified content.

DocumentFragment createDocumentFragment()

Create and return a new, empty DocumentFragment node.

Element createElement(string localName)

Create and return a new, empty Element node with the specified tag name. In HTML documents, the tag name is converted to uppercase.

Element createElementNS(string namespace, string qualifiedName)

Create and return a new, empty, Element node. The first argument specifies the namespace URI for the element, and the second argument specifies the namespace prefix, a colon, and the tag name of the element.

Event createEvent(string eventInterface)

Create and return an uninitialized synthetic Event object. The argument must specify the type of event, and the argument should be a string such as「Event」,「UIEvent」,「MouseEvent」,「MessageEvent」, or so on. After creating an Event object, you can initialize its read-only properties by calling an appropriate event-initialization method on it, such as initEvent(), initUIEvent(), initMouseEvent(), or so on. Most of these event-specific initialization methods are not covered in this book, but see Event.initEvent() for the simplest one. When you have created and initialized an synthetic event object, you can dispatch it using the dispatchEvent() method of EventTarget. Synthetic events will always have an isTrusted property of false.

ProcessingInstruction createProcessingInstruction(string target, string data)

Creates and returns a new ProcessingInstruction node with the specified target and data string.

Text createTextNode(string data)

Creates and returns a new Text node to represent the specified text.

Element elementFromPoint(float x, float y)

Return the most deeply nested Element at window coordinates (x, y).

boolean execCommand(string commandId, [boolean showUI, [string value]])

Execute the editing command named by the commandId argument in whatever editable element has the insertion cursor. HTML5 defines the following commands:

bold insertLineBreak selectAll createLink insertOrderedList subscript delete insertUnorderedList superscript formatBlock insertParagraph undo forwardDelete insertText unlink insertImage italic unselect insertHTML redo

Some of these commands (such as「createLink」) require an argument value. If the second argument to execCommand() is false, the third argument gives the argument that the command is to use. Otherwise, the browser will prompt the user for the necessary value. See Editable Content for more on execCommand().

Element getElementById(string elementId)

This method searches the document for an Element node with an id attribute whose value is elementId and returns that Element. If no such Element is found, it returns null. The value of the id attribute is intended to be unique within a document, but if this method finds more than one Element with the specified elementId, it returns the first. This is an important and commonly used method because it provides a simple way to obtain the Element object that represents a specific document element. Note that the name of this method ends with「Id」, not with「ID」.

NodeList getElementsByClassName(string classNames)

Returns an array-like object of elements that have a class attribute that includes all of the specified classNames. classNames may be a single class or a space-separated list of classes. The returned NodeList object is live and is automatically updated as the document changes. The elements in the returned NodeList appear in the same order as they appear in the document. Note that this method is also defined on Element.

NodeList getElementsByName(string elementName)

This method returns a live, read-only, array-like object of Elements that have a name attribute whose value is elementName. If there are no matching elements, it returns a NodeList with length 0.

NodeList getElementsByTagName(string qualifiedName)

This method returns a read-only array-like object that contains all Element nodes from the document that have the specified tag name, in the order in which they appear in the document source. The NodeList is「live」—its contents are automatically updated as necessary when the document changes. For HTML elements, tag name comparison is case-insensitive. As a special case, the tag name「*」matches all elements in a document.

Note that the Element interface defines a method by the same name that searches only a subtree of the document.

NodeList getElementsByTagNameNS(string namespace, string localName)

This method works like getElementsByTagName(), but it specifies the desired tag name as a combination of namespace URI and local name within that namespace.

boolean hasFocus()

This method returns true if this document’s Window has the keyboard focus (and, if that window is not a top-level window, all of its ancestors are focused).

Node importNode(Node node, boolean deep)

This method is passed a node defined in another document and returns a copy of the node that is suitable for insertion into this document. If deep is true, all descendants of the node are also copied. The original node and its descendants are not modified in any way. The returned copy has its ownerDocument property set to this document but has a parentNode of null because it has not yet been inserted into the document. Event-listener functions registered on the original node or tree are not copied. See also adoptNode().

Window open(string url, string name, string features, [boolean replace])

When the open() method of a document is invoked with three or more arguments, it acts just like the open() method of the Window object. See Window.

Document open([string type], [string replace])

With two or fewer arguments, this method erases the current document and begins a new one (using the existing Document object, which is the return value). After calling open(), you can use the write() and writeln() methods to stream content to the document and close() to end the document and force its new content to be displayed. See The document.write() Method for details.

The new document will be an HTML document if type is omitted or is「text/html」. Otherwise, it will be a plain text document. If the replace argument is true, the new document replaces the old one in the browsing history.

This method should not be called by a script or event handler that is part of the document being overwritten, because the script or handler will itself be overwritten.

boolean queryCommandEnabled(string commandId)

Returns true if it is currently meaningful to pass commandId to execCommand() and false otherwise. The「undo」command, for example, is not enabled if there is nothing to undo. See Editable Content.

boolean queryCommandIndeterm(string commandId)

Returns true if commandId is in an indeterminate state for which queryCommandState() cannot return a meaningful value. Commands defined by HTML5 are never indeterminate, but browser-specific commands might be. See Editable Content.

boolean queryCommandState(string commandId)

Return the state of the specified commandId. Some editing commands, such as「bold」and「italic,」have a state true if the cursor or selection is in italic and false if it is not. Most commands are stateless, however, and this method always returns false for those. See Editable Content.

boolean queryCommandSupported(string commandId)

Returns true if the browser supports the specified command and false otherwise. See Editable Content.

string queryCommandValue(string commandId)

Returns the state of the specified command as a string. See Editable Content.

Element querySelector(string selectors)

Returns the first element in this document that matches the specified CSS selectors (this may be a single CSS selector or a comma-separated group of selectors).

NodeList querySelectorAll(string selectors)

Returns an array-like object containing all Elements in this Document that match the specified selectors (this may be a single CSS selector or a comma-separated group of selectors). Unlike the NodeLists returned by getElementsByTagName() and similar methods, the NodeList returned by this method is not live: it is just a static snapshot of the elements that matched when the method was called.

void write(string text...)

This method appends its arguments to the document. You can use this method while the document is loading to insert content at the location of the <script> tag, or you can use it after calling the open() method. See The document.write() Method for details.

void writeln(string text...)

This method is like HTMLDocument.write(), except that it follows the appended text with a newline character, which may be useful when writing the content of a <pre> tag, for example.

Events

Browsers do not fire many events directly at Document objects, but Element events do bubble up to the Document that contains them. Therefore, Document objects support all of the event handler properties listed in Element. Like Elements, Document objects implement the EventTarget methods.

Browsers do fire two document readiness events at the Document object. When the readyState property changes, the browser fires a readystatechange event. You can register a handler for this event with the onreadystatechange property. The browser also fires a DOMContentLoaded event (see Document Load Events) when the document tree is ready (but before external resources have finished loading). You must use an EventTarget method to register a handler for those events, however, since there is an onDOMContentLoaded property.

Name

DocumentFragment — adjacent nodes and their subtrees

Inherits from

Node

Synopsis

The DocumentFragment interface represents a portion—or fragment—of a document. More specifically, it is a list of adjacent nodes and all descendants of each, but without any common parent node. DocumentFragment nodes are never part of a document tree, and the inherited parentNode property is always null. DocumentFragment nodes exhibit a special behavior that makes them quite useful, however: when a request is made to insert a DocumentFragment into a document tree, it is not the DocumentFragment node itself that is inserted but instead each child of the DocumentFragment. This makes DocumentFragment useful as a temporary placeholder for nodes that you wish to insert, all at once, into a document.

You can create a new, empty DocumentFragment with Document.createDocumentFragment().

You can search for elements in a DocumentFragment with querySelector() and query Selector All(), which work just like the same methods of the Document object.

Methods

Element querySelector(string selectors)

See Document.querySelector().

NodeList querySelectorAll(string selectors)

See Document.querySelectorAll().

Name

DocumentType — the <!DOCTYPE> declaration of a document

Inherits from

Node

Synopsis

This infrequently used type represents the <!DOCTYPE> declaration of a document. The doctype property of a Document holds the DocumentType node for that document. DocumentType nodes are immutable and cannot be modified in any way.

DocumentType nodes are used to create new Document objects with DOMImplementation. create Document(). You can create new DocumentType objects with DOMImplementation.createDocumentType().

Properties

readonly string name

The name of the document type. This identifier immediately follows <!DOCTYPE> at the start of a document, and it is the same as the tag name of the document’s root element. For HTML documents, this will be「html」.

readonly string publicId

The public identifier of the DTD, or the empty string if none was specified.

readonly string systemId

The system identifier of the DTD, or the empty string if none was specified.

Name

DOMException — an exception thrown by a Web API

Synopsis

Most client-side JavaScript APIs throw DOMException objects when they need to signal an error. The code and name properties of the object provide more details about the error. Note that a DOMException can be thrown when reading or writing a property of an object as well as when calling a method of an object.

DOMException is not a subclass of the core JavaScript Error type, but it functions like one, and some browsers include a message property for compatibility with Error.

Constants

unsigned short INDEX_SIZE_ERR = 1

unsigned short HIERARCHY_REQUEST_ERR = 3

unsigned short WRONG_DOCUMENT_ERR = 4

unsigned short INVALID_CHARACTER_ERR = 5

unsigned short NO_MODIFICATION_ALLOWED_ERR = 7

unsigned short NOT_FOUND_ERR = 8

unsigned short NOT_SUPPORTED_ERR = 9

unsigned short INVALID_STATE_ERR = 11

unsigned short SYNTAX_ERR = 12

unsigned short INVALID_MODIFICATION_ERR = 13

unsigned short NAMESPACE_ERR = 14

unsigned short INVALID_ACCESS_ERR = 15

unsigned short TYPE_MISMATCH_ERR = 17

unsigned short SECURITY_ERR = 18

unsigned short NETWORK_ERR = 19

unsigned short ABORT_ERR = 20

unsigned short URL_MISMATCH_ERR = 21

unsigned short QUOTA_EXCEEDED_ERR = 22

unsigned short TIMEOUT_ERR = 23

unsigned short DATA_CLONE_ERR = 25

These are the possible values of the code property. The constant names are verbose enough to indicate the approximate reason that the exception was thrown.

Properties

unsigned short code

One of the constant values listed above, indicating what type of exception occurred.

string name

The name of the specific exception type. This will be one of the constant names listed above, as a string.

Name

DOMImplementation — global DOM methods

Synopsis

The DOMImplementation object defines methods that are not specific to any particular Document object but rather are「global」to an implementation of the DOM. You can obtain a reference to the DOMImplementation object through the implementation property of any Document object.

Methods

Document createDocument(string namespace, string qualifiedName, DocumentType doctype)

This method creates and returns a new XML Document object. If qualifiedName is specified, a root element with that name is created and added to the document as its documentElement. If qualifiedName includes a namespace prefix and a colon, namespace should be the URI that uniquely identifies the namespace. If the doctype argument is non-null, the ownerDocument property of this DocumentType object is set to the newly created document and the DocumentType node is added to the new document.

DocumentType createDocumentType(string qualifiedName, publicId, systemId)

This method creates and returns a new DocumentType node to represent a <!DOCTYPE> declaration that you can pass to createDocument().

Document createHTMLDocument(string title)

This method creates a new HTMLDocument object with a skeletal document tree that includes the specified title. The documentElement property of the returned object is an <html> element, and this root element has <head> and <body> tags as its children. The <head> element in turn has a <title> child, which has the specified title string as its child.

Name

DOMSettableTokenList — a token list with a settable string value

Inherits from

DOMTokenList

Synopsis

A DOMSettableTokenList is a DOMTokenList that also has a value property that can be set to specify the entire set of tokens at once.

The classList property of Element is a DOMTokenList that represents the set of tokens in the className property, which is a string. If you want to set all the classList tokens at once, you can simply set the className property to a new string. The sandbox property of the IFrame element is a little different. This property and the HTML attribute that it is based on was defined by HTML5 and so there is no need for an old string representation and a new DOMTokenList representation. In this case, the property is simply defined as a DOMSettableTokenList: you can read it and write it as if it were a string, or you can use its methods and use it as a set of tokens. The htmlFor property of Output and the audio property of Video are also DOMSettableTokenLists.

Properties

string value

The space-separated string representation of the set of tokens. You can read or write this property to treat the set as a single string value. You do not normally need to use this property explicitly, however: when you use a DOMSettableTokenList as a string, it is this string value that is returned. And if you assign a string to a DOMSettableTokenList, this property is implicitly set.

Name

DOMTokenList — a set of space-separated tokens

Synopsis

A DOMTokenList is a parsed representation of a space-separated string of tokens, such as the className property of a Element. A DOMTokenList is, as its name implies, a list—it is an array-like object with a length property and you can index it to retrieve the individual tokens. But more importantly, it defines methods contains(), add(), remove(), and toggle() methods that allow you to treat it as a set of tokens. If you use a DOMTokenList as if it was a string, it evaluates to a space-separated string of tokens.

The HTML5 classList property of Element objects is a DOMTokenList, in browsers that support that property, and is the only DOMTokenList you are likely to use often. See also DOMSettableTokenList.

Properties

readonly unsigned long length

A DOMTokenList is an array-like object; this property specifies the number of unique tokens it contains.

Methods

void add(string token)

If the DOMTokenList does not already contain token, add it at the end of the list.

boolean contains(string token)

Returns true if the DOMTokenList contains token, or false otherwise.

string item(unsigned long index)

Return the token at the specified index or null if index is out of bounds. You can also index the DOMTokenList directly instead of calling this method.

void remove(string token)

If this DOMTokenList contains token, remove it. Otherwise, do nothing.

boolean toggle(string token)

If the DOMTokenList contains token, remove it. Otherwise add it.

Name

Element — a document element

Inherits from

Node, EventTarget

Synopsis

An Element object represents an element in an HTML or XML document. The tagName property specifies the tag name or type of the element. Standard HTML attributes of the element are available through JavaScript properties of the Element object. Attributes, including XML attributes and nonstandard HTML attributes can also be accessed with the get Attribute() and setAttribute() methods. Element content is available through properties inherited from Node. If you are only interested in the Element relatives of an Element, you can use the children property or firstElementChild, nextElementSibling, and related properties.

There are a number of ways to obtain Element objects from documents. The document Element property of a Document refers to the root element for that document, such as the <html> element of an HTML document. For HTML documents, the head and body properties are similar: they refer to the <head> and <body> elements of the document. To locate a specific named element by its unique id attribute, use Document.getElementById(). As described in Selecting Document Elements, you can also obtain Element objects with Document and Element methods such as getElementsByTagName(), getElementsByClassName(), and querySelectorAll(). Finally, you can create new Element objects for insertion into a document with Document.createElement().

Web browsers fire many different kinds of events on document elements, and Element objects define many event handler properties. In addition, Element objects define the EventTarget methods (see EventTarget) for adding and removing event listeners.

The reference entry for HTMLElement, which appeared in previous versions of this book, has been merged with this section. Note that some of the properties, methods, and event handlers described here are HTML-specific and will not work with the elements of XML documents.

Properties

In addition to the properties listed here, the HTML attributes of HTML elements are accessible as JavaScript properties of the Element object. HTML tags and their legal attributes are listed at the end of this reference entry.

readonly Attr[] attributes

An array-like object of Attr objects that represent the HTML or XML attributes of this element. Element objects generally make attributes accessible through JavaScript properties, however, so it is never really necessary to use this attributes[] array.

readonly unsigned long childElementCount

The number of child elements (not child nodes) that this element has.

readonly HTMLCollection children

An array-like object of the Element children (excluding non-Element children, such as Text and Comment nodes) of this Element.

readonly DOMTokenList classList

The class attribute of an element is a space-separated list of class names. This property allows access to the individual elements of that list and defines methods for querying, adding, removing, and toggling class names. See DOMTokenList for details.

string className

This property represents the class attribute of the element. class is a reserved word in JavaScript, so the JavaScript property is className instead of class. Note that this property name is misleading, since the class attribute often includes more than one class name.

readonly long clientHeight

readonly long clientWidth

If this element is the root element (see document.documentElement), these properties return the dimensions of the Window. These are the inner or viewport dimensions that exclude scrollbars and other browser「chrome」. Otherwise, these properties return the dimensions of the element’s content plus padding.

readonly long clientLeft

readonly long clientTop

These properties return the number of pixels between the left or top edge of the element’s border and the left or top edge of its padding. Normally this is just the left and top border width, but these amounts may also include the width of a scrollbar if one is rendered on the left or top of the element.

CSSStyleDeclaration currentStyle

This IE-specific property represents the cascaded set of all CSS properties that apply to the element. You can use it in IE8 and before as a substitute for the standard Window.get Computed Style() method.

readonly object dataset

You can associate arbitrary values with any HTML element by assigning those values to attributes whose names begin with the special prefix「data-」. This dataset property is the set of data attributes for an element and makes it easy to set and query them.

The value of this property behaves like a regular JavaScript object. Each property of the object corresponds to one data attribute on the element. If the element has an attribute named data-x, the dataset object has a property named x, and dataset.x has the same value as getAttribute("data-x") does.

Querying and setting properties of the dataset object queries and sets the corresponding data attributes of this element. You can use the delete operator to remove data attributes, and you can use a for/in loop to enumerate the data attributes.

readonly Element firstElementChild

This property is like the firstChild property of Node, but it ignores Text and Comment nodes and only returns Elements.

string id

The value of the id attribute. No two elements within the same document should have the same value for id.

string innerHTML

A read/write string that specifies the HTML or XML markup that is contained within the element, not including the opening and closing tags of the element itself. Querying this property returns the content of the element as a string of HTML or XML text. Setting this property to a string of HTML or XML text replaces the content of the element with the parsed representation of that text.

readonly boolean isContentEditable

This property is true if the element is editable or false otherwise. An element may be editable because of the contenteditable property on it or an ancestor or because of the designMode property of the containing Document.

string lang

The value of the lang attribute, which specifies the language code for the element’s content.

readonly Element lastElementChild

This property is like the lastChild property of Node, but it ignores Text and Comment nodes and only returns Elements.

readonly string localName

The local, unprefixed name for this element. This differs from the tagName attribute, which includes the namespace prefix if there is one (and is converted to uppercase for HTML elements).

readonly string namespaceURI

The URL that formally defines the namespace for this element. This can be null or a string such as「http://www.w3.org/1999/xhtml」.

readonly Element nextElementSibling

This property is like the nextSibling property of Node, but it ignores Text and Comment nodes and only returns Elements.

readonly long offsetHeight

readonly long offsetWidth

The height and width, in pixels, of the element and all its content, including the element’s CSS padding and border, but not its margin.

readonly long offsetLeft

readonly long offsetTop

The X and Y coordinates of the upper left corner of the CSS border of the element relative to the offsetParent container element.

readonly Element offsetParent

Specifies the container element that defines the coordinate system in which offsetLeft and offsetTop are measured. For most elements, offsetParent is the <body> element that contains them. However, if an element has a dynamically positioned container, the dynamically positioned element is the offsetParent, and if the element is in a table, a <td>, <th>, or <table> element may be the offsetParent. See More on Element Size, Position and Overflow.

string outerHTML

The HTML or XML markup that defines this element and its children. If you set this property to a string, you replace this element (and all of its content) with the result of parsing the new value as an HTML or XML document fragment.

readonly string prefix

The namespace prefix for this element. This is usually null, unless you are working with an XML document that uses namespaces.

readonly Element previousElementSibling

This property is like the previousSibling property of Node, but it ignores Text and Comment nodes and only returns Elements.

readonly long scrollHeight

readonly long scrollWidth

The overall height and width, in pixels, of an element. When an element has scrollbars (because of the CSS overflow attribute, for example), these properties differ from offset Height and offsetWidth, which simply report the size of the visible portion of the element.

long scrollLeft

long scrollTop

The number of pixels that have scrolled off the left edge of the element or off the top edge of the element. These properties are useful only for elements with scrollbars, such as elements with the CSS overflow attribute set to auto. When these properties are queried on the <html> element (see Document.documentElement), they specify the amount of scrolling for the document as a whole. Note that these properties do not specify the amount of scrolling in an <iframe> tag. You can set these properties to scroll an element or the entire document. See More on Element Size, Position and Overflow.

readonly CSSStyleDeclaration style

The value of the style attribute that specifies inline CSS styles for this element. Note that the value of this property is not a string but an object with read/write properties that correspond to CSS style attributes. See CSSStyleDeclaration for details.

readonly string tagName

The tag name of the element. For HTML documents, the tag name is returned in uppercase, regardless of its capitalization in the document source, so a <p> element would have a tagName property of「P」. XML documents are case-sensitive, and the tag name is returned exactly as it is written in the document source. This property has the same value as the inherited nodeName property of the Node interface.

string title

The value of the title attribute of the element. Many browsers display the value of this attribute in a tool tip when the mouse hovers over the element.

Methods

void blur()

This method transfers keyboard focus to the body element of the containing Document object.

void click()

This method simulates a click on this element. If clicking on this element would normally make something happen (following a link, for example), this method makes that happen, too. Otherwise, calling this method just triggers a click event on the element.

void focus()

Transfer keyboard focus to this element.

string getAttribute(string qualifiedName)

getAttribute() returns the value of a named attribute of an element or null if no attribute with that name exists. Note that the HTMLElement object defines JavaScript properties that match each of the standard HTML attributes, so you need to use this method with HTML documents only if you are querying the value of nonstandard attributes. In HTML documents, attribute name comparisons are case-insensitive.

In XML documents, attribute values are not available directly as element properties and must be looked up by calling this method. For XML documents that use namespaces, include the namespace prefix and colon in the attribute name passed to this method or use get AttributeNS() instead.

string getAttributeNS(string namespace, string localName)

This method works just like the getAttribute() method, except that the attribute is specified by a combination of namespace URI and local name within that namespace.

ClientRect getBoundingClientRect()

Returns a ClientRect object that describes the bounding box of this element.

ClientRect[] getClientRects()

Returns an array-like object of ClientRects that describes one or more rectangles occupied by this element. (Inline elements that span more than one line usually require more than one rectangle to accurately describe their region of the window.)

NodeList getElementsByClassName(string classNames)

Returns an array-like object of descendant elements that have a class attribute that includes all of the specified classNames. classNames may be a single class or a space-separated list of classes. The returned NodeList object is live and is automatically updated as the document changes. The elements in the returned NodeList appear in the same order as they appear in the document. Note that this method is also defined on Document.

NodeList getElementsByTagName(string qualifiedName)

This method traverses all descendants of this element and returns an live array-like NodeList of Element nodes representing all document elements with the specified tag name. The elements in the returned array appear in the same order in which they appear in the source document.

Note that Document objects also have a getElementsByTagName() method that works just like this one but that traverses the entire document, rather than just the descendants of a single element.

NodeList getElementsByTagNameNS(string namespace, string localName)

This method works like getElementsByTagName(), except that the tag name of the desired elements is specified as a combination of a namespace URI and a local name defined within that namespace.

boolean hasAttribute(string qualifiedName)

This method returns true if this element has an attribute with the specified name and false otherwise. In HTML documents, attribute names are case-insensitive.

boolean hasAttributeNS(string namespace, string localName)

This method works like hasAttribute(), except that the attribute is specified by namespace URI and local name within that namespace.

void insertAdjacentHTML(string position, string text)

This method inserts the specified HTML markup text at the specified position relative to this element. The position argument must be one of these four strings:

PositionMeaning

beforebegin Insert the text before the opening tag

afterend Insert the text after the closing tag

afterbegin Insert the text right after the opening tag

beforeend Insert the text right before the closing tag

Element querySelector(string selectors)

Returns the first descendant of this element that matches the specified CSS selectors (this may be a single CSS selector or a comma-separated group of selectors).

NodeList querySelectorAll(string selectors)

Returns an array-like object containing all descendants of this Element that match the specified selectors (this may be a single CSS selector or a comma-separated group of selectors). Unlike the NodeList returned by getElementsByTagName(), the NodeList returned by this method is not live: it is just a static snapshot of the elements that matched when the method was called.

void removeAttribute(string qualifiedName)

removeAttribute() deletes a named attribute from this element. Attempts to remove nonexistent attributes are silently ignored. In HTML documents, attribute names are case-insensitive.

void removeAttributeNS(string namespace, string localName)

removeAttributeNS() works just like removeAttribute(), except that the attribute to be removed is specified by namespace URI and local name.

void scrollIntoView([boolean top])

If an HTML element is not currently visible in the window, this method scrolls the document so that it becomes visible. The top argument is an optional hint about whether the element should be positioned near the top or bottom of the window. If true or omitted, the browser will attempt to position the element near the top. If false, the browser will attempt to position the element near the bottom. For elements that accept the keyboard focus, such as Input elements, the focus() method implicitly performs this same scroll-into-view operation. See also the scrollTo() method of Window.

void setAttribute(string qualifiedName, string value)

This method sets the specified attribute to the specified value. If no attribute by that name already exists, a new one is created. In HTML documents, the attribute name is converted to lowercase before being set. Note that HTMLElement objects of an HTML document define JavaScript properties that correspond to all standard HTML attributes, and you can set attributes directly with those properties. Thus, you need to use this method only if you want to set a nonstandard attribute.

void setAttributeNS(string namespace, string qualifiedName, string value)

This method is like setAttribute(), except that the attribute to be created or set is specified with a namespace URI and a qualified name that consists of a namespace prefix, a colon, and a local name within the namespace.

Event Handlers

Element objects that represent HTML elements define quite a few event handler properties. Set any of the properties listed below to a function, and that function will be invoked when a specific type of event occurs on (or bubbles up to) the element. You can also use the methods defined by EventTarget to register event handlers, of course.

Most events bubble up the document hierarchy to the Document node, and then on from there to the Window object. So each of the event handler properties listed here are also defined on the Document and Window object. The Window object has quite a few event handlers of its own, however, and the properties marked with an asterisk in the table below have a different meaning on the Window object. For historical reasons, event handlers registered as HTML attributes of the <body> element are registered on the Window object, and this means that the handler properties with asterisks have a different meaning on the <body> element than they do on other elements. See Window.

Many of the events listed here are only triggered on certain types of HTML elements. But because most of those events bubble up the document tree, the event handler properties are defined generically for all elements. The HTML5 media events fired on <audio> and <video> tags do not bubble, so they are documented in MediaElement. Similarly, some HTML5 form-related events do not bubble and are covered under FormControl.

Event HandlerInvoked When...

onabort resource loading canceled at user’s request

onblur* element loses input focus

onchange user changes form control content or state (fired for complete edits, not individual keystrokes)

onclick element activated by mouse click or other means

oncontextmenu context menu is about to be displayed, usually because of a right-click

ondblclick two rapid mouse clicks occur

ondrag drag continues (triggered on drag source)

ondragend drag ends (triggered on drag source)

ondragenter drag enters (triggered on drop target)

ondragleave drag leaves (triggered on drop target)

ondragover drag continues (triggered on drop target)

ondragstart user initiates drag-and-drop (triggered on drag source)

ondrop user completes drag-and-drop (triggered on drop target)

onerror* resource loading failed (usually because of a network error)

onfocus* element gains keyboard focus

oninput input occurs on a form element (triggered more frequently than onchange)

onkeydown the user presses a key

onkeypress a keypress generates a printable character

onkeyup the user releases a key

onload* resource loading (e.g., for <img>) has completed

onmousedown the user presses a mouse button

onmousemove the user moves the mouse

onmouseout the mouse leaves an element

onmouseover the mouse enters an element

onmouseup the user releases a mouse button

onmousewheel the user rotates the mouse wheel

onreset a <form> is reset

onscroll* an element with scrollbars is scrolled

onselect the user selects text in a form element

onsubmit when a <form> is submitted

HTML Elements and Attributes

This reference section includes individual reference pages for the following HTML element types:

Element(s)Reference PageElement(s)Reference Page

<audio> Audio <output> Output

<button>, <input type="button"> Button <progress> Progress

<canvas> Canvas <script> Script

<fieldset> FieldSet <select> Select

