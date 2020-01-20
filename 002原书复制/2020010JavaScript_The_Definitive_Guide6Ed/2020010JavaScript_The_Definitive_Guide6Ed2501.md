"butt" This default value specifies that the line should have no cap. The end of the line is straight and is perpendicular to the direction of the line. The line is not extended beyond its endpoint.

"round" This value specifies that lines should be capped with a semicircle whose diameter is equal to the width of the line and which extends beyond the end of the line by one half the width of the line.

"square" This value specifies that lines should be capped with a rectangle. This value is like「butt」, but the line is extended by half of its width.

string lineJoin

When a path includes vertices where line segments and/or curves meet, the lineJoin property specifies how those vertices are drawn. The effect of this property is apparent only when drawing with wide lines.

The default value of the property is「miter」, which specifies that the outside edges of the two line segments are extended until they intersect. When two lines meet at an acute angle, mitered joins can become quite long. The miterLimit property places an upper bound on the length of a miter. If a miter would exceed this limit, it is converted to a bevel.

The value「round」specifies that the outside edges of the vertex should be joined with a filled arc whose diameter is equal to the width of the line. The value「bevel」specifies that the outside edges of the vertex should be joined with a filled triangle.

double lineWidth

Specifies the line width for stroking (line drawing) operations. The default is 1. Lines are centered over the path, with half of the line width on each side.

double miterLimit

When lines are drawn with the lineJoin property set to「miter」and two lines meet at an acute angle, the resulting miter can be quite long. When miters are too long, they become visually jarring. This miterLimit property places an upper bound on the length of the miter. This property expresses a ratio of the miter length to half the line width. The default value is 10, which means that a miter should never be longer than 5 times the line width. If a miter formed by two lines would be longer than the maximum allowed by miter Limit , those two lines will be joined with a bevel instead of a miter.

double shadowBlur

Specifies how much blur shadows should have. The default is 0, which produces crisp-edged shadows. Larger values produce larger blurs, but note that the units are not measured in pixels and are not affected by the current transform.

string shadowColor

Specifies the color of shadows as a CSS color string. The default is transparent black.

double shadowOffsetX

double shadowOffsetY

Specify the horizontal and vertical offset of the shadows. Larger values make the shadowed object appear to float higher above the background. The default is 0. These values are in coordinate space units and they are independent of the current transform.

any strokeStyle

Specifies the color, pattern, or gradient used for stroking (drawing) paths. This property can be a CSS color string or a CanvasGradient or a CanvasPattern object.

string textAlign

Specifies the horizontal alignment of text and the meaning of the X coordinate passed to fillText() and strokeText(). Legal values are「left」,「center」,「right」,「start」, and「end」. The meaning of「start」and「end」depend on the dir (text direction) attribute of the <canvas> tag. The default is「start」.

string textBaseline

Specifies the vertical alignment of text and the meaning of the Y coordinate passed to fillText() and strokeText(). Legal values are「top」,「middle」,「bottom」,「alphabetic」,「hanging」, and「ideographic」. The default is「alphabetic」.

Methods

void arc(double x, y,radius, startAngle,endAngle, [boolean anticlockwise])

This method adds an arc to the current subpath of a canvas, using a center point and radius. The first three arguments to this method specify the center and radius of a circle. The next two arguments are angles that specify the start and end points of an arc along the circle. These angles are measured in radians. The three o’clock position along the positive X axis is an angle of 0, and angles increase in the clockwise direction. The final argument specifies whether the arc is traversed counterclockwise (true) or clockwise (false or omitted) along the circle’s circumference.

Invoking this method adds a straight line between the current point and the start point of the arc and then adds the arc itself to the current path.

void arcTo(double x1, y1, x2, y2, radius)

This method adds a straight line and an arc to the current subpath and describes that arc in a way that makes it particularly useful for adding rounded corners to polygons. The arguments x1 and y1 specify a point P1, and the arguments x2 and y2 specify a point P2. The arc that is added to the path is a portion of a circle with the specified radius. The arc has one point tangent to the line from the current position to P1 and one point that is tangent to the line from P1 to P2. The arc begins and ends at these two tangent points and is drawn in the direction that connects those two points with the shortest arc. Before adding the arc to the path, this method adds a straight line from the current point to the start point of the arc. After calling this method, the current point is at the end point of the arc, which lies on the line between P1 and P2.

Given a context object c, you can draw a 100x100 square with rounded corners (of varying radii) with code like this:

c.beginPath(); c.moveTo(150, 100); // Start in the middle of the top edge c.arcTo(200,100,200,200,40); // Draw top edge and rounded upper right corner c.arcTo(200,200,100,200,30); // Draw right edge and (less) rounded lower right c.arcTo(100,200,100,100,20); // Draw bottom and rounded lower left corner c.arcTo(100,100,200,100,10); // Draw left and rounded upper left corner c.closePath(); // Back to the starting point. c.stroke(); // Draw the path

void beginPath()

beginPath() discards any currently defined path and begins a new one. There is no current point after a call to beginPath().

When the context for a canvas is first created, beginPath() is implicitly called.

void bezierCurveTo(double cp1x, cp1y,cp2x, cp2y, x, y)

bezierCurveTo() adds a cubic Bezier curve to the current subpath of a canvas. The start point of the curve is the current point of the canvas, and the end point is (x,y). The two Bezier control points (cpX1, cpY1) and (cpX2, cpY2) define the shape of the curve. When this method returns, the current position is (x,y).

void clearRect(double x, y, width, height)

clearRect() fills the specified rectangle with transparent black. Unlike rect(), it does not affect the current point or the current path.

void clip()

This method computes the intersection of the inside of the current path with the current clipping region and uses that (smaller) region as the new clipping region. Note that there is no way to enlarge the clipping region. If you want a temporary clipping region, you should first call save() so that you can later restore() the original clipping region. The default clipping region for a canvas is the canvas rectangle itself.

Like the fill() method, clip() treats all subpaths as closed and uses the nonzero winding rule for distinguishing the inside of the path from the outside of the path.

void closePath()

If the current subpath of the canvas is open, closePath() closes it by adding a line connecting the current point to the first point of the subpath. It then begins a new subpath (as if by calling moveTo()) at that same point.

fill() and clip() treat all subpaths as if they had been closed, so you only need to call closePath() explicitly if you want to stroke() a closed path.

ImageData createImageData(ImageData imagedata)

Returns a new ImageData object with the same dimensions as data.

ImageData createImageData(double w, double h)

Returns a new ImageData object with the specified width and height. All pixels within this new ImageData object are initialized to transparent black (all color components and alpha are 0).

The w and h arguments specify image dimensions in CSS pixels. Implementations are allowed to map single CSS pixels to more than one underlying device pixel. The width and height properties of the returned ImageData object specify the image dimensions in device pixels, and these values may not match the w and h arguments.

CanvasGradient createLinearGradient(double x0, y0, x1, y1)

This method creates and returns a new CanvasGradient object that linearly interpolates colors between the start point (x0,y0) and the end point (x1,y1). Note that this method does not specify any colors for the gradient. Use the addColorStop() method of the returned object to do that. To stroke lines or fill areas using a gradient, assign a CanvasGradient object to the strokeStyle or fillStyle properties.

CanvasPattern createPattern(Element image, string repetition)

This method creates and returns a CanvasPattern object that represents the pattern defined by a tiled image. The image argument must be an <img>, <canvas>, or <video> element containing the image to be used as the pattern. The repetition argument specifies how the image is tiled. The possible values are:

ValueMeaning

"repeat" Tile the image in both directions. This is the default.

"repeat-x" Tile the image in the X dimension only.

"repeat-y" Tile the image in the Y dimension only.

"no-repeat" Do not tile the image; use it a single time only.

To use a pattern for stroking lines or filling areas, use a CanvasPattern object as the value of the strokeStyle or fillStyle properties.

CanvasGradient createRadialGradient(double x0, y0, r0, x1, y1, r1)

This method creates and returns a new CanvasGradient object that radially interpolates colors between the circumferences of the two specified circles. Note that this method does not specify any colors for the gradient. Use the addColorStop() method of the returned object to do that. To stroke lines or fill areas using a gradient, assign a CanvasGradient object to the stroke Style or fillStyle properties.

Radial gradients are rendered by using the color at offset 0 for the circumference of the first circle, the color at offset 1 for the second circle, and interpolated color values at circles between the two.

void drawImage(Element image, double dx, dy, [dw, dh])

Copy the specified image (which must be an <img>, <canvas>, or <video> element) into the canvas with its upper left corner at (dx,dy). If dw and dh are specified, the image is scaled so that it is dw pixels wide and dh pixels high.

void drawImage(Element image, double sx, sy, sw, sh, dx, dy, dw, dh)

This version of the drawImage() method copies a source rectangle of the specified image into a destination rectangle of the canvas. image must be an <img>, <canvas>, or <video> element. (sx,sy) specifies the upper left corner of the source rectangle within that image and sw and sh specify the width and height of the source rectangle. Note that these arguments are in CSS pixels and are not subject to transformation. The remaining arguments specify the destination rectangle into which the image should be copied: see the five-argument version of drawImage() for details. Note that these destination rectangle arguments are transformed by the current transformation matrix.

void fill()

fill() fills the current path with the color, gradient, or pattern specified by the fillStyle property. Any subpaths that are not closed are filled as if the closePath() method had been called on them. (Note, however, that this does not actually cause those subpaths to become closed.)

Filling a path does not clear the path. You can call stroke() after calling fill() without redefining the path.

When the path intersects itself or when subpaths overlap, fill() canvas uses the nonzero winding rule to determine which points are inside the path and which are outside. This means, for example, that if your path defines a square inside of a circle and the square’s subpath winds in the opposite direction of the circle’s path, the interior of the square will be outside of the path and will not be filled.

void fillRect(double x, y, width, height)

fillRect() fills the specified rectangle with the color, gradient, or pattern specified by the fillStyle property.

Unlike the rect() method, fillRect() has no effect on the current point or the current path.

void fillText(string text, double x, y, [double maxWidth])

fillText() draws text using the current font and fillStyle properties. The x and y arguments specify where on the canvas the text should be drawn, but the interpretation of these arguments depends on the textAlign and textBaseline properties, respectively.

If textAlign is left or is start (the default) for a canvas that uses left-to-right text (also the default) or end for a canvas that uses right-to-left text, the text is drawn to the right of the specified X coordinate. If textAlign is center, the text is horizontally centered around the specified X coordinate. Otherwise (if textAlign is「right」, is「end」for left-to-right text, or is「start」for right-to-left text), the text is drawn to the left of the specified X coordinate.

If textBaseline is「alphabetic」(the default),「bottom」, or「ideographic」, most of the glyphs will appear above the specified Y coordinate. If textBaseline is「center」, the text will be approximately vertically centered on the specified Y coordinate. And if textBaseline is「top」or「hanging」, most of the glyphs will appear below the specified Y coordinate.

The optional maxwidth argument specifies a maximum width for the text. If the text would be wider than maxWidth, the text will be drawn using a smaller or more condensed version of the font instead.

ImageData getImageData(double sx, sy, sw, sh)

The arguments to this method are untransformed coordinates that specify a rectangular region of the canvas. The method copies the pixel data from that region of the canvas into a new ImageData object and returns that object. See ImageData for an explanation of how to access the red, green, blue, and alpha components of the individual pixels.

The RGB color components of the returned pixels are not premultiplied by the alpha value. If any portions of the requested rectangle lie outside the bounds of the canvas, the associated pixels in the ImageData are set to transparent black (all zeros). If the implementation uses more than one device pixel per CSS pixel, the width and height properties of the returned ImageData object will be different from the sw and sh arguments.

Like Canvas.toDataURL(), this method is subject to a security check to prevent cross-origin information leakage. getImageData() only returns an ImageData object if the underlying canvas is「origin-clean」; otherwise, it raises an exception. A canvas is not origin-clean if it has ever had an image drawn in it (directly by drawImage() or indirectly through a CanvasPattern) that has a different origin than the document that contains the canvas. Also, a canvas is not origin-clean if it has ever had text drawn to it using a web font from a different origin.

boolean isPointInPath(double x, y)

isPointInPath() returns true if the specified point falls within or on the edge of the current path and returns false otherwise. The specified point is not transformed by the current transformation matrix. x should be a value between 0 and canvas.width and y should be a value between 0 and canvas.height.

The reason that isPointInPath() tests untransformed points is that it is designed for「hit-testing」: determining whether a user’s mouse click (for example) is on top of the portion of the canvas described by the path. In order to do hit-testing, mouse coordinates must first be translated so that they are relative to the canvas rather than the window. If the canvas’s size on the screen is different than the size declared by its width and height attributes (if style.width and style.height have been set, for example), the mouse coordinates also have to be scaled to match the canvas coordinates. The following function is designed for use as an onclick handler of a <canvas> and performs the necessary transformation to convert mouse coordinates to canvas coordinates:

// An onclick handler for a canvas tag. Assumes a path is currently defined. function hittest(event) { var canvas = this; // Called in the context of the canvas var c = canvas.getContext("2d"); // Get drawing context of the canvas // Get the canvas size and position var bb = canvas.getBoundingClientRect(); // Convert mouse event coordinates to canvas coordinates var x = (event.clientX-bb.left)*(canvas.width/bb.width); var y = (event.clientY-bb.top)*(canvas.height/bb.height); // Fill the path if the user clicked on it if (c.isPointInPath(x,y)) c.fill(); }

void lineTo(double x, double y)

lineTo() adds a straight line to the current subpath. The line begins at the current point and ends at (x,y). When this method returns, the current position is (x,y).

TextMetrics measureText(string text)

measureText() measures the width that the specified text would occupy if drawn with the current font and returns a TextMetrics object containing the results of the measurement. At the time of this writing, the returned object has only a single width property, and the text height and bounding box are not measured.

void moveTo(double x, double y)

moveTo() sets the current position to (x,y) and begins a new subpath with this as its first point. If there was a previous subpath and it consisted of just one point, that empty subpath is removed from the path.

void putImageData(ImageData imagedata, double dx, dy, [sx, sy, sw, sh])

putImageData() copies a rectangular block of pixels from an ImageData object onto the canvas. This is a low-level pixel copy operation: the globalCompositeOperation and globalAlpha attribute are ignored, as are the clipping region, transformation matrix, and shadow-drawing attributes.

The dx and dy arguments specify the destination point in the canvas. Pixels from data will be copied to the canvas starting at that point. These arguments are not transformed by the current transformation matrix.

The last four arguments specify a source rectangle within the ImageData. If specified, only the pixels within that rectangle will be copied to the canvas. If these arguments are omitted, all pixels in the ImageData will be copied. If these arguments specify a rectangle that exceeds the bounds of the ImageData, the rectangle will be clipped to those bounds. Negative values for sx and sy are allowed.

One use for ImageData objects is as a「backing store」for a canvas—saving a copy of the canvas pixels in an ImageData (using getImageData()) allows you to draw temporarily on the canvas and then restore it to its original state with putImageData().

void quadraticCurveTo(double cpx, cpy, x, y)

This method adds a quadratic Bezier curve segment to the current subpath. The curve starts at the current point and ends at (x,y). The control point (cpX, cpY) specifies the shape of the curve between these two points. (The mathematics of Bezier curves is beyond the scope of this book, however.) When this method returns, the current position is (x,y). Also see the bezierCurveTo() method.

void rect(double x, y, w, h)

This method adds a rectangle to the path. This rectangle is in a subpath of its own and is not connected to any other subpaths in the path. When this method returns, the current position is (x,y). A call to this method is equivalent to the following sequence of calls:

c.moveTo(x,y); c.lineTo(x+w, y); c.lineTo(x+w, y+h); c.lineTo(x, y+h); c.closePath();

void restore()

This method pops the stack of saved graphics states and restores the values of the CanvasRenderingContext2D properties, the clipping path, and the transformation matrix. See the save() method for further information.

void rotate(double angle)

This method alters the current transformation matrix so that any subsequent drawing appears rotated within the canvas by the specified angle. It does not rotate the <canvas> element itself. Note that the angle is specified in radians. To convert degrees to radians, multiply by Math.PI and divide by 180.

void save()

save() pushes a copy of the current graphics state onto a stack of saved graphics states. This allows you to temporarily change the graphics state, and then restore the previous values with a call to restore().

The graphics state of a canvas includes all the properties of the CanvasRenderingContext2D object (except for the read-only canvas property). It also includes the transformation matrix that is the result of calls to rotate(), scale(), and translate(). Additionally, it includes the clipping path, which is specified with the clip() method. Note, however, that the current path and current position are not part of the graphics state and are not saved by this method.

void scale(double sx, double sy)

scale() adds a scale transformation to the current transformation matrix of the canvas. Scaling is done with independent horizontal and vertical scaling factors. For example, passing the values 2.0 and 0.5 causes subsequently drawn paths to be twice as wide and half as high as they would otherwise have been. Specifying a negative value for sx causes X coordinates to be flipped across the Y axis, and a negative value of sy causes Y coordinates to be flipped across the X axis.

void setTransform(double a, b, c, d, e, f)

This method allows you to set the current transformation matrix directly rather than through a series of calls to translate(), scale(), and rotate(). After calling this method, the new transformation is:

x' a c e x = ax + cy + e y' = b d f × y = bx + dy + f 1 0 0 1 1

void stroke()

The stroke() method draws the outline of the current path. The path defines the geometry of the line that is produced, but the visual appearance of that line depends on the strokeStyle, lineWidth, lineCap, lineJoin, and miterLimit properties.

The term stroke refers to a pen or brush stroke. It means「draw the outline of.」Contrast this stroke() method with fill(), which fills the interior of a path rather than stroking the outline of the path.

void strokeRect(double x, y, w, h)

This method draws the outline (but does not fill the interior) of a rectangle with the specified position and size. Line color and line width are specified by the strokeStyle and lineWidth properties. The appearance of the rectangle corners is specified by the lineJoin property.

Unlike the rect() method, strokeRect() has no effect on the current path or the current point.

void strokeText(string text, double x, y, [maxWidth])

strokeText() works just like fillText(), except that instead of filling the individual character glyphs with fillStyle, it strokes the outline of each glyph using strokeStyle. strokeText() produces interesting graphical effects when used at large font sizes, but fillText() is more commonly used for actually drawing text.

void transform(double a, b, c, d, e, f)

The arguments to this method specify the six nontrivial elements of a 3x3 affine transformation matrix T:

a c e b d f 0 0 1

transform() sets the current transformation matrix to the product of the transformation matrix and the T:

CTM' = CTM × T

Translations, scales, and rotations can be implemented in terms of this general-purpose transform() method. For a translation, call transform(1,0,0,1,dx,dy). For a scale, call transform (sx, 0, 0, sy, 0, 0). For a clockwise rotation around the origin by an angle x, use:

transform(cos(x),sin(x),-sin(x), cos(x), 0, 0)

For a shear by a factor of k parallel to the X axis, call transform(1,0,k,1,0,0). For a shear parallel to the Y axis, call transform(1,k,0,1,0,0).

void translate(double x, double y)

translate() adds horizontal and vertical offsets to the transformation matrix of the canvas. The arguments dx and dy are added to all points in any subsequently defined paths.

Name

ClientRect — an element bounding box

Synopsis

A ClientRect object describes a rectangle, using Window or viewport coordinates. The getBoundingClientRect() method of Element returns objects of this kind to describe the on-screen bounding box of an element. ClientRect objects are x static: they do not change when the element they describe changes.

Properties

readonly float bottom

The Y position, in viewport coordinates, of the bottom edge of the rectangle.

readonly float height

The height, in pixels, of the rectangle. In IE8 and before, this property is not defined; use bottom-top instead.

readonly float left

The X position, in viewport coordinates, of the left edge of the rectangle.

readonly float right

The X position, in viewport coordinates, of the right edge of the rectangle.

readonly float top

The Y position, in viewport coordinates, of the top edge of the rectangle.

readonly float width

The width, in pixels, of the rectangle. In IE8 and before, this property is not defined; use right-left instead.

Name

CloseEvent — specifies whether a WebSocket closed cleanly

Inherits from

Event

Synopsis

When a WebSocket connection closes, a nonbubbling, noncancelable close event is fired on the WebSocket object and an associated CloseEvent object is passed to any registered event handlers.

Properties

readonly boolean wasClean

If the WebSocket connection closed in the controlled way specified by WebSocket protocol, with acknowledgment between client and server, the close is said to be clean, and this property will be true. If this property is false, the WebSocket may have closed as the result of a network error of some sort.

Name

Comment — an HTML or XML comment

Inherits from

Node

Synopsis

A Comment node represents a comment in an HTML or XML document. The content of the comment (i.e., the text between <!-- and -->) is available through the data property or through the nodeValue property inherited from Node. You can create a comment object with Document.createComment().

Properties

string data

The text of the comment.

readonly unsigned long length

The number of characters in the comment.

Methods

void appendData(string data)

void deleteData(unsigned long offset, unsigned long count)

void insertData(unsigned long offset, string data)

void replaceData(unsigned long offset, unsigned long count, string data)

string substringData(unsigned long offset, unsigned long count)

Comment nodes have most of the methods of a Text node, and those methods work as they do on Text nodes. They are listed here, but see Text for documentation.

Name

Console — debugging output

Synopsis

Modern browsers (and older ones with debugger extensions, such as Firebug, installed) define a global property console that refers to a Console object. The methods of this object define a API for simple debugging tasks, such as logging messages to a console window (the console may go by a name such as「Developer Tools」or「Web Inspector」).

There is no formal standard that defines the Console API, but the Firebug debugger extension for Firefox has established a de facto standard and browser vendors seem to be implementing the Firebug API, which is documented here. Support for the basic console.log() function is nearly universal, but the other functions may not be as well supported in all browsers.

Note that in some older browsers, the console property is only defined when the console window is open, and running scripts that use the Console API without the console open will cause errors.

See also ConsoleCommandLine.

Methods

void assert(any expression, string message)

Display an error message on the console if expression is false or a falsy value like null, undefined, 0, or the empty string.

void count([string title])

Display the specified title string along with a count of the number of times that this method has been called with that string.

void debug(any message...)

Like console.log(), but mark the output as debugging information.

void dir(any object)

Display the JavaScript object on the console in a way that allows the developer to examine its properties or elements and interactively explore nested objects or arrays.

void dirxml(any node)

Display XML or HTML markup for the document node in the console.

void error(any message...)

Like console.log(), but mark the output as an error.

void group(any message...)

Display message in the same way that log() does, but display it as the title of a collapsible group of debug messages. All subsequent console output will be formatted as part of this group until a corresponding call to groupEnd() occurs.

void groupCollapsed(any message...)

Begin a new group of messages, but start it in its collapsed state, so that subsequent debugging output is hidden by default.

void groupEnd()

End the debugging output group most recently started with group() or groupCollapsed().

void info(any message...)

Like console.log(), but mark the output as an informative message.

void log(string format, any message...)

This method displays its arguments in the console. In the simplest case, when format does not contain any % characters, it simply converts its arguments to strings and displays them with spaces in between. When an object is passed to this method, the string that is displayed in the console will be clickable to view the contents of the object.

For more complex log messages, this method supports a simple subset of the C language printf() formatting capabilities. The message arguments will be interpolated into the format argument in place of the character sequences「%s」,「%d」,「%i」,「%f」, and「%o」, and then the formatted string will be displayed in the console (followed by any unused message arguments). Arguments that replace「%s」are formatted as strings. Those that replace「%d」or「%i」are formatted as integers. Those that replace「%f」are formatted as floating-point numbers, and those that replace「%o」are formatted as clickable objects.

void profile([string title])

Start the JavaScript profiler, and display title at the start of its report.

void profileEnd()

Stop the profiler and display its code profiling report.

void time(string name)

Start a timer with the specified name.

void timeEnd(string name)

End the timer with the specified name, and display the name and the time elapsed since the corresponding call to time()

void trace()

Display a stack trace.

void warn(any message...)

Like console.log(), but mark the output as a warning.

Name

ConsoleCommandLine — global utilities for the console window

Synopsis

Most web browsers support a JavaScript console (which may be known by a name like「Developer Tools」or「Web Inspector」) that allows you to enter individual lines of JavaScript code. In addition to the normal global variables and functions of client-side JavaScript, the console command line typically supports the useful properties and functions described here. See also the Console API.

Properties

readonly Element $0

The document element most recently selected via some other feature of the debugger.

readonly Element $1

The document element selected before $0.

Methods

void cd(Window frame)

When a document includes nested frames, the cd() function allows you to switch global objects and execute subsequent commands in the scope of the specified frame.

void clear()

Clear the console window.

void dir(object o)

Display the properties or elements of o. Like Console.dir().

void dirxml(Element elt)

Display an XML or HTML-based representation of elt. Like Console.dirxml().

Element $(string id)

A shortcut for document.getElementById().

NodeList $$(string selector)

Return an array-like object of all elements matching the specified CSS selector. This is a shortcut for document.querySelectorAll(). In some consoles, it returns a true array rather than a NodeList.

void inspect(any object, [string tabname])

Display the object, possibly switching from the console to a different tab of the debugger. The second argument is an optional hint about how you would like the object displayed. Supported values may include「html」,「css」,「script」, and「dom」.

string[] keys(any object)

Returns an array of the property names for object.

void monitorEvents(Element object, [string type])

Log events of the specified type dispatched to object. Values for type include「mouse」,「key」,「text」,「load」,「form」,「drag」, and「contextmenu」. If type is omitted, all events on object are logged.

void profile(string title)

Begin code profiling. See Console.profile().

void profileEnd()

End profiling. See Console.profileEnd().

void unmonitorEvents(Element object, [string type])

Stop monitoring type events on object.

any[] values(any object)

Returns an array of the property values for object.

Name

CSS2Properties — see CSSStyleDeclaration

Name

CSSRule — a rule in a CSS stylesheet

Description

A CSSRule object represents a rule in a CSSStyleSheet: it represents style information to be applied to a specific set of document elements. selectorText is the string representation of the element selector for this rule, and style is a CSSStyleDeclaration object that represents the set of style attributes and values to apply to the selected elements.

The CSS Object Model specification actually defines a hierarchy of CSSRule subtypes to represent different kinds of rules that can appear in a CSS stylesheet. The properties listed here are properties of the generic CSSRule type and of its CSSStyleRule subtype. Style rules are the most common and most important types of rules in a stylesheet, and the ones you are most likely to script.

In IE8 and before, CSSRule objects support only the selectorText and style properties.

Constants

unsigned short STYLE_RULE = 1

unsigned short IMPORT_RULE = 3

unsigned short MEDIA_RULE = 4

unsigned short FONT_FACE_RULE = 5

unsigned short PAGE_RULE = 6

unsigned short NAMESPACE_RULE = 10

These are the possible values of the type property below and they specify what kind of rule it is. If type is anything other than 1, the CSSRule object will have other properties that are not documented here.

Properties

string cssText

The complete text of this CSS rule.

readonly CSSRule parentRule

The rule, if any, within which this rule is contained.

readonly CSSStyleSheet parentStyleSheet

The stylesheet within which this rule is contained.

string selectorText

When type is STYLE_RULE, this property holds the selector text that specifies the document elements this style rule applies to.

readonly CSSStyleDeclaration style

When type is STYLE_RULE, this property specifies the styles that should be applied to elements specified by selectorText. Note that while the style property itself is read-only, the properties of the CSSStyleDeclaration object to which it refers are read/write.

readonly unsigned short type

The type of this rule. The value will be one of the constants defined above.

Name

CSSStyleDeclaration — a set of CSS attributes and their values

Synopsis

A CSSStyleDeclaration object represents a set of CSS style attributes and their values, and it allows those style values to be queried and set using JavaScript property names that are similar to CSS property names. The style property of an HTMLElement is a read/write CSSStyleDeclaration object, as is the style property of a CSSRule object. The return value of Window .getComputedStyle(), however, is a CSSStyleDeclaration object whose properties are read-only.

A CSSStyleDeclaration object makes CSS style attributes available through JavaScript properties. The names of these JavaScript properties correspond closely to the CSS attribute names, with minor changes required to avoid syntax errors in JavaScript. Multiword attributes that contain hyphens, such as「font-family」, are written without hyphens in JavaScript, with each word after the first capitalized: fontFamily. Also, the「float」attribute conflicts with the reserved word float, so it translates to the property cssFloat. Note that you can use unmodified CSS attribute names if you use strings and square brackets to access the properties.

Properties

In addition to the properties described above, a CSSStyleDeclaration has two additional properties:

string cssText

The textual representation of a set of style attributes and their values. The text is formatted as in a CSS stylesheet, minus the element selector and the curly braces that surround the attributes and values.

readonly unsigned long length

The number of attribute/value pairs contained in this CSSStyleDeclaration. A CSSStyleDeclaration object is also an array-like object whose elements are the names of the CSS style attributes that are declared.

Name

CSSStyleSheet — a CSS stylesheet

Synopsis

This interface represents a CSS stylesheet. It has properties and methods for disabling the stylesheet, and for querying, inserting, and removing CSSRule style rules. The CSSStyleSheet objects that apply to a document are members of the styleSheets[] array of the Document object and may also be available through the sheet property of the <style> or <link> element that defines or links to the stylesheet.

In IE8 and before, use the rules[] array instead of cssRules[], and use addRule() and remove Rule() instead of the DOM standard insertRule() and deleteRule().

Properties

readonly CSSRule[] cssRules

A read-only, array-like object holding the CSSRule objects that compose the stylesheet. In IE, use the rules property instead.

boolean disabled

If true, the stylesheet is disabled and is not applied to the document. If false, the stylesheet is enabled and is applied to the document.

readonly string href

The URL of a stylesheet that is linked to the document, or null for inline stylesheets.

readonly string media

A list of media to which this stylesheet applies. You can query and set this property as a single string, or treat it as an array-like object of media types with appendMedium() and deleteMedium() methods. (Formally, the value of this property is a MediaList object, but that type is not covered in this reference.)

readonly Node ownerNode

The document element that「owns」this stylesheet, or null if there isn’t one. See Link and Style.

readonly CSSRule ownerRule

The CSSRule (from a parent stylesheet) that caused this stylesheet to be included, or null if this stylesheet was included in some other way. (Note that the entry for CSSRule in this reference only documents style rules, not @import rules.)

readonly CSSStyleSheet parentStyleSheet

The stylesheet that included this one, or null if this stylesheet was included directly in the document.

readonly string title

The title of the stylesheet, if specified. A title can be specified by the title attribute of a <style> or <link> element that refers to the stylesheet.

readonly string type

The MIME type of this stylesheet. CSS stylesheets have a type of「text/css」.

Methods

void deleteRule(unsigned long index)

This method deletes the rule at the specified index from the cssRules array. In IE8 and before, use the equivalent method removeRule() instead.

unsigned long insertRule(string rule, unsigned long index)

This method inserts (or appends) a new CSS rule (a single string that specifies selector and styles within curly braces) at the specified index of the cssRules array of this stylesheet. In IE8 and before, use addRule() instead, and pass the selector string and the styles string (without curly braces) as two separate arguments, passing the index as the third argument.

Name

DataTransfer — a transfer of data via drag-and-drop

Synopsis

When the user performs a drag-and-drop operation, a sequence of events is fired on the drag source or the drop target (or both, if they are both in a browser window). These events are accompanied by an event object whose dataTransfer property (see Event) refers to a DataTransfer object. The DataTransfer object is the central object for any drag-and-drop operation: the drag source stores the data to be transferred in it, and the drop target extracts the transferred data from it. In addition, the DataTransfer object manages a negotiation between the drag source and drop target about whether the drag-and-drop should be a copy, move, or link operation.

The API described here was created by Microsoft for IE, and it has been at least partially implemented by other browsers. HTML5 standardizes the basic IE API. As this book goes to press, HTML5 has defined a new version of the API that defines the items property as an array-like object of DataTransferItem objects. This is an appealing and rational API, but since no browsers yet implement it, it is not documented here. Instead, this page documents the features that (mostly) work in current browsers. See Drag and Drop Events for further discussion of this quirky API.

Properties

string dropEffect

This property specifies the type of data transfer this object represents. It must have one of the values「none」,「copy」,「move」, or「link」. Typically, the drop target will set this property from a dragenter or dragover event. The value of this property may also be affected by the modifier keys that the user holds down while performing the drag, but that is platform-dependent.

string effectAllowed

This property specifies what combination of copy, move, and link transfers are allowed for this drag-and-drop operation. It is typically set by the drag source in response to the dragstart event. Legal values are「none」,「copy」,「copyLink」,「copyMove」,「link」,「linkMove」,「move」, and「all」. (As a mnemonic, note that in the values that specify two operations, the operation names always appear in alphabetical order.)

readonly File[] files

If the data being dragged is one or more files, this property will be set to an array or array-like object of File objects.

readonly string[] types

This is an array-like object of strings that specify the MIME types of the data that has been stored in this DataTransfer object (with setData() if the drag source is within the browser or by some other mechanism if the drag source is outside of the browser). The array-like object that holds the types is supposed to have a contains() method for testing whether a specific string is present. Some browsers just make this a true array, however, and in that case, you can use the indexOf() method instead.

Methods

void addElement(Element element)

This method tells the browser to use element when creating the visual effect that the user sees while dragging. This method is generally called by the drag source, and it may not be implemented or have any effect in all browsers.

void clearData([string format])

Removes any data in the specified format that was previously set with setData().

string getData(string format)

Return the transferred data in the specified format. If format is equal (ignoring case) to「text」, use「text/plain」instead. And if it is equal (ignoring case) to「url」, use「text/uri-list」instead. This method is called by the drop target in response to the drop event at the end of a drag-and-drop operation.

void setData(string format, string data)

Specify the data to be transferred, and the MIME type format of that data. The drag source calls this method in response to a dragstart event at the beginning of a drag-and-drop operation. It cannot be called from any other event handler. If the drag source can make its data available in more than one format, it can call this method multiple times to register values for each supported format.

void setDragImage(Element image, long x, long y)

This method specifies an image (typically an <img> element) that should be displayed to the user as a visual representation of the value being dragged. The x and y coordinates give mouse pointer offsets within the image. This method can only be called by the drag source in response to the dragstart event.

Name

DataView — read and write values from an ArrayBuffer

Inherits from

ArrayBufferView

Synopsis

A DataView is an ArrayBufferView that wraps an ArrayBuffer (or a region of an array buffer) and defines methods for reading and writing 1-, 2-, and 4-byte signed and unsigned integers and 4- and 8-byte floating-point numbers from or into the buffer. The methods support both big-endian and little-endian byte orders. See also TypedArray.

Constructor

new DataView(ArrayBuffer buffer, [unsigned long byteOffset], [unsigned long byteLength])

This constructor creates a new DataView object that allows read and write access to the bytes in buffer or a region of buffer. With one argument, it creates a view of the entire buffer. With two arguments, it creates a view that extends from byte number byteOffset to the end of the buffer. And with three arguments, it creates a view of the byteLength bytes starting at byteOffset.

Methods

Each of these method reads a numeric value from, or writes a numeric value into, the underlying ArrayBuffer. The method name specifies the type that is read or written. All methods that read or write more than one byte accept an optional final littleEndian argument. If this argument is omitted, or is false, big-endian byte ordering is used, with the most significant bytes being read or written first. If the argument is true, however, little-endian byte ordering is used.

float getFloat32(unsigned long byteOffset, [boolean littleEndian])

Interpret the 4 bytes starting at byteOffset as a floating-point number and return that number.

double getFloat64(unsigned long byteOffset, [boolean littleEndian])

Interpret the 8 bytes starting at byteOffset as a floating-point number and return that number.

short getInt16(unsigned long byteOffset, [boolean littleEndian])

Interpret the 2 bytes starting at byteOffset as a signed integer number and return that number.

long getInt32(unsigned long byteOffset, [boolean littleEndian])

Interpret the 4 bytes starting at byteOffset as a signed integer number and return that number.

byte getInt8(unsigned long byteOffset)

Interpret the byte at byteOffset as a signed integer number and return that number.

unsigned short getUint16(unsigned long byteOffset, [boolean littleEndian])

Interpret the 2 bytes starting at byteOffset as an unsigned integer number and return that number.

unsigned long getUint32(unsigned long byteOffset, [boolean littleEndian])

Interpret the 4 bytes starting at byteOffset as an unsigned integer number and return that number.

unsigned byte getUint8(unsigned long byteOffset)

Interpret the byte at byteOffset as an unsigned integer number and return that number.

void setFloat32(unsigned long byteOffset, float value, [boolean littleEndian])

Convert value to a 4-byte floating-point representation and write those bytes at byteOffset.

void setFloat64(unsigned long byteOffset, double value, [boolean littleEndian])

Convert value to an 8-byte floating-point representation and write those bytes at byteOffset.

void setInt16(unsigned long byteOffset, short value, [boolean littleEndian])

Convert value to a 2-byte integer representation and write those bytes at byteOffset.

void setInt32(unsigned long byteOffset, long value, [boolean littleEndian])

Convert value to a 4-byte integer representation and write those bytes at byteOffset.

void setInt8(unsigned long byteOffset, byte value)

Convert value to a 1-byte integer representation and write that byte at byteOffset.

void setUint16(unsigned long byteOffset,unsigned short value,[boolean little Endian])

Convert value to a 2-byte unsigned integer representation and write those bytes at byteOffset.

void setUint32(unsigned long byteOffset, unsigned long value, [boolean littleEndian])

Convert value to a 4-byte unsigned integer representation and write those bytes at byteOffset.

void setUint8(unsigned long byteOffset, octet value)

Convert value to a 1-byte unsigned integer representation and write that byte at byteOffset.

Name

Document — an HTML or XML document

Inherits from

Node

Synopsis

A Document object is a Node that serves as the root of a document tree. The document Element property is the root Element of the document. A Document node may have other children (such as Comment and DocumentType nodes), but it has only one Element child that holds all the content of the document.

