To wrap up this discussion of the MRO, Figure 12-2 illustrates part of the complex multiple inheritance graph of the Tkinter GUI toolkit from the Python standard library. To study the picture, start at the Text class at the bottom. The Text class implements a full featured, multiline editable text widget. It has rich functionality of its own, but also inherits many methods from other classes. The left side shows a plain UML class diagram. On the right, it’s decorated with arrows showing the MRO, as listed here with the help of the print_mro convenience function defined in Example 12-8:

>>> import tkinter >>> print_mro(tkinter.Text) Text, Widget, BaseWidget, Misc, Pack, Place, Grid, XView, YView, object

Figure 12-2. Left: UML class diagram of the Tkinter Text widget class and its superclasses. Right: Dashed arrows depict Text.mro.

In the next section, we’ll discuss the pros and cons of multiple inheritance, with examples from real frameworks that use it.

Multiple Inheritance in the Real World

It is possible to put multiple inheritance to good use. The Adapter pattern in the Design Patterns book uses multiple inheritance, so it can’t be completely wrong to do it (the remaining 22 patterns in the book use single inheritance only, so multiple inheritance is clearly not a cure-all).

In the Python standard library, the most visible use of multiple inheritance is the collections.abc package. That is not controversial: after all, even Java supports multiple inheritance of interfaces, and ABCs are interface declarations that may optionally provide concrete method implementations.[92]

An extreme example of multiple inheritance in the standard library is the Tkinter GUI toolkit (module tkinter: Python interface to Tcl/Tk). I used part of the Tkinter widget hierarchy to illustrate the MRO in Figure 12-2, but Figure 12-3 shows all the widget classes in the tkinter base package (there are more widgets in the tkinter.ttk sub-package).

Figure 12-3. Summary UML diagram for the Tkinter GUI class hierarchy; classes tagged «mixin» are designed to provide concrete methods to other classes via multiple inheritance

Tkinter is 20 years old as I write this, and is not an example of current best practices. But it shows how multiple inheritance was used when coders did not appreciate its drawbacks. And it will serve as a counter-example when we cover some good practices in the next section.

Consider these classes from Figure 12-3:

➊ Toplevel: The class of a top-level window in a Tkinter application.

➋ Widget: The superclass of every visible object that can be placed on a window.

➌ Button: A plain button widget.

➍ Entry: A single-line editable text field.

➎ Text: A multiline editable text field.

Here are the MROs of those classes, displayed by the print_mro function from Example 12-8:

>>> import tkinter >>> print_mro(tkinter.Toplevel) Toplevel, BaseWidget, Misc, Wm, object >>> print_mro(tkinter.Widget) Widget, BaseWidget, Misc, Pack, Place, Grid, object >>> print_mro(tkinter.Button) Button, Widget, BaseWidget, Misc, Pack, Place, Grid, object >>> print_mro(tkinter.Entry) Entry, Widget, BaseWidget, Misc, Pack, Place, Grid, XView, object >>> print_mro(tkinter.Text) Text, Widget, BaseWidget, Misc, Pack, Place, Grid, XView, YView, object

Things to note about how these classes relate to others:

Toplevel is the only graphical class that does not inherit from Widget, because it is the top-level window and does not behave like a widget—for example, it cannot be attached to a window or frame. Toplevel inherits from Wm, which provides direct access functions of the host window manager, like setting the window title and configuring its borders.

Widget inherits directly from BaseWidget and from Pack, Place, and Grid. These last three classes are geometry managers: they are responsible for arranging widgets inside a window or frame. Each encapsulates a different layout strategy and widget placement API.

Button, like most widgets, descends only from Widget, but indirectly from Misc, which provides dozens of methods to every widget.

Entry subclasses Widget and XView, the class that implements horizontal scrolling.

Text subclasses from Widget, XView, and YView, which provides vertical scrolling functionality.

We’ll now discuss some good practices of multiple inheritance and see whether Tkinter goes along with them.

Coping with Multiple Inheritance

[…] we needed a better theory about inheritance entirely (and still do). For example, inheritance and instancing (which is a kind of inheritance) muddles both pragmatics (such as factoring code to save space) and semantics (used for way too many tasks such as: specialization, generalization, speciation, etc.).

— Alan Kay The Early History of Smalltalk

As Alan Kay wrote, inheritance is used for different reasons, and multiple inheritance adds alternatives and complexity. It’s easy to create incomprehensible and brittle designs using multiple inheritance. Because we don’t have a comprehensive theory, here are a few tips to avoid spaghetti class graphs.

1. Distinguish Interface Inheritance from Implementation Inheritance

When dealing with multiple inheritance, it’s useful to keep straight the reasons why subclassing is done in the first place. The main reasons are:

Inheritance of interface creates a subtype, implying an「is-a」relationship.

Inheritance of implementation avoids code duplication by reuse.

In practice, both uses are often simultaneous, but whenever you can make the intent clear, do it. Inheritance for code reuse is an implementation detail, and it can often be replaced by composition and delegation. On the other hand, interface inheritance is the backbone of a framework.

2. Make Interfaces Explicit with ABCs

In modern Python, if a class is designed to define an interface, it should be an explicit ABC. In Python ≥ 3.4, this means: subclass abc.ABC or another ABC (see ABC Syntax Details if you need to support older Python versions).

3. Use Mixins for Code Reuse

If a class is designed to provide method implementations for reuse by multiple unrelated subclasses, without implying an「is-a」relationship, it should be an explicit mixin class. Conceptually, a mixin does not define a new type; it merely bundles methods for reuse. A mixin should never be instantiated, and concrete classes should not inherit only from a mixin. Each mixin should provide a single specific behavior, implementing few and very closely related methods.

4. Make Mixins Explicit by Naming

There is no formal way in Python to state that a class is a mixin, so it is highly recommended that they are named with a …Mixin suffix. Tkinter does not follow this advice, but if it did, XView would be XViewMixin, Pack would be PackMixin, and so on with all the classes where I put the «mixin» tag in Figure 12-3.

5. An ABC May Also Be a Mixin; The Reverse Is Not True

Because an ABC can implement concrete methods, it works as a mixin as well. An ABC also defines a type, which a mixin does not. And an ABC can be the sole base class of any other class, while a mixin should never be subclassed alone except by another, more specialized mixin—not a common arrangement in real code.

One restriction applies to ABCs and not to mixins: the concrete methods implemented in an ABC should only collaborate with methods of the same ABC and its superclasses. This implies that concrete methods in an ABC are always for convenience, because everything they do, a user of the class can also do by calling other methods of the ABC.

6. Don’t Subclass from More Than One Concrete Class

Concrete classes should have zero or at most one concrete superclass.[93] In other words, all but one of the superclasses of a concrete class should be ABCs or mixins. For example, in the following code, if Alpha is a concrete class, then Beta and Gamma must be ABCs or mixins:

class MyConcreteClass(Alpha, Beta, Gamma): """This is a concrete class: it can be instantiated.""" # ... more code ...

7. Provide Aggregate Classes to Users

If some combination of ABCs or mixins is particularly useful to client code, provide a class that brings them together in a sensible way. Grady Booch calls this an aggregate class.[94]

For example, here is the complete source code for tkinter.Widget:

class Widget(BaseWidget, Pack, Place, Grid): """Internal class. Base class for a widget which can be positioned with the geometry managers Pack, Place or Grid.""" pass

The body of Widget is empty, but the class provides a useful service: it brings together four superclasses so that anyone who needs to create a new widget does not need to remember all those mixins, or wonder if they need to be declared in a certain order in a class statement. A better example of this is the Django ListView class, which we’ll discuss shortly, in A Modern Example: Mixins in Django Generic Views.

8.「Favor Object Composition Over Class Inheritance.」

This quote comes straight the Design Patterns book,[95] and is the best advice I can offer here. Once you get comfortable with inheritance, it’s too easy to overuse it. Placing objects in a neat hierarchy appeals to our sense of order; programmers do it just for fun.

However, favoring composition leads to more flexible designs. For example, in the case of the tkinter.Widget class, instead of inheriting the methods from all geometry managers, widget instances could hold a reference to a geometry manager, and invoke its methods. After all, a Widget should not「be」a geometry manager, but could use the services of one via delegation. Then you could add a new geometry manager without touching the widget class hierarchy and without worrying about name clashes. Even with single inheritance, this principle enhances flexibility, because subclassing is a form of tight coupling, and tall inheritance trees tend to be brittle.

Composition and delegation can replace the use of mixins to make behaviors available to different classes, but cannot replace the use of interface inheritance to define a hierarchy of types.

We will now analyze Tkinter from the point of view of these recommendations.

Tkinter: The Good, the Bad, and the Ugly

Note

Keep in mind that Tkinter has been part of the standard library since Python 1.1 was released in 1994. Tkinter is a layer on top of the excellent Tk GUI toolkit of the Tcl language. The Tcl/Tk combo is not originally object oriented, so the Tk API is basically a vast catalog of functions. However, the toolkit is very object oriented in its concepts, if not in its implementation.

Most advice in the previous section is not followed by Tkinter, with #7 being a notable exception. Even then, it’s not a great example, because composition would probably work better for integrating the geometry managers into Widget, as discussed in #8.

The docstring of tkinter.Widget starts with the words「Internal class.」This suggests that Widget should probably be an ABC. Although Widget has no methods of its own, it does define an interface. Its message is:「You can count on every Tkinter widget providing basic widget methods (__init__, destroy, and dozens of Tk API functions), in addition to the methods of all three geometry managers.」We can agree that this is not a great interface definition (it’s just too broad), but it is an interface, and Widget「defines」it as the union of the interfaces of its superclasses.

The Tk class, which encapsulates the GUI application logic, inherits from Wm and Misc, neither of which are abstract or mixin (Wm is not proper mixin because TopLevel subclasses only from it). The name of the Misc class is—by itself—a very strong code smell. Misc has more than 100 methods, and all widgets inherit from it. Why is it necessary that every single widget has methods for clipboard handling, text selection, timer management, and the like? You can’t really paste into a button or select text from a scrollbar. Misc should be split into several specialized mixin classes, and not all widgets should inherit from every one of those mixins.

To be fair, as a Tkinter user, you don’t need to know or use multiple inheritance at all. It’s an implementation detail hidden behind the widget classes that you will instantiate or subclass in your own code. But you will suffer the consequences of excessive multiple inheritance when you type dir(tkinter.Button) and try to find the method you need among the 214 attributes listed.

Despite the problems, Tkinter is stable, flexible, and not necessarily ugly. The legacy (and default) Tk widgets are not themed to match modern user interfaces, but the tkinter.ttk package provides pretty, native-looking widgets, making professional GUI development viable since Python 3.1 (2009). Also, some of the legacy widgets, like Canvas and Text, are incredibly powerful. With just a little coding, you can turn a Canvas object into a simple drag-and-drop drawing application. Tkinter and Tcl/Tk are definitely worth a look if you are interested in GUI programming.

However, our theme here is not GUI programming, but the practice of multiple inheritance. A more up-to-date example with explicit mixin classes can be found in Django.

A Modern Example: Mixins in Django Generic Views

Note

You don’t need to know Django to follow this section. I am just using a small part of the framework as a practical example of multiple inheritance, and I will try to give all the necessary background, assuming you have some experience with server-side web development in another language or framework.

In Django, a view is a callable object that takes, as argument, an object representing an HTTP request and returns an object representing an HTTP response. The different responses are what interests us in this discussion. They can be as simple as a redirect response, with no content body, or as complex as a catalog page in an online store, rendered from an HTML template and listing multiple merchandise with buttons for buying and links to detail pages.

Originally, Django provided a set of functions, called generic views, that implemented some common use cases. For example, many sites need to show search results that include information from numerous items, with the listing spanning multiple pages, and for each item a link to a page with detailed information about it. In Django, a list view and a detail view are designed to work together to solve this problem: a list view renders search results, and a detail view produces pages for individual items.

However, the original generic views were functions, so they were not extensible. If you needed to do something similar but not exactly like a generic list view, you’d have to start from scratch.

In Django 1.3, the concept of class-based views was introduced, along with a set of generic view classes organized as base classes, mixins, and ready-to-use concrete classes. The base classes and mixins are in the base module of the django.views.generic package, pictured in Figure 12-4. At the top of the diagram we see two classes that take care of very distinct responsibilities: View and TemplateResponseMixin.

Tip

A great resource to study these classes is the Classy Class-Based Views website, where you can easily navigate through them, see all methods in each class (inherited, overridden, and added methods), view diagrams, browse their documentation, and jump to their source code on GitHub.

View is the base class of all views (it could be an ABC), and it provides core functionality like the dispatch method, which delegates to「handler」methods like get, head, post, etc., implemented by concrete subclasses to handle the different HTTP verbs.[96] The RedirectView class inherits only from View, and you can see that it implements get, head, post, etc.

Concrete subclasses of View are supposed to implement the handler methods, so why aren’t they part of the View interface? The reason: subclasses are free to implement just the handlers they want to support. A TemplateView is used only to display content, so it only implements get. If an HTTP POST request is sent to a TemplateView, the inherited View.dispatch method checks that there is no post handler, and produces an HTTP 405 Method Not Allowed response.[97]

Figure 12-4. UML class diagram for the django.views.generic.base module

The TemplateResponseMixin provides functionality that is of interest only to views that need to use a template. A RedirectView, for example, has no content body, so it has no need of a template and it does not inherit from this mixin. TemplateResponseMixin provides behaviors to TemplateView and other template-rendering views, such as ListView, DetailView, etc., defined in other modules of the django.views.generic package. Figure 12-5 depicts the django.views.generic.list module and part of the base module.

Figure 12-5. UML class diagram for the django.views.generic.list module. Here the three classes of the base module are collapsed (see Figure 12-4). The ListView class has no methods or attributes: it’s an aggregate class.

For Django users, the most important class in Figure 12-5 is ListView, which is an aggregate class, with no code at all (its body is just a docstring). When instantiated, a ListView has an object_list instance attribute through which the template can iterate to show the page contents, usually the result of a database query returning multiple objects. All the functionality related to generating this iterable of objects comes from the MultipleObjectMixin. That mixin also provides the complex pagination logic—to display part of the results in one page and links to more pages.

Suppose you want to create a view that will not render a template, but will produce a list of objects in JSON format. Thats’ why the BaseListView exists. It provides an easy-to-use extension point that brings together View and MultipleObjectMixin functionality, without the overhead of the template machinery.

The Django class-based views API is a better example of multiple inheritance than Tkinter. In particular, it is easy to make sense of its mixin classes: each has a well-defined purpose, and they are all named with the …Mixin suffix.

Class-based views were not universally embraced by Django users. Many do use them in a limited way, as black boxes, but when it’s necessary to create something new, a lot of Django coders continue writing monolithic view functions that take care of all those responsibilities, instead of trying to reuse the base views and mixins.

It does take some time to learn how to leverage class-based views and how to extend them to fulfill specific application needs, but I found that it was worthwhile to study them: they eliminate a lot of boilerplate code, make it easier to reuse solutions, and even improve team communication—for example, by defining standard names to templates, and to the variables passed to template contexts. Class-based views are Django views「on rails.」

This concludes our tour of multiple inheritance and mixin classes.

Chapter Summary

We started our coverage of inheritance explaining the problem with subclassing built-in types: their native methods implemented in C do not call overridden methods in subclasses, except in very few special cases. That’s why, when we need a custom list, dict, or str type, it’s easier to subclass UserList, UserDict, or UserString—all defined in the collections module, which actually wraps the built-in types and delegate operations to them—three examples of favoring composition over inheritance in the standard library. If the desired behavior is very different from what the built-ins offer, it may be easier to subclass the appropriate ABC from collections.abc and write your own implementation.

The rest of the chapter was devoted to the double-edged sword of multiple inheritance. First we saw how the method resolution order, encoded in the __mro__ class attribute, addresses the problem of potential naming conflicts in inherited methods. We also saw how the super() built-in follows the __mro__ to call a method on a superclass. We then studied how multiple inheritance is used in the Tkinter GUI toolkit that comes with the Python standard library. Tkinter is not an example of current best practices, so we discussed some ways of coping with multiple inheritance, including careful use of mixin classes and avoiding multiple inheritance altogether by using composition instead. After considering how multiple inheritance is abused in Tkinter, we wrapped up by studying the core parts of the Django class-based views hierarchy, which I consider a better example of mixin usage.

Lennart Regebro—a very experienced Pythonista and one of this book’s technical reviewers—finds the design of Django’s mixin views hierarchy confusing. But he also wrote:

The dangers and badness of multiple inheritance are greatly overblown. I’ve actually never had a real big problem with it.

In the end, each of us may have different opinions about how to use multiple inheritance, or whether to use it at all in our own projects. But often we don’t have a choice: the frameworks we must use impose their own choices.

Further Reading

When using ABCs, multiple inheritance is not only common but practically inevitable, because each of the most fundamental collection ABCs (Sequence, Mapping, and Set) extend multiple ABCs. The source code for collections.abc (Lib/_collections_abc.py) is a good example of multiple inheritance with ABCs—many of which are also mixin classes.

Raymond Hettinger’s post Python’s super() considered super! explains the workings of super and multiple inheritance in Python from a positive perspective. It was written in response to Python’s Super is nifty, but you can’t use it (a.k.a. Python’s Super Considered Harmful) by James Knight.

Despite the titles of those posts, the problem is not really the super built-in—which in Python 3 is not as ugly as it was in Python 2. The real issue is multiple inheritance, which is inherently complicated and tricky. Michele Simionato goes beyond criticizing and actually offers a solution in his Setting Multiple Inheritance Straight: he implements traits, a constrained form of mixins that originated in the Self language. Simionato has a long series of illuminating blog posts about multiple inheritance in Python, including The wonders of cooperative inheritance, or using super in Python 3; Mixins considered harmful, part 1 and part 2; and Things to Know About Python Super, part 1, part 2 and part 3. The oldest posts use the Python 2 super syntax, but are still relevant.

I read the first edition of Grady Booch’s Object Oriented Analysis and Design, 3E (Addison-Wesley, 2007), and highly recommend it as a general primer on object oriented thinking, independent of programming language. It is a rare book that covers multiple inheritance without prejudice.

Soapbox

Think About the Classes You Really Need

The vast majority of programmers write applications, not frameworks. Even those who do write frameworks are likely to spend a lot (if not most) of their time writing applications. When we write applications, we normally don’t need to code class hierarchies. At most, we write classes that subclass from ABCs or other classes provided by the framework. As application developers, it’s very rare that we need to write a class that will act as the superclass of another. The classes we code are almost always leaf classes (i.e., leaves of the inheritance tree).

If, while working as an application developer, you find yourself building multilevel class hierarchies, it’s likely that one or more of the following applies:

You are reinventing the wheel. Go look for a framework or library that provides components you can reuse in your application.

You are using a badly designed framework. Go look for an alternative.

You are overengineering. Remember the KISS principle.

You became bored coding applications and decided to start a new framework. Congratulations and good luck!

It’s also possible that all of the above apply to your situation: you became bored and decided to reinvent the wheel by building your own overengineered and badly designed framework, which is forcing you to code class after class to solve trivial problems. Hopefully you are having fun, or at least getting paid for it.

Misbehaving Built-ins: Bug or Feature?

The built-in dict, list, and str types are essential building blocks of Python itself, so they must be fast—any performance issues in them would severely impact pretty much everything else. That’s why CPython adopted the shortcuts that cause their built-in methods to misbehave by not cooperating with methods overridden by subclasses. A possible way out of this dilemma would be to offer two implementations for each of those types: one「internal,」optimized for use by the interpreter and an external, easily extensible one.

But wait, this is what we have: UserDict, UserList, and UserString are not as fast as the built-ins but are easily extensible. The pragmatic approach taken by CPython means we also get to use, in our own applications, the highly optimized implementations that are hard to subclass. Which makes sense, considering that it’s not so often that we need a custom mapping, list, or string, but we use dict, list and str every day. We just need to be aware of the trade-offs involved.

Inheritance Across Languages

Alan Kay coined the term「object oriented,」and Smalltalk had only single inheritance, although there are forks with various forms of multiple inheritance support, including the modern Squeak and Pharo Smalltalk dialects that support traits—a language construct that fulfills the role of a mixin class, while avoiding some of the issues with multiple inheritance.

The first popular language to implement multiple inheritance was C++, and the feature was abused enough that Java—intended as a C++ replacement—was designed without support for multiple inheritance of implementation (i.e., no mixin classes). That is, until Java 8 introduced default methods that make interfaces very similar to the abstract classes used to define interfaces in C++ and in Python. Except that Java interfaces cannot have state—a key distinction. After Java, probably the most widely deployed JVM language is Scala, and it implements traits. Other languages supporting traits are the latest stable versions of PHP and Groovy, and the under-construction languages Rust and Perl 6—so it’s fair to say that traits are trendy as I write this.

Ruby offers an original take on multiple inheritance: it does not support it, but introduces mixins as a language feature. A Ruby class can include a module in its body, so the methods defined in the module become part of the class implementation. This is a「pure」form of mixin, with no inheritance involved, and it’s clear that a Ruby mixin has no influence on the type of the class where it’s used. This provides the benefits of mixins, while avoiding many of its usual problems.

Two recent languages that are getting a lot of traction severely limit inheritance: Go and Julia. Go has no inheritance at all, but it implements interfaces in a way that resembles a static form of duck typing (see Soapbox for more about this). Julia avoids the terms「classes」and has only「types.」Julia has a type hierarchy but subtypes cannot inherit structure, only behaviors, and only abstract types can be subtyped. In addition, Julia methods are implemented using multiple dispatch—a more advanced form of the mechanism we saw in Generic Functions with Single Dispatch.

* * *

[88] Alan Kay,「The Early History of Smalltalk,」in SIGPLAN Not. 28, 3 (March 1993), 69–95. Also available online. Thanks to my friend Christiano Anderson who shared this reference as I was writing this chapter.

[89] If you are curious, the experiment is in the strkeydict_dictsub.py file in the Fluent Python code repository.

[90] By the way, in this regard, PyPy behaves more「correctly」than CPython, at the expense of introducing a minor incompatibility. See「Differences between PyPy and CPython」for details.

[91] In Python 2, the first line of D.pingpong would be written as super(D, self).ping() rather than super().ping()

[92] As previously mentioned, Java 8 allows interfaces to provide method implementations as well. The new feature is called Default Methods in the official Java Tutorial.

[93] In Waterfowl and ABCs, Alex Martelli quotes Scott Meyer’s More Effective C++, which goes even further:「all non-leaf classes should be abstract」(i.e., concrete classes should not have concrete superclasses at all).

[94]「A class that is constructed primarily by inheriting from mixins and does not add its own structure or behavior is called an aggregate class.」, Grady Booch et al., Object Oriented Analysis and Design, 3E (Addison-Wesley, 2007), p. 109.

[95] Erich Gamma, Richard Helm, Ralph Johnson and John Vlissides, Design Patterns: Elements of Reusable Object-Oriented Software, Introduction, p. 20.

[96] Django programmers know that the as_view class method is the most visible part of the View interface, but it’s not relevant to us here.

[97] If you are into design patterns, you’ll notice that the Django dispatch mechanism is a dynamic variation of the Template Method pattern. It’s dynamic because the View class does not force subclasses to implement all handlers, but dispatch checks at runtime if a concrete handler is available for the specific request.

Chapter 13. Operator Overloading: Doing It Right

There are some things that I kind of feel torn about, like operator overloading. I left out operator overloading as a fairly personal choice because I had seen too many people abuse it in C++.[98]

— James Gosling Creator of Java

Operator overloading allows user-defined objects to interoperate with infix operators such as + and | or unary operators like - and ~. More generally, function invocation (()), attribute access (.), and item access/slicing ([]) are also operators in Python, but this chapter covers unary and infix operators.

In Emulating Numeric Types (Chapter 1) we saw some trivial implementations of operators in a bare bones Vector class. The __add__ and __mul__ methods in Example 1-2 were written to show how special methods support operator overloading, but there are subtle problems in their implementations that we overlooked. Also, in Example 9-2, we noted that the Vector2d.__eq__ method considers this to be True: Vector(3, 4) == [3, 4]—which may or not make sense. We will address those matters in this chapter.

In the following sections, we will cover:

How Python supports infix operators with operands of different types

Using duck typing or explicit type checks to deal with operands of various types

How an infix operator method should signal it cannot handle an operand

The special behavior of the rich comparison operators (e.g., ==, >, <=, etc.)

The default handling of augmented assignment operators, like +=, and how to overload them

Operator Overloading 101

Operator overloading has a bad name in some circles. It is a language feature that can be (and has been) abused, resulting in programmer confusion, bugs, and unexpected performance bottlenecks. But if well used, it leads to pleasurable APIs and readable code. Python strikes a good balance between flexibility, usability, and safety by imposing some limitations:

We cannot overload operators for the built-in types.

We cannot create new operators, only overload existing ones.

A few operators can’t be overloaded: is, and, or, not (but the bitwise &, |, ~, can).

In Chapter 10, we already had one infix operator in Vector: ==, supported by the __eq__ method. In this chapter, we’ll improve the implementation of __eq__ to better handle operands of types other than Vector. However, the rich comparison operators (==, !=, >, <, >=, <=) are special cases in operator overloading, so we’ll start by overloading four arithmetic operators in Vector: the unary - and +, followed by the infix + and *.

Let’s start with the easiest topic: unary operators.

Unary Operators

In The Python Language Reference,「6.5. Unary arithmetic and bitwise operations」lists three unary operators, shown here with their associated special methods:

- (__neg__)

Arithmetic unary negation. If x is -2 then -x == 2.

+ (__pos__)

Arithmetic unary plus. Usually x == +x, but there are a few cases when that’s not true. See When x and +x Are Not Equal if you’re curious.

~ (__invert__)

Bitwise inverse of an integer, defined as ~x == -(x+1). If x is 2 then ~x == -3.

The Data Model」chapter of The Python Language Reference also lists the abs(…) built-in function as a unary operator. The associated special method is __abs__, as we’ve seen before, starting with Emulating Numeric Types.

It’s easy to support the unary operators. Simply implement the appropriate special method, which will receive just one argument: self. Use whatever logic makes sense in your class, but stick to the fundamental rule of operators: always return a new object. In other words, do not modify self, but create and return a new instance of a suitable type.

In the case of - and +, the result will probably be an instance of the same class as self; for +, returning a copy of self is the best approach most of the time. For abs(…), the result should be a scalar number. As for ~, it’s difficult to say what would be a sensible result if you’re not dealing with bits in an integer, but in an ORM it could make sense to return the negation of an SQL WHERE clause, for example.

As promised before, we’ll implement several new operators on the Vector class from Chapter 10. Example 13-1 shows the __abs__ method we already had in Example 10-16, and the newly added __neg__ and __pos__ unary operator method.

Example 13-1. vector_v6.py: unary operators - and + added to Example 10-16

def __abs__(self): return math.sqrt(sum(x * x for x in self)) def __neg__(self): return Vector(-x for x in self) def __pos__(self): return Vector(self)

To compute -v, build a new Vector with every component of self negated.

To compute +v, build a new Vector with every component of self.

Recall that Vector instances are iterable, and the Vector.__init__ takes an iterable argument, so the implementations of __neg__ and __pos__ are short and sweet.

We’ll not implement __invert__, so if the user tries ~v on a Vector instance, Python will raise TypeError with a clear message:「bad operand type for unary ~: 'Vector'.」

The following sidebar covers a curiosity that may help you win a bet about unary + someday. The next important topic is Overloading + for Vector Addition.

When x and +x Are Not Equal

Everybody expects that x == +x, and that is true almost all the time in Python, but I found two cases in the standard library where x != +x.

The first case involves the decimal.Decimal class. You can have x != +x if x is a Decimal instance created in an arithmetic context and +x is then evaluated in a context with different settings. For example, x is calculated in a context with a certain precision, but the precision of the context is changed and then +x is evaluated. See Example 13-2 for a demonstration.

Example 13-2. A change in the arithmetic context precision may cause x to differ from +x

>>> import decimal >>> ctx = decimal.getcontext() >>> ctx.prec = 40 >>> one_third = decimal.Decimal('1') / decimal.Decimal('3') >>> one_third Decimal('0.3333333333333333333333333333333333333333') >>> one_third == +one_third True >>> ctx.prec = 28 >>> one_third == +one_third False >>> +one_third Decimal('0.3333333333333333333333333333')

Get a reference to the current global arithmetic context.

Set the precision of the arithmetic context to 40.

Compute 1/3 using the current precision.

Inspect the result; there are 40 digits after the decimal point.

one_third == +one_third is True.

Lower precision to 28—the default for Decimal arithmetic in Python 3.4.

Now one_third == +one_third is False.

Inspect +one_third; there are 28 digits after the '.' here.

The fact is that each occurrence of the expression +one_third produces a new Decimal instance from the value of one_third, but using the precision of the current arithmetic context.

The second case where x != +x you can find in the collections.Counter documentation. The Counter class implements several arithmetic operators, including infix + to add the tallies from two Counter instances. However, for practical reasons, Counter addition discards from the result any item with a negative or zero count. And the prefix + is a shortcut for adding an empty Counter, therefore it produces a new Counter preserving only the tallies that are greater than zero. See Example 13-3.

Example 13-3. Unary + produces a new Counter without zeroed or negative tallies

>>> ct = Counter('abracadabra') >>> ct Counter({'a': 5, 'r': 2, 'b': 2, 'd': 1, 'c': 1}) >>> ct['r'] = -3 >>> ct['d'] = 0 >>> ct Counter({'a': 5, 'b': 2, 'c': 1, 'd': 0, 'r': -3}) >>> +ct Counter({'a': 5, 'b': 2, 'c': 1})

Now, back to our regularly scheduled programming.

Overloading + for Vector Addition

Note

The Vector class is a sequence type, and the section「3.3.6. Emulating container types」in the「Data Model」chapter says sequences should support the + operator for concatenation and * for repetition. However, here we will implement + and * as mathematical vector operations, which are a bit harder but more meaningful for a Vector type.

Adding two Euclidean vectors results in a new vector in which the components are the pairwise additions of the components of the addends. To illustrate:

>>> v1 = Vector([3, 4, 5]) >>> v2 = Vector([6, 7, 8]) >>> v1 + v2 Vector([9.0, 11.0, 13.0]) >>> v1 + v2 == Vector([3+6, 4+7, 5+8]) True

What happens if we try to add two Vector instances of different lengths? We could raise an error, but considering practical applications (such as information retrieval), it’s better to fill out the shortest Vector with zeros. This is the result we want:

>>> v1 = Vector([3, 4, 5, 6]) >>> v3 = Vector([1, 2]) >>> v1 + v3 Vector([4.0, 6.0, 5.0, 6.0])

Given these basic requirements, the implementation of __add__ is short and sweet, as shown in Example 13-4.

Example 13-4. Vector.add method, take #1

# inside the Vector class def __add__(self, other): pairs = itertools.zip_longest(self, other, fillvalue=0.0) # return Vector(a + b for a, b in pairs) #

pairs is a generator that will produce tuples (a, b) where a is from self, and b is from other. If self and other have different lengths, fillvalue is used to supply the missing values for the shortest iterable.

A new Vector is built from a generator expression producing one sum for each item in pairs.

Note how __add__ returns a new Vector instance, and does not affect self or other.

Warning

Special methods implementing unary or infix operators should never change their operands. Expressions with such operators are expected to produce results by creating new objects. Only augmented assignment operators may change the first operand (self), as discussed in Augmented Assignment Operators.

Example 13-4 allows adding Vector to a Vector2d, and Vector to a tuple or to any iterable that produces numbers, as Example 13-5 proves.

Example 13-5. Vector.__add__ take #1 supports non-Vector objects, too

>>> v1 = Vector([3, 4, 5]) >>> v1 + (10, 20, 30) Vector([13.0, 24.0, 35.0]) >>> from vector2d_v3 import Vector2d >>> v2d = Vector2d(1, 2) >>> v1 + v2d Vector([4.0, 6.0, 5.0])

Both additions in Example 13-5 work because __add__ uses zip_longest(…), which can consume any iterable, and the generator expression to build the new Vector merely performs a + b with the pairs produced by zip_longest(…), so an iterable producing any number items will do.

However, if we swap the operands (Example 13-6), the mixed-type additions fail..

Example 13-6. Vector.__add__ take #1 fails with non-Vector left operands

>>> v1 = Vector([3, 4, 5]) >>> (10, 20, 30) + v1 Traceback (most recent call last): File "<stdin>", line 1, in <module> TypeError: can only concatenate tuple (not "Vector") to tuple >>> from vector2d_v3 import Vector2d >>> v2d = Vector2d(1, 2) >>> v2d + v1 Traceback (most recent call last): File "<stdin>", line 1, in <module> TypeError: unsupported operand type(s) for +: 'Vector2d' and 'Vector'

To support operations involving objects of different types, Python implements a special dispatching mechanism for the infix operator special methods. Given an expression a + b, the interpreter will perform these steps (also see Figure 13-1):

If a has __add__, call a.__add__(b) and return result unless it’s NotImplemented.

If a doesn’t have __add__, or calling it returns NotImplemented, check if b has __radd__, then call b.__radd__(a) and return result unless it’s NotImplemented.

If b doesn’t have __radd__, or calling it returns NotImplemented, raise TypeError with an unsupported operand types message.

Figure 13-1. Flowchart for computing a + b with __add__ and __radd__

The __radd__ method is called the「reflected」or「reversed」version of __add__. I prefer to call them「reversed」special methods.[99] Three of this book’s technical reviewers—Alex, Anna, and Leo—told me they like to think of them as the「right」special methods, because they are called on the righthand operand. Whatever「r」-word you prefer, that’s what the「r」prefix stands for in __radd__, __rsub__, and the like.

Therefore, to make the mixed-type additions in Example 13-6 work, we need to implement the Vector.__radd__ method, which Python will invoke as a fall back if the left operand does not implement __add__ or if it does but returns NotImplemented to signal that it doesn’t know how to handle the right operand.

Warning

Do not confuse NotImplemented with NotImplementedError. The first, NotImplemented, is a special singleton value that an infix operator special method should return to tell the interpreter it cannot handle a given operand. In contrast, NotImplementedError is an exception that stub methods in abstract classes raise to warn that they must be overwritten by subclasses.

The simplest possible __radd__ that works is shown in Example 13-7.

Example 13-7. Vector.__add__ and __radd__ methods

# inside the Vector class def __add__(self, other): # pairs = itertools.zip_longest(self, other, fillvalue=0.0) return Vector(a + b for a, b in pairs) def __radd__(self, other): # return self + other

No changes to __add__ from Example 13-4; listed here because __radd__ uses it.

__radd__ just delegates to __add__.

Often, __radd__ can be as simple as that: just invoke the proper operator, therefore delegating to __add__ in this case. This applies to any commutative operator; + is commutative when dealing with numbers or our vectors, but it’s not commutative when concatenating sequences in Python.

The methods in Example 13-4 work with Vector objects, or any iterable with numeric items, such as a Vector2d, a tuple of integers, or an array of floats. But if provided with a noniterable object, __add__ fails with a message that is not very helpful, as in Example 13-8.

Example 13-8. Vector.__add__ method needs an iterable operand

>>> v1 + 1 Traceback (most recent call last): File "<stdin>", line 1, in <module> File "vector_v6.py", line 328, in __add__ pairs = itertools.zip_longest(self, other, fillvalue=0.0) TypeError: zip_longest argument #2 must support iteration

Another unhelpful message is given if an operand is iterable but its items cannot be added to the float items in the Vector. See Example 13-9.

Example 13-9. Vector.__add__ method needs an iterable with numeric items

>>> v1 + 'ABC' Traceback (most recent call last): File "<stdin>", line 1, in <module> File "vector_v6.py", line 329, in __add__ return Vector(a + b for a, b in pairs) File "vector_v6.py", line 243, in __init__ self._components = array(self.typecode, components) File "vector_v6.py", line 329, in <genexpr> return Vector(a + b for a, b in pairs) TypeError: unsupported operand type(s) for +: 'float' and 'str'

The problems in Examples 13-8 and 13-9 actually go deeper than obscure error messages: if an operator special method cannot return a valid result because of type incompatibility, it should return NotImplemented and not raise TypeError. By returning NotImplemented, you leave the door open for the implementer of the other operand type to perform the operation when Python tries the reversed method call.

In the spirit of duck typing, we will refrain from testing the type of the other operand, or the type of its elements. We’ll catch the exceptions and return NotImplemented. If the interpreter has not yet reversed the operands, it will try that. If the reverse method call returns NotImplemented, then Python will raise issue TypeError with a standard error message like「unsupported operand type(s) for +: Vector and str.」

The final implementation of the special methods for Vector addition are in Example 13-10.

Example 13-10. vector_v6.py: operator + methods added to vector_v5.py (Example 10-16)

def __add__(self, other): try: pairs = itertools.zip_longest(self, other, fillvalue=0.0) return Vector(a + b for a, b in pairs) except TypeError: return NotImplemented def __radd__(self, other): return self + other

Warning

If an infix operator method raises an exception, it aborts the operator dispatch algorithm. In the particular case of TypeError, it is often better to catch it and return NotImplemented. This allows the interpreter to try calling the reversed operator method, which may correctly handle the computation with the swapped operands, if they are of different types.

At this point, we have safely overloaded the + operator by writing __add__ and __radd__. We will now tackle another infix operator: *.

Overloading * for Scalar Multiplication

What does Vector([1, 2, 3]) * x mean? If x is a number, that would be a scalar product, and the result would be a new Vector with each component multiplied by x—also known as an elementwise multiplication:

>>> v1 = Vector([1, 2, 3]) >>> v1 * 10 Vector([10.0, 20.0, 30.0]) >>> 11 * v1 Vector([11.0, 22.0, 33.0])

Another kind of product involving Vector operands would be the dot product of two vectors—or matrix multiplication, if you take one vector as a 1 × N matrix and the other as an N × 1 matrix. The current practice in NumPy and similar libraries is not to overload the * with these two meanings, but to use * only for the scalar product. For example, in NumPy, numpy.dot() computes the dot product.[100]

Back to our scalar product, again we start with the simplest __mul__ and __rmul__ methods that could possibly work:

# inside the Vector class def __mul__(self, scalar): return Vector(n * scalar for n in self) def __rmul__(self, scalar): return self * scalar

Those methods do work, except when provided with incompatible operands. The scalar argument has to be a number that when multiplied by a float produces another float (because our Vector class uses an array of floats internally). So a complex number will not do, but the scalar can be an int, a bool (because bool is a subclass of int), or even a fractions.Fraction instance.

We could use the same duck typing technique as we did in Example 13-10 and catch a TypeError in __mul__, but there is another, more explicit way that makes sense in this situation: goose typing. We use isinstance() to check the type of scalar, but instead of hardcoding some concrete types, we check against the numbers.Real ABC, which covers all the types we need, and keeps our implementation open to future numeric types that declare themselves actual or virtual subclasses of the numbers.Real ABC. Example 13-11 shows a practical use of goose typing—an explicit check against an abstract type; see the_ Fluent Python_ code repository for the full listing.

Warning

As you may recall from ABCs in the Standard Library, decimal.Decimal is not registered as a virtual subclass of numbers.Real. Thus, our Vector class will not handle decimal.Decimal numbers.

Example 13-11. vector_v7.py: operator * methods added

from array import array import reprlib import math import functools import operator import itertools import numbers # class Vector: typecode = 'd' def __init__(self, components): self._components = array(self.typecode, components) # many methods omitted in book listing, see vector_v7.py # in https://github.com/fluentpython/example-code ... def __mul__(self, scalar): if isinstance(scalar, numbers.Real): # return Vector(n * scalar for n in self) else: # return NotImplemented def __rmul__(self, scalar): return self * scalar #

Import the numbers module for type checking.

If scalar is an instance of a numbers.Real subclass, create new Vector with multiplied component values.

Otherwise, raise TypeError with an explicit message.

In this example, __rmul__ works fine by just performing self * scalar, delegating to the __mul__ method.

With Example 13-11, we can multiply Vectors by scalar values of the usual and not so usual numeric types:

>>> v1 = Vector([1.0, 2.0, 3.0]) >>> 14 * v1 Vector([14.0, 28.0, 42.0]) >>> v1 * True Vector([1.0, 2.0, 3.0]) >>> from fractions import Fraction >>> v1 * Fraction(1, 3) Vector([0.3333333333333333, 0.6666666666666666, 1.0])

Implementing + and * we saw the most common patterns for coding infix operators. The techniques we described for + and * are applicable to all operators listed in Table 13-1 (the in-place operators will be covered in Augmented Assignment Operators).

Table 13-1. Infix operator method names (the in-place operators are used for augmented assignment; comparison operators are in Table 13-2)

Operator Forward Reverse In-place Description

+

__add__

__radd__

__iadd__

Addition or concatenation

-

__sub__

__rsub__

__isub__

Subtraction

*

__mul__

__rmul__

__imul__

Multiplication or repetition

/

__truediv__

__rtruediv__

__itruediv__

True division

//

__floordiv__

__rfloordiv__

__ifloordiv__

Floor division

%

__mod__

__rmod__

__imod__

Modulo

divmod()

__divmod__

__rdivmod__

__idivmod__

Returns tuple of floor division quotient and modulo

**, pow()

__pow__

__rpow__

__ipow__

Exponentiation[a]

@

__matmul__

__rmatmul__

__imatmul__

Matrix multiplication[b]

&

__and__

__rand__

__iand__

Bitwise and

|

__or__

__ror__

__ior__

Bitwise or

^

__xor__

__rxor__

__ixor__

Bitwise xor

<<

__lshift__

__rlshift__

__ilshift__

Bitwise shift left

>>

__rshift__

__rrshift__

__irshift__

Bitwise shift right

[a] pow takes an optional third argument, modulo: pow(a, b, modulo), also supported by the special methods when invoked directly (e.g., a.__pow__(b, modulo)).

[b] New in Python 3.5.

The rich comparison operators are another category of infix operators, using a slightly different set of rules. We cover them in the next main section: Rich Comparison Operators.

The following optional sidebar is about the @ operator introduced in Python 3.5—not yet released at the time of this writing.

The New @ Infix Operator in Python 3.5

Python 3.4 does not have an infix operator for the dot product. However, as I write this, Python 3.5 pre-alpha already implements PEP 465 — A dedicated infix operator for matrix multiplication, making the @ sign available for that purpose (e.g., a @ b is the dot product of a and b). The @ operator is supported by the special methods __matmul__, __rmatmul__, and __imatmul__, named for「matrix multiplication.」These methods are not used anywhere in the standard library at this time, but are recognized by the interpreter in Python 3.5 so the NumPy team—and the rest of us—can support the @ operator in user-defined types. The parser was also changed to handle the infix @ (a @ b is a syntax error in Python 3.4).

Just for fun, after compiling Python 3.5 from source, I was able to implement and test the @ operator for the Vector dot product.

These are the simple tests I did:

>>> va = Vector([1, 2, 3]) >>> vz = Vector([5, 6, 7]) >>> va @ vz == 38.0 # 1*5 + 2*6 + 3*7 True >>> [10, 20, 30] @ vz 380.0 >>> va @ 3 Traceback (most recent call last): ... TypeError: unsupported operand type(s) for @: 'Vector' and 'int'

And here is the code of the relevant special methods:

class Vector: # many methods omitted in book listing def __matmul__(self, other): try: return sum(a * b for a, b in zip(self, other)) except TypeError: return NotImplemented def __rmatmul__(self, other): return self @ other

The full source is in the vector_py3_5.py file in the Fluent Python code repository.

Remember to try it with Python 3.5, otherwise you’ll get a SyntaxError!

Rich Comparison Operators

The handling of the rich comparison operators ==, !=, >, <, >=, <= by the Python interpreter is similar to what we just saw, but differs in two important aspects:

The same set of methods are used in forward and reverse operator calls. The rules are summarized in Table 13-2. For example, in the case of ==, both the forward and reverse calls invoke __eq__, only swapping arguments; and a forward call to __gt__ is followed by a reverse call to __lt__ with the swapped arguments.

In the case of == and !=, if the reverse call fails, Python compares the object IDs instead of raising TypeError.

Table 13-2. Rich comparison operators: reverse methods invoked when the initial method call returns NotImplemented

Group Infix operator Forward method call Reverse method call Fall back

Equality

a == b

a.__eq__(b)

b.__eq__(a)

Return id(a) == id(b)

a != b

a.__ne__(b)

b.__ne__(a)

Return not (a == b)

Ordering

a > b

a.__gt__(b)

b.__lt__(a)

Raise TypeError

a < b

a.__lt__(b)

b.__gt__(a)

Raise TypeError

a >= b

a.__ge__(b)

b.__le__(a)

Raise TypeError

a <= b

a.__le__(b)

b.__ge__(a)

Raise TypeError

New Behavior in Python 3

The fallback step for all comparison operators changed from Python 2. For __ne__, Python 3 now returns the negated result of __eq__. For the ordering comparison operators, Python 3 raises TypeError with a message like 'unorderable types: int() < tuple()'. In Python 2, those comparisons produced weird results taking into account object types and IDs in some arbitrary way. However, it really makes no sense to compare an int to a tuple, for example, so raising TypeError in such cases is a real improvement in the language.

Given these rules, let’s review and improve the behavior of the Vector.__eq__ method, which was coded as follows in vector_v5.py (Example 10-16):

class Vector: # many lines omitted def __eq__(self, other): return (len(self) == len(other) and all(a == b for a, b in zip(self, other)))

That method produces the results in Example 13-12.

Example 13-12. Comparing a Vector to a Vector, a Vector2d, and a tuple

>>> va = Vector([1.0, 2.0, 3.0]) >>> vb = Vector(range(1, 4)) >>> va == vb # True >>> vc = Vector([1, 2]) >>> from vector2d_v3 import Vector2d >>> v2d = Vector2d(1, 2) >>> vc == v2d # True >>> t3 = (1, 2, 3) >>> va == t3 # True

Two Vector instances with equal numeric components compare equal.

A Vector and a Vector2d are also equal if their components are equal.

A Vector is also considered equal to a tuple or any iterable with numeric items of equal value.

The last one of the results in Example 13-12 is probably not desirable. I really have no hard rule about this; it depends on the application context. But the Zen of Python says:

In the face of ambiguity, refuse the temptation to guess.

Excessive liberality in the evaluation of operands may lead to surprising results, and programmers hate surprises.

Taking a clue from Python itself, we can see that [1,2] == (1, 2) is False. Therefore, let’s be conservative and do some type checking. If the second operand is a Vector instance (or an instance of a Vector subclass), then use the same logic as the current __eq__. Otherwise, return NotImplemented and let Python handle that. See Example 13-13.

Example 13-13. vector_v8.py: improved __eq__ in the Vector class

def __eq__(self, other): if isinstance(other, Vector): return (len(self) == len(other) and all(a == b for a, b in zip(self, other))) else: return NotImplemented

If the other operand is an instance of Vector (or of a Vector subclass), perform the comparison as before.

Otherwise, return NotImplemented.

If you run the tests in Example 13-12 with the new Vector.__eq__ from Example 13-13, what you get now is shown in Example 13-14.

Example 13-14. Same comparisons as Example 13-12: last result changed

>>> va = Vector([1.0, 2.0, 3.0]) >>> vb = Vector(range(1, 4)) >>> va == vb # True >>> vc = Vector([1, 2]) >>> from vector2d_v3 import Vector2d >>> v2d = Vector2d(1, 2) >>> vc == v2d # True >>> t3 = (1, 2, 3) >>> va == t3 # False

Same result as before, as expected.

Same result as before, but why? Explanation coming up.

Different result; this is what we wanted. But why does it work? Read on…

Among the three results in Example 13-14, the first one is no news, but the last two were caused by __eq__ returning NotImplemented in Example 13-13. Here is what happens in the example with a Vector and a Vector2d, step by step:

To evaluate vc == v2d, Python calls Vector.__eq__(vc, v2d).

Vector.__eq__(vc, v2d) verifies that v2d is not a Vector and returns NotImplemented.

Python gets NotImplemented result, so it tries Vector2d.__eq__(v2d, vc).

Vector2d.__eq__(v2d, vc) turns both operands into tuples an compares them: the result is True (the code for Vector2d.__eq__ is in Example 9-9).

As for the comparison between Vector and tuple in Example 13-14, the actual steps are:

To evaluate va == t3, Python calls Vector.__eq__(va, t3).

Vector.__eq__(va, t3) verifies that t3 is not a Vector and returns NotImplemented.

Python gets NotImplemented result, so it tries tuple.__eq__(t3, va).

tuple.__eq__(t3, va) has no idea what a Vector is, so it returns NotImplemented.

In the special case of ==, if the reversed call returns NotImplemented, Python compares object IDs as a last resort.

How about !=? We don’t need to implement it because the fallback behavior of the __ne__ inherited from object suits us: when __eq__ is defined and does not return NotImplemented, __ne__ returns that result negated.

In other words, given the same objects we used in Example 13-14, the results for != are consistent:

>>> va != vb False >>> vc != v2d False >>> va != (1, 2, 3) True

The __ne__ inherited from object works like the following code—except that the original is written in C:[101]

def __ne__(self, other): eq_result = self == other if eq_result is NotImplemented: return NotImplemented else: return not eq_result

Python 3 Documentation Bug

As I write this, the rich comparison method documentation states:「The truth of x==y does not imply that x!=y is false. Accordingly, when defining __eq__(), one should also define __ne__() so that the operators will behave as expected.」That was true for Python 2, but in Python 3 that’s not good advice, because a useful default __ne__ implementation is inherited from the object class, and it’s rarely necessary to override it. The new behavior is documented in Guido’s What’s New in Python 3.0, in the section「Operators And Special Methods.」The documentation bug is recorded as issue 4395.

After covering the essentials of infix operator overloading, let’s turn to a different class of operators: the augmented assignment operators.

Augmented Assignment Operators

Our Vector class already supports the augmented assignment operators += and *=. Example 13-15 shows them in action.

Example 13-15. Augmented assignment works with immutable targets by creating new instances and rebinding

>>> v1 = Vector([1, 2, 3]) >>> v1_alias = v1 # >>> id(v1) # 4302860128 >>> v1 += Vector([4, 5, 6]) # >>> v1 # Vector([5.0, 7.0, 9.0]) >>> id(v1) # 4302859904 >>> v1_alias # Vector([1.0, 2.0, 3.0]) >>> v1 *= 11 # >>> v1 # Vector([55.0, 77.0, 99.0]) >>> id(v1) 4302858336

Create alias so we can inspect the Vector([1, 2, 3]) object later.

Remember the ID of the initial Vector bound to v1.

Perform augmented addition.

The expected result…

…but a new Vector was created.

Inspect v1_alias to confirm the original Vector was not altered.

Perform augmented multiplication.

Again, the expected result, but a new Vector was created.

If a class does not implement the in-place operators listed in Table 13-1, the augmented assignment operators are just syntactic sugar: a += b is evaluated exactly as a = a + b. That’s the expected behavior for immutable types, and if you have __add__ then += will work with no additional code.

However, if you do implement an in-place operator method such as __iadd__, that method is called to compute the result of a += b. As the name says, those operators are expected to change the lefthand operand in place, and not create a new object as the result.

Warning

The in-place special methods should never be implemented for immutable types like our Vector class. This is fairly obvious, but worth stating anyway.

To show the code of an in-place operator, we will extend the BingoCage class from Example 11-12 to implement __add__ and __iadd__.

We’ll call the subclass AddableBingoCage. Example 13-16 is the behavior we want for the + operator.

Example 13-16. A new AddableBingoCage instance can be created with

>>> vowels = 'AEIOU' >>> globe = AddableBingoCage(vowels) >>> globe.inspect() ('A', 'E', 'I', 'O', 'U') >>> globe.pick() in vowels True >>> len(globe.inspect()) 4 >>> globe2 = AddableBingoCage('XYZ') >>> globe3 = globe + globe2 >>> len(globe3.inspect()) 7 >>> void = globe + [10, 20] Traceback (most recent call last): ... TypeError: unsupported operand type(s) for +: 'AddableBingoCage' and 'list'

