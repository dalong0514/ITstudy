$ time python3 mem_test.py vector2d_v3.py Selected Vector2d type: vector2d_v3.Vector2d Creating 10,000,000 Vector2d instances Initial RAM usage: 5,623,808 Final RAM usage: 1,558,482,944 real 0m16.721s user 0m15.568s sys 0m1.149s $ time python3 mem_test.py vector2d_v3_slots.py Selected Vector2d type: vector2d_v3_slots.Vector2d Creating 10,000,000 Vector2d instances Initial RAM usage: 5,718,016 Final RAM usage: 655,466,496 real 0m13.605s user 0m13.163s sys 0m0.434s

As Example 9-12 reveals, the RAM footprint of the script grows to 1.5 GB when instance __dict__ is used in each of the 10 million Vector2d instances, but that is reduced to 655 MB when Vector2d has a __slots__ attribute. The __slots__ version is also faster. The mem_test.py script in this test basically deals with loading a module, checking memory usage, and formatting results. The code is not really relevant here so it’s in Appendix A, Example A-4.

Warning

When __slots__ is specified in a class, its instances will not be allowed to have any other attributes apart from those named in __slots__. This is really a side effect, and not the reason why __slots__ exists. It’s considered bad form to use __slots__ just to prevent users of your class from creating new attributes in the instances if they want to. __slots__ should used for optimization, not for programmer restraint.

It may be possible, however, to「save memory and eat it too」: if you add the '__dict__' name to the __slots__ list, your instances will keep attributes named in __slots__ in the per-instance tuple, but will also support dynamically created attributes, which will be stored in the usual __dict__. Of course, having '__dict__' in __slots__ may entirely defeat its purpose, depending on the number of static and dynamic attributes in each instance and how they are used. Careless optimization is even worse than premature optimization.

There is another special per-instance attribute that you may want to keep: the __weakref__ attribute is necessary for an object to support weak references (covered in Weak References). That attribute is present by default in instances of user-defined classes. However, if the class defines __slots__, and you need the instances to be targets of weak references, then you need to include '__weakref__' among the attributes named in __slots__.

To summarize, __slots__ has some caveats and should not be abused just for the sake of limiting what attributes can be assigned by users. It is mostly useful when working with tabular data such as database records where the schema is fixed by definition and the datasets may be very large. However, if you do this kind of work often, you must check out not only NumPy, but also the pandas data analysis library, which can handle nonnumeric data and import/export to many different tabular data formats.

The Problems with __slots__

To summarize, __slots__ may provide significant memory savings if properly used, but there are a few caveats:

You must remember to redeclare __slots__ in each subclass, because the inherited attribute is ignored by the interpreter.

Instances will only be able to have the attributes listed in __slots__, unless you include '__dict__' in __slots__ (but doing so may negate the memory savings).

Instances cannot be targets of weak references unless you remember to include '__weakref__' in __slots__.

If your program is not handling millions of instances, it’s probably not worth the trouble of creating a somewhat unusual and tricky class whose instances may not accept dynamic attributes or may not support weak references. Like any optimization, __slots__ should be used only if justified by a present need and when its benefit is proven by careful profiling.

The last topic in this chapter has to do with overriding a class attribute in instances and subclasses.

Overriding Class Attributes

A distinctive feature of Python is how class attributes can be used as default values for instance attributes. In Vector2d there is the typecode class attribute. It’s used twice in the __bytes__ method, but we read it as self.typecode by design. Because Vector2d instances are created without a typecode attribute of their own, self.typecode will get the Vector2d.typecode class attribute by default.

But if you write to an instance attribute that does not exist, you create a new instance attribute—e.g., a typecode instance attribute—and the class attribute by the same name is untouched. However, from then on, whenever the code handling that instance reads self.typecode, the instance typecode will be retrieved, effectively shadowing the class attribute by the same name. This opens the possibility of customizing an individual instance with a different typecode.

The default Vector2d.typecode is 'd', meaning each vector component will be represented as an 8-byte double precision float when exporting to bytes. If we set the typecode of a Vector2d instance to 'f' prior to exporting, each component will be exported as a 4-byte single precision float. Example 9-13 demonstrates.

Warning

We are discussing adding a custom instance attribute, therefore Example 9-13 uses the Vector2d implementation without __slots__ as listed in Example 9-9.

Example 9-13. Customizing an instance by setting the typecode attribute that was formerly inherited from the class

>>> from vector2d_v3 import Vector2d >>> v1 = Vector2d(1.1, 2.2) >>> dumpd = bytes(v1) >>> dumpd b'd\x9a\x99\x99\x99\x99\x99\xf1?\x9a\x99\x99\x99\x99\x99\x01@' >>> len(dumpd) # 17 >>> v1.typecode = 'f' # >>> dumpf = bytes(v1) >>> dumpf b'f\xcd\xcc\x8c?\xcd\xcc\x0c@' >>> len(dumpf) # 9 >>> Vector2d.typecode # 'd'

Default bytes representation is 17 bytes long.

Set typecode to 'f' in the v1 instance.

Now the bytes dump is 9 bytes long.

Vector2d.typecode is unchanged; only the v1 instance uses typecode 'f'.

Now it should be clear why the bytes export of a Vector2d is prefixed by the typecode: we wanted to support different export formats.

If you want to change a class attribute you must set it on the class directly, not through an instance. You could change the default typecode for all instances (that don’t have their own typecode) by doing this:

>>> Vector2d.typecode = 'f'

However, there is an idiomatic Python way of achieving a more permanent effect, and being more explicit about the change. Because class attributes are public, they are inherited by subclasses, so it’s common practice to subclass just to customize a class data attribute. The Django class-based views use this technique extensively. Example 9-14 shows how.

Example 9-14. The ShortVector2d is a subclass of Vector2d, which only overwrites the default typecode

>>> from vector2d_v3 import Vector2d >>> class ShortVector2d(Vector2d): # ... typecode = 'f' ... >>> sv = ShortVector2d(1/11, 1/27) # >>> sv ShortVector2d(0.09090909090909091, 0.037037037037037035) # >>> len(bytes(sv)) # 9

Create ShortVector2d as a Vector2d subclass just to overwrite the typecode class attribute.

Build ShortVector2d instance sv for demonstration.

Inspect the repr of sv.

Check that the length of the exported bytes is 9, not 17 as before.

This example also explains why I did not hardcode the class_name in Vecto2d.__repr__, but instead got it from type(self).__name__, like this:

# inside class Vector2d: def __repr__(self): class_name = type(self).__name__ return '{}({!r}, {!r})'.format(class_name, *self)

If I had hardcoded the class_name, subclasses of Vector2d like ShortVector2d would have to overwrite __repr__ just to change the class_name. By reading the name from the type of the instance, I made __repr__ safer to inherit.

This ends our coverage of implementing a simple class that leverages the data model to play well with the rest of Python—offering different object representations, implementing a custom formatting code, exposing read-only attributes, and supporting hash() to integrate with sets and mappings.

Chapter Summary

The aim of this chapter was to demonstrate the use of special methods and conventions in the construction of a well-behaved Pythonic class.

Is vector2d_v3.py (Example 9-9) more Pythonic than vector2d_v0.py (Example 9-2)? The Vector2d class in vector2d_v3.py certainly exhibits more Python features. But whether the first or the last Vector2d implementation is more idiomatic depends on the context where it would be used. Tim Peter’s Zen of Python says:

Simple is better than complex.

A Pythonic object should be as simple as the requirements allow—and not a parade of language features.

But my goal in expanding the Vector2d code was to provide context for discussing Python special methods and coding conventions. If you look back at Table 1-1, the several listings in this chapter demonstrated:

All string/bytes representation methods: __repr__, __str__, __format__, and __bytes__.

Several methods for converting an object to a number: __abs__, __bool__, __hash__.

The __eq__ operator, to test bytes conversion and to enable hashing (along with __hash__).

While supporting conversion to bytes we also implemented an alternative constructor, Vector2d.frombytes(), which provided the context for discussing the decorators @classmethod (very handy) and @staticmethod (not so useful, module-level functions are simpler). The frombytes method was inspired by it’s namesake in the array.array class.

We saw that the Format Specification Mini-Language is extensible by implementing a __format__ method that does some minimal parsing of format_spec provided to the format(obj, format_spec) built-in or within replacement fields '{:«format_spec»}' in strings used with the str.format method.

In preparation to make Vector2d instances hashable, we made an effort to make them immutable, at least preventing accidental changes by coding the x and y attributes as private, and exposing them as read-only properties. We then implemented __hash__ using the recommended technique of xor-ing the hashes of the instance attributes.

We then discussed the memory savings and the caveats of declaring a __slots__ attribute in Vector2d. Because using __slots__ is somewhat tricky, it really makes sense only when handling a very large number of instances—think millions of instances, not just thousands.

The last topic we covered was the overriding of a class attribute accessed via the instances (e.g., self.typecode). We did that first by creating an instance attribute, and then by subclassing and overwriting at the class level.

Throughout the chapter, I mentioned how design choices in the examples were informed by studying the API of standard Python objects. If this chapter can be summarized in one sentence, this is it:

To build Pythonic objects, observe how real Python objects behave.

— Ancient Chinese proverb

Further Reading

This chapter covered several special methods of the data model, so naturally the primary references are the same as the ones provided in Chapter 1, which gave a high-level view of the same topic. For convenience, I’ll repeat those four earlier recommendations here, and add a few other ones:

「Data Model」chapter of The Python Language Reference

Most of the methods we used in this chapter are documented in「3.3.1. Basic customization」.

Python in a Nutshell, 2nd Edition, by Alex Martelli

Excellent coverage of the data model, even if only Python 2.5 is covered (in the second edition). The fundamental concepts are all the same and most of the Data Model APIs haven’t changed at all since Python 2.2, when built-in types and user-defined classes became more compatible.

Python Cookbook, 3rd Edition, by David Beazley and Brian K. Jones

Very modern coding practices demonstrated through recipes. Chapter 8,「Classes and Objects」in particular has several solutions related to discussions in this chapter.

Python Essential Reference, 4th Edition, by David Beazley

Covers the data model in detail in the context of Python 2.6 and Python 3.

In this chapter, we covered every special method related to object representation, except __index__. It’s used to coerce an object to an integer index in the specific context of sequence slicing, and was created to solve a need in NumPy. In practice, you and I are not likely to need to implement __index__ unless we decide to write a new numeric data type, and we want it to be usable as arguments to __getitem__. If you are curious about it, A.M. Kuchling’s What’s New in Python 2.5 has a short explanation, and PEP 357 — Allowing Any Object to be Used for Slicing details the need for __index__, from the perspective of an implementor of a C-extension, Travis Oliphant, the lead author of NumPy.

An early realization of the need for distinct string representations for objects appeared in Smalltalk. The 1996 article「How to Display an Object as a String: printString and displayString」by Bobby Woolf discusses the implementation of the printString and displayString methods in that language. From that article, I borrowed the pithy descriptions「the way the developer wants to see it」and「the way the user wants to see it」when defining repr() and str() in Object Representations.

Soapbox

Properties Help Reduce Upfront Costs

In the initial versions of Vector2d, the x and y attributes were public, as are all Python instance and class attributes by default. Naturally, users of vectors need to be able to access its components. Although our vectors are iterable and can be unpacked into a pair of variables, it’s also desirable to be able to write my_vector.x and my_vector.y to get each component.

When we felt the need to avoid accidental updates to the x and y attributes, we implemented properties, but nothing changed elsewhere in the code and in the public interface of Vector2d, as verified by the doctests. We are still able to access my_vector.x and my_vector.y.

This shows that we can always start our classes in the simplest possible way, with public attributes, because when (or if) we later need to impose more control with getters and setters, these can be implemented through properties without changing any of the code that already interacts with our objects through the names (e.g., x and y) that were initially simple public attributes.

This approach is the opposite of that encouraged by the Java language: a Java programmer cannot start with simple public attributes and only later, if needed, implement properties, because they don’t exist in the language. Therefore, writing getters and setters is the norm in Java—even when those methods do nothing useful—because the API cannot evolve from simple public attributes to getters and setters without breaking all code that uses those attributes.

In addition, as our technical reviewer Alex Martelli points out, typing getter/setter calls everywhere is goofy. You have to write stuff like:

--- >>> my_object.set_foo(my_object.get_foo() + 1) ---

Just to do this:

--- >>> my_object.foo += 1 ---

Ward Cunningham, inventor of the wiki and an Extreme Programming pioneer, recommends asking「What’s the simplest thing that could possibly work?」The idea is to focus on the goal.[59] Implementing setters and getters up front is a distraction from the goal. In Python, we can simply use public attributes knowing we can change them to properties later, if the need arises.

Safety Versus Security in Private Attributes

Perl doesn’t have an infatuation with enforced privacy. It would prefer that you stayed out of its living room because you weren’t invited, not because it has a shotgun.

— Larry Wall Creator of Perl

Python and Perl are polar opposites in many regards, but Larry and Guido seem to agree on object privacy.

Having taught Python to many Java programmers over the years, I’ve found a lot of them put too much faith in the privacy guarantees that Java offers. As it turns out, the Java private and protected modifiers normally provide protection against accidents only (i.e., safety). They can only guarantee security against malicious intent if the application is deployed with a security manager, and that seldom happens in practice, even in corporate settings.

To prove my point, I like to show this Java class (Example 9-15).

Example 9-15. Confidential.java: a Java class with a private field named secret

public class Confidential { private String secret = ""; public Confidential(String text) { secret = text.toUpperCase(); } }

In Example 9-15, I store the text in the secret field after converting it to uppercase, just to make it obvious that whatever is in that field will be in all caps.

The actual demonstration consists of running expose.py with Jython. That script uses introspection (「reflection」in Java parlance) to get the value of a private field. The code is in Example 9-16.

Example 9-16. expose.py: Jython code to read the content of a private field in another class

import Confidential message = Confidential('top secret text') secret_field = Confidential.getDeclaredField('secret') secret_field.setAccessible(True) # break the lock! print 'message.secret =', secret_field.get(message)

If you run Example 9-16, this is what you get:

$ jython expose.py message.secret = TOP SECRET TEXT

The string 'TOP SECRET TEXT' was read from the secret private field of the Confidential class.

There is no black magic here: expose.py uses the Java reflection API to get a reference to the private field named 'secret', and then calls 'secret_field.setAccessible(True)' to make it readable. The same thing can be done with Java code, of course (but it takes more than three times as many lines to do it; see the file Expose.java in the Fluent Python code repository).

The crucial call .setAccessible(True) will fail only if the Jython script or the Java main program (e.g., Expose.class) is running under the supervision of a SecurityManager. But in the real world, Java applications are rarely deployed with a SecurityManager—except for Java applets (remember those?).

My point is: in Java too, access control modifiers are mostly about safety and not security, at least in practice. So relax and enjoy the power Python gives you. Use it responsibly.

* * *

[49] From the Paste Style Guide.

[50] I used eval to clone the object here just to make a point about repr; to clone an instance, the copy.copy function is safer and faster.

[51] This line could also be written as yield self.x; yield.self.y. I have a lot more to say about the __iter__ special method, generator expressions, and the yield keyword in Chapter 14.

[52] We had a brief introduction to memoryview, explaining its .cast method in Memory Views.

[53] Leonardo Rochael, one of the technical reviewers of this book disagrees with my low opinion of staticmethod, and recommends the blog post「The Definitive Guide on How to Use Static, Class or Abstract Methods in Python」by Julien Danjou as a counter-argument. Danjou’s post is very good; I do recommend it. But it wasn’t enough to change my mind about staticmethod. You’ll have to decide for yourself.

[54] This is not how Ian Bicking would do it; recall the quote at the start of the chapter. The pros and cons of private attributes are the subject of the upcoming Private and「Protected」Attributes in Python.

[55] From the Paste Style Guide.

[56] In modules, a single _ in front of a top-level name does have an effect: if you write from mymod import * the names with a _ prefix are not imported from mymod. However, you can still write from mymod import _privatefunc. This is explained in the Python Tutorial, section 6.1. More on Modules.

[57] One example is in the gettext module docs.

[58] If this state of affairs depresses you, and makes you wish Python was more like Java in this regard, don’t read my discussion of the relative strength of the Java private modifier in Soapbox.

[59] See「Simplest Thing that Could Possibly Work: A Conversation with Ward Cunningham, Part V」.

Chapter 10. Sequence Hacking, Hashing, and Slicing

Don’t check whether it is-a duck: check whether it quacks-like-a duck, walks-like-a duck, etc, etc, depending on exactly what subset of duck-like behavior you need to play your language-games with. (comp.lang.python, Jul. 26, 2000)

— Alex Martelli

In this chapter, we will create a class to represent a multidimensional Vector class—a significant step up from the two-dimensional Vector2d of Chapter 9. Vector will behave like a standard Python immutable flat sequence. Its elements will be floats, and it will support the following by the end of this chapter:

Basic sequence protocol: __len__ and __getitem__.

Safe representation of instances with many items.

Proper slicing support, producing new Vector instances.

Aggregate hashing taking into account every contained element value.

Custom formatting language extension.

We’ll also implement dynamic attribute access with __getattr__ as a way of replacing the read-only properties we used in Vector2d—although this is not typical of sequence types.

The code-intensive presentation will be interrupted by a conceptual discussion about the idea of protocols as an informal interface. We’ll talk about how protocols and duck typing are related, and its practical implications when you create your own types.

Let’s get started.

Vector Applications Beyond Three Dimensions

Who needs a vector with 1,000 dimensions? Hint: not 3D artists! However, n-dimensional vectors (with large values of n) are widely used in information retrieval, where documents and text queries are represented as vectors, with one dimension per word. This is called the Vector space model. In this model, a key relevance metric is the cosine similarity (i.e., the cosine of the angle between a query vector and a document vector). As the angle decreases, the cosine approaches the maximum value of 1, and so does the relevance of the document to the query.

Having said that, the Vector class in this chapter is a didactic example and we’ll not do much math here. Our goal is just to demonstrate some Python special methods in the context of a sequence type.

NumPy and SciPy are the tools you need for real-world vector math. The PyPI package gemsim, by Radim Rehurek, implements vector space modeling for natural language processing and information retrieval, using NumPy and SciPy.

Vector: A User-Defined Sequence Type

Our strategy to implement Vector will be to use composition, not inheritance. We’ll store the components in an array of floats, and will implement the methods needed for our Vector to behave like an immutable flat sequence.

But before we implement the sequence methods, let’s make sure we have a baseline implementation of Vector that is compatible with our earlier Vector2d class—except where such compatibility would not make sense.

Vector Take #1: Vector2d Compatible

The first version of Vector should be as compatible as possible with our earlier Vector2d class.

However, by design, the Vector constructor is not compatible with the Vector2d constructor. We could make Vector(3, 4) and Vector(3, 4, 5) work, by taking arbitrary arguments with *args in __init__, but the best practice for a sequence constructor is to take the data as an iterable argument in the constructor, like all built-in sequence types do. Example 10-1 shows some ways of instantiating our new Vector objects.

Example 10-1. Tests of Vector.__init__ and Vector.__repr__

>>> Vector([3.1, 4.2]) Vector([3.1, 4.2]) >>> Vector((3, 4, 5)) Vector([3.0, 4.0, 5.0]) >>> Vector(range(10)) Vector([0.0, 1.0, 2.0, 3.0, 4.0, ...])

Apart from new constructor signature, I made sure every test I did with Vector2d (e.g., Vector2d(3, 4)) passed and produced the same result with a two-component Vector([3, 4]).

Warning

When a Vector has more than six components, the string produced by repr() is abbreviated with ... as seen in the last line of Example 10-1. This is crucial in any collection type that may contain a large number of items, because repr is used for debugging (and you don’t want a single large object to span thousands of lines in your console or log). Use the reprlib module to produce limited-length representations, as in Example 10-2.

The reprlib module is called repr in Python 2. The 2to3 tool rewrites imports from repr automatically.

Example 10-2 lists the implementation of our first version of Vector (this example builds on the code shown in Examples 9-2 and 9-3).

Example 10-2. vector_v1.py: derived from vector2d_v1.py

from array import array import reprlib import math class Vector: typecode = 'd' def __init__(self, components): self._components = array(self.typecode, components) def __iter__(self): return iter(self._components) def __repr__(self): components = reprlib.repr(self._components) components = components[components.find('['):-1] return 'Vector({})'.format(components) def __str__(self): return str(tuple(self)) def __bytes__(self): return (bytes([ord(self.typecode)]) + bytes(self._components)) def __eq__(self, other): return tuple(self) == tuple(other) def __abs__(self): return math.sqrt(sum(x * x for x in self)) def __bool__(self): return bool(abs(self)) @classmethod def frombytes(cls, octets): typecode = chr(octets[0]) memv = memoryview(octets[1:]).cast(typecode) return cls(memv)

The self._components instance「protected」attribute will hold an array with the Vector components.

To allow iteration, we return an iterator over self._components.[60]

Use reprlib.repr() to get a limited-length representation of self._components (e.g., array('d', [0.0, 1.0, 2.0, 3.0, 4.0, ...])).

Remove the array('d', prefix and the trailing ) before plugging the string into a Vector constructor call.

Build a bytes object directly from self._components.

We can’t use hypot anymore, so we sum the squares of the components and compute the sqrt of that.

The only change needed from the earlier frombytes is in the last line: we pass the memoryview directly to the constructor, without unpacking with * as we did before.

The way I used reprlib.repr deserves some elaboration. That function produces safe representations of large or recursive structures by limiting the length of the output string and marking the cut with '...'. I wanted the repr of a Vector to look like Vector([3.0, 4.0, 5.0]) and not Vector(array('d', [3.0, 4.0, 5.0])), because the fact that there is an array inside a Vector is an implementation detail. Because these constructor calls build identical Vector objects, I prefer the simpler syntax using a list argument.

When coding __repr__, I could have produced the simplified components display with this expression: reprlib.repr(list(self._components)). However, this would be wasteful, as I’d be copying every item from self._components to a list just to use the list repr. Instead, I decided to apply reprlib.repr to the self._components array directly, and then chop off the characters outside of the []. That’s what the second line of __repr__ does in Example 10-2.

Tip

Because of its role in debugging, calling repr() on an object should never raise an exception. If something goes wrong inside your implementation of __repr__, you must deal with the issue and do your best to produce some serviceable output that gives the user a chance of identifying the target object.

Note that the __str__, __eq__, and __bool__ methods are unchanged from Vector2d, and only one character was changed in frombytes (a * was removed in the last line). This is one of the benefits of making the original Vector2d iterable.

By the way, we could have subclassed Vector from Vector2d, but I chose not to do it for two reasons. First, the incompatible constructors really make subclassing not advisable. I could work around that with some clever parameter handling in __init__, but the second reason is more important: I want Vector to be a standalone example of a class implementing the sequence protocol. That’s what we’ll do next, after a discussion of the term protocol.

Protocols and Duck Typing

As early as Chapter 1, we saw that you don’t need to inherit from any special class to create a fully functional sequence type in Python; you just need to implement the methods that fulfill the sequence protocol. But what kind of protocol are we talking about?

In the context of object-oriented programming, a protocol is an informal interface, defined only in documentation and not in code. For example, the sequence protocol in Python entails just the __len__ and __getitem__ methods. Any class Spam that implements those methods with the standard signature and semantics can be used anywhere a sequence is expected. Whether Spam is a subclass of this or that is irrelevant; all that matters is that it provides the necessary methods. We saw that in Example 1-1, reproduced here in Example 10-3.

Example 10-3. Code from Example 1-1, reproduced here for convenience

import collections Card = collections.namedtuple('Card', ['rank', 'suit']) class FrenchDeck: ranks = [str(n) for n in range(2, 11)] + list('JQKA') suits = 'spades diamonds clubs hearts'.split() def __init__(self): self._cards = [Card(rank, suit) for suit in self.suits for rank in self.ranks] def __len__(self): return len(self._cards) def __getitem__(self, position): return self._cards[position]

The FrenchDeck class in Example 10-3 takes advantage of many Python facilities because it implements the sequence protocol, even if that is not declared anywhere in the code. Any experienced Python coder will look at it and understand that it is a sequence, even if it subclasses object. We say it is a sequence because it behaves like one, and that is what matters.

This became known as duck typing, after Alex Martelli’s post quoted at the beginning of this chapter.

Because protocols are informal and unenforced, you can often get away with implementing just part of a protocol, if you know the specific context where a class will be used. For example, to support iteration, only __getitem__ is required; there is no need to provide __len__.

We’ll now implement the sequence protocol in Vector, initially without proper support for slicing, but later adding that.

Vector Take #2: A Sliceable Sequence

As we saw with the FrenchDeck example, supporting the sequence protocol is really easy if you can delegate to a sequence attribute in your object, like our self._components array. These __len__ and __getitem__ one-liners are a good start:

class Vector: # many lines omitted # ... def __len__(self): return len(self._components) def __getitem__(self, index): return self._components[index]

With these additions, all of these operations now work:

>>> v1 = Vector([3, 4, 5]) >>> len(v1) 3 >>> v1[0], v1[-1] (3.0, 5.0) >>> v7 = Vector(range(7)) >>> v7[1:4] array('d', [1.0, 2.0, 3.0])

As you can see, even slicing is supported—but not very well. It would be better if a slice of a Vector was also a Vector instance and not a array. The old FrenchDeck class has a similar problem: when you slice it, you get a list. In the case of Vector, a lot of functionality is lost when slicing produces plain arrays.

Consider the built-in sequence types: every one of them, when sliced, produces a new instance of its own type, and not of some other type.

To make Vector produce slices as Vector instances, we can’t just delegate the slicing to array. We need to analyze the arguments we get in __getitem__ and do the right thing.

Now, let’s see how Python turns the syntax my_seq[1:3] into arguments for my_seq.__getitem__(...).

How Slicing Works

A demo is worth a thousand words, so take a look at Example 10-4.

Example 10-4. Checking out the behavior of __getitem__ and slices

>>> class MySeq: ... def __getitem__(self, index): ... return index # ... >>> s = MySeq() >>> s[1] # 1 >>> s[1:4] # slice(1, 4, None) >>> s[1:4:2] # slice(1, 4, 2) >>> s[1:4:2, 9] # (slice(1, 4, 2), 9) >>> s[1:4:2, 7:9] # (slice(1, 4, 2), slice(7, 9, None))

For this demonstration, __getitem__ merely returns whatever is passed to it.

A single index, nothing new.

The notation 1:4 becomes slice(1, 4, None).

slice(1, 4, 2) means start at 1, stop at 4, step by 2.

Surprise: the presence of commas inside the [] means __getitem__ receives a tuple.

The tuple may even hold several slice objects.

Now let’s take a closer look at slice itself in Example 10-5.

Example 10-5. Inspecting the attributes of the slice class

>>> slice # <class 'slice'> >>> dir(slice) # ['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'indices', 'start', 'step', 'stop']

slice is a built-in type (we saw it first in Slice Objects).

Inspecting a slice we find the data attributes start, stop, and step, and an indices method.

In Example 10-5, calling dir(slice) reveals an indices attribute, which turns out to be a very interesting but little-known method. Here is what help(slice.indices) reveals:

S.indices(len) -> (start, stop, stride)

Assuming a sequence of length len, calculate the start and stop indices, and the stride length of the extended slice described by S. Out of bounds indices are clipped in a manner consistent with the handling of normal slices.

In other words, indices exposes the tricky logic that’s implemented in the built-in sequences to gracefully handle missing or negative indices and slices that are longer than the target sequence. This method produces「normalized」tuples of nonnegative start, stop, and stride integers adjusted to fit within the bounds of a sequence of the given length.

Here are a couple of examples, considering a sequence of len == 5, e.g., 'ABCDE':

>>> slice(None, 10, 2).indices(5) # (0, 5, 2) >>> slice(-3, None, None).indices(5) # (2, 5, 1)

'ABCDE'[:10:2] is the same as 'ABCDE'[0:5:2]

'ABCDE'[-3:] is the same as 'ABCDE'[2:5:1]

Note

As I write this, the slice.indices method is apparently not documented in the online Python Library Reference. The Python Python/C API Reference Manual documents a similar C-level function, PySlice_GetIndicesEx. I discovered slice.indices while exploring slice objects in the Python console, using dir() and help(). Yet another evidence of the value of the interactive console as a discovery tool.

In our Vector code, we’ll not need the slice.indices() method because when we get a slice argument we’ll delegate its handling to the _components array. But if you can’t count on the services of an underlying sequence, this method can be a huge time saver.

Now that we know how to handle slices, let’s take a look at the improved Vector.__getitem__ implementation.

A Slice-Aware __getitem__

Example 10-6 lists the two methods needed to make Vector behave as a sequence: __len__ and __getitem__ (the latter now implemented to handle slicing correctly).

Example 10-6. Part of vector_v2.py: __len__ and __getitem__ methods added to Vector class from vector_v1.py (see Example 10-2)

def __len__(self): return len(self._components) def __getitem__(self, index): cls = type(self) if isinstance(index, slice): return cls(self._components[index]) elif isinstance(index, numbers.Integral): return self._components[index] else: msg = '{cls.__name__} indices must be integers' raise TypeError(msg.format(cls=cls))

Get the class of the instance (i.e., Vector) for later use.

If the index argument is a slice…

…invoke the class to build another Vector instance from a slice of the _components array.

If the index is an int or some other kind of integer…

…just return the specific item from _components.

Otherwise, raise an exception.

Note

Excessive use of isinstance may be a sign of bad OO design, but handling slices in __getitem__ is a justified use case. Note in Example 10-6 the test against numbers.Integral—an Abstract Base Class. Using ABCs in insinstance tests makes an API more flexible and future-proof. Chapter 11 explains why. Unfortunately, there is no ABC for slice in the Python 3.4 standard library.

To discover which exception to raise in the else clause of __getitem__, I used the interactive console to check the result of 'ABC'[1, 2]. I then learned that Python raises a TypeError, and I also copied the wording from the error message:「indices must be integers.」To create Pythonic objects, mimic Python’s own objects.

Once the code in Example 10-6 is added to the Vector class, we have proper slicing behavior, as Example 10-7 demonstrates.

Example 10-7. Tests of enhanced Vector.getitem from Example 10-6

>>> v7 = Vector(range(7)) >>> v7[-1] 6.0 >>> v7[1:4] Vector([1.0, 2.0, 3.0]) >>> v7[-1:] Vector([6.0]) >>> v7[1,2] Traceback (most recent call last): ... TypeError: Vector indices must be integers

An integer index retrieves just one component value as a float.

A slice index creates a new Vector.

A slice of len == 1 also creates a Vector.

Vector does not support multidimensional indexing, so a tuple of indices or slices raises an error.

Vector Take #3: Dynamic Attribute Access

In the evolution from Vector2d to Vector, we lost the ability to access vector components by name (e.g., v.x, v.y). We are now dealing with vectors that may have a large number of components. Still, it may be convenient to access the first few components with shortcut letters such as x, y, z instead of v[0], v[1] and v[2].

Here is the alternative syntax we want to provide for reading the first four components of a vector:

>>> v = Vector(range(10)) >>> v.x 0.0 >>> v.y, v.z, v.t (1.0, 2.0, 3.0)

In Vector2d, we provided read-only access to x and y using the @property decorator (Example 9-7). We could write four properties in Vector, but it would be tedious. The __getattr__ special method provides a better way.

「The __getattr__ method is invoked by the interpreter when attribute lookup fails. In simple terms, given the expression my_obj.x, Python checks if the my_obj instance has an attribute named x; if not, the search goes to the class (my_obj.__class__), and then up the inheritance graph.[61] If the x attribute is not found, then the __getattr__ method defined in the class of my_obj is called with self and the name of the attribute as a string (e.g., 'x').

Example 10-8 lists our __getattr__ method. Essentially it checks whether the attribute being sought is one of the letters xyzt and if so, returns the corresponding vector component.

Example 10-8. Part of vector_v3.py: __getattr__ method added to Vector class from vector_v2.py

shortcut_names = 'xyzt' def __getattr__(self, name): cls = type(self) if len(name) == 1: pos = cls.shortcut_names.find(name) if 0 <= pos < len(self._components): return self._components[pos] msg = '{.__name__!r} object has no attribute {!r}' raise AttributeError(msg.format(cls, name))

Get the Vector class for later use.

If the name is one character, it may be one of the shortcut_names.

Find position of 1-letter name; str.find would also locate 'yz' and we don’t want that, this is the reason for the test above.

If the position is within range, return the array element.

If either test failed, raise AttributeError with a standard message text.

It’s not hard to implement __getattr__, but in this case it’s not enough. Consider the bizarre interaction in Example 10-9.

Example 10-9. Inappropriate behavior: assigning to v.x raises no error, but introduces an inconsistency

>>> v = Vector(range(5)) >>> v Vector([0.0, 1.0, 2.0, 3.0, 4.0]) >>> v.x # 0.0 >>> v.x = 10 # >>> v.x # 10 >>> v Vector([0.0, 1.0, 2.0, 3.0, 4.0]) #

Access element v[0] as v.x.

Assign new value to v.x. This should raise an exception.

Reading v.x shows the new value, 10.

However, the vector components did not change.

Can you explain what is happening? In particular, why the second time v.x returns 10 if that value is not in the vector components array? If you don’t know right off the bat, study the explanation of __getattr__ given right before Example 10-8. It’s a bit subtle, but a very important foundation to understand a lot of what comes later in the book.

The inconsistency in Example 10-9 was introduced because of the way __getattr__ works: Python only calls that method as a fall back, when the object does not have the named attribute. However, after we assign v.x = 10, the v object now has an x attribute, so __getattr__ will no longer be called to retrieve v.x: the interpreter will just return the value 10 that is bound to v.x. On the other hand, our implementation of __getattr__ pays no attention to instance attributes other than self._components, from where it retrieves the values of the「virtual attributes」listed in shortcut_names.

We need to customize the logic for setting attributes in our Vector class in order to avoid this inconsistency.

Recall that in the latest Vector2d examples from Chapter 9, trying to assign to the .x or .y instance attributes raised AttributeError. In Vector we want the same exception with any attempt at assigning to all single-letter lowercase attribute names, just to avoid confusion. To do that, we’ll implement __setattr__ as listed in Example 10-10.

Example 10-10. Part of vector_v3.py: __setattr__ method in Vector class

def __setattr__(self, name, value): cls = type(self) if len(name) == 1: if name in cls.shortcut_names: error = 'readonly attribute {attr_name!r}' elif name.islower(): error = "can't set attributes 'a' to 'z' in {cls_name!r}" else: error = '' if error: msg = error.format(cls_name=cls.__name__, attr_name=name) raise AttributeError(msg) super().__setattr__(name, value)

Special handling for single-character attribute names.

If name is one of xyzt, set specific error message.

If name is lowercase, set error message about all single-letter names.

Otherwise, set blank error message.

If there is a nonblank error message, raise AttributeError.

Default case: call __setattr__ on superclass for standard behavior.

Tip

The super() function provides a way to access methods of superclasses dynamically, a necessity in a dynamic language supporting multiple inheritance like Python. It’s used to delegate some task from a method in a subclass to a suitable method in a superclass, as seen in Example 10-10. There is more about super in Multiple Inheritance and Method Resolution Order.

While choosing the error message to display with AttributeError, my first check was the behavior of the built-in complex type, because they are immutable and have a pair of data attributes real and imag. Trying to change either of those in a complex instance raises AttributeError with the message "can't set attribute". On the other hand, trying to set a read-only attribute protected by a property as we did in A Hashable Vector2d produces the message "readonly attribute". I drew inspiration from both wordings to set the error string in __setitem__, but was more explicit about the forbidden attributes.

Note that we are not disallowing setting all attributes, only single-letter, lowercase ones, to avoid confusion with the supported read-only attributes x, y, z, and t.

Warning

Knowing that declaring __slots__ at the class level prevents setting new instance attributes, it’s tempting to use that feature instead of implementing __setattr__ as we did. However, because of all the caveats discussed in The Problems with __slots__, using __slots__ just to prevent instance attribute creation is not recommended. __slots__ should be used only to save memory, and only if that is a real issue.

Even without supporting writing to the Vector components, here is an important takeaway from this example: very often when you implement __getattr__ you need to code __setattr__ as well, to avoid inconsistent behavior in your objects.

If we wanted to allow changing components, we could implement __setitem__ to enable v[0] = 1.1 and/or __setattr__ to make v.x = 1.1 work. But Vector will remain immutable because we want to make it hashable in the coming section.

Vector Take #4: Hashing and a Faster ==

Once more we get to implement a __hash__ method. Together with the existing __eq__, this will make Vector instances hashable.

The __hash__ in Example 9-8 simply computed hash(self.x) ^ hash(self.y). We now would like to apply the ^ (xor) operator to the hashes of every component, in succession, like this: v[0] ^ v[1] ^ v[2]…. That is what the functools.reduce function is for. Previously I said that reduce is not as popular as before,[62] but computing the hash of all vector components is a perfect job for it. Figure 10-1 depicts the general idea of the reduce function.

Figure 10-1. Reducing functions—reduce, sum, any, all—produce a single aggregate result from a sequence or from any finite iterable object.

So far we’ve seen that functools.reduce() can be replaced by sum(), but now let’s properly explain how it works. The key idea is to reduce a series of values to a single value. The first argument to reduce() is a two-argument function, and the second argument is an iterable. Let’s say we have a two-argument function fn and a list lst. When you call reduce(fn, lst), fn will be applied to the first pair of elements—fn(lst[0], lst[1])—producing a first result, r1. Then fn is applied to r1 and the next element—fn(r1, lst[2])—producing a second result, r2. Now fn(r2, lst[3]) is called to produce r3 … and so on until the last element, when a single result, rN, is returned.

Here is how you could use reduce to compute 5! (the factorial of 5):

>>> 2 * 3 * 4 * 5 # the result we want: 5! == 120 120 >>> import functools >>> functools.reduce(lambda a,b: a*b, range(1, 6)) 120

Back to our hashing problem, Example 10-11 shows the idea of computing the aggregate xor by doing it in three ways: with a for loop and two reduce calls.

Example 10-11. Three ways of calculating the accumulated xor of integers from 0 to 5

>>> n = 0 >>> for i in range(1, 6): # ... n ^= i ... >>> n 1 >>> import functools >>> functools.reduce(lambda a, b: a^b, range(6)) # 1 >>> import operator >>> functools.reduce(operator.xor, range(6)) # 1

Aggregate xor with a for loop and an accumulator variable.

functools.reduce using an anonymous function.

functools.reduce replacing custom lambda with operator.xor.

From the alternatives in Example 10-11, the last one is my favorite, and the for loop comes second. What is your preference?

As seen in The operator Module, operator provides the functionality of all Python infix operators in function form, lessening the need for lambda.

To code Vector.__hash__ in my preferred style, we need to import the functools and operator modules. Example 10-12 shows the relevant changes.

Example 10-12. Part of vector_v4.py: two imports and __hash__ method added to Vector class from vector_v3.py

from array import array import reprlib import math import functools # import operator # class Vector: typecode = 'd' # many lines omitted in book listing... def __eq__(self, other): # return tuple(self) == tuple(other) def __hash__(self): hashes = (hash(x) for x in self._components) # return functools.reduce(operator.xor, hashes, 0) # # more lines omitted...

Import functools to use reduce.

Import operator to use xor.

No change to __eq__; I listed it here because it’s good practice to keep __eq__ and __hash__ close in source code, because they need to work together.

Create a generator expression to lazily compute the hash of each component.

Feed hashes to reduce with the xor function to compute the aggregate hash value; the third argument, 0, is the initializer (see next warning).

Warning

When using reduce, it’s good practice to provide the third argument, reduce(function, iterable, initializer), to prevent this exception: TypeError: reduce() of empty sequence with no initial value (excellent message: explains the problem and how to fix it). The initializer is the value returned if the sequence is empty and is used as the first argument in the reducing loop, so it should be the identity value of the operation. As examples, for +, |, ^ the initializer should be 0, but for *, & it should be 1.

As implemented, the __hash__ method in Example 10-8 is a perfect example of a map-reduce computation (Figure 10-2).

Figure 10-2. Map-reduce: apply function to each item to generate a new series (map), then compute aggregate (reduce)

The mapping step produces one hash for each component, and the reduce step aggregates all hashes with the xor operator. Using map instead of a genexp makes the mapping step even more visible:

def __hash__(self): hashes = map(hash, self._components) return functools.reduce(operator.xor, hashes)

Tip

The solution with map would be less efficient in Python 2, where the map function builds a new list with the results. But in Python 3, map is lazy: it creates a generator that yields the results on demand, thus saving memory—just like the generator expression we used in the __hash__ method of Example 10-8.

While we are on the topic of reducing functions, we can replace our quick implementation of __eq__ with another one that will be cheaper in terms of processing and memory, at least for large vectors. As introduced in Example 9-2, we have this very concise implementation of __eq__:

def __eq__(self, other): return tuple(self) == tuple(other)

This works for Vector2d and for Vector—it even considers Vector([1, 2]) equal to (1, 2), which may be a problem, but we’ll overlook that for now.[63] But for Vector instances that may have thousands of components, it’s very inefficient. It builds two tuples copying the entire contents of the operands just to use the __eq__ of the tuple type. For Vector2d (with only two components), it’s a good shortcut, but not for the large multidimensional vectors. A better way of comparing one Vector to another Vector or iterable would be Example 10-13.

Example 10-13. Vector.eq using zip in a for loop for more efficient comparison

def __eq__(self, other): if len(self) != len(other): # return False for a, b in zip(self, other): # if a != b: # return False return True #

If the len of the objects are different, they are not equal.

zip produces a generator of tuples made from the items in each iterable argument. See The Awesome zip if zip is new to you. The len comparison above is needed because zip stops producing values without warning as soon as one of the inputs is exhausted.

As soon as two components are different, exit returning False.

Otherwise, the objects are equal.

Example 10-13 is efficient, but the all function can produce the same aggregate computation of the for loop in one line: if all comparisons between corresponding components in the operands are True, the result is True. As soon as one comparison is False, all returns False. Example 10-14 shows how __eq__ looks using all.

Example 10-14. Vector.eq using zip and all: same logic as Example 10-13

def __eq__(self, other): return len(self) == len(other) and all(a == b for a, b in zip(self, other))

Note that we first check that the operands have equal length, because zip will stop at the shortest operand.

Example 10-14 is the implementation we choose for __eq__ in vector_v4.py.

We wrap up this chapter by bringing back the __format__ method from Vector2d to Vector.

The Awesome zip

Having a for loop that iterates over items without fiddling with index variables is great and prevents lots of bugs, but demands some special utility functions. One of them is the zip built-in, which makes it easy to iterate in parallel over two or more iterables by returning tuples that you can unpack into variables, one for each item in the parallel inputs. See Example 10-15.

Tip

The zip function is named after the zipper fastener because the physical device works by interlocking pairs of teeth taken from both zipper sides, a good visual analogy for what zip(left, right) does. No relation with compressed files.

Example 10-15. The zip built-in at work

>>> zip(range(3), 'ABC') # <zip object at 0x10063ae48> >>> list(zip(range(3), 'ABC')) # [(0, 'A'), (1, 'B'), (2, 'C')] >>> list(zip(range(3), 'ABC', [0.0, 1.1, 2.2, 3.3])) # [(0, 'A', 0.0), (1, 'B', 1.1), (2, 'C', 2.2)] >>> from itertools import zip_longest # >>> list(zip_longest(range(3), 'ABC', [0.0, 1.1, 2.2, 3.3], fillvalue=-1)) [(0, 'A', 0.0), (1, 'B', 1.1), (2, 'C', 2.2), (-1, -1, 3.3)]

zip returns a generator that produces tuples on demand.

Here we build a list from it just for display; usually we iterate over the generator.

zip has a surprising trait: it stops without warning when one of the iterables is exhausted.[64]

The itertools.zip_longest function behaves differently: it uses an optional fillvalue (None by default) to complete missing values so it can generate tuples until the last iterable is exhausted.

The enumerate built-in is another generator function often used in for loops to avoid manual handling of index variables. If you are not familiar with enumerate, you should definitely check it out in the「Built-in functions」documentation. The zip and enumerate built-ins, along with several other generator functions in the standard library, are covered in Generator Functions in the Standard Library.

Vector Take #5: Formatting

The __format__ method of Vector will resemble that of Vector2d, but instead of providing a custom display in polar coordinates, Vector will use spherical coordinates—also known as「hyperspherical」coordinates, because now we support n dimensions, and spheres are「hyperspheres」in 4D and beyond.[65] Accordingly, we’ll change the custom format suffix from 'p' to 'h'.

Tip

As we saw in Formatted Displays, when extending the Format Specification Mini-Language it’s best to avoid reusing format codes supported by built-in types. In particular, our extended mini-language also uses the float formatting codes 'eEfFgGn%' in their original meaning, so we definitely must avoid these. Integers use 'bcdoxXn' and strings use 's'. I picked 'p' for Vector2d polar coordinates. Code 'h' for hyperspherical coordinates is a good choice.

For example, given a Vector object in 4D space (len(v) == 4), the 'h' code will produce a display like <r, Φ₁, Φ₂, Φ₃> where r is the magnitude (abs(v)) and the remaining numbers are the angular coordinates Φ₁, Φ₂, Φ₃.

Here are some samples of the spherical coordinate format in 4D, taken from the doctests of vector_v5.py (see Example 10-16):

>>> format(Vector([-1, -1, -1, -1]), 'h') '<2.0, 2.0943951023931957, 2.186276035465284, 3.9269908169872414>' >>> format(Vector([2, 2, 2, 2]), '.3eh') '<4.000e+00, 1.047e+00, 9.553e-01, 7.854e-01>' >>> format(Vector([0, 1, 0, 0]), '0.5fh') '<1.00000, 1.57080, 0.00000, 0.00000>'

Before we can implement the minor changes required in __format__, we need to code a pair of support methods: angle(n) to compute one of the angular coordinates (e.g., Φ₁), and angles() to return an iterable of all angular coordinates. I’ll not describe the math here; if you’re curious, Wikipedia’s "n-sphere」entry has the formulas I used to calculate the spherical coordinates from the Cartesian coordinates in the Vector components array.

Example 10-16 is a full listing of vector_v5.py consolidating all we’ve implemented since Vector Take #1: Vector2d Compatible and introducing custom formatting.

Example 10-16. vector_v5.py: doctests and all code for final Vector class; callouts highlight additions needed to support __format__

""" A multidimensional ``Vector`` class, take 5 A ``Vector`` is built from an iterable of numbers:: >>> Vector([3.1, 4.2]) Vector([3.1, 4.2]) >>> Vector((3, 4, 5)) Vector([3.0, 4.0, 5.0]) >>> Vector(range(10)) Vector([0.0, 1.0, 2.0, 3.0, 4.0, ...]) Tests with two dimensions (same results as ``vector2d_v1.py``):: >>> v1 = Vector([3, 4]) >>> x, y = v1 >>> x, y (3.0, 4.0) >>> v1 Vector([3.0, 4.0]) >>> v1_clone = eval(repr(v1)) >>> v1 == v1_clone True >>> print(v1) (3.0, 4.0) >>> octets = bytes(v1) >>> octets b'd\\x00\\x00\\x00\\x00\\x00\\x00\\x08@\\x00\\x00\\x00\\x00\\x00\\x00\\x10@' >>> abs(v1) 5.0 >>> bool(v1), bool(Vector([0, 0])) (True, False) Test of ``.frombytes()`` class method: >>> v1_clone = Vector.frombytes(bytes(v1)) >>> v1_clone Vector([3.0, 4.0]) >>> v1 == v1_clone True Tests with three dimensions:: >>> v1 = Vector([3, 4, 5]) >>> x, y, z = v1 >>> x, y, z (3.0, 4.0, 5.0) >>> v1 Vector([3.0, 4.0, 5.0]) >>> v1_clone = eval(repr(v1)) >>> v1 == v1_clone True >>> print(v1) (3.0, 4.0, 5.0) >>> abs(v1) # doctest:+ELLIPSIS 7.071067811... >>> bool(v1), bool(Vector([0, 0, 0])) (True, False) Tests with many dimensions:: >>> v7 = Vector(range(7)) >>> v7 Vector([0.0, 1.0, 2.0, 3.0, 4.0, ...]) >>> abs(v7) # doctest:+ELLIPSIS 9.53939201... Test of ``.__bytes__`` and ``.frombytes()`` methods:: >>> v1 = Vector([3, 4, 5]) >>> v1_clone = Vector.frombytes(bytes(v1)) >>> v1_clone Vector([3.0, 4.0, 5.0]) >>> v1 == v1_clone True Tests of sequence behavior:: >>> v1 = Vector([3, 4, 5]) >>> len(v1) 3 >>> v1[0], v1[len(v1)-1], v1[-1] (3.0, 5.0, 5.0) Test of slicing:: >>> v7 = Vector(range(7)) >>> v7[-1] 6.0 >>> v7[1:4] Vector([1.0, 2.0, 3.0]) >>> v7[-1:] Vector([6.0]) >>> v7[1,2] Traceback (most recent call last): ... TypeError: Vector indices must be integers Tests of dynamic attribute access:: >>> v7 = Vector(range(10)) >>> v7.x 0.0 >>> v7.y, v7.z, v7.t (1.0, 2.0, 3.0) Dynamic attribute lookup failures:: >>> v7.k Traceback (most recent call last): ... AttributeError: 'Vector' object has no attribute 'k' >>> v3 = Vector(range(3)) >>> v3.t Traceback (most recent call last): ... AttributeError: 'Vector' object has no attribute 't' >>> v3.spam Traceback (most recent call last): ... AttributeError: 'Vector' object has no attribute 'spam' Tests of hashing:: >>> v1 = Vector([3, 4]) >>> v2 = Vector([3.1, 4.2]) >>> v3 = Vector([3, 4, 5]) >>> v6 = Vector(range(6)) >>> hash(v1), hash(v3), hash(v6) (7, 2, 1) Most hash values of non-integers vary from a 32-bit to 64-bit CPython build:: >>> import sys >>> hash(v2) == (384307168202284039 if sys.maxsize > 2**32 else 357915986) True Tests of ``format()`` with Cartesian coordinates in 2D:: >>> v1 = Vector([3, 4]) >>> format(v1) '(3.0, 4.0)' >>> format(v1, '.2f') '(3.00, 4.00)' >>> format(v1, '.3e') '(3.000e+00, 4.000e+00)' Tests of ``format()`` with Cartesian coordinates in 3D and 7D:: >>> v3 = Vector([3, 4, 5]) >>> format(v3) '(3.0, 4.0, 5.0)' >>> format(Vector(range(7))) '(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)' Tests of ``format()`` with spherical coordinates in 2D, 3D and 4D:: >>> format(Vector([1, 1]), 'h') # doctest:+ELLIPSIS '<1.414213..., 0.785398...>' >>> format(Vector([1, 1]), '.3eh') '<1.414e+00, 7.854e-01>' >>> format(Vector([1, 1]), '0.5fh') '<1.41421, 0.78540>' >>> format(Vector([1, 1, 1]), 'h') # doctest:+ELLIPSIS '<1.73205..., 0.95531..., 0.78539...>' >>> format(Vector([2, 2, 2]), '.3eh') '<3.464e+00, 9.553e-01, 7.854e-01>' >>> format(Vector([0, 0, 0]), '0.5fh') '<0.00000, 0.00000, 0.00000>' >>> format(Vector([-1, -1, -1, -1]), 'h') # doctest:+ELLIPSIS '<2.0, 2.09439..., 2.18627..., 3.92699...>' >>> format(Vector([2, 2, 2, 2]), '.3eh') '<4.000e+00, 1.047e+00, 9.553e-01, 7.854e-01>' >>> format(Vector([0, 1, 0, 0]), '0.5fh') '<1.00000, 1.57080, 0.00000, 0.00000>' """ from array import array import reprlib import math import numbers import functools import operator import itertools class Vector: typecode = 'd' def __init__(self, components): self._components = array(self.typecode, components) def __iter__(self): return iter(self._components) def __repr__(self): components = reprlib.repr(self._components) components = components[components.find('['):-1] return 'Vector({})'.format(components) def __str__(self): return str(tuple(self)) def __bytes__(self): return (bytes([ord(self.typecode)]) + bytes(self._components)) def __eq__(self, other): return (len(self) == len(other) and all(a == b for a, b in zip(self, other))) def __hash__(self): hashes = (hash(x) for x in self) return functools.reduce(operator.xor, hashes, 0) def __abs__(self): return math.sqrt(sum(x * x for x in self)) def __bool__(self): return bool(abs(self)) def __len__(self): return len(self._components) def __getitem__(self, index): cls = type(self) if isinstance(index, slice): return cls(self._components[index]) elif isinstance(index, numbers.Integral): return self._components[index] else: msg = '{.__name__} indices must be integers' raise TypeError(msg.format(cls)) shortcut_names = 'xyzt' def __getattr__(self, name): cls = type(self) if len(name) == 1: pos = cls.shortcut_names.find(name) if 0 <= pos < len(self._components): return self._components[pos] msg = '{.__name__!r} object has no attribute {!r}' raise AttributeError(msg.format(cls, name)) def angle(self, n): r = math.sqrt(sum(x * x for x in self[n:])) a = math.atan2(r, self[n-1]) if (n == len(self) - 1) and (self[-1] < 0): return math.pi * 2 - a else: return a def angles(self): return (self.angle(n) for n in range(1, len(self))) def __format__(self, fmt_spec=''): if fmt_spec.endswith('h'): # hyperspherical coordinates fmt_spec = fmt_spec[:-1] coords = itertools.chain([abs(self)], self.angles()) outer_fmt = '<{}>' else: coords = self outer_fmt = '({})' components = (format(c, fmt_spec) for c in coords) return outer_fmt.format(', '.join(components)) @classmethod def frombytes(cls, octets): typecode = chr(octets[0]) memv = memoryview(octets[1:]).cast(typecode) return cls(memv)

Import itertools to use chain function in __format__.

Compute one of the angular coordinates, using formulas adapted from the n-sphere article.

Create generator expression to compute all angular coordinates on demand.

Use itertools.chain to produce genexp to iterate seamlessly over the magnitude and the angular coordinates.

Configure spherical coordinate display with angular brackets.

Configure Cartesian coordinate display with parentheses.

Create generator expression to format each coordinate item on demand.

Plug formatted components separated by commas inside brackets or parentheses.

Note

We are making heavy use of generator expressions in __format__, angle, and angles but our focus here is in providing __format__ to bring Vector to the same implementation level as Vector2d. When we cover generators in Chapter 14 we’ll use some of the code in Vector as examples, and then the generator tricks will be explained in detail.

This concludes our mission for this chapter. The Vector class will be enhanced with infix operators in Chapter 13, but our goal here was to explore techniques for coding special methods that are useful in a wide variety of collection classes.

Chapter Summary

The Vector example in this chapter was designed to be compatible with Vector2d, except for the use of a different constructor signature accepting a single iterable argument, just like the built-in sequence types do. The fact that Vector behaves as a sequence just by implementing __getitem__ and __len__ prompted a discussion of protocols, the informal interfaces used in duck-typed languages.

We then looked at how the my_seq[a:b:c] syntax works behind the scenes, by creating a slice(a, b, c) object and handing it to __getitem__. Armed with this knowledge, we made Vector respond correctly to slicing, by returning new Vector instances, just like a Pythonic sequence is expected to do.

The next step was to provide read-only access to the first few Vector components using notation such as my_vec.x. We did it by implementing __getattr__. Doing that opened the possibility of tempting the user to assign to those special components by writing my_vec.x = 7, revealing a potential bug. We fixed it by implementing __setattr__ as well, to forbid assigning values to single-letter attributes. Very often, when you code a __getattr__ you need to add __setattr__ too, in order to avoid inconsistent behavior.

Implementing the __hash__ function provided the perfect context for using functools.reduce, because we needed to apply the xor operator ^ in succession to the hashes of all Vector components to produce an aggregate hash value for the whole Vector. After applying reduce in __hash__, we used the all reducing built-in to create a more efficient __eq__ method.

The last enhancement to Vector was to reimplement the __format__ method from Vector2d by supporting spherical coordinates as an alternative to the default Cartesian coordinates. We used quite a bit of math and several generators to code __format__ and its auxiliary functions, but these are implementation details—and we’ll come back to the generators in Chapter 14. The goal of that last section was to support a custom format, thus fulfilling the promise of a Vector that could do everything a Vector2d did, and more.

As we did in Chapter 9, here we often looked at how standard Python objects behave, to emulate them and provide a「Pythonic」look-and-feel to Vector.

In Chapter 13, we will implement several infix operators on Vector. The math will be much simpler than that in the angle() method here, but exploring how infix operators work in Python is a great lesson in OO design. But before we get to operator overloading, we’ll step back from working on one class and look at organizing multiple classes with interfaces and inheritance, the subjects of Chapters 11 and 11.

Further Reading

Most special methods covered in the Vector example also appear in the Vector2d example from Chapter 9, so the references in Further Reading are all relevant here.

The powerful reduce higher-order function is also known as fold, accumulate, aggregate, compress, and inject. For more information, see Wikipedia’s「Fold (higher-order function)」article, which presents applications of that higher-order function with emphasis on functional programming with recursive data structures. The article also includes a table listing fold-like functions in dozens of programming languages.

Soapbox

Protocols as Informal Interfaces

Protocols are not an invention of Python. The Smalltalk team, who also coined the expression「object oriented,」used「protocol」as a synonym for what we now call interfaces. Some Smalltalk programming environments allowed programmers to tag a group of methods as a protocol, but that was merely a documentation and navigation aid, and not enforced by the language. That’s why I believe「informal interface」is a reasonable short explanation for「protocol」when I speak to an audience that is more familiar with formal (and compiler enforced) interfaces.

Established protocols naturally evolve in any language that uses dynamic typing, that is, when type-checking done at runtime because there is no static type information in method signatures and variables. Ruby is another important OO language that has dynamic typing and uses protocols.

In the Python documentation, you can often tell when a protocol is being discussed when you see language like「a file-like object.」This is a quick way of saying「something that behaves sufficiently like a file, by implementing the parts of the file interface that are relevant in the context.」

You may think that implementing only part of a protocol is sloppy, but it has the advantage of keeping things simple. Section 3.3 of the「Data Model」chapter suggests:

When implementing a class that emulates any built-in type, it is important that the emulation only be implemented to the degree that it makes sense for the object being modeled. For example, some sequences may work well with retrieval of individual elements, but extracting a slice may not make sense.

—「Data Model」chapter of The Python Language Reference

When we don’t need to code nonsense methods just to fulfill some over-designed interface contract and keep the compiler happy, it becomes easier to follow the KISS principle.

I’ll have more to say about protocols and interfaces in Chapter 11, where that is actually the main focus.

Origins of Duck Typing

I believe the Ruby community, more than any other, helped popularize the term「duck typing,」as they preached to the Java masses. But the expression has been used in Python discussions before either Ruby or Python were「popular.」According to Wikipedia, an early example of the duck analogy in object-oriented programming is a message to the Python-list by Alex Martelli from July 26, 2000: polymorphism (was Re: Type checking in python?). That’s where the quote at the beginning of this chapter came from. If you are curious about the literary origins of the「duck typing」term, and the applications of this OO concept in many languages, check out Wikipedia’s「Duck typing」entry.

A safe format, with Enhanced Usability

While implementing __format__, we did not take any precautions regarding Vector instances with a very large number of components, as we did in __repr__ using reprlib. The reasoning is that repr() is for debugging and logging, so it must always generate some serviceable output, while __format__ is used to display output to end users who presumably want to see the entire Vector. If you think this is dangerous, then it would be cool to implement a further extension to the format specifier mini-language.

Here is how I’d do it: by default, any formatted Vector would display a reasonable but limited number of components, say 30. If there are more elements than that, the default behavior would be similar to what the reprlib does: chop the excess and put ... in its place. However, if the format specifier ended with the special * code, meaning「all,」then the size limitation would be disabled. So a user who’s unaware of the problem of very long displays will not be bitten by it by accident. But if the default limitation becomes a nuisance, then the presence of the ... should prompt the user to research the documentation and discover the * formatting code.

Send a pull request to the Fluent Python repository on GitHub if you implement this!

The Search for a Pythonic Sum

There’s no single answer to「What is Pythonic?」just as there’s no single answer to「What is beautiful?」Saying, as I often do, that it means using「idiomatic Python」is not 100% satisfactory, because what may be「idiomatic」for you may not be for me. One thing I know:「idiomatic」does not mean using the most obscure language features.

In the Python-list, there’s a thread from April 2003 titled「Pythonic Way to Sum n-th List Element?」. It’s relevant to our discussion of reduce in this chapter.

The original poster, Guy Middleton, asked for an improvement on this solution, stating he did not like to use lambda:[66]

>>> my_list = [[1, 2, 3], [40, 50, 60], [9, 8, 7]] >>> import functools >>> functools.reduce(lambda a, b: a+b, [sub[1] for sub in my_list]) 60

That code uses lots of idioms: lambda, reduce, and a list comprehension. It would probably come last in a popularity contest, because it offends people who hate lambda and those who despise list comprehensions—pretty much both sides of a divide.

If you’re going to use lambda, there’s probably no reason to use a list comprehension—except for filtering, which is not the case here.

Here is a solution of my own that will please the lambda lovers:

>>> functools.reduce(lambda a, b: a + b[1], my_list, 0) 60

I did not take part in the original thread, and I wouldn’t use that in real code, because I don’t like lambda too much myself, but I wanted to show an example without a list comprehension.

The first answer came from Fernando Perez, creator of IPython, highlighting that NumPy supports n-dimensional arrays and n-dimensional slicing:

>>> import numpy as np >>> my_array = np.array(my_list) >>> np.sum(my_array[:, 1]) 60

I think Perez’s solution is cool, but Guy Middleton praised this next solution, by Paul Rubin and Skip Montanaro:

>>> import operator >>> functools.reduce(operator.add, [sub[1] for sub in my_list], 0) 60

Then Evan Simpson asked,「What’s wrong with this?」:

>>> t = 0 >>> for sub in my_list: ... total += sub[1] >>> t 60

Lots of people agreed that was quite Pythonic. Alex Martelli went as far as saying that’s probably how Guido would code it.

I like Evan Simpson’s code but I also like David Eppstein’s comment on it:

If you want the sum of a list of items, you should write it in a way that looks like「the sum of a list of items」, not in a way that looks like「loop over these items, maintain another variable t, perform a sequence of additions」. Why do we have high level languages if not to express our intentions at a higher level and let the language worry about what low-level operations are needed to implement it?

Then Alex Martelli comes back to suggest:

「The sum」is so frequently needed that I wouldn’t mind at all if Python singled it out as a built-in. But「reduce(operator.add, …」just isn’t a great way to express it, in my opinion (and yet as an old APL’er, and FP-liker, I should like it—but I don’t).

Alex goes on to suggest a sum() function, which he contributed. It became a built-in in Python 2.3, released only three months after that conversation took place. So Alex’s preferred syntax became the norm:

>>> sum([sub[1] for sub in my_list]) 60

By the end of the next year (November 2004), Python 2.4 was launched with generator expressions, providing what is now in my opinion the most Pythonic answer to Guy Middleton’s original question:

>>> sum(sub[1] for sub in my_list) 60

This is not only more readable than reduce but also avoids the trap of the empty sequence: sum([]) is 0, simple as that.

In the same conversation, Alex Martelli suggests the reduce built-in in Python 2 was more trouble than it was worth, because it encouraged coding idioms that were hard to explain. He was most convincing: the function was demoted to the functools module in Python 3.

Still, functools.reduce has its place. It solved the problem of our Vector.__hash__ in a way that I would call Pythonic.

* * *

[60] The iter() function is covered in Chapter 14, along with the __iter__ method.

[61] Attribute lookup is more complicated than this; we’ll see the gory details in Part VI. For now, this simplified explanation will do.

[62] The sum, any, and all cover the most common uses of reduce. See the discussion in Modern Replacements for map, filter, and reduce.

[63] We’ll seriously consider the matter of Vector([1, 2]) == (1, 2) in Operator Overloading 101.

[64] That’s surprising (to me, at least). I think zip should raise ValueError if the sequences are not all of the same length, which is what happens when unpacking an iterable to a tuple of variables of different length.

[65] The Wolfram Mathworld site has an article on Hypersphere; on Wikipedia,「hypersphere」redirects to the "n-sphere」entry.

[66] I adapted the code for this presentation: in 2003, reduce was a built-in, but in Python 3 we need to import it; also, I replaced the names x and y with my_list and sub, for sub-list.

Chapter 11. Interfaces: From Protocols to ABCs

An abstract class represents an interface.[67]

— Bjarne Stroustrup Creator of C++

Interfaces are the subject of this chapter: from the dynamic protocols that are the hallmark of duck typing to abstract base classes (ABCs) that make interfaces explicit and verify implementations for conformance.

If you have a Java, C#, or similar background, the novelty here is in the informal protocols of duck typing. But for the long-time Pythonista or Rubyist, that is the「normal」way of thinking about interfaces, and the news is the formality and type-checking of ABCs. The language was 15 years old when ABCs were introduced in Python 2.6.

We’ll start the chapter by reviewing how the Python community traditionally understood interfaces as somewhat loose—in the sense that a partially implemented interface is often acceptable. We’ll make that clear through a couple examples that highlight the dynamic nature of duck typing.

Then, a guest essay by Alex Martelli will introduce ABCs and give name to a new trend in Python programming. The rest of the chapter will be devoted to ABCs, starting with their common use as superclasses when you need to implement an interface. We’ll then see when an ABC checks concrete subclasses for conformance to the interface it defines, and how a registration mechanism lets developers declare that a class implements an interface without subclassing. Finally, we’ll see how an ABC can be programmed to automatically「recognize」arbitrary classes that conform to its interface—without subclassing or explicit registration.

We will implement a new ABC to see how that works, but Alex Martelli and I don’t want to encourage you to start writing your own ABCs left and right. The risk of over-engineering with ABCs is very high.

Warning

ABCs, like descriptors and metaclasses, are tools for building frameworks. Therefore, only a very small minority of Python developers can create ABCs without imposing unreasonable limitations and needless work on fellow programmers.

Let’s get started with the Pythonic view of interfaces.

Interfaces and Protocols in Python Culture

Python was already highly successful before ABCs were introduced, and most existing code does not use them at all. Since Chapter 1, we’ve been talking about duck typing and protocols. In Protocols and Duck Typing, protocols are defined as the informal interfaces that make polymorphism work in languages with dynamic typing like Python.

How do interfaces work in a dynamic-typed language? First, the basics: even without an interface keyword in the language, and regardless of ABCs, every class has an interface: the set public attributes (methods or data attributes) implemented or inherited by the class. This includes special methods, like __getitem__ or __add__.

By definition, protected and private attributes are not part of an interface, even if「protected」is merely a naming convention (the single leading underscore) and private attributes are easily accessed (recall Private and「Protected」Attributes in Python). It is bad form to violate these conventions.

On the other hand, it’s not a sin to have public data attributes as part of the interface of an object, because—if necessary—a data attribute can always be turned into a property implementing getter/setter logic without breaking client code that uses the plain obj.attr syntax. We did that in the Vector2d class: in Example 11-1, we see the first implementation with public x and y attributes.

Example 11-1. vector2d_v0.py: x and y are public data attributes (same code as Example 9-2)

class Vector2d: typecode = 'd' def __init__(self, x, y): self.x = float(x) self.y = float(y) def __iter__(self): return (i for i in (self.x, self.y)) # more methods follow (omitted in this listing)

In Example 9-7, we turned x and y into read-only properties (Example 11-2). This is a significant refactoring, but an essential part of the interface of Vector2d is unchanged: users can still read my_vector.x and my_vector.y.

Example 11-2. vector2d_v3.py: x and y reimplemented as properties (see full listing in Example 9-9)

class Vector2d: typecode = 'd' def __init__(self, x, y): self.__x = float(x) self.__y = float(y) @property def x(self): return self.__x @property def y(self): return self.__y def __iter__(self): return (i for i in (self.x, self.y)) # more methods follow (omitted in this listing)

A useful complementary definition of interface is: the subset of an object’s public methods that enable it to play a specific role in the system. That’s what is implied when the Python documentation mentions「a file-like object」or「an iterable,」without specifying a class. An interface seen as a set of methods to fulfill a role is what Smalltalkers called a procotol, and the term spread to other dynamic language communities. Protocols are independent of inheritance. A class may implement several protocols, enabling its instances to fulfill several roles.

Protocols are interfaces, but because they are informal—defined only by documentation and conventions—protocols cannot be enforced like formal interfaces can (we’ll see how ABCs enforce interface conformance later in this chapter). A protocol may be partially implemented in a particular class, and that’s OK. Sometimes all a specific API requires from「a file-like object」is that it has a .read() method that returns bytes. The remaining file methods may or may not be relevant in the context.

As I write this, the Python 3 documentation of memoryview says that it works with objects that「support the buffer protocol, which is only documented at the C API level. The bytearray constructor accepts an「an object conforming to the buffer interface.」Now there is a move to adopt「bytes-like object」as a friendlier term.[68] I point this out to emphasize that「X-like object,」「X protocol,」and「X interface」are synonyms in the minds of Pythonistas.

One of the most fundamental interfaces in Python is the sequence protocol. The interpreter goes out of its way to handle objects that provide even a minimal implementation of that protocol, as the next section demonstrates.

Python Digs Sequences

The philosophy of the Python data model is to cooperate with essential protocols as much as possible. When it comes to sequences, Python tries hard to work with even the simplest implementations.

