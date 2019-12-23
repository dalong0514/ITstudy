## PREFACE

## 01. Welcome to the Third Edition of Core Python Applications Programming

We are delighted that you have engaged us to help you learn Python as quickly and as deeply as possible. The goal of the Core Python series of books is not to just teach developers the Python language; we want you to develop enough of a personal knowledge base to be able to develop software in any application area.

In our other Core Python offerings, Core Python Programming and Core Python Language Fundamentals, we not only teach you the syntax of the Python language, but we also strive to give you in-depth knowledge of how Python works under the hood. We believe that armed with this knowledge, you will write more effective Python applications, whether you're a beginner to the language or a journeyman (or journeywoman!) Upon completion of either or any other introductory Python books, you might be satisfied that you have learned Python and learned it well. By completing many of the exercises, you're probably even fairly confident in your newfound Python coding skills. Still, you might be left wondering, Now what? What kinds of applications can I build with Python? Perhaps you learned Python for a work project that's constrained to a very narrow focus. "What else can I build with Python? "

## 02. About this Book

In Core Python Applications Programming, you will take all the Python knowledge gained elsewhere and develop new skills, building up a toolset with which youll be able to use Python for a variety of general applica tions. These advanced topics chapters are meant as intros or"quick dives into a variety of distinct subjects. If you're moving toward the specific areas of application development covered by any of these chapters, you'li likely discover that they contain more than enough information to get you pointed in the right direction. Do not expect an in-depth treatment because that will detract from the breadth-oriented treatment that this book is designed to convey






Like all other Core Python books, throughout this one, you wil find many examples that you can try right in front of your computer. To ham- mer the concepts home, you will also find fun and challenging exercises at the end of every chapter. These easy and intermediate exercises are meant to test your learning and push your Python skills. There simply is no sub- stitute for hands-on experience. We believe you should not only pick up Python programming skills but also be able to master them in as short a time period as possible

Because the best way for you to extend your Python skills is througl practice, you will find these exercises to be one of the greatest strengths of this book. They will test your knowledge of chapter topics and definitions as well as motivate you to code as much as possible. There is no substitute for improving your skills more effectively than by building applications You will find easy, intermediate, and difficult problems to solve. It is also here that you might need to write one of those"large"applications that many readers wanted to see in the book, but rather than scripting them-which frankly doesnt do you all that much good-you gain b jumping right in and doing it yourself. Appendix A, " Answers to Selected Exercises, "features answers to selected problems from each chapter. As with the second edition, you'li find useful reference tables collated in -ppendix B, Reference Tables

Id like to personally thank all readers for your feedback and encouragement. You're the reason why I go through the effort of writing these books I encourage you to keep sending your feedback and help us make a fourth edition possible, and even better than its predecessors.

## 03. Who Should Read This Book?

This book is meant for anyone who already knows some Python but wants to know more and expand their application development skillset Python is used in many fields, including engineering, information tech- nology, science, business, entertainment, and so on. This means that the list of Python users (and readers of this book) includes but is not limited to

Software engineers

Hardware design/CAD engineers

QA/testing and automation framework developers

1S/1T/system and network administrators

Scientists and mathematicians

Technical or proiect management staff

Multimedia or audio/visual engineers

SCM or release engineers

Web masters and content management staff

Customer/technical support engineers

Database engineers and administrators

Research and development engineers

Software integration and professional services staff

Collegiate and secondary educators

Web service engineers

Financial software engineers

And many others!

Some of the most famous companies that use Python include Google, Yahoo NASA, Lucasfilm/industrial Light and Magic, Red Hat, Zope, Disney Pixar, and Dreamworks

## 04. The Author and Python

I discovered Python over a decade ago at a company called Four11. At the

timethecompanyhadonemajorproducttheFourl1. ComWhitePage directory service. Python was being used to design its next product: the Rocketmail Web-based e-mail service that would eventually evolve into

what today is Yahoo! Mail

It was fun learning Python and being on the original Yahoo! Mail engi-

the time, Python also became part of a number @r d spell checker. At leering team. I helped re-design the address book and spell checker. A

other Yahoo! sites

including People Search, Yellow Pages, and Maps and Driving Directions, just to name a few. In fact, I was the lead engineer for People Search

A Ithough Python was new to me then, it was fairly easy to pick



up-much simpler than other languages I had learned in the past. The scarcity of textbooks at the time led me to use the Library Reference and

Quick Reference Guide as my primary learning tools; it was also a driving motivation for the book you are reading right now.

Since my days at Yahoo!, I have been able to use Python in all sorts of interesting ways at the jobs that followed. In each case, I was able to har ness the power of Python to solve the problems at hand, in a timely man ner. I have also developed several Python courses and have used this book to teach those classes-truly eating my own dogfood

Not only are the Core Python books great learning devices, but they also among the best tools with which to teach Python. As an engineer

know what it takes to learn, understand, and apply a new technology. As a professional instructor, I also know what is needed to deliver the most effective sessions for clients. These books provide the experience necessary to be able to give you real-world analogies and tips that you cannot get from some one who is"just a trainer" or"just a book author

## 05. What to Expect of the Writing Style Technical, Yet Easy Reading

Rather than being strictly a"beginners"book or a pure, hard-core com puter science reference book, my instructional experience has taught me that an easy-to-read, yet technically oriented book serves the purpose the best, which is to get you up to speed on Python as quickly as possible so that you can apply it to your tasks posthaste. We will introduce concepts Coupled with appropriate examples to expedite the learning process. At the end of each chapter you will find numerous exercises to reinforce some of

the concepts and ideas acquired in your reading

We are thrilled and humbled to be compared with Bruce Eckel's writing style (seethereviewstothefirsteditionatthebooksWebsitehttp: // corepython. Com) This is not a dry college textbook. Our goal is to have a conversation with you, as if you were attending one of my well-received Python training courses. As a lifelong student, I constantly put myself in my student's shoes and tell you what you need to hear in order to learn the concepts as quickly and as thoroughly as possible. You will find read ing this book fast and easy, without losing sight of the technical details

As an engineer, I know what I need to tell you in order to teach you a concept in Python. As a teacher, I can take technical details and boil them

down into language that is easy to understand and grasp right away. You are getting the best of both worlds with my writing and teaching styles,

but you will enjoy programming in Python even more

Thus, youll notice that even though I'm the sole author, I use thethird person plural! 'writing structure; that is to say, I use verbiage such as"we and'us '"our because in the grand scheme of this book, were all in this together, working toward the goal of expanding the Python program-

ming universe

About This Third Edition

At the time the first edition of this book was published, Python was enter ing its second era with the release of version 2.0. Since then, the language has undergone significant improvements that have contributed to the overall continued success, acceptance, and growth in the use of the lan guage Deficiencies have been removed and new features added that bring

a new level of power and sophistication to Python developers worldwide

The second edition of the book came out in 2006, at the height of Pythons

ascendance, during the time of its most popular release to date, 2.5

The second edition was released to rave reviews and ended up outsell ing the first edition. Python itself had won numerous accolades since that time as well, including the following

. Tiobe (www. Tiobe. Com

Language of the Year (2007, 2010)

Linuxjournal  (linuxjournal. Com)

Favorite Programming Language  (2009-2011)

Favorite Scripting Language (2006-2008, 2010, 2011)

Linuxquestions. Org Members Choice Awards

Language of the Year (2007-2010)

These awards and honors have helped propel Python even further Now it's on its next generation with Python 3. Likewise, Core Python Pro gramming is moving towards its third generation "too, as I'm exceeding pleased that Prentice Hall has asked me to develop this third edition Because version 3. X is backward-incompatible with Python 1 and 2, it will take some time before it is universally adopted and integrated into indus-

try. We are happy to guide you through this transition. The code in this edition will be presented in both Python 2 and 3  (as appropriate-not everything has been ported yet). We'll also discuss various tools and prac-

tices when porting

The changes brought about in version 3. X continue the trend of iterating

ad improving the language, taking a larger step toward removing some of its last major flaws, and representing a bigger jump in the continuing evolution of the language. Similarly, the structure of the book is also mak ing a rather significant transition. Due to its size and scope, Core Python Programming as it has existed wouldnt be able to handle all the new mate- rial introduced in this third edition

Therefore, Prentice Hall and I have decided the best way of moving for ward is to take that logical division represented by Parts I and II of the pre vious editions, representing the core language and advanced applications topics, respectively, and divide the book into two volumes at this juncture You are holding in your hands (perhaps in ebook form) the second half of the third edition of Core Python Programming. The good news is that the first half is not required in order to make use of the rich amount of conten

in this volume. We only recommend that you have intermediate Python experience. If youve learned Python recently and are fairly comfortable with using it, or have existing Python skills and want to take it to the next level, then you've come to the right place

As existing Core Python Programming readers already know, my primary focus is teaching you the core of the Python language in a comprehen sive manner, much more than just its syntax (which you don't really need a book to learn, right?) Knowing more about how Python works under the hood-including the relationship between data objects and memory management-will make you a much more effective Python programmer

Right out of the gate. This is what Part and now Core Python Language

As with all editions of this book, I will continue to update the books Web site and my blog with updates, downloads, and other related articles

to keep this publication as contemporary as possible, regardless to which new release of Python you have migrated

For existing readers, the new topics we have added to this edition include

Web-based e-mail examples (Chapter 3)

Using Tile/Ttk(Chapter 5

Using Mongodb (Chapter 6)

More significant Outlook and Powerpoint examples (Chapter 7)

Web server gateway interface (WSG) (Chapter 10)

Using Twitter (Chapter 13)

Using Google+ (Chapter 15

In addition, we are proud to introduce three brand new chapters to the book: Chapter 11, " Web Frameworks: Django, " Chapter 12, "Cloud Co om-

Pung Google App Englne and Chapen development for which Python er 14, Text Processing. "These rep- resent new or ongoing areas of applicatior

is used quite often. All existing chapters have been refreshed and updated to the latest versions of Python, possibly including new material. Take a look at the chapter guide that follows for more details on what to expect from every part of this volume

## 06. Chapter Guide

This book is divided into three parts. The first part, which takes up about two-thirds of the text, gives you treatment of the "core" members of an application development toolset  (with Python being the focus, of course). 

The second part concentrates on a variety of topics, all tied to Web programming. The book concludes with the supplemental section which provides experimental chapters that are under development and hopefully will grow into independent chapters in future editions.

All three parts provide a set of various advanced topics to show what you can build by using Python. We are certainly glad that we were at least able to provide you with a good introduction to many of the key areas of Python development including some of the topics mentioned previously Following is a more in-depth, chapter-by-chapter guide.

### Part l: General Application Topics

#### Chapter 1-regular Expressions

Regular expressions are a powerful tool that you can use for pattern matching, extracting, and search-and-replace functionality.

#### Chapter 2-network Programming

So many applications today need to be network oriented. In this chapter, you learn to create clients and servers using TCP/IP and UDP/IP as well as get an introduction to Socketserver and Twisted.

#### Chapter 3-internet Client Programming

Most Internet protocols in use today were developed using sockets. In Chapter 3, we explore some of those higher-level libraries that are used to build clients of these Internet protocols. In particular, we focus on file transfer (FTP), the Usenet news protocol (NNTP), and a variety of e-mail protocols  (SMTP POP3, IMAP4).

#### Chapter 4-multithreaded Programming

Multithreaded programming is one way to improve the execution performance of many types of applications by introducing concurrency. This chapter ends the drought of written documentation on how to implement threads in Python by explaining the concepts and showing you how to correctly build a Python multithreaded application and what the best use Cases are.

#### Chapter 5-GUI Programming

Based on the Tk graphical toolkit, Tkinter (renamed to tkinter in Python 3) is Python's default GUI development library. We introduce Tkinter to you by showing you how to build simple GUI applications. One of the best ways to learn is to copy, and by building on top of some of these applications, you will be on your way in no time. We conclude the chapter by taking a brief look at other graphical libraries, such as Tix, Pmw, wxpython, PYGTK, and Ttk/Tile.

#### Chapter 6-database Programming

Python helps simplify database programming, as well. We first review basic concepts and then introduce you to the Python database application programmers interface (db-apt). We then show you how you can connect to a relational database and perform queries and operations by using Python. If you prefer a hands-off approach that uses the Structured Query Language  (SQL) and want to just work with objects without having to worry about the underlying database layer, we have object-relational managers (ORMS) just for that purpose. Finally, we introduce you to the world of non-relational databases, experimenting with Mongodb as our NOSQL example.

#### Chapter 7-programming Microsoft Office

Like it or not, we live in a world where we will likely have to interact with Microsoft Windows-based PCs. It might be intermittent or something we have to deal with on a daily basis, but regardless of how much exposure we face, the power of Python can be used to make our lives easier. In this chapter, we explore COM Client programming by using Python to control and communicate with Office applications, such as Word, Excel, Power-Point, and Outlook. Although experimental in the previous edition, we're glad we were able to add enough material to turn this into a standalone chapter.

#### Chapter 8-extending Python

We mentioned earlier how powerful it is to be able to reuse code and extend the language. In pure Python, these extensions are modules and packages, but you can also develop lower-level code in C/C++, C#, or Java. Those extensions then can interface with Python in a seamless fashion.

Writing your extensions in a lower-level programming language gives you added performance and some security (because the source code does not have to be revealed). This chapter walks you step-by-step through the extension building process using C.

### Part ll Web Development

#### Chapter 9-web Clients and Servers

Extending our discussion of client-server architecture in Chapter 2, we apply this concept to the Web. In this chapter, we not only look at clients, but also explore a variety of Web client tools, parsing Web content, and finally, we introduce you to customizing your own Web servers in Python.








Chapter 10- Web Programming: CGI and WSGI

The main job of Web servers is to take client requests and return results But how do servers get that data? Because theyre really only good at returning results, they generally do not have the capabilities or logic nec essary to do so; the heavy lifting is done elsewhere. CGL gives servers the ability to spawn another program to do this processing and has histori cally been the solution, but it doesn't scale and is thus not really used in practice; however, its concepts still apply, regardless of what framework (s you use, so we'll spend most of the chapter learning CGL. You will also learn how WSGI helps application developers by providing them a com mon programming interface. In addition, youll see how WSGI helps framework developers who have to connect to Web servers on one side

and application code on the other so that application developers can write code without having to worry about the execution platform

Chapter 11- Web Frameworks: Django

Python features a host of Web frameworks with Django being one of the most popular. In this chapter, you get an introduction to this framework and learn how to write simple Web applications. With this knowledge, ou can then explore other Web frameworks as you wish

Chapter 12-cloud Computing: Google App Engine

Cloud computing is taking the industry by storm. While the world is most familiar with infrastructure services like Amazons AWS and online appli cations such as Gmail and Yahoo! Mail, platforms present a powerful alter- native that take advantage of infrastructure without user involvement but

give more flexibility than cloud software because you control the application

and its code. In this cha lapter, you get a comprehensive introduction to the first

platform service using Python, Google App Engine. With the knowledge gained here, you can then explore similar services in the same space.

Chapter 13-web Services

Inthischapterweexplorehigher-levelservicesontheWeb (usingHTTP) We look at an older service (Yahoo! Finance) and a newer one  (Twitter) You learn how to interact with both of these services by using Python as well as knowledge you've gained from earlier chapters

Part Ill: Supplemental/Experimental Chapter 14-text Processing

Our first supplemental chapter introduces you to text processing using Python. We first explore CSV, then J SON, and finally XML. In the last part of this chapter, we take our client/server knowledge from earlier in the book and combine it XML to look at how you can create online remote

procedure calls  (RPC) services by using XML-RPC

Chapter 15-miscellaneous

This chapter consists of bonus material that we will likely develop into full, individual chapters in the next edition. Topics covered here include Java/Jython and Google+.

Conventions

All program output and source code are in monospaced font. Python key words appear in Bold-monospaced font Lines of output with three leading greater than signs  (>>>) represent the Python interpreter prompt. A lead- ing asterisk () in front of a chapter, section, or exercise, indicates that this is advanced and /or optional material.

Represents Core Notes

Represents Core Module

Represents Core Tips

New features to Python are highlighted with this icon, with the num

ber representing version (s) of Python in which the features first Appeared

## Book Resources

We welcome any and all feedback-the good, the bad, and the ugly. If you have any comments, suggestions, kudos, complaints, bugs, questions, or anything at all, feel free to contact me at corepython@yahoo.com. 

You will find errata, source code, updates, upcoming talks, Python training, downloads, and other information at the book's Web site located at [Core Python Programming](http://corepython.com/). You can also participate in the community discussion around the Core Python books at their Google+ page, which is locatedat: http://plus.ly/corepython.