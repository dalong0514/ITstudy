string acceptCharset

A list of one or more allowed character sets in which the form data may be encoded for submission.

string action

The URL to which the form should be submitted.

string autocomplete

The string「on」or「off」. If「on」, the browser can prefill form controls with saved values from a previous visit to the page.

readonly HTMLFormControlsCollection elements

An array-like object of form controls contained by this form.

string enctype

Specifies the way the values of the form controls are encoded for submission. The legal values of this property are:

「application/x-www-form-urlencoded」(the default)

「multipart/form-data」

「text/plain」

readonly long length

The number of form controls represented by the elements property. Form elements behave as if they themselves were array-like objects of form controls, and for a form f and an integer n, the expression f[n] is the same as f.elements[n].

string method

The HTTP method used to submit the form to the action URL. Either「get」or「post」.

string name

The name of the form, as specified by the HTML name attribute. You can use the value of this property as a property name on the document object. The value of that document property will be this Form object.

boolean noValidate

true if the form is not to be validated before submission. Mirrors the HTML novalidate attribute.

string target

The name of a window or frame in which the document returned by form submission is to be displayed.

Methods

boolean checkValidity()

In browsers that support form validation, this method checks the validity of each form control. It returns true if they are all valid. If any controls are not valid, it fires an invalid event on that control and then returns false.

void dispatchFormChange()

This method triggers a formchange event on each control in this form. The form usually does this automatically when user input triggers a change event, so you do not normally need to call this method.

void dispatchFormInput()

This method triggers a forminput event on each control in this form. The form usually does this automatically when user input triggers an input event, so you do not normally need to call this method.

void reset()

Reset all form elements to their default values.

void submit()

Submit the form manually, without triggering an submit event.

Event Handlers

These form-related event handler properties are defined on Element, but they are documented in more detail here because they are triggered on Form elements.

onreset

Invoked just before the elements of the form are reset. Return false or cancel the event to prevent the reset.

onsubmit

Invoked just before the form is submitted. Return false or cancel the event to prevent the submission.

Name

FormControl — common features of all form controls

Synopsis

Most HTML form controls are <input> elements, but forms can also contain <button>, <select>, and <textarea> controls. This page documents the features that those element types have in common. See HTML Forms for an introduction to HTML forms, and see Form, Input , Select, and TextArea for more on forms and form controls.

The <fieldset> and <output> elements implement most, but not all, of the properties described here. This reference treats FieldSet and Output objects as FormControls even though they do not implement every property.

This page documents certain HTML5 form features (particularly form validation) which, at the time of this writing, were not yet widely implemented.

Properties

boolean autofocus

true if the control should automatically receive keyboard focus as soon as the document is loaded. (FieldSet and Output controls do not implement this property.)

boolean disabled

true if the form control is disabled. Disabled controls do not respond to user input and are not subject to form validation. (Output elements do not implement this property; FieldSet elements use it to disable all of the controls they contain.)

readonly Form form

A reference to the Form that is the owner of this control, or null if it does not have one. If a control is contained within a <form> element, that is its form owner. Otherwise, if the control has an HTML form attribute that specifies the ID of a <form>, that named form is the form owner.

readonly NodeList labels

An array-like object of Label elements associated with this control. (FieldSet controls do not implement this property.)

string name

The value of the HTML name attribute for this control. A control’s name can be used as a property of the Form element: the value of that property is the control element. Control names are also used when submitting a form.

string type

For <input> elements, the type property has the value of the type attribute, or the value「text」if no type attribute is specified on the <input> tag. For <button>, <select>, and textarea elements, the type property is「button」,「select-one」(or「select-multiple」, if the multiple attribute is set), and「textarea」. For <fieldset> elements, the type is「fieldset」, and for <output> elements the type is「output」.

readonly string validationMessage

If the control is valid or is not subject to validation, this property will be the empty string. Otherwise, this property contains a localized string that explains why the user’s input is invalid.

readonly FormValidity validity

This property refers to an object that specifies whether the user’s input for this control is valid, and if not, why not.

string value

Every form control has a string value that is used when the form is submitted. For text input controls, the value is the user’s input. For buttons, the value is just the value of the HTML value attribute. For output elements, this property is like the textContent property inherited from Node. FieldSet elements do not implement this property.

readonly boolean willValidate

This property is true if the control takes part in form validation, and false otherwise.

Event Handlers

Form controls define the following event handler properties. You can also register event handlers using the EventTarget methods implemented by all Elements:

Event HandlerInvoked when

onformchange When a change event is fired on any control in the form, the form broadcasts a nonbubbling formchange event to all of its controls. Controls can use this handler property to detect changes to their sibling controls.

onforminput When an input event is fired on any control in the form, the form broadcasts a nonbubbling forminput event to all of its controls. Controls can use this handler property to detect changes to their sibling controls.

oninvalid If a form control does not validate, an invalid event will be fired on it. This event does not bubble, but if canceled, the browser will not display an error message for the control.

Methods

boolean checkValidity()

Returns true if the control is valid (or if it is not subject to validation). Otherwise, it fires an invalid event at the control and returns false.

void setCustomValidity(string error)

If error is a nonempty string, this method marks the control as invalid and uses error as a localized message when reporting the element’s invalidity to the user. If error is the empty string, any previous error string is removed and the control is considered valid.

Name

FormData — an HTTP multipart/form-data request body

Synopsis

The FormData type is a feature of XMLHttpRequest Level 2 (XHR2) that makes it easy to perform HTTP PUT requests with multipart/form-data encoding using an XMLHttpRequest. Multipart encoding is necessary, for example, if you want to upload multiple File objects in a single request.

Create a FormData object with the constructor, and then add name/value pairs to it with the append() method. Once you have added all of the parts of your request body, you can pass the FormData to the send() method of an XMLHttpRequest.

Constructor

new FormData()

This no-argument constructor returns an empty FormData object.

Methods

void append(string name, any value)

This method adds a new part, with the specified name and value, to the FormData. The value argument can be a string or a Blob (recall that File objects are Blobs).

Name

FormValidity — the validity of a form control

Synopsis

The validity property of a FormControl refers to a FormValidity object that is a live representation of the validity state of that control. If the valid property is false, the control is not valid, and at least one of the other properties will be true to indicate the nature of the validity error (or errors).

Form validation is an HTML5 feature that, at the time of this writing, is not yet widely implemented.

Properties

readonly boolean customError

A script called FormControl.setCustomValidity() on this element.

readonly boolean patternMismatch

The input does not match the pattern regular expression.

readonly boolean rangeOverflow

The input is too large.

readonly boolean rangeUnderflow

The input is too small.

readonly boolean stepMismatch

The input does not match the specified step.

readonly boolean tooLong

The input is too long.

readonly boolean typeMismatch

The input is of the wrong type.

readonly boolean valid

If this property is true, the form control is valid, and all the other properties are false. If this property is false, the form control is not valid, and at least one of the other properties is true.

readonly boolean valueMissing

The form element was required, but no value was entered.

Name

Geocoordinates — a geographical position

Synopsis

An object of this type represents a position on the surface of the earth.

Properties

readonly double accuracy

The accuracy of the latitude and longitude values, in meters.

readonly double altitude

The altitude, in meters above sea level, or null if altitude is not available.

readonly double altitudeAccuracy

The accuracy, in meters, of the altitude property. If altitude is null, altitude Accuracy will also be null.

readonly double heading

The user’s direction of travel, in degrees clockwise from true north, or null if the heading is not available. If heading information is available, but speed is 0, heading will be NaN.

readonly double latitude

The user’s latitude in decimal degrees north of the equator.

readonly double longitude

The user’s longitude in decimal degrees east of the Greenwich Meridian.

readonly double speed

The user’s speed in meters per second, or null if speed information is not available. This property will never be a negative number. See also heading.

Name

Geolocation — obtain the user’s latitude and longitude

Synopsis

The Geolocation object defines methods for determining the user’s precise geographical location. In browsers that support it, the Geolocation object is available through the Navigator object as navigator.geolocation. The methods described here depend on a few other types: locations are reported in the form of a Geoposition object and errors are reported as GeolocationError objects.

Methods

void clearWatch(long watchId)

Stops watching the user’s location. The watchId argument must be the value returned by the corresponding call to watchPosition().

void getCurrentPosition(function success, [function error], [object options])

Asynchronously determines the user’s location using any options (see the list of option properties below) that were specified. This method returns immediately, and when the user’s location becomes available, it passes a Geoposition object to the specified success callback. Or, if an error occurs (perhaps because the user did not grant permission to share her location), it passes a GeolocationError object to the error callback if one was specified.

long watchPosition(function success, [function error], [object options])

This method is like getCurrentPosition(), but after determining the user’s current location, it continues to monitor the user’s location and invokes success callback every time the position is found to have changed significantly. The return value is a number that you can pass to clearWatch() to stop tracking the user’s location.

Options

The options argument to getCurrentPosition() and watchPosition() is a regular JavaScript object with zero or more of the following properties:

boolean enableHighAccuracy

This option is a hint that a high-accuracy position is desired, even if it would take longer to determine or would use more battery power, for example. The default is false. In devices that can determine position via WiFi signals or by GPS, setting this option to true will typically mean「use the GPS」.

long maximumAge

This option specifies the largest acceptable age (in milliseconds) of the first Geoposition object passed to the successCallback. The default is 0, which means that each call to getCurrentPosition() or watchPosition() will have to request a new position fix. If you set this option to 60000, for example, the implementation is allowed to return any Geoposition determined in the last minute.

long timeout

This option specifies how long, in milliseconds, the requester is willing to wait for a position fix. The default value is Infinity. If more than timeout milliseconds elapse, the errorCallback will be invoked. Note that time spent asking the user for permission to share her location does not count against this timeout value.

Name

GeolocationError — an error while querying the user’s location

Synopsis

If an attempt to determine the user’s geographical position fails, your error callback function will be invoked with a GeolocationError object that describes what went wrong.

Constants

These constants are the possible values of the code property:

unsigned short PERMISSION_DENIED = 1

The user did not grant permission to share her or his location.

unsigned short POSITION_UNAVAILABLE = 2

The location could not be determined for an unspecified reason. This could be caused by a network error, for example.

unsigned short TIMEOUT = 3

The location could not be determined within the time allotted (see the timeout option described in Geolocation).

Properties

readonly unsigned short code

This property will have one of the three values above.

readonly string message

A message that provides more details about the error. The message is intended to aid with debugging and is not suitable for display to end users.

Name

Geoposition — a timestamped position report

Synopsis

A Geoposition object represents the user’s geographical position at a specific time. Objects of this type have only two properties: a timestamp and a reference to a Geocoordinates object that holds the actual position properties.

Properties

readonly Geocoordinates coords

This property refers to a Geocoordinates object whose properties specify the user’s latitude, longitude, etc.

readonly unsigned long timestamp

The time at which those coordinates were valid, in milliseconds since the epoch. You can use this value to create a Date object if desired.

Name

HashChangeEvent — event object for hashchange events

Inherits from

Event

Synopsis

Browsers fire a hashchange event when the fragment identifier (the portion of a URL beginning with the hash mark #) of the document URL changes. This can happen because of a scripted change to the hash property of the Location object, or because the user used the browser’s Back or Forward buttons to navigate through the browser’s history. In either case, a hashchange event is triggered. The associated event object is a HashChangeEvent. See History Management for more on history management with location.hash and the hashchange event.

Properties

readonly string newURL

This property holds the new value of location.href. Note that this is the complete URL, not just the hash portion of it.

readonly string oldURL

This property holds the old value of location.href.

Name

History — the browsing history of a Window

Synopsis

The History object represents the browsing history of a window. For privacy reasons, however, it does not allow scripted access to the actual URLs that have been visited. The methods of the History object allow scripts to move the window backward and forward through the browsing history and to add new entries to the browsing history.

Properties

readonly long length

This property specifies the number of entries in the browser’s history list. Since there is no way to determine the index of the currently displayed document within this list, knowing the size of this list is not particularly helpful.

Methods

void back()

back() causes the window or frame to which the History object belongs to revisit the URL (if any) that was visited immediately before the current one. Calling this method has the same effect as clicking on the browser’s Back button. It is also equivalent to:

history.go(-1);

void forward()

forward() causes the window or frame to which the History object belongs to revisit the URL (if any) that was visited immediately after the current one. Calling this method has the same effect as clicking on the browser’s Forward button. It is also equivalent to:

history.go(1);

void go([long delta])

The History.go() method takes an integer argument and causes the browser to visit the URL that is the specified number of positions away in the browsing history list maintained by the History object. Positive arguments move the browser forward through the list, and negative arguments move it backward. Thus, calling history.go(-1) is equivalent to calling history. back() and produces the same effect as clicking on the Back button. With an argument of 0 or no argument at all, this method reloads the currently displayed document.

void pushState(any data, string title, [string url])

This method adds a new entry to the window’s browsing history, storing a structured clone (see Structured Clones) of data as well as the specified title and url. If the user later uses the browser’s history navigation mechanism to return to this saved state, a popstate event will be triggered on the window, and the PopStateEvent object will hold another clone of data in its state property.

The title argument provides a name for this state, and browsers may display it in their history UI. (At the time of this writing, browsers ignore this argument). If specified, the url argument is displayed in the location bar and gives this state a permanent state that can be bookmarked or shared with others. url is resolved relative to the current document location. If url is an absolute URL, it must have the same origin as the current document. One common technique is to use URLs that are just fragment identifiers beginning with #.

void replaceState(any data, string title, [string url])

This method is like pushState(), except that instead of creating a new entry in the window’s browsing history, it updates the current entry with a new state data, title, and url.

Name

HTMLCollection — an element collection accessible by name or number

Synopsis

An HTMLCollection is a read-only array-like object of Element objects that also defines properties corresponding to the name and id values of the collected elements. The Document object defines HTMLCollection properties such as forms and image.

HTMLCollection objects define item() and namedItem() methods, for retrieving elements by position or name, but it is never necessary to use them: you can simply treat the HTMLCollection as a JavaScript object and access its properties and array elements. For example:

document.images[0] // A numbered element of an HTMLCollection document.forms.address // A named element of an HTMLCollection

Properties

readonly unsigned long length

The number of elements in the collection.

Methods

Element item(unsigned long index)

Returns the element at the specified index in the collection or null if index is out of bounds. You can also simply specify the position within array brackets instead of calling this method explicitly.

object namedItem(string name)

Returns the first element from the collection that has the specified name for its id or name attribute, or null if there is no such element. You can also place the element name within array brackets instead of calling this method explicitly.

Name

HTMLDocument — see Document

Name

HTMLElement — see Element

Name

HTMLFormControlsCollection — a array-like object of form controls

Inherits from

HTMLCollection

Synopsis

HTMLFormControlsCollection is a specialized HTMLCollection used by Form elements to represent collections of form controls. Like HTMLCollection, you can index it numerically, like an array, or treat it like an object and index it with the names or IDs of form controls. HTML forms often have multiple controls (usually radio buttons or checkboxes) that have the same value for their name attribute, and an HTMLFormControlsCollection handles this differently than an ordinary HTMLCollection would.

When you read a property of an HTMLFormControlsCollection, and the form contains more than one element that has that property as its name, the HTMLFormControlsCollection returns an array-like object of all form controls that share the name. In addition, the returned array-like object has a value property that returns the value attribute of the first checked radio button with that name. You can even set this value property to check the radio button with the corresponding value.

Name

HTMLOptionsCollection — a collection of Option elements

Inherits from

HTMLCollection

Synopsis

HTMLOptionsCollection is a specialized HTMLCollection that represents the Option elements within a Select element. It overrides the namedItem() method to handle multiple Option elements with the same name, and it defines methods for adding and removing elements. For historical reasons, HTMLOptionsCollection defines a writable length property that you can set to truncate or extend the collection.

Properties

unsigned long length

This property returns the number of elements in the collection. Unlike the length property of a regular HTMLCollection, however, this one is not read-only. If you set it to a value smaller than its current value, the collection of Option elements is truncated, and those that are no longer in the collection are removed from the containing Select element. If you set length to a value larger than its current value, empty <option/> elements are created and added to the Select element and to the collection.

long selectedIndex

The index of the first selected Option in the collection, or -1 if no Option is selected. You can set this property to change the selected item.

Methods

void add(Element option, [any before])

Insert the option (which must be an <option> or <optgroup> element) into this collection (and into the Select element) at the position specified by before. If before is null, insert it at the end. If before is an integer index, insert it before the item that is currently at that index. If before is another Element, insert the option before that element.

Element item(unsigned long index)

HTMLOptionsCollection inherits this method from HTMLCollection. It returns the element at the specified index or null if index is out of bounds. You can also index the collection directly with square brackets instead of calling this method explicitly.

object namedItem(string name)

This method returns all Option elements in the collection that have the specified name or ID. If no elements match, it returns null. If one Option element matches, it returns that element. If more than one element matches, it returns a NodeList of those elements. Note that you can index an HTMLOptionsCollection directly, using name as a property name instead of calling this method explicitly.

void remove(long index)

This method removes the <option> element at the specified index in the collection. If invoked with no argument or with an argument that is out of bounds, it may remove the first element in the collection.

Name

IFrame — an HTML <iframe>

Inherits from

Node, Element

Synopsis

An IFrame object represents an <iframe> element in an HTML document. If you look up an <iframe> using getElementById() or a similar query function, you’ll get an IFrame object. If, however, you access the <iframe> through the frames property of the Window object, or by using the name of the <iframe> as a property of the containing window, the object you obtain is the Window object that the <iframe> represents.

Properties

readonly Document contentDocument

The document contained in this <iframe> element. If the document displayed in the <iframe> is from a different origin, the same-origin policy (The Same-Origin Policy) will prevent access to this document.

readonly Window contentWindow

The Window object of the <iframe>. (The frameElement of that Window object will be a reference back to this IFrame object.)

string height

The height, in CSS pixels, of the <iframe>. This property mirrors the HTML height attribute.

string name

The name of the <iframe>. This property mirrors the HTML name attribute, and its value can be used as the target of Link and Form objects.

readonly DOMSettableTokenList sandbox

This property mirrors the HTML5 sandbox attribute and allows it to be queried and set as a string or as a set of individual tokens.

The sandbox attribute specifies that the browser should impose additional security restrictions on untrusted content displayed in an <iframe>. If the sandbox attribute is present but empty, the <iframe> content will be treated as if it was from a distinct origin, will not be allowed to run scripts, will not be allowed to display forms, and will not be allowed to change the location of its containing window. The sandbox attribute can also be set to a space-separated list of tokens, each of which lifts one of those additional security restrictions. The valid tokens are「allow-same-origin」,「allow-scripts」,「allow-forms」, and「allow-top-navigation」.

The sandbox attribute is not yet widely implemented at the time of this writing. See an HTML reference for further details.

boolean seamless

This property mirrors the HTML seamless attribute. If true, the browser should render the content of the <iframe> so that it appears to be part of the containing document. This means, in part, that the browser must apply the CSS styles of the containing document to the content of the <iframe>.

The seamless attribute was introduced as part of HTML5 and is not yet widely implemented at the time of this writing.

string src

This property mirrors the src attribute of the <iframe>: it specifies the URL of the framed content.

string srcdoc

This property mirrors the srcdoc HTML attribute and specifies the content of the <iframe> as a string. The srcdoc attribute was recently introduced as part of HTML5 and is not yet implemented at the time of this writing.

string width

The width, in CSS pixels, of the <iframe>. This property mirrors the HTML width attribute.

Name

Image — an <img> in an HTML document

Inherits from

Node, Element

Synopsis

An Image object represents an image embedded in an HTML document with an <img> tag. The images that appear in a document are collected in the document.images[] array.

The src property of the Image object is the most interesting one. When you set this property, the browser loads and displays the image specified by the new value. This allows visual effects such as image rollovers and animations. See Scripting Images for examples.

You can create offscreen Image objects by simply creating new <img> elements with document .createElement() or with the Image() constructor. Note that this constructor does not have an argument to specify the image to be loaded: to load an image, simply set the src property of your Image object. To actually display the image, insert the Image object into the document.

Constructor

new Image([unsigned long width, unsigned long height])

You can create a new Image as you would create any HTML element with document. create Element(). For historical reasons, however, client-side JavaScript also defines the Image() constructor to do the same thing. If the width or height arguments are specified, they set the width and height attributes of the <img> tag.

Properties

In addition to the properties listed here, Image elements also expose the following HTML attributes as JavaScript properties: alt, usemap, ismap.

readonly boolean complete

true if no image src was specified or if the image has been completely downloaded. false otherwise.

unsigned long height

The on-screen height at which the image is displayed, in CSS pixels. Set this to change the height of the image.

readonly unsigned long naturalHeight

The intrinsic height of the image.

readonly unsigned long naturalWidth

The intrinsic width of the image.

string src

The URL of the image. Setting this property causes the specified image to load. If the Image object has been inserted into the document, the new image will be displayed.

unsigned long width

The width, in CSS pixels, at which the image is actually displayed on the screen. You can set this to change the on-screen size of the image.

Name

ImageData — an array of pixel data from a <canvas>

Synopsis

An ImageData object holds the red, green, blue, and alpha (transparency) components of a rectangular region of pixels. Obtain an ImageData object with the createImageData() or getImageData() methods of the CanvasRenderingContext2D object of a <canvas> tag.

The width and height properties specify the dimensions of the rectangle of pixels. The data property is an array that holds the pixel data. Pixels appear in the data[] array in left-to-right and top-to-bottom order. Each pixel consists of four byte values that represent the R, G, B, and A components, in that order. Thus, the color components for a pixel at (x,y) within an ImageData object image can be accessed like this:

var offset = (x + y*image.width) * 4; var red = image.data[offset]; var green = image.data[offset+1]; var blue = image.data[offset+2]; var alpha = image.data[offset+3];

The data[] array is not a true JavaScript array, but an optimized array-like object whose elements are integers between 0 and 255. The elements are read/write, but the length of the array is fixed. For any ImageData object i, i.data.length will always equal i.width * i.height * 4.

Properties

readonly byte[] data

A read-only reference to a read/write array-like object whose elements are bytes.

readonly unsigned long height

The number of rows of image data.

readonly unsigned long width

The number of pixels per row of data.

Name

Input — an HTML <input> element

Inherits from

Node, Element, FormControl

Synopsis

An Input object represents an HTML form <input> element. Its appearance and behavior depends on its type attribute: an Input element might represent a simple text input field, a checkbox, a radio box, a button, or a file selection element, for example. Because an <input> element can represent so many kinds of form controls, the Input element is one of the most complicated. See HTML Forms for an overview of HTML forms and form elements. Note that some of the important properties of the Input element (such as type, value, name, and form) are documented in FormControl.

Properties

In addition to the properties listed here, Input elements also implement all of the properties defined by Element and FormControl. The properties marked with an asterisk in this list are newly defined by HTML5 and are not yet, at the time of this writing, widely implemented.

string accept

When type is「file」, this property is a comma-separated list of MIME types that specify the types of files that may be selected. The strings「audio/*」,「video/*」, and「image/*」are also legal. Mirrors the accept attribute.

string autocomplete

True if the browser can prefill this Input element with a value from a previous session. Mirrors that autocomplete attribute. See also the autocomplete property of Form.

boolean checked

For checkable input elements, this property specifies whether the element is「checked」or not. Setting this property changes the visual appearance of the input element.

boolean defaultChecked

For checkable input elements, this property specifies the initial checkedness of the element. When the form is reset, the checked property is restored to the value of this property. Mirrors the checked attribute.

string defaultValue

For elements with a textual value, this property holds the initial value displayed by the element. When the form is reset, the element is restored to this value. Mirrors the value attribute.

readonly File[] files

For elements whose type is「file」, this property is an array-like object of the File object or objects that the user selected.

string formAction*

For submit button elements, this property specifies a value that overrides the action property of the containing form. Mirrors the formaction attribute.

string formEnctype*

For submit button elements, this property specifies a value that overrides the enctype property of the containing form. Mirrors the formenctype attribute.

string formMethod*

For submit button elements, this property specifies a value that overrides the method property of the containing form. Mirrors the formmethod attribute.

boolean formNoValidate*

For submit button elements, this property specifies a value that overrides the no Validate property of the containing form. Mirrors the formnovalidate attribute.

string formTarget*

For submit button elements, this property specifies a value that overrides the target property of the containing form. Mirrors the formtarget attribute.

boolean indeterminate

For checkboxes, this property specifies whether the element is in an indeterminate (neither checked nor unchecked) state. This property does not mirror an HTML attribute: you can only set it with JavaScript.

readonly Element list*

A <datalist> element that contains <option> elements that a browser can use as suggestions or autocompletion values.

string max*

A maximum valid value for this Input element.

long maxLength

If type is「text」or「password」, this property specifies the maximum number of characters that the user is allowed to enter. Note that this is not the same as the size property. Mirrors the maxlength attribute.

string min*

A maximum valid value for this Input element.

boolean multiple*

true if the input element should accept more than one value of the specified type. Mirrors the multiple attribute.

string pattern*

The text of a regular expression that the input must match in order to be considered valid. This property uses JavaScript regular expression syntax (without the leading and trailing slashes), but note that the property is a string, not a RegExp object. Also note that in order be considered valid, the entire string of input must match the pattern, not just a substring. (This is as if the pattern begins with ^ and ends with $.) This property mirrors the pattern attribute.

string placeholder

A short string of text that will appear within the Input element as a prompt to the user. When the user focuses the element, the placeholder text will vanish and an insertion cursor will appear. This property mirrors the placeholder attribute.

boolean readOnly

If true, this Input element is not editable. Mirrors the readonly attribute.

boolean required*

If true, the containing form will not be considered valid if the user does not enter a value in this Input element. Mirrors the required attribute.

readonly Option selectedOption*

If the list property is defined and multiple is false, this property returns the selected Option element child of the list, if there is one.

unsigned long selectionEnd

Returns or sets the index of the first input character after the selected text. See also setSelectionRange().

unsigned long selectionStart

Returns or sets the index of the first selected character in the <textarea>. See also setSelectionRange().

unsigned long size

For Input elements that allow text input, this property specifies the width of the element in characters. Mirrors the size attribute. Contrast with maxLength.

string step*

For numeric input types (including date and time input), this property specifies the granularity or step size of the allowed input values. This property can be the string「any」or a floating-point number. Mirrors the step attribute.

Date valueAsDate*

Returns the element’s value (see FormControl) as a Date object.

double valueAsNumber*

Returns the element’s value (see FormControl) as a number.

Methods

In addition to the methods listed here, Input elements also implement all of the methods defined by Element and FormControl. The methods marked with an asterisk in this list are newly defined by HTML5 and are not yet, at the time of this writing, widely implemented.

void select()

This method selects all the text displayed by this Input element. In most browsers, this means that the text is highlighted and that new text entered by the user replaces the highlighted text instead of being appended to it.

void setSelectionRange(unsigned long start, unsigned long end)

This method selects text displayed in this Input element, starting with the character at position start and continuing up to (but not including) the character at end.

void stepDown([long n])*

For elements that support the step property, decrease the current value by n steps.

void stepUp([long n])*

For elements that support the step property, increase the current value by n steps.

Name

jQuery — the jQuery library

Availability

jQuery 1.4

