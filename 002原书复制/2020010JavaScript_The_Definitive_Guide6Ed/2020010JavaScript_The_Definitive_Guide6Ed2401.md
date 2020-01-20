Returns

The primitive string value of string. It is rarely necessary to call this method.

Throws

TypeError

If this method is invoked on an object that is not a String.

See Also

String.valueOf()

Name

String.toUpperCase() — convert a string to uppercase

Synopsis

string.toUpperCase()

Returns

A copy of string, with each lowercase letter converted to its uppercase equivalent, if it has one.

Name

String.trim() — strip leading and trailing whitespace

Availability

ECMAScript 5

Synopsis

string.trim()

Returns

A copy of string, with all leading and trailing whitespace removed.

See Also

String.replace()

Name

String.valueOf() — return the string

Inherits from

Overrides Object.valueOf()

Synopsis

string.valueOf()

Returns

The primitive string value of string.

Throws

TypeError

If this method is invoked on an object that is not a String.

See Also

String.toString()

Name

SyntaxError — thrown to signal a syntax error

Inherits from

Object → Error → SyntaxError

Constructor

new SyntaxError() new SyntaxError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the SyntaxError object.

Returns

A newly constructed SyntaxError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the SyntaxError() constructor is called as a function, without the new operator, it behaves just as it does when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor, or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All SyntaxError objects inherit the value「SyntaxError」for this property.

Description

An instance of the SyntaxError class is thrown to signal a syntax error in JavaScript code. The eval() method, the Function() constructor, and the RegExp() constructor may all throw exceptions of this type. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Name

TypeError — thrown when a value is of the wrong type

Inherits from

Object → Error → TypeError

Constructor

new TypeError() new TypeError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the TypeError object.

Returns

A newly constructed TypeError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the TypeError() constructor is called as a function, without the new operator, it behaves just as it does when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor, or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All TypeError objects inherit the value「TypeError」for this property.

Description

An instance of the TypeError class is thrown when a value is not of the type expected. This happens most often when you attempt to access a property of a null or undefined value. It can also occur if you invoke a method defined by one class on an object that is an instance of some other class, or if you use the new operator with a value that is not a constructor function, for example. JavaScript implementations are also permitted to throw TypeError objects when a built-in function or method is called with more arguments than expected. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Name

undefined — the undefined value

Synopsis

undefined

Description

undefined is a global property that holds the JavaScript undefined value. This is the same value that is returned when you attempt to read the value of a nonexistent object property. The undefined property is not enumerated by for/in loops and cannot be deleted with the delete operator. Note that undefined is not a constant and can be set to any other value, something that you should take care not to do.

When testing a value to see whether it is undefined, use the === operator, because the == operator treats the undefined value as equal to null.

Name

unescape() — decode an escaped string

Availability

deprecated

Synopsis

unescape(s)

Arguments

s

The string that is to be decoded or「unescaped.」

Returns

A decoded copy of s.

Description

unescape() is a global function that decodes a string encoded with escape(). It decodes s by finding and replacing character sequences of the form % xx and %u xxxx (where x represents a hexadecimal digit) with the Unicode characters \u00 xx and \ u xxxx.

Although unescape() was standardized in the first version of ECMAScript, it has been deprecated and removed from the standard by ECMAScript v3. Implementations of ECMAScript are likely to implement this function, but they are not required to. You should use decodeURI() and decodeURIComponent() instead of unescape(). See escape() for more details and an example.

See Also

decodeURI(), decodeURIComponent(), escape(), String

Name

URIError — thrown by URI encoding and decoding methods

Inherits from

Object → Error → URIError

Constructor

new URIError() new URIError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the URIError object.

Returns

A newly constructed URIError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the URIError() constructor is called as a function without the new operator, it behaves just as it does when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor, or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All URIError objects inherit the value「URIError」for this property.

Description

An instance of the URIError class is thrown by decodeURI() and decodeURIComponent() if the specified string contains illegal hexadecimal escapes. It can also be thrown by encodeURI() and encodeURIComponent() if the specified string contains illegal Unicode surrogate pairs. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Part IV. Client-Side JavaScript Reference

This part of the book is a reference to client-side JavaScript. It includes entries for important client-side JavaScript object such as Window, Document, Element, Event, XMLHttpRequest, Storage, Canvas, and File. There is also an entry for the jQuery library. The entries are arranged alphabetically by object name and each entry includes a complete list of the constants, properties, methods and event handlers supported by that object.

Previous editions of this book included a separate reference entry for each method, but in this edition, the reference material is made more compact (without omitting details) by including the method descriptions directly in the parent entry.

ApplicationCache DOMException HTMLOptionsCollection Script

ArrayBuffer DOMImplementation IFrame Select

ArrayBufferView DOMSettableTokenList Image Storage

Attr DOMTokenList ImageData StorageEvent

Audio Element Input Style

BeforeUnloadEvent ErrorEvent jQuery Table

Blob Event Label TableCell

BlobBuilder EventSource Link TableRow

Button EventTarget Location TableSection

Canvas FieldSet MediaElement Text

CanvasGradient File MediaError TextArea

CanvasPattern FileError MessageChannel TextMetrics

CanvasRenderingContext2D FileReader MessageEvent TimeRanges

ClientRect FileReaderSync MessagePort TypedArray

CloseEvent Form Meter URL

Comment FormControl Navigator Video

Console FormData Node WebSocket

ConsoleCommandLine FormValidity NodeList Window

CSSRule Geocoordinates Option Worker

CSSStyleDeclaration Geolocation Output WorkerGlobalScope

CSSStyleSheet GeolocationError PageTransitionEvent WorkerLocation

DataTransfer Geoposition PopStateEvent WorkerNavigator

DataView HashChangeEvent ProcessingInstruction XMLHttpRequest

Document History Progress XMLHttpRequestUpload

DocumentFragment HTMLCollection ProgressEvent

DocumentType HTMLFormControlsCollection Screen

Client-Side JavaScript Reference

* * *

Name

ApplicationCache — application cache management API

Inherits from

EventTarget

Synopsis

The ApplicationCache object is the value of the applicationCache property of the Window object. It defines an API for managing updates to cached applications. For simple cached applications, there is no need to use this API: it is sufficient to create (and update, as needed) an appropriate cache manifest, as described in Application Storage and Offline Webapps. More complex cached applications that want to more actively manage updates can use the properties, methods, and event handlers described here. See Cache Updates for more details.

Constants

The following constants are the possible values of the status property.

unsigned short UNCACHED = 0

This application does not have a manifest attribute: it is not cached.

unsigned short IDLE = 1

The manifest has been checked and this application is cached and up-to-date.

unsigned short CHECKING = 2

The browser is currently checking the manifest file.

unsigned short DOWNLOADING = 3

The browser is downloading and caching files listed in the manifest.

unsigned short UPDATEREADY = 4

A new version of the application has been downloaded and cached.

unsigned short OBSOLETE = 5

The manifest no longer exists and the cache will be deleted.

Properties

readonly unsigned short status

This property describes the cache status of the current document. Its value will be one of the constants listed above.

Methods

void swapCache()

When the status property is UPDATEREADY, the browser is maintaining two cached versions of the application: files are being served from the old version of the cache, and the new version is freshly downloaded and ready for use when the application is next reloaded. You can call swapCache() to tell the browser to immediately discard the old cache and begin serving files from the new cache. Note, however, that this can lead to version skew issues, and a safer way to flush the old cache and begin using the new one is to reload the application with Location.reload().

void update()

Normally, the browser checks for a new version of the manifest file for a cached application each time the application is loaded. Long-lived web apps can use this method to check for updates more frequently.

Event Handlers

The browser fires a sequence of events on the ApplicationCache during the manifest check and cache update process. You can use the following event handler properties of the ApplicationCache object to register event handlers, or you can use the EventTarget methods implemented by the ApplicationCache object. Handlers for most of these events are passed a simple Event object. Handlers for progress events, however, are passed a ProgressEvent object, which can be used to track how many bytes have been downloaded.

oncached

Triggered when an application has cached for the first time. This will be the last event in the sequence of events.

onchecking

Triggered when the browser begins checking the manifest file for updates. This is the first event in any sequence of application cache events.

ondownloading

Triggered when the browser begins downloading the resources listed in a manifest file, either the first time the application is cached or when there is an update. This event will generally be followed by one or more progress events.

onerror

Triggered when an error occurs during the cache update process. This can occur if the browser is offline, for example, or if an uncached application references a nonexistent manifest file.

onnoupdate

Triggered when the browser determines that the manifest has not changed and the cached application is current. This is the last event in the sequence.

onobsolete

Triggered when the manifest file for a cached application no longer exists. This causes the cache to be deleted. This is the last event in the sequence.

onprogress

Triggered periodically while the application files are being downloaded and cached. The event object associated with this event is a ProgressEvent.

onupdateready

Triggered when a new version of the application has been downloaded and cached (and is ready for use the next time the application is loaded). This is the last event in the sequence.

Name

ArrayBuffer — a fixed-length sequence of bytes

Synopsis

An ArrayBuffer represents a fixed-length sequence of bytes in memory, but it defines no way to get or set those bytes. ArrayBufferViews like the TypedArray classes provide a way to access and interpret the bytes.

Constructor

new ArrayBuffer(unsigned long length)

Creates a new ArrayBuffer with the specified number of bytes. All bytes in the new ArrayBuffer are initialized to 0.

Properties

readonly unsigned long byteLength

the length, in bytes, of the ArrayBuffer.

Name

ArrayBufferView — common properties for types based on ArrayBuffers

Synopsis

ArrayBufferView serves as a superclass for types that provide access to the bytes of an ArrayBuffer. You can’t create an ArrayBufferView directly: it exists to define the common properties for subtypes like TypedArray and DataView.

Properties

readonly ArrayBuffer buffer

The underlying ArrayBuffer that this object is a view of.

readonly unsigned long byteLength

The length, in bytes, of the portion of buffer that is accessible through this view.

readonly unsigned long byteOffset

The starting position, in bytes, of the portion of the buffer that is accessible through this view.

Name

Attr — an element attribute

Synopsis

An Attr object represents an attribute of an Element node. You can obtain an Attr object through the attributes property of the Node interface or by calling the getAttributeNode() or getAttributeNodeNS() methods of the Element interface.

Since attribute values can be completely represented by strings, it is not usually necessary to use the Attr interface at all. In most cases, the easiest way to work with attributes is with the Element.getAttribute() and Element.setAttribute() methods. These methods use strings for attribute values and avoid the use of Attr objects altogether.

Properties

readonly string localName

The name of the attribute, not including any namespace prefix.

readonly string name

The name of the attribute, including the namespace prefix, if there is one.

readonly string namespaceURI

The URI that identifies the attribute’s namespace, or null if it doesn’t have one.

readonly string prefix

The namespace prefix of the attribute, or null if it doesn’t have one.

string value

The value of the attribute.

Name

Audio — an HTML <audio> element

Inherits from

Node, Element, MediaElement

Synopsis

An Audio object represents an HTML <audio> element. Except for its constructor, an Audio object has no properties, methods or event handlers other than those inherited from MediaElement.

Constructor

new Audio([string src])

This constructor creates a new <audio> element with a preload attribute set to「auto」. If the src argument is specified, it is used as the value of the src attribute.

Name

BeforeUnloadEvent — Event object for unload events

Inherits from

Event

Synopsis

The unload event is triggered on a Window object just before the browser navigates to a new document, and gives a web application the opportunity to ask the user if he is really sure he wants to leave the page. The object passed to unload event handler functions is a BeforeUnloadEvent object. If you want to require the user to confirm that he really wants to leave the page, you do not need to, and should not, call the Window.confirm() method. Instead, return a string from the event handler or set the returnValue of this event object to a string. The string you return or set will be presented to the user in the confirmation dialog the user sees.

See also Event and Window.

Properties

string returnValue

A message to be displayed to the user in a confirmation dialog before navigating away from the page. Leave this property unset if you do not want to display a confirmation dialog.

Name

Blob — an opaque chunk of data, such as file contents

Synopsis

A Blob is an opaque type used to exchange data between APIs. Blobs may be very large and may represent binary data, but neither is required. Blobs are often stored in files, but this is an implementation detail. Blobs expose only their size and, optionally, a MIME type, and they define a single method for treating a region of a Blob as a Blob.

A number of APIs use Blobs: see FileReader for a way to read the content of a Blob and BlobBuilder for a way to create new Blob objects. See XMLHttpRequest for ways to download and upload Blobs. See Blobs for discussion of Blobs and the APIs that use them.

Properties

readonly unsigned long size

The length, in bytes, of the Blob.

readonly string type

The MIME type of the Blob, if it has one, or the empty string otherwise.

Methods

Blob slice(unsigned long start, unsigned long length, [string contentType])

Return a new Blob that represents the length bytes of this Blob starting at offset start. If contentType is specified, it will be used as the type property of the returned Blob

Name

BlobBuilder — create new Blobs

Synopsis

A BlobBuilder object is used to create new Blob objects out of strings of text and bytes from ArrayBuffer objects and other Blobs. To build a Blob, create a BlobBuilder, call append() one or more times, and then call getBlob().

Constructor

new BlobBuilder()

Create a new BlobBuilder by calling the BlobBuilder() constructor with no arguments.

Methods

void append(string text, [string endings])

Appends the specified text, encoded using UTF-8, to the Blob that is being built.

void append(Blob data)

Append the content of the Blob data to the Blob that is being built.

void append(ArrayBuffer data)

Append the bytes of the ArrayBuffer data to the Blob that is being built.

Blob getBlob([string contentType])

Return a Blob that represents all the data that has been appended to this BlobBuilder since it was created. Each call to this method returns a new Blob. If contentType is specified, it will be the value of the type property of the returned Blob. If unspecified, the returned Blob will have the empty string as its type.

Name

Button — an HTML <button>

Inherits from

Node, Element, FormControl

Synopsis

A Button object represents an HTML <button> element. Most of the properties and methods of Buttons are described in FormControl and Element. When a Button has a type property (see FormControl)「submit」, however, the other properties listed here specify form submission parameters that override similar properties on the Button’s form (see FormControl).

Properties

The following properties are meaningful only when the <button> has a type of「submit」.

string formAction

This property mirrors the formaction HTML attribute. For submit buttons, it overrides the action property of the form.

string formEnctype

This property mirrors the formenctype HTML attribute. For submit buttons, it overrides the enctype property of the form and has the same legal values as that property.

string formMethod

This property mirrors the formmethod HTML attribute. For submit buttons, it overrides the method property of the form.

string formNoValidate

This property mirrors the formnovalidate HTML attribute. For submit buttons, it overrides the noValidate property of the form.

string formTarget

This property mirrors the formtarget HTML attribute. For submit buttons, it overrides the target property of the form.

Name

Canvas — an HTML element for scripted drawing

Inherits from

Node, Element

Synopsis

The Canvas object represents an HTML canvas element. It has no behavior of its own, but it defines an API that supports scripted client-side drawing operations. You can specify the width and height directly on this object, and you can extract an image from the canvas with toDataURL(), but the actual drawing API is implemented by a separate「context」object returned by the getContext() method. See CanvasRenderingContext2D.

Properties

unsigned long height

unsigned long width

These properties mirror the width and height attributes of the <canvas> tag and specify the dimensions of the canvas coordinate space. The defaults are 300 for width and 150 for height.

If the size of the canvas element is not otherwise specified in a stylesheet or with the inline style attribute, these width and height properties also specify the on-screen dimensions of the canvas element.

Setting either of these properties (even setting it to its current value) clears the canvas to transparent black and resets all of its graphics attributes to their default values.

Methods

object getContext(string contextId, [any args...])

This method returns an object with which you can draw into the Canvas element. When you pass the string「2d」, it will return a CanvasRenderingContext2D object for 2D drawing. No additional args are required in this case.

There is only one CanvasRenderingContext2D object per canvas element, so repeated calls to getContext("2d") return the same object.

HTML5 standardizes the「2d」argument to this method and defines no other valid arguments. A separate standard, WebGL, is under development for 3D graphics. In browsers that support it, you can pass the string「webgl」to this method to obtain an object that allows 3D rendering. Note, however, that the CanvasRenderingContext2D object is the only drawing context documented in this book.

string toDataURL([string type], [any args...])

toDataURL() returns the contents of the canvas bitmap as a data:// URL that can easily be used with an <img> tag or transmitted across the network. For example:

// Copy the content of a canvas into an <img> and append to the document var canvas = document.getElementById("my_canvas"); var image = document.createElement("img"); image.src = canvas.toDataURL(); document.body.appendChild(image);

The type argument specifies the MIME type of the image format to use. If this argument is omitted, the default value is「image/png」. The PNG image format is the only one that implementations are required to support. For image types other than PNG, additional arguments may be passed to specify encoding details. If type is「image/jpeg」, for example, the second argument should be a number between 0 and 1 specifying the image quality level. No other parameter arguments are standardized at the time of this writing.

To prevent cross-origin information leaks, toDataURL() does not work on <canvas> tags that are not「origin-clean.」A canvas is not origin-clean if it has ever had an image drawn in it (directly by drawImage() or indirectly through a CanvasPattern) that has a different origin than the document that contains the canvas. Also, a canvas is not origin-clean if it has ever had text drawn to it using a web font from a different origin.

Name

CanvasGradient — a color gradient for use in a canvas

Synopsis

A CanvasGradient object represents a color gradient that can be assigned to both the stroke Style and fillStyle properties of a CanvasRenderingContext2D object. The createLinearGradient() and createRadialGradient() methods of CanvasRenderingContext2D both return CanvasGradient objects.

Once you have created a CanvasGradient object, use addColorStop() to specify what colors should appear at what positions within the gradient. Between the positions you specify, colors are interpolated to create a smooth gradient or fade. If you specify no color stops, the gradient will be uniform transparent black.

Methods

void addColorStop(double offset, string color)

addColorStop() specifies fixed colors within a gradient. color is a CSS color string. offset is a floating-point value in the range 0.0 to 1.0 that represents a fraction between the start and end points of the gradient. An offset of 0 corresponds to the start point, and an offset of 1 corresponds to the end point.

If you specify two or more color stops, the gradient will smoothly interpolate colors between the stops. Before the first stop, the gradient will display the color of the first stop. After the last stop, the gradient will display the color of the last stop. If you specify only a single stop, the gradient will be one solid color. If you specify no color stops, the gradient will be uniform transparent black.

Name

CanvasPattern — an image-based pattern for use in a Canvas

Synopsis

A CanvasPattern object is an opaque object returned by the createPattern() method of a CanvasRenderingContext2D object. A CanvasPattern object can be used as the value of the strokeStyle and fillStyle properties of a CanvasRenderingContext2D object.

Name

CanvasRenderingContext2D — the object used for drawing on a canvas

Synopsis

The CanvasRenderingContext2D object provides properties and methods for drawing two-dimensional graphics. The following sections provide an overview. See Graphics in a <canvas>, Canvas, CanvasGradient, CanvasPattern, ImageData, and TextMetrics for further details.

Creating and rendering paths

A powerful feature of the canvas is its ability to build shapes up from basic drawing operations, then either draw their outlines (stroke them) or paint their contents (fill them). The operations accumulated are collectively referred to as the current path. A canvas maintains a single current path.

In order to build a connected shape out of multiple segments, a joining point is needed between drawing operations. For this purpose, the canvas maintains a current position. The canvas drawing operations implicitly use this as their start point and update it to what is typically their end point. You can think of this like drawing with a pen on paper: when finishing a particular line or curve, the current position is where the pen rested after completing the operation.

You can create a sequence of disconnected shapes in the current path that will be rendered together with the same drawing parameters. To separate shapes, use the moveTo() method; this moves the current position to a new location without adding a connecting line. When you do this, you create a new subpath, which is the canvas term used for a collection of operations that are connected.

The available path operations are lineTo() for drawing straight lines, rect() for drawing rectangles, arc() and arcTo() for drawing partial circles, and bezierCurveTo() and quadraticCurveTo() for drawing curves.

Once the path is complete, you can draw its outline with stroke(), paint its contents with fill(), or do both.

In addition to stroking and filling, you can also use the current path to specify the clipping region the canvas uses when rendering. Pixels inside this region are displayed; those outside are not. The clipping region is cumulative; calling clip() intersects the current path with the current clipping region to yield a new region.

If the segments in any of the subpaths do not form a closed shape, fill() and clip() operations implicitly close them for you by adding a virtual (not visible with a stroke) line segment from the start to the end of the subpath. Optionally, you can call closePath() to explicitly add this line segment.

To test whether a point is inside (or on the boundary of) the current path, use isPointInPath(). When a path intersects itself or consists of multiple overlapping subpaths, the definition of「inside」is based on the nonzero winding rule. If you draw a circle inside another circle and both circles are drawn in the same direction, everything inside the larger circle is considered inside the path. If, on the other hand, one circle is drawn clockwise and the other counterclockwise, you have defined a donut shape and the interior of the smaller circle is outside of the path. This same definition of insideness is used by the fill() and clip() methods.

Colors, gradients, and patterns

When filling or stroking paths, you can specify how the lines or filled area are rendered using the fillStyle and strokeStyle properties. Both accept CSS-style color strings, as well as CanvasGradient and CanvasPattern objects that describe gradients and patterns. To create a gradient, use the createLinearGradient() or createRadialGradient() methods. To create a pattern, use createPattern().

To specify an opaque color using CSS notation, use a string of the form「#RRGGBB」, where RR, GG, and BB are hexadecimal digits that specify the red, green, and blue components of the color as values between 00 and FF. For example, bright red is「#FF0000」. To specify a partially transparent color, use a string of the form「rgba(R,G,B,A)」. In this form, R, G, and B specify the red, green, and blue components of the color as decimal integers between 0 and 255, and A specifies the alpha (opacity) component as a floating-point value between 0.0 (fully transparent) and 1.0 (fully opaque). For example, half-transparent bright red is「rgba(255,0,0,0.5)」.

Line width, line caps, and line joins

Canvas defines several properties that specify how lines are stroked. You can specify the width of the line with the lineWidth property, how the end points of lines are drawn with the lineCap property, and how lines are joined using the lineJoin property.

Drawing rectangles

You can outline and fill rectangles with strokeRect() and fillRect(). In addition, you can clear the area defined by a rectangle with clearRect().

Drawing images

In the Canvas API, images are specified using Image objects that represent HTML <img> elements or offscreen images created with the Image() constructor. (See the Image reference page for details.) A <canvas> element or <video> element can also be used as an image source.

You can draw an image into a canvas with the drawImage() method, which, in its most general form, allows an arbitrary rectangular region of the source image to be scaled and rendered into the canvas.

Drawing Text

The fillText() method draws text and the strokeText() method draws outlined text. The font property specifies the font to use; the value of this property should be a CSS font specification string. The textAlign property specifies whether text is left-justified, centered, or right-justified on the X coordinate you pass, and the textBaseline property specifies where the text is drawn in relation to the Y coordinate you pass.

Coordinate space and transformations

By default, the coordinate space for a canvas has its origin at (0,0) in the upper left corner of the canvas, with x values increasing to the right and y values increasing down. The width and height attributes of the <canvas> tag specify the maximum X and Y coordinates, and a single unit in this coordinate space normally translates to a single on-screen pixel.

You can define your own coordinate space and the coordinates you pass to the canvas drawing methods will automatically be transformed. This is done with the translate(), scale(), and rotate() methods, which affect the transformation matrix of the canvas. Because the coordinate space can be transformed like this, the coordinates you pass to methods such as lineTo() cannot be measured in pixels and the Canvas API uses floating-point numbers instead of integers.

Shadows

CanvasRenderingContext2D can automatically add a drop shadow to anything you draw. The color of the shadow is specified with shadowColor, and its offset is changed using shadowOffsetX and shadowOffsetY. In addition, the amount of feathering applied to the shadow’s edge can be set with shadowBlur.

Compositing

Usually, when you draw on a canvas, the newly drawn graphics appear on top of the previous content of the canvas, partially or fully obscuring the old content, depending on the opacity of the new graphics. The process of combining new pixels with old pixels is called「compositing」and you can alter the way the canvas composites pixels by specifying different values for the globalCompositeOperation property. For example, you can set this property so that newly drawn graphics appear underneath the existing content.

The following table lists the allowed property values and their meanings. The word source in the table refers to the pixels being drawn onto the canvas, and the word destination refers to the existing pixels on the canvas. The word result refers to the pixels that result from the combination of the source and destination. In the formulas, the letter S is the source pixel, D is the destination pixel, R is the result pixel, αs is the alpha channel (the opacity) of the source pixel, and αd is the alpha channel of the destination:

ValueFormulaMeaning

"copy" R = S Draws the source pixel, ignoring the destination pixel.

"destination-atop" R=(1-αd)S + αsD Draw the source pixel underneath the destination. If the source is transparent, the result is also transparent.

"destination-in" R = αsD Multiply the destination pixel by the opacity of the source pixel, but ignore the color of the source.

"destination-out" R = (1-αs)D The destination pixel is made transparent when the source is opaque and is left unchanged when the source is transparent. The color of the source pixel is ignored.

"destination-over" R = (1-αd)S + D The source pixel appears behind the destination pixel, showing through based on the transparency of the destination.

"lighter" R = S + D The color components of the two pixels are simply added together and clipped if the sum exceeds the maximum value.

"source-atop" R=αdS + (1-αs)D Draw the source pixel on top of the destination but multiply it by the opacity of the destination. Don’t draw anything over a transparent destination.

"source-in" R = αdS Draw the source pixel, but multiply it by the opacity of the destination. The color of the destination is ignored. If the destination is transparent, the result is transparent, too.

"source-out" R = (1-αd)S The result is the source pixel where the destination is transparent and transparent pixels where the destination is opaque. The color of the destination is ignored.

"source-over" R = S + (1-αs)D The source pixel is drawn on top of the destination pixel. If the source is translucent, the destination pixel contributes to the result. This is the default value of the global Composite Operation property.

"xor" R = (1-αd)S + (1-αs)D If the source is transparent, the result is the destination. If the destination is transparent, the result is the source. If source and destination are both transparent or both opaque, the result is transparent.

Saving graphics state

The save() and restore() methods allow you to save and restore the state of a CanvasRenderingContext2D object. save() pushes the current state onto a stack, and restore() pops the most recently saved state off the top of the stack and sets the current drawing state based on those stored values.

All properties of the CanvasRenderingContext2D object (except for the canvas property, which is a constant) are part of the saved state. The transformation matrix and clipping region are also part of the state, but the current path and current point are not.

Manipulating Pixels

The getImageData() method allows you to query the raw pixels of a canvas, and putImageData() allows you to set individual pixels. These can be useful if you want to implement image processing operations in JavaScript.

Properties

readonly Canvas canvas

The Canvas element upon which this context will draw.

any fillStyle

The current color, pattern, or gradient used for filling paths. This property can be set to a CSS color string or to a CanvasGradient or CanvasPattern object. The default fill style is solid black.

string font

The font to be used by text-drawing methods, specified as a string, using the same syntax as the CSS font attribute. The default is「10px sans-serif」. If the font string uses font size units like「em」or「ex」or uses relative keywords like「larger」,「smaller」,「bolder」, or「lighter」, these are interpreted relative to the computed style of the CSS font of the <canvas> element.

double globalAlpha

Specifies additional transparency to be added to everything drawn on the canvas. The alpha value of all pixels drawn on the canvas is multiplied by the value of this property. The value must be a number between 0.0 (makes everything completely transparent) and 1.0 (the default: adds no additional transparency).

string globalCompositeOperation

This property specifies how source pixels being rendered onto the canvas are combined (or「composited」) with the destination pixels that already exist in the canvas. This property is typically only useful when you are working with partially transparent colors or have set the globalAlpha property. The default value is "source-over". Other commonly used values are「destination-over」and「copy」. See the table of legal values above. Note that at the time of this writing, browsers have differing implementations of certain compositing modes: some composite locally and some composite globally. See Compositing for details.

string lineCap

The lineCap property specifies how lines should be terminated. It matters only when drawing wide lines. Legal values for this property are listed in the following table. The default value is「butt」.

ValueMeaning

