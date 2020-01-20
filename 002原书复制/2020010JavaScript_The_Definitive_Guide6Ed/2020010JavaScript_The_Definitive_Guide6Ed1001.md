In the days before JavaScript, a form was submitted with a special-purpose Submit button, and form elements had their values reset with a special-purpose Reset button. The JavaScript Form object supports two methods, submit() and reset(), that serve the same purpose. Invoking the submit() method of a Form submits the form, and invoking reset() resets the form elements.

All (or most) form elements have the following properties in common. Some elements have other special-purpose properties that are described later when various types of form elements are considered individually:

type

A read-only string that identifies the type of the form element. For form elements that are defined by an <input> tag, this is simply the value of the type attribute. Other form elements (such as <textarea> and <select>) define a type property so that they can easily be identified by the same test that distinguishes between <input> elements. The second column of Table 15-1 lists the value of this property for each form element.

form

A read-only reference to the Form object in which the element is contained, or null if the element is not contained within a <form> element.

name

A read-only string specified by the HTML name attribute.

value

A read/write string that specifies the「value」contained or represented by the form element. This is the string that is sent to the web server when the form is submitted, and it is only sometimes of interest to JavaScript programs. For Text and Textarea elements, this property contains the text that the user entered. For button elements created with an <input> tag (but not those created with a <button> tag) this property specifies the text displayed within the button. For radio and checkbox elements, however, the value property is not edited or displayed to the user in any way. It is simply a string set by the HTML value attribute. It is intended for use in form submission, but it can also be a useful way to associate extra data with a form element. The value property is discussed further in the sections on the different categories of form elements, later in this chapter.

Form and Element Event Handlers

Each Form element has an onsubmit event handler to detect form submission and an onreset event handler to detect form resets. The onsubmit handler is invoked just before the form is submitted; it can cancel the submission by returning false. This provides an opportunity for a JavaScript program to check the user’s input for errors in order to avoid submitting incomplete or invalid data over the network to a server-side program. Note that the onsubmit handler is triggered only by a genuine click on a Submit button. Calling the submit() method of a form does not trigger the onsubmit handler.

The onreset event handler is similar to the onsubmit handler. It is invoked just before the form is reset, and it can prevent the form elements from being reset by returning false. Reset buttons are rarely necessary in forms, but if you have one, you might want to make the user confirm the reset:

<form... onreset="return confirm('Really erase ALL input and start over?')"> ... <button type="reset">Clear and Start Over</button> </form>

Like the onsubmit handler, onreset is triggered only by a genuine Reset button. Calling the reset() method of a form does not trigger onreset.

Form elements typically fire a click or change event when the user interacts with them, and you can handle these events by defining an onclick or onchange event handler. The third column of Table 15-1 specifies the primary event handler for each form element. In general, form elements that are buttons fire a click event when activated (even when this activation happens through the keyboard rather than via an actual mouse click). Other form elements fire a change event when the user changes the value represented by the element. This happens when the user enters text in a text field or selects an option from a drop-down list. Note that this event is not fired every time the user types a key in a text field. It is fired only when the user changes the value of an element and then moves the input focus to some other form element. That is, the invocation of this event handler indicates a completed change. Radio buttons and checkboxes are buttons that have a state, and they fire both click and change events; the change event is the more useful of the two.

Form elements also fire a focus event when they receive keyboard focus and a blur event when they lose it.

An important thing to know about event handlers is that within the code of an event handler, the this keyword refers to the document element that triggered the event (we’ll talk about this again in Chapter 17). Since elements within a <form> element have a form property that refers to the containing form, the event handlers of these elements can always refer to the Form object as this.form. Going a step further, this means that an event handler for one form element can refer to a sibling form element named x as this.form.x.

Push Buttons

Buttons are one the most commonly used form elements because they provide a clear visual way to allow the user to trigger some scripted action. A button element has no default behavior of its own, and it is never useful unless it has an onclick event handler. Buttons defined as <input> elements display the plain text of the value attribute. Buttons defined as <button> elements display whatever the element content.

Note that hyperlinks provide the same onclick event handler that buttons do. Use a link when the action to be triggered by the onclick handler can be conceptualized as「following a link」; otherwise, use a button.

Submit and reset elements are just like button elements, but they have default actions (submitting and resetting a form) associated with them. If the onclick event handler returns false, the default action of these buttons is not performed. You can use the onclick handler of a submit element to perform form validation, but it is more common to do this with the onsubmit handler of the Form object itself.

Part IV does not include a Button entry. See Input for details on all form element push buttons, including those created with the <button> element.

Toggle Buttons

The checkbox and radio elements are toggle buttons, or buttons that have two visually distinct states: they can be checked or unchecked. The user can change the state of a toggle button by clicking on it. Radio elements are designed to be used in groups of related elements, all of which have the same value for the HTML name attribute. Radio elements created in this way are mutually exclusive: when you check one, the one that was previously checked becomes unchecked. Checkboxes are also often used in groups that share a name attribute, and when you select these elements using the name as a form property you must remember that you get an array-like object rather than a single element.

Radio and checkbox elements both define a checked property. This read/write boolean value specifies whether the element is currently checked. The defaultChecked property is a boolean that has the value of the HTML checked attribute; it specifies whether the element is checked when the page is first loaded.

Radio and checkbox elements do not display any text themselves and are typically displayed with adjacent HTML text (or with an associated <label> element.) This means that setting the value property of a checkbox or radio element does not alter the visual appearance of the element. You can set value, but this changes only the string that is sent to the web server when the form is submitted.

When the user clicks on a toggle button, the radio or checkbox element triggers its onclick handlers. If the toggle button changes state as the result of the click, it also triggers the onchange event handlers. (Note, however, that radio buttons that change state when the user clicks on a different radio button do not fire an onchange handler.)

Text Fields

Text input fields are probably the most commonly used element in HTML forms and JavaScript programs. They allow the user to enter a short, single-line string of text. The value property represents the text the user has entered. You can set this property to specify explicitly the text that should be displayed in the field.

In HTML5, the placeholder attribute specifies a prompt to be displayed within the field before the user enters anything:

Arrival Date: <input type="text" name="arrival" placeholder="yyyy-mm-dd">

A text field’s onchange event handler is triggered when the user enters new text or edits existing text and then indicates that he is finished editing by moving input focus out of the text field.

The Textarea element is like a text input field element, except that it allows the user to input (and your JavaScript programs to display) multiline text. Textarea elements are created with a <textarea> tag using a syntax significantly different from the <input> tag that creates a text field. (See TextArea in Part IV.) Nevertheless, the two types of elements behave quite similarly. You can use the value property and onchange event handler of a Textarea element just as you can for a Text element.

An <input type="password"> element is a modified input field that displays asterisks as the user types into it. As the name indicates, this is useful to allow a user to enter passwords without worrying about others reading over his shoulder. Note that the Password element protects the user’s input from prying eyes, but when the form is submitted, that input is not encrypted in any way (unless it is submitted over a secure HTTPS connection), and it may be visible as it is transmitted over the network.

Finally, an <input type="file"> element allows the user to enter the name of a file to be uploaded to the web server. It is a text field combined with a button that opens a file-chooser dialog box. This file selection element has an onchange event handler, like a regular input field. Unlike an input field, however, the value property of a file selection element is read-only. This prevents malicious JavaScript programs from tricking the user into uploading a file that should not be shared.

The various text input elements define onkeypress, onkeydown, and onkeyup event handlers. You can return false from the onkeypress or onkeydown event handlers to prevent the user’s keystroke from being recorded. This can be useful, for example, if you want to force the user to enter only digits into a particular text input field. See Example 17-6 for a demonstration of this technique.

Select and Option Elements

The Select element represents a set of options (represented by Option elements) from which the user can select. Browsers typically render Select elements in drop-down menus, but if you specify a size attribute with a value greater than 1, they will display the options in a (possibly scrollable) list instead. The Select element can operate in two very distinct ways, and the value of the type property depends on how it is configured. If the <select> element has the multiple attribute, the user is allowed to select multiple options, and the type property of the Select object is「select-multiple」. Otherwise, if the multiple attribute is not present, only a single item can be selected, and the type property is「select-one」.

In some ways, a select-multiple element is like a set of checkbox elements, and a select-one element is like a set of radio elements. The options displayed by a Select element are not toggle buttons, however: they are defined by <option> elements instead. A Select element defines an options property which is an array-like object that contains Option elements.

When the user selects or deselects an option, the Select element triggers its onchange event handler. For select-one Select elements, the read/write selectedIndex property specifies which one of the options is currently selected. For select-multiple elements, the single selectedIndex property is not sufficient to represent the complete set of selected options. In this case, to determine which options are selected, you must loop through the elements of the options[] array and check the value of the selected property for each Option object.

In addition to its selected property, each Option object has a text property that specifies the string of plain text that appears in the Select element for that option. You can set this property to change the text that is displayed to the user. The value property is also a read/write string that specifies the text to be sent to the web server when the form is submitted. Even if you are writing a pure client-side program and your form never gets submitted, the value property (or its corresponding HTML value attribute) can be a useful place to store any data that you’ll need if the user selects a particular option. Note that Option elements do not have form-related event handlers: use the onchange handler of the containing Select element instead.

In addition to setting the text property of Option objects, you can dynamically change the options displayed in a Select element using special features of the options property that date to the early days of client-side scripting. You can truncate the array of Option elements by setting options.length to the desired number of options, and you can remove all Option objects by setting options.length to 0. You can remove an individual Option object from the Select element by setting its spot in the options[] array to null. This deletes the Option object, and any higher elements in the options[] array automatically get moved down to fill the empty spot.

To add new options to a Select element, create an Option object with the Option() constructor and append it to the options[] property with code like this:

// Create a new Option object var zaire = new Option("Zaire", // The text property "zaire", // The value property false, // The defaultSelected property false); // The selected property // Display it in a Select element by appending it to the options array: var countries = document.address.country; // Get the Select object countries.options[countries.options.length] = zaire;

Keep in mind that these special-purpose Select element APIs are very old. You can more clearly insert and remove option elements with standard calls to Document.create Element(), Node.insertBefore(), Node.removeChild(), and so on.

Other Document Features

This chapter began with the assertion that it is one of the most important in the book. It is also, by necessity, one of the longest. This final section rounds out the chapter by covering a number of miscellaneous features of the Document object.

Document Properties

This chapter has already introduced Document properties such as body, document Element , and forms that refer to special elements of the document. Documents also define a few other properties of interest:

cookie

A special property that allows JavaScript programs to read and write HTTP cookies. This property is covered in Chapter 20.

domain

A property that allows mutually trusted web servers within the same Internet domain to collaboratively relax same-origin policy security restrictions on interactions between their web pages (see Relaxing the same-origin policy).

lastModified

A string that contains the modification date of the document.

location

This property refers to the same Location object as the location property of the Window object.

referrer

The URL of the document containing the link, if any, that brought the browser to the current document. This property has the same content as the HTTP Referer header, but it is spelled with a double r.

title

The text between the <title> and <title> tags for this document.

URL

The URL of the document as a read-only String rather than as a Location object. The value of this property is the same as the initial value of location.href, but it is not dynamic like the Location object is. If the user navigates to a new fragment identifier within the document, for example, location.href will change, but document.URL will not.

referrer is one of the most interesting of these properties: it contains the URL of the document from which the user linked to the current document. You might use this property with code like this:

if (document.referrer.indexOf("http://www.google.com/search?") == 0) { var args = document.referrer.substring(ref.indexOf("?")+1).split("&"); for(var i = 0; i < args.length; i++) { if (args[i].substring(0,2) == "q=") { document.write("<p>Welcome Google User. "); document.write("You searched for: " + unescape(args[i].substring(2)).replace('+', ' '); break; } } }

The document.write() method used in the code above is the subject of the next section.

The document.write() Method

The document.write() method was one of the very first scriptable APIs implemented by the Netscape 2 web browser. It was introduced well before the DOM and was the only way to display computed text in a document. It is no longer needed in new code, but you are likely to see it in existing code.

document.write() concatenates its string arguments and inserts the resulting string into the document at the location of the script element that invoked it. When the script finishes running, the browser parses the generated output and displays it. The following code, for example, uses write() to dynamically output information into an otherwise static HTML document:

<script> document.write("<p>Document title: " + document.title); document.write("<br>URL: " + document.URL); document.write("<br>Referred by: " + document.referrer); document.write("<br>Modified on: " + document.lastModified); document.write("<br>Accessed on: " + new Date()); </script>

It is important to understand that you can use the write() method to output HTML to the current document only while that document is being parsed. That is, you can call document.write() from within top-level code in <script> elements only because these scripts are executed as part of the document parsing process. If you place a document. write() call within a function definition and then call that function from an event handler, it will not work as you expect—in fact, it will erase the current document and the scripts it contains! (You’ll see why shortly.) For similar reasons, you should not use document.write() in scripts that have the defer or async attributes set.

Example 13-3 in Chapter 13 used document.write() in this way to generate more complicated output.

You can also use the write() method to create entirely new documents in other windows or frames. (When working with multiple windows or frames, however, you must be careful not to violate the same-origin policy.) Your first call to the write() method of another document will erase all content in that document. You can call write() more than once to build up the new content of the document. The content you pass to write() may be buffered (and not displayed) until you terminate the sequence of writes by calling the close() method of the document object. This, in essence, tells the HTML parser that it has reached the end-of-file for the document and that it should finish parsing and display the new document.

It is worth noting that the Document object also supports a writeln() method, which is identical to the write() method in every way except that it appends a newline after outputting its arguments. This can be useful if you are outputting preformatted text within a <pre> element, for example.

The document.write() method is not commonly used in modern code: the innerHTML property and other DOM techniques provide a better way of adding content to a document. On the other hand, some algorithms do lend themselves nicely to a stream-style I/O API like that provided by the write() method. If you are writing code that computes and outputs text while it runs, you might be interested in Example 15-10, which wraps simple write() and close() methods around the innerHTML property of a specified element.

Example 15-10. A streaming API for the innerHTML property

// Define a simple "streaming" API for setting the innerHTML of an element. function ElementStream(elt) { if (typeof elt === "string") elt = document.getElementById(elt); this.elt = elt; this.buffer = ""; } // Concatenate all arguments and append to the buffer ElementStream.prototype.write = function() { this.buffer += Array.prototype.join.call(arguments, ""); }; // Just like write(), but add a newline ElementStream.prototype.writeln = function() { this.buffer += Array.prototype.join.call(arguments, "") + "\n"; }; // Set element content from buffer and empty the buffer. ElementStream.prototype.close = function() { this.elt.innerHTML = this.buffer; this.buffer = ""; };

Querying Selected Text

It is sometimes useful to be able to determine what text the user has selected within a document. You can do that with a function like this:

function getSelectedText() { if (window.getSelection) // The HTML5 standard API return window.getSelection().toString(); else if (document.selection) // This is the IE-specific technique. return document.selection.createRange().text; }

The standard window.getSelection() method returns a Selection object that describes the current selection as a sequence of one or more Range objects. Selection and Range define a fairly complex API that is not commonly used and is not documented in this book. The most important and widely implemented (except in IE) feature of the Selection object is that it has a toString() method that returns the plain text content of the selection.

IE defines a different API that is also left undocumented in this book. document. selection returns an object that represents the selection. The createRange() method of that object returns an IE-specific TextRange object, and the text property of that object contains the selected text.

Code like the above can be particularly useful in bookmarklets (Bookmarklets) that operate on the selected text by looking up a word with a search engine or reference site. The following HTML link, for example, looks up the currently selected text in Wikipedia. When bookmarked, this link and the JavaScript URL it contains become a bookmarklet:

<a href="javascript: var q; if (window.getSelection) q = window.getSelection().toString(); else if (document.selection) q = document.selection.createRange().text; void window.open('http://en.wikipedia.org/wiki/' + q);"> Look Up Selected Text In Wikipedia </a>

There is an incompatibility in the selection querying code shown above: the get Selection() method of the Window object does not return selected text if it is within an <input> or <textarea> form element: it only returns text selected from the body of the document itself. The IE document.selection property, on the other hand, returns selected text from anywhere in the document.

To obtain the selected text from a text input field or <textarea> element, use this code:

elt.value.substring(elt.selectionStart, elt.selectionEnd);

The selectionStart and selectionEnd properties are not supported in IE8 or earlier.

Editable Content

We’ve seen that HTML form elements include text fields and textarea elements that allow the user to enter and edit plain text. Following the lead of IE, all current web browsers also support simple HTML editing functionality: you may have seen this in use on pages (such as blog comment pages) that embed a rich-text editor that includes a toolbar of buttons for setting typographic styles (bold, italic), setting justification, and inserting images and links.

There are two ways to enable this editing functionality. Set the contenteditable HTML attribute of any tag or set the contenteditable JavaScript property on the corresponding Element to make the content of that element editable. When the user clicks on the content inside that element, an insertion cursor will appear and the user’s keystrokes will be inserted. Here is an HTML element that creates an editable region:

<div id="editor" contenteditable> Click to edit </div>

Browsers may support automatic spell-checking for form fields and contenteditable elements. In browsers that support this, checking may be on by default or off by default. Add the spellcheck attribute to explicitly turn checking on in browsers that support it. And use spellcheck=false to explicitly disable checking (when, for example, a <text area> will display source code or other content with identifiers that do not appear in dictionaries).

You can also make an entire document editable by setting the designMode property of the Document object to the string「on」. (Set it to「off」to revert to a read-only document.) The designMode property does not have a corresponding HTML attribute. You might make the document within an <iframe> editable like this (note the use of the onLoad() function from Example 13-5):

<iframe id="editor" src="about:blank"></iframe> // Empty iframe <script> onLoad(function() { // When document loads, var editor = document.getElementById("editor"); // get the iframe document editor.contentDocument.designMode = "on"; // and turn editing on. }); </script>

All current browsers support contenteditable and designMode. They are less compatible, however, when it comes to their actual editing behavior. All browsers allow you to insert and delete text and move the cursor using the mouse and keyboard. In all browsers, the Enter key begins a new line, but different browsers produce different markup. Some begin a new paragraph and others simply insert a <br/> element.

Some browsers allow keyboard shortcuts such as Ctrl-B to convert the currently selected text to bold. In other browsers (such as Firefox), standard word processor shortcuts such as Ctrl-B and Ctrl-I are bound to other, browser-related functions and are not available to the text editor.

Browsers define a number of text-editing commands, most of which do not have keyboard shortcuts. To execute these commands, you instead use the execCommand() method of the Document object. (Note that this is a method of the Document, not of the element on which the contenteditable attribute is set. If a document contains more than one editable element, the command applies to whichever one holds the selection or the insertion cursor.) Commands executed by execCommand() are named by strings such as「bold」,「subscript」,「justifycenter,」or「insertimage」. The command name is the first argument to execCommand(). Some commands require a value argument—「createlink」, for example, requires the hyperlink URL. In theory, if the second argument to execCommand() is true, the browser will automatically prompt the user for whatever value is required. For portability, however, you should prompt the user yourself, pass false as the second argument, and pass the value as the third argument. Here are two example functions that perform edits using execCommand():

function bold() { document.execCommand("bold", false, null); } function link() { var url = prompt("Enter link destination"); if (url) document.execCommand("createlink", false, url); }

The commands supported by execCommand() are typically triggered by buttons in a toolbar. A good UI will disable buttons when the command they trigger is not available. Pass a command name to document.queryCommandSupported() to find out if it is supported by the browser. Call document.queryCommandEnabled() to find out if the command can currently be used. (A command that expects a selected range of text, for example, might be disabled when there is no selection.) Some commands, such as the「bold」and「italic」commands, have a boolean state and can be on or off depending on the current selection or cursor location. These commands are typically represented with a toggle button in a toolbar. Use document.queryCommandState() to determine the current state of such a command. Finally, some commands, such as「fontname,」have an associated value (a font family name). Query this value with document.queryCommandValue(). If the current selection includes text using two different font families, the value of「fontname」will be indeterminate. Use document.queryCommandIndeterm() to check for this case.

Different browsers implement different sets of editing commands. A few, such as「bold」,「italic」,「createlink」,「undo,」and「redo」, are well supported.[34] The HTML5 draft current at the time of this writing defines the following commands. Because they are not universally supported, however, they are not documented here in any detail:

bold insertLineBreak selectAll createLink insertOrderedList subscript delete insertUnorderedList superscript formatBlock insertParagraph undo forwardDelete insertText unlink insertImage italic unselect insertHTML redo

If you need rich-text editing functionality for your web application, you will probably want to adopt a prebuilt solution that addresses the various differences between browsers. A number of such editor components can be found online.[35] It is worth noting that the editing functionality built into browsers is powerful enough to allow a user to enter small amounts of rich text, but it is too simple for any kind of serious document editing. In particular, note that the HTML markup generated by these editors is likely to be quite messy.

Once the user has edited the content of an element that has the contenteditable attribute set, you can use the innerHTML property to obtain the HTML markup of the edited content. What you do with that rich text is up to you. You might store it in a hidden form field and send it to a server by submitting the form. You might use the techniques described in Chapter 18 to send the edited text directly to a server. Or you might use the techniques shown in Chapter 20 to save the user’s edits locally.

* * *

[34] See http://www.quirksmode.org/dom/execCommand.html for a list of interoperable commands.

[35] The YUI and Dojo frameworks include editor components. A list of other choices can be found at http://en.wikipedia.org/wiki/Online_rich-text_editor.

Chapter 16. Scripting CSS

Cascading Style Sheets (CSS) is a standard for specifying the visual presentation of HTML documents. CSS is intended for use by graphic designers: it allows a designer to precisely specify fonts, colors, margins, indentation, borders, and even the position of document elements. But CSS is also of interest to client-side JavaScript programmers because CSS styles can be scripted. Scripted CSS enables a variety of interesting visual effects: you can create animated transitions where document content「slides in」from the right, for example, or create an expanding and collapsing outline list in which the user can control the amount of information that is displayed. When first introduced, scripted visual effects like these were revolutionary. The JavaScript and CSS techniques that produced them were loosely referred to as Dynamic HTML or DHTML, a term that has since fallen out of favor.

CSS is a complex standard that, at the time of this writing, is undergoing active development. CSS is a book-length topic of its own and complete coverage is well beyond the scope of this book.[36] In order to understand CSS scripting, however, it is necessary to be familiar with CSS basics and with the most commonly scripted styles, so this chapter begins with a concise overview of CSS, followed by an explanation of key styles that are most amenable to scripting. After these two introductory sections, the chapter moves on to explain how to script CSS. Scripting Inline Styles explains the most common and important technique: altering the styles that apply to individual document elements using the HTML style attribute. Although an element’s style attribute can be used to set styles, it is not useful for querying an element’s style. Querying Computed Styles explains how to query the computed style of any element. Scripting CSS Classes explains how to alter many styles at once by altering the style attribute of an element. It is also possible, though less common, to script stylesheets directly, and Scripting Stylesheets shows how to enable and disable stylesheets, alter the rules of existing stylesheets, and add new stylesheets.

Overview of CSS

There are many variables in the visual display of an HTML document: fonts, colors, spacing, and so on. The CSS standard enumerates these variables and calls them style properties. CSS defines properties that specify fonts, colors, margins, borders, background images, text alignment, element size, and element position. To define the visual appearance of HTML elements, we specify the value of CSS properties. To do this, follow the name of a property with a colon and a value:

font-weight: bold

In order to fully describe the visual presentation of an element, we usually need to specify the value of more than one property. When multiple name:value pairs are required, they are separated from one another by semicolons:

margin-left: 10%; /* left margin is 10% of page width */ text-indent: .5in; /* indent by 1/2 inch */ font-size: 12pt; /* 12 point font size */

As you can see, CSS ignores comments between /* and */. It does not support comments that begin with //, however.

There are two ways to associate a set of CSS property values with the HTML elements whose presentation they define. The first is by setting the style attribute of an individual HTML element. This is called the inline style:

<p style="margin: 20px; border: solid red 2px;"> This paragraph has increased margins and is surrounded by a rectangular red border. </p>

It is usually much more useful, however, to separate CSS styles from individual HTML elements and define them in a stylesheet. A stylesheet associates sets of style properties with sets of HTML elements that are described using selectors. A selector specifies or「selects」one or more elements of a document, based on element ID, class, or tag name, or on more specialized criteria. Selectors were introduced in Selecting Elements with CSS Selectors, which also showed how to use querySelectorAll() to obtain the set of elements that match the selector.

The basic element of a CSS stylesheet is a style rule, which consists of a selector followed by a set of CSS properties and their values, enclosed in curly braces. A stylesheet can contain any number of style rules:

p { /* the selector "p" matches all <p> elements */ text-indent: .5in; /* indent the first line by .5 inches */ } .warning { /* Any element with class="warning" */ background-color: yellow; /* gets a yellow background */ border: solid black 5px; /* and a big black border */ }

A CSS stylesheet can be associated with an HTML document by enclosing it within <style> and </style> tags within the <head> of a document. Like the <script> element, the <style> element parses its content specially and does not treat it as HTML:

<html> <head><title>Test Document</title> <style> body { margin-left: 30px; margin-right: 15px; background-color: #ffffff } p { font-size: 24px; } </style> </head> <body><p>Testing, testing</p> </html>

When a stylesheet is to be used by more than one page on a website, it is usually better to store it in its own file, without any enclosing HTML tags. This CSS file can then be included in the HTML page. Unlike the <script> element, however, the <style> element does not have a src attribute. To include a stylesheet in an HTML page, use a <link> in the <head> of a document:

<head> <title>Test Document</title> <link rel="stylesheet" href="mystyles.css" type="text/css"> </head>

That, in a nutshell, is how CSS works. There are a few other points about CSS that are worth understanding, however, and the subsections that follow explain them.

The Cascade

Recall that the C in CSS stands for「cascading.」This term indicates that the style rules that apply to any given element in a document can come from a「cascade」of different sources:

The web browser’s default stylesheet

The document’s stylesheets

The style attribute of individual HTML elements

Styles from the style attribute override styles from stylesheets. And styles from a document’s stylesheets override the browser’s default styles, of course. The visual presentation of any given element may be a combination of style properties from all three sources. An element may even match more than one selector within a stylesheet, in which case the style properties associated with all of those selectors are applied to the element. (If different selectors define different values for the same style property, the value associated with the most specific selector overrides the value associated with less specific selectors, but the details are beyond the scope of this book.)

To display any document element, the web browser must combine the style attribute of that element with styles from all the matched selectors in the document stylesheets. The result of this computation is the actual set of style properties and values that are used to display the element. This set of values is known as the computed style of the element.

CSS History

CSS is a relatively old standard. CSS1 was adopted in December 1996 and defines properties for specifying colors, fonts, margins, borders, and other basic styles. Browsers as old as Netscape 4 and Internet Explorer 4 include substantial support for CSS1. The second edition of the standard, CSS2, was adopted in May 1998; it defines a number of more advanced features, most notably support for absolute positioning of elements. CSS2.1 clarifies and corrects CSS2, and it removes features that browser vendors never actually implemented. Current browsers have essentially complete support for CSS2.1, although versions of IE prior to IE8 have notable omissions.

Work continues on CSS. For version 3, the CSS specification has been broken into various specialized modules that are going through the standardization process separately. You can find the CSS specifications and working drafts at http://www.w3.org/Style/CSS/current-work.

Shortcut Properties

Certain style properties that are commonly used together can be combined using special shortcut properties. For example, the font-family, font-size, font-style, and font-weight properties can all be set at once using a single font property with a compound value:

font: bold italic 24pt helvetica;

Similarly, the border, margin, and padding properties are shortcuts for properties that specify borders, margins, and padding (space between the border and element content) for each of the individual sides of an element. For example, instead of using the border property, you can use border-left, border-right, border-top, and border-bottom properties to specify the border of each side separately. In fact, each of these properties is itself a shortcut. Instead of specifying border-top, you can specify border-top-color, border-top-style, and border-top-width.

Nonstandard Properties

When browser vendors implement nonstandard CSS properties, they prefix the property names with a vendor-specific string. Firefox uses moz-, Chrome uses -webkit-, and IE uses -ms-. Browser vendors do this even when implementing properties that are intended for future standardization. One example is the border-radius property, which specifies rounded corners for elements. This was implemented experimentally in Firefox 3 and Safari 4 using prefixes. Once the standard had matured sufficiently, Firefox 4 and Safari 5 removed the prefix and supported border-radius directly. (Chrome and Opera have supported it for a long time with no prefix. IE9 also supports it without a prefix, but IE8 did not support it, even with a prefix.)

When working with CSS properties that have different names in different browsers, you may find it helpful to define a class for that property:

.radius10 { border-radius: 10px; /* for current browsers */ -moz-border-radius: 10px; /* for Firefox 3.x */ -webkit-border-radius: 10px; /* For Safari 3.2 and 4 */ }

With a class like this defined, you can add「radius10」to the class attribute of any element to give it a border radius of 10 pixels.

CSS Example

Example 16-1 is an HTML file that defines and uses a stylesheet. It demonstrates tag name, class, and ID-based selectors, and also has an example of an inline style defined with the style attribute. Figure 16-1 shows how this example is rendered in a browser.

Figure 16-1. A web page styled with CSS

Example 16-1. Defining and using Cascading Style Sheets

<head> <style type="text/css"> /* Specify that headings display in blue italic text. */ h1, h2 { color: blue; font-style: italic } /* * Any element of class="WARNING" displays in big bold text with large margins * and a yellow background with a fat red border. */ .WARNING { font-weight: bold; font-size: 150%; margin: 0 1in 0 1in; /* top right bottom left */ background-color: yellow; border: solid red 8px; padding: 10px; /* 10 pixels on all 4 sides */ } /* * Text within an h1 or h2 heading within an element with class="WARNING" * should be centered, in addition to appearing in blue italics. */ .WARNING h1, .WARNING h2 { text-align: center } /* The single element with id="special" displays in centered uppercase. */ #special { text-align: center; text-transform: uppercase; } </style> </head> <body> <h1>Cascading Style Sheets Demo</h1> <div class="WARNING"> <h2>Warning</h2> This is a warning! Notice how it grabs your attention with its bold text and bright colors. Also notice that the heading is centered and in blue italics. </div> <p id="special"> This paragraph is centered<br> and appears in uppercase letters.<br> <span style="text-transform: none"> Here we explicitly use an inline style to override the uppercase letters. </span> </p>

Cutting-Edge CSS

As I write this chapter, CSS is in the midst of a revolution, with browser vendors implementing powerful new styles such as border-radius, text-shadow, box-shadow, and column-count. Another revolutionary new feature of CSS is web fonts: the ability to download and use custom fonts with a CSS @font-face rule. (See http://code.google.com/webfonts for a selection of fonts free for use on the Web and an easy mechanism for downloading them from Google’s servers.)

Another revolutionary development in CSS is CSS Transitions. This is a draft specification that can automatically turn any scripted change to a CSS style into a smoothly animated transition. (When widely implemented, it will largely obviate the need for CSS animation code like that shown in CSS Animations.) CSS Transitions is implemented in current browsers other than IE, but its style properties are still prefixed with vendor-specific strings. CSS Animations is a related proposal that uses CSS Transitions as a starting point for defining more complex animation sequences. CSS Animations are currently only implemented by Webkit browsers. Neither transitions nor animations are covered in this chapter, but they are technologies that you, as a web developer, should be aware of.

Another CSS draft that web developers should be aware of is CSS Transforms, which allows arbitrary 2D affine transforms (rotation, scaling, translation, or any combination expressed as a matrix) to be applied to any element. All current browsers (including IE9 and later) support the draft, with vendor prefixes. Safari even supports an extension that allows 3D transformations, but it is unclear whether other browsers will follow their lead.

* * *

[36] But see CSS: The Definitive Guide by Eric Meyer (O’Reilly), for example.

Important CSS Properties

For client-side JavaScript programmers, the most important features of CSS are the properties that specify the visibility, size, and precise position of individual elements of a document. Other CSS properties allow you to specify stacking order, transparency, clipping region, margins, padding, borders, and colors. In order to script CSS, it is important to understand how these style properties work. They are summarized in Table 16-1 and documented in more detail in the sections that follow.

Table 16-1. Important CSS style properties

PropertyDescription

position Specifies the type of positioning applied to an element

top, left Specify the position of the top and left edges of an element

bottom, right Specify the position of the bottom and right edges of an element

width, height Specify the size of an element

z-index Specifies the「stacking order」of an element relative to any overlapping elements; defines a third dimension of element positioning

display Specifies how and whether an element is displayed

visibility Specifies whether an element is visible

clip Defines a「clipping region」for an element; only portions of the element within this region are displayed

overflow Specifies what to do if an element is bigger than the space allotted for it

margin, border, padding Specify spacing and borders for an element.

background Specifies the background color or image of an element.

opacity Specifies how opaque (or translucent) an element is. This is a CSS3 property, supported by some browsers. A working alternative exists for IE.

Positioning Elements with CSS

The CSS position property specifies the type of positioning applied to an element. Here are the four possible values for this property:

static

This is the default value and specifies that the element is positioned according to the normal flow of document content (for most Western languages, this is left to right and top to bottom). Statically positioned elements cannot be positioned with top, left, and other properties. To use CSS positioning techniques with a document element, you must first set its position property to one of the other three values.

absolute

This value allows you to specify the position of an element relative to its containing element. Absolutely positioned elements are positioned independently of all other elements and are not part of the flow of statically positioned elements. An absolutely positioned element is positioned either relative to its nearest positioned ancestor or relative to the document itself.

fixed

This value allows you to specify an element’s position with respect to the browser window. Elements with fixed positioning are always visible and do not scroll with the rest of the document. Like absolutely positioned elements, fixed-position elements are independent of all others and are not part of the document flow. Fixed positioning is supported in most modern browsers but is not available in IE6.

relative

When the position property is set to relative, an element is laid out according to the normal flow, and its position is then adjusted relative to its position in the normal flow. The space allocated for the element in the normal document flow remains allocated for it, and the elements on either side of it do not close up to fill in that space, nor are they「pushed away」from the new position of the element.

Once you have set the position property of an element to something other than static, you can specify the position of that element with some combination of the left, top, right, and bottom properties. The most common positioning technique uses the left and top properties to specify the distance from the left edge of the containing element (usually the document itself) to the left edge of the element and the distance from the top edge of the container to the top edge of the element. For example, to place an element 100 pixels from the left and 100 pixels from the top of the document, you can specify CSS styles in a style attribute as follows:

<div style="position: absolute; left: 100px; top: 100px;">

If an element uses absolute positioning, its top and left properties are interpreted relative to the closest ancestor element that has its position property set to something other than static. If an absolutely positioned element has no positioned ancestor, the top and left properties are measured in document coordinates—they are offsets from the top-left corner of the document. If you wish to absolutely position an element relative to a container that is part of the normal document flow, use position:relative for the container and specify a top and left position of 0px. This makes the container dynamically positioned but leaves it at its normal place in the document flow. Any absolutely positioned children are then positioned relative to the container position.

Although it is most common to specify the position of the upper-left corner of an element with left and top, you can also use right and bottom to specify the position of the bottom and right edges of an element relative to the bottom and right edges of the containing element. For example, to position an element so that its bottom-right corner is at the bottom-right of the document (assuming it is not nested within another dynamic element), use the following styles:

position: absolute; right: 0px; bottom: 0px;

To position an element so that its top edge is 10 pixels from the top of the window and its right edge is 10 pixels from the right of the window, and so that it does not scroll with the document, you might use these styles:

position: fixed; right: 10px; top: 10px;

In addition to the position of elements, CSS allows you to specify their size. This is most commonly done by providing values for the width and height style properties. For example, the following HTML creates an absolutely positioned element with no content. Its width, height, and background-color properties make it appear as a small blue square:

<div style="position: absolute; top: 10px; left: 10px; width: 10px; height: 10px; background-color: blue"> </div>

Another way to specify the width of an element is to specify a value for both the left and right properties. Similarly, you can specify the height of an element by specifying both top and bottom. If you specify a value for left, right, and width, however, the width property overrides the right property; if the height of an element is overconstrained, height takes priority over bottom.

Bear in mind that it is not necessary to specify the size of every dynamic element. Some elements, such as images, have an intrinsic size. Furthermore, for dynamic elements that contain text or other flowed content, it is often sufficient to specify the desired width of the element and allow the height to be determined automatically by the layout of the element’s content.

CSS requires position and dimension properties to be specified with a unit. In the examples above, the position and size properties were specified with the suffix「px,」which stands for pixels. You can also use inches (「in」), centimeters (「cm」), points (「pt」), and ems (「em」; a measure of the line height for the current font).

Instead of specifying absolute positions and sizes using the units shown above, CSS also allows you to specify the position and size of an element as a percentage of the size of the containing element. For example, the following HTML creates an empty element with a black border that is half as wide and half as high as the containing element (or the browser window) and centered within that element:

<div style="position: absolute; left: 25%; top: 25%; width: 50%; height: 50%; border: 2px solid black"> </div>

The third dimension: z-index

You’ve seen that the left, top, right, and bottom properties can specify the X and Y coordinates of an element within the two-dimensional plane of the containing element. The z-index property defines a kind of third dimension: it allows you to specify the stacking order of elements and indicate which of two or more overlapping elements is drawn on top of the others. The z-index property is an integer. The default value is zero, but you may specify positive or negative values. When two or more elements overlap, they are drawn in order from lowest to highest z-index; the element with the highest z-index appears on top of all the others. If overlapping elements have the same z-index, they are drawn in the order in which they appear in the document so that the last overlapping element appears on top.

Note that z-index stacking applies only to sibling elements (i.e., elements that are children of the same container). If two elements that are not siblings overlap, setting their individual z-index properties does not allow you to specify which one is on top. Instead, you must specify the z-index property for the two sibling containers of the two overlapping elements.

Nonpositioned elements (i.e., elements with default position:static positioning) are always laid out in a way that prevents overlaps, so the z-index property does not apply to them. Nevertheless, they have a default z-index of zero, which means that positioned elements with a positive z-index appear on top of the normal document flow and positioned elements with a negative z-index appear beneath the normal document flow.

CSS positioning example: Shadowed text

The CSS3 specification includes a text-shadow property to produce drop-shadow effects under text. It is supported by a number of current browsers, but you can use CSS positioning properties to achieve a similar effect, as long as you are willing to repeat and restyle the text to produce a shadow:

<!-- The text-shadow property produces shadows automatically --> <span style="text-shadow: 3px 3px 1px #888">Shadowed</span> <!-- Here's how we can produce a similar effect with positioning. --> <span style="position:relative;"> Shadowed <!-- This is the text that casts the shadow. --> <span style="position:absolute; top:3px; left:3px; z-index:-1; color: #888"> Shadowed <!-- This is the shadow --> </span> </span>

The text to be shadowed is enclosed in a relatively positioned <span> element. There are no position properties set, so the text appears at its normal position in the flow. The shadow is in an absolutely positioned <span> inside (and therefore positioned relatively to) the relatively positioned <span>. The z-index property ensures that the shadow appears underneath the text that produces it.

Borders, Margins and Padding

CSS allows you to specify borders, margins, and padding around any element. The border of an element is a rectangle (or rounded rectangle in CSS3) drawn around (or partially around) it. CSS properties allow you to specify the style, color, and thickness of the border:

border: solid black 1px; /* border is drawn with a solid, black 1-pixel line */ border: 3px dotted red; /* border is drawn in 3-pixel red dots */

It is possible to specify the border width, style, and color using individual CSS properties, and it is also possible to specify the border for individual sides of an element. To draw a line beneath an element, for example, simply specify its border-bottom property. It is even possible to specify the width, style, or color of a single side of an element with properties such as border-top-width and border-left-color.

In CSS3, you can round all corners of a border with the border-radius property, and you can round individual corners with more explicit property names. For example:

border-top-right-radius: 50px;

The margin and padding properties both specify blank space around an element. The important difference is that margin specifies space outside the border, between the border and adjacent elements, and padding specifies space inside the border, between the border and the element content. A margin provides visual space between a (possibly bordered) element and its neighbors in the normal document flow. Padding keeps element content visually separated from its border. If an element has no border, padding is typically not necessary. If an element is dynamically positioned, it is not part of the normal document flow, and its margins are irrelevant.

You can specify the margin and padding of an element with the margin and padding properties:

margin: 5px; padding: 5px;

You can also specify margins and paddings for individual sides of an element:

margin-left: 25px; padding-bottom: 5px;

Or you can specify margin and padding values for all four edges of an element with the margin and padding properties. You specify the top values first and then proceed clockwise: top, right, bottom, and left. For example, the following code shows two equivalent ways to set different padding values for each of the four sides of an element:

padding: 1px 2px 3px 4px; /* The previous line is equivalent to the following lines. */ padding-top: 1px; padding-right: 2px; padding-bottom: 3px; padding-left: 4px;

The margin property works in the same way.

The CSS Box Model and Positioning Details

The margin, border, and padding style properties described above are not properties that you are likely to script very frequently. The reason that they are mentioned here is that margins, borders, and padding are part of the CSS box model, and you have to understand the box model in order to truly understand the CSS positioning properties.

Figure 16-2 illustrates the CSS box model and visually explains the meaning of the top, left, width, and height for elements that have borders and padding.

Figure 16-2. The CSS box model: borders, padding, and positioning properties

Figure 16-2 shows an absolutely positioned element nested inside a positioned container element. Both the container and the contained elements have borders and padding, and the figure illustrates the CSS properties that specify padding and border width for each side of the container element. Notice that no margin properties are shown: margins aren’t relevant to absolutely positioned elements.

Figure 16-2 contains other, more important information as well. First, width and height specify the size of an element’s content area only; they do not include any additional space required for the element’s padding or border (or margins). To determine the full on-screen size of an element with a border, you must add the left and right padding and left and right border widths to the element width, and you must add the top and bottom padding and top and bottom border widths to the element’s height.

Second, the left and top properties specify the distance from the inside of the container’s border to the outside of the positioned element’s border. These properties do not measure from the upper-left corner of the content area of the container, but from the upper-left corner of the container’s padding. Similarly, the right and bottom properties measure from the lower-right corner of the padding.

Here’s an example that might make this clearer. Suppose you’ve created a dynamically positioned container element that has 10 pixels of padding all the way around its content area and a 5-pixel border all the way around the padding. Now suppose you dynamically position a child element inside this container. If you set the left property of the child to「0 px」, you’ll discover that the child is positioned with its left edge right up against the inner edge of the container’s border. With this setting, the child overlaps the container’s padding, which presumably was supposed to remain empty (since that is the purpose of padding). If you want to position the child element in the upper left corner of the container’s content area, you should set both the left and top properties to「10px」.

The border-box model and the box-sizing property

The standard CSS box model specifies that the width and height style properties give the size of the content area and do not include padding and borders. We might call this box model the「content-box model.」There are exceptions to the content-box model in old versions of IE and also in new versions of CSS. Before IE6, and when IE6, 7, or 8 displays a page in「quirks mode」(when the page has no <!DOCTYPE> or has an insufficiently strict doctype), the width and height properties do include the padding and border widths.

IE’s behavior is a bug, but IE’s nonstandard box model is often quite useful. Recognizing this, CSS3 introduces a box-sizing property. The default value is content-box, which specifies the standard box model described above. If you instead specify box-sizing:border-box, the browser will use the IE box model for that element, and the width and height properties will include border and padding. The border-box model is particularly useful when you want to specify the overall size of an element as a percentage but also want to specify the border and padding size in pixels:

<div style="box-sizing:border-box; width: 50%; padding: 10px; border: solid black 2px;">

The box-sizing property is supported by all current browsers but is not yet universally implemented without a prefix. In Chrome and Safari, use -webkit-box-sizing. In Firefox, use -moz-box-sizing. In Opera and IE8 and later, you can use box-sizing without any prefix.

A future CSS3 alternative to the border-box model is the use of calculated values for box dimensions:

<div style="width: calc(50%-12px); padding: 10px; border: solid black 2px;">

Calculated CSS values with calc() are supported in IE9 and in Firefox 4 (as -moz-calc()).

Element Display and Visibility

Two CSS properties affect the visibility of a document element: visibility and display . The visibility property is simple: when the property is set to the value hidden, the element is not shown; when it is set to the value visible, the element is shown. The display property is more general and is used to specify the type of display an item receives. It specifies whether an element is a block element, an inline element, a list item, or so on. When display is set to none, however, the affected element is not displayed, or even laid out, at all.

The difference between the visibility and display style properties has to do with their effect on elements that use static or relative positioning. For an element that appears in the normal layout flow, setting visibility to hidden makes the element invisible but reserves space for it in the document layout. Such an element can be repeatedly hidden and shown without changing the document layout. If an element’s display property is set to none, however, no space is allocated for it in the document layout; elements on either side of it close up as if it were not there. The display property is useful, for example, when creating expanding and collapsing outlines.

visibility and display have equivalent effects when used with absolute- or fixed-position elements because these elements are not part of the document layout. The visibility property is generally preferred for hiding and showing positioned elements, however.

Note that it doesn’t make much sense to use visibility or display to make an element invisible unless you are going to use JavaScript to dynamically set these properties and make the element visible at some point! We’ll see how to do this later in the chapter.

Color, Transparency, and Translucency

You can specify the color of text contained in a document element with the CSS color property. And you can specify the background color of any element with the background-color property. Earlier, we saw that you can specify the color of an element’s border with border-color or with the shortcut property border.

The discussion of borders included examples that specified border colors using the English names of common colors such as「red」and「black」. CSS supports a number of these English color names, but the more general syntax for specifying colors in CSS is to use hexadecimal digits to specify the red, green, and blue components of a color. You can use either one or two digits per component. For example:

#000000 /* black */ #fff /* white */ #f00 /* bright red */ #404080 /* dark unsaturated blue */ #ccc /* light gray */

CSS3 also defines syntaxes for specifying colors in the RGBA color space (red, green, and blue values plus an alpha value that specifies the transparency of the color). RGBA is supported by all modern browsers except IE, and support is expected in IE9. CSS3 also defines support for HSL (hue-saturation-value) and HSLA color specifications. Again, these are supported by Firefox, Safari, and Chrome, but not IE.

CSS allows you to specify the exact position, size, background color, and border color of elements; this gives you a rudimentary graphics capability for drawing rectangles and (when the height and width are reduced) horizontal and vertical lines. The last edition of this book included a bar chart example using CSS graphics, but it has been replaced in this book by extended coverage of the <canvas> element. (See Chapter 21 for more on scripted client-side graphics.)

In addition to the background-color property, you can also specify images to be used as the background of an element. The background-image property specifies the image to use, and the background-attachment, background-position, and background-repeat properties specify further details about how this image is drawn. The shortcut property background allows you to specify these properties together. You can use these background image properties to create interesting visual effects, but those are beyond the scope of this book.

It is important to understand that if you do not specify a background color or image for an element, that element’s background is usually transparent. For example, if you absolutely position a <div> over some existing text in the normal document flow, that text will, by default, show through the <div> element. If the <div> contains its own text, the letters may overlap and become an illegible jumble. Not all elements are transparent by default, however. Form elements don’t look right with a transparent background, for example, and elements such as <button> have a default background color. You can override this default with the background-color property, and you can even explicitly set it to「transparent」if you desire.

The transparency we’ve been discussing so far is all-or-none: an element either has a transparent background or an opaque background. It is also possible to specify that an element (both its background and its foreground content) is translucent. (See Figure 16-3 for an example.) You do this with the CSS3 opacity property. The value of this property is a number between 0 and 1, where 1 means 100 percent opaque (the default) and 0 means 0% opaque (or 100% transparent). The opacity property is supported by all current browsers except IE. IE provides a work-alike alternative through its IE-specific filter property. To make an element 75 percent opaque, you can use the following CSS styles:

opacity: .75; /* standard CSS3 style for transparency */ filter: alpha(opacity=75); /* transparency for IE; note no decimal point */

Partial Visibility: overflow and clip

The visibility property allows you to completely hide a document element. The overflow and clip properties allow you to display only part of an element. The overflow property specifies what happens when the content of an element exceeds the size specified (with the width and height style properties, for example) for the element. The allowed values and their meanings for this property are as follows:

visible

Content may overflow and be drawn outside of the element’s box if necessary. This is the default.

hidden

Content that overflows is clipped and hidden so that no content is ever drawn outside the region defined by the size and positioning properties.

scroll

The element’s box has permanent horizontal and vertical scrollbars. If the content exceeds the size of the box, the scrollbars allow the user to scroll to view the extra content. This value is honored only when the document is displayed on a computer screen; when the document is printed on paper, for example, scrollbars obviously do not make sense.

auto

Scrollbars are displayed only when content exceeds the element’s size rather than being permanently displayed.

While the overflow property allows you to specify what happens when an element’s content is bigger than the element’s box, the clip property allows you to specify exactly which portion of an element should be displayed, whether or not the element overflows. This property is especially useful for scripted effects in which an element is progressively displayed or uncovered.

The value of the clip property specifies the clipping region for the element. In CSS2, clipping regions are rectangular, but the syntax of the clip property leaves open the possibility that future versions of the standard will support clipping shapes other than rectangles. The syntax of the clip property is:

rect(top right bottom left)

The top, right, bottom, and left values specify the boundaries of the clipping rectangle relative to the upper-left corner of the element’s box. For example, to display only a 100 × 100-pixel portion of an element, you can give that element this style attribute:

style="clip: rect(0px 100px 100px 0px);"

Note that the four values within the parentheses are length values and must include a unit specification, such as px for pixels. Percentages are not allowed. Values can be negative to specify that the clipping region extends beyond the box specified for the element. You can also use the auto keyword for any of the four values to specify that the edge of the clipping region is the same as the corresponding edge of the element’s box. For example, you can display just the leftmost 100 pixels of an element with this style attribute:

style="clip: rect(auto 100px auto auto);"

Note that there are no commas between the values, and the edges of the clipping region are specified in clockwise order from the top edge. To turn clipping off, set the clip property to auto.

Example: Overlapping Translucent Windows

This section concludes with an example that demonstrates many of the CSS properties discussed here. Example 16-2 uses CSS to create the visual effect of scrolling, overlapping, translucent windows within the browser window. Figure 16-3 shows how it looks.

Figure 16-3. Windows created with CSS

The example contains no JavaScript code and no event handlers, so there is no way to interact with the windows (other than to scroll them), but it is a useful demonstration of the powerful effects that can be achieved with CSS.

Example 16-2. Displaying windows with CSS

<!DOCTYPE html> <head> <style type="text/css"> /** * This is a CSS stylesheet that defines three style rules that we use * in the body of the document to create a "window" visual effect. * The rules use positioning properties to set the overall size of the window * and the position of its components. Changing the size of the window * requires careful changes to positioning properties in all three rules. **/ div.window { /* Specifies size and border of the window */ position: absolute; /* The position is specified elsewhere */ width: 300px; height: 200px;/* Window size, not including borders */ border: 3px outset gray; /* Note 3D "outset" border effect */ } div.titlebar { /* Specifies position, size, and style of the titlebar */ position: absolute; /* It's a positioned element */ top: 0px; height: 18px; /* Titlebar is 18px + padding and borders */ width: 290px; /* 290 + 5px padding on left and right = 300 */ background-color: #aaa; /* Titlebar color */ border-bottom: groove gray 2px; /* Titlebar has border on bottom only */ padding: 3px 5px 2px 5px; /* Values clockwise: top, right, bottom, left */ font: bold 11pt sans-serif; /* Title font */ } div.content { /* Specifies size, position and scrolling for window content */ position: absolute; /* It's a positioned element */ top: 25px; /* 18px title+2px border+3px+2px padding */ height: 165px; /* 200px total - 25px titlebar - 10px padding*/ width: 290px; /* 300px width - 10px of padding */ padding: 5px; /* Allow space on all four sides */ overflow: auto; /* Give us scrollbars if we need them */ background-color: #fff; /* White background by default */ } div.translucent { /* this class makes a window partially transparent */ opacity: .75; /* Standard style for transparency */ filter: alpha(opacity=75); /* Transparency for IE */ } </style> </head> <body> <!-- Here is how we define a window: a "window" div with a titlebar and --> <!-- content div nested inside. Note how position is specified with --> <!-- a style attribute that augments the styles from the stylesheet. --> <div class="window" style="left: 10px; top: 10px; z-index: 10;"> <div class="titlebar">Test Window</div> <div class="content"> 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>0<br><!-- Lots of lines to --> 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>0<br><!-- demonstrate scrolling--> </div> </div> <!-- Here's another window with different position, color, and font weight --> <div class="window" style="left: 75px; top: 110px; z-index: 20;"> <div class="titlebar">Another Window</div> <div class="content translucent" style="background-color:#ccc; font-weight:bold;"> This is another window. Its <tt>z-index</tt> puts it on top of the other one. CSS styles make its content area translucent, in browsers that support that. </div> </div>

The major shortcoming of this example is that the stylesheet specifies a fixed size for all windows. Because the titlebar and content portions of the window must be precisely positioned within the overall window, changing the size of a window requires changing the value of various positioning properties in all three rules defined by the stylesheet. This is difficult to do in a static HTML document, but it would not be so difficult if you could use a script to set all the necessary properties. This topic is explored in the next section.

Scripting Inline Styles

The most straightforward way to script CSS is to alter the style attribute of individual document elements. Like most HTML attributes, style is also a property of the Element object, and you can manipulate it in JavaScript. The style property is unusual, however: its value is not a string, but a CSSStyleDeclaration object. The JavaScript properties of this style object represent the CSS properties specified by the HTML style attribute. To make the text of an element e big, bold, and blue, for example, you can use the following code to set the JavaScript properties that correspond to the font-size font-weight and color style properties:

e.style.fontSize = "24pt"; e.style.fontWeight = "bold"; e.style.color = "blue";

Naming Conventions: CSS Properties in JavaScript

Many CSS style properties, such as font-size, contain hyphens in their names. In JavaScript, a hyphen is interpreted as a minus sign, so it is not possible to write an expression like:

e.style.font-size = "24pt"; // Syntax error!

Therefore, the names of the properties of the CSSStyleDeclaration object are slightly different from the names of actual CSS properties. If a CSS property name contains one or more hyphens, the CSSStyleDeclaration property name is formed by removing the hyphens and capitalizing the letter immediately following each hyphen. Thus, the CSS property border-left-width is accessed through the JavaScript borderLeftWidth property, and you can access the CSS font-family property with code like this:

e.style.fontFamily = "sans-serif";

Also, when a CSS property, such as the float property, has a name that is a reserved word in JavaScript, that name is prefixed with「css」to create a legal CSSStyleDeclaration name. Thus, to set or query the value of the CSS float property of an element, use the cssFloat property of the CSSStyleDeclaration object.

When working with the style properties of the CSSStyleDeclaration object, remember that all values must be specified as strings. In a stylesheet or style attribute, you can write:

position: absolute; font-family: sans-serif; background-color: #ffffff;

To accomplish the same thing for an element e with JavaScript, you have to quote all of the values:

e.style.position = "absolute"; e.style.fontFamily = "sans-serif"; e.style.backgroundColor = "#ffffff";

Note that the semicolons go outside the strings. These are just normal JavaScript semicolons; the semicolons you use in CSS stylesheets are not required as part of the string values you set with JavaScript.

Furthermore, remember that all the positioning properties require units. Thus, it is not correct to set the left property like this:

e.style.left = 300; // Incorrect: this is a number, not a string e.style.left = "300"; // Incorrect: the units are missing

Units are required when setting style properties in JavaScript, just as they are when setting style properties in stylesheets. The correct way to set the value of the left property of an element e to 300 pixels is:

e.style.left = "300px";

If you want to set the left property to a computed value, be sure to append the units at the end of the computation:

e.style.left = (x0 + left_margin + left_border + left_padding) + "px";

Notice that the numeric result of the computation will be converted to a string as a side effect of appending the units string.

Recall that some CSS properties, such as margin, are shortcuts for other properties, such as margin-top, margin-right, margin-bottom, and margin-left. The CSSStyleDeclaration object has properties that correspond to these shortcut properties. For example, you might set the margin property like this:

e.style.margin = topMargin + "px " + rightMargin + "px " + bottomMargin + "px " + leftMargin + "px";

Arguably, it is easier to set the four margin properties individually:

e.style.marginTop = topMargin + "px"; e.style.marginRight = rightMargin + "px"; e.style.marginBottom = bottomMargin + "px"; e.style.marginLeft = leftMargin + "px";

The style attribute of an HTML element is its inline style, and it overrides any style specifications in a stylesheet. Inline styles are generally useful for setting style values, and that is what the examples above have all done. You can read the properties of a CSSStyleDeclaration object that represents inline styles, but they return meaningful values only if they’ve previously been set by your JavaScript code or if the HTML element with which you are working has an inline style attribute that sets the desired properties. For example, your document may include a stylesheet that sets the left margin for all paragraphs to 30 pixels, but if you read the marginLeft property of one of your paragraph elements, you’ll get the empty string unless that paragraph has a style attribute that overrides the stylesheet setting.

Reading the inline style of an element is particularly difficult for style properties that require units and for shortcut properties: your code has to include nontrivial CSS parsing capabilities to really make use of those values. In general, the inline style of an element is only useful for setting styles. If you need to query the style of an element, use the computed style, which is discussed in Querying Computed Styles.

Sometimes, you may find it easier to set or query the inline style of an element as a single string value rather than as a CSSStyleDeclaration object. To do that, you can use the Element getAttribute() and setAttribute() methods, or you can use the cssText property of the CSSStyleDeclaration object:

// Set the style attribute of e to the string s with either of these lines: e.setAttribute("style", s); e.style.cssText = s; // Query the inline style string of the element e with either of these: s = e.getAttribute("style"); s = e.style.cssText;

CSS Animations

One of the most common uses of scripted CSS is to produce animated visual effects. This can be achieved by using setTimeout() or setInterval() (see Timers) to repeatedly invoke a function that alters the inline style of an element. Example 16-3 demonstrates with two functions shake() and fadeOut(). shake() quickly moves or「shakes」an element side to side. It might be used to grab the user’s attention if he enters invalid data, for example. fadeOut() decreases the opacity of an element over a specified amount of time (500 milliseconds, by default), causing it to fade out and vanish.

Example 16-3. CSS animations

// Convert element e to relative positioning and "shake" it left and right. // The first argument can be an element object or the id of an element. // If a function is passed as the second argument, it will be invoked // with e as an argument when the animation is complete. // The 3rd argument specifies how far to shake e. The default is 5 pixels. // The 4th argument specifies how long to shake for. The default is 500 ms. function shake(e, oncomplete, distance, time) { // Handle arguments if (typeof e === "string") e = document.getElementById(e); if (!time) time = 500; if (!distance) distance = 5; var originalStyle = e.style.cssText; // Save the original style of e e.style.position = "relative"; // Make e relatively positioned var start = (new Date()).getTime(); // Note the animation start time animate(); // Start the animation // This function checks the elapsed time and updates the position of e. // If the animation is complete, it restores e to its original state. // Otherwise, it updates e's position and schedules itself to run again. function animate() { var now = (new Date()).getTime(); // Get current time var elapsed = now-start; // How long since we started var fraction = elapsed/time; // What fraction of total time? if (fraction < 1) { // If the animation is not yet complete // Compute the x position of e as a function of animation // completion fraction. We use a sinusoidal function, and multiply // the completion fraction by 4pi, so that it shakes back and // forth twice. var x = distance * Math.sin(fraction*4*Math.PI); e.style.left = x + "px"; // Try to run again in 25ms or at the end of the total time. // We're aiming for a smooth 40 frames/second animation. setTimeout(animate, Math.min(25, time-elapsed)); } else { // Otherwise, the animation is complete e.style.cssText = originalStyle // Restore the original style if (oncomplete) oncomplete(e); // Invoke completion callback } } } // Fade e from fully opaque to fully transparent over time milliseconds. // Assume that e is fully opaque when this function is invoked. // oncomplete is an optional function that will be invoked with e as its // argument when the animation is done. If time is omitted, use 500ms. // This function does not work in IE, but could be modified to animate // IE's nonstandard filter property in addition to opacity. function fadeOut(e, oncomplete, time) { if (typeof e === "string") e = document.getElementById(e); if (!time) time = 500; // We use Math.sqrt as a simple "easing function" to make the animation // subtly nonlinear: it fades quickly at first and then slows down some. var ease = Math.sqrt; var start = (new Date()).getTime(); // Note the animation start time animate(); // And start animating function animate() { var elapsed = (new Date()).getTime()-start; // elapsed time var fraction = elapsed/time; // As a fraction of total if (fraction < 1) { // If the animation is not yet complete var opacity = 1 - ease(fraction); // Compute element opacity e.style.opacity = String(opacity); // Set it on e setTimeout(animate, // Schedule another frame Math.min(25, time-elapsed)); } else { // Otherwise, we're done e.style.opacity = "0"; // Make e fully transparent if (oncomplete) oncomplete(e); // Invoke completion callback } } }

Both shake() and fadeOut() accept an optional callback function as their second argument. If specified, this function will be invoked when the animation is complete. The element that was animated is passed as an argument to the callback. The following HTML creates a button that, when clicked, shakes from side to side and then fades away:

<button onclick="shake(this, fadeOut);">Shake and Fade</button>

Note that the shake() and fadeOut() example functions are quite similar to each other, and both can serve as templates for similar animations of other CSS properties. Client-side libraries, such as jQuery usually support pre-defined visual effects, however, so you may never actually need to write an animation function like shake(), unless you want to create a particularly complex visual effect. One early and noteworthy effects library is Scriptaculous, which is designed for use with the Prototype framework. Visit http://script.aculo.us/ and http://scripty2.com/ to learn more.

The CSS3 Transitions module defines a way to specify animated effects in stylesheets, obviating the need for any scripting. Instead of defining a function like fadeOut(), for example, you might use CSS like this:

.fadeable { transition: opacity .5s ease-in }

This specifies that any time the opacity of a「fadeable」element changed, that change will be animated (from the current value to the new value) over a period of half a second, using a nonlinear easing function. CSS Transitions is not yet standard but has been implemented for some time in Safari and Chrome using the -webkit-transition property. At the time of this writing, Firefox 4 has added support using -moz-transition.

Querying Computed Styles

The style property of an element is that element’s inline style. It overrides all stylesheets, and it is the perfect place to set CSS properties to change the visual appearance of an element. It is not, however, generally useful for querying the styles that actually apply to an element. For that, you want the computed style. The computed style for an element is the set of property values that the browser derives (or computes) from the inline style plus all applicable style rules in all linked stylesheets: it is the set of properties actually used to display the element. Like inline styles, computed styles are represented with a CSSStyleDeclaration object. Unlike inline styles, however, computed styles are read-only. You can’t set these styles, but the computed CSSStyleDeclaration object for an element lets you determine exactly what style property values the browser used when rendering that element.

Obtain the computed style for an element with the getComputedStyle() method of the Window object. The first argument to this method is the element whose computed style is desired. The second argument is required and is usually null or the empty string, but it can also be a string that names a CSS pseudoelement, such as「:before」,「:after」,「:first-line」, or「:first-letter」:

var title = document.getElementById("section1title"); var titlestyles = window.getComputedStyle(element, null);

The return value of getComputedStyle() is a CSSStyleDeclaration object that represents all the styles that apply to the specified element (or pseudoelement). There are a number of important differences between a CSSStyleDeclaration object that represents inline styles and one that represents computed styles:

Computed style properties are read-only.

Computed style properties are absolute: relative units like percentages and points are converted to absolute values. Any property that specifies a size (such as a margin size or a font size) will have a value measured in pixels. This value will be a string with a「px」suffix, so you’ll still need to parse it, but you won’t have to worry about parsing or converting units. Properties whose values are colors will be returned in「rgb(#,#,#)」or「rgba(#,#,#,#)」format.

Shortcut properties are not computed, only the fundamental properties that they are based on. Don’t query the margin property, for example, but use marginLeft, marginTop, and so on.

The cssText property of the computed style is undefined.

Computed styles and inline styles can be used together. Example 16-4 defines functions scale() and scaleColor(). One queries and parses the computed text size of a specified element; the other queries and parses the computed background color of an element. Both functions then scale the resulting value and set the scaled value as an inline style of the element. (These functions do not work in IE8 and earlier: as we’ll discuss below, those versions of IE do not support getComputedStyle().)

Example 16-4. Querying computed styles and setting inline styles

// Scale the text size of element e by the specified factor function scale(e, factor) { // Use the computed style to query the current size of the text var size = parseInt(window.getComputedStyle(e,"").fontSize); // And use the inline style to enlarge that size e.style.fontSize = factor*size + "px"; } // Alter the background color of element e by the specified amount. // Factors > 1 lighten the color and factors < 1 darken it. function scaleColor(e, factor) { var color = window.getComputedStyle(e, "").backgroundColor; // Query var components = color.match(/[\d\.]+/g); // Parse r,g,b, and a components for(var i = 0; i < 3; i++) { // Loop through r, g and b var x = Number(components[i]) * factor; // Scale each one x = Math.round(Math.min(Math.max(x, 0), 255)); // Round and set bounds components[i] = String(x); } if (components.length == 3) // A rgb() color e.style.backgroundColor = "rgb(" + components.join() + ")"; else // A rgba() color e.style.backgroundColor = "rgba(" + components.join() + ")"; }

Computed styles can be tricky, and querying them does not always provide the information you might expect. Consider the font-family property: it accepts a comma-separated list of desired font families for cross-platform portability. When you query the fontFamily property of a computed style, you’re simply getting the value of the most specific font-family style that applies to the element. This may return a value such as「arial,helvetica,sans-serif」, which does not tell you which typeface is actually in use. Similarly, if an element is not absolutely positioned, attempting to query its position and size through the top and left properties of its computed style often returns the value「auto」. This is a perfectly legal CSS value, but it is probably not what you were looking for.

getComputedStyle() is not implemented by IE8 and earlier, but it is expected in IE9. In IE, every HTML element has a currentStyle property whose value is a CSSStyleDeclaration. IE’s currentStyle combines inline styles with stylesheets, but it is not a true computed style because relative values are not converted to absolute values. Querying the properties of IE’s current style can return sizes with relative units like「%」or「em」or colors with imprecise names like「red」.

Although CSS can be used to precisely specify the position and size of document elements, querying the computed style of an element is not the preferred way to determine the element’s size and position. See Querying the Geometry of an Element for a simpler, portable alternative.

Scripting CSS Classes

An alternative to scripting individual CSS styles through the inline style property is to script the value of the HTML class attribute. Changing an element’s class changes the set of stylesheet selectors that apply to the element and can cause multiple CSS properties to change at the same time. Suppose, for example, that you want a way to draw the user’s attention to individual paragraphs (or other elements) of a document. You might start by defining attention-grabbing styles for any elements that have a class name of「attention」:

.attention { /* Styles to grab the user's attention */ background-color: yellow; /* Yellow highlight background */ font-weight: bold; /* Bold text */ border: solid black 2px; /* Black box */ }

The identifier class is a reserved word in JavaScript, so the HTML class attribute is available to JavaScript code using the name className. Here is code that sets and clears the className property of an element to add and remove the「attention」class for that element:

function grabAttention(e) { e.className = "attention"; } function releaseAttention(e) { e.className = ""; }

HTML elements can be members of more than one CSS class and the class attribute holds a space-separated list of class names. The className property has a misleading name: classNames would have been a much better choice. The functions above assume that the className property will specify zero or one class name and do not work when more than one class is in use. If an element already has a class assigned, calling the grabAttention() function for that element will overwrite the existing class.

HTML5 addresses this issue by defining a classList property for every element. The value of this property is known as a DOMTokenList: a read-only array-like object (Array-Like Objects) whose elements contain the individual classnames for the element. More important than its array elements, however, are the methods defined by DOMTokenList. add() and remove() add and remove individual class names from the element’s class attribute. toggle() adds a classname if it is not already present and removes it otherwise. Finally, the contains() method tests whether the class attribute contains a specified classname.

Like other DOM collection types, a DOMTokenList is a「live」representation of the element’s set of classes, not a static snapshot of the classes at the time the classList property is queried. If you obtain a DOMTokenList from the classList property of an element and then change the className property of that element, those changes are immediately visible through the token list. Similarly, any changes you make through the token list are immediately visible through the className property.

At the time of this writing, the classList property is not supported by all current browsers. This important functionality is easy to approximate, however, with code like that of Example 16-5. Using code like this that allows an element’s class attribute to be treated as a set of classnames makes many CSS scripting tasks much easier.

Example 16-5. classList(): treat className as a set of CSS classes

/* * Return the classList property of e, if it has one. * Otherwise, return an object that simulates the DOMTokenList API for e. * The returned object has contains(), add(), remove(), toggle() and toString() * methods for testing and altering the set of classes of the element e. * If the classList property is natively supported, the returned object is * array-like and has length and array index properties. The simulated * DOMTokenList is not array-like, but has a toArray() method that returns * a true-array snapshot of the element's class names. */ function classList(e) { if (e.classList) return e.classList; // Return e.classList if it exists else return new CSSClassList(e); // Otherwise try to fake it } // CSSClassList is a JavaScript class that simulates DOMTokenList function CSSClassList(e) { this.e = e; } // Return true if e.className contains the class c, false otherwise CSSClassList.prototype.contains = function(c) { // Check that c is a valid class name if (c.length === 0 || c.indexOf(" ") != -1) throw new Error("Invalid class name: '" + c + "'"); // Check common cases first var classes = this.e.className; if (!classes) return false; // e has no classes at all if (classes === c) return true; // e has one class that matches exactly // Otherwise, use a RegExp to search for c as a word by itself // \b in a regular expression requires a match at a word boundary. return classes.search("\\b" + c + "\\b") != -1; }; // Add c to the e.className if it is not already present CSSClassList.prototype.add = function(c) { if (this.contains(c)) return; // Do nothing if already present var classes = this.e.className; if (classes && classes[classes.length-1] != " ") c = " " + c; // Add a space if we need one this.e.className += c; // Add c to the className }; // Remove all occurrences of c from e.className CSSClassList.prototype.remove = function(c) { // Make sure c is a valid class name if (c.length === 0 || c.indexOf(" ") != -1) throw new Error("Invalid class name: '" + c + "'"); // Remove all occurances of c as a word, plus any trailing space var pattern = new RegExp("\\b" + c + "\\b\\s*", "g"); this.e.className = this.e.className.replace(pattern, ""); }; // Add c to e.className if it is not already present and return true. // Otherwise, remove all occurrences of c from e.className and return false. CSSClassList.prototype.toggle = function(c) { if (this.contains(c)) { // If e.className contains c this.remove(c); // then remove it. return false; } else { // Otherwise: this.add(c); // add it. return true; } }; // Return e.className itself CSSClassList.prototype.toString = function() { return this.e.className; }; // Return of the names in e.className CSSClassList.prototype.toArray = function() { return this.e.className.match(/\b\w+\b/g) || []; };

Scripting Stylesheets

So far, we’ve seen how to set and query the CSS styles and classes of individual elements. It is also possible to script CSS stylesheets themselves. This is not commonly done, but it can occasionally be useful and this section sketches out the technique.

When scripting stylesheets, there are two kinds of objects you may need to work with. The first kind are the Element objects that represent <style> and <link> elements that contain or reference your stylesheets. These are regular document elements and if you give them id attributes, you can select them with document.getElementById(). The second kind of object is a CSSStyleSheet object that represents the stylesheet itself. The document.styleSheets property is a read-only array-like object containing CSSStyleSheet objects that represent the stylesheets associated with the document. If you set the title attribute of the <style> or <link> element that defines or references the stylesheet, that title will be available as the title property of the corresponding CSSStyleSheet object.

The subsections that follow explain what you can do with these style and link elements and stylesheet objects.

Enabling and Disabling Stylesheets

The simplest stylesheet scripting technique is also the most portable and robust. <style> elements, <link> elements, and CSSStyleSheet objects all define a disabled property that you can query and set in JavaScript. As its name implies, if the disabled property is true, then the stylesheet is disabled and is ignored by the browser.

The disableStylesheet() function below demonstrates this. If passed a number, it treats it as an index into the document.styleSheets array. If passed a string, it treats it as a CSS selector and passes it to document.querySelectorAll() (see Selecting Elements with CSS Selectors), then sets the disabled property of all returned elements:

function disableStylesheet(ss) { if (typeof ss === "number") document.styleSheets[ss].disabled = true; else { var sheets = document.querySelectorAll(ss); for(var i = 0; i < sheets.length; i++) sheets[i].disabled = true; } }

Querying, Inserting and Deleting Stylesheet Rules

In addition to disabling and enabling stylesheets, the CSSStyleSheet object also defines an API for querying, inserting, and deleting the style rules of a stylesheet. IE8 and before implement a slightly different API than the standard API implemented by other browsers.

Manipulating stylesheets directly is not normally a useful thing to do. Instead of editing or adding new rules to a stylesheet, it is typically better to leave your stylesheets static and script the className property of your elements. On the other hand, if you want to allow the user complete control over the styles used on your pages, you might need to dynamically manipulate a stylesheet.

The elements of the document.styleSheets[] array are CSSStyleSheet objects. A CSSStyleSheet object has a cssRules[] array that contains the rules of the stylesheet:

var firstRule = document.styleSheets[0].cssRules[0];

IE uses the property name rules instead of cssRules.

The elements of the cssRules[] or rules[] arrays are CSSRule objects. In the standard API, a CSSRule object may represent any kind of CSS rule, including at-rules such as @import and @page directives. In IE, however, the rules[] array contains only the actual style rules of the stylesheet.

CSSRule objects have two properties that can be used portably. (In the standard API, a rule that is not a style rule will not have these properties defined, and you probably want to skip over it when traversing the stylesheet.) selectorText is the CSS selector for the rule, and style refers to a writable CSSStyleDeclaration object that describes the styles associated with that selector. Recall that CSSStyleDeclaration is the same type used to represent inline and computed styles. You can use this CSSStyleDeclaration object to query the style values or to set new styles for the rule. Often, when traversing a stylesheet, you are interested in the text of the rule rather than a parsed representation of the rule. In this case, use the cssText property of the CSSStyleDeclaration object to obtain the text representation of the rules.

In addition to querying and altering the existing rules of a stylesheet, you can also add rules to and remove rules from a stylesheet. The standard API interface defines insert Rule() and deleteRule() methods for adding and removing rules:

document.styleSheets[0].insertRule("H1 { text-weight: bold; }", 0);

IE does not support insertRule() and deleteRule() but defines largely equivalent addRule() and removeRule() functions. The only real difference (aside from the different names) is that addRule() expects the selector text and styles text as two separate arguments.

The following code loops through the rules of a stylesheet, demonstrating the API by making some dubious changes to the stylesheet:

var ss = document.styleSheets[0]; // Get the first stylesheet var rules = ss.cssRules?ss.cssRules:ss.rules; // Get the stylesheet rules for(var i = 0; i < rules.length; i++) { // Loop through those rules var rule = rules[i]; if (!rule.selectorText) continue; // Skip @import and other nonstyle rules var selector = rule.selectorText; // The selector var ruleText = rule.style.cssText; // The styles, in text form // If the rule applies to h1 elements, apply it to h2 elements as well // Note this only works if the selector is literally "h1" if (selector == "h1") { if (ss.insertRule) ss.insertRule("h2 {" + ruleText + "}", rules.length); else if (ss.addRule) ss.addRule("h2", ruleText, rules.length); } // If the rule sets the text-decoration property, delete it. if (rule.style.textDecoration) { if (ss.deleteRule) ss.deleteRule(i); else if (ss.removeRule) ss.removeRule(i); i--; // Adjust the loop index since the former rule i+1 is now rule i } }

Creating New Stylesheets

Finally, it is possible to create entirely new stylesheets and add them to your document. In most browsers, this is done with standard DOM techniques: just create a new <style> element and insert it into the document head, then use its innerHTML property to set stylesheet content. In IE8 and before, however, a new CSSStyleSheet object is created with the nonstandard method document.createStyleSheet(), and stylesheet text is specified using the cssText property. Example 16-6 demonstrates.

Example 16-6. Creating a new stylesheet

// Add a stylesheet to the document and populate it with the specified styles. // The styles argument can be a string or an object. If it is a string, it // is treated as the text of the stylesheet. If it is an object, then each // property defines a style rule to be added to the stylesheet. Property // names are selectors and their values are the corresponding styles function addStyles(styles) { // First, create a new stylesheet var styleElt, styleSheet; if (document.createStyleSheet) { // If the IE API is defined, use it styleSheet = document.createStyleSheet(); } else { var head = document.getElementsByTagName("head")[0] styleElt = document.createElement("style"); // New <style> element head.appendChild(styleElt); // Insert it into <head> // Now the new stylesheet should be the last one styleSheet = document.styleSheets[document.styleSheets.length-1] } // Now insert the styles into it if (typeof styles === "string") { // The argument is stylesheet text if (styleElt) styleElt.innerHTML = styles; else styleSheet.cssText = styles; // The IE API } else { // The argument is an object of individual rules to insert var i = 0; for(selector in styles) { if (styleSheet.insertRule) { var rule = selector + " {" + styles[selector] + "}"; styleSheet.insertRule(rule, i++); } else { styleSheet.addRule(selector, styles[selector], i++); } } } }

Chapter 17. Handling Events

Client-side JavaScript programs use an asynchronous event-driven programming model (introduced in Event-Driven JavaScript). In this style of programming, the web browser generates an event whenever something interesting happens to the document or browser or to some element or object associated with it. For example, the web browser generates an event when it finishes loading a document, when the user moves the mouse over a hyperlink, or when the user strikes a key on the keyboard. If a JavaScript application cares about a particular type of event, it can register one or more functions to be invoked when events of that type occur. Note that this is not unique to web programming: all applications with graphical user interfaces are designed this way—they sit around waiting for something to happen (i.e., they wait for events to occur), and then they respond.

Note that the word event is not itself a technical word that requires definition. Events are simply occurrences that a web browser will notify your program about. Events are not JavaScript objects and have no manifestation in the source code of your program. There are, of course, a number of event-related objects that do appear in your source code, and these do require technical explanation. We’ll begin this chapter, therefore, with some important definitions.

The event type is a string that specifies what kind of event occurred. The type「mousemove」, for example, means that the user moved the mouse. The type「keydown」means that a key on the keyboard was pushed down. And the type「load」means that a document (or some other resource) has finished loading from the network. Because the type of an event is just a string, it is sometimes called an event name, and indeed, we use this name to identify the specific kind of event we’re talking about. Modern web browsers support many event types. Types of Events has an overview.

The event target is the object on which the event occurred or with which the event is associated. When we speak of an event, we must specify both the type and the target. A load event on a Window, for example, or a click event on a <button> Element. Window, Document, and Element objects are the most common event targets in client-side JavaScript applications, but some events are triggered on other kinds of objects. In Chapter 18 we’ll see a readystatechange event that is triggered on an XMLHttpRequest object, for example.

An event handler or event listener is a function that handles or responds to an event.[37] Applications register their event handler functions with the web browser, specifying an event type and an event target. When an event of the specified type occurs on the specified target, the browser invokes the handler. When event handlers are invoked for an object, we sometimes say that the browser has「fired」,「triggered」, or「dispatched」the event. There are a number of ways to register event handlers, and the details of handler registration and invocation are explained in Registering Event Handlers and Event Handler Invocation.

An event object is an object that is associated with a particular event and contains details about that event. Event objects are passed as an argument to the event handler function (except in IE8 and before where they are sometimes only available through the global variable event). All event objects have a type property that specifies the event type and a target property that specifies the event target. (In IE8 and before, use srcElement instead of target.) Each event type defines a set of properties for its associated event object. The object associated with a mouse event includes the coordinates of the mouse pointer, for example, and the object associated with a keyboard event contains details about the key that was pressed and the modifier keys that were held down. Many event types define only a few standard properties—such as type and target—and do not carry much other useful information. For those events it is the simple occurrence of the event, not the event details, that matter. This chapter does not have a specific section covering the Event object. Instead, it explains event object properties when describing specific event types. You can read more about the event object under the name Event in the reference section.[38]

Event propagation is the process by which the browser decides which objects to trigger event handlers on. For events that are specific to a single object (such as the load event on the Window object), no propagation is required. When certain kinds of events occur on document elements, however, they propagate or「bubble」up the document tree. If the user moves the mouse over a hyperlink, the mousemove event is first fired on the <a> element that defines that link. Then it is fired on the containing elements: perhaps a <p> element, a <div> element, and the Document object itself. It is sometimes more convenient to register a single event handler on a Document or other container element than to register handlers on each individual element you’re interested in. An event handler can stop the propagation of an event, so that it will not continue to bubble and will not trigger handlers on containing elements. Handlers do this by invoking a method or setting a property of the event object. Event propagation is covered in detail in Event Propagation.

In another form of event propagation, known as event capturing, handlers specially registered on container elements have the opportunity to intercept (or「capture」) events before they are delivered to their actual target. Event capturing is not supported by IE8 and earlier, and is not, therefore, commonly used. The ability to capture or「grab」mouse events is required when processing mouse drag events, however, and we’ll see how to do this in Example 17-2.

Some events have default actions associated with them. When a click event occurs on a hyperlink, for example, the default action is for the browser to follow the link and load a new page. Event handlers can prevent this default action by returning an appropriate value, invoking a method of the event object, or by setting a property of the event object. This is sometimes called「canceling」the event and is covered in Event Cancellation.

With those terms defined, we can now move on to study events and event handling in detail. The first section that follows is an overview of the many event types supported by web browsers. It doesn’t cover any single kind of event in detail, but it lets you know what kinds of events are available for use in your web applications. This section includes cross-references to other parts of this book that demonstrate some of the events in action.

After the introductory section on event types, the next two sections explain how to register event handlers and how the browser invokes those event handlers. Because of the historical evolution of the JavaScript event model and because of IE’s lack of standards support prior to IE9, both of these topics are more complicated than you might expect.

The chapter ends with a series of examples that demonstrate how to work with a specific types of events. These event-type-specific sections cover:

Document loading and readiness events

Mouse events

Mouse wheel events

Drag-and-drop events

Key events

Text input events

Types of Events

In the early days of the Web, client-side programmers made do with only a small set of events:「load」,「click」,「mouseover」, and the like. These legacy event types are well supported by all browsers and are the subject of Legacy Event Types. As the web platform has grown to include more powerful APIs, the set of events has grown large. No single standard defines a complete set of events, and at the time of this writing, the number of events supported by browsers is growing rapidly. These new events come from three sources:

The DOM Level 3 Events specification, which after a long period of inactivity is being actively worked on under the auspices of the W3C. DOM events are covered in DOM Events.

Many new APIs in the HTML5 specification (and related spin-off specifications) define new events for things like history management, drag-and-drop, cross-document messaging, and audio and video playback. HTML5 Events gives an overview of these events.

The advent of touch-based and JavaScript-enabled mobile devices, such as the iPhone, have required the definition of new touch and gesture event types. See Touchscreen and Mobile Events for some Apple-specific examples.

Note that many of these new event types are not yet widely implemented and are defined by standards that are still in draft stage. The subsections that follow provide an overview of the events, but do not document each one in detail. The rest of this chapter covers the event handling model comprehensively and includes lots of examples of working with events that are well supported. If you understand how to work with events generally, you will be able to easily handle new event types as new web APIs are defined and implemented.

Event Categories

Events can be grouped into some general categories, and knowing what these categories are will help you to understand and organize the long list of events that follows:

Device-dependent input events

These are events that are directly tied to a specific input device, such as the mouse or keyboard. They include legacy event types such as「mousedown」,「mousemove」,「mouseup」,「keydown」,「keypress」, and「keyup」and also new touch-specific events like「touchmove」and「gesturechange」.

Device-independent input events

These are input events that are not directly tied to a specific input device. The click event, for example, indicates that a link or button (or other document element) has been activated. This is often done via a mouse click, but it could also be done by keyboard or (on touch-sensitive devices) by gesture. The textinput event (which is not yet widely implemented) is a device-independent alternative to the keypress event and supports keyboard input as well as alternatives such as cut-and-paste and handwriting recognition.

User interface events

UI events are higher-level events, often on HTML form elements that define a user interface for a web application. They include the focus event (when a text input field gains keyboard focus), the change event when the user changes the value displayed by a form element, and the submit event when the user clicks a Submit button in a form.

State-change events

