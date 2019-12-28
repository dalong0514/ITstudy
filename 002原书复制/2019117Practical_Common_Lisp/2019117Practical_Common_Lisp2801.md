Querying the Database

Once you've loaded your database with data, you'll need a way to query it. For the MP3 application you'll need a slightly more sophisticated query function than you wrote in Chapter 3. This time around you want not only to be able to select rows matching particular criteria but also to limit the results to particular columns, to limit the results to unique rows, and perhaps to sort the rows by particular columns. In keeping with the spirit of relational database theory, the result of a query will be a new table object containing the desired rows and columns.

The query function you'll write, select, is loosely modeled on the SELECT statement from Structured Query Language (SQL). It'll take five keyword parameters: :from, :columns, :where, :distinct, and :order-by. The :from argument is the table object you want to query. The :columns argument specifies which columns should be included in the result. The value should be a list of column names, a single column name, or a T, the default, meaning return all columns. The :where argument, if provided, should be a function that accepts a row and returns true if it should be included in the results. In a moment, you'll write two functions, matching and in, that return functions appropriate for use as :where arguments. The :order-by argument, if supplied, should be a list of column names; the results will be sorted by the named columns. As with the :columns argument, you can specify a single column using just the name, which is equivalent to a one-item list containing the same name. Finally, the :distinct argument is a boolean that says whether to eliminate duplicate rows from the results. The default value for :distinct is NIL.

Here are some examples of using select:

;; Select all rows where the :artist column is "Green Day" (select :from *mp3s* :where (matching *mp3s* :artist "Green Day")) ;; Select a sorted list of artists with songs in the genre "Rock" (select :columns :artist :from *mp3s* :where (matching *mp3s* :genre "Rock") :distinct t :order-by :artist)

The implementation of select with its immediate helper functions looks like this:

(defun select (&key (columns t) from where distinct order-by) (let ((rows (rows from)) (schema (schema from))) (when where (setf rows (restrict-rows rows where))) (unless (eql columns 't) (setf schema (extract-schema (mklist columns) schema)) (setf rows (project-columns rows schema))) (when distinct (setf rows (distinct-rows rows schema))) (when order-by (setf rows (sorted-rows rows schema (mklist order-by)))) (make-instance 'table :rows rows :schema schema))) (defun mklist (thing) (if (listp thing) thing (list thing))) (defun extract-schema (column-names schema) (loop for c in column-names collect (find-column c schema))) (defun find-column (column-name schema) (or (find column-name schema :key #'name) (error "No column: ~a in schema: ~a" column-name schema))) (defun restrict-rows (rows where) (remove-if-not where rows)) (defun project-columns (rows schema) (map 'vector (extractor schema) rows)) (defun distinct-rows (rows schema) (remove-duplicates rows :test (row-equality-tester schema))) (defun sorted-rows (rows schema order-by) (sort (copy-seq rows) (row-comparator order-by schema)))

Of course, the really interesting part of select is how you implement the functions extractor, row-equality-tester, and row-comparator.

As you can tell by how they're used, each of these functions must return a function. For instance, project-columns uses the value returned by extractor as the function argument to MAP. Since the purpose of project-columns is to return a set of rows with only certain column values, you can infer that extractor returns a function that takes a row as an argument and returns a new row containing only the columns specified in the schema it's passed. Here's how you can implement it:

(defun extractor (schema) (let ((names (mapcar #'name schema))) #'(lambda (row) (loop for c in names collect c collect (getf row c)))))

Note how you can do the work of extracting the names from the schema outside the body of the closure: since the closure will be called many times, you want it to do as little work as possible each time it's called.

The functions row-equality-tester and row-comparator are implemented in a similar way. To decide whether two rows are equivalent, you need to apply the appropriate equality predicate for each column to the appropriate column values. Recall from Chapter 22 that the LOOP clause always will return NIL as soon as a pair of values fails their test or will cause the LOOP to return T.

(defun row-equality-tester (schema) (let ((names (mapcar #'name schema)) (tests (mapcar #'equality-predicate schema))) #'(lambda (a b) (loop for name in names and test in tests always (funcall test (getf a name) (getf b name))))))

Ordering two rows is a bit more complex. In Lisp, comparator functions return true if their first argument should be sorted ahead of the second and NIL otherwise. Thus, a NIL can mean that the second argument should be sorted ahead of the first or that they're equivalent. You want your row comparators to behave the same way: return T if the first row should be sorted ahead of the second and NIL otherwise.

Thus, to compare two rows, you should compare the values from the columns you're sorting by, in order, using the appropriate comparator for each column. First call the comparator with the value from the first row as the first argument. If the comparator returns true, that means the first row should definitely be sorted ahead of the second row, so you can immediately return T.

But if the column comparator returns NIL, then you need to determine whether that's because the second value should sort ahead of the first value or because they're equivalent. So you should call the comparator again with the arguments reversed. If the comparator returns true this time, it means the second column value sorts ahead of the first and thus the second row ahead of the first row, so you can return NIL immediately. Otherwise, the column values are equivalent, and you need to move onto the next column. If you get through all the columns without one row's value ever winning the comparison, then the rows are equivalent, and you return NIL. A function that implements this algorithm looks like this:

(defun row-comparator (column-names schema) (let ((comparators (mapcar #'comparator (extract-schema column-names schema)))) #'(lambda (a b) (loop for name in column-names for comparator in comparators for a-value = (getf a name) for b-value = (getf b name) when (funcall comparator a-value b-value) return t when (funcall comparator b-value a-value) return nil finally (return nil)))))

Matching Functions

The :where argument to select can be any function that takes a row object and returns true if it should be included in the results. In practice, however, you'll rarely need the full power of arbitrary code to express query criteria. So you should provide two functions, matching and in, that will build query functions that allow you to express the common kinds of queries and that take care of using the proper equality predicates and value normalizers for each column.

The workhouse query-function constructor will be matching, which returns a function that will match rows with specific column values. You saw how it was used in the earlier examples of select. For instance, this call to matching:

(matching *mp3s* :artist "Green Day")

returns a function that matches rows whose :artist value is "Green Day". You can also pass multiple names and values; the returned function matches when all the columns match. For example, the following returns a closure that matches rows where the artist is "Green Day" and the album is "American Idiot":

(matching *mp3s* :artist "Green Day" :album "American Idiot")

You have to pass matching the table object because it needs access to the table's schema in order to get at the equality predicates and value normalizer functions for the columns it matches against.

You build up the function returned by matching out of smaller functions, each responsible for matching one column's value. To build these functions, you should define a function, column-matcher, that takes a column object and an unnormalized value you want to match and returns a function that accepts a single row and returns true when the value of the given column in the row matches the normalized version of the given value.

(defun column-matcher (column value) (let ((name (name column)) (predicate (equality-predicate column)) (normalized (normalize-for-column value column))) #'(lambda (row) (funcall predicate (getf row name) normalized))))

You then build a list of column-matching functions for the names and values you care about with the following function, column-matchers:

(defun column-matchers (schema names-and-values) (loop for (name value) on names-and-values by #'cddr when value collect (column-matcher (find-column name schema) value)))

Now you can implement matching. Again, note that you do as much work as possible outside the closure in order to do it only once rather than once per row in the table.

(defun matching (table &rest names-and-values) "Build a where function that matches rows with the given column values." (let ((matchers (column-matchers (schema table) names-and-values))) #'(lambda (row) (every #'(lambda (matcher) (funcall matcher row)) matchers))))

This function is a bit of a twisty maze of closures, but it's worth contemplating for a moment to get a flavor of the possibilities of programming with functions as first-class objects.

The job of matching is to return a function that will be invoked on each row in a table to determine whether it should be included in the new table. So, matching returns a closure with one parameter, row.

Now recall that the function EVERY takes a predicate function as its first argument and returns true if, and only if, that function returns true each time it's applied to an element of the list passed as EVERY's second argument. However, in this case, the list you pass to EVERY is itself a list of functions, the column matchers. What you want to know is that every column matcher, when invoked on the row you're currently testing, returns true. So, as the predicate argument to EVERY, you pass yet another closure that FUNCALLs the column matcher, passing it the row.

Another matching function that you'll occasionally find useful is in, which returns a function that matches rows where a particular column is in a given set of values. You'll define in to take two arguments: a column name and a table that contains the values you want to match. For instance, suppose you wanted to find all the songs in the MP3 database that have names the same as a song performed by the Dixie Chicks. You can write that where clause using in and a subselect like this:4

(select :columns '(:artist :song) :from *mp3s* :where (in :song (select :columns :song :from *mp3s* :where (matching *mp3s* :artist "Dixie Chicks"))))

Although the queries are more complex, the definition of in is much simpler than that of matching.

(defun in (column-name table) (let ((test (equality-predicate (find-column column-name (schema table)))) (values (map 'list #'(lambda (r) (getf r column-name)) (rows table)))) #'(lambda (row) (member (getf row column-name) values :test test))))

Getting at the Results

Since select returns another table, you need to think a bit about how you want to get at the individual row and column values in a table. If you're sure you'll never want to change the way you represent the data in a table, you can just make the structure of a table part of the API--that table has a slot rows that's a vector of plists--and use all the normal Common Lisp functions for manipulating vectors and plists to get at the values in the table. But that representation is really an internal detail that you might want to change. Also, you don't necessarily want other code manipulating the data structures directly--for instance, you don't want anyone to use SETF to put an unnormalized column value into a row. So it might be a good idea to define a few abstractions that provide the operations you want to support. Then if you decide to change the internal representation later, you'll need to change only the implementation of these functions and macros. And while Common Lisp doesn't enable you to absolutely prevent folks from getting at "internal" data, by providing an official API you at least make it clear where the boundary is.

Probably the most common thing you'll need to do with the results of a query is to iterate over the individual rows and extract specific column values. So you need to provide a way to do both those things without touching the rows vector directly or using GETF to get at the column values within a row.

For now these operations are trivial to implement; they're merely wrappers around the code you'd write if you didn't have these abstractions. You can provide two ways to iterate over the rows of a table: a macro do-rows, which provides a basic looping construct, and a function map-rows, which builds a list containing the results of applying a function to each row in the table.5

(defmacro do-rows ((row table) &body body) `(loop for ,row across (rows ,table) do ,@body)) (defun map-rows (fn table) (loop for row across (rows table) collect (funcall fn row)))

To get at individual column values within a row, you should provide a function, column-value, that takes a row and a column name and returns the appropriate value. Again, it's a trivial wrapper around the code you'd write otherwise. But if you change the internal representation of a table later, users of column-value needn't be any the wiser.

(defun column-value (row column-name) (getf row column-name))

While column-value is a sufficient abstraction for getting at column values, you'll often want to get at the values of multiple columns at once. So you can provide a bit of syntactic sugar, a macro, with-column-values, that binds a set of variables to the values extracted from a row using the corresponding keyword names. Thus, instead of writing this:

(do-rows (row table) (let ((song (column-value row :song)) (artist (column-value row :artist)) (album (column-value row :album))) (format t "~a by ~a from ~a~%" song artist album)))

you can simply write the following:

(do-rows (row table) (with-column-values (song artist album) row (format t "~a by ~a from ~a~%" song artist album)))

Again, the actual implementation isn't complicated if you use the once-only macro from Chapter 8.

(defmacro with-column-values ((&rest vars) row &body body) (once-only (row) `(let ,(column-bindings vars row) ,@body))) (defun column-bindings (vars row) (loop for v in vars collect `(,v (column-value ,row ,(as-keyword v))))) (defun as-keyword (symbol) (intern (symbol-name symbol) :keyword))

Finally, you should provide abstractions for getting at the number of rows in a table and for accessing a specific row by numeric index.

(defun table-size (table) (length (rows table))) (defun nth-row (n table) (aref (rows table) n))

Other Database Operations

Finally, you'll implement a few other database operations that you'll need in Chapter 29. The first two are analogs of the SQL DELETE statement. The function delete-rows is used to delete rows from a table that match particular criteria. Like select, it takes :from and :where keyword arguments. Unlike select, it doesn't return a new table--it actually modifies the table passed as the :from argument.

(defun delete-rows (&key from where) (loop with rows = (rows from) with store-idx = 0 for read-idx from 0 for row across rows do (setf (aref rows read-idx) nil) unless (funcall where row) do (setf (aref rows store-idx) row) (incf store-idx) finally (setf (fill-pointer rows) store-idx)))

In the interest of efficiency, you might want to provide a separate function for deleting all the rows from a table.

(defun delete-all-rows (table) (setf (rows table) (make-rows *default-table-size*)))

The remaining table operations don't really map to normal relational database operations but will be useful in the MP3 browser application. The first is a function to sort the rows of a table in place.

(defun sort-rows (table &rest column-names) (setf (rows table) (sort (rows table) (row-comparator column-names (schema table)))) table)

On the flip side, in the MP3 browser application, you'll need a function that shuffles a table's rows in place using the function nshuffle-vector from Chapter 23.

(defun shuffle-table (table) (nshuffle-vector (rows table)) table)

And finally, again for the purposes of the MP3 browser, you should provide a function that selects n random rows, returning the results as a new table. It also uses nshuffle-vector along with a version of random-sample based on Algorithm S from Donald Knuth's The Art of Computer Programming, Volume 2: Seminumerical Algorithms, Third Edition (Addison-Wesley, 1998) that I discussed in Chapter 20.

(defun random-selection (table n) (make-instance 'table :schema (schema table) :rows (nshuffle-vector (random-sample (rows table) n)))) (defun random-sample (vector n) "Based on Algorithm S from Knuth. TAOCP, vol. 2. p. 142" (loop with selected = (make-array n :fill-pointer 0) for idx from 0 do (loop with to-select = (- n (length selected)) for remaining = (- (length vector) idx) while (>= (* remaining (random 1.0)) to-select) do (incf idx)) (vector-push (aref vector idx) selected) when (= (length selected) n) return selected))

With this code you'll be ready, in Chapter 29, to build a Web interface for browsing a collection of MP3 files. But before you get to that, you need to implement the part of the server that streams MP3s using the Shoutcast protocol, which is the topic of the next chapter.

* * *

1The general theory behind interning objects is that if you're going to compare a particular value many times, it's worth it to pay the cost of interning it. The value-normalizer runs once when you insert a value into the table and, as you'll see, once at the beginning of each query. Since a query can involve invoking the equality-predicate once per row in the table, the amortized cost of interning the values will quickly approach zero.

2As always, the first causality of concise exposition in programming books is proper error handling; in production code you'd probably want to define your own error type, such as the following, and signal it instead:

(error 'illegal-column-value :value value :column column)

Then you'd want to think about where you can add restarts that might be able to recover from this condition. And, finally, in any given application you could establish condition handlers that would choose from among those restarts.

3If any MP3 files have malformed data in the track and year frames, PARSE-INTEGER could signal an error. One way to deal with that is to pass PARSE-INTEGER the :junk-allowed argument of T, which will cause it to ignore any non-numeric junk following the number and to return NIL if no number can be found in the string. Or, if you want practice at using the condition system, you could define an error and signal it from these functions when the data is malformed and also establish a few restarts to allow these functions to recover.

4This query will also return all the songs performed by the Dixie Chicks. If you want to limit it to songs by artists other than the Dixie Chicks, you need a more complex :where function. Since the :where argument can be any function, it's certainly possible; you could remove the Dixie Chicks' own songs with this query:

(let* ((dixie-chicks (matching *mp3s* :artist "Dixie Chicks")) (same-song (in :song (select :columns :song :from *mp3s* :where dixie-chicks))) (query #'(lambda (row) (and (not (funcall dixie-chicks row)) (funcall same-song row))))) (select :columns '(:artist :song) :from *mp3s* :where query))

This obviously isn't quite as convenient. If you were going to write an application that needed to do lots of complex queries, you might want to consider coming up with a more expressive query language.

5The version of LOOP implemented at M.I.T. before Common Lisp was standardized included a mechanism for extending the LOOP grammar to support iteration over new data structures. Some Common Lisp implementations that inherited their LOOP implementation from that code base may still support that facility, which would make do-rows and map-rows less necessary.

Copyright © 2003-2005, Peter Seibel

28. Practical: A Shoutcast Server

In this chapter you'll develop another important part of what will eventually be a Web-based application for streaming MP3s, namely, the server that implements the Shoutcast protocol for actually streaming MP3s to clients such as iTunes, XMMS,1 or Winamp.

The Shoutcast Protocol

The Shoutcast protocol was invented by the folks at Nullsoft, the makers of the Winamp MP3 software. It was designed to support Internet audio broadcasting--Shoutcast DJs send audio data from their personal computers to a central Shoutcast server that then turns around and streams it out to any connected listeners.

The server you'll build is actually only half a true Shoutcast server--you'll use the protocol that Shoutcast servers use to stream MP3s to listeners, but your server will be able to serve only songs already stored on the file system of the computer where the server is running.

You need to worry about only two parts of the Shoutcast protocol: the request that a client makes in order to start receiving a stream and the format of the response, including the mechanism by which metadata about what song is currently playing is embedded in the stream.

The initial request from the MP3 client to the Shoutcast server is formatted as a normal HTTP request. In response, the Shoutcast server sends an ICY response that looks like an HTTP response except with the string "ICY"2 in place of the normal HTTP version string and with different headers. After sending the headers and a blank line, the server streams a potentially endless amount of MP3 data.

The only tricky thing about the Shoutcast protocol is the way metadata about the songs being streamed is embedded in the data sent to the client. The problem facing the Shoutcast designers was to provide a way for the Shoutcast server to communicate new title information to the client each time it started playing a new song so the client could display it in its UI. (Recall from Chapter 25 that the MP3 format doesn't make any provision for encoding metadata.) While one of the design goals of ID3v2 had been to make it better suited for use when streaming MP3s, the Nullsoft folks decided to go their own route and invent a new scheme that's fairly easy to implement on both the client side and the server side. That, of course, was ideal for them since they were also the authors of their own MP3 client.

Their scheme was to simply ignore the structure of MP3 data and embed a chunk of self-delimiting metadata every n bytes. The client would then be responsible for stripping out this metadata so it wasn't treated as MP3 data. Since metadata sent to a client that isn't ready for it will cause glitches in the sound, the server is supposed to send metadata only if the client's original request contains a special Icy-Metadata header. And in order for the client to know how often to expect metadata, the server must send back a header Icy-Metaint whose value is the number of bytes of MP3 data that will be sent between each chunk of metadata.

The basic content of the metadata is a string of the form "StreamTitle='title';" where title is the title of the current song and can't contain single quote marks. This payload is encoded as a length-delimited array of bytes: a single byte is sent indicating how many 16-byte blocks follow, and then that many blocks are sent. They contain the string payload as an ASCII string, with the final block padded out with null bytes as necessary.

Thus, the smallest legal metadata chunk is a single byte, zero, indicating zero subsequent blocks. If the server doesn't need to update the metadata, it can send such an empty chunk, but it must send at least the one byte so the client doesn't throw away actual MP3 data.

Song Sources

Because a Shoutcast server has to keep streaming songs to the client for as long as it's connected, you need to provide your server with a source of songs to draw on. In the Web-based application, each connected client will have a playlist that can be manipulated via the Web interface. But in the interest of avoiding excessive coupling, you should define an interface that the Shoutcast server can use to obtain songs to play. You can write a simple implementation of this interface now and then a more complex one as part of the Web application you'll build in Chapter 29.

The Package

The package for the code you'll develop in this chapter looks like this:

(defpackage :com.gigamonkeys.shoutcast (:use :common-lisp :net.aserve :com.gigamonkeys.id3v2) (:export :song :file :title :id3-size :find-song-source :current-song :still-current-p :maybe-move-to-next-song :*song-source-type*))

The idea behind the interface is that the Shoutcast server will find a source of songs based on an ID extracted from the AllegroServe request object. It can then do three things with the song source it's given.

Get the current song from the source

Tell the song source that it's done with the current song

Ask the source whether the song it was given earlier is still the current song

The last operation is necessary because there may be ways--and will be in Chapter 29--to manipulate the songs source outside the Shoutcast server. You can express the operations the Shoutcast server needs with the following generic functions:

(defgeneric current-song (source) (:documentation "Return the currently playing song or NIL.")) (defgeneric maybe-move-to-next-song (song source) (:documentation "If the given song is still the current one update the value returned by current-song.")) (defgeneric still-current-p (song source) (:documentation "Return true if the song given is the same as the current-song."))

The function maybe-move-to-next-song is defined the way it is so a single operation checks whether the song is current and, if it is, moves the song source to the next song. This will be important in the next chapter when you need to implement a song source that can be safely manipulated from two different threads.3

To represent the information about a song that the Shoutcast server needs, you can define a class, song, with slots to hold the name of the MP3 file, the title to send in the Shoutcast metadata, and the size of the ID3 tag so you can skip it when serving up the file.

(defclass song () ((file :reader file :initarg :file) (title :reader title :initarg :title) (id3-size :reader id3-size :initarg :id3-size)))

The value returned by current-song (and thus the first argument to still-current-p and maybe-move-to-next-song) will be an instance of song.

In addition, you need to define a generic function that the server can use to find a song source based on the type of source desired and the request object. Methods will specialize the type parameter in order to return different kinds of song source and will pull whatever information they need from the request object to determine which source to return.

(defgeneric find-song-source (type request) (:documentation "Find the song-source of the given type for the given request."))

However, for the purposes of this chapter, you can use a trivial implementation of this interface that always uses the same object, a simple queue of song objects that you can manipulate from the REPL. You can start by defining a class, simple-song-queue, and a global variable, *songs*, that holds an instance of this class.

(defclass simple-song-queue () ((songs :accessor songs :initform (make-array 10 :adjustable t :fill-pointer 0)) (index :accessor index :initform 0))) (defparameter *songs* (make-instance 'simple-song-queue))

Then you can define a method on find-song-source that specializes type with an EQL specializer on the symbol singleton and returns the instance stored in *songs*.

(defmethod find-song-source ((type (eql 'singleton)) request) (declare (ignore request)) *songs*)

Now you just need to implement methods on the three generic functions that the Shoutcast server will use.

(defmethod current-song ((source simple-song-queue)) (when (array-in-bounds-p (songs source) (index source)) (aref (songs source) (index source)))) (defmethod still-current-p (song (source simple-song-queue)) (eql song (current-song source))) (defmethod maybe-move-to-next-song (song (source simple-song-queue)) (when (still-current-p song source) (incf (index source))))

And for testing purposes you should provide a way to add songs to this queue.

(defun add-file-to-songs (file) (vector-push-extend (file->song file) (songs *songs*))) (defun file->song (file) (let ((id3 (read-id3 file))) (make-instance 'song :file (namestring (truename file)) :title (format nil "~a by ~a from ~a" (song id3) (artist id3) (album id3)) :id3-size (size id3))))

Implementing Shoutcast

Now you're ready to implement the Shoutcast server. Since the Shoutcast protocol is loosely based on HTTP, you can implement the server as a function within AllegroServe. However, since you need to interact with some of the low-level features of AllegroServe, you can't use the define-url-function macro from Chapter 26. Instead, you need to write a regular function that looks like this:

(defun shoutcast (request entity) (with-http-response (request entity :content-type "audio/MP3" :timeout *timeout-seconds*) (prepare-icy-response request *metadata-interval*) (let ((wants-metadata-p (header-slot-value request :icy-metadata))) (with-http-body (request entity) (play-songs (request-socket request) (find-song-source *song-source-type* request) (if wants-metadata-p *metadata-interval*))))))

Then publish that function under the path /stream.mp3 like this:4

(publish :path "/stream.mp3" :function 'shoutcast)

In the call to with-http-response, in addition to the usual request and entity arguments, you need to pass :content-type and :timeout arguments. The :content-type argument tells AllegroServe how to set the Content-Type header it sends. And the :timeout argument specifies the number of seconds AllegroServe gives the function to generate its response. By default AllegroServe times out each request after five minutes. Because you're going to stream an essentially endless sequence of MP3s, you need much more time. There's no way to tell AllegroServe to never time out the request, so you should set it to the value of *timeout-seconds*, which you can define to some suitably large value such as the number of seconds in ten years.

(defparameter *timeout-seconds* (* 60 60 24 7 52 10))

Then, within the body of the with-http-response and before the call to with-http-body that will cause the response headers to be sent, you need to manipulate the reply that AllegroServe will send. The function prepare-icy-response encapsulates the necessary manipulations: changing the protocol string from the default of "HTTP" to "ICY" and adding the Shoutcast-specific headers.5 You also need, in order to work around a bug in iTunes, to tell AllegroServe not to use chunked transfer-encoding.6 The functions request-reply-protocol-string, request-uri, and reply-header-slot-value are all part of AllegroServe.

(defun prepare-icy-response (request metadata-interval) (setf (request-reply-protocol-string request) "ICY") (loop for (k v) in (reverse `((:|icy-metaint| ,(princ-to-string metadata-interval)) (:|icy-notice1| "<BR>This stream blah blah blah<BR>") (:|icy-notice2| "More blah") (:|icy-name| "MyLispShoutcastServer") (:|icy-genre| "Unknown") (:|icy-url| ,(request-uri request)) (:|icy-pub| "1"))) do (setf (reply-header-slot-value request k) v)) ;; iTunes, despite claiming to speak HTTP/1.1, doesn't understand ;; chunked Transfer-encoding. Grrr. So we just turn it off. (turn-off-chunked-transfer-encoding request)) (defun turn-off-chunked-transfer-encoding (request) (setf (request-reply-strategy request) (remove :chunked (request-reply-strategy request))))

Within the with-http-body of shoutcast, you actually stream the MP3 data. The function play-songs takes the stream to which it should write the data, the song source, and the metadata interval it should use or NIL if the client doesn't want metadata. The stream is the socket obtained from the request object, the song source is obtained by calling find-song-source, and the metadata interval comes from the global variable *metadata-interval*. The type of song source is controlled by the variable *song-source-type*, which for now you can set to singleton in order to use the simple-song-queue you implemented previously.

(defparameter *metadata-interval* (expt 2 12)) (defparameter *song-source-type* 'singleton)

The function play-songs itself doesn't do much--it loops calling the function play-current, which does all the heavy lifting of sending the contents of a single MP3 file, skipping the ID3 tag and embedding ICY metadata. The only wrinkle is that you need to keep track of when to send the metadata.

Since you must send metadata chunks at a fixed intervals, regardless of when you happen to switch from one MP3 file to the next, each time you call play-current you need to tell it when the next metadata is due, and when it returns, it must tell you the same thing so you can pass the information to the next call to play-current. If play-current gets NIL from the song source, it returns NIL, which allows the play-songs LOOP to end.

In addition to handling the looping, play-songs also provides a HANDLER-CASE to trap the error that will be signaled when the MP3 client disconnects from the server and one of the writes to the socket, down in play-current, fails. Since the HANDLER-CASE is outside the LOOP, handling the error will break out of the loop, allowing play-songs to return.

(defun play-songs (stream song-source metadata-interval) (handler-case (loop for next-metadata = metadata-interval then (play-current stream song-source next-metadata metadata-interval) while next-metadata) (error (e) (format *trace-output* "Caught error in play-songs: ~a" e))))

Finally, you're ready to implement play-current, which actually sends the Shoutcast data. The basic idea is that you get the current song from the song source, open the song's file, and then loop reading data from the file and writing it to the socket until either you reach the end of the file or the current song is no longer the current song.

There are only two complications: One is that you need to make sure you send the metadata at the correct interval. The other is that if the file starts with an ID3 tag, you want to skip it. If you don't worry too much about I/O efficiency, you can implement play-current like this:

(defun play-current (out song-source next-metadata metadata-interval) (let ((song (current-song song-source))) (when song (let ((metadata (make-icy-metadata (title song)))) (with-open-file (mp3 (file song)) (unless (file-position mp3 (id3-size song)) (error "Can't skip to position ~d in ~a" (id3-size song) (file song))) (loop for byte = (read-byte mp3 nil nil) while (and byte (still-current-p song song-source)) do (write-byte byte out) (decf next-metadata) when (and (zerop next-metadata) metadata-interval) do (write-sequence metadata out) (setf next-metadata metadata-interval)) (maybe-move-to-next-song song song-source))) next-metadata)))

This function gets the current song from the song source and gets a buffer containing the metadata it'll need to send by passing the title to make-icy-metadata. Then it opens the file and skips past the ID3 tag using the two-argument form of FILE-POSITION. Then it commences reading bytes from the file and writing them to the request stream.7

It'll break out of the loop either when it reaches the end of the file or when the song source's current song changes out from under it. In the meantime, whenever next-metadata gets to zero (if you're supposed to send metadata at all), it writes metadata to the stream and resets next-metadata. Once it finishes the loop, it checks to see if the song is still the song source's current song; if it is, that means it broke out of the loop because it read the whole file, in which case it tells the song source to move to the next song. Otherwise, it broke out of the loop because someone changed the current song out from under it, and it just returns. In either case, it returns the number of bytes left before the next metadata is due so it can be passed in the next call to play-current.8

The function make-icy-metadata, which takes the title of the current song and generates an array of bytes containing a properly formatted chunk of ICY metadata, is also straightforward.9

(defun make-icy-metadata (title) (let* ((text (format nil "StreamTitle='~a';" (substitute #\Space #\' title))) (blocks (ceiling (length text) 16)) (buffer (make-array (1+ (* blocks 16)) :element-type '(unsigned-byte 8) :initial-element 0))) (setf (aref buffer 0) blocks) (loop for char across text for i from 1 do (setf (aref buffer i) (char-code char))) buffer))

Depending on how your particular Lisp implementation handles its streams, and also how many MP3 clients you want to serve at once, the simple version of play-current may or may not be efficient enough.

The potential problem with the simple implementation is that you have to call READ-BYTE and WRITE-BYTE for every byte you transfer. It's possible that each call may result in a relatively expensive system call to read or write one byte. And even if Lisp implements its own streams with internal buffering so not every call to READ-BYTE or WRITE-BYTE results in a system call, function calls still aren't free. In particular, in implementations that provide user-extensible streams using so-called Gray Streams, READ-BYTE and WRITE-BYTE may result in a generic function call under the covers to dispatch on the class of the stream argument. While generic function dispatch is normally speedy enough that you don't have to worry about it, it's a bit more expensive than a nongeneric function call and thus not something you necessarily want to do several million times in a few minutes if you can avoid it.

A more efficient, if slightly more complex, way to implement play-current is to read and write multiple bytes at a time using the functions READ-SEQUENCE and WRITE-SEQUENCE. This also gives you a chance to match your file reads with the natural block size of the file system, which will likely give you the best disk throughput. Of course, no matter what buffer size you use, keeping track of when to send the metadata becomes a bit more complicated. A more efficient version of play-current that uses READ-SEQUENCE and WRITE-SEQUENCE might look like this:

(defun play-current (out song-source next-metadata metadata-interval) (let ((song (current-song song-source))) (when song (let ((metadata (make-icy-metadata (title song))) (buffer (make-array size :element-type '(unsigned-byte 8)))) (with-open-file (mp3 (file song)) (labels ((write-buffer (start end) (if metadata-interval (write-buffer-with-metadata start end) (write-sequence buffer out :start start :end end))) (write-buffer-with-metadata (start end) (cond ((> next-metadata (- end start)) (write-sequence buffer out :start start :end end) (decf next-metadata (- end start))) (t (let ((middle (+ start next-metadata))) (write-sequence buffer out :start start :end middle) (write-sequence metadata out) (setf next-metadata metadata-interval) (write-buffer-with-metadata middle end)))))) (multiple-value-bind (skip-blocks skip-bytes) (floor (id3-size song) (length buffer)) (unless (file-position mp3 (* skip-blocks (length buffer))) (error "Couldn't skip over ~d ~d byte blocks." skip-blocks (length buffer))) (loop for end = (read-sequence buffer mp3) for start = skip-bytes then 0 do (write-buffer start end) while (and (= end (length buffer)) (still-current-p song song-source))) (maybe-move-to-next-song song song-source))))) next-metadata)))

Now you're ready to put all the pieces together. In the next chapter you'll write a Web interface to the Shoutcast server developed in this chapter, using the MP3 database from Chapter 27 as the source of songs.

* * *

1The version of XMMS shipped with Red Hat 8.0 and 9.0 and Fedora no longer knows how to play MP3s because the folks at Red Hat were worried about the licensing issues related to the MP3 codec. To get an XMMS with MP3 support on these versions of Linux, you can grab the source from http://www.xmms.org and build it yourself. Or, see http://www.fedorafaq.org/#xmms-mp3 for information about other possibilities.

2To further confuse matters, there's a different streaming protocol called Icecast. There seems to be no connection between the ICY header used by Shoutcast and the Icecast protocol.

3Technically, the implementation in this chapter will also be manipulated from two threads--the AllegroServe thread running the Shoutcast server and the REPL thread. But you can live with the race condition for now. I'll discuss how to use locking to make code thread safe in the next chapter.

4Another thing you may want to do while working on this code is to evaluate the form (net.aserve::debug-on :notrap). This tells AllegroServe to not trap errors signaled by your code, which will allow you to debug them in the normal Lisp debugger. In SLIME this will pop up a SLIME debugger buffer just like any other error.

5Shoutcast headers are usually sent in lowercase, so you need to escape the names of the keyword symbols used to identify them to AllegroServe to keep the Lisp reader from converting them to all uppercase. Thus, you'd write :|icy-metaint| rather than :icy-metaint. You could also write :\i\c\y-\m\e\t\a\i\n\t, but that'd be silly.

