__matmul__, Overloading * for Scalar Multiplication

__missing__, The __missing__ Method

__mro__, A Virtual Subclass of Tombola

__mul__, Overloading * for Scalar Multiplication

__neg__, Unary Operators

__new__, Flexible Object Creation with __new__, Further Reading

__next__, Iterables Versus Iterators, Making Sentence an Iterator: Bad Idea

__ne__, Rich Comparison Operators

__pos__, Unary Operators

__prepare__, The Metaclass __prepare__ Special Method

__radd__, Overloading + for Vector Addition

__repr__, String Representation

__rmatmul__, Overloading * for Scalar Multiplication

__rmul__, Overloading * for Scalar Multiplication

__ruml__, Arithmetic Operators

__self__, Special Methods for Attribute Handling

__setattr__, Special Methods for Attribute Handling

__setitem__, Monkey-Patching to Implement a Protocol at Runtime

__set__, Attribute Descriptors, LineItem Take #3: A Simple Descriptor

__slots__, Saving Space with the __slots__ Class Attribute, Special Attributes that Affect Attribute Handling, Chapter 9: RAM Usage With and Without __slots__

__str__, String Representation

__subclasshook__, Geese Can Behave as Ducks

{} (curly brackets), List Comprehensions and Readability

~ operator, Unary Operators

– operator, Unary Operators

… (ellipsis), Multidimensional Slicing and Ellipsis, Vector Take #1: Vector2d Compatible

A

ABC (Abstract Base Class)

advantages of, Alex Martelli’s Waterfowl

appropriate use of, Interfaces: From Protocols to ABCs, Alex Martelli’s Waterfowl, Chapter Summary

as mixins, 5. An ABC May Also Be a Mixin; The Reverse Is Not True

declaring, ABC Syntax Details

defining and using, Defining and Using an ABC–A Virtual Subclass of Tombola

definition of term, Python Jargon

explicit interfaces using, 2. Make Interfaces Explicit with ABCs

goose typing and, Chapter Summary

in standard library, ABCs in the Standard Library

numbers package, The Numbers Tower of ABCs

subclass creation, Subclassing the Tombola ABC

subclass testing, How the Tombola Subclasses Were Tested

subclassing process, Subclassing an ABC

syntax details, ABC Syntax Details

virtual subclass creation, A Virtual Subclass of Tombola

ABC language, An Array of Sequences, Further Reading, Python Jargon

abs function, Emulating Numeric Types

absolute values, Emulating Numeric Types

accessor methods, Dynamic Attributes and Properties, Further Reading, Python Jargon

accumulating functions, Iterable Reducing Functions

Adapter pattern, Multiple Inheritance in the Real World

addition

2D vector, Emulating Numeric Types

vector, Overloading + for Vector Addition–Overloading + for Vector Addition

aggregate classes, 7. Provide Aggregate Classes to Users

aiohttp package, Downloading with asyncio and aiohttp, An aiohttp Web Server

algorithms

binary search, Managing Ordered Sequences with bisect

C3 algorithm, Multiple Inheritance and Method Resolution Order

cryptographic, Launching Processes with concurrent.futures, Chapter 17: Cryptographic Examples

for hash tables, The hash table algorithm

RC4, Chapter 17: Cryptographic Examples

Timsort sorting algorithm, Further Reading

Unicode Collation Algorithm (UCA), Sorting with the Unicode Collation Algorithm

aliasing, Identity, Equality, and Aliases, Python Jargon

and operator, Operator Overloading 101

anonymous functions, Anonymous Functions, Further Reading, Closures

arcfour.py module, Chapter 17: Cryptographic Examples

argument lists, Anonymous Functions

arguments

definition of term, Python Jargon

explicit self, LineItem Take #3: A Simple Descriptor, Further Reading

freezing with functools.parital, Freezing Arguments with functools.partial

grabbing arbitrary excess, Using * to grab excess items

instance, LineItem Take #3: A Simple Descriptor

keyword-only, From Positional to Keyword-Only Parameters

arithmetic operators, Arithmetic Operators, Overview of Special Methods, The operator Module, Operator Overloading 101

arithmetic progression generator, Another Example: Arithmetic Progression Generator

array.array library, An Alternative Constructor

arrays

benefits of, Arrays

building with generator expressions, Generator Expressions

creating, saving and loading, Arrays

handling with memory views, Memory Views

handling with NumPy, NumPy and SciPy

vs. lists, Arrays

asciize function, Extreme「Normalization」: Taking Out Diacritics

assignment

augmented, Overview of Special Methods, Augmented Assignment with Sequences–A += Assignment Puzzler, Augmented Assignment Operators–Augmented Assignment Operators

destructuring, Python Jargon

of variables, Variables Are Not Boxes

overwriting descriptors with, Overwriting a Descriptor in the Class

parallel, Tuple Unpacking, Python Jargon

to slices, Assigning to Slices

asynchronous operations, Running Circling Around Blocking Calls, Further Reading

asyncio package, Concurrency with asyncio–Smarter Clients for Better Concurrency

APIs provided by, Deques and Other Queues

asynchronous operations, Running Circling Around Blocking Calls

asyncio.as_completed, Using asyncio.as_completed

asyncio.Future class, asyncio.Future: Nonblocking by Design

asyncio.Task objects, Yielding from Futures, Tasks, and Coroutines

asyncio.wait(…), Downloading with asyncio and aiohttp

avoiding event loop blocking, Using an Executor to Avoid Blocking the Event Loop

benefits of, Further Reading

coroutines in, Thread Versus Coroutine: A Comparison

coroutines vs. futures, Yielding from Futures, Tasks, and Coroutines

development of, Concurrency with asyncio

downloader script enhancement, Enhancing the asyncio downloader Script

downloading with aiohttp package, Downloading with asyncio and aiohttp

TCP server, An asyncio TCP Server

time.sleep(…), Thread Versus Coroutine: A Comparison

vs. Threading module, Thread Versus Coroutine: A Comparison

writing asyncio servers, Writing asyncio Servers–Smarter Clients for Better Concurrency

yield from construct and, asyncio.Future: Nonblocking by Design, Downloading with asyncio and aiohttp

attribute access (.), Operator Overloading: Doing It Right

attribute descriptors, Attribute Descriptors–Chapter Summary

attribute validation, Descriptor Example: Attribute Validation–LineItem Take #5: A New Descriptor Type

docstrings, Descriptor docstring and Overriding Deletion

methods as, Methods Are Descriptors

overriding deletion, Descriptor docstring and Overriding Deletion

overriding vs. nonoverriding, Overriding Versus Nonoverriding Descriptors–Overwriting a Descriptor in the Class

overview of, Attribute Descriptors

overwriting, Overwriting a Descriptor in the Class

usage tips, Descriptor Usage Tips

using, LineItem Take #3: A Simple Descriptor

vs. property factories, LineItem Take #4: Automatic Storage Attribute Names

attribute validation

automatic storage attribute names, LineItem Take #4: Automatic Storage Attribute Names

new descriptor types, LineItem Take #5: A New Descriptor Type

simple descriptor class, LineItem Take #3: A Simple Descriptor

attributes

assigning arbitrary, Function Introspection

definition of term, Python Jargon

deleting, Handling Attribute Deletion

dynamic, Dynamic Attributes and Properties–Linked Record Retrieval with Properties

dynamic access, Vector Take #3: Dynamic Attribute Access

handling of, Essential Attributes and Functions for Attribute Handling

instance, Descriptor Usage Tips

listing, Function Introspection

managed, LineItem Take #3: A Simple Descriptor, Python Jargon

names, The Invalid Attribute Name Problem

of user-defined functions, Function Introspection

overriding, Overriding Class Attributes

private and protected, Private and「Protected」Attributes in Python, Further Reading, Interfaces and Protocols in Python Culture

public, Further Reading, Interfaces and Protocols in Python Culture

special, Special Attributes that Affect Attribute Handling

storage, LineItem Take #3: A Simple Descriptor, LineItem Take #4: Automatic Storage Attribute Names, Python Jargon

validating with descriptors, Descriptor Example: Attribute Validation–LineItem Take #5: A New Descriptor Type

validating with properties, Using a Property for Attribute Validation

augmented assignment, Overview of Special Methods, Augmented Assignment with Sequences–A += Assignment Puzzler, Augmented Assignment Operators–Augmented Assignment Operators

B

backslash (\), List Comprehensions and Readability

BDFL (Benevolent Dictator For Life), Python Jargon

BIF (see built-in functions)

big-endian byte ordering, BOM: A Useful Gremlin

binary search algorithm, Managing Ordered Sequences with bisect

binary sequences

building, Byte Essentials

built-in types for, Byte Essentials

definition of term, Python Jargon

displays used, Byte Essentials

fromhex class method, Byte Essentials

sharing memory, Byte Essentials

str method support, Byte Essentials

bisect module

inserting with bisect.insort, Inserting with bisect.insort

main functions, Managing Ordered Sequences with bisect

searching with bisect function, Searching with bisect

bitwise operators, Overview of Special Methods, Operator Overloading 101

blocking I/O functions, Blocking I/O and the GIL, Running Circling Around Blocking Calls

Bobo HTTP micro-framework, Retrieving Information About Parameters, Further Reading

BOM (Byte Order Mark), BOM: A Useful Gremlin, Python Jargon

bool (x), Boolean Value of a Custom Type

boolean values, custom types and, Boolean Value of a Custom Type

bound methods, Python Jargon

built-in functions, list.sort and the sorted Built-In Function, Dictionaries and Sets, The Seven Flavors of Callable Objects, Built-In Functions for Attribute Handling, Python Jargon

built-in methods, The Seven Flavors of Callable Objects

byte strings, Python Jargon

bytearray type, Byte Essentials

bytes (see encoding/decoding)

bytes argument, str Versus bytes in Regular Expressions

bytes type, Byte Essentials

bytes-like objects, Python Jargon

C

C3 algorithm, Multiple Inheritance and Method Resolution Order

caches

attribute descriptors and, Descriptor Usage Tips

using WeakValueDictionary class, The WeakValueDictionary Skit

weak references and, Weak References

call by reference, Further Reading

call by sharing, Function Parameters as References, Further Reading

Callable ABC, ABCs in collections.abc

callable objects, The Seven Flavors of Callable Objects, Python Jargon

callable() function, The Seven Flavors of Callable Objects

callbacks

callback hell, From Callbacks to Futures and Coroutines

vs. coroutines, Using an Executor to Avoid Blocking the Event Loop

vs. futures, From Callbacks to Futures and Coroutines

CamelCase, Further Reading, Afterword, Python Jargon

canonical equivalents, Normalizing Unicode for Saner Comparisons

card deck example, A Pythonic Card Deck–A Pythonic Card Deck

cartesian products, generating lists from, Cartesian Products

case folding, Case Folding

ChainMap, Variations of dict

characters

code point identification, Character Issues

compatibility, Normalizing Unicode for Saner Comparisons

definition of term, Character Issues

encoding/decoding of, Character Issues

Unicode standard for, Character Issues

Chardet Universal Character Encoding Detector, How to Discover the Encoding of a Byte Sequence

charfinder.py module, An asyncio TCP Server

Cheese Shop, Python Jargon

class decorators

drawbacks of, A Class Decorator for Customizing Descriptors

for customizing descriptors, A Class Decorator for Customizing Descriptors

vs. function decorators, A Class Decorator for Customizing Descriptors

vs. metaclasses, Class Metaprogramming

class metaprogramming, Class Metaprogramming–Chapter Summary

class factory, A Class Factory

classes as objects, Classes as Objects

descriptor customization, A Class Decorator for Customizing Descriptors

exec/eval functions and, A Class Factory

import time vs. runtime, What Happens When: Import Time Versus Runtime–Solution for scenario #2

metaclass basics, Metaclasses 101–Solution for scenario #4

metaclass for customizing descriptors, A Metaclass for Customizing Descriptors

metaclasses vs. class decorators, Class Metaprogramming

__prepare__, The Metaclass __prepare__ Special Method

classes

aggregate, 7. Provide Aggregate Classes to Users

as callable objects, The Seven Flavors of Callable Objects

as objects, Classes as Objects, Further Reading

customizing at runtime (see class metaprogramming)

definition of term, Python Jargon

descriptor, Attribute Descriptors, LineItem Take #4: Automatic Storage Attribute Names, Python Jargon

managed, LineItem Take #3: A Simple Descriptor, Python Jargon

metaclasses, Metaclasses 101–Solution for scenario #4, Python Jargon

MGN notation for, LineItem Take #3: A Simple Descriptor

mixin, 3. Use Mixins for Code Reuse, A Modern Example: Mixins in Django Generic Views–A Modern Example: Mixins in Django Generic Views, Python Jargon

multilevel hierarchies, Further Reading

classmethod decorator, classmethod Versus staticmethod

closures (see decorators and closures)

code point, Character Issues, Python Jargon

code smell, Alex Martelli’s Waterfowl, Python Jargon

code, top-level, What Happens When: Import Time Versus Runtime

codec module, Basic Encoders/Decoders, Python Jargon

coding idioms, Further Reading

collections

definition of term, Python Jargon

iterability of, Iterables, Iterators, and Generators

collections.abc module

ABCs in, ABCs in collections.abc

collections.ChainMap, Variations of dict

collections.Counter, Variations of dict

collections.defaultdict, Overview of Common Mapping Methods, defaultdict: Another Take on Missing Keys

collections.deque class, Deques and Other Queues

collections.MutableSequence, Subclassing an ABC

collections.MutableSet, Set Operations

collections.namedtuple function, Named Tuples

collections.OrderedDict, Overview of Common Mapping Methods, Variations of dict

collections.UserDict, Subclassing UserDict

Mapping/MutableMapping ABCs, Generic Mapping Types, ABCs in collections.abc

multiple inheritance in, Multiple Inheritance in the Real World

Command design pattern, Command

comparison operators, Overview of Special Methods, Operator Overloading 101, Rich Comparison Operators–Rich Comparison Operators

compatibility characters, Normalizing Unicode for Saner Comparisons

composition, 8.「Favor Object Composition Over Class Inheritance.」

compounds, Further Reading

concrete subclasses, Subclassing an ABC, Subclassing the Tombola ABC, 6. Don’t Subclass from More Than One Concrete Class

concurrency

asynchronous operations, Running Circling Around Blocking Calls, Further Reading

better approach to, Further Reading

concurrent vs. sequential scripts, Example: Web Downloads in Three Styles

concurrent.futures download, Downloading with concurrent.futures

concurrent.futures task launching, Launching Processes with concurrent.futures

error handling and, Downloads with Progress Display and Error Handling, Error Handling in the flags2 Examples

examples of, Example: Web Downloads in Three Styles

GIL (Global Interpreter Lock) and, Blocking I/O and the GIL

importance of, Example: Web Downloads in Three Styles

importance of futures in, Where Are the Futures?

in other languages, Further Reading

multiple download requests, Doing Multiple Requests for Each Download

nonblocking design and, asyncio.Future: Nonblocking by Design

progress displays, Downloads with Progress Display and Error Handling

smarter clients for, Smarter Clients for Better Concurrency

testing concurrent clients, Downloads with Progress Display and Error Handling

threading vs. coroutines, Thread Versus Coroutine: A Comparison

threading/multiprocessing alternatives, Threading and Multiprocessing Alternatives

using futures.as_completed, Using futures.as_completed

vs. parallelism, Concurrency with asyncio

with asyncio package, Thread Versus Coroutine: A Comparison–Smarter Clients for Better Concurrency

with Executor.map function, Experimenting with Executor.map

concurrent.futures library, Concurrency with Futures–Chapter Summary

behind the scenes operation of, Where Are the Futures?

benefits of, Further Reading

downloading, Downloading with concurrent.futures

futures.as_completed, Downloads with Progress Display and Error Handling, Using futures.as_completed

futures.ProcessPoolExecutor, Threading and Multiprocessing Alternatives

introduction of, Concurrency with Futures

launching processes with, Launching Processes with concurrent.futures

「Considered Harmful」article, Python Jargon

constructors, definition of term, Python Jargon

Container ABC, ABCs in collections.abc

container sequences, Overview of Built-In Sequences, Further Reading

containers, definition of term, Python Jargon

context managers

contextlib utilities, The contextlib Utilities

definition of term, Python Jargon

temporary contexts via with statements, Context Managers and else Blocks

uses for, Context Managers and with Blocks

with statement and, Context Managers and with Blocks

continuous simulation, About Discrete Event Simulations

copy function, Deep and Shallow Copies of Arbitrary Objects

coroutines

benefits of, From Callbacks to Futures and Coroutines

computing running averages, Example: Coroutine to Compute a Running Average

decorators for priming, Decorators for Coroutine Priming

definition of term, Python Jargon

delaying, Thread Versus Coroutine: A Comparison

evolution of, How Coroutines Evolved from Generators

exception handling, Coroutine Termination and Exception Handling

for discrete event simulation, Use Case: Coroutines for Discrete Event Simulation–The Taxi Fleet Simulation, Chapter 16: Taxi Fleet Discrete Event Simulation

generators as, Generators as Coroutines, Basic Behavior of a Generator Used as a Coroutine

in asyncio, Thread Versus Coroutine: A Comparison

obtaining Tasks, Yielding from Futures, Tasks, and Coroutines

possible states of, Basic Behavior of a Generator Used as a Coroutine

returning values from, Returning a Value from a Coroutine

termination of, Coroutine Termination and Exception Handling

vs. callbacks, Using an Executor to Avoid Blocking the Event Loop

vs. futures, Yielding from Futures, Tasks, and Coroutines

vs. generators, Coroutines

vs. threading, Thread Versus Coroutine: A Comparison

yield from meaning, The Meaning of yield from–The Meaning of yield from

yield from use, Using yield from–Using yield from

yield keyword and, Basic Behavior of a Generator Used as a Coroutine

cosine similarity, Sequence Hacking, Hashing, and Slicing

Counter, Variations of dict

cp1252 encoding, Basic Encoders/Decoders

cp437 encoding, Basic Encoders/Decoders

CPython, del and Garbage Collection, Blocking I/O and the GIL, Python Jargon

CRUD (Create, Read, Update, and Delete), Python Jargon

cryptographic algorithms, Launching Processes with concurrent.futures, Chapter 17: Cryptographic Examples

curly brackets ({}), List Comprehensions and Readability

D

data attributes (see attributes)

data descriptors (see overriding descriptors)

data model, The Python Data Model–Further Reading

behavior of __len__, Why len Is Not a Method

boolean value of custom types, Boolean Value of a Custom Type

emulating numeric types, Emulating Numeric Types

example of, A Pythonic Card Deck

metaobject protocol, Further Reading

overview of, The Python Data Model

protocols and sequences, Python Digs Sequences

special (magic) methods, The Python Data Model, Further Reading

special methods, overview of, Overview of Special Methods

special methods, using, How Special Methods Are Used

string representation, String Representation

vs. object model, Further Reading

data structures

dictionaries and sets, Dictionaries and Sets–Further Reading

sequences, An Array of Sequences–Further Reading

text vs. bytes, Text versus Bytes–Further Reading

database conversion utility, Case Study: Generators in a Database Conversion Utility, Chapter 14: isis2json.py Database Conversion Script

dbm module, Restructuring the OSCON Feed with shelve

decimal.Decimal class, Unary Operators

Decorator pattern, How It Works, Further Reading

decorators and closures, Function Decorators and Closures–Further Reading

classmethod vs. staticmethod, classmethod Versus staticmethod

closure example, Closures

closure overview, Closures

closures vs. anonymous functions, Closures

decorator behavior, How It Works

decorator implementation, Implementing a Simple Decorator

definition of closures, Closures

definition of decorators, Decorators 101, Python Jargon

dynamic scope, Further Reading

in Python standard library, Decorators in the Standard Library–Generic Functions with Single Dispatch

key function of decorators, When Python Executes Decorators

nonlocal declaration, The nonlocal Declaration

parameterized decorators, Parameterized Decorators–The Parameterized Clock Decorator

priming decorators, Thread Versus Coroutine: A Comparison

purpose of decorators, Function Decorators and Closures

registration decorators, Decorator-Enhanced Strategy Pattern, A Parameterized Registration Decorator

stacked decorators, Stacked Decorators

stacked function decorators, ABC Syntax Details

variable scope rules, Variable Scope Rules

deep copies, Deep and Shallow Copies of Arbitrary Objects, Python Jargon

deepcopy function, Deep and Shallow Copies of Arbitrary Objects

defaultdict, Overview of Common Mapping Methods, defaultdict: Another Take on Missing Keys

default_factory, defaultdict: Another Take on Missing Keys

del statement

behavior of, del and Garbage Collection

in-place modifications with, Assigning to Slices

object attribute deletion with, Handling Attribute Deletion

delegating generators, Using yield from

deques package, Deques and Other Queues

descriptor classes, Attribute Descriptors, LineItem Take #4: Automatic Storage Attribute Names

descriptor instances, LineItem Take #3: A Simple Descriptor

descriptors

customizing, A Class Decorator for Customizing Descriptors, A Metaclass for Customizing Descriptors

definition of term, Python Jargon

nonoverriding, Overriding Versus Nonoverriding Descriptors, Python Jargon

overriding, Overriding Versus Nonoverriding Descriptors, Python Jargon

(see also attribute descriptors)

validation, Descriptor Usage Tips

design patterns, Design Patterns with First-Class Functions–Further Reading

Adapter, Multiple Inheritance in the Real World

choosing the best Strategy, Choosing the Best Strategy: Simple Approach

classic Strategy, Case Study: Refactoring Strategy

Command, Command

Decorator, How It Works

finding strategies in modules, Finding Strategies in a Module

function-oriented Strategy, Function-Oriented Strategy

language-dependent relevancy of, Design Patterns with First-Class Functions, Further Reading

destructuring assignment, Python Jargon

diacritics, Extreme「Normalization」: Taking Out Diacritics

diamond problem, Multiple Inheritance and Method Resolution Order–Multiple Inheritance and Method Resolution Order

dict, Hash Tables in Dictionaries

dict comprehensions (dictcomp), dict Comprehensions

dict.get, Handling Missing Keys with setdefault

dict.setdefault, Handling Missing Keys with setdefault

dictionaries and sets, Dictionaries and Sets–Further Reading

building dictionaries, Generic Mapping Types

creating new mapping types, Subclassing UserDict

dictcomp (dict comprehensions), dict Comprehensions

immutable mappings, Immutable Mappings

implementation with hash tables, dict and set Under the Hood–How Sets Work—Practical Consequences

mapping methods overview, Overview of Common Mapping Methods

mapping types, Generic Mapping Types

mappings with flexible key lookup, Mappings with Flexible Key Lookup

