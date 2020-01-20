Returns the Node at the specified index or null if the index is out of bounds.

Name

Option — an <option> in a Select element

Inherits from

Node, Element

Synopsis

The Option object describes a single option displayed within a Select object. The properties of this object specify whether it is selected by default, whether it is currently selected, the position it has in the options[] array of its containing Select object, the text it displays, and the value it passes to the server if it is selected when the containing form is submitted.

For historical reasons, the Option element defines a constructor that you can use to create and initialize new Option elements. (You can also use the normal Document.create Element() method, of course.) Once a new Option object is created, it can be appended to the options collection of a Select object. See HTMLOptionsCollection for details.

Constructor

new Option([string text, string value, boolean defaultSelected, boolean selected])

The Option() constructor creates an <option> element. The four optional argument specify the textContent (see Node) of the element and the initial values of the value, default Selected and selected properties.

Properties

boolean defaultSelected

This property mirrors the HTML selected attribute. It defines the initial selectedness of the option, and also the value that is used when the form is reset.

boolean disabled

true if this option is disabled. Options are disabled if they or a containing <optgroup> has the HTML disabled attribute.

readonly Form form

The <form> element, if any, of which this Option element is a part.

readonly long index

The index of this Option element within its containing Select element. (See also HTMLOptionsCollection).

string label

The value of the HTML label attribute if there is one, or otherwise the textContent (see Node) of this Option.

boolean selected

true if this option is currently selected, or false otherwise.

string text

The textContent (see Node) of this Option element, with leading and trailing whitespace removed and runs of two or more spaces replaced with a single space character.

string value

The value of the HTML value attribute, if this Option has one, or the textContent of the element otherwise.

Name

Output — an HTML form <output> element

Inherits from

Node, Element, FormControl

Synopsis

The Output object represents an HTML form <output> element. In browsers that support them, Output objects implement most of the properties of FormControl.

Properties

string defaultValue

This property is the initial value of the Output element’s textContent (see Node). When the form is reset, its value is restored to this value. If this property is set and the Output element is currently displaying its previous defaultValue, the new default value will be displayed. Otherwise, the currently displayed value will not be changed.

readonly DOMSettableTokenList htmlFor

The HTML for attribute of an <output> element is a space-separated list of the IDs of elements whose values contributed to the computed content displayed by the <output> element. for is a reserved word in JavaScript, so this corresponding JavaScript property is named htmlFor instead. You can get and set this property as if it was an ordinary string value, or you can use the methods of DOMTokenList to query and set individual element IDs from the list.

Name

PageTransitionEvent — event object for pageshow and pagehide events

Inherits from

Event

Synopsis

Browsers fire a pageshow event after the load event when a document first loads, and then fire another pageshow event each time the page is restored from the in-memory history cache. A PageTransitionEvent object is associated with each pageshow event, and its persisted property is true if the page is being restored rather than loaded or reloaded.

Pagehide events also have an associated PageTransitionEvent object, but the persisted property is always true for pagehide events.

Pageshow and pagehide events are triggered on the Window object. They do not bubble and have no default action to cancel.

Properties

readonly boolean persisted

For pageshow events, this property is false if the page was loaded (or reloaded) from the network or the disk cache. It is true if the page being shown was restored from the in-memory cache without being reloaded.

For pagehide events, this property is always true.

Name

PopStateEvent — history transition event

Inherits from

Event

Synopsis

Web applications that manage their own history (see History Management) use the pushState() method of History to create a new entry in the browsing history and associate a state value or object with it. When the user uses the browser’s Back or Forward buttons to navigate between those saved states, the browser triggers a popstate event on the Window object and passes a copy of the saved application state in the associated PopStateEvent object.

Properties

readonly any state

This property holds a copy of the state value or object that was passed to the History. pushState() or History.replaceState() method. The state can be any value that can be cloned with the structured clone algorithm (see Structured Clones).

Name

ProcessingInstruction — a processing instruction in an XML document

Inherits from

Node

Synopsis

This infrequently used interface represents a processing instruction (or PI) in an XML document. Programmers working with HTML documents will never encounter a ProcessingInstruction node.

Properties

string data

The content of the processing instruction (i.e., the first nonspace character after the target, up to but not including the closing ?>).

readonly string target

The target of the processing instruction. This is the first identifier that follows the opening <?; it specifies the「processor」for which the processing instruction is intended.

Name

Progress — a progress bar

Inherits from

Node, Element

Synopsis

A Progress object represents an HTML <progress> element and displays a graphical representation of progress toward the completion of some kind of task.

When the amount of work or time required to complete the task is not know, the Progress element is said to be in an indeterminate state. In this state, it simply displays some kind of「working」animation to indicate that something is happening. When the total amount of work (or time or bytes) and the amount accomplished are known, the Progress element is a determinate state and can display progress with some kind of completion percentage graphic.

<progress> is an HTML5 element that, at the time of this writing, is not yet widely supported.

Properties

readonly Form form

The Form element, if there is one, that is the ancestor of this element or that was identified with the HTML form attribute.

readonly NodeList labels

An array-like object of Label elements that are associated with this element.

double max

The total amount of work to be done. When using a Progress element to display upload or download progress of an XMLHttpRequest, for example, you might set this property to the total number of bytes to be transferred. This property mirrors the max attribute. The default value is 1.0.

readonly double position

If this is a determinate Progress element, this property is the computed value value/max. Otherwise this property will be -1.

double value

A value between 0 and max indicating how much progress has been made. This property mirrors the value attribute. If the attribute exists, the Progress element is a determinate element. If it does not exist, the Progress element is indeterminate. To switch from determinate to indeterminate mode (because of a stalled event from a MediaElement, for example), you can use the removeAttribute() method of Element.

Name

ProgressEvent — downloading, uploading, or file reading progress

Inherits from

Event

Synopsis

The ApplicationCache, FileReader, and (level 2) XMLHttpRequest object all fire Progress events to inform interested applications of the progress of a data transfer process such as a network download or upload or a file read. Events of this sort are known generically as Progress events, but only one such event actually has the name「progress.」Other Progress events fired by FileReader and XMLHttpRequest are loadstart, load, loadend, error and abort. XMLHttpRequest also fires a timeout Progress event. ApplicationCache fires a number of events, but only the one named「progress」is a Progress event of the type described here.

Progress events are triggered in a sequence that begins with a loadstart event and always ends with a loadend event. The event immediately before loadend will be load, error, or abort, depending on whether the data transfer operation succeeded and if not, how it failed. Zero or more progress events (with the actual event name「progress」) are triggered between the initial loadstart and the final two events. (The ApplicationCache object fires a different sequence of events, but the progress event it fires as part of its cache update process is a Progress event.)

Event handlers for Progress events are passed a ProgressEvent object that specifies how many bytes of data have been transferred. This ProgressEvent object is unrelated to the HTML <progress> element described in Progress, but the ProgressEvent object passed to the onprogress event handler of an XMLHttpRequest (for example) could be used to update the state of a <progress> element to display a visual download completion percentage value to the user.

Properties

readonly boolean lengthComputable

true if the total number of bytes to transfer is known and false otherwise. If this property is true, the data transfer completion percentage for a ProgressEvent e can be computed as:

var percentComplete = Math.floor(100*e.loaded/e.total);

readonly unsigned long loaded

How many bytes have been transferred so far.

readonly unsigned long total

The total number of bytes to be transferred, if that value is known, or 0 otherwise. This information might come from the size property of a Blob or the Content-Length header returned by a web server, for example.

Name

Screen — information about the display screen

Synopsis

The screen property of a Window refers to a Screen object. The properties of this global object contain information about the computer monitor on which the browser is displayed. JavaScript programs can use this information to optimize their output for the user’s display capabilities. For example, a program can choose between large and small images based on the display size.

Properties

readonly unsigned long availHeight

Specifies the available height, in pixels, of the screen on which the web browser is displayed. This available height does not include vertical space allocated to permanent desktop features, such as a bar or dock at the bottom of the screen.

readonly unsigned long availWidth

Specifies the available width, in pixels, of the screen on which the web browser is displayed. This available width does not include horizontal space allocated to permanent desktop features.

readonly unsigned long colorDepth

readonly unsigned long pixelDepth

These synonymous properties both specify the color depth of the screen in bits per pixel.

readonly unsigned long height

Specifies the total height, in pixels, of the screen on which the web browser is displayed. See also availHeight.

readonly unsigned long width

Specifies the total width, in pixels, of the screen on which the web browser is displayed. See also availWidth.

Name

Script — an HTML <script> element

Inherits from

Node, Element

Synopsis

A Script object represents an HTML <script> element. Most of its properties simply mirror the HTML attributes with the same name, but text works like the textContent property inherited from Node.

Note that a <script> will not run more than once. You cannot change the src or text property of an existing <script> element to make it run a new script. You can set these properties on a newly created <script> element to execute a script, however. Note, though, that a <script> tag must be inserted into a Document in order to run. The script will be executed when src or type is set or when it is inserted into the document, whichever comes last.

Properties

boolean async

true if the <script> element has an async attribute and false otherwise. See Synchronous, Asynchronous, and Deferred Scripts.

string charset

The character encoding of the script specified by src URL. This property is not normally specified, and the default is to interpret the script using the same encoding as the containing document.

boolean defer

true if the <script> element has a defer attribute and false otherwise. See Synchronous, Asynchronous, and Deferred Scripts.

string src

The URL of the script to be loaded.

string text

The text that appears between the <script> tag and the closing </script> tag.

string type

The MIME type of the scripting language. The default is「text/javascript」, and you do not need to set this property (or the HTML attribute) for ordinary JavaScript scripts. If you set this property to a custom MIME type of your own, you can embed arbitrary textual data within the <script> element for use by other scripts.

Name

Select — a graphical selection list

Inherits from

Node, Element, FormControl

Synopsis

The Select element represents an HTML <select> tag, which displays a graphical list of choices to the user. If the HTML multiple attribute is present, the user may select any number of options from the list. If that attribute is not present, the user may select only one option, and options have a radio button behavior—selecting one deselects whichever was previously selected.

The options in a Select element can be displayed in two distinct ways. If the size attribute has a value greater than 1, or if the multiple attribute is present, they are displayed in a list box that is size lines high in the browser window. If size is smaller than the number of options, the listbox includes a scrollbar. On the other hand, if size is 1 and multiple is not specified, the currently selected option is displayed on a single line, and the list of other options is made available through a drop-down menu. The first presentation style displays the options clearly but requires more space in the browser window. The second style requires minimal space but does not display alternative options as explicitly. size defaults to 4 when the multiple attribute is set, and 1 otherwise.

The options[] property of the Select element is the most interesting. This is an array-like object of <option> elements (see Option) that describe the choices presented by the Select element. For historical reasons, this array-like object has some unusual behaviors for adding and removing new <option> elements. See HTMLOptionsCollection for details.

For a Select element without the multiple attribute specified, you can determine which option is selected with the selectedIndex property. When multiple selections are allowed, however, this property tells you the index of only the first selected option. To determine the full set of selected options, you must iterate through the options[] array and check the selected property of each Option object.

Properties

In addition to the properties listed here, Select elements also define the properties of Element and FormControl and mirror HTML attributes with the following JavaScript properties: multiple, required, and size.

unsigned long length

The number of elements in the options collection. Select objects are themselves array-like objects, and for a Select object s and a number n, s[n] is the same as s.options[n].

readonly HTMLOptionsCollection options

An array-like object of Option elements contained by this Select element. See HTMLOptionsCollection for a description of the historical behavior of this collection.

long selectedIndex

The position of the selected option in the options array. If no options are selected, this property is −1. If multiple options are selected, this property holds the index of the first selected option.

Setting the value of this property selects the specified option and deselects all other options, even if the Select object has the multiple attribute specified. When you’re doing listbox selection (when size > 1), you can deselect all options by setting selectedIndex to −1. Note that changing the selection in this way does not trigger the onchange() event handler.

readonly HTMLCollection selectedOptions

A read-only array-like object of Option elements that are selected. This is a new property defined by HTML5 and, at the time of this writing, it is not yet widely supported.

Methods

The methods listed here all delegate to the same-named methods of the options property; see HTMLOptionsCollection for details. In addition to these methods, Select elements also implement the methods of Element and FormControl.

void add(Element element, [any before])

This method works just like options.add() to add a new Option element.

any item(unsigned long index)

This method works just like options.item() to return an Option element. It is also invoked when the user indexes the Select object directly.

any namedItem(string name)

This method is just like options.namedItem(). See HTMLOptionsCollection.

void remove(long index)

This method works just like options.remove() to remove an Option element. See HTMLOptionsCollection.

Name

Storage — client-side storage of name/value pairs

Synopsis

The localStorage and sessionStorage properties of Window are both Session objects that represent persistent client-side associative arrays that map string keys to values. In theory, a Session object can store any value that can be cloned with the structured clone algorithm (see Structured Clones). At the time of this writing, however, browsers only support string values.

The methods of a Storage object allow you to add new key/value pairs, remove key/value pairs, and query the value associated with a specified key. You don’t have to call these methods explicitly, however: you can use array indexing and the delete operator in their place, and treat localStorage and sessionStorage as if they were ordinary JavaScript objects.

If you change the contents of a Storage object, any other Windows that have access to the same storage area (because they’re displaying a document from the same origin) will be notified of the change with a StorageEvent.

Properties

readonly unsigned long length

The number of key/value pairs stored.

Methods

void clear()

Removes all stored key/value pairs.

any getItem(string key)

Returns the value associated with key. (In implementations current at the time of this writing, the return value will always be a string.) This method is invoked implicitly when you index the Storage object to retrieve a property named key.

string key(unsigned long n)

Returns the nth key in this Storage object or null if n is greater than or equal to length. Note that the order of the keys may change if you add or remove key/value pairs.

void removeItem(string key)

Removes key, and its associated value, from this Storage object. This method is invoked implicitly if you use the delete operator to delete the property named key.

void setItem(string key, any value)

Add the specified key and value to this Storage object, replacing any value that is already associated with key. This method is invoked implicitly if you assign a value to the property named key of the Storage object. That is, you can use ordinary JavaScript property access and assignment syntax instead of explicitly calling setItem().

Name

StorageEvent

Inherits from

Event

Synopsis

The localStorage and sessionStorage properties of a Window object refer to Storage objects that represent client-side storage areas (see localStorage and sessionStorage). If more than one window, tab, or frame is displaying documents from the same origin, multiple windows have access to the same storage areas. If a script in one window changes the contents of a storage area, a storage event is triggered on all other Window objects that share access to that storage area. (Note that the event is not triggered in the window that made the change.) Storage events are triggered on the Window object and do not bubble. They do not have any default action that can be canceled. The object associated with a storage event is a StorageEvent object, and its properties describe the change that occurred to the storage area.

Properties

readonly string key

This property is the key that was set or deleted. If the entire storage area was cleared with Storage.clear(), this property (as well as newValue and oldValue) will be null.

readonly any newValue

The new value of the specified key. This will be null if the key was removed. At the time of this writing, browser implementations only allow string values to be stored.

readonly any oldValue

The old value of the key that was changed, or null if this key was newly added to the storage area. At the time of this writing browser implementations only allow string values to be stored.

readonly Storage storageArea

This property will be equal to the localStorage or sessionStorage property of the Window that receives this event and indicates which storage area was changed.

readonly string url

This is the URL of the document whose script changed the storage area.

Name

Style — an HTML <style> element

Inherits from

Node, Element

Synopsis

A Style object represents an HTML <style> tag.

Properties

boolean disabled

Set this property to true to disable the stylesheet associated with this <style> element, and set it to false to re-enable it.

string media

This property mirrors the HTML media attribute and specifies the mediums to which the specified styles apply.

boolean scoped

This property is true if the HTML scoped attribute is present on the <style> element, and false otherwise. At the time of this writing, browsers do not support scoped stylesheets.

readonly CSSStyleSheet sheet

The CSSStyleSheet defined by this <style> element.

string title

All HTML elements allow a title attribute. Setting this attribute or property on a <style> element may allow the user to select the stylesheet (as an alternate stylesheet) by title, and the title you specify may appear within the web browser UI in some fashion.

string type

Mirrors the HTML type attribute. The default value is「text/css」, and you do not normally need to set this attribute.

Name

Table — an HTML <table>

Inherits from

Node, Element

Synopsis

The Table object represents an HTML <table> element and defines a number of convenience properties and methods for querying and modifying various sections of the table. These methods and properties make it easier to work with tables, but their functionality can also be duplicated with core DOM methods.

HTML tables are composed of sections, rows, and cells. See TableCell, TableRow, and TableSection.

Properties

In addition to the properties listed here, Table elements also have a summary property that mirrors the HTML attribute of the same name.

Element caption

A reference to the <caption> element for the table, or null if there is none

readonly HTMLCollection rows

An array-like object of TableRow objects that represent all the rows in the table. This includes all rows defined within <thead>, <tfoot>, and <tbody> tags.

readonly HTMLCollection tBodies

An array-like object of TableSection objects that represent all the <tbody> sections in this table.

TableSection tFoot

The <tfoot> element of the table, or null if there is none.

TableSection tHead

The <thead> element of the table, or null if there is none.

Methods

Element createCaption()

This method returns an Element object representing the <caption> of this table. If the table already has a caption, this method simply returns it. If the table does not have an existing <caption>, this method creates a new (empty) caption and inserts it into the table before returning it.

TableSection createTBody()

This method creates a new <tbody> element, inserts it into the table, and returns it. The new element is inserted after the last <tbody> in the table, or at the end of the table.

TableSection createTFoot()

This method returns a TableSection representing the first <tfoot> element for this table. If the table already has a footer, this method simply returns it. If the table does not have an existing footer, this method creates a new (empty) <tfoot> element and inserts it into the table before returning it.

TableSection createTHead()

This method returns a TableSection representing the first <thead> element for this table. If the table already has a header, this method simply returns it. If the table does not have an existing header, this method creates a new (empty) <thead> element and inserts it into the table before returning it.

void deleteCaption()

Removes the first <caption> element from the table, if it has one.

void deleteRow(long index)

This method deletes the row at the specified position from the table. Rows are numbered in the order in which they appear in the document source. Rows in <thead> and <tfoot> sections are numbered along with all other rows in the table.

void deleteTFoot()

Removes the first <tfoot> element from the table, if it has one.

void deleteTHead()

Removes the first <thead> element from the table, if it has one.

TableRow insertRow([long index])

This method creates a new <tr> element, inserts it into the table at the specified index, and returns it.

The new row is inserted in the same section and immediately before the existing row at the position specified by index. If index is equal to the number of rows in the table (or to -1), the new row is appended to the last section of the table. If the table is initially empty, the new row is inserted into a new <tbody> section that is itself inserted into the table.

You can use the convenience method TableRow.insertCell() to add content to the newly created row. See also the insertRow() method of TableSection.

Name

TableCell — a cell in an HTML table

Inherits from

Node, Element

Synopsis

A TableCell object represents a <td> or <th> element.

Properties

readonly long cellIndex

The position of this cell within its row.

unsigned long colSpan

The value of the HTML colspan attribute, as a number.

unsigned long rowSpan

The value of the HTML rowspan attribute, as a number.

Name

TableRow — a <tr> element in an HTML table

Inherits from

Node, Element

Synopsis

A TableRow object represents a row (a <tr> element) in an HTML table and defines properties and methods for working with the TableCell elements of the row.

Properties

readonly HTMLCollection cells

An array-like object of TableCell objects representing the <td> and <th> elements in this row.

readonly long rowIndex

The index of this row in the table.

readonly long sectionRowIndex

The position of this row within its section (i.e., within the <thead>, <tbody>, or <tfoot> in which it is contained).

Methods

void deleteCell(long index)

This method deletes the cell at the specified index in the row.

Element insertCell([long index])

This method creates a new <td> element, inserts it into the row at the specified position, and then returns it. The new cell is inserted immediately before the cell that is currently at the position specified by index. If index is omitted, is -1, or is equal to the number of cells in the row, the new cell is appended to the end of the row.

Note that this convenience method inserts <td> data cells only. If you need to add a header cell into a row, you must create and insert the <th> element using Document.create Element() and Node.insertBefore() or related methods.

Name

TableSection — a header, footer, or body section of a table

Inherits from

Node, Element

Synopsis

A TableSection object represents a <tbody>, <thead>, or <tfoot> element in an HTML table. The tHead and tFoot properties of a Table are TableSection objects, and the tBodies property is an HTMLCollection of TableSection objects.

A TableSection contains TableRow objects and is contained in a Table object.

Properties

readonly HTMLCollection rows

An array-like object of TableRow objects representing the rows in this section of the table.

Methods

void deleteRow(long index)

This method deletes the row at the specified position within this section.

TableRow insertRow([long index])

This method creates a new <tr> element, inserts it into this table section at the specified position, and returns it. If index is -1 or is omitted or equals the number of rows currently in the section, the new row is appended to the end of the section. Otherwise, the new row is inserted immediately before the row that is currently at the position specified by index. Note that for this method, index specifies a row position within a single table section, not within the entire table.

Name

Text — a run of text in a document

Inherits from

Node

Synopsis

A Text node represents a run of plain text in a document and typically appear in the document tree as children of Element. The textual content of a Text node is available through the data property or through the nodeValue and textContent properties inherited from Node. You can create a new Text node with Document.createTextNode(). Text nodes never have children.

Properties

string data

The text contained by this node.

readonly unsigned long length

The length, in characters, of the text.

readonly string wholeText

The text content of this node and any adjacent text nodes before or after this one. If you’ve called the normalize() method of the parent Node, this property will be the same as data.

Methods

Unless you are writing a web-based text editor application, these methods are not commonly used.

void appendData(string text)

This method appends the specified text to the end of this Text node.

void deleteData(unsigned long offset, unsigned long count)

This method deletes characters from this Text node, starting with the character at the position offset and continuing for count characters. If offset plus count is greater than the number of characters in the Text node, all characters from offset to the end of the string are deleted.

void insertData(unsigned long offset, string text)

This method inserts the specified text into the Text node at the specified offset.

void replaceData(unsigned long offset, unsigned long count, string text)

This method replaces count characters starting at position offset with the contents of the string text. If the sum of offset and count is greater than the length of the Text node, all characters from offset on are replaced.

Text replaceWholeText(string text)

This method creates a new Text node that contains the specified text. It then replaces this node and any adjacent Text nodes with the single new node and returns the new node. See the wholeText property above and the normalize() method of Node.

Text splitText(unsigned long offset)

This method splits a Text node in two at the specified offset. The original Text node is modified so that it contains all text content up to, but not including, the character at position offset. A new Text node is created to contain all the characters from (and including) the position offset to the end of the string. This new Text node is the return value of the method. Additionally, if the original Text node has a parentNode, the new node is inserted into this parent node immediately after the original node.

string substringData(unsigned long offset, unsigned long count)

This method extracts and returns the substring that starts at position offset and continues for count characters from the text of a Text node. If a Text node contains a very large amount of text, using this method may be more efficient than using String.substring().

Name

TextArea — a multiline text input area

Inherits from

Node, Element, FormControl

Synopsis

A TextArea object represents an HTML <textarea> element that creates a multiline text input field, often within an HTML form. The initial content of the text area is specified as plain text between the <textarea> and </textarea> tags. You can query and set the displayed text with the value property.

TextArea is a form control element like Input and Select. Like those objects, it defines form, name, type, and value properties and the other properties and methods documented in FormControl.

Properties

In addition to the properties listed here, TextArea elements also define the properties of Element and FormControl and mirror HTML attributes with the following JavaScript properties: cols, maxLength, rows, placeholder, readOnly, required, and wrap.

string defaultValue

The initial plain-text content of the <textarea> element. When the form is reset, the text area is restored to this value. This property is the same as the textContent property inherited from Node.

unsigned long selectionEnd

Returns or sets the index of the first input character after the selected text. See also setSelectionRange().

unsigned long selectionStart

Returns or sets the index of the first selected character in the <textarea>. See also set Selection Range().

readonly unsigned long textLength

The length, in characters, of the value property (see FormControl).

Methods

In addition to the methods listed here, TextArea elements also implement the methods of Element and FormControl.

void select()

This method selects all the text displayed by this <textarea> element. In most browsers, this means that the text is highlighted and that new text entered by the user replaces the highlighted text instead of being appended to it.

void setSelectionRange(unsigned long start, unsigned long end)

Select text displayed in the <textarea>, starting with the character at position start and continuing up to (but not including) the character at end.

Name

TextMetrics — measurements of a string of text

Synopsis

A TextMetrics object is returned by the measureText() method of CanvasRenderingContext2D. Its width property holds the width of the measured text, in CSS pixels. Additional metrics may be added in the future.

Properties

readonly double width

The width, in CSS pixels, of the measured text.

Name

TimeRanges — a set of media time ranges

Synopsis

The buffered, played, and seekable properties of a MediaElement represent the portions of a media timeline that have data buffered, that have been played, and that playback can be started at. Each of these portions of the timeline may include multiple disjoint time ranges (this happens to the played property when the user skips to the middle of a video file, for example). A TimeRanges object represents zero or more disjoint time ranges. The length property specifies the number of ranges, and the start() and end() methods return the bounds of each range.

The TimeRanges objects returned by MediaElements are always normalized, which means that the ranges they contain are in order, nonempty and do not touch or overlap.

Properties

readonly unsigned long length

The number of ranges represented by this TimeRanges object.

Methods

double end(unsigned long n)

Returns the end time (in seconds) of time range n, or throws an exception if n is less than zero or greater than or equal to length.

double start(unsigned long n)

Returns the start time (in seconds) of time range n, or throws an exception if n is less than zero or greater than or equal to length.

Name

TypedArray — fixed-size binary arrays

Inherits from

ArrayBufferView

Synopsis

A TypedArray is an ArrayBufferView that interprets the bytes of an underlying ArrayBuffer as an array of numbers and allows read and write access to the elements of that array. This page does not document a single type named TypedArray. Instead, it covers eight different kinds of typed arrays. These eight types are all subtypes of ArrayBufferView, and they differ from each other only in the number of bytes per array element and the way those bytes are interpreted. The eight actual types are:

Int8Array

One byte per array element, interpreted as a signed integer.

Int16Array

Two bytes per array element, interpreted as a signed integer, using platform byte order.

Int32Array

Four bytes per array element, interpreted as a signed integer, using platform byte order.

