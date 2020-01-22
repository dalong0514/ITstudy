Create a globe instance with five items (each of the vowels).

Pop one of the items, and verify it is one the vowels.

Confirm that the globe is down to four items.

Create a second instance, with three items.

Create a third instance by adding the previous two. This instance has seven items.

Attempting to add an AddableBingoCage to a list fails with TypeError. That error message is produced by the Python interpreter when our __add__ method returns NotImplemented.

Because an AddableBingoCage is mutable, Example 13-17 shows how it will work when we implement __iadd__.

Example 13-17. An existing AddableBingoCage can be loaded with += (continuing from Example 13-16)

>>> globe_orig = globe >>> len(globe.inspect()) 4 >>> globe += globe2 >>> len(globe.inspect()) 7 >>> globe += ['M', 'N'] >>> len(globe.inspect()) 9 >>> globe is globe_orig True >>> globe += 1 Traceback (most recent call last): ... TypeError: right operand in += must be 'AddableBingoCage' or an iterable

Create an alias so we can check the identity of the object later.

globe has four items here.

An AddableBingoCage instance can receive items from another instance of the same class.

The righthand operand of += can also be any iterable.

Throughout this example, globe has always referred to the globe_orig object.

Trying to add a noniterable to an AddableBingoCage fails with a proper error message.

Note that the += operator is more liberal than + with regard to the second operand. With +, we want both operands to be of the same type (AddableBingoCage, in this case), because if we accepted different types this might cause confusion as to the type of the result. With the +=, the situation is clearer: the lefthand object is updated in place, so there’s no doubt about the type of the result.

Tip

I validated the contrasting behavior of + and += by observing how the list built-in type works. Writing my_list + x, you can only concatenate one list to another list, but if you write my_list += x, you can extend the lefthand list with items from any iterable x on the righthand side. This is consistent with how the list.extend() method works: it accepts any iterable argument.

Now that we are clear on the desired behavior for AddableBingoCage, we can look at its implementation in Example 13-18.

Example 13-18. bingoaddable.py: AddableBingoCage extends BingoCage to support + and +=

import itertools from tombola import Tombola from bingo import BingoCage class AddableBingoCage(BingoCage): def __add__(self, other): if isinstance(other, Tombola): return AddableBingoCage(self.inspect() + other.inspect()) else: return NotImplemented def __iadd__(self, other): if isinstance(other, Tombola): other_iterable = other.inspect() else: try: other_iterable = iter(other) except TypeError: self_cls = type(self).__name__ msg = "right operand in += must be {!r} or an iterable" raise TypeError(msg.format(self_cls)) self.load(other_iterable) return self

PEP 8 — Style Guide for Python Code recommends coding imports from the standard library above imports of your own modules.

AddableBingoCage extends BingoCage.

Our __add__ will only work with an instance of Tombola as the second operand.

Retrieve items from other, if it is an instance of Tombola.

Otherwise, try to obtain an iterator over other.[102]

If that fails, raise an exception explaining what the user should do. When possible, error messages should explicitly guide the user to the solution.

If we got this far, we can load the other_iterable into self.

Very important: augmented assignment special methods must return self.

We can summarize the whole idea of in-place operators by contrasting the return statements that produce results in __add__ and __iadd__ in Example 13-18:

__add__

The result is produced by calling the constructor AddableBingoCage to build a new instance.

__iadd__

The result is produced by returning self, after it has been modified.

To wrap up this example, a final observation on Example 13-18: by design, no __radd__ was coded in AddableBingoCage, because there is no need for it. The forward method __add__ will only deal with righthand operands of the same type, so if Python is trying to compute a + b where a is an AddableBingoCage and b is not, we return NotImplemented—maybe the class of b can make it work. But if the expression is b + a and b is not an AddableBingoCage, and it returns NotImplemented, then it’s better to let Python give up and raise TypeError because we cannot handle b.

Tip

In general, if a forward infix operator method (e.g., __mul__) is designed to work only with operands of the same type as self, it’s useless to implement the corresponding reverse method (e.g., __rmul__) because that, by definition, will only be invoked when dealing with an operand of a different type.

This concludes our exploration of operator overloading in Python.

Chapter Summary

We started this chapter by reviewing some restrictions Python imposes on operator overloading: no overloading of operators in built-in types, and overloading limited to existing operators, except for a few ones (is, and, or, not).

We got down to business with the unary operators, implementing __neg__ and __pos__. Next came the infix operators, starting with +, supported by the __add__ method. We saw that unary and infix operators are supposed to produce results by creating new objects, and should never change their operands. To support operations with other types, we return the NotImplemented special value—not an exception—allowing the interpreter to try again by swapping the operands and calling the reverse special method for that operator (e.g., __radd__). The algorithm Python uses to handle infix operators is summarized in the flowchart in Figure 13-1.

Mixing operand types means we need to detect when we get an operand we can’t handle. In this chapter, we did this in two ways: in the duck typing way, we just went ahead and tried the operation, catching a TypeError exception if it happened; later, in __mul__, we did it with an explicit isinstance test. There are pros and cons to these approaches: duck typing is more flexible, but explicit type checking is more predictable. When we did use isinstance, we were careful to avoid testing with a concrete class, but used the numbers.Real ABC: isinstance(scalar, numbers.Real). This is a good compromise between flexibility and safety, because existing or future user-defined types can be declared as actual or virtual subclasses of an ABC, as we saw in Chapter 11.

The next topic we covered was the rich comparison operators. We implemented == with __eq__ and discovered that Python provides a handy implementation of != in the __ne__ inherited from the object base class. The way Python evaluates these operators along with >, <, >=, and <= is slightly different, with a different logic for choosing the reverse method, and special fallback handling for == and !=, which never generate errors because Python compares the object IDs as a last resort.

In the last section, we focused on augmented assignment operators. We saw that Python handles them by default as a combination of plain operator followed by assignment, that is: a += b is evaluated exactly as a = a + b. That always creates a new object, so it works for mutable or immutable types. For mutable objects, we can implement in-place special methods such as __iadd__ for +=, and alter the value of the lefthand operand. To show this at work, we left behind the immutable Vector class and worked on implementing a BingoCage subclass to support += for adding items to the random pool, similar to the way the list built-in supports += as a shortcut for the list.extend() method. While doing this, we discussed how + tends to be stricter than += regarding the types it accepts. For sequence types, + usually requires that both operands are of the same type, while += often accepts any iterable as the righthand operand.

Further Reading

Operator overloading is one area of Python programming where isinstance tests are common. In general, libraries should leverage dynamic typing—to be more flexible—by avoiding explicit type tests and just trying operations and then handling the exceptions, opening the door for working with objects regardless of their types, as long as they support the necessary operations. But Python ABCs allow a stricter form of duck typing, dubbed「goose typing」by Alex Martelli, which is often useful when writing code that overloads operators. So, if you skipped Chapter 11, make sure to read it.

The main reference for the operator special methods is the「Data Model」chapter. It’s the canonical source, but at this time it’s plagued by that glaring bug mentioned in Python 3 Documentation Bug, advising「when defining __eq__(), one should also define __ne__().」In reality, the __ne__ inherited from the object class in Python 3 covers the vast majority of needs, so implementing __ne__ is rarely necessary in practice. Another relevant reading in the Python documentation is「9.1.2.2. Implementing the arithmetic operations」in the numbers module of The Python Standard Library.

A related technique is generic functions, supported by the @singledispatch decorator in Python 3 (Generic Functions with Single Dispatch). In Python Cookbook, 3E (O’Reilly), by David Beazley and Brian K. Jones,「Recipe 9.20. Implementing Multiple Dispatch with Function Annotations」uses some advanced metaprogramming—involving a metaclass—to implement type-based dispatching with function annotations. The second edition of the Python Cookbook by Martelli, Ravenscroft, and Ascher has an interesting recipe (2.13, by Erik Max Francis) showing how to overload the << operator to emulate the C++ iostream syntax in Python. Both books have other examples with operator overloading, I just picked two notable recipes.

The functools.total_ordering function is a class decorator (supported in Python 2.7 and later) that automatically generates methods for all rich comparison operators in any class that defines at least a couple of them. See the functools module docs.

If you are curious about operator method dispatching in languages with dynamic typing, two seminal readings are「A Simple Technique for Handling Multiple Polymorphism」by Dan Ingalls (member of the original Smalltalk team) and「Arithmetic and Double Dispatching in Smalltalk-80」by Kurt J. Hebel and Ralph Johnson (Johnson became famous as one of the authors of the original Design Patterns book). Both papers provide deep insight into the power of polymorphism in languages with dynamic typing, like Smalltalk, Python, and Ruby. Python does not use double dispatching for handling operators as described in those articles. The Python algorithm using forward and reverse operators is easier for user-defined classes to support than double dispatching, but requires special handling by the interpreter. In contrast, classic double dispatching is a general technique you can use in Python or any OO language beyond the specific context of infix operators, and in fact Ingalls, Hebel, and Johnson use very different examples to describe it.

The article「The C Family of Languages: Interview with Dennis Ritchie, Bjarne Stroustrup, and James Gosling」from which I quoted the epigraph in this chapter, and two other snippets in Soapbox, appeared in Java Report, 5(7), July 2000 and C++ Report, 12(7), July/August 2000. It’s an awesome reading if you are into programming language design.

Soapbox

Operator Overloading: Pros and Cons

James Gosling, quoted at the start of this chapter, made the conscious decision to leave operator overloading out when he designed Java. In that same interview (「The C Family of Languages: Interview with Dennis Ritchie, Bjarne Stroustrup, and James Gosling」) he says:

Probably about 20 to 30 percent of the population think of operator overloading as the spawn of the devil; somebody has done something with operator overloading that has just really ticked them off, because they’ve used like + for list insertion and it makes life really, really confusing. A lot of that problem stems from the fact that there are only about half a dozen operators you can sensibly overload, and yet there are thousands or millions of operators that people would like to define—so you have to pick, and often the choices conflict with your sense of intuition.

Guido van Rossum picked the middle way in supporting operator overloading: he did not leave the door open for users creating new arbitrary operators like <=> or :-), which prevents a Tower of Babel of custom operators, and allows the Python parser to be simple. Python also does not let you overload the operators of the built-in types, another limitation that promotes readability and predictable performance.

Gosling goes on to say:

Then there’s a community of about 10 percent that have actually used operator overloading appropriately and who really care about it, and for whom it’s actually really important; this is almost exclusively people who do numerical work, where the notation is very important to appealing to people’s intuition, because they come into it with an intuition about what the + means, and the ability to say「a + b」where a and b are complex numbers or matrices or something really does make sense.

The notation side of the issue cannot be underestimated. Here is an illustrative example from the realm of finances. In Python, you can compute compound interest using a formula written like this:

interest = principal * ((1 + rate) ** periods - 1)

That same notation works regardless of the numeric types involved. Thus, if you are doing serious financial work, you can make sure that periods is an int, while rate, interest, and principal are exact numbers—instances of the Python decimal.Decimal class — and that formula will work exactly as written.

But in Java, if you switch from float to BigDecimal to get arbitrary precision, you can’t use infix operators anymore, because they only work with the primitive types. This is the same formula coded to work with BigDecimal numbers in Java:

BigDecimal interest = principal.multiply(BigDecimal.ONE.add(rate) .pow(periods).subtract(BigDecimal.ONE));

It’s clear that infix operators make formulas more readable, at least for most of us.[103] And operator overloading is necessary to support nonprimitive types with infix operator notation. Having operator overloading in a high-level, easy-to-use language was probably a key reason for the amazing penetration of Python in scientific computing in recent years.

Of course, there are benefits to disallowing operator overloading in a language. It is arguably a sound decision for lower-level systems languages where performance and safety are paramount. The much newer Go language followed the lead of Java in this regard and does not support operator overloading.

But overloaded operators, when used sensibly, do make code easier to read and write. It’s a great feature to have in a modern high-level language.

A Glimpse at Lazy Evaluation

If you look closely at the traceback in Example 13-9, you’ll see evidence of the lazy evaluation of generator expressions. Example 13-19 is that same traceback, now with callouts.

Example 13-19. Same as Example 13-9

>>> v1 + 'ABC' Traceback (most recent call last): File "<stdin>", line 1, in <module> File "vector_v6.py", line 329, in __add__ return Vector(a + b for a, b in pairs) # File "vector_v6.py", line 243, in __init__ self._components = array(self.typecode, components) # File "vector_v6.py", line 329, in <genexpr> return Vector(a + b for a, b in pairs) # TypeError: unsupported operand type(s) for +: 'float' and 'str'

The Vector call gets a generator expression as its components argument. No problem at this stage.

The components genexp is passed to the array constructor. Within the array constructor, Python tries to iterate over the genexp, causing the evaluation of the first item a + b. That’s when the TypeError occurs.

The exception propagates to the Vector constructor call, where it is reported.

This shows how the generator expression is evaluated at the latest possible moment, and not where it is defined in the source code.

In contrast, if the Vector constructor was invoked as Vector([a + b for a, b in pairs]), then the exception would happen right there, because the list comprehension tried to build a list to be passed as the argument to the Vector() call. The body of Vector.__init__ would not be reached at all.

Chapter 14 will cover generator expressions in detail, but I did not want to let this accidental demonstration of their lazy nature go unnoticed.

* * *

[98] Source:「The C Family of Languages: Interview with Dennis Ritchie, Bjarne Stroustrup, and James Gosling」.

[99] The Python documentation uses both terms. The「Data Model」chapter uses「reflected,」but「9.1.2.2. Implementing the arithmetic operations」in the numbers module docs mention「forward」and「reverse」methods, and I find this terminology better, because「forward」and「reversed」clearly name each of the directions, while「reflected」doesn’t have an obvious opposite.

[100] The @ sign can be used as an infix dot product operator starting with Python 3.5. More about it in The New @ Infix Operator in Python 3.5.

[101] The logic for object.__eq__ and object.__ne__ is in function object_richcompare in Objects/typeobject.c in the CPython source code.

[102] The iter built-in function will be covered in the next chapter. Here I could have used tuple(other), and it would work, but at the cost of building a new tuple when all the .load(…) method needs is to iterate over its argument.

[103] My friend Mario Domenech Goulart, a core developer of the CHICKEN Scheme compiler, will probably disagree with this.

Part V. Control Flow

Chapter 14. Iterables, Iterators, and Generators

When I see patterns in my programs, I consider it a sign of trouble. The shape of a program should reflect only the problem it needs to solve. Any other regularity in the code is a sign, to me at least, that I’m using abstractions that aren’t powerful enough—often that I’m generating by hand the expansions of some macro that I need to write.[104]

— Paul Graham Lisp hacker and venture capitalist

Iteration is fundamental to data processing. And when scanning datasets that don’t fit in memory, we need a way to fetch the items lazily, that is, one at a time and on demand. This is what the Iterator pattern is about. This chapter shows how the Iterator pattern is built into the Python language so you never need to implement it by hand.

Python does not have macros like Lisp (Paul Graham’s favorite language), so abstracting away the Iterator pattern required changing the language: the yield keyword was added in Python 2.2 (2001).[105] The yield keyword allows the construction of generators, which work as iterators.

Note

Every generator is an iterator: generators fully implement the iterator interface. But an iterator—as defined in the GoF book—retrieves items from a collection, while a generator can produce items「out of thin air.」That’s why the Fibonacci sequence generator is a common example: an infinite series of numbers cannot be stored in a collection. However, be aware that the Python community treats iterator and generator as synonyms most of the time.

Python 3 uses generators in many places. Even the range() built-in now returns a generator-like object instead of full-blown lists like before. If you must build a list from range, you have to be explicit (e.g., list(range(100))).

Every collection in Python is iterable, and iterators are used internally to support:

for loops

Collection types construction and extension

Looping over text files line by line

List, dict, and set comprehensions

Tuple unpacking

Unpacking actual parameters with * in function calls

This chapter covers the following topics:

How the iter(…) built-in function is used internally to handle iterable objects

How to implement the classic Iterator pattern in Python

How a generator function works in detail, with line-by-line descriptions

How the classic Iterator can be replaced by a generator function or generator expression

Leveraging the general-purpose generator functions in the standard library

Using the new yield from statement to combine generators

A case study: using generator functions in a database conversion utility designed to work with large datasets

Why generators and coroutines look alike but are actually very different and should not be mixed

We’ll get started studying how the iter(…) function makes sequences iterable.

Sentence Take #1: A Sequence of Words

We’ll start our exploration of iterables by implementing a Sentence class: you give its constructor a string with some text, and then you can iterate word by word. The first version will implement the sequence protocol, and it’s iterable because all sequences are iterable, as we’ve seen before, but now we’ll see exactly why.

Example 14-1 shows a Sentence class that extracts words from a text by index.

Example 14-1. sentence.py: A Sentence as a sequence of words

import re import reprlib RE_WORD = re.compile('\w+') class Sentence: def __init__(self, text): self.text = text self.words = RE_WORD.findall(text) def __getitem__(self, index): return self.words[index] def __len__(self): return len(self.words) def __repr__(self): return 'Sentence(%s)' % reprlib.repr(self.text)

re.findall returns a list with all nonoverlapping matches of the regular expression, as a list of strings.

self.words holds the result of .findall, so we simply return the word at the given index.

To complete the sequence protocol, we implement __len__—but it is not needed to make an iterable object.

reprlib.repr is a utility function to generate abbreviated string representations of data structures that can be very large.[106]

By default, reprlib.repr limits the generated string to 30 characters. See the console session in Example 14-2 to see how Sentence is used.

Example 14-2. Testing iteration on a Sentence instance

>>> s = Sentence('"The time has come," the Walrus said,') # >>> s Sentence('"The time ha... Walrus said,') # >>> for word in s: # ... print(word) The time has come the Walrus said >>> list(s) # ['The', 'time', 'has', 'come', 'the', 'Walrus', 'said']

A sentence is created from a string.

Note the output of __repr__ using ... generated by reprlib.repr.

Sentence instances are iterable; we’ll see why in a moment.

Being iterable, Sentence objects can be used as input to build lists and other iterable types.

In the following pages, we’ll develop other Sentence classes that pass the tests in Example 14-2. However, the implementation in Example 14-1 is different from all the others because it’s also a sequence, so you can get words by index:

>>> s[0] 'The' >>> s[5] 'Walrus' >>> s[-1] 'said'

Every Python programmer knows that sequences are iterable. Now we’ll see precisely why.

Why Sequences Are Iterable: The iter Function

Whenever the interpreter needs to iterate over an object x, it automatically calls iter(x).

The iter built-in function:

Checks whether the object implements __iter__, and calls that to obtain an iterator.

If __iter__ is not implemented, but __getitem__ is implemented, Python creates an iterator that attempts to fetch items in order, starting from index 0 (zero).

If that fails, Python raises TypeError, usually saying「C object is not iterable,」where C is the class of the target object.

That is why any Python sequence is iterable: they all implement __getitem__. In fact, the standard sequences also implement __iter__, and yours should too, because the special handling of __getitem__ exists for backward compatibility reasons and may be gone in the future (although it is not deprecated as I write this).

As mentioned in Python Digs Sequences, this is an extreme form of duck typing: an object is considered iterable not only when it implements the special method __iter__, but also when it implements __getitem__, as long as __getitem__ accepts int keys starting from 0.

In the goose-typing approach, the definition for an iterable is simpler but not as flexible: an object is considered iterable if it implements the __iter__ method. No subclassing or registration is required, because abc.Iterable implements the __subclasshook__, as seen in Geese Can Behave as Ducks. Here is a demonstration:

>>> class Foo: ... def __iter__(self): ... pass ... >>> from collections import abc >>> issubclass(Foo, abc.Iterable) True >>> f = Foo() >>> isinstance(f, abc.Iterable) True

However, note that our initial Sentence class does not pass the issubclass(Sentence, abc.Iterable) test, even though it is iterable in practice.

Tip

As of Python 3.4, the most accurate way to check whether an object x is iterable is to call iter(x) and handle a TypeError exception if it isn’t. This is more accurate than using isinstance(x, abc.Iterable), because iter(x) also considers the legacy __getitem__ method, while the Iterable ABC does not.

Explicitly checking whether an object is iterable may not be worthwhile if right after the check you are going to iterate over the object. After all, when the iteration is attempted on a noniterable, the exception Python raises is clear enough: TypeError: 'C' object is not iterable . If you can do better than just raising TypeError, then do so in a try/except block instead of doing an explicit check. The explicit check may make sense if you are holding on to the object to iterate over it later; in this case, catching the error early may be useful.

The next section makes explicit the relationship between iterables and iterators.

Iterables Versus Iterators

From the explanation in Why Sequences Are Iterable: The iter Function we can extrapolate a definition:

iterable

Any object from which the iter built-in function can obtain an iterator. Objects implementing an __iter__ method returning an iterator are iterable. Sequences are always iterable; as are objects implementing a __getitem__ method that takes 0-based indexes.

It’s important to be clear about the relationship between iterables and iterators: Python obtains iterators from iterables.

Here is a simple for loop iterating over a str. The str 'ABC' is the iterable here. You don’t see it, but there is an iterator behind the curtain:

>>> s = 'ABC' >>> for char in s: ... print(char) ... A B C

If there was no for statement and we had to emulate the for machinery by hand with a while loop, this is what we’d have to write:

>>> s = 'ABC' >>> it = iter(s) # >>> while True: ... try: ... print(next(it)) # ... except StopIteration: # ... del it # ... break # ... A B C

Build an iterator it from the iterable.

Repeatedly call next on the iterator to obtain the next item.

The iterator raises StopIteration when there are no further items.

Release reference to it—the iterator object is discarded.

Exit the loop.

StopIteration signals that the iterator is exhausted. This exception is handled internally in for loops and other iteration contexts like list comprehensions, tuple unpacking, etc.

The standard interface for an iterator has two methods:

__next__

Returns the next available item, raising StopIteration when there are no more items.

__iter__

Returns self; this allows iterators to be used where an iterable is expected, for example, in a for loop.

This is formalized in the collections.abc.Iterator ABC, which defines the __next__ abstract method, and subclasses Iterable—where the abstract __iter__ method is defined. See Figure 14-1.

Figure 14-1. The Iterable and Iterator ABCs. Methods in italic are abstract. A concrete Iterable.iter should return a new Iterator instance. A concrete Iterator must implement next. The Iterator.iter method just returns the instance itself.

The Iterator ABC implements __iter__ by doing return self. This allows an iterator to be used wherever an iterable is required. The source code for abc.Iterator is in Example 14-3.

Example 14-3. abc.Iterator class; extracted from Lib/_collections_abc.py

class Iterator(Iterable): __slots__ = () @abstractmethod def __next__(self): 'Return the next item from the iterator. When exhausted, raise StopIteration' raise StopIteration def __iter__(self): return self @classmethod def __subclasshook__(cls, C): if cls is Iterator: if (any("__next__" in B.__dict__ for B in C.__mro__) and any("__iter__" in B.__dict__ for B in C.__mro__)): return True return NotImplemented

Warning

The Iterator ABC abstract method is it.__next__() in Python 3 and it.next() in Python 2. As usual, you should avoid calling special methods directly. Just use the next(it): this built-in function does the right thing in Python 2 and 3.

The Lib/types.py module source code in Python 3.4 has a comment that says:

# Iterators in Python aren't a matter of type but of protocol. A large # and changing number of builtin types implement *some* flavor of # iterator. Don't check the type! Use hasattr to check for both # "__iter__" and "__next__" attributes instead.

In fact, that’s exactly what the __subclasshook__ method of the abc.Iterator ABC does (see Example 14-3).

Tip

Taking into account the advice from Lib/types.py and the logic implemented in Lib/_collections_abc.py, the best way to check if an object x is an iterator is to call isinstance(x, abc.Iterator). Thanks to Iterator.__subclasshook__, this test works even if the class of x is not a real or virtual subclass of Iterator.

Back to our Sentence class from Example 14-1, you can clearly see how the iterator is built by iter(…) and consumed by next(…) using the Python console:

>>> s3 = Sentence('Pig and Pepper') # >>> it = iter(s3) # >>> it # doctest: +ELLIPSIS <iterator object at 0x...> >>> next(it) # 'Pig' >>> next(it) 'and' >>> next(it) 'Pepper' >>> next(it) # Traceback (most recent call last): ... StopIteration >>> list(it) # [] >>> list(iter(s3)) # ['Pig', 'and', 'Pepper']

Create a sentence s3 with three words.

Obtain an iterator from s3.

next(it) fetches the next word.

There are no more words, so the iterator raises a StopIteration exception.

Once exhausted, an iterator becomes useless.

To go over the sentence again, a new iterator must be built.

Because the only methods required of an iterator are __next__ and __iter__, there is no way to check whether there are remaining items, other than to call next() and catch StopInteration. Also, it’s not possible to「reset」an iterator. If you need to start over, you need to call iter(…) on the iterable that built the iterator in the first place. Calling iter(…) on the iterator itself won’t help, because—as mentioned—Iterator.__iter__ is implemented by returning self, so this will not reset a depleted iterator.

To wrap up this section, here is a definition for iterator:

iterator

Any object that implements the __next__ no-argument method that returns the next item in a series or raises StopIteration when there are no more items. Python iterators also implement the __iter__ method so they are iterable as well.

This first version of Sentence was iterable thanks to the special treatment the iter(…) built-in gives to sequences. Now we’ll implement the standard iterable protocol.

Sentence Take #2: A Classic Iterator

The next Sentence class is built according to the classic Iterator design pattern following the blueprint in the GoF book. Note that this is not idiomatic Python, as the next refactorings will make very clear. But it serves to make explicit the relationship between the iterable collection and the iterator object.

Example 14-4 shows an implementation of a Sentence that is iterable because it implements the __iter__ special method, which builds and returns a SentenceIterator. This is how the Iterator design pattern is described in the original Design Patterns book.

We are doing it this way here just to make clear the crucial distinction between an iterable and an iterator and how they are connected.

Example 14-4. sentence_iter.py: Sentence implemented using the Iterator pattern

import re import reprlib RE_WORD = re.compile('\w+') class Sentence: def __init__(self, text): self.text = text self.words = RE_WORD.findall(text) def __repr__(self): return 'Sentence(%s)' % reprlib.repr(self.text) def __iter__(self): return SentenceIterator(self.words) class SentenceIterator: def __init__(self, words): self.words = words self.index = 0 def __next__(self): try: word = self.words[self.index] except IndexError: raise StopIteration() self.index += 1 return word def __iter__(self): return self

The __iter__ method is the only addition to the previous Sentence implementation. This version has no __getitem__, to make it clear that the class is iterable because it implements __iter__.

__iter__ fulfills the iterable protocol by instantiating and returning an iterator.

SentenceIterator holds a reference to the list of words.

self.index is used to determine the next word to fetch.

Get the word at self.index.

If there is no word at self.index, raise StopIteration.

Increment self.index.

Return the word.

Implement self.__iter__.

The code in Example 14-4 passes the tests in Example 14-2.

Note that implementing __iter__ in SentenceIterator is not actually needed for this example to work, but the it’s the right thing to do: iterators are supposed to implement both __next__ and __iter__, and doing so makes our iterator pass the issubclass(SentenceInterator, abc.Iterator) test. If we had subclassed SentenceIterator from abc.Iterator, we’d inherit the concrete abc.Iterator.__iter__ method.

That is a lot of work (for us lazy Python programmers, anyway). Note how most code in SentenceIterator deals with managing the internal state of the iterator. Soon we’ll see how to make it shorter. But first, a brief detour to address an implementation shortcut that may be tempting, but is just wrong.

Making Sentence an Iterator: Bad Idea

A common cause of errors in building iterables and iterators is to confuse the two. To be clear: iterables have an __iter__ method that instantiates a new iterator every time. Iterators implement a __next__ method that returns individual items, and an __iter__ method that returns self.

Therefore, iterators are also iterable, but iterables are not iterators.

It may be tempting to implement __next__ in addition to __iter__ in the Sentence class, making each Sentence instance at the same time an iterable and iterator over itself. But this is a terrible idea. It’s also a common anti-pattern, according to Alex Martelli who has a lot of experience with Python code reviews.

The「Applicability」section[107] of the Iterator design pattern in the GoF book says:

Use the Iterator pattern

to access an aggregate object’s contents without exposing its internal representation.

to support multiple traversals of aggregate objects.

to provide a uniform interface for traversing different aggregate structures (that is, to support polymorphic iteration).

To「support multiple traversals」it must be possible to obtain multiple independent iterators from the same iterable instance, and each iterator must keep its own internal state, so a proper implementation of the pattern requires each call to iter(my_iterable) to create a new, independent, iterator. That is why we need the SentenceIterator class in this example.

Tip

An iterable should never act as an iterator over itself. In other words, iterables must implement __iter__, but not __next__.

On the other hand, for convenience, iterators should be iterable. An iterator’s __iter__ should just return self.

Now that the classic Iterator pattern is properly demonstrated, we can get let it go. The next section presents a more idiomatic implementation of Sentence.

Sentence Take #3: A Generator Function

A Pythonic implementation of the same functionality uses a generator function to replace the SequenceIterator class. A proper explanation of the generator function comes right after Example 14-5.

Example 14-5. sentence_gen.py: Sentence implemented using a generator function

import re import reprlib RE_WORD = re.compile('\w+') class Sentence: def __init__(self, text): self.text = text self.words = RE_WORD.findall(text) def __repr__(self): return 'Sentence(%s)' % reprlib.repr(self.text) def __iter__(self): for word in self.words: yield word return # done!

Iterate over self.word.

Yield the current word.

This return is not needed; the function can just「fall-through」and return automatically. Either way, a generator function doesn’t raise StopIteration: it simply exits when it’s done producing values.[108]

No need for a separate iterator class!

Here again we have a different implementation of Sentence that passes the tests in Example 14-2.

Back in the Sentence code in Example 14-4, __iter__ called the SentenceIterator constructor to build an iterator and return it. Now the iterator in Example 14-5 is in fact a generator object, built automatically when the __iter__ method is called, because __iter__ here is a generator function.

A full explanation of generator functions follows.

How a Generator Function Works

Any Python function that has the yield keyword in its body is a generator function: a function which, when called, returns a generator object. In other words, a generator function is a generator factory.

Tip

The only syntax distinguishing a plain function from a generator function is the fact that the latter has a yield keyword somewhere in its body. Some argued that a new keyword like gen should be used for generator functions instead of def, but Guido did not agree. His arguments are in PEP 255 — Simple Generators.[109]

Here is the simplest function useful to demonstrate the behavior of a generator:[110]

>>> def gen_123(): # ... yield 1 # ... yield 2 ... yield 3 ... >>> gen_123 # doctest: +ELLIPSIS <function gen_123 at 0x...> # >>> gen_123() # doctest: +ELLIPSIS <generator object gen_123 at 0x...> # >>> for i in gen_123(): # ... print(i) 1 2 3 >>> g = gen_123() # >>> next(g) # 1 >>> next(g) 2 >>> next(g) 3 >>> next(g) # Traceback (most recent call last): ... StopIteration

Any Python function that contains the yield keyword is a generator function.

Usually the body of a generator function has loop, but not necessarily; here I just repeat yield three times.

Looking closely, we see gen_123 is a function object.

But when invoked, gen_123() returns a generator object.

Generators are iterators that produce the values of the expressions passed to yield.

For closer inspection, we assign the generator object to g.

Because g is an iterator, calling next(g) fetches the next item produced by yield.

When the body of the function completes, the generator object raises a StopIteration.

A generator function builds a generator object that wraps the body of the function. When we invoke next(…) on the generator object, execution advances to the next yield in the function body, and the next(…) call evaluates to the value yielded when the function body is suspended. Finally, when the function body returns, the enclosing generator object raises StopIteration, in accordance with the Iterator protocol.

Tip

I find it helpful to be strict when talking about the results obtained from a generator: I say that a generator yields or produces values. But it’s confusing to say a generator「returns」values. Functions return values. Calling a generator function returns a generator. A generator yields or produces values. A generator doesn’t「return」values in the usual way: the return statement in the body of a generator function causes StopIteration to be raised by the generator object.[111]

Example 14-6 makes the interaction between a for loop and the body of the function more explicit.

Example 14-6. A generator function that prints messages when it runs

>>> def gen_AB(): # ... print('start') ... yield 'A' # ... print('continue') ... yield 'B' # ... print('end.') # ... >>> for c in gen_AB(): # ... print('-->', c) # ... start --> A continue --> B end. >>>

The generator function is defined like any function, but uses yield.

The first implicit call to next() in the for loop at will print 'start' and stop at the first yield, producing the value 'A'.

The second implicit call to next() in the for loop will print 'continue' and stop at the second yield, producing the value 'B'.

The third call to next() will print 'end.' and fall through the end of the function body, causing the generator object to raise StopIteration.

To iterate, the for machinery does the equivalent of g = iter(gen_AB()) to get a generator object, and then next(g) at each iteration.

The loop block prints --> and the value returned by next(g). But this output will be seen only after the output of the print calls inside the generator function.

The string 'start' appears as a result of print('start') in the generator function body.

yield 'A' in the generator function body produces the value A consumed by the for loop, which gets assigned to the c variable and results in the output --> A.

Iteration continues with a second call next(g), advancing the generator function body from yield 'A' to yield 'B'. The text continue is output because of the second print in the generator function body.

yield 'B' produces the value B consumed by the for loop, which gets assigned to the c loop variable, so the loop prints --> B.

Iteration continues with a third call next(it), advancing to the end of the body of the function. The text end. appears in the output because of the third print in the generator function body.

When the generator function body runs to the end, the generator object raises StopIteration. The for loop machinery catches that exception, and the loop terminates cleanly.

Now hopefully it’s clear how Sentence.__iter__ in Example 14-5 works: __iter__ is a generator function which, when called, builds a generator object that implements the iterator interface, so the SentenceIterator class is no longer needed.

This second version of Sentence is much shorter than the first, but it’s not as lazy as it could be. Nowadays, laziness is considered a good trait, at least in programming languages and APIs. A lazy implementation postpones producing values to the last possible moment. This saves memory and may avoid useless processing as well.

We’ll build a lazy Sentence class next.

Sentence Take #4: A Lazy Implementation

The Iterator interface is designed to be lazy: next(my_iterator) produces one item at a time. The opposite of lazy is eager: lazy evaluation and eager evaluation are actual technical terms in programming language theory.

Our Sentence implementations so far have not been lazy because the __init__ eagerly builds a list of all words in the text, binding it to the self.words attribute. This will entail processing the entire text, and the list may use as much memory as the text itself (probably more; it depends on how many nonword characters are in the text). Most of this work will be in vain if the user only iterates over the first couple words.

Whenever you are using Python 3 and start wondering「Is there a lazy way of doing this?」, often the answer is「Yes.」

The re.finditer function is a lazy version of re.findall which, instead of a list, returns a generator producing re.MatchObject instances on demand. If there are many matches, re.finditer saves a lot of memory. Using it, our third version of Sentence is now lazy: it only produces the next word when it is needed. The code is in Example 14-7.

Example 14-7. sentence_gen2.py: Sentence implemented using a generator function calling the re.finditer generator function

import re import reprlib RE_WORD = re.compile('\w+') class Sentence: def __init__(self, text): self.text = text def __repr__(self): return 'Sentence(%s)' % reprlib.repr(self.text) def __iter__(self): for match in RE_WORD.finditer(self.text): yield match.group()

No need to have a words list.

finditer builds an iterator over the matches of RE_WORD on self.text, yielding MatchObject instances.

match.group() extracts the actual matched text from the MatchObject instance.

Generator functions are an awesome shortcut, but the code can be made even shorter with a generator expression.

Sentence Take #5: A Generator Expression

Simple generator functions like the one in the previous Sentence class (Example 14-7) can be replaced by a generator expression.

A generator expression can be understood as a lazy version of a list comprehension: it does not eagerly build a list, but returns a generator that will lazily produce the items on demand. In other words, if a list comprehension is a factory of lists, a generator expression is a factory of generators.

Example 14-8 is a quick demo of a generator expression, comparing it to a list comprehension.

Example 14-8. The gen_AB generator function is used by a list comprehension, then by a generator expression

>>> def gen_AB(): # ... print('start') ... yield 'A' ... print('continue') ... yield 'B' ... print('end.') ... >>> res1 = [x*3 for x in gen_AB()] # start continue end. >>> for i in res1: # ... print('-->', i) ... --> AAA --> BBB >>> res2 = (x*3 for x in gen_AB()) # >>> res2 # <generator object <genexpr> at 0x10063c240> >>> for i in res2: # ... print('-->', i) ... start --> AAA continue --> BBB end.

This is the same gen_AB function from Example 14-6.

The list comprehension eagerly iterates over the items yielded by the generator object produced by calling gen_AB(): 'A' and 'B'. Note the output in the next lines: start, continue, end.

This for loop is iterating over the res1 list produced by the list comprehension.

The generator expression returns res2. The call to gen_AB() is made, but that call returns a generator, which is not consumed here.

res2 is a generator object.

Only when the for loop iterates over res2, the body of gen_AB actually executes. Each iteration of the for loop implicitly calls next(res2), advancing gen_AB to the next yield. Note the output of gen_AB with the output of the print in the for loop.

So, a generator expression produces a generator, and we can use it to further reduce the code in the Sentence class. See Example 14-9.

Example 14-9. sentence_genexp.py: Sentence implemented using a generator expression

import re import reprlib RE_WORD = re.compile('\w+') class Sentence: def __init__(self, text): self.text = text def __repr__(self): return 'Sentence(%s)' % reprlib.repr(self.text) def __iter__(self): return (match.group() for match in RE_WORD.finditer(self.text))

The only difference from Example 14-7 is the __iter__ method, which here is not a generator function (it has no yield) but uses a generator expression to build a generator and then returns it. The end result is the same: the caller of __iter__ gets a generator object.

Generator expressions are syntactic sugar: they can always be replaced by generator functions, but sometimes are more convenient. The next section is about generator expression usage.

Generator Expressions: When to Use Them

I used several generator expressions when implementing the Vector class in Example 10-16. Each of the methods __eq__, __hash__, __abs__, angle, angles, format, __add__, and __mul__ has a generator expression. In all those methods, a list comprehension would also work, at the cost of using more memory to store the intermediate list values.

In Example 14-9, we saw that a generator expression is a syntactic shortcut to create a generator without defining and calling a function. On the other hand, generator functions are much more flexible: you can code complex logic with multiple statements, and can even use them as coroutines (see Chapter 16).

For the simpler cases, a generator expression will do, and it’s easier to read at a glance, as the Vector example shows.

My rule of thumb in choosing the syntax to use is simple: if the generator expression spans more than a couple of lines, I prefer to code a generator function for the sake of readability. Also, because generator functions have a name, they can be reused. You can always name a generator expression and use it later by assigning it to a variable, of course, but that is stretching its intended usage as a one-off generator.

Syntax Tip

When a generator expression is passed as the single argument to a function or constructor, you don’t need to write a set of parentheses for the function call and another to enclose the generator expression. A single pair will do, like in the Vector call from the __mul__ method in Example 10-16, reproduced here. However, if there are more function arguments after the generator expression, you need to enclose it in parentheses to avoid a SyntaxError:

def __mul__(self, scalar): if isinstance(scalar, numbers.Real): return Vector(n * scalar for n in self) else: return NotImplemented

The Sentence examples we’ve seen exemplify the use of generators playing the role of classic iterators: retrieving items from a collection. But generators can also be used to produce values independent of a data source. The next section shows an example of that.

Another Example: Arithmetic Progression Generator

The classic Iterator pattern is all about traversal: navigating some data structure. But a standard interface based on a method to fetch the next item in a series is also useful when the items are produced on the fly, instead of retrieved from a collection. For example, the range built-in generates a bounded arithmetic progression (AP) of integers, and the itertools.count function generates a boundless AP.

We’ll cover itertools.count in the next section, but what if you need to generate a bounded AP of numbers of any type?

Example 14-10 shows a few console tests of an ArithmeticProgression class we will see in a moment. The signature of the constructor in Example 14-10 is ArithmeticProgression(begin, step[, end]). The range() function is similar to the ArithmeticProgression here, but its full signature is range(start, stop[, step]). I chose to implement a different signature because for an arithmetic progression the step is mandatory but end is optional. I also changed the argument names from start/stop to begin/end to make it very clear that I opted for a different signature. In each test in Example 14-10 I call list() on the result to inspect the generated values.

Example 14-10. Demonstration of an ArithmeticProgression class

>>> ap = ArithmeticProgression(0, 1, 3) >>> list(ap) [0, 1, 2] >>> ap = ArithmeticProgression(1, .5, 3) >>> list(ap) [1.0, 1.5, 2.0, 2.5] >>> ap = ArithmeticProgression(0, 1/3, 1) >>> list(ap) [0.0, 0.3333333333333333, 0.6666666666666666] >>> from fractions import Fraction >>> ap = ArithmeticProgression(0, Fraction(1, 3), 1) >>> list(ap) [Fraction(0, 1), Fraction(1, 3), Fraction(2, 3)] >>> from decimal import Decimal >>> ap = ArithmeticProgression(0, Decimal('.1'), .3) >>> list(ap) [Decimal('0.0'), Decimal('0.1'), Decimal('0.2')]

Note that type of the numbers in the resulting arithmetic progression follows the type of begin or step, according to the numeric coercion rules of Python arithmetic. In Example 14-10, you see lists of int, float, Fraction, and Decimal numbers.

Example 14-11 lists the implementation of the ArithmeticProgression class.

Example 14-11. The ArithmeticProgression class

class ArithmeticProgression: def __init__(self, begin, step, end=None): self.begin = begin self.step = step self.end = end # None -> "infinite" series def __iter__(self): result = type(self.begin + self.step)(self.begin) forever = self.end is None index = 0 while forever or result < self.end: yield result index += 1 result = self.begin + self.step * index

__init__ requires two arguments: begin and step. end is optional, if it’s None, the series will be unbounded.

This line produces a result value equal to self.begin, but coerced to the type of the subsequent additions.[112]

For readability, the forever flag will be True if the self.end attribute is None, resulting in an unbounded series.

This loop runs forever or until the result matches or exceeds self.end. When this loop exits, so does the function.

The current result is produced.

The next potential result is calculated. It may never be yielded, because the while loop may terminate.

In the last line of Example 14-11, instead of simply incrementing the result with self.step iteratively, I opted to use an index variable and calculate each result by adding self.begin to self.step multiplied by index to reduce the cumulative effect of errors when working with with floats.

The ArithmeticProgression class from Example 14-11 works as intended, and is a clear example of the use of a generator function to implement the __iter__ special method. However, if the whole point of a class is to build a generator by implementing __iter__, the class can be reduced to a generator function. A generator function is, after all, a generator factory.

Example 14-12 shows a generator function called aritprog_gen that does the same job as ArithmeticProgression but with less code. The tests in Example 14-10 all pass if you just call aritprog_gen instead of ArithmeticProgression.[113]

Example 14-12. The aritprog_gen generator function

def aritprog_gen(begin, step, end=None): result = type(begin + step)(begin) forever = end is None index = 0 while forever or result < end: yield result index += 1 result = begin + step * index

Example 14-12 is pretty cool, but always remember: there are plenty of ready-to-use generators in the standard library, and the next section will show an even cooler implementation using the itertools module.

Arithmetic Progression with itertools

The itertools module in Python 3.4 has 19 generator functions that can be combined in a variety of interesting ways.

For example, the itertools.count function returns a generator that produces numbers. Without arguments, it produces a series of integers starting with 0. But you can provide optional start and step values to achieve a result very similar to our aritprog_gen functions:

>>> import itertools >>> gen = itertools.count(1, .5) >>> next(gen) 1 >>> next(gen) 1.5 >>> next(gen) 2.0 >>> next(gen) 2.5

However, itertools.count never stops, so if you call list(count()), Python will try to build a list larger than available memory and your machine will be very grumpy long before the call fails.

On the other hand, there is the itertools.takewhile function: it produces a generator that consumes another generator and stops when a given predicate evaluates to False. So we can combine the two and write this:

>>> gen = itertools.takewhile(lambda n: n < 3, itertools.count(1, .5)) >>> list(gen) [1, 1.5, 2.0, 2.5]

Leveraging takewhile and count, Example 14-13 is sweet and short.

Example 14-13. aritprog_v3.py: this works like the previous aritprog_gen functions

import itertools def aritprog_gen(begin, step, end=None): first = type(begin + step)(begin) ap_gen = itertools.count(first, step) if end is not None: ap_gen = itertools.takewhile(lambda n: n < end, ap_gen) return ap_gen

Note that aritprog_gen is not a generator function in Example 14-13: it has no yield in its body. But it returns a generator, so it operates as a generator factory, just as a generator function does.

The point of Example 14-13 is: when implementing generators, know what is available in the standard library, otherwise there’s a good chance you’ll reinvent the wheel. That’s why the next section covers several ready-to-use generator functions.

Generator Functions in the Standard Library

The standard library provides many generators, from plain-text file objects providing line-by-line iteration, to the awesome os.walk function, which yields filenames while traversing a directory tree, making recursive filesystem searches as simple as a for loop.

The os.walk generator function is impressive, but in this section I want to focus on general-purpose functions that take arbitrary iterables as arguments and return generators that produce selected, computed, or rearranged items. In the following tables, I summarize two dozen of them, from the built-in, itertools, and functools modules. For convenience, I grouped them by high-level functionality, regardless of where they are defined.

Note

Perhaps you know all the functions mentioned in this section, but some of them are underused, so a quick overview may be good to recall what’s already available.

The first group are filtering generator functions: they yield a subset of items produced by the input iterable, without changing the items themselves. We used itertools.takewhile previously in this chapter, in Arithmetic Progression with itertools. Like takewhile, most functions listed in Table 14-1 take a predicate, which is a one-argument Boolean function that will be applied to each item in the input to determine whether the item is included in the output.

Table 14-1. Filtering generator functions

Module Function Description

itertools

compress(it, selector_it)

Consumes two iterables in parallel; yields items from it whenever the corresponding item in selector_it is truthy

itertools

dropwhile(predicate, it)

Consumes it skipping items while predicate computes truthy, then yields every remaining item (no further checks are made)

(built-in)

filter(predicate, it)

Applies predicate to each item of iterable, yielding the item if predicate(item) is truthy; if predicate is None, only truthy items are yielded

itertools

filterfalse(predicate, it)

Same as filter, with the predicate logic negated: yields items whenever predicate computes falsy

itertools

islice(it, stop) or islice(it, start, stop, step=1)

Yields items from a slice of it, similar to s[:stop] or s[start:stop:step] except it can be any iterable, and the operation is lazy

itertools

takewhile(predicate, it)

Yields items while predicate computes truthy, then stops and no further checks are made

The console listing in Example 14-14 shows the use of all functions in Table 14-1.

Example 14-14. Filtering generator functions examples

>>> def vowel(c): ... return c.lower() in 'aeiou' ... >>> list(filter(vowel, 'Aardvark')) ['A', 'a', 'a'] >>> import itertools >>> list(itertools.filterfalse(vowel, 'Aardvark')) ['r', 'd', 'v', 'r', 'k'] >>> list(itertools.dropwhile(vowel, 'Aardvark')) ['r', 'd', 'v', 'a', 'r', 'k'] >>> list(itertools.takewhile(vowel, 'Aardvark')) ['A', 'a'] >>> list(itertools.compress('Aardvark', (1,0,1,1,0,1))) ['A', 'r', 'd', 'a'] >>> list(itertools.islice('Aardvark', 4)) ['A', 'a', 'r', 'd'] >>> list(itertools.islice('Aardvark', 4, 7)) ['v', 'a', 'r'] >>> list(itertools.islice('Aardvark', 1, 7, 2)) ['a', 'd', 'a']

The next group are the mapping generators: they yield items computed from each individual item in the input iterable—or iterables, in the case of map and starmap.[114] The generators in Table 14-2 yield one result per item in the input iterables. If the input comes from more than one iterable, the output stops as soon as the first input iterable is exhausted.

Table 14-2. Mapping generator functions

Module Function Description

itertools

accumulate(it, [func])

Yields accumulated sums; if func is provided, yields the result of applying it to the first pair of items, then to the first result and next item, etc.

(built-in)

enumerate(iterable, start=0)

Yields 2-tuples of the form (index, item), where index is counted from start, and item is taken from the iterable

(built-in)

map(func, it1, [it2, …, itN])

Applies func to each item of it, yielding the result; if N iterables are given, func must take N arguments and the iterables will be consumed in parallel

itertools

starmap(func, it)

Applies func to each item of it, yielding the result; the input iterable should yield iterable items iit, and func is applied as func(*iit)

Example 14-15 demonstrates some uses of itertools.accumulate.

Example 14-15. itertools.accumulate generator function examples

>>> sample = [5, 4, 2, 8, 7, 6, 3, 0, 9, 1] >>> import itertools >>> list(itertools.accumulate(sample)) # [5, 9, 11, 19, 26, 32, 35, 35, 44, 45] >>> list(itertools.accumulate(sample, min)) # [5, 4, 2, 2, 2, 2, 2, 0, 0, 0] >>> list(itertools.accumulate(sample, max)) # [5, 5, 5, 8, 8, 8, 8, 8, 9, 9] >>> import operator >>> list(itertools.accumulate(sample, operator.mul)) # [5, 20, 40, 320, 2240, 13440, 40320, 0, 0, 0] >>> list(itertools.accumulate(range(1, 11), operator.mul)) [1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800] #

Running sum.

Running minimum.

Running maximum.

Running product.

Factorials from 1! to 10!.

The remaining functions of Table 14-2 are shown in Example 14-16.

Example 14-16. Mapping generator function examples

>>> list(enumerate('albatroz', 1)) # [(1, 'a'), (2, 'l'), (3, 'b'), (4, 'a'), (5, 't'), (6, 'r'), (7, 'o'), (8, 'z')] >>> import operator >>> list(map(operator.mul, range(11), range(11))) # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100] >>> list(map(operator.mul, range(11), [2, 4, 8])) # [0, 4, 16] >>> list(map(lambda a, b: (a, b), range(11), [2, 4, 8])) # [(0, 2), (1, 4), (2, 8)] >>> import itertools >>> list(itertools.starmap(operator.mul, enumerate('albatroz', 1))) # ['a', 'll', 'bbb', 'aaaa', 'ttttt', 'rrrrrr', 'ooooooo', 'zzzzzzzz'] >>> sample = [5, 4, 2, 8, 7, 6, 3, 0, 9, 1] >>> list(itertools.starmap(lambda a, b: b/a, ... enumerate(itertools.accumulate(sample), 1))) # [5.0, 4.5, 3.6666666666666665, 4.75, 5.2, 5.333333333333333, 5.0, 4.375, 4.888888888888889, 4.5]

Number the letters in the word, starting from 1.

Squares of integers from 0 to 10.

Multiplying numbers from two iterables in parallel: results stop when the shortest iterable ends.

This is what the zip built-in function does.

Repeat each letter in the word according to its place in it, starting from 1.

Running average.

Next, we have the group of merging generators—all of these yield items from multiple input iterables. chain and chain.from_iterable consume the input iterables sequentially (one after the other), while product, zip, and zip_longest consume the input iterables in parallel. See Table 14-3.

Table 14-3. Generator functions that merge multiple input iterables

Module Function Description

itertools

chain(it1, …, itN)

Yield all items from it1, then from it2 etc., seamlessly

itertools

chain.from_iterable(it)

Yield all items from each iterable produced by it, one after the other, seamlessly; it should yield iterable items, for example, a list of iterables

itertools

product(it1, …, itN, repeat=1)

Cartesian product: yields N-tuples made by combining items from each input iterable like nested for loops could produce; repeat allows the input iterables to be consumed more than once

(built-in)

zip(it1, …, itN)

Yields N-tuples built from items taken from the iterables in parallel, silently stopping when the first iterable is exhausted

itertools

zip_longest(it1, …, itN, fillvalue=None)

Yields N-tuples built from items taken from the iterables in parallel, stopping only when the last iterable is exhausted, filling the blanks with the fillvalue

Example 14-17 shows the use of the itertools.chain and zip generator functions and their siblings. Recall that the zip function is named after the zip fastener or zipper (no relation with compression). Both zip and itertools.zip_longest were introduced in The Awesome zip.

Example 14-17. Merging generator function examples

>>> list(itertools.chain('ABC', range(2))) # ['A', 'B', 'C', 0, 1] >>> list(itertools.chain(enumerate('ABC'))) # [(0, 'A'), (1, 'B'), (2, 'C')] >>> list(itertools.chain.from_iterable(enumerate('ABC'))) # [0, 'A', 1, 'B', 2, 'C'] >>> list(zip('ABC', range(5))) # [('A', 0), ('B', 1), ('C', 2)] >>> list(zip('ABC', range(5), [10, 20, 30, 40])) # [('A', 0, 10), ('B', 1, 20), ('C', 2, 30)] >>> list(itertools.zip_longest('ABC', range(5))) # [('A', 0), ('B', 1), ('C', 2), (None, 3), (None, 4)] >>> list(itertools.zip_longest('ABC', range(5), fillvalue='?')) # [('A', 0), ('B', 1), ('C', 2), ('?', 3), ('?', 4)]

chain is usually called with two or more iterables.

chain does nothing useful when called with a single iterable.

But chain.from_iterable takes each item from the iterable, and chains them in sequence, as long as each item is itself iterable.

zip is commonly used to merge two iterables into a series of two-tuples.

Any number of iterables can be consumed by zip in parallel, but the generator stops as soon as the first iterable ends.

itertools.zip_longest works like zip, except it consumes all input iterables to the end, padding output tuples with None as needed.

The fillvalue keyword argument specifies a custom padding value.

The itertools.product generator is a lazy way of computing Cartesian products, which we built using list comprehensions with more than one for clause in Cartesian Products. Generator expressions with multiple for clauses can also be used to produce Cartesian products lazily. Example 14-18 demonstrates itertools.product.

Example 14-18. itertools.product generator function examples

>>> list(itertools.product('ABC', range(2))) # [('A', 0), ('A', 1), ('B', 0), ('B', 1), ('C', 0), ('C', 1)] >>> suits = 'spades hearts diamonds clubs'.split() >>> list(itertools.product('AK', suits)) # [('A', 'spades'), ('A', 'hearts'), ('A', 'diamonds'), ('A', 'clubs'), ('K', 'spades'), ('K', 'hearts'), ('K', 'diamonds'), ('K', 'clubs')] >>> list(itertools.product('ABC')) # [('A',), ('B',), ('C',)] >>> list(itertools.product('ABC', repeat=2)) # [('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'B'), ('B', 'C'), ('C', 'A'), ('C', 'B'), ('C', 'C')] >>> list(itertools.product(range(2), repeat=3)) [(0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1)] >>> rows = itertools.product('AB', range(2), repeat=2) >>> for row in rows: print(row) ... ('A', 0, 'A', 0) ('A', 0, 'A', 1) ('A', 0, 'B', 0) ('A', 0, 'B', 1) ('A', 1, 'A', 0) ('A', 1, 'A', 1) ('A', 1, 'B', 0) ('A', 1, 'B', 1) ('B', 0, 'A', 0) ('B', 0, 'A', 1) ('B', 0, 'B', 0) ('B', 0, 'B', 1) ('B', 1, 'A', 0) ('B', 1, 'A', 1) ('B', 1, 'B', 0) ('B', 1, 'B', 1)

