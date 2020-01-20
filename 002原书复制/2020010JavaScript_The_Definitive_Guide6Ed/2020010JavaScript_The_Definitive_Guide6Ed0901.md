Relationships Between Frames

As we saw above, the open() method of a Window object returns a new Window object that has an opener property that refers back to the original window. In this way, the two windows can refer to each other, and each can read properties and invoke methods of the other. A similar thing is possible with frames. Code running in a window or frame can refer to the containing window or frame and to nested child frames using the properties described below.

You already know that the JavaScript code in any window or frame can refer to its own Window object as window or as self. A frame can refer to the Window object of the window or frame that contains it using the parent property:

parent.history.back();

A Window object that represents a top-level window or tab has no container, and its parent property simply refers to the window itself:

parent == self; // For any top-level window

If a frame is contained within another frame that is contained within a top-level window, that frame can refer to the top-level window as parent.parent. The top property is a general-case shortcut, however: no matter how deeply a frame is nested, its top property refers to the top-level containing window. If a Window object represents a top-level window, top simply refers to that window itself. For frames that are direct children of a top-level window, the top property is the same as the parent property.

The parent and top properties allow a script to refer to its frame’s ancestors. There is more than one way to refer to the descendant frames of a window or frame. Frames are created with <iframe> elements. You can obtain an Element object that represents an <iframe> just as you would do for any other element. Suppose your document contains <iframe id="f1">. Then, the Element object that represents this iframe is:

var iframeElement = document.getElementById("f1");

<iframe> elements have a contentWindow property that refers to the Window object of the frame, so the Window object for this frame is:

var childFrame = document.getElementById("f1").contentWindow;

You can go in the reverse direction—from the Window that represents a frame to the <iframe> Element that contains the frame—with the frameElement property of the Window. Window objects that represent top-level windows rather than frames have a null frameElement property:

var elt = document.getElementById("f1"); var win = elt.contentWindow; win.frameElement === elt // Always true for frames window.frameElement === null // For toplevel windows

It is not usually necessary to use the getElementById() method and the contentWindow property to obtain references to the child frames of a window, however. Every Window object has a frames property that refers to the child frames contained within the window or frame. The frames property refers to an array-like object that can be indexed numerically or by frame name. To refer to the first child frame of a window, you can use frames[0]. To refer to the third child frame of the second child, you can use frames[1].frames[2]. Code running in a frame might refer to a sibling frame as parent.frames[1]. Note that the elements of the frames[] array are Window objects, not <iframe> elements.

If you specify the name or id attribute of an <iframe> element, that frame can be indexed by name as well as by number. A frame named「f1」would be frames["f1"] or frames.f1, for example.

Recall from Document Elements As Window Properties that the names or IDs of <iframe> and other elements are automatically used as properties of the Window object, and that <iframe> elements are treated differently than other elements: for frames, the value of these automatically created properties refer to a Window object rather than an Element object. What this means is that we can refer to a frame named「f1」as f1 instead of as frames.f1. In fact, HTML5 specifies that the frames property is a self-referential property, just like window and self, and that it is the Window object itself that acts like an array of frames. This means that we can refer to the first child frame as window[0], and we can query the number of frames with window.length or just length. It is usually clearer, and still traditional, to use frames instead of window here, however. Note that current browsers do not all make frame==window, but those that do not make them equal do allow child frames to be indexed by number or by name through either object.

You can use the name or id attribute of an <iframe> element to give the frame a name that can be used in JavaScript code. If you use the name attribute, however, the name you specify also becomes the value of the name property of the Window that represents the frame. A name specified in this way can be used as the target attribute of a link, and it can be used as the second argument to window.open().

JavaScript in Interacting Windows

Each window or frame is its own JavaScript execution context with a Window as its global object. But if code in one window or frame can refer to another window or frame (and if the same-origin policy does not prevent it), the scripts in one window or frame can interact with the scripts in the other.

Imagine a web page with two <iframe> elements named「A」and「B」, and suppose that those frames contain documents from the same server and that those documents contain interacting scripts. The script in frame A might define a variable i:

var i = 3;

That variable is nothing more than a property of the global object—a property of the Window object. Code in frame A can refer to the variable with the identifier i, or it can explicitly reference it through the window object:

window.i

Since the script in frame B can refer to the Window object for frame A, it can also refer to the properties of that window object:

parent.A.i = 4; // Change the value of a variable in frame A

Recall that the function keyword that defines functions creates a variable just like the var keyword does. If a script in frame B declares a (non-nested) function f, that function is a global variable in frame B, and code in frame B can invoke f as f(). Code in frame A, however, must refer to f as a property of the Window object of frame B:

parent.B.f(); // Invoke a function defined in frame B

If the code in frame A needs to use this function frequently, it might assign the function to a variable of frame A so that it can more conveniently refer to the function:

var f = parent.B.f;

Now code in frame A can invoke the function as f(), just as code in frame B does.

When you share functions between frames or windows like this, it is important to keep the rules of lexical scoping in mind. A function is executed in the scope in which it was defined, not in the scope from which it is invoked. Thus, if the function f above refers to global variables, these variables are looked up as properties of frame B, even when the function is invoked from frame A.

Remember that constructors are also functions, so when you define a class (see Chapter 9) with a constructor function and an associated prototype object, that class is defined only within a single window. Suppose that the window that contains frames A and B includes the Set class from Example 9-6.

Scripts within that top-level window can create new Set objects like this:

var s = new Set();

But scripts in either of the frames must explicitly refer to the Set() constructor as a property of the parent window:

var s = new parent.Set();

Alternatively, code in either frame can define its own variable to refer more conveniently to the constructor function:

var Set = top.Set(); var s = new Set();

Unlike user-defined classes, the built-in classes like String, Date, and RegExp are automatically predefined in all windows. This means, however, that each window has an independent copy of the constructor and an independent copy of the prototype object. For example, each window has its own copy of the String() constructor and the String.prototype object. So if you write a new method for manipulating JavaScript strings and then make it a method of the String class by assigning it to the String. prototype object in the current window, all strings created by code in that window can use the new method. However, the new method is not accessible to strings created in other windows.

The fact that each Window has its own prototype objects means that the instanceof operator does not work across windows. instanceof will evaluate to false, for example, when used to compare a string from frame B to the String() constructor from frame A. Array Type describes the related difficulty of determining the type of arrays across windows.

The WindowProxy Object

We’ve noted repeatedly that the Window object is the global object of client-side JavaScript. Technically, however, this is not true. Each time a web browser loads new content into a window or a frame, it must start with a fresh JavaScript execution context, including a newly created global object. But when multiple windows or frames are in use, it is critical that the Window object that refers to a frame or window continue to be a valid reference even if that frame or window loads a new document.

So client-side JavaScript has two important objects. The client-side global object is the top of the scope chain and is where global variables and functions are defined. This global object is, in fact, replaced whenever the window or frame loads new content. The object we have been calling the Window object is not actually the global object, but a proxy for it. Whenever you query or set a property of the Window object, that object queries or sets the same property on the current global object of the window or frame. The HTML5 specification calls this proxy object WindowProxy, but we will continue to use the term Window object in this book.

Because of its proxying behavior, the proxy object behaves just like the true global object, except that it has a longer lifetime. If you could compare the two objects, it would be difficult to distinguish them. In fact, however, there is no way to refer to the true client-side global object. The global object is at the top of the scope chain, but the window, self, top, parent, and frames properties all return proxy objects. The window. open() method returns a proxy object. Even the value of the this keyword within a top-level function is a proxy object rather than the true global object.[28]

* * *

[28] This last point is a minor violation of the ES3 and ES5 specifications, but it is necessary to support the multiple execution contexts of client-side JavaScript.

Chapter 15. Scripting Documents

Client-side JavaScript exists to turn static HTML documents into interactive web applications. Scripting the content of web pages is the central purpose of JavaScript. This chapter—one of the most important in the book—explains how to do this.

Chapters 13 and 14 explained that every web browser window, tab, and frame is represented by a Window object. Every Window object has a document property that refers to a Document object. The Document object represents the content of the window, and it is the subject of this chapter. The Document object does not stand alone, however. It is the central object in a larger API, known as the Document Object Model , or DOM, for representing and manipulating document content.

This chapter begins by explaining the basic architecture of the DOM. It then moves on to explain:

How to query or select individual elements from a document.

How to traverse a document as a tree of nodes, and how to find the ancestors, siblings, and descendants of any document element.

How to query and set the attributes of document elements.

How to query, set, and modify the content of a document.

How to modify the structure of a document by creating, inserting, and deleting nodes.

How to work with HTML forms.

The final section of the chapter covers miscellaneous document features, including the referrer property, the write() method, and techniques for querying the currently selected document text.

Overview of the DOM

The Document Object Model, or DOM, is the fundamental API for representing and manipulating the content of HTML and XML documents. The API is not particularly complicated, but there are a number of architectural details you need to understand. First, you should understand that the nested elements of an HTML or XML document are represented in the DOM as a tree of objects. The tree representation of an HTML document contains nodes representing HTML tags or elements, such as <body> and <p>, and nodes representing strings of text. An HTML document may also contain nodes representing HTML comments. Consider the following simple HTML document:

<html> <head> <title>Sample Document</title> </head> <body> <h1>An HTML Document</h1> <p>This is a <i>simple</i> document. </html>

The DOM representation of this document is the tree pictured in Figure 15-1.

Figure 15-1. The tree representation of an HTML document

If you are not already familiar with tree structures in computer programming, it is helpful to know that they borrow terminology from family trees. The node directly above a node is the parent of that node. The nodes one level directly below another node are the children of that node. Nodes at the same level, and with the same parent, are siblings. The set of nodes any number of levels below another node are the descendants of that node. And the parent, grandparent, and all other nodes above a node are the ancestors of that node.

Each box in Figure 15-1 is a node of the document and is represented by a Node object. We’ll talk about the properties and methods of Node in some of the sections that follow, and you can look up those properties and methods under Node in Part IV. Note that the figure contains three different types of nodes. At the root of the tree is the Document node that represents the entire document. The nodes that represent HTML elements are Element nodes, and the nodes that represent text are Text nodes. Document, Element, and Text are subclasses of Node and have their own entries in the reference section. Document and Element are the two most important DOM classes, and much of this chapter is devoted to their properties and methods.

Node and its subtypes form the type hierarchy illustrated in Figure 15-2. Notice that there is a formal distinction between the generic Document and Element types, and the HTMLDocument and HTMLElement types. The Document type represents either an HTML or an XML document, and the Element class represents an element of such a document. The HTMLDocument and HTMLElement subclasses are specific to HTML documents and elements. In this book, we often use the generic class names Document and Element, even when referring to HTML documents. This is true in the reference section as well: the properties and methods of the HTMLDocument and the HTMLElement types are documented in the Document and Element reference pages.

Figure 15-2. A partial class hierarchy of document nodes

It is also worth noting in Figure 15-2 that there are many subtypes of HTMLElement that represent specific types of HTML elements. Each defines JavaScript properties to mirror the HTML attributes of a specific element or group of elements (see HTML Attributes As Element Properties). Some of these element-specific classes define additional properties or methods that go beyond simple mirroring of HTML syntax. These classes and their additional features are covered in the reference section.

Finally, note that Figure 15-2 shows some node types that haven’t been mentioned so far. Comment nodes represent HTML or XML comments. Because comments are basically strings of text, these nodes are much like the Text nodes that represent the displayed text of a document. CharacterData, the common ancestor of both Text and Comment, defines methods shared by both nodes. The Attr node type represents an XML or HTML attribute, but it is almost never used because the Element class defines methods for treating attributes as name/value pairs rather than document nodes. The DocumentFragment class (not pictured) is a kind of Node that never exists in an actual document: it represents a sequence of Nodes that do not have a common parent. DocumentFragments are useful for some document manipulations and are covered in Using DocumentFragments. The DOM also defines infrequently used types to represent things like doctype declarations and XML processing instructions.

Selecting Document Elements

Most client-side JavaScript programs work by somehow manipulating one or more document elements. When these programs start, they can use the global variable document to refer to the Document object. In order to manipulate elements of the document, however, they must somehow obtain or select the Element objects that refer to those document elements. The DOM defines a number of ways to select elements; you can query a document for an element or elements:

with a specified id attribute;

with a specified name attribute;

with the specified tag name;

with the specified CSS class or classes; or

matching the specified CSS selector

The subsections that follow explain each of these element selection techniques.

Selecting Elements By ID

Any HTML element can have an id attribute. The value of this attribute must be unique within the document—no two elements in the same document can have the same ID. You can select an element based on this unique ID with the getElementById() method of the Document object. We’ve already used this method in both Chapter 13 and Chapter 14:

var section1 = document.getElementById("section1");

This is the simplest and most commonly used way to select elements. If your script is going to manipulate a certain specific set of document elements, give those elements id attributes, and look up the Element objects using that ID. If you need to look up more than one element by ID, you might find the getElements() function of Example 15-1 useful.

Example 15-1. Looking up multiple elements by ID

/** * This function expects any number of string arguments. It treats each * argument as an element id and calls document.getElementById() for each. * Returns an object that maps ids to the corresponding Element object. * Throws an Error object if any of the ids is undefined. */ function getElements(/*ids...*/) { var elements = {}; // Start with an empty map for(var i = 0; i < arguments.length; i++) { // For each argument var id = arguments[i]; // Argument is an element id var elt = document.getElementById(id); // Look up the Element if (elt == null) // If not defined, throw new Error("No element with id: " + id); // throw an error elements[id] = elt; // Map id to element } return elements; // Return id to element map }

In versions of Internet Explorer prior to IE8, getElementById() does a case-insensitive match on element IDs and also returns elements that have a matching name attribute.

Selecting Elements by Name

The HTML name attribute was originally intended to assign names to form elements, and the value of this attribute is used when form data is submitted to a server. Like the id attribute, name assigns a name to an element. Unlike id, however, the value of a name attribute does not have to be unique: multiple elements may have the same name, and this is common in the case of radio buttons and checkboxes in forms. Also, unlike id, the name attribute is only valid on a handful of HTML elements, including forms, form elements, <iframe>, and <img> elements.

To select HTML elements based on the value of their name attributes, you can use the getElementsByName() method of the Document object:

var radiobuttons = document.getElementsByName("favorite_color");

getElementsByName() is defined by the HTMLDocument class, not the Document class, and so it is only available for HTML documents, not XML documents. It returns a NodeList object that behaves like a read-only array of Element objects. In IE, get Elements ByName() will also return elements that have an id attribute with the specified value. For compatibility, you should be careful not to use the same string as both a name and an ID.

We saw in Document Elements As Window Properties that setting the name attribute of certain HTML elements automatically created properties with those names on the Window object. A similar thing is true for the Document object. Setting the name attribute of a <form>, <img>, <iframe>, <applet> , <embed>, or <object> element (but only <object> elements that do not have fallback objects within them) creates a property of the Document object whose name is the value of the attribute (assuming, of course, that the document does not already have a property with that name).

If there is only a single element with a given name, the value of the automatically created document property is the element itself. If there is more than one element, then the value of the property is a NodeList object that acts as an array of elements. As we saw in Document Elements As Window Properties, the document properties created for named <iframe> elements are special: instead of referring to the Element object, they refer to the frame’s Window object.

What this means is that some elements can be selected by name simply by using the name as a Document property:

// Get the Element object for the <form name="shipping_address"> element var form = document.shipping_address;

The reasons given in Document Elements As Window Properties for not using the automatically created window properties apply equally to these automatically created document properties. If you need to look up named elements, it is better to look them up explicitly with a call to getElementsByName().

Selecting Elements by Type

You can select all HTML or XML elements of a specified type (or tag name) using the getElementsByTagName() method of the Document object. To obtain a read-only array-like object containing the Element objects for all <span> elements in a document, for example, you might write:

var spans = document.getElementsByTagName("span");

Like getElementsByName(), getElementsByTagName() returns a NodeList object. (See the sidebar in this section for more on the NodeList class.) The elements of the returned NodeList are in document order, so you can select the first <p> element of a document like this:

var firstpara = document.getElementsByTagName("p")[0];

HTML tags are case-insensitive, and when getElementsByTagName() is used on an HTML document, it performs a case-insensitive tag name comparison. The spans variable above, for example, will include any <span> elements that were written as <SPAN>.

You can obtain a NodeList that represents all elements in a document by passing the wildcard argument「*」to getElementsByTagName().

The Element class also defines a getElementsByTagName() method. It works in the same way as the Document version, but it only selects elements that are descendants of the element on which it is invoked. So to find all <span> elements inside the first <p> element of a document, you could write:

var firstpara = document.getElementsByTagName("p")[0]; var firstParaSpans = firstpara.getElementsByTagName("span");

For historical reasons, the HTMLDocument class defines shortcut properties to access certain kinds of nodes. The images, forms, and links properties, for example, refer to objects that behave like read-only arrays of <img>, <form>, and <a> elements (but only <a> tags that have an href attribute). These properties refer to HTMLCollection objects, which are much like NodeList objects, but they can additionally be indexed by element ID or name. Earlier, we saw how you could refer to a named <form> element with an expression like this:

document.shipping_address

With the document.forms property, you can also refer more specifically to the named (or ID’ed) form like this:

document.forms.shipping_address;

The HTMLDocument object also defines synonymous embeds and plugins properties that are HTMLCollections of <embed> elements. The anchors property is nonstandard but refers to <a> elements that have a name attribute rather than an href attribute. The <scripts> property is standardized by HTML5 to be an HTMLCollection of <script> elements, but it is not, at the time of this writing, universally implemented.

HTMLDocument also defines two properties that refer to special single elements rather than element collections. document.body is the <body> element of an HTML document, and document.head is the <head> element. These properties are always defined: if the document source does not explicitly include <head> and <body> elements, the browser creates them implicitly. The documentElement property of the Document class refers to the root element of the document. In HTML documents, this is always an <html> element.

NodeLists and HTMLCollections

getElementsByName() and getElementsByTagName() return NodeList objects, and properties like document.images and document.forms are HTMLCollection objects.

These objects are read-only array-like objects (see Array-Like Objects). They have length properties and can be indexed (for reading but not writing) like true arrays. You can iterate the contents of a NodeList or HTMLCollection with a standard loop like this:

for(var i = 0; i < document.images.length; i++) // Loop through all images document.images[i].style.display = "none"; // ...and hide them.

You cannot invoke Array methods on NodeLists and HTMLCollections directly, but you can do so indirectly:

var content = Array.prototype.map.call(document.getElementsByTagName("p"), function(e) { return e.innerHTML; });

HTMLCollection objects may have additional named properties and can be indexed with strings as well as numbers.

For historical reasons, both NodeList and HTMLCollection objects can also be treated as functions: invoking them with a number or string argument is the same as indexing them with a number or string. Use of this quirk is discouraged.

Both the NodeList and HTMLCollection interfaces were designed with languages less dynamic than JavaScript in mind. Both define an item() method. It expects an integer and returns the element at that index. There is never any need to call this method in JavaScript because you can simply use array indexing instead. Similarly, HTMLCollection defines a namedItem() method that returns the value of a named property, but JavaScript programs can use array indexing or regular property access instead.

One of the most important and surprising features of NodeList and HTMLCollection is that they are not static snapshots of a historical document state but are generally live and the list of elements they contain can vary as the document changes. Suppose you call getElementsByTagName('div') on a document with no <div> elements. The return value is a NodeList with a length of 0. If you then insert a new <div> element into the document, that element automatically becomes a member of the NodeList, and the length property changes to 1.

Usually, the liveness of NodeLists and HTMLCollections is quite helpful. If you will be adding or removing elements from the document while iterating through a NodeList, however, you may want to make a static copy of the NodeList first:

var snapshot = Array.prototype.slice.call(nodelist, 0);

Selecting Elements by CSS Class

The class attribute of an HTML is a space-separated list of zero or more identifiers. It describes a way to define sets of related document elements: any elements that have the same identifier in their class attribute are part of the same set. class is a reserved word in JavaScript, so client-side JavaScript uses the className property to hold the value of the HTML class attribute. The class attribute is usually used in conjunction with a CSS stylesheet to apply the same presentation styles to all members of a set, and we’ll see it again in Chapter 16. In addition, however, HTML5 defines a method, getElements ByClassName(), that allows us to select sets of document elements based on the identifiers in their class attribute.

Like getElementsByTagName(), getElementsByClassName() can be invoked on both HTML documents and HTML elements, and it returns a live NodeList containing all matching descendants of the document or element. getElementsByClassName() takes a single string argument, but the string may specify multiple space-separated identifiers. Only elements that include all of the specified identifiers in their class attribute are matched. The order of the identifiers does not matter. Note that both the class attribute and the getElementsByClassName() methods separate class identifiers with spaces, not with commas. Here are some examples of getElementsByClassName():

// Find all elements that have "warning" in their class attribute var warnings = document.getElementsByClassName("warning");// Find all descendants of the element named "log" that have the class // "error" and the class "fatal" var log = document.getElementById("log"); var fatal = log.getElementsByClassName("fatal error");

Today’s web browsers display HTML documents in「quirks mode」or「standards mode」depending on how strict the <!DOCTYPE> declaration at the start of the document is. Quirks mode exists for backward compatibility, and one of its quirks is that class identifiers in the class attribute and in CSS stylesheets are case-insensitive. getElements ByClassName() follows the matching algorithm used by stylesheets. If the document is rendered in quirks mode, the method performs a case-insensitive string comparison. Otherwise, the comparison is case sensitive.

At the time of this writing, getElementsByClassName() is implemented by all current browsers except IE8 and earlier. IE8 does support querySelectorAll(), described in the next section, and getElementsByClassName() can be implemented on top of that method.

Selecting Elements with CSS Selectors

CSS stylesheets have a very powerful syntax, known as selectors, for describing elements or sets of elements within a document. Full details of CSS selector syntax are beyond the scope of this book,[29] but some examples will demonstrate the basics. Elements can be described by ID, tag name, or class:

#nav // An element with id="nav" div // Any <div> element .warning // Any element with "warning" in its class attribute

More generally, elements can be selected based on attribute values:

p[lang="fr"] // A paragraph written in French: <p lang="fr"> *[name="x"] // Any element with a name="x" attribute

These basic selectors can be combined:

span.fatal.error // Any <span> with "warning" and "fatal" in its class span[lang="fr"].warning // Any warning in French

Selectors can also specify document structure:

#log span // Any <span> descendant of the element with id="log" #log>span // Any <span> child of the element with id="log" body>h1:first-child // The first <h1> child of the <body>

Selectors can be combined to select multiple elements or multiple sets of elements:

div, #log // All <div> elements plus the element with id="log"

As you can see, CSS selectors allow elements to be selected in all of the ways described above: by ID, by name, by tag name, and by class name. Along with the standardization of CSS3 selectors, another W3C standard, known as「Selectors API」defines JavaScript methods for obtaining the elements that match a given selector.[30] The key to this API is the Document method querySelectorAll(). It takes a single string argument containing a CSS selector and returns a NodeList that represents all elements in the document that match the selector. Unlike previously described element selection methods, the NodeList returned by querySelectorAll() is not live: it holds the elements that match the selector at the time the method was invoked, but it does not update as the document changes. If no elements match, querySelectorAll() returns an empty NodeList. If the selector string is invalid, querySelectorAll() throws an exception.

In addition to querySelectorAll(), the document object also defines querySelector(), which is like querySelectorAll(), but returns only the first (in document order) matching element or null if there is no matching element.

These two methods are also defined on Elements (and also on DocumentFragment nodes; see Using DocumentFragments). When invoked on an element, the specified selector is matched against the entire document, and then the result set is filtered so that it only includes descendants of the specified element. This may seem counterintuitive, as it means that the selector string can include ancestors of the element against which it is matched.

Note that CSS defines :first-line and :first-letter pseudoelements. In CSS, these match portions of text nodes rather than actual elements. They will not match if used with querySelectorAll() or querySelector(). Also, many browsers will refuse to return matches for the :link and :visited pseudoclasses, as this could expose information about the user’s browsing history.

All current browsers support querySelector() and querySelectorAll(). Note, however, that the specification of these methods does not require support for CSS3 selectors: browsers are encouraged to support the same set of selectors that they support in stylesheets. Current browsers other than IE support CSS3 selectors. IE7 and 8 support CSS2 selectors. (IE9 is expected to have CSS3 support.)

querySelectorAll() is the ultimate element selection method: it is a very powerful technique by which client-side JavaScript programs can select the document elements that they are going to manipulate. Fortunately, this use of CSS selectors is available even in browsers without native support for querySelectorAll(). The jQuery library (see Chapter 19) uses this kind of CSS selector-based query as its central programming paradigm. Web applications based on jQuery use a portable, cross-browser equivalent to querySelectorAll() named $().

jQuery’s CSS selector matching code has been factored out and released as a stand-alone library named Sizzle, which has been adopted by Dojo and other client-side libraries.[31] The advantage to using a library like Sizzle (or a library that uses Sizzle) is that selections work even on older browsers, and there is a baseline set of selectors that are guaranteed to work on all browsers.

document.all[]

Before the DOM was standardized, IE4 introduced the document.all[] collection that represented all elements (but not Text nodes) in the document. document.all[] has been replaced by standard methods like getElementById() and getElementsByTagName() and is now obsolete and should not be used. When introduced, however, it was revolutionary, and you may still see existing code that uses it in any of these ways:

document.all[0] // The first element in the document document.all["navbar"] // Element (or elements) with id or name "navbar" document.all.navbar // Ditto document.all.tags("div") // All <div> elements in the document document.all.tags("p")[0] // The first <p> in the document

* * *

[29] CSS3 selectors are specified by http://www.w3.org/TR/css3-selectors/.

[30] The Selectors API standard is not part of HTML5 but is closely affiliated with it. See http://www.w3.org/TR/selectors-api/.

[31] A stand-alone version of Sizzle is available at http://sizzlejs.com.

Document Structure and Traversal

Once you have selected an Element from a Document, you sometimes need to find structurally related portions (parent, siblings, children) of the document. A Document can be conceptualized as a tree of Node objects, as illustrated in Figure 15-1. The Node type defines properties for traversing such a tree, which we’ll cover in Documents As Trees of Nodes. Another API allows documents to be traversed as trees of Element objects. Documents As Trees of Elements covers this newer (and often easier-to-use) API.

Documents As Trees of Nodes

The Document object, its Element objects, and the Text objects that represent runs of text in the document are all Node objects. Node defines the following important properties:

parentNode

The Node that is the parent of this one, or null for nodes like the Document object that have no parent.

childNodes

A read-only array-like object (a NodeList) that is a live representation of a Node’s child nodes.

firstChild, lastChild

The first and last child nodes of a node, or null if the node has no children.

nextSibling, previousSibling

The next and previous sibling node of a node. Two nodes with the same parent are siblings. Their order reflects the order in which they appear in the document. These properties connect nodes in a doubly linked list.

nodeType

The kind of node this is. Document nodes have the value 9. Element nodes have the value 1. Text nodes have the value 3. Comments nodes are 8 and DocumentFragment nodes are 11.

nodeValue

The textual content of a Text or Comment node.

nodeName

The tag name of an Element, converted to uppercase.

Using these Node properties, the second child node of the first child of the Document can be referred to with expressions like these:

document.childNodes[0].childNodes[1] document.firstChild.firstChild.nextSibling

Suppose the document in question is the following:

<html><head><title>Test</title></head><body>Hello World!</body></html>

Then the second child of the first child is the <body> element. It has a nodeType of 1 and a nodeName of「BODY」.

Note, however, that this API is extremely sensitive to variations in the document text. If the document is modified by inserting a single newline between the <html> and the <head> tag, for example, the Text node that represents that newline becomes the first child of the first child, and the second child is the <head> element instead of the <body> body.

Documents As Trees of Elements

When we are primarily interested in the Elements of a document instead of the text within them (and the whitespace between them), it is helpful to use an API that allows us to treat a document as a tree of Element objects, ignoring Text and Comment nodes that are also part of the document.

The first part of this API is the children property of Element objects. Like childNodes, this is a NodeList. Unlike childNodes, however, the children list contains only Element objects. The children property is nonstandard, but it works in all current browsers. IE has implemented it for a long time, and most other browsers have followed suit. The last major browser to adopt it was Firefox 3.5.

Note that Text and Comment nodes cannot have children, which means that the Node.parentNode property described above never returns a Text or Comment node. The parentNode of any Element will always be another Element, or, at the root of the tree, a Document or DocumentFragment.

The second part of an element-based document traversal API is Element properties that are analogs to the child and sibling properties of the Node object:

firstElementChild, lastElementChild

Like firstChild and lastChild, but for Element children only.

nextElementSibling, previousElementSibling

Like nextSibling and previousSibling, but for Element siblings only.

childElementCount

The number of element children. Returns the same value as children.length.

These child and sibling properties are standardized and are implemented in all current browsers except IE.[32]

Because the API for element-by-element document traversal is not yet completely universal, you might want to define portable traversal functions like those in Example 15-2.

Example 15-2. Portable document traversal functions

/** * Return the nth ancestor of e, or null if there is no such ancestor * or if that ancestor is not an Element (a Document or DocumentFragment e.g.). * If n is 0 return e itself. If n is 1 (or * omitted) return the parent. If n is 2, return the grandparent, etc. */ function parent(e, n) { if (n === undefined) n = 1; while(n-- && e) e = e.parentNode; if (!e || e.nodeType !== 1) return null; return e; } /** * Return the nth sibling element of Element e. * If n is postive return the nth next sibling element. * If n is negative, return the -nth previous sibling element. * If n is zero, return e itself. */ function sibling(e,n) { while(e && n !== 0) { // If e is not defined we just return it if (n > 0) { // Find next element sibling if (e.nextElementSibling) e = e.nextElementSibling; else { for(e=e.nextSibling; e && e.nodeType !== 1; e=e.nextSibling) /* empty loop */ ; } n--; } else { // Find the previous element sibling if (e.previousElementSibing) e = e.previousElementSibling; else { for(e=e.previousSibling; e&&e.nodeType!==1; e=e.previousSibling) /* empty loop */ ; } n++; } } return e; } /** * Return the nth element child of e, or null if it doesn't have one. * Negative values of n count from the end. 0 means the first child, but * -1 means the last child, -2 means the second to last, and so on. */ function child(e, n) { if (e.children) { // If children array exists if (n < 0) n += e.children.length; // Convert negative n to array index if (n < 0) return null; // If still negative, no child return e.children[n]; // Return specified child } // If e does not have a children array, find the first child and count // forward or find the last child and count backwards from there. if (n >= 0) { // n is non-negative: count forward from the first child // Find the first child element of e if (e.firstElementChild) e = e.firstElementChild; else { for(e = e.firstChild; e && e.nodeType !== 1; e = e.nextSibling) /* empty */; } return sibling(e, n); // Return the nth sibling of the first child } else { // n is negative, so count backwards from the end if (e.lastElementChild) e = e.lastElementChild; else { for(e = e.lastChild; e && e.nodeType !== 1; e=e.previousSibling) /* empty */; } return sibling(e, n+1); // +1 to convert child -1 to sib 0 of last } }

Defining Custom Element Methods

All current browsers (including IE8, but not IE7 and before) implement the DOM so that types like Element and HTMLDocument[33] are classes like String and Array. They are not constructors (we’ll see how to create new Element objects later in the chapter), but they have prototype objects and you can extend them with custom methods:

Element.prototype.next = function() { if (this.nextElementSibling) return this.nextElementSibling; var sib = this.nextSibling; while(sib && sib.nodeType !== 1) sib = sib.nextSibling; return sib; };

The functions of Example 15-2 are not defined as Element methods because this technique is not supported by IE7.

This ability to extend DOM types is still useful, however, if you want to implement IE-specific features in browsers other than IE. As noted above, the nonstandard Element property children was introduced by IE and has been adopted by other browsers. You can use code like this to simulate it in browsers like Firefox 3.0 that do not support it:

// Simulate the Element.children property in non-IE browsers that don't have it // Note that this returns a static array rather than a live NodeList if (!document.documentElement.children) { Element.prototype.__defineGetter__("children", function() { var kids = []; for(var c = this.firstChild; c != null; c = c.nextSibling) if (c.nodeType === 1) kids.push(c); return kids; }); }

The __defineGetter__ method (covered in Legacy API for Getters and Setters) is completely nonstandard, but it is perfect for portability code like this.

* * *

[32] http://www.w3.org/TR/ElementTraversal.

[33] IE8 supports extendable prototypes for Element, HTMLDocument, and Text, but not for Node, Document, HTMLElement, or any of the more specific HTMLElement subtypes.

Attributes

HTML elements consist of a tag name and a set of name/value pairs known as attributes. The <a> element that defines a hyperlink, for example, uses the value of its href attribute as the destination of the link. The attribute values of HTML elements are available as properties of the HTMLElement objects that represent those elements. The DOM also defines other APIs for getting and setting the values of XML attributes and nonstandard HTML attributes. The subsections that follow have details.

HTML Attributes As Element Properties

The HTMLElement objects that represent the elements of an HTML document define read/write properties that mirror the HTML attributes of the elements. HTMLElement defines properties for the universal HTTP attributes such as id, title lang, and dir, and event handler properties like onclick. Element-specific subtypes define attributes specific to those elements. To query the URL of an image, for example, you can use the src property of the HTMLElement that represents the <img> element:

var image = document.getElementById("myimage"); var imgurl = image.src; // The src attribute is the URL of the image image.id === "myimage" // Since we looked up the image by id

Similarly, you might set the form-submission attributes of a <form> element with code like this:

var f = document.forms[0]; // First <form> in the document f.action = "http://www.example.com/submit.php"; // Set URL to submit it to. f.method = "POST"; // HTTP request type

HTML attributes are not case sensitive, but JavaScript property names are. To convert an attribute name to the JavaScript property, write it in lowercase. If the attribute is more than one word long, however, put the first letter of each word after the first in uppercase: defaultChecked and tabIndex, for example.

Some HTML attribute names are reserved words in JavaScript. For these, the general rule is to prefix the property name with「html」. The HTML for attribute (of the <label> element), for example, becomes the JavaScript htmlFor property.「class」is a reserved (but unused) word in JavaScript, and the very important HTML class attribute is an exception to the rule above: it becomes className in JavaScript code. We’ll see the className property again in Chapter 16.

The properties that represent HTML attributes usually have string value. When the attribute is a boolean or numeric value (the defaultChecked and maxLength attributes of an <input> element, for example), the properties values are booleans or numbers instead of strings. Event handler attributes always have Function objects (or null) as their values. The HTML5 specification defines a few attributes (such as the form attribute of <input> and related elements) that convert element IDs to actual Element objects. Finally, the value of the style property of any HTML element is a CSSStyleDeclaration object rather than a string. We’ll see much more about this important property in Chapter 16.

Note that this property-based API for getting and setting attribute values does not define any way to remove an attribute from an element. In particular, the delete operator cannot be used for this purpose. The section that follows describes a method that you can use to accomplish this.

Getting and Setting Non-HTML Attributes

As described above, HTMLElement and its subtypes define properties that correspond to the standard attributes of HTML elements. The Element type also defines get Attribute() and setAttribute() methods that you can use to query and set nonstandard HTML attributes and to query and set attributes on the elements of an XML document:

var image = document.images[0]; var width = parseInt(image.getAttribute("WIDTH")); image.setAttribute("class", "thumbnail");

The code above highlights two important differences between these methods and the property-based API described above. First, attribute values are all treated as strings. getAttribute() never returns a number, boolean, or object. Second, these methods use standard attribute names, even when those names are reserved words in JavaScript. For HTML elements, the attribute names are case insensitive.

Element also defines two related methods, hasAttribute() and removeAttribute(), which check for the presence of a named attribute and remove an attribute entirely. These methods are particularly useful with boolean attributes: these are attributes (such as the disabled attribute of HTML form elements) whose presence or absence from an element matters but whose value is not relevant.

If you are working with XML documents that include attributes from other namespaces, you can use the namespaced variants of these four methods: getAttributeNS(), setAttributeNS(), hasAttributeNS(), and removeAttributeNS(). Instead of taking a single attribute name string, these methods take two. The first is the URI that identifies the namespace. The second is usually the unqualified local name of the attribute within the namespace. For setAttributeNS() only, however, the second argument is the qualified name of the attribute and includes the namespace prefix. You can read more about these namespace-aware attribute methods in Part IV.

Dataset Attributes

It is sometimes useful to attach additional information to HTML elements, typically when JavaScript code will be selecting those elements and manipulating them in some way. Sometimes this can be done by adding special identifiers to the class attribute. Other times, for more complex data, client-side programmers resort to the use of nonstandard attributes. As noted above, you can use the getAttribute() and set Attribute() methods to read and write the values of nonstandard attributes. The price you pay, however, is that your document will not be valid HTML.

HTML5 provides a solution. In an HTML5 document, any attribute whose name is lowercase and begins with the prefix「data-」is considered valid. These「dataset attributes」will not affect the presentation of the elements on which they appear and they define a standard way to attach additional data without compromising document validity.

HTML5 also defines a dataset property on Element objects. This property refers to an object, which has properties that correspond to the data- attributes with their prefix removed. Thus dataset.x would hold the value of the data-x attribute. Hyphenated attributes map to camel-case property names: the attribute data-jquery-test becomes the property dataset.jqueryTest.

As a more concrete example, suppose that a document contains the following markup:

<span class="sparkline" data-ymin="0" data-ymax="10"> 1 1 1 2 2 3 4 5 5 4 3 5 6 7 7 4 2 1 </span>

A sparkline is a small graphic—often a line plot—designed to be displayed within the flow of text. In order to generate a sparkline, you might extract the value of the dataset attributes above with code like this:

// Assumes the ES5 Array.map() method (or a work-alike) is defined var sparklines = document.getElementsByClassName("sparkline"); for(var i = 0; i < sparklines.length; i++) { var dataset = sparklines[i].dataset; var ymin = parseFloat(dataset.ymin); var ymax = parseFloat(dataset.ymax); var data = sparklines[i].textContent.split(" ").map(parseFloat); drawSparkline(sparklines[i], ymin, ymax, data); // Not yet implemented }

At the time of this writing, the dataset property is not implemented in current browsers, and the code above would have to be written like this:

var sparklines = document.getElementsByClassName("sparkline"); for(var i = 0; i < sparklines.length; i++) { var elt = sparklines[i]; var ymin = parseFloat(elt.getAttribute("data-ymin")); var ymin = parseFloat(elt.getAttribute("data-ymax")); var points = elt.getAttribute("data-points"); var data = elt.textContent.split(" ").map(parseFloat); drawSparkline(elt, ymin, ymax, data); // Not yet implemented }

Note that the dataset property is (or will be, when implemented) a live, two-way interface to the data- attributes of an element. Setting or deleting a property of dataset sets or removes the corresponding data- attribute of the element.

The drawSparkline() function in the above examples is fictitious, but Example 21-13 draws sparklines marked up like this using the <canvas> element.

Attributes As Attr Nodes

There is one more way to work with the attributes of an Element. The Node type defines an attributes property. This property is null for any nodes that are not Element objects. For Element objects, attributes is a read-only array-like object that represents all the attributes of the element. The attributes object is live in the way that NodeLists are. It can be indexed numerically, which means that you can enumerate all the attributes of an element. And it can also be indexed by attribute name:

document.body.attributes[0] // The first attribute of the <body> elt document.body.attributes.bgcolor // The bgcolor attribute of the <body> elt document.body.attributes["ONLOAD"] // The onload attribute of the <body> elt

The values obtained when you index the attributes object are Attr objects. Attr objects are a specialized kind of Node but are never really used like one. The name and value properties of an Attr return the name and value of the attribute.

Element Content

Take a look again at Figure 15-1, and ask yourself what the「content」of the <p> element is. There are three ways we might answer this question:

The content is the HTML string「This is a <i>simple</i> document.」

The content is the plain-text string「This is a simple document.」

The content is a Text node, an Element node that has a Text node child, and another Text node.

Each of these are valid answers, and each answer is useful in its own way. The sections that follow explain how to work with the HTML representation, the plain-text representation, and the tree representation of element content.

Element Content As HTML

Reading the innerHTML property of an Element returns the content of that element as a string of markup. Setting this property on an element invokes the web browser’s parser and replaces the element’s current content with a parsed representation of the new string. (Despite its name, innerHTML can be used with XML elements as well as HTML elements.)

Web browsers are very good at parsing HTML and setting innerHTML is usually fairly efficient, even though the value you specify must be parsed. Note, however, that repeatedly appending bits of text to the innerHTML property with the += operator is usually not efficient because it requires both a serialization step and a parsing step.

innerHTML was introduced in IE4. Although it has long been supported by all browsers, it has only become standardized with the advent of HTML5. HTML5 says that innerHTML should work on Document nodes as well as Element nodes, but this is not universally supported yet.

HTML5 also standardizes a property named outerHTML. When you query outerHTML, the string of HTML or XML markup that is returned includes the opening and closing tags of the element on which you queried it. When you set outerHTML on an element, the new content replaces the element itself. outerHTML is defined only for Element nodes, not Documents. At the time of this writing, outerHTML is supported by all current browsers except Firefox. (See Example 15-5, later in this chapter, for an outerHTML implementation based on innerHTML.)

Another feature introduced by IE and standardized by HTML5 is the insert Adjacent HTML() method, which allows you to insert a string of arbitrary HTML markup「adjacent」to the specified element. The markup is passed as the second argument to this method, and the precise meaning of「adjacent」depends on the value of the first argument. This first argument should be a string with one of the values「beforebegin」,「afterbegin」,「beforeend」or「afterend」. These values correspond to insertion points that are illustrated in Figure 15-3.

Figure 15-3. Insertion points for insertAdjacentHTML()

insertAdjacentHTML() is not supported by current versions of Firefox. Later in this chapter, Example 15-6 shows how to implement insertAdjacentHTML() using the innerHTML property and also demonstrates how to write HTML insertion methods that do not require the insertion position to be specified with a string argument.

Element Content As Plain Text

Sometimes you want to query the content of an element as plain text, or to insert plain-text into a document (without having to escape the angle brackets and ampersands used in HTML markup). The standard way to do this is with the textContent property of Node:

var para = document.getElementsByTagName("p")[0]; // First <p> in the document var text = para.textContent; // Text is "This is a simple document." para.textContent = "Hello World!"; // Alter paragraph content

The textContent property is supported by all current browsers except IE. In IE, you can use the Element property innerText instead. Microsoft introduced innerText in IE4, and it is supported by all current browsers except Firefox.

The textContent and innerText properties are similar enough that you can usually use them interchangeably. Be careful though to distinguish empty elements (the string「」is falsy in JavaScript) from undefined properties:

/** * With one argument, return the textContent or innerText of the element. * With two arguments, set the textContent or innerText of element to value. */ function textContent(element, value) { var content = element.textContent; // Check if textContent is defined if (value === undefined) { // No value passed, so return current text if (content !== undefined) return content; else return element.innerText; } else { // A value was passed, so set text if (content !== undefined) element.textContent = value; else element.innerText = value; } }

The textContent property is a straightforward concatenation of all Text node descendants of the specified element. innerText does not have a clearly specified behavior, but differs from textContent in a few ways. innerText does not return the content of <script> elements. It omits extraneous whitespace and attempts to preserve table formatting. Also, innerText is treated as a read-only property for certain table elements such as <table>, <tbody>, and <tr>.

Text in <script> elements

Inline <script> elements (i.e., those that do not have a src attribute) have a text property that you can use to retrieve their text. The content of a <script> element is never displayed by the browser, and the HTML parser ignores angle brackets and ampersands within a script. This makes a <script> element an ideal place to embed arbitrary textual data for use by your application. Simply set the type attribute of the element to some value (such as「text/x-custom-data」) that makes it clear that the script is not executable JavaScript code. If you do this, the JavaScript interpreter will ignore the script, but the element will exist in the document tree and its text property will return the data to you.

Element Content As Text Nodes

Another way to work with the content of an element is as a list of child nodes, each of which may have its own set of children. When thinking about element content, it is usually the Text nodes that are of interest. In XML documents, you must also be prepared to handle CDATASection nodes—they are a subtype of Text and represent the content of CDATA sections.

Example 15-3 shows a textContent() function that recursively traverses the children of an element and concatenates the text of all the Text node descendants. In order to understand the code, recall that the nodeValue property (defined by the Node type) holds the content of a Text node.

Example 15-3. Finding all Text node descendants of an element

// Return the plain-text content of element e, recursing into child elements. // This method works like the textContent property function textContent(e) { var child, type, s = ""; // s holds the text of all children for(child = e.firstChild; child != null; child = child.nextSibling) { type = child.nodeType; if (type === 3 || type === 4) // Text and CDATASection nodes s += child.nodeValue; else if (type === 1) // Recurse for Element nodes s += textContent(child); } return s; }

The nodeValue property is read/write and you can set it to change the content displayed by a Text or CDATASection node. Both Text and CDATASection are subtypes of CharacterData, which you can look up in Part IV. CharacterData defines a data property, which is the same text as nodeValue. The following function converts the content of Text nodes to uppercase by setting the data property:

// Recursively convert all Text node descendants of n to uppercase. function upcase(n) { if (n.nodeType == 3 || n.nodeTyep == 4) // If n is Text or CDATA n.data = n.data.toUpperCase(); // ...convert content to uppercase. else // Otherwise, recurse on child nodes for(var i = 0; i < n.childNodes.length; i++) upcase(n.childNodes[i]); }

CharacterData also defines infrequently used methods for appending, deleting, inserting, and replacing text within a Text or CDATASection node. Instead of altering the content of existing Text nodes, it is also possible to insert brand-new Text nodes into an Element or to replace existing nodes with new Text nodes. Creating, inserting, and deleting nodes is the topic of the next section.

Creating, Inserting, and Deleting Nodes

We’ve seen how to query and alter document content using strings of HTML and of plain text. And we’ve also seen that we can traverse a Document to examine the individual Element and Text nodes that it is made of. It is also possible to alter a document at the level of individual nodes. The Document type defines methods for creating Element and Text objects, and the Node type defines methods for inserting, deleting, and replacing nodes in the tree. Example 13-4 demonstrated both node creation and node insertion, and that short example is duplicated here:

// Asynchronously load and execute a script from a specified URL function loadasync(url) { var head = document.getElementsByTagName("head")[0]; // Find document <head> var s = document.createElement("script"); // Create a <script> element s.src = url; // Set its src attribute head.appendChild(s); // Insert the <script> into head }

The subsections that follow include more details and examples of node creation, of the insertion and deletion of nodes, and also of the use of DocumentFragment as a shortcut when working with multiple nodes.

Creating Nodes

As shown in the code above, you can create new Element nodes with the create Element() method of the Document object. Pass the tag name of the element as the method argument: this name is case-insensitive for HTML documents and case-sensitive for XML documents.

Text nodes are created with a similar method:

var newnode = document.createTextNode("text node content");

Document defines other factory methods, such as the infrequently used create Comment() , as well. We’ll use the createDocumentFragment() method in Using DocumentFragments. When working with documents that use XML namespaces, you can use createElementNS() to specify both the namespace URI and the tag name of the Element to be created.

Another way to create new document nodes is to make copies of existing ones. Every node has a cloneNode() method that returns a new copy of the node. Pass true to recursively copy all descendants as well, or false to only make a shallow copy. In browsers other than IE, the Document object also defines a similar method named importNode(). If you pass it a node from another document, it returns a copy suitable for insertion into this document. Pass true as the second argument to recursively import all descendants.

Inserting Nodes

Once you have a new node, you can insert it into the document with the Node methods appendChild() or insertBefore(). appendChild() is invoked on the Element node that you want to insert into, and it inserts the specified node so that it becomes the lastChild of that node.

insertBefore() is like appendChild(), but it takes two arguments. The first argument is the node to be inserted. The second argument is the node before which that node is to be inserted. This method is invoked on the node that will be the parent of the new node, and the second argument must be a child of that parent node. If you pass null as that second argument, the insertBefore() behaves like appendChild() and inserts at the end.

Here is a simple function for inserting a node at a numerical index. It demonstrates both appendChild() and insertBefore():

// Insert the child node into parent so that it becomes child node n function insertAt(parent, child, n) { if (n < 0 || n > parent.childNodes.length) throw new Error("invalid index"); else if (n == parent.childNodes.length) parent.appendChild(child); else parent.insertBefore(child, parent.childNodes[n]); }

If you call appendChild() or insertBefore() to insert a node that is already in the document, that node will automatically be removed from its current position and reinserted at its new position: there is no need to explicitly remove the node. Example 15-4 shows a function for sorting the rows of a table based on the values of cells in a specified column. It doesn’t create any new nodes but uses appendChild() to change the order of existing nodes.

Example 15-4. Sorting the rows of a table

// Sort the rows in first <tbody> of the specified table according to // the value of nth cell within each row. Use the comparator function // if one is specified. Otherwise, compare the values alphabetically. function sortrows(table, n, comparator) { var tbody = table.tBodies[0]; // First <tbody>; may be implicitly created var rows = tbody.getElementsByTagName("tr"); // All rows in the tbody rows = Array.prototype.slice.call(rows,0); // Snapshot in a true array // Now sort the rows based on the text in the nth <td> element rows.sort(function(row1,row2) { var cell1 = row1.getElementsByTagName("td")[n]; // Get nth cell var cell2 = row2.getElementsByTagName("td")[n]; // of both rows var val1 = cell1.textContent || cell1.innerText; // Get text content var val2 = cell2.textContent || cell2.innerText; // of the two cells if (comparator) return comparator(val1, val2); // Compare them! if (val1 < val2) return -1; else if (val1 > val2) return 1; else return 0; }); // Now append the rows into the tbody in their sorted order. // This automatically moves them from their current location, so there // is no need to remove them first. If the <tbody> contains any // nodes other than <tr> elements, those nodes will float to the top. for(var i = 0; i < rows.length; i++) tbody.appendChild(rows[i]); } // Find the <th> elements of the table (assuming there is only one row of them) // and make them clickable so that clicking on a column header sorts // by that column. function makeSortable(table) { var headers = table.getElementsByTagName("th"); for(var i = 0; i < headers.length; i++) { (function(n) { // Nested funtion to create a local scope headers[i].onclick = function() { sortrows(table, n); }; }(i)); // Assign value of i to the local variable n } }

Removing and Replacing Nodes

The removeChild() method removes a node from the document tree. Be careful, however: this method isn’t invoked on the node to be removed but (as the「child」part of its name implies) on the parent of that node. Invoke the method on the parent node and pass the child node that is to be removed as the method argument. To remove the node n from the document, you’d write:

n.parentNode.removeChild(n);

replaceChild() removes one child node and replaces it with a new one. Invoke this method on the parent node, passing the new node as the first argument and the node to be replaced as the second argument. To replace the node n with a string of text, for example, you could write:

n.parentNode.replaceChild(document.createTextNode("[ REDACTED ]"), n);

The following function demonstrates another use of replaceChild():

// Replace the node n with a new <b> element and make n a child of that element. function embolden(n) { // If we're passed a string instead of a node, treat it as an element id if (typeof n == "string") n = document.getElementById(n); var parent = n.parentNode; // Get the parent of n var b = document.createElement("b"); // Create a <b> element parent.replaceChild(b, n); // Replace n with the <b> element b.appendChild(n); // Make n a child of the <b> element }

Element Content As HTML introduced the outerHTML property of an element and explained that it was not implemented in current versions of Firefox. Example 15-5 shows how to implement this property in Firefox (and any other browser that supports innerHTML, has an extensible Element.prototype object, and has methods for defining property getters and setters). The code also demonstrates a practical use for the removeChild() and cloneNode() methods.

Example 15-5. Implementing the outerHTML property using innerHTML

// Implement the outerHTML property for browsers that don't support it. // Assumes that the browser does support innerHTML, has an extensible // Element.prototype, and allows getters and setters to be defined. (function() { // If we already have outerHTML return without doing anything if (document.createElement("div").outerHTML) return; // Return the outer HTML of the element referred to by this function outerHTMLGetter() { var container = document.createElement("div"); // Dummy element container.appendChild(this.cloneNode(true)); // Copy this to dummy return container.innerHTML; // Return dummy content } // Set the outer HTML of the this element to the specified value function outerHTMLSetter(value) { // Create a dummy element and set its content to the specified value var container = document.createElement("div"); container.innerHTML = value; // Move each of the nodes from the dummy into the document while(container.firstChild) // Loop until container has no more kids this.parentNode.insertBefore(container.firstChild, this); // And remove the node that has been replaced this.parentNode.removeChild(this); } // Now use these two functions as getters and setters for the // outerHTML property of all Element objects. Use ES5 Object.defineProperty // if it exists and otherwise fall back on __defineGetter__ and Setter__. if (Object.defineProperty) { Object.defineProperty(Element.prototype, "outerHTML", { get: outerHTMLGetter, set: outerHTMLSetter, enumerable: false, configurable: true }); } else { Element.prototype.__defineGetter__("outerHTML", outerHTMLGetter); Element.prototype.__defineSetter__("outerHTML", outerHTMLSetter); } }());

Using DocumentFragments

A DocumentFragment is a special kind of Node that serves as a temporary container for other nodes. Create a DocumentFragment like this:

var frag = document.createDocumentFragment();

Like a Document node, a DocumentFragment stands alone and is not part of any other document. Its parentNode is always null. Like an Element, however, a DocumentFragment can have any number of children, which you can manipulate with appendChild(), insertBefore(), and so on.

The special thing about DocumentFragment is that it allows a set of nodes to be treated as a single node: if you pass a DocumentFragment to appendChild(), insertBefore(), or replaceChild(), it is the children of the fragment that are inserted into the document, not the fragment itself. (The children are moved from the fragment into the document, and the fragment becomes empty and ready for reuse.) The following function uses a DocumentFragment to reverse the order of the children of a node:

// Reverse the order of the children of Node n function reverse(n) { // Create an empty DocumentFragment as a temporary container var f = document.createDocumentFragment(); // Now loop backward through the children, moving each one to the fragment. // The last child of n becomes the first child of f, and vice-versa. // Note that appending a child to f automatically removes it from n. while(n.lastChild) f.appendChild(n.lastChild); // Finally, move the children of f all at once back to n, all at once. n.appendChild(f); }

Example 15-6 implements the insertAdjacentHTML() method (see Element Content As HTML) using the innerHTML property and a DocumentFragment. It also defines logically named HTML insertion functions as an alternative to the confusing insertAdjacentHTML() API. The internal utility function fragment() is possibly the most useful part of this code: it returns a DocumentFragment that contains the parsed representation of a specified string of HTML text.

Example 15-6. Implementing insertAdjacentHTML() using innerHTML

// This module defines Element.insertAdjacentHTML for browsers that don't // support it, and also defines portable HTML insertion functions that have // more logical names than insertAdjacentHTML: // Insert.before(), Insert.after(), Insert.atStart(), Insert.atEnd() var Insert = (function() { // If elements have a native insertAdjacentHTML, use it in four HTML // insertion functions with more sensible names. if (document.createElement("div").insertAdjacentHTML) { return { before: function(e,h) {e.insertAdjacentHTML("beforebegin",h);}, after: function(e,h) {e.insertAdjacentHTML("afterend",h);}, atStart: function(e,h) {e.insertAdjacentHTML("afterbegin",h);}, atEnd: function(e,h) {e.insertAdjacentHTML("beforeend",h);} }; } // Otherwise, we have no native insertAdjacentHTML. Implement the same // four insertion functions and then use them to define insertAdjacentHTML. // First, define a utility method that takes a string of HTML and returns // a DocumentFragment containing the parsed representation of that HTML. function fragment(html) { var elt = document.createElement("div"); // Create empty element var frag = document.createDocumentFragment(); // Create empty fragment elt.innerHTML = html; // Set element content while(elt.firstChild) // Move all nodes frag.appendChild(elt.firstChild); // from elt to frag return frag; // And return the frag } var Insert = { before: function(elt, html) { elt.parentNode.insertBefore(fragment(html), elt); }, after: function(elt, html) { elt.parentNode.insertBefore(fragment(html),elt.nextSibling); }, atStart: function(elt, html) { elt.insertBefore(fragment(html), elt.firstChild); }, atEnd: function(elt, html) { elt.appendChild(fragment(html)); } }; // Now implement insertAdjacentHTML based on the functions above Element.prototype.insertAdjacentHTML = function(pos, html) { switch(pos.toLowerCase()) { case "beforebegin": return Insert.before(this, html); case "afterend": return Insert.after(this, html); case "afterbegin": return Insert.atStart(this, html); case "beforeend": return Insert.atEnd(this, html); } }; return Insert; // Finally return the four insertion function }());

Example: Generating a Table of Contents

Example 15-7 shows how to dynamically create a table of contents for a document. It demonstrates many of the document scripting concepts described in the sections above: element selection, document traversal, setting element attributes, setting the innerHTML property, and creating new nodes and inserting them into the document. The example is well-commented and you should have no trouble following the code.

Example 15-7. An automatically generated table of contents

/** * TOC.js: create a table of contents for a document. * * This module registers an anonymous function that runs automatically * when the document finishes loading. When it runs, the function first * looks for a document element with an id of "TOC". If there is no * such element it creates one at the start of the document. * * Next, the function finds all <h1> through <h6> tags, treats them as * section titles, and creates a table of contents within the TOC * element. The function adds section numbers to each section heading * and wraps the headings in named anchors so that the TOC can link to * them. The generated anchors have names that begin with "TOC", so * you should avoid this prefix in your own HTML. * * The entries in the generated TOC can be styled with CSS. All entries have * a class "TOCEntry". Entries also have a class that corresponds to the level * of the section heading. <h1> tags generate entries of class "TOCLevel1", * <h2> tags generate entries of class "TOCLevel2", and so on. Section numbers * inserted into headings have class "TOCSectNum". * * You might use this module with a stylesheet like this: * * #TOC { border: solid black 1px; margin: 10px; padding: 10px; } * .TOCEntry { font-family: sans-serif; } * .TOCEntry a { text-decoration: none; } * .TOCLevel1 { font-size: 16pt; font-weight: bold; } * .TOCLevel2 { font-size: 12pt; margin-left: .5in; } * .TOCSectNum:after { content: ": "; } * * That final line generates a colon and space after section numbers. To hide * the section numbers, use this: * * .TOCSectNum { display: none } * * This module requires the onLoad() utility function. **/ onLoad(function() { // Anonymous function defines a local scope // Find the TOC container element. // If there isn't one, create one at the start of the document. var toc = document.getElementById("TOC"); if (!toc) { toc = document.createElement("div"); toc.id = "TOC"; document.body.insertBefore(toc, document.body.firstChild); } // Find all section heading elements var headings; if (document.querySelectorAll) // Can we do it the easy way? headings = document.querySelectorAll("h1,h2,h3,h4,h5,h6"); else // Otherwise, find the headings the hard way headings = findHeadings(document.body, []); // Recursively traverse the document body looking for headings function findHeadings(root, sects) { for(var c = root.firstChild; c != null; c = c.nextSibling) { if (c.nodeType !== 1) continue; if (c.tagName.length == 2 && c.tagName.charAt(0) == "H") sects.push(c); else findHeadings(c, sects); } return sects; } // Initialize an array that keeps track of section numbers. var sectionNumbers = [0,0,0,0,0,0]; // Now loop through the section header elements we found. for(var h = 0; h < headings.length; h++) { var heading = headings[h]; // Skip the section heading if it is inside the TOC container. if (heading.parentNode == toc) continue; // Figure out what level heading it is. var level = parseInt(heading.tagName.charAt(1)); if (isNaN(level) || level < 1 || level > 6) continue; // Increment the section number for this heading level // and reset all lower heading level numbers to zero. sectionNumbers[level-1]++; for(var i = level; i < 6; i++) sectionNumbers[i] = 0; // Now combine section numbers for all heading levels // to produce a section number like 2.3.1. var sectionNumber = sectionNumbers.slice(0,level).join(".") // Add the section number to the section header title. // We place the number in a <span> to make it styleable. var span = document.createElement("span"); span.className = "TOCSectNum"; span.innerHTML = sectionNumber; heading.insertBefore(span, heading.firstChild); // Wrap the heading in a named anchor so we can link to it. var anchor = document.createElement("a"); anchor.name = "TOC"+sectionNumber; heading.parentNode.insertBefore(anchor, heading); anchor.appendChild(heading); // Now create a link to this section. var link = document.createElement("a"); link.href = "#TOC" + sectionNumber; // Link destination link.innerHTML = heading.innerHTML; // Link text is same as heading // Place the link in a div that is styleable based on the level. var entry = document.createElement("div"); entry.className = "TOCEntry TOCLevel" + level; entry.appendChild(link); // And add the div to the TOC container. toc.appendChild(entry); } });

Document and Element Geometry and Scrolling

In this chapter so far we have thought about documents as abstract trees of elements and text nodes. But when a browser renders a document within a window, it creates a visual representation of the document in which each element has a position and a size. Often, web applications can treat documents as trees of elements and never have to think about how those elements are rendered onscreen. Sometimes, however, it is necessary to determine the precise geometry of an element. We’ll see in Chapter 16, for example, that the CSS can be used to specify the position of an element. If you want to use CSS to dynamically position an element (such as a tooltip or callout) next to some ordinary browser-positioned element, you need to be able to determine the location of that element.

This section explains how you can go back and forth between the abstract, tree-based model of a document and the geometrical, coordinate-based view of the document as it is laid out in a browser window. The properties and methods described in this section have been implemented in browsers for a long time (though some were, until recently, IE-specific and some were not implemented by IE until IE9). At the time of this writing, they are going through the W3C standardization process as the CSSOM-View Module (see http://www.w3.org/TR/cssom-view/).

Document Coordinates and Viewport Coordinates

The position of an element is measured in pixels, with the X coordinate increasing to the right and the Y coordinate increasing as we go down. There are two different points we can use as the coordinate system origin, however: the X and Y coordinates of an element can be relative to the top-left corner of the document or relative to the top-left corner of the viewport in which the document is displayed. In top-level windows and tabs, the「viewport」is the portion of the browser that actually displays document content: it excludes browser「chrome」such as menus, toolbars, and tabs. For documents displayed in frames, the viewport is the <iframe> element that defines the frame. In either case, when we talk about the position of an element, we must be clear whether we are using document coordinates or viewport coordinates. (Note that viewport coordinates are sometimes called window coordinates.)

If the document is smaller than the viewport, or if it has not been scrolled, the upper-left corner of the document is in the upper-left corner of the viewport and the document and viewport coordinate systems are the same. In general, however, to convert between the two coordinate systems, we must add or subtract the scroll offsets. If an element has a Y coordinate of 200 pixels in document coordinates, for example, and if the user has scrolled the browser down by 75 pixels, then that element has a Y coordinate of 125 pixels in viewport coordinates. Similarly, if an element has an X coordinate of 400 in viewport coordinates and the user has scrolled the viewport 200 pixels horizontally, the element’s X coordinate in document coordinates is 600.

Document coordinates are more fundamental than viewport coordinates, and they do not change when the user scrolls. Nevertheless, it is quite common to use viewport coordinates in client-side programming. We use document coordinates when we specify an element position using CSS (see Chapter 16). But the simplest way of querying the position of an element (see Querying the Geometry of an Element) returns the position in viewport coordinates. Similarly, when we register handler functions for mouse events, the coordinates of the mouse pointer are reported in viewport coordinates.

In order to convert between coordinate systems, we need to be able to determine the scrollbar positions for the browser window. The pageXOffset and pageYOffset properties of the Window object provide these values in all browsers except IE versions 8 and before. IE (and all modern browsers) also make the scrollbar positions available through scrollLeft and scrollTop properties. The confusing thing is that you normally query these properties on the root element of the document (document.documentElement), but in quirks mode (see Quirks Mode and Standards Mode) you must query them on the <body> element (document.body) of the document instead. Example 15-8 shows how to portably query the scrollbar positions.

Example 15-8. Querying the scrollbar positions of a window

// Return the current scrollbar offsets as the x and y properties of an object function getScrollOffsets(w) { // Use the specified window or the current window if no argument w = w || window; // This works for all browsers except IE versions 8 and before if (w.pageXOffset != null) return {x: w.pageXOffset, y:w.pageYOffset}; // For IE (or any browser) in Standards mode var d = w.document; if (document.compatMode == "CSS1Compat") return {x:d.documentElement.scrollLeft, y:d.documentElement.scrollTop}; // For browsers in Quirks mode return { x: d.body.scrollLeft, y: d.body.scrollTop }; }

It is sometimes useful to be able to determine the viewport size—to find what portions of the document are currently visible, for example. As with the scroll offsets, the easy way to query viewport size does not work in IE8 and before and the technique that works in IE depends on whether the browser is in quirks mode or standards mode. Example 15-9 shows how to portably query the viewport size. Note how similar the code is to Example 15-8.

Example 15-9. Querying the viewport size of a window

// Return the viewport size as w and h properties of an object function getViewportSize(w) { // Use the specified window or the current window if no argument w = w || window; // This works for all browsers except IE8 and before if (w.innerWidth != null) return {w: w.innerWidth, h:w.innerHeight}; // For IE (or any browser) in Standards mode var d = w.document; if (document.compatMode == "CSS1Compat") return { w: d.documentElement.clientWidth, h: d.documentElement.clientHeight }; // For browsers in Quirks mode return { w: d.body.clientWidth, h: d.body.clientWidth }; }

The two examples above have used the scrollLeft, scrollTop, clientWidth, and client Height properties. We’ll encounter these properties again in More on Element Size, Position and Overflow.

Querying the Geometry of an Element

The easiest way to determine the size and position of an element is to call its get Bounding ClientRect() method. This method was introduced in IE5 and is now implemented by all current browsers. It expects no arguments and returns an object with properties left, right, top, and bottom. The left and top properties give the X and Y coordinates of the upper-left corner of the element and the right and bottom properties give the coordinates of the lower-right corner.

This method returns element positions in viewport coordinates. (The word「client」in the method name getBoundingClientRect() is an oblique reference to the web browser client—specifically to the window and the viewport it defines.) To convert to document coordinates that remain valid even if the user scrolls the browser window, add the scroll offsets:

var box = e.getBoundingClientRect(); // Get position in viewport coordinates var offsets = getScrollOffsets(); // Utility function defined above var x = box.left + offsets.x; // Convert to document coordinates var y = box.top + offsets.y;

In many browsers (and in the W3C standard), the object returned by getBoundingClientRect() also has width and height properties, but the original IE implementation does not do this. For portability, you can compute the element width and height like this:

var box = e.getBoundingClientRect(); var w = box.width || (box.right - box.left); var h = box.height || (box.bottom - box.top);

You’ll learn in Chapter 16 that the content of an element is surrounded by an optional blank area known as padding. The padding is surrounded by an optional border, and the border is surrounded by optional margins. The coordinates returned by get Bounding ClientRect() include the border and the padding of the element but do not include the element margins.

If the word「Client」in the method getBoundingClientRect() specifies the coordinate system of the returned rectangle, what explains the word「Bounding」in the method name? Block elements, such as images, paragraphs, and <div> elements are always rectangular when laid out by the browser. Inline elements, such as <span>, <code>, and <b> elements, however, may span multiple lines and may therefore consist of multiple rectangles. Imagine, for example, some italicized text (marked up with <i> and </i> tags) that is broken across two lines. Its rectangles consist of the right-hand portion of the first line and the left-hand portion of the second line (assuming left-to-right text). If you call getBoundingClientRect() on an inline element, it returns the「bounding rectangle」of the individual rectangles. For the <i> element described above, the bounding rectangle would include the entire width of both lines.

If you want to query the individual rectangles of inline elements, call the get Client Rects() method to obtain a read-only array-like object whose elements are rectangle objects like those returned by getBoundingClientRect().

We’ve seen that DOM methods like getElementsByTagName() return「live」results that are updated as the document changes. The rectangle objects (and rectangle object lists) returned by getBoundingClientRect() and getClientRects() are not live. They are static snapshots of the visual state of document when the methods are called. They are not updated when the user scrolls or resizes the browser window.

Determining the Element at a Point

The getBoundingClientRect() method allows us to determine the current position of an element in a viewport. Sometimes we want to go in the other direction and determine which element is at a given location in the viewport. You can determine this with the elementFromPoint() method of the Document object. Pass X and Y coordinates (using viewport coordinates, not document coordinates) and this method returns an Element object that is at the specified position. At the time of this writing, the algorithm for selecting the element is not specified, but the intent of this method is that it returns the innermost and uppermost (see the CSS z-index attribute in The third dimension: z-index) element at that point. If you specify a point that is outside of the viewport, elementFromPoint() will return null even if that point would be perfectly valid when converted to document coordinates.

elementFromPoint() seems like a very useful method, and the obvious use case is passing the coordinates of the mouse pointer to determine which element the mouse is over. As we’ll learn in Chapter 17, however, mouse event objects already include this information in their target property. In practice, therefore, elementFromPoint() is not commonly used.

Scrolling

Example 15-8 showed how to query the scrollbar positions for a browser window. The scrollLeft and scrollTop properties used in that example can be set to make the browser scroll, but there is an easier way that has been supported since the earliest days of JavaScript. The scrollTo() method of the Window object (and its synonym scroll()) takes the X and Y coordinates of a point (in document coordinates) and sets these as the scrollbar offsets. That is, it scrolls the window so that the specified point is in the upper left corner of the viewport. If you specify a point that is too close to the bottom or too close to the right edge of the document, the browser will move it as close as possible to the upper left corner but won’t be able to get it all the way there. The following code scrolls the browser so that the bottom-most page of the document is visible:

// Get the height of the document and viewport. offsetHeight is explained below. var documentHeight = document.documentElement.offsetHeight; var viewportHeight = window.innerHeight; // Or use getViewportSize() above // And scroll so the last "page" shows in the viewport window.scrollTo(0, documentHeight - viewportHeight);

The scrollBy() method of the Window is similar to scroll() and scrollTo(), but its arguments are relative and are added to the current scrollbar offsets. Speed readers might like a bookmarklet (Bookmarklets) like this one, for example:

// Scroll 10 pixels down every 200 ms. Note there is no way to turn this off! javascript:void setInterval(function() {scrollBy(0,10)}, 200);

Often, instead of scrolling to a numeric location in document, we just want to scroll so that a certain element in the document is visible. You could compute the position of the element with getBoundingClientRect(), convert that position to document coordinates, and then use the scrollTo() method, but it is easier to just call the scrollIntoView() method on the desired HTML element. This method ensures that the element on which it is invoked is visible in the viewport. By default, it tries to put the top edge of the element at or near the top of the viewport. If you pass false as the only argument, it will try to put the bottom edge of the element at the bottom of the viewport. The browser will also scroll the viewport horizontally as needed to make the element visible.

The behavior of scrollIntoView() is similar to what the browser does when you set window.location.hash to the name of a named anchor (an <a name=""> element).

More on Element Size, Position and Overflow

The getBoundingClientRect() method is defined in all current browsers, but if you need to support an older generation of browsers, you can’t rely on this method and must use older techniques for determining element size and position. Element size is easy: the readonly offsetWidth and offsetHeight properties of any HTML element return its on screen size, in CSS pixels. The returned sizes include the element border and padding but not margins.

All HTML elements have offsetLeft and offsetTop properties that return the X and Y coordinates of the element. For many elements, these values are document coordinates and directly specify the position of the element. But for descendants of positioned elements and for some other elements, such as table cells, these properties return coordinates that are relative to an ancestor element rather than the document. The offsetParent property specifies which element the properties are relative to. If offsetParent is null, the properties are document coordinates. In general, therefore, computing the position of an element e using offsetLeft and offsetTop requires a loop:

function getElementPosition(e) { var x = 0, y = 0; while(e != null) { x += e.offsetLeft; y += e.offsetTop; e = e.offsetParent; } return {x:x, y:y}; }

By looping through the offsetParent chain and accumulating offsets, this function computes the document coordinates of the specified element. (Recall that getBoundingClientRect() returns viewport coordinates instead.) This is not the final word on element positioning, however—this getElementPosition() function does not always compute the correct values, and we’ll see how to fix it below.

In addition to the set of offset properties, all document elements define two other sets of properties, one whose names begin with client and one whose names begin with scroll. That is, every HTML element has all of the following properties:

offsetWidth clientWidth scrollWidth offsetHeight clientHeight scrollHeight offsetLeft clientLeft scrollLeft offsetTop clientTop scrollTop offsetParent

In order to understand these client and scroll properties, you need to know that the content of an HTML element may be larger than the content box allocated to hold that content, and that therefore individual elements may have scrollbars (see the CSS overflow attribute in Partial Visibility: overflow and clip). The content area is a viewport, like the browser window is, and when the content is larger than the viewport, we need to take an element’s scrollbar position into account.

clientWidth and clientHeight are like offsetWidth and offsetHeight except that they do not include the border size, only the content area and its padding. Also, if the browser has added scrollbars between the padding and the border, clientWidth and client Height do not include the scrollbar in their returned value. Note that clientWidth and clientHeight always return 0 for inline elements like <i>, <code>, and <span>.

clientWidth and clientHeight were used in the getViewportSize() method of Example 15-9. As a special case, when these properties are queried on the root element of a document (or the body element in quirks mode), they return the same values as the innerWidth and innerHeight properties of the window.

The clientLeft and clientTop properties are not very useful: they return the horizontal and vertical distance between the outside of an element’s padding and the outside of its border. Usually these values are just the width of the left and top borders. If an element has scrollbars, however, and if the browser places those scrollbars on the left or top (which would be unusual), clientLeft and clientTop also include the scrollbar width. For inline elements, clientLeft and clientTop are always 0.

scrollWidth and scrollHeight are the size of an element’s content area plus its padding plus any overflowing content. When the content fits within the content area without overflow, these properties are the same as clientWidth and clientHeight. But when there is overflow, they include the overflowing content and return values larger than clientWidth and clientHeight.

Finally, scrollLeft and scrollTop give the scrollbar positions of an element. We queried them on the root element of the document in the getScrollOffsets() method (Example 15-8), but they are also defined on any element. Note that scrollLeft and scrollTop are writable properties and you can set them to scroll the content within an element. (HTML elements do not have a scrollTo() method like the Window object does.)

When a document contains scrollable elements with overflowing content, the getElementPosition() method defined above does not work correctly because it does not take scrollbar position into account. Here is a modified version that subtracts scrollbar positions from the accumulated offsets and, in so doing, converts the returned position from document coordinates to viewport coordinates:

function getElementPos(elt) { var x = 0, y = 0; // Loop to add up offsets for(var e = elt; e != null; e = e.offsetParent) { x += e.offsetLeft; y += e.offsetTop; } // Loop again, through all ancestor elements to subtract scroll offsets. // This subtracts the main scrollbars, too, and converts to viewport coords. for(var e=elt.parentNode; e != null && e.nodeType == 1; e=e.parentNode) { x -= e.scrollLeft; y -= e.scrollTop; } return {x:x, y:y}; }

In modern browsers, this getElementPos() method returns the same position values as getBoundingClientRect() does (but is much less efficient). Theoretically, a function such as getElementPos() could be used in browsers that do not support getBounding Client Rect(). In practice, however, browsers that do not support getBounding Client Rect() have a lot of element positioning incompatibilities and a function as simple as this one will not work reliably. Practical client-side libraries like jQuery include functions for computing element position that augment this basic position computation algorithm with a number of browser-specific bug fixes. If you need to compute element position and need your code to work in browsers that do not support getBoundingClientRect(), you should probably use a library like jQuery.

HTML Forms

The HTML <form> element, and the various form input elements, such as <input>, <select>, and <button>, have an important place in client-side programming. These HTML elements date from the very beginning of the Web and predate JavaScript itself. HTML forms are the mechanism behind the first generation of web applications, which required no JavaScript at all. User input is gathered in form elements; form submission sends that input to the server; the server processes the input and generates a new HTML page (usually with new form elements) for display by the client.

HTML form elements are still a great way to gather input from the user, even when form data is processed entirely by client-side JavaScript and never submitted to the server. With server-side programs, a form isn’t useful unless it has a Submit button. In client-side programming, on the other hand, a Submit button is never necessary (though it may still be useful). Server-side programs are based on form submissions—they process data in form-sized chunks—and this limits their interactivity. Client-side programs are event based—they can respond to events on individual form elements—and this allows them to be much more responsive. A client-side program might validate the user’s input as she types it, for example. Or it might respond to a click on a checkbox by enabling a set of options that are only meaningful when that box is checked.

The subsections that follow explain how to do these kinds of things with HTML forms. Forms are composed of HTML elements, just like any other part of an HTML document, and you can manipulate them with the DOM techniques already explained in this chapter. But form elements were the first ones to be made scriptable, in the earliest days of client-side programming, and they also support some APIs that predate the DOM.

Note that this section is about scripting HTML forms, not about the HTML itself. It assumes that you are already somewhat familiar with the HTML elements (<input>, <textarea>, <select>, and so on) used to define those forms. Nevertheless, Table 15-1 is a quick reference to the most commonly used form elements. You can read more about the form and form element APIs in Part IV, under the entries Form, Input, Option, Select, and TextArea.

Table 15-1. HTML form elements

HTML element Type property Event handlerDescription and events

<input type="button"> or <button type="button">

「button」onclick A push button

<input type="checkbox">「checkbox」onchange A toggle button without radio button behavior

<input type="file">「file」onchange An input field for entering the name of a file to upload to the web server; value property is read-only

<input type="hidden">「hidden」none Data submitted with the form but not visible to the user

<option> none none A single item within a Select object; event handlers are on the Select object, not on individual Option objects

<input type="password">「password」onchange An input field for password entry—typed characters are not visible

<input type="radio">「radio」onchange A toggle button with radio button behavior—only one selected at a time

<input type="reset"> or <button type="reset">

「reset」onclick A push button that resets a form

<select>「select-one」onchange A list or drop-down menu from which one item may be selected (also see <option>)

<select multiple>「select-multiple」onchange A list from which multiple items may be selected (also see <option>)

<input type="submit"> or <button type="submit">

「submit」onclick A push button that submits a form

<input type="text">「text」onchange A single-line text entry field; the default <input> element it type attribute is omitted or unrecognized

<textarea>「textarea」onchange A multiline text entry field

Selecting Forms and Form Elements

Forms and the elements they contain can be selected from a document using standard methods like getElementById() and getElementsByTagName():

var fields = document.getElementById("address").getElementsByTagName("input");

In browsers that support querySelectorAll(), you might select all radio buttons, or all elements with the same name, from a form with code like this:

// All radio buttons in the form with id "shipping" document.querySelectorAll('#shipping input[type="radio"]'); // All radio buttons with name "method" in form with id "shipping" document.querySelectorAll('#shipping input[type="radio"][name="method"]');

As described in Document Elements As Window Properties, Selecting Elements by Name, and Selecting Elements by Type, however, a <form> element with a name or id attribute can be selected in a number of other ways. A <form> with a name="address" attribute can be selected in any of these ways:

window.address // Brittle: do not use document.address // Only works for forms with name attribute document.forms.address // Explicit access to a form with name or id document.forms[n] // Brittle: n is the form's numerical position

Selecting Elements by Type explained that document.forms is an HTMLCollection object that allows form elements to be selected by numerical order, by id, or by name. Form objects themselves act like HTMLCollections of form elements and can be indexed by name or number. If a form with name「address」has a first element with name「street」, you can refer to that form element with any of these expressions:

document.forms.address[0] document.forms.address.street document.address.street // only for name="address", not id="address"

If you want to be explicit about selecting a form element, you can index the elements property of the form object instead:

document.forms.address.elements[0] document.forms.address.elements.street

The id attribute is the generally preferred way to name specific document elements. The name attribute, however, has a special purpose for HTML form submission, and is much more commonly used with forms than with other elements. It is typical for groups of related checkboxes and mandatory for mutually exclusive groups of radioboxes to share a value of the name attribute. Remember that when you index an HTMLCollection with a name and more than one element shares that name, the returned value is an array-like object that contains all matching elements. Consider this form that contains radio buttons for selecting a shipping method:

<form name="shipping"> <fieldset><legend>Shipping Method</legend> <label><input type="radio" name="method" value="1st">First-class</label> <label><input type="radio" name="method" value="2day">2-day Air</label> <label><input type="radio" name="method" value="overnite">Overnight</label> </fieldset> </form>

With this form, you might refer to the array of radio button elements like this:

var methods = document.forms.shipping.elements.method;

Note that <form> elements have an HTML attribute and corresponding JavaScript property named「method」, so in this case, we must use the elements property of the form instead of directly accessing the method property. In order to determine which shipping method the user has selected, we’d loop through the form elements in the array and check the checked property of each:

var shipping_method; for(var i = 0; i < methods.length; i++) if (methods[i].checked) shipping_method = methods[i].value;

We’ll see more about the properties, such as checked and value, of form elements in the next section.

Form and Element Properties

The elements[] array described above is the most interesting property of a Form object. The remaining properties of the Form object are of less importance. The action, encoding , method, and target properties correspond directly to the action, encoding, method, and target attributes of the <form> element. These properties and attributes are all used to control how form data is submitted to the web server and where the results are displayed. Client-side JavaScript can set the value of these properties, but they are only useful when the form is actually submitted to a server-side program.

