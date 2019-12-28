This page, and the pages it links to, contain text of the Common Lisp book Practical Common Lisp published by Apress These pages now contain the final text as it appears in the book. If you find errors in these pages, please send email to book@gigamonkeys.com. These pages will remain online in perpetuity—I hope they will serve as a useful introduction to Common Lisp for folks who are curious about Lisp but maybe not yet curious enough to shell out big bucks for a dead-tree book and a good Common Lisp tutorial for folks who want to get down to real coding right away. However, don't let that stop you from buying the printed version available from Apress at your favorite local or online bookseller. For the complete bookstore browsing experience, you can read the letter to the reader that appears on the back cover of the treeware edition of the book.

Copyright © 2003-2009, Peter Seibel

「I have been complimented many times and they always embarrass me; I always feel that they have not said enough.」—Mark Twain

「that book is dead sexy」—Xach on #lisp

「Peter Seibel offers a fresh view of Lisp and its possibilities for elegantly solving problems. In Practical Common Lisp, he gives enough basic information to let you quickly see the power of the functional language paradigm. He then dazzles you with examples that seem almost magical in their simplicity and power. This read is pure fun from start to finish.」—Gary Pollice, from Dr. Dobb's Portal, May 17, 2006 article on the 2006 Jolt Awards

* * *

「Peter Seibel's Practical Common Lisp is just what the title implies: an excellent introduction to Common Lisp for someone who wants to dive in and start using the language for real work. The book is very well written and is fun to read—at least for those of us whose idea of fun extends to learning new programming languages.







* * *

Rather than spending a lot of time on abstract discussion of Lisp's place in the universe of programming lnaguages, Seibel dives right in, guiding the reader through a series of programming examples of increasing complexity. This approach places the most emphasis on those parts of Common Lisp that skilled programmers use the most, without getting bogged down in the odd corners of Common Lisp that even the experts must look up in the manual. The result of Seibel's example-driven approach is to give the reader an excellent appreciation of the power of Common Lisp in building complex, evolving software systems with a minimum of effort.

* * *

There are already many good books on Common Lisp that offer a more abstract and comparative approach, but a good ‘Here's how you do it—and why’ book, aimed at the working programmer, is a valuable contribution, both to current Common Lisp users and those who should be.」—Scott E. Fahlman, Research Professor of Computer Science, Carnegie Mellon University

* * *

「This book shows the power of Lisp not only in the areas that it has traditionally been noted for—such as developing a complete unit test framework in only 26 lines of code—but also in new areas such as parsing binary MP3 files, building a web application for browsing a collection of songs, and streaming audio over the web. Many readers will be surprised that Lisp allows you to do all this with conciseness similar to scripting languages such as Python, efficiency similar to C++, and unparalleled flexibility in designing your own language extensions.」—Peter Norvig, Director of Search Quality, Google Inc; author of Paradigms of Artificial Intelligence Programming: Case Studies in Common Lisp

* * *

「I wish this book had already existed when I started learning Lisp. It's not that there aren't other good books about (Common) Lisp out there, but none of them has such a pragmatic, up-to-date approach. And let's not forget that Peter covers topics like pathnames or conditions and restarts which are completely ignored in the rest of the Lisp literature.

If you're new to Lisp and want to dive right in don't hesitate to buy this book. Once you've read it and worked with it you can continue with the ‘classics’ like Graham, Norvig, Keene, or Steele.」—Edi Weitz, maintainer of the Common Lisp Cookbook and author of CL-PPCRE regular expression library.

* * *

「Two prehensile toes up!」—Kenny Tilton, comp.lang.lisp demon, reporting on behalf of his development team.

* * *

「Experienced programmers learn best from examples and it is delightful to see that Lisp is finally being served with Seibel's example-rich tutorial text. Especially delightful is the fact that this book includes so many examples that fall within the realm of problems today's programmers might be called upon to tackle, such as Web development and streaming media.—Philip Greenspun, author of Software Engineering for Internet Applications, MIT Department of Electrical Engineering and Computer Science

* * *

「Practical Common Lisp is an excellent book that covers the breadth of the Common Lisp language and also demonstrates the unique features of Common Lisp with real-world applications that the reader can run and extend. This book not only shows what Common Lisp is but also why every programmer should be familiar with Lisp.」—John Foderaro, Senior Scientist, Franz Inc.

* * *

「The Maxima Project frequently gets queries from potential new contributors who would like to learn Common Lisp. I am pleased to finally have a book that I can recommend to them without reservation. Peter Seibel's clear, direct style allows the reader to quickly appreciate the power of Common Lisp. His many included examples, which focus on contemporary programming problems, demonstrate that Lisp is much more than an academic programming language. Practical Common Lisp is a welcome addition to the literature.」—James Amundson, Maxima Project Leader

* * *

「I like the interspersed Practical chapters on 'real' and useful programs. We need books of this kind telling the world that crunching strings and numbers into trees or graphs is easily done in Lisp.—Professor Christian Queinnec, Universite Paris 6 (Pierre et Marie Curie)

* * *

「One of the most important parts of learning a programming language is learning its proper programming style. This is hard to teach, but it can be painlessly absorbed from Practical Common Lisp. Just reading the practical examples made me a better programmer in any language.」—Peter Scott, Lisp programmer

* * *

「Finally, a Lisp book for the rest of us. If you want to learn how to write a factorial function, this is not your book. Seibel writes for the practical programmer, emphasizing the engineer/artist over the scientist, subtly and gracefully implying the power of the language while solving understandable real-world problems.

In most chapters, the reading of the chapter feels just like the experience of writing a program, starting with a little understanding, then having that understanding grow, like building the shoulders upon which you can then stand. When Seibel introduced macros as an aside while building a test framework, I was shocked at how such a simple example made me really 'get' them. Narrative context is extremely powerful and the technical books that use it are a cut above. Congrats!」—Keith Irwin, Lisp Programmer

* * *

「While learning Lisp, one is often refered to the CL HyperSpec if they do not know what a particular function does, however, I found that I often did not 'get it' just reading the HyperSpec. When I had a problem of this manner, I turned to Practical Common Lisp every single time—it is by far the most readable source on the subject that shows you how to program, not just tell you.」—Philip Haddad, Lisp Programmer

* * *

「With the IT world evolving at an ever increasing pace, professionals need the most powerful tools available. This is why Common Lisp—the most powerful, flexible, and stable programming language ever—is seeing such a rise in popularity. Practical Common Lisp is the long-awaited book that will help you harness the power of Common Lisp to tackle today's complex real world problems.」—Marc Battyani, author of CL-PDF, CL-TYPESETTING, and mod_lisp.

* * *

「Please don't assume Common Lisp is only useful for Databases, Unit Test Frameworks, Spam Filters, ID3 Parsers, Web Programming, Shoutcast Servers, HTML Generation Interpreters, and HTML Generation Compilers just because these are the only things happened to be implemented in the book Practical Common Lisp.—Tobias C. Rittweiler, Lisp Programmer

* * *

「When I met Peter, who just started writing this book, I asked to myself (not to him, of course) ‘why yet another book on Common Lisp, when there are many nice introductory books?’ One year later, I found a draft of the new book and recognized I was wrong. This book is not ‘yet another’ one. The author focuses on practical aspects rather than on technical details of the language. When I first studied Lisp by reading an introductory book, I felt I understood the language, but I also had an impression ‘so what?’, meaning I had no idea about how to use it. In contrast, this book leaps into a ‘PRACTICAL’ chapter after the first few chapters that explain the very basic notions of the language. Then the readers are expected to learn more about the language while they are following the PRACTICAL projects, which are combined together to form a product of a significant size. After reading this book, the readers will feel themselves expert programmers on Common Lisp since they have ‘finished’ a big project already. I think Lisp is the only language that allows this type of practical introduction. Peter makes use of this feature of the language in building up a fancy introduction on Common Lisp.」—Taiichi Yuasa, Professor, Department of Communications and Computer Engineering, Kyoto University

* * *

Have something to say about this book? Something nice? Want to see it here? Send it along to book@gigamonkeys.com.

Back to index.

Copyright © 2003-2004, Peter Seibel

Dear Reader,

Practical Common Lisp ... isn't that an oxymoron? If you're like most programmers, you probably know something about Lisp—from a comp sci course in college or from learning enough Elisp to customize Emacs a bit. Or maybe you just know someone who won't shut up about Lisp, the greatest language ever. But you probably never figured you'd see practical and Lisp in the same book title.

Yet, you're reading this; you must want to know more. Maybe you believe learning Lisp will make you a better programmer in any language. Or maybe you just want to know what those Lisp fanatics are yammering about all the time. Or maybe you have learned some Lisp but haven't quite made the leap to using it to write interesting software.

If any of those is true, this book is for you. Using Common Lisp, an ANSI standardized, industrial-strength dialect of Lisp, I show you how to write software that goes well beyond silly academic exercises or trivial editor customizations. And I show you how Lisp—even with many of its features adopted by other languages—still has a few tricks up its sleeve.

But unlike many Lisp books, this one doesn't just touch on a few of Lisp's greatest features and then leave you on your own to actually use them. I cover all the language features you'll need to write real programs and devote well over a third of the book to developing nontrivial software—a statistical spam filter, a library for parsing binary files, and a server for streaming MP3s over a network complete with an online MP3 database and Web interface.

So turn the book over, open it up, and see for yourself how eminently practical using the greatest language ever invented can be.

Sincerely,

Peter Seibel

Back to index.

Copyright © 2003-2004, Peter Seibel

## Contents

Introduction: Why Lisp?

Lather, Rinse, Repeat: A Tour of the REPL

Practical: A Simple Database

Syntax and Semantics

Functions

Variables

Macros: Standard Control Constructs

Macros: Defining Your Own

Practical: Building a Unit Test Framework

Numbers, Characters, and Strings

Collections

They Called It LISP for a Reason: List Processing

Beyond Lists: Other Uses for Cons Cells

Files and File I/O

Practical: A Portable Pathname Library

Object Reorientation: Generic Functions

Object Reorientation: Classes

A Few FORMAT Recipes

Beyond Exception Handling: Conditions and Restarts

The Special Operators

Programming in the Large: Packages and Symbols

LOOP for Black Belts

Practical: A Spam Filter

Practical: Parsing Binary Files

Practical: An ID3 Parser

Practical: Web Programming with AllegroServe

Practical: An MP3 Database

Practical: A Shoutcast Server

Practical: An MP3 Browser

Practical: An HTML Generation Library, the Interpreter

Practical: An HTML Generation Library, the Compiler

Conclusion: What's Next?