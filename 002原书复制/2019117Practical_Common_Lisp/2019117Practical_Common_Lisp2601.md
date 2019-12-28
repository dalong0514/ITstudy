ID3V2> (frames *id3*) (#<TEXT-INFO-FRAME-V2.2 @ #x73d04cca> #<TEXT-INFO-FRAME-V2.2 @ #x73d04dba> #<TEXT-INFO-FRAME-V2.2 @ #x73d04ea2> #<TEXT-INFO-FRAME-V2.2 @ #x73d04f9a> #<TEXT-INFO-FRAME-V2.2 @ #x73d05082> #<TEXT-INFO-FRAME-V2.2 @ #x73d0516a> #<TEXT-INFO-FRAME-V2.2 @ #x73d05252> #<TEXT-INFO-FRAME-V2.2 @ #x73d0533a> #<COMMENT-FRAME-V2.2 @ #x73d0543a> #<COMMENT-FRAME-V2.2 @ #x73d05612> #<COMMENT-FRAME-V2.2 @ #x73d0586a>)

Now suppose you want to extract the song title. It's probably in one of those frames, but to find it, you need to find the frame with the "TT2" identifier. Well, you can check easily enough to see if the tag contains such a frame by extracting all the identifiers like this:

ID3V2> (mapcar #'id (frames *id3*)) ("TT2" "TP1" "TAL" "TRK" "TPA" "TYE" "TCO" "TEN" "COM" "COM" "COM")

There it is, the first frame. However, there's no guarantee it'll always be the first frame, so you should probably look it up by identifier rather than position. That's also straightforward using the FIND function.

ID3V2> (find "TT2" (frames *id3*) :test #'string= :key #'id) #<TEXT-INFO-FRAME-V2.2 @ #x73d04cca>

Now, to get at the actual information in the frame, do this:

ID3V2> (information (find "TT2" (frames *id3*) :test #'string= :key #'id)) "Byla Cesta^@"

Whoops. That ^@ is how Emacs prints a null character. In a maneuver reminiscent of the kludge that turned ID3v1 into ID3v1.1, the information slot of a text information frame, though not officially a null-terminated string, can contain a null, and ID3 readers are supposed to ignore any characters after the null. So, you need a function that takes a string and returns the contents up to the first null character, if any. That's easy enough using the +null+ constant from the binary data library.

(defun upto-null (string) (subseq string 0 (position +null+ string)))

Now you can get just the title.

ID3V2> (upto-null (information (find "TT2" (frames *id3*) :test #'string= :key #'id))) "Byla Cesta"

You could just wrap that code in a function named song that takes an id3-tag as an argument, and you'd be done. However, the only difference between this code and the code you'll use to extract the other pieces of information you'll need (such as the album name, the artist, and the genre) is the identifier. So, it's better to split up the code a bit. For starters, you can write a function that just finds a frame given an id3-tag and an identifier like this:

(defun find-frame (id3 id) (find id (frames id3) :test #'string= :key #'id)) ID3V2> (find-frame *id3* "TT2") #<TEXT-INFO-FRAME-V2.2 @ #x73d04cca>

Then the other bit of code, the part that extracts the information from a text-info-frame, can go in another function.

(defun get-text-info (id3 id) (let ((frame (find-frame id3 id))) (when frame (upto-null (information frame))))) ID3V2> (get-text-info *id3* "TT2") "Byla Cesta"

Now the definition of song is just a matter of passing the right identifier.

(defun song (id3) (get-text-info id3 "TT2")) ID3V2> (song *id3*) "Byla Cesta"

However, this definition of song works only with version 2.2 tags since the identifier changed from "TT2" to "TIT2" between version 2.2 and version 2.3. And all the other tags changed too. Since the user of this library shouldn't have to know about different versions of the ID3 format to do something as simple as get the song title, you should probably handle those details for them. A simple way is to change find-frame to take not just a single identifier but a list of identifiers like this:

(defun find-frame (id3 ids) (find-if #'(lambda (x) (find (id x) ids :test #'string=)) (frames id3)))

Then change get-text-info slightly so it can take one or more identifiers using a &rest parameter.

(defun get-text-info (id3 &rest ids) (let ((frame (find-frame id3 ids))) (when frame (upto-null (information frame)))))

Then the change needed to allow song to support both version 2.2 and version 2.3 tags is just a matter of adding the version 2.3 identifier.

(defun song (id3) (get-text-info id3 "TT2" "TIT2"))

Then you just need to look up the appropriate version 2.2 and version 2.3 frame identifiers for any fields for which you want to provide an accessor function. Here are the ones you'll need in Chapter 27:

(defun album (id3) (get-text-info id3 "TAL" "TALB")) (defun artist (id3) (get-text-info id3 "TP1" "TPE1")) (defun track (id3) (get-text-info id3 "TRK" "TRCK")) (defun year (id3) (get-text-info id3 "TYE" "TYER" "TDRC")) (defun genre (id3) (get-text-info id3 "TCO" "TCON"))

The last wrinkle is that the way the genre is stored in the TCO or TCON frames isn't always human readable. Recall that in ID3v1, genres were stored as a single byte that encoded a particular genre from a fixed list. Unfortunately, those codes live on in ID3v2--if the text of the genre frame is a number in parentheses, the number is supposed to be interpreted as an ID3v1 genre code. But, again, users of this library probably won't care about that ancient history. So, you should provide a function that automatically translates the genre. The following function uses the genre function just defined to extract the actual genre text and then checks whether it starts with a left parenthesis, decoding the version 1 genre code with a function you'll define in a moment if it does:

(defun translated-genre (id3) (let ((genre (genre id3))) (if (and genre (char= #\( (char genre 0))) (translate-v1-genre genre) genre)))

Since a version 1 genre code is effectively just an index into an array of standard names, the easiest way to implement translate-v1-genre is to extract the number from the genre string and use it as an index into an actual array.

(defun translate-v1-genre (genre) (aref *id3-v1-genres* (parse-integer genre :start 1 :junk-allowed t)))

Then all you need to do is to define the array of names. The following array of names includes the 80 official version 1 genres plus the genres created by the authors of Winamp:

(defparameter *id3-v1-genres* #( ;; These are the official ID3v1 genres. "Blues" "Classic Rock" "Country" "Dance" "Disco" "Funk" "Grunge" "Hip-Hop" "Jazz" "Metal" "New Age" "Oldies" "Other" "Pop" "R&B" "Rap" "Reggae" "Rock" "Techno" "Industrial" "Alternative" "Ska" "Death Metal" "Pranks" "Soundtrack" "Euro-Techno" "Ambient" "Trip-Hop" "Vocal" "Jazz+Funk" "Fusion" "Trance" "Classical" "Instrumental" "Acid" "House" "Game" "Sound Clip" "Gospel" "Noise" "AlternRock" "Bass" "Soul" "Punk" "Space" "Meditative" "Instrumental Pop" "Instrumental Rock" "Ethnic" "Gothic" "Darkwave" "Techno-Industrial" "Electronic" "Pop-Folk" "Eurodance" "Dream" "Southern Rock" "Comedy" "Cult" "Gangsta" "Top 40" "Christian Rap" "Pop/Funk" "Jungle" "Native American" "Cabaret" "New Wave" "Psychadelic" "Rave" "Showtunes" "Trailer" "Lo-Fi" "Tribal" "Acid Punk" "Acid Jazz" "Polka" "Retro" "Musical" "Rock & Roll" "Hard Rock" ;; These were made up by the authors of Winamp but backported into ;; the ID3 spec. "Folk" "Folk-Rock" "National Folk" "Swing" "Fast Fusion" "Bebob" "Latin" "Revival" "Celtic" "Bluegrass" "Avantgarde" "Gothic Rock" "Progressive Rock" "Psychedelic Rock" "Symphonic Rock" "Slow Rock" "Big Band" "Chorus" "Easy Listening" "Acoustic" "Humour" "Speech" "Chanson" "Opera" "Chamber Music" "Sonata" "Symphony" "Booty Bass" "Primus" "Porn Groove" "Satire" "Slow Jam" "Club" "Tango" "Samba" "Folklore" "Ballad" "Power Ballad" "Rhythmic Soul" "Freestyle" "Duet" "Punk Rock" "Drum Solo" "A capella" "Euro-House" "Dance Hall" ;; These were also invented by the Winamp folks but ignored by the ;; ID3 authors. "Goa" "Drum & Bass" "Club-House" "Hardcore" "Terror" "Indie" "BritPop" "Negerpunk" "Polsk Punk" "Beat" "Christian Gangsta Rap" "Heavy Metal" "Black Metal" "Crossover" "Contemporary Christian" "Christian Rock" "Merengue" "Salsa" "Thrash Metal" "Anime" "Jpop" "Synthpop"))

Once again, it probably feels like you wrote a ton of code in this chapter. But if you put it all in a file, or if you download the version from this book's Web site, you'll see it's just not that many lines--most of the pain of writing this library stems from having to understand the intricacies of the ID3 format itself. Anyway, now you have a major piece of what you'll turn into a streaming MP3 server in Chapters 27, 28, and 29. The other major bit of infrastructure you'll need is a way to write server-side Web software, the topic of the next chapter.

* * *

1Ripping is the process by which a song on an audio CD is converted to an MP3 file on your hard drive. These days most ripping software also automatically retrieves information about the songs being ripped from online databases such as Gracenote (née the Compact Disc Database [CDDB]) or FreeDB, which it then embeds in the MP3 files as ID3 tags.

2Almost all file systems provide the ability to overwrite existing bytes of a file, but few, if any, provide a way to add or remove data at the beginning or middle of a file without having to rewrite the rest of the file. Since ID3 tags are typically stored at the beginning of a file, to rewrite an ID3 tag without disturbing the rest of the file you must replace the old tag with a new tag of exactly the same length. By writing ID3 tags with a certain amount of padding, you have a better chance of being able to do so--if the new tag has more data than the original tag, you use less padding, and if it's shorter, you use more.

3The frame data following the ID3 header could also potentially contain the illegal sequence. That's prevented using a different scheme that's turned on via one of the flags in the tag header. The code in this chapter doesn't account for the possibility that this flag might be set; in practice it's rarely used.

4In ID3v2.4, UCS-2 is replaced by the virtually identical UTF-16, and UTF-16BE and UTF-8 are added as additional encodings.

5The 2.4 version of the ID3 format also supports placing a footer at the end of a tag, which makes it easier to find a tag appended to the end of a file.

6Character streams support two functions, PEEK-CHAR and UNREAD-CHAR, either of which would be a perfect solution to this problem, but binary streams support no equivalent functions.

7If a tag had an extended header, you could use this value to determine where the frame data should end. However, if the extended header isn't used, you'd have to use the old algorithm anyway, so it's not worth adding code to do it another way.

8These flags, in addition to controlling whether the optional fields are included, can affect the parsing of the rest of the tag. In particular, if the seventh bit of the flags is set, then the actual frame data is compressed using the zlib algorithm, and if the sixth bit is set, the data is encrypted. In practice these options are rarely, if ever, used, so you can get away with ignoring them for now. But that would be an area you'd have to address to make this a production-quality ID3 library. One simple half solution would be to change find-frame-class to accept a second argument and pass it the flags; if the frame is compressed or encrypted, you could instantiate a generic frame to hold the data.

9Ensuring that kind of interfield consistency would be a fine application for :after methods on the accessor generic functions. For instance, you could define this :after method to keep size in sync with the information string:

(defmethod (setf information) :after (value (frame text-info-frame)) (declare (ignore value)) (with-slots (encoding size information) frame (setf size (encoded-string-length information encoding nil))))

Copyright Š 2003-2005, Peter Seibel

26. Practical: Web Programming with AllegroServe

In this chapter you'll look at one way to develop Web-based programs in Common Lisp, using the open-source AllegroServe Web server. This isn't meant as a full introduction to AllegroServe. And I'm certainly not going to cover anything more than a tiny corner of the larger topic of Web programming. My goal here is to cover enough of the basics of using AllegroServe that you'll be able, in Chapter 29, to develop an application for browsing a library of MP3 files and streaming them to an MP3 client. Similarly, this chapter will serve as a brief introduction to Web programming for folks new to the topic.

A 30-Second Intro to Server-Side Web Programming

While Web programming today typically involves quite a number of software frameworks and different protocols, the core bits of Web programming haven't changed much since they were invented in the early 1990s. For simple applications, such as the one you'll write in Chapter 29, you need to understand only a few key concepts, so I'll review them quickly here. Experienced Web programmers can skim or skip the rest of this section.1

To start, you need to understand the roles the Web browser and the Web server play in Web programming. While a modern browser comes with a lot of bells and whistles, the core functionality of a Web browser is to request Web pages from a Web server and then render them. Typically those pages will be written in the Hypertext Markup Language (HTML), which tells the browser how to render the page, including where to insert inline images and links to other Web pages. HTML consists of text marked up with tags that give the text a structure that the browser uses when rendering the page. For instance, a simple HTML document looks like this:

<html> <head> <title>Hello</title> </head> <body> <p>Hello, world!</p> <p>This is a picture: <img src="some-image.gif"></p> <p>This is a <a href="another-page.html">link</a> to another page.</p> </body> </html>

Figure 26-1 shows how the browser renders this page.

Figure 26-1. Sample Web page

The browser and server communicate using a protocol called the Hypertext Transfer Protocol (HTTP). While you don't need to worry about the details of the protocol, it's worth understanding that it consists entirely of a sequence of requests initiated by the browser and responses generated by the server. That is, the browser connects to the Web server and sends a request that includes, at the least, the desired URL and the version of HTTP that the browser speaks. The browser can also include data in its request; that's how the browser submits HTML forms to the server.

To reply to a request, the server sends a response made up of a set of headers and a body. The headers contain information about the body, such as what type of data it is (for instance, HTML, plain text, or an image), and the body is the data itself, which is then rendered by the browser. The server can also send an error response telling the browser that its request couldn't be answered for some reason.

And that's pretty much it. Once the browser has received the complete response from the server, there's no communication between the browser and the server until the next time the browser decides to request a page from the server.2 This is the main constraint of Web programming--there's no way for code running on the server to affect what the user sees in their browser unless the browser issues a new request to the server.3

Some Web pages, called static pages, are simply HTML files stored on the Web server and served up when requested by the browser. Dynamic pages, on the other hand, consist of HTML generated each time the page is requested by a browser. For instance, a dynamic page might be generated by querying a database and then constructing HTML to represent the results of the query.4

When generating its response to a request, server-side code has four main pieces of information to act on. The first piece of information is the requested URL. Typically, however, the URL is used by the Web server itself to determine what code is responsible for generating the response. Next, if the URL contains a question mark, everything after the question mark is considered to be a query string, which is typically ignored by the Web server except that it makes it available to the code generating the response. Most of the time the query string contains a set of key/value pairs. The request from the browser can also contain post data, which also usually consists of key/value pairs. Post data is typically used to submit HTML forms. The key/value pairs supplied in either the query string or the post data are collectively called the query parameters.

Finally, in order to string together a sequence of individual requests from the same browser, code running in the server can set a cookie, sending a special header in its response to the browser that contains a bit of opaque data called a cookie. After a cookie is set by a particular server, the browser will send the cookie with each request it sends to that server. The browser doesn't care about the data in the cookie--it just echoes it back to the server for the server-side code to interpret however it wants.

These are the primitive elements on top of which 99 percent of server-side Web programming is built. The browser sends a request, the server finds some code to handle the request and runs it, and the code uses query parameters and cookies to determine what to do.

AllegroServe

You can serve Web content using Common Lisp in a number of ways; there are at least three open-source Web servers written in Common Lisp as well as plug-ins such as mod_lisp5 and Lisplets6 that allow the Apache Web server or any Java Servlet container to delegate requests to a Lisp server running in a separate process.

For this chapter, you'll use a version of the open-source Web server AllegroServe, originally written by John Foderaro at Franz Inc.. AllegroServe is included in the version of Allegro available from Franz for use with this book. If you're not using Allegro, you can use PortableAllegroServe, a friendly fork of the AllegroServe code base, which includes an Allegro compatibility layer that allows PortableAllegroServe to run on most Common Lisps. The code you'll write in this chapter and in Chapter 29 should run in both vanilla AllegroServe and PortableAllegroServe.

AllegroServe provides a programming model similar in spirit to Java Servlets--each time a browser requests a page, AllegroServe parses the request and looks up an object, called an entity, which handles the request. Some entity classes provided as part of AllegroServe know how to serve static content--either individual files or the contents of a directory tree. Others, the ones I'll spend most of this chapter discussing, run arbitrary Lisp code to generate the response.7

But before I get to that, you need to know how to start AllegroServe and set it up to serve a few files. The first step is to load the AllegroServe code into your Lisp image. In Allegro, you can simply type (require :aserve). In other Lisps (or in Allegro), you can load PortableAllegroServe by loading the file INSTALL.lisp at the top of the portableaserve directory tree. Loading AllegroServe will create three new packages, NET.ASERVE, NET.HTML.GENERATOR, and NET.ASERVE.CLIENT.8

After loading the server, you start it with the function start in the NET.ASERVE package. To have easy access to the symbols exported from NET.ASERVE, from COM.GIGAMONKEYS.HTML (a package I'll discuss in a moment), and from the rest of Common Lisp, you should create a new package to play in like this:

CL-USER> (defpackage :com.gigamonkeys.web (:use :cl :net.aserve :com.gigamonkeys.html)) #<The COM.GIGAMONKEYS.WEB package>

Now switch to that package with this IN-PACKAGE expression:

CL-USER> (in-package :com.gigamonkeys.web) #<The COM.GIGAMONKEYS.WEB package> WEB>

Now you can use the exported names from NET.ASERVE without qualification. The function start starts the server. It takes quite a number of keyword parameters, but the only one you need to pass is :port, which specifies the port to listen on. You should probably use a high port such as 2001 instead of the default port for HTTP servers, 80, because on Unix-derived operating systems only the root user can listen on ports below 1024. To run AllegroServe listening on port 80 on Unix, you'd need to start Lisp as root and then use the :setuid and :setgid parameters to tell start to switch its identity after opening the port. You can start a server listening on port 2001 like this:

WEB> (start :port 2001) #<WSERVER port 2001 @ #x72511c72>

The server is now running in your Lisp. It's possible you'll get an error that says something about "port already in use" when you try to start the server. This means port 2001 is already in use by some other server on your machine. In that case, the simplest fix is to use a different port, supplying a different argument to start and then using that value instead of 2001 in the URLs used throughout this chapter.

You can continue to interact with Lisp via the REPL because AllegroServe starts its own threads to handle requests from browsers. This means, among other things, that you can use the REPL to get a view into the guts of your server while it's running, which makes debugging and testing a lot easier than if the server is a complete black box.

Assuming you're running Lisp on the same machine as your browser, you can check that the server is up and running by pointing your browser at http://localhost:2001/. At this point you should get a page-not-found error message in the browser since you haven't published anything yet. But the error message will be from AllegroServe; it'll say so at the bottom of the page. On the other hand, if the browser displays an error dialog that says something like "The connection was refused when attempting to contact localhost:2001," it means either that the server isn't running or that you started it with a different port than 2001.

Now you can publish some files. Suppose you have a file hello.html in the directory /tmp/html with the following contents:

<html> <head> <title>Hello</title> </head> <body> <p>Hello, world!</p> </body> </html>

You can publish it individually with the publish-file function.

WEB> (publish-file :path "/hello.html" :file "/tmp/html/hello.html") #<NET.ASERVE::FILE-ENTITY @ #x725eddea>

The :path argument is the path that will appear in the URL requested by the browser, while the :file argument is the name of the file in the file system. After evaluating the publish-file expression, you can point your browser to http://localhost:2001/hello.html, and it should display a page something like Figure 26-2.

Figure 26-2. http://localhost:2001/hello.html

You could also publish a whole directory tree of files using the publish-directory function. First let's clear out the already published entity with the following call to publish-file:

WEB> (publish-file :path "/hello.html" :remove t) NIL

Now you can publish the whole /tmp/html/ directory (and all its subdirectories) with the publish-directory function.

WEB> (publish-directory :prefix "/" :destination "/tmp/html/") #<NET.ASERVE::DIRECTORY-ENTITY @ #x72625aa2>

In this case, the :prefix argument specifies the beginning of the path part of URLs that should be handled by this entity. Thus, if the server receives a request for http://localhost:2001/foo/bar.html, the path is /foo/bar.html, which starts with /. This path is then translated to a filename by replacing the prefix, /, with the destination, /tmp/html/. Thus, the URL http://localhost:2001/hello.html will still be translated into a request for the file /tmp/html/hello.html.

Generating Dynamic Content with AllegroServe

Publishing entities that generate dynamic content is nearly as simple as publishing static content. The functions publish and publish-prefix are the dynamic analogs of publish-file and publish-directory. The basic idea of these two functions is that you publish a function that will be called to generate the response to a request for either a specific URL or any URL with a given prefix. The function will be called with two arguments: an object representing the request and the published entity. Most of time you don't need to do anything with the entity object except to pass it along to a couple macros I'll discuss in a moment. On the other hand, you'll use the request object to obtain information submitted by the browser--query parameters included in the URL or data posted using an HTML form.

For a trivial example of using a function to generate dynamic content, let's write a function that generates a page with a different random number each time it's requested.

(defun random-number (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (format (request-reply-stream request) "<html>~@ <head><title>Random</title></head>~@ <body>~@ <p>Random number: ~d</p>~@ </body>~@ </html>~@ " (random 1000)))))

The macros with-http-response and with-http-body are part of AllegroServe. The former starts the process of generating an HTTP response and can be used, as here, to specify things such as the type of content that will be returned. It also handles various parts of HTTP such as dealing with If-Modified-Since requests. The with-http-body actually sends the HTTP response headers and then executes its body, which should contain code that generates the content of the reply. Within with-http-response but before the with-http-body, you can add or change HTTP headers to be sent in the reply. The function request-reply-stream is also part of AllegroServe and returns the stream to which you should write output intended to be sent to the browser.

As this function shows, you can just use FORMAT to print HTML to the stream returned by request-reply-stream. In the next section, I'll show you more convenient ways to programmatically generate HTML.9

Now you're ready to publish this function.

WEB> (publish :path "/random-number" :function 'random-number) #<COMPUTED-ENTITY @ #x7262bab2>

As it does in the publish-file function, the :path argument specifies the path part of the URL that will result in this function being invoked. The :function argument specifies either the name or an actual function object. Using the name of a function, as shown here, allows you to redefine the function later without republishing and have AllegroServe use the new function definition. After evaluating the call to publish, you can point your browser at http:// localhost:2001/random-number to get a page with a random number on it, as shown in Figure 26-3.

Figure 26-3. http://localhost:2001/random-number

Generating HTML

Although using FORMAT to emit HTML works fine for the simple pages I've discussed so far, as you start building more elaborate pages it'd be nice to have a more concise way to generate HTML. Several libraries are available for generating HTML from an s-expression representation including one, htmlgen, that's included with AllegroServe. In this chapter you'll use a library called FOO,10 which is loosely modeled on Franz's htmlgen and whose implementation you'll look at in more detail in Chapters 30 and 31. For now, however, you just need to know how to use FOO.

Generating HTML from within Lisp is quite natural since s-expressions and HTML are essentially isomorphic. You can represent HTML elements with s-expressions by treating each element in HTML as a list "tagged" with an appropriate first element, such as a keyword symbol of the same name as the HTML tag. Thus, the HTML <p>foo</p> is represented by the s-expression (:p "foo"). Because HTML elements nest the same way lists in s-expressions do, this scheme extends to more complex HTML. For instance, this HTML:

<html> <head> <title>Hello</title> </head> <body> <p>Hello, world!</p> </body> </html>

could be represented with the following s-expression:

(:html (:head (:title "Hello")) (:body (:p "Hello, world!")))

HTML elements with attributes complicate things a bit but not in an insurmountable way. FOO supports two ways of including attributes in a tag. One is to simply follow the first item of the list with keyword/value pairs. The first element that follows a keyword/value pair that's not itself a keyword symbol marks the beginning of the element's contents. Thus, you'd represent this HTML:

<a href="foo.html">This is a link</a>

with the following s-expression:

(:a :href "foo.html" "This is a link")

The other syntax FOO supports is to group the tag name and attributes into their own list like this:

((:a :href "foo.html") "This is link.")

FOO can use the s-expression representation of HTML in two ways. The function emit-html takes an HTML s-expression and outputs the corresponding HTML.

WEB> (emit-html '(:html (:head (:title "Hello")) (:body (:p "Hello, world!")))) <html> <head> <title>Hello</title> </head> <body> <p>Hello, world!</p> </body> </html> T

However, emit-html isn't always the most efficient way to generate HTML because its argument must be a complete s-expression representation of the HTML to be generated. While it's easy to build such a representation, it's not always particularly efficient. For instance, suppose you wanted to make an HTML page containing a list of 10,000 random numbers. You could build the s-expression using a backquote template and then pass it to emit-html like this:

(emit-html `(:html (:head (:title "Random numbers")) (:body (:h1 "Random numbers") (:p ,@(loop repeat 10000 collect (random 1000) collect " ")))))

However, this has to build a tree containing a 10,000-element list before it can even start emitting HTML, and the whole s-expression will become garbage as soon as the HTML is emitted. To avoid this inefficiency, FOO also provides a macro html, which allows you to embed bits of Lisp code in the middle of an HTML s-expression.

Literal values such as strings and numbers in the input to html are interpolated into the output HTML. Likewise, symbols are treated as variable references, and code is generated to emit their value at runtime. Thus, both of these:

(html (:p "foo")) (let ((x "foo")) (html (:p x)))

will emit the following:

<p>foo</p>

List forms that don't start with a keyword symbol are assumed to be code and are embedded in the generated code. Any values the embedded code returns will be ignored, but the code can emit more HTML by calling html itself. For instance, to emit the contents of a list in HTML, you might write this:

(html (:ul (dolist (item (list 1 2 3)) (html (:li item)))))

which will emit the following HTML:

<ul> <li>1</li> <li>2</li> <li>3</li> </ul>

If you want to emit the value of a list form, you must wrap it in the pseudotag :print. Thus, this expression:

(html (:p (+ 1 2)))

generates this HTML after computing and discarding the value 3:

<p></p>

To emit the 3, you must write this:

(html (:p (:print (+ 1 2))))

Or you could compute the value and store it in a variable outside the call to html like this:

(let ((x (+ 1 2))) (html (:p x)))

Thus, you can use the html macro to generate the list of random numbers like this:

(html (:html (:head (:title "Random numbers")) (:body (:h1 "Random numbers") (:p (loop repeat 10 do (html (:print (random 1000)) " "))))))

The macro version will be quite a bit more efficient than the emit-html version. Not only do you never have to generate an s-expression representing the whole page, also much of the work that emit-html does at runtime to interpret the s-expression will be done once, when the macro is expanded, rather than every time the code is run.

You can control where the output generated by both html and emit-html is sent with the macro with-html-output, which is part of the FOO library. Thus, you can use the with-html-output and html macros from FOO to rewrite random-number like this:

(defun random-number (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (with-html-output ((request-reply-stream request)) (html (:html (:head (:title "Random")) (:body (:p "Random number: " (:print (random 1000))))))))))

HTML Macros

Another feature of FOO is that it allows you to define HTML "macros" that can translate arbitrary forms into HTML s-expressions that the html macro understands. For instance, suppose you frequently find yourself writing pages of this form:

(:html (:head (:title "Some title")) (:body (:h1 "Some title") ... stuff ...))

You could define an HTML macro to capture that pattern like this:

(define-html-macro :standard-page ((&key title) &body body) `(:html (:head (:title ,title)) (:body (:h1 ,title) ,@body)))

Now you can use the "tag" :standard-page in your s-expression HTML, and it'll be expanded before being interpreted or compiled. For instance, the following:

(html (:standard-page (:title "Hello") (:p "Hello, world.")))

generates the following HTML:

<html> <head> <title>Hello</title> </head> <body> <h1>Hello</h1> <p>Hello, world.</p> </body> </html>

Query Parameters

Of course, generating HTML output is only half of Web programming. The other thing you need to do is get input from the user. As I discussed in the "A 30-Second Intro to Server-Side Web Programming" section, when a browser requests a page from a Web server, it can send query parameters in the URL and post data, both of which act as input to the server-side code.

