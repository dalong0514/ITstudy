The Cartesian product of a str with three characters and a range with two integers yields six tuples (because 3 * 2 is 6).

The product of two card ranks ('AK'), and four suits is a series of eight tuples.

Given a single iterable, product yields a series of one-tuples, not very useful.

The repeat=N keyword argument tells product to consume each input iterable N times.

Some generator functions expand the input by yielding more than one value per input item. They are listed in Table 14-4.

Table 14-4. Generator functions that expand each input item into multiple output items

Module Function Description

itertools

combinations(it, out_len)

Yield combinations of out_len items from the items yielded by it

itertools

combinations_with_replacement(it, out_len)

Yield combinations of out_len items from the items yielded by it, including combinations with repeated items

itertools

count(start=0, step=1)

Yields numbers starting at start, incremented by step, indefinitely

itertools

cycle(it)

Yields items from it storing a copy of each, then yields the entire sequence repeatedly, indefinitely

itertools

permutations(it, out_len=None)

Yield permutations of out_len items from the items yielded by it; by default, out_len is len(list(it))

itertools

repeat(item, [times])

Yield the given item repeadedly, indefinetly unless a number of times is given

The count and repeat functions from itertools return generators that conjure items out of nothing: neither of them takes an iterable as input. We saw itertools.count in Arithmetic Progression with itertools. The cycle generator makes a backup of the input iterable and yields its items repeatedly. Example 14-19 illustrates the use of count, repeat, and cycle.

Example 14-19. count, cycle, and repeat

>>> ct = itertools.count() # >>> next(ct) # 0 >>> next(ct), next(ct), next(ct) # (1, 2, 3) >>> list(itertools.islice(itertools.count(1, .3), 3)) # [1, 1.3, 1.6] >>> cy = itertools.cycle('ABC') # >>> next(cy) 'A' >>> list(itertools.islice(cy, 7)) # ['B', 'C', 'A', 'B', 'C', 'A', 'B'] >>> rp = itertools.repeat(7) # >>> next(rp), next(rp) (7, 7) >>> list(itertools.repeat(8, 4)) # [8, 8, 8, 8] >>> list(map(operator.mul, range(11), itertools.repeat(5))) # [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]

Build a count generator ct.

Retrieve the first item from ct.

I can’t build a list from ct, because ct never stops, so I fetch the next three items.

I can build a list from a count generator if it is limited by islice or takewhile.

Build a cycle generator from 'ABC' and fetch its first item, 'A'.

A list can only be built if limited by islice; the next seven items are retrieved here.

Build a repeat generator that will yield the number 7 forever.

A repeat generator can be limited by passing the times argument: here the number 8 will be produced 4 times.

A common use of repeat: providing a fixed argument in map; here it provides the 5 multiplier.

The combinations, combinations_with_replacement, and permutations generator functions—together with product—are called the combinatoric generators in the itertools documentation page. There is a close relationship between itertools.product and the remaining combinatoric functions as well, as Example 14-20 shows.

Example 14-20. Combinatoric generator functions yield multiple values per input item

>>> list(itertools.combinations('ABC', 2)) # [('A', 'B'), ('A', 'C'), ('B', 'C')] >>> list(itertools.combinations_with_replacement('ABC', 2)) # [('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'B'), ('B', 'C'), ('C', 'C')] >>> list(itertools.permutations('ABC', 2)) # [('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'C'), ('C', 'A'), ('C', 'B')] >>> list(itertools.product('ABC', repeat=2)) # [('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'B'), ('B', 'C'), ('C', 'A'), ('C', 'B'), ('C', 'C')]

All combinations of len()==2 from the items in 'ABC'; item ordering in the generated tuples is irrelevant (they could be sets).

All combinations of len()==2 from the items in 'ABC', including combinations with repeated items.

All permutations of len()==2 from the items in 'ABC'; item ordering in the generated tuples is relevant.

Cartesian product from 'ABC' and 'ABC' (that’s the effect of repeat=2).

The last group of generator functions we’ll cover in this section are designed to yield all items in the input iterables, but rearranged in some way. Here are two functions that return multiple generators: itertools.groupby and itertools.tee. The other generator function in this group, the reversed built-in, is the only one covered in this section that does not accept any iterable as input, but only sequences. This makes sense: because reversed will yield the items from last to first, it only works with a sequence with a known length. But it avoids the cost of making a reversed copy of the sequence by yielding each item as needed. I put the itertools.product function together with the merging generators in Table 14-3 because they all consume more than one iterable, while the generators in Table 14-5 all accept at most one input iterable.

Table 14-5. Rearranging generator functions

Module Function Description

itertools

groupby(it, key=None)

Yields 2-tuples of the form (key, group), where key is the grouping criterion and group is a generator yielding the items in the group

(built-in)

reversed(seq)

Yields items from seq in reverse order, from last to first; seq must be a sequence or implement the __reversed__ special method

itertools

tee(it, n=2)

Yields a tuple of n generators, each yielding the items of the input iterable independently

Example 14-21 demonstrates the use of itertools.groupby and the reversed built-in. Note that itertools.groupby assumes that the input iterable is sorted by the grouping criterion, or at least that the items are clustered by that criterion—even if not sorted.

Example 14-21. itertools.groupby

>>> list(itertools.groupby('LLLLAAGGG')) # [('L', <itertools._grouper object at 0x102227cc0>), ('A', <itertools._grouper object at 0x102227b38>), ('G', <itertools._grouper object at 0x102227b70>)] >>> for char, group in itertools.groupby('LLLLAAAGG'): # ... print(char, '->', list(group)) ... L -> ['L', 'L', 'L', 'L'] A -> ['A', 'A',] G -> ['G', 'G', 'G'] >>> animals = ['duck', 'eagle', 'rat', 'giraffe', 'bear', ... 'bat', 'dolphin', 'shark', 'lion'] >>> animals.sort(key=len) # >>> animals ['rat', 'bat', 'duck', 'bear', 'lion', 'eagle', 'shark', 'giraffe', 'dolphin'] >>> for length, group in itertools.groupby(animals, len): # ... print(length, '->', list(group)) ... 3 -> ['rat', 'bat'] 4 -> ['duck', 'bear', 'lion'] 5 -> ['eagle', 'shark'] 7 -> ['giraffe', 'dolphin'] >>> for length, group in itertools.groupby(reversed(animals), len): # ... print(length, '->', list(group)) ... 7 -> ['dolphin', 'giraffe'] 5 -> ['shark', 'eagle'] 4 -> ['lion', 'bear', 'duck'] 3 -> ['bat', 'rat'] >>>

groupby yields tuples of (key, group_generator).

Handling groupby generators involves nested iteration: in this case, the outer for loop and the inner list constructor.

To use groupby, the input should be sorted; here the words are sorted by length.

Again, loop over the key and group pair, to display the key and expand the group into a list.

Here the reverse generator is used to iterate over animals from right to left.

The last of the generator functions in this group is iterator.tee, which has a unique behavior: it yields multiple generators from a single input iterable, each yielding every item from the input. Those generators can be consumed independently, as shown in Example 14-22.

Example 14-22. itertools.tee yields multiple generators, each yielding every item of the input generator

>>> list(itertools.tee('ABC')) [<itertools._tee object at 0x10222abc8>, <itertools._tee object at 0x10222ac08>] >>> g1, g2 = itertools.tee('ABC') >>> next(g1) 'A' >>> next(g2) 'A' >>> next(g2) 'B' >>> list(g1) ['B', 'C'] >>> list(g2) ['C'] >>> list(zip(*itertools.tee('ABC'))) [('A', 'A'), ('B', 'B'), ('C', 'C')]

Note that several examples in this section used combinations of generator functions. This is a great feature of these functions: because they all take generators as arguments and return generators, they can be combined in many different ways.

While on the subject of combining generators, the yield from statement, new in Python 3.3, is a tool for doing just that.

New Syntax in Python 3.3: yield from

Nested for loops are the traditional solution when a generator function needs to yield values produced from another generator.

For example, here is a homemade implementation of a chaining generator:[115]

>>> def chain(*iterables): ... for it in iterables: ... for i in it: ... yield i ... >>> s = 'ABC' >>> t = tuple(range(3)) >>> list(chain(s, t)) ['A', 'B', 'C', 0, 1, 2]

The chain generator function is delegating to each received iterable in turn. PEP 380 — Syntax for Delegating to a Subgenerator introduced new syntax for doing that, shown in the next console listing:

>>> def chain(*iterables): ... for i in iterables: ... yield from i ... >>> list(chain(s, t)) ['A', 'B', 'C', 0, 1, 2]

As you can see, yield from i replaces the inner for loop completely. The use of yield from in this example is correct, and the code reads better, but it seems like mere syntactic sugar. Besides replacing a loop, yield from creates a channel connecting the inner generator directly to the client of the outer generator. This channel becomes really important when generators are used as coroutines and not only produce but also consume values from the client code. Chapter 16 dives into coroutines, and has several pages explaining why yield from is much more than syntactic sugar.

After this first encounter with yield from, we’ll go back to our review of iterable-savvy functions in the standard library.

Iterable Reducing Functions

The functions in Table 14-6 all take an iterable and return a single result. They are known as「reducing,」「folding,」or「accumulating」functions. Actually, every one of the built-ins listed here can be implemented with functools.reduce, but they exist as built-ins because they address some common use cases more easily. Also, in the case of all and any, there is an important optimization that can’t be done with reduce: these functions short-circuit (i.e., they stop consuming the iterator as soon as the result is determined). See the last test with any in Example 14-23.

Table 14-6. Built-in functions that read iterables and return single values

Module Function Description

(built-in)

all(it)

Returns True if all items in it are truthy, otherwise False; all([]) returns True

(built-in)

any(it)

Returns True if any item in it is truthy, otherwise False; any([]) returns False

(built-in)

max(it, [key=,] [default=])

Returns the maximum value of the items in it;[a] key is an ordering function, as in sorted; default is returned if the iterable is empty

(built-in)

min(it, [key=,] [default=])

Returns the minimum value of the items in it.[b] key is an ordering function, as in sorted; default is returned if the iterable is empty

functools

reduce(func, it, [initial])

Returns the result of applying func to the first pair of items, then to that result and the third item and so on; if given, initial forms the initial pair with the first item

(built-in)

sum(it, start=0)

The sum of all items in it, with the optional start value added (use math.fsum for better precision when adding floats)

[a] May also be called as max(arg1, arg2, …, [key=?]), in which case the maximum among the arguments is returned.

[b] May also be called as min(arg1, arg2, …, [key=?]), in which case the minimum among the arguments is returned.

The operation of all and any is exemplified in Example 14-23.

Example 14-23. Results of all and any for some sequences

>>> all([1, 2, 3]) True >>> all([1, 0, 3]) False >>> all([]) True >>> any([1, 2, 3]) True >>> any([1, 0, 3]) True >>> any([0, 0.0]) False >>> any([]) False >>> g = (n for n in [0, 0.0, 7, 8]) >>> any(g) True >>> next(g) 8

A longer explanation about functools.reduce appeared in Vector Take #4: Hashing and a Faster ==.

Another built-in that takes an iterable and returns something else is sorted. Unlike reversed, which is a generator function, sorted builds and returns an actual list. After all, every single item of the input iterable must be read so they can be sorted, and the sorting happens in a list, therefore sorted just returns that list after it’s done. I mention sorted here because it does consume an arbitrary iterable.

Of course, sorted and the reducing functions only work with iterables that eventually stop. Otherwise, they will keep on collecting items and never return a result.

We’ll now go back to the iter() built-in: it has a little-known feature that we haven’t covered yet.

A Closer Look at the iter Function

As we’ve seen, Python calls iter(x) when it needs to iterate over an object x.

But iter has another trick: it can be called with two arguments to create an iterator from a regular function or any callable object. In this usage, the first argument must be a callable to be invoked repeatedly (with no arguments) to yield values, and the second argument is a sentinel: a marker value which, when returned by the callable, causes the iterator to raise StopIteration instead of yielding the sentinel.

The following example shows how to use iter to roll a six-sided die until a 1 is rolled:

>>> def d6(): ... return randint(1, 6) ... >>> d6_iter = iter(d6, 1) >>> d6_iter <callable_iterator object at 0x00000000029BE6A0> >>> for roll in d6_iter: ... print(roll) ... 4 3 6 3

Note that the iter function here returns a callable_iterator. The for loop in the example may run for a very long time, but it will never display 1, because that is the sentinel value. As usual with iterators, the d6_iter object in the example becomes useless once exhausted. To start over, you must rebuild the iterator by invoking iter(…) again.

A useful example is found in the iter built-in function documentation. This snippet reads lines from a file until a blank line is found or the end of file is reached:

with open('mydata.txt') as fp: for line in iter(fp.readline, ''): process_line(line)

To close this chapter, I present a practical example of using generators to handle a large volume of data efficiently.

Case Study: Generators in a Database Conversion Utility

A few years ago I worked at BIREME, a digital library run by PAHO/WHO (Pan-American Health Organization/World Health Organization) in São Paulo, Brazil. Among the bibliographic datasets created by BIREME are LILACS (Latin American and Caribbean Health Sciences index) and SciELO (Scientific Electronic Library Online), two comprehensive databases indexing the scientific and technical literature produced in the region.

Since the late 1980s, the database system used to manage LILACS is CDS/ISIS, a non-relational, document database created by UNESCO and eventually rewritten in C by BIREME to run on GNU/Linux servers. One of my jobs was to research alternatives for a possible migration of LILACS—and eventually the much larger SciELO—to a modern, open source, document database such as CouchDB or MongoDB.

As part of that research, I wrote a Python script, isis2json.py, that reads a CDS/ISIS file and writes a JSON file suitable for importing to CouchDB or MongoDB. Initially, the script read files in the ISO-2709 format exported by CDS/ISIS. The reading and writing had to be done incrementally because the full datasets were much bigger than main memory. That was easy enough: each iteration of the main for loop read one record from the .iso file, massaged it, and wrote it to the .json output.

However, for operational reasons, it was deemed necessary that isis2json.py supported another CDS/ISIS data format: the binary .mst files used in production at BIREME—to avoid the costly export to ISO-2709.

Now I had a problem: the libraries used to read ISO-2709 and .mst files had very different APIs. And the JSON writing loop was already complicated because the script accepted a variety of command-line options to restructure each output record. Reading data using two different APIs in the same for loop where the JSON was produced would be unwieldy.

The solution was to isolate the reading logic into a pair of generator functions: one for each supported input format. In the end, the isis2json.py script was split into four functions. You can see the main Python 2 script in Example A-5, but the full source code with dependencies is in fluentpython/isis2json on GitHub.

Here is a high-level overview of how the script is structured:

main

The main function uses argparse to read command-line options that configure the structure of the output records. Based on the input filename extension, a suitable generator function is selected to read the data and yield the records, one by one.

iter_iso_records

This generator function reads .iso files (assumed to be in the ISO-2709 format). It takes two arguments: the filename and isis_json_type, one of the options related to the record structure. Each iteration of its for loop reads one record, creates an empty dict, populates it with field data, and yields the dict.

iter_mst_records

This other generator functions reads .mst files.[116] If you look at the source code for isis2json.py, you’ll see that it’s not as simple as iter_iso_records, but its interface and overall structure is the same: it takes a filename and an isis_json_type argument and enters a for loop, which builds and yields one dict per iteration, representing a single record.

write_json

This function performs the actual writing of the JSON records, one at a time. It takes numerous arguments, but the first one—input_gen—is a reference to a generator function: either iter_iso_records or iter_mst_records. The main for loop in write_json iterates over the dictionaries yielded by the selected input_gen generator, massages it in several ways as determined by the command-line options, and appends the JSON record to the output file.

By leveraging generator functions, I was able to decouple the reading logic from the writing logic. Of course, the simplest way to decouple them would be to read all records to memory, then write them to disk. But that was not a viable option because of the size of the datasets. Using generators, the reading and writing is interleaved, so the script can process files of any size.

Now if isis2json.py needs to support an additional input format—say, MARCXML, a DTD used by the U.S. Library of Congress to represent ISO-2709 data—it will be easy to add a third generator function to implement the reading logic, without changing anything in the complicated write_json function.

This is not rocket science, but it’s a real example where generators provided a flexible solution to processing databases as a stream of records, keeping memory usage low regardless of the amount of data. Anyone who manages large datasets finds many opportunities for using generators in practice.

The next section addresses an aspect of generators that we’ll actually skip for now. Read on to understand why.

Generators as Coroutines

About five years after generator functions with the yield keyword were introduced in Python 2.2, PEP 342 — Coroutines via Enhanced Generators was implemented in Python 2.5. This proposal added extra methods and functionality to generator objects, most notably the .send() method.

Like .__next__(), .send() causes the generator to advance to the next yield, but it also allows the client using the generator to send data into it: whatever argument is passed to .send() becomes the value of the corresponding yield expression inside the generator function body. In other words, .send() allows two-way data exchange between the client code and the generator—in contrast with .__next__(), which only lets the client receive data from the generator.

This is such a major「enhancement」that it actually changes the nature of generators: when used in this way, they become coroutines. David Beazley—probably the most prolific writer and speaker about coroutines in the Python community—warned in a famous PyCon US 2009 tutorial:

Generators produce data for iteration

Coroutines are consumers of data

To keep your brain from exploding, you don’t mix the two concepts together

Coroutines are not related to iteration

Note: There is a use of having yield produce a value in a coroutine, but it’s not tied to iteration.[117]

— David Beazley「A Curious Course on Coroutines and Concurrency」

I will follow Dave’s advice and close this chapter—which is really about iteration techniques—without touching send and the other features that make generators usable as coroutines. Coroutines will be covered in Chapter 16.

Chapter Summary

Iteration is so deeply embedded in the language that I like to say that Python groks iterators.[118] The integration of the Iterator pattern in the semantics of Python is a prime example of how design patterns are not equally applicable in all programming languages. In Python, a classic iterator implemented「by hand」as in Example 14-4 has no practical use, except as a didactic example.

In this chapter, we built a few versions of a class to iterate over individual words in text files that may be very long. Thanks to the use of generators, the successive refactorings of the Sentence class become shorter and easier to read—when you know how they work.

We then coded a generator of arithmetic progressions and showed how to leverage the itertools module to make it simpler. An overview of 24 general-purpose generator functions in the standard library followed.

Following that, we looked at the iter built-in function: first, to see how it returns an iterator when called as iter(o), and then to study how it builds an iterator from any function when called as iter(func, sentinel).

For practical context, I described the implementation of a database conversion utility using generator functions to decouple the reading to the writing logic, enabling efficient handling of large datasets and making it easy to support more than one data input format.

Also mentioned in this chapter were the yield from syntax, new in Python 3.3, and coroutines. Both topics were just introduced here; they get more coverage later in the book.

Further Reading

A detailed technical explanation of generators appears in The Python Language Reference in 6.2.9. Yield expressions. The PEP where generator functions were defined is PEP 255 — Simple Generators.

The itertools module documentation is excellent because of all the examples included. Although the functions in that module are implemented in C, the documentation shows how many of them would be written in Python, often by leveraging other functions in the module. The usage examples are also great: for instance, there is a snippet showing how to use the accumulate function to amortize a loan with interest, given a list of payments over time. There is also an Itertools Recipes section with additional high-performance functions that use the itertools functions as building blocks.

Chapter 4,「Iterators and Generators,」of Python Cookbook, 3E (O’Reilly), by David Beazley and Brian K. Jones, has 16 recipes covering this subject from many different angles, always focusing on practical applications.

The yield from syntax is explained with examples in What’s New in Python 3.3 (see PEP 380: Syntax for Delegating to a Subgenerator). We’ll also cover it in detail in Using yield from and The Meaning of yield from in Chapter 16.

If you are interested in document databases and would like to learn more about the context of Case Study: Generators in a Database Conversion Utility, the Code4Lib Journal—which covers the intersection between libraries and technology—published my paper「From ISIS to CouchDB: Databases and Data Models for Bibliographic Records」. One section of the paper describes the isis2json.py script. The rest of it explains why and how the semistructured data model implemented by document databases like CouchDB and MongoDB are more suitable for cooperative bibliographic data collection than the relational model.

Soapbox

Generator Function Syntax: More Sugar Would Be Nice

Designers need to ensure that controls and displays for different purposes are significantly different from one another.

— Donald Norman The Design of Everyday Things

Source code plays the role of「controls and displays」in programming languages. I think Python is exceptionally well designed; its source code is often as readable as pseudocode. But nothing is perfect. Guido van Rossum should have followed Donald Norman’s advice (previously quoted) and introduced another keyword for defining generator expressions, instead of reusing def. The「BDFL Pronouncements」section of PEP 255 — Simple Generators actually argues:

A「yield」statement buried in the body is not enough warning that the semantics are so different.

But Guido hates introducing new keywords and he did not find that argument convincing, so we are stuck with def.

Reusing the function syntax for generators has other bad consequences. In the paper and experimental work「Python, the Full Monty: A Tested Semantics for the Python Programming Language,」Politz[119] et al. show this trivial example of a generator function (section 4.1 of the paper):

def f(): x=0 while True: x += 1 yield x

The authors then make the point that we can’t abstract the process of yielding with a function call (Example 14-24).

Example 14-24.「[This] seems to perform a simple abstraction over the process of yielding」(Politz et al.)

def f(): def do_yield(n): yield n x = 0 while True: x += 1 do_yield(x)

If we call f() in Example 14-24, we get an infinite loop, and not a generator, because the yield keyword only makes the immediately enclosing function a generator function. Although generator functions look like functions, we cannot delegate another generator function with a simple function call. As a point of comparison, the Lua language does not impose this limitation. A Lua coroutine can call other functions and any of them can yield to the original caller.

The new yield from syntax was introduced to allow a Python generator or coroutine to delegate work to another, without requiring the workaround of an inner for loop. Example 14-24 can be「fixed」by prefixing the function call with yield from, as in Example 14-25.

Example 14-25. This actually performs a simple abstraction over the process of yielding

def f(): def do_yield(n): yield n x = 0 while True: x += 1 yield from do_yield(x)

Reusing def for declaring generators was a usability mistake, and the problem was compounded in Python 2.5 with coroutines, which are also coded as functions with yield. In the case of coroutines, the yield just happens to appear—usually—on the righthand side of an assignment, because it receives the argument of the .send() call from the client. As David Beazley says:

Despite some similarities, generators and coroutines are basically two different concepts.[120]

I believe coroutines also deserved their own keyword. As we’ll see later, coroutines are often used with special decorators, which do set them apart from other functions. But generator functions are not decorated as frequently, so we have to scan their bodies for yield to realize they are not functions at all, but a completely different beast.

It can be argued that, because those features were made to work with little additional syntax, extra syntax would be merely「syntactic sugar.」I happen to like syntactic sugar when it makes features that are different look different. The lack of syntactic sugar is the main reason why Lisp code is hard to read: every language construct in Lisp looks like a function call.

Semantics of Generator Versus Iterator

There are at least three ways of thinking about the relationship between iterators and generators.

The first is the interface viewpoint. The Python iterator protocol defines two methods: __next__ and __iter__. Generator objects implement both, so from this perspective, every generator is an iterator. By this definition, objects created by the enumerate() built-in are iterators:

>>> from collections import abc >>> e = enumerate('ABC') >>> isinstance(e, abc.Iterator) True

The second is the implementation viewpoint. From this angle, a generator is a Python language construct that can be coded in two ways: as a function with the yield keyword or as a generator expression. The generator objects resulting from calling a generator function or evaluating a generator expression are instances of an internal GeneratorType. From this perspective, every generator is also an iterator, because GeneratorType instances implement the iterator interface. But you can write an iterator that is not a generator—by implementing the classic Iterator pattern, as we saw in Example 14-4, or by coding an extension in C. The enumerate objects are not generators from this perspective:

>>> import types >>> e = enumerate('ABC') >>> isinstance(e, types.GeneratorType) False

This happens because types.GeneratorType is defined as「The type of generator-iterator objects, produced by calling a generator function.」

The third is the conceptual viewpoint. In the classic Iterator design pattern—as defined in the GoF book—the iterator traverses a collection and yields items from it. The iterator may be quite complex; for example, it may navigate through a tree-like data structure. But, however much logic is in a classic iterator, it always reads values from an existing data source, and when you call next(it), the iterator is not expected to change the item it gets from the source; it’s supposed to just yield it as is.

In contrast, a generator may produce values without necessarily traversing a collection, like range does. And even if attached to a collection, generators are not limited to yielding just the items in it, but may yield some other values derived from them. A clear example of this is the enumerate function. By the original definition of the design pattern, the generator returned by enumerate is not an iterator because it creates the tuples it yields.

At this conceptual level, the implementation technique is irrelevant. You can write a generator without using a Python generator object. Example 14-26 is a Fibonacci generator I wrote just to make this point.

Example 14-26. fibo_by_hand.py: Fibonacci generator without GeneratorType instances

class Fibonacci: def __iter__(self): return FibonacciGenerator() class FibonacciGenerator: def __init__(self): self.a = 0 self.b = 1 def __next__(self): result = self.a self.a, self.b = self.b, self.a + self.b return result def __iter__(self): return self

Example 14-26 works but is just a silly example. Here is the Pythonic Fibonacci generator:

def fibonacci(): a, b = 0, 1 while True: yield a a, b = b, a + b

And of course, you can always use the generator language construct to perform the basic duties of an iterator: traversing a collection and yielding items from it.

In reality, Python programmers are not strict about this distinction: generators are also called iterators, even in the official docs. The canonical definition of an iterator in the Python Glossary is so general it encompasses both iterators and generators:

Iterator: An object representing a stream of data. […]

The full definition of iterator in the Python Glossary is worth reading. On the other hand, the definition of generator there treats iterator and generator as synonyms, and uses the word「generator」to refer both to the generator function and the generator object it builds. So, in the Python community lingo, iterator and generator are fairly close synonyms.

The Minimalistic Iterator Interface in Python

In the「Implementation」section of the Iterator pattern,[121] the Gang of Four wrote:

The minimal interface to Iterator consists of the operations First, Next, IsDone, and CurrentItem.

However, that very sentence has a footnote which reads:

We can make this interface even smaller by merging Next, IsDone, and CurrentItem into a single operation that advances to the next object and returns it. If the traversal is finished, then this operation returns a special value (0, for instance) that marks the end of the iteration.

This is close to what we have in Python: the single method __next__ does the job. But instead of using a sentinel, which could be overlooked by mistake, the StopIteration exception signals the end of the iteration. Simple and correct: that’s the Python way.

* * *

[104] From「Revenge of the Nerds」, a blog post.

[105] Python 2.2 users could use yield with the directive from __future__ import generators; yield became available by default in Python 2.3.

[106] We first used reprlib in Vector Take #1: Vector2d Compatible.

[107] Gamma et. al., Design Patterns: Elements of Reusable Object-Oriented Software, p. 259.

[108] When reviewing this code, Alex Martelli suggested the body of this method could simply be return iter(self.words). He is correct, of course: the result of calling __iter__ would also be an iterator, as it should be. However, I used a for loop with yield here to introduce the syntax of a generator function, which will be covered in detail in the next section.

[109] Sometimes I add a gen prefix or suffix when naming generator functions, but this is not a common practice. And you can’t do that if you’re implementing an iterable, of course: the necessary special method must be named __iter__.

[110] Thanks to David Kwast for suggesting this example.

[111] Prior to Python 3.3, it was an error to provide a value with the return statement in a generator function. Now that is legal, but the return still causes a StopIteration exception to be raised. The caller can retrieve the return value from the exception object. However, this is only relevant when using a generator function as a coroutine, as we’ll see in Returning a Value from a Coroutine.

[112] In Python 2, there was a coerce() built-in function but it’s gone in Python 3, deemed unnecessary because the numeric coercion rules are implicit in the arithmetic operator methods. So the best way I could think of to coerce the initial value to be of the same type as the rest of the series was to perform the addition and use its type to convert the result. I asked about this in the Python-list and got an excellent response from Steven D’Aprano.

[113] The 14-it-generator/ directory in the Fluent Python code repository includes doctests and a script, aritprog_runner.py, which runs the tests against all variations of the aritprog*.py scripts.

[114] Here the term「mapping」is unrelated to dictionaries, but has to do with the map built-in.

[115] The itertools.chain from the standard library is written in C.

[116] The library used to read the complex .mst binary is actually written in Java, so this functionality is only available when isis2json.py is executed with the Jython interpreter, version 2.5 or newer. For further details, see the README.rst file in the repository. The dependencies are imported inside the generator functions that need them, so the script can run even if only one of the external libraries is available.

[117] Slide 33,「Keeping It Straight,」in「A Curious Course on Coroutines and Concurrency」.

[118] According to the Jargon file, to grok is not merely to learn something, but to absorb it so「it becomes part of you, part of your identity.」

[119] Joe Gibbs Politz, Alejandro Martinez, Matthew Milano, Sumner Warren, Daniel Patterson, Junsong Li, Anand Chitipothu, and Shriram Krishnamurthi,「Python: The Full Monty,」SIGPLAN Not. 48, 10 (October 2013), 217-232.

[120] Slide 31,「A Curious Course on Coroutines and Concurrency」.

[121] Gamma et. al., Design Patterns: Elements of Reusable Object-Oriented Software, p. 261.

Chapter 15. Context Managers and else Blocks

Context managers may end up being almost as important as the subroutine itself. We’ve only scratched the surface with them. […] Basic has a with statement, there are with statements in lots of languages. But they don’t do the same thing, they all do something very shallow, they save you from repeated dotted [attribute] lookups, they don’t do setup and tear down. Just because it’s the same name don’t think it’s the same thing. The with statement is a very big deal.[122]

— Raymond Hettinger Eloquent Python evangelist

In this chapter, we will discuss control flow features that are not so common in other languages, and for this reason tend to be overlooked or underused in Python. They are:

The with statement and context managers

The else clause in for, while, and try statements

The with statement sets up a temporary context and reliably tears it down, under the control of a context manager object. This prevents errors and reduces boilerplate code, making APIs at the same time safer and easier to use. Python programmers are finding lots of uses for with blocks beyond automatic file closing.

The else clause is completely unrelated to with. But this is Part V, and I couldn’t find another place for covering else, and I wouldn’t have a one-page chapter about it, so here it is.

Let’s review the smaller topic to get to the real substance of this chapter.

Do This, Then That: else Blocks Beyond if

This is no secret, but it is an underappreciated language feature: the else clause can be used not only in if statements but also in for, while, and try statements.

The semantics of for/else, while/else, and try/else are closely related, but very different from if/else. Initially the word else actually hindered my understanding of these features, but eventually I got used to it.

Here are the rules:

for

The else block will run only if and when the for loop runs to completion (i.e., not if the for is aborted with a break).

while

The else block will run only if and when the while loop exits because the condition became falsy (i.e., not when the while is aborted with a break).

try

The else block will only run if no exception is raised in the try block. The official docs also state:「Exceptions in the else clause are not handled by the preceding except clauses.」

In all cases, the else clause is also skipped if an exception or a return, break, or continue statement causes control to jump out of the main block of the compound statement.

Note

I think else is a very poor choice for the keyword in all cases except if. It implies an excluding alternative, like「Run this loop, otherwise do that,」but the semantics for else in loops is the opposite:「Run this loop, then do that.」This suggests then as a better keyword—which would also make sense in the try context:「Try this, then do that.」However, adding a new keyword is a breaking change to the language, and Guido avoids it like the plague.

Using else with these statements often makes the code easier to read and saves the trouble of setting up control flags or adding extra if statements.

The use of else in loops generally follows the pattern of this snippet:

for item in my_list: if item.flavor == 'banana': break else: raise ValueError('No banana flavor found!')

In the case of try/except blocks, else may seem redundant at first. After all, the after_call() in the following snippet will run only if the dangerous_call() does not raise an exception, correct?

try: dangerous_call() after_call() except OSError: log('OSError...')

However, doing so puts the after_call() inside the try block for no good reason. For clarity and correctness, the body of a try block should only have the statements that may generate the expected exceptions. This is much better:

try: dangerous_call() except OSError: log('OSError...') else: after_call()

Now it’s clear that the try block is guarding against possible errors in dangerous_call() and not in after_call(). It’s also more obvious that after_call() will only execute if no exceptions are raised in the try block.

In Python, try/except is commonly used for control flow, and not just for error handling. There’s even an acronym/slogan for that documented in the official Python glossary:

EAFP

Easier to ask for forgiveness than permission. This common Python coding style assumes the existence of valid keys or attributes and catches exceptions if the assumption proves false. This clean and fast style is characterized by the presence of many try and except statements. The technique contrasts with the LBYL style common to many other languages such as C.

The glossary then defines LBYL:

LBYL

Look before you leap. This coding style explicitly tests for pre-conditions before making calls or lookups. This style contrasts with the EAFP approach and is characterized by the presence of many if statements. In a multi-threaded environment, the LBYL approach can risk introducing a race condition between「the looking」and「the leaping」. For example, the code, if key in mapping: return mapping[key] can fail if another thread removes key from mapping after the test, but before the lookup. This issue can be solved with locks or by using the EAFP approach.

Given the EAFP style, it makes even more sense to know and use well else blocks in try/except statements.

Now let’s address the main topic of this chapter: the powerful with statement.

Context Managers and with Blocks

Context manager objects exist to control a with statement, just like iterators exist to control a for statement.

The with statement was designed to simplify the try/finally pattern, which guarantees that some operation is performed after a block of code, even if the block is aborted because of an exception, a return or sys.exit() call. The code in the finally clause usually releases a critical resource or restores some previous state that was temporarily changed.

The context manager protocol consists of the __enter__ and __exit__ methods. At the start of the with, __enter__ is invoked on the context manager object. The role of the finally clause is played by a call to __exit__ on the context manager object at the end of the with block.

The most common example is making sure a file object is closed. See Example 15-1 for a detailed demonstration of using with to close a file.

Example 15-1. Demonstration of a file object as a context manager

>>> with open('mirror.py') as fp: # ... src = fp.read(60) # ... >>> len(src) 60 >>> fp # <_io.TextIOWrapper name='mirror.py' mode='r' encoding='UTF-8'> >>> fp.closed, fp.encoding # (True, 'UTF-8') >>> fp.read(60) # Traceback (most recent call last): File "<stdin>", line 1, in <module> ValueError: I/O operation on closed file.

fp is bound to the opened file because the file’s __enter__ method returns self.

Read some data from fp.

The fp variable is still available.[123]

You can read the attributes of the fp object.

But you can’t perform I/O with fp because at the end of the with block, the TextIOWrapper.__exit__ method is called and closes the file.

The first callout in Example 15-1 makes a subtle but crucial point: the context manager object is the result of evaluating the expression after with, but the value bound to the target variable (in the as clause) is the result of calling __enter__ on the context manager object.

It just happens that in Example 15-1, the open() function returns an instance of TextIOWrapper, and its __enter__ method returns self. But the __enter__ method may also return some other object instead of the context manager.

When control flow exits the with block in any way, the __exit__ method is invoked on the context manager object, not on whatever is returned by __enter__.

The as clause of the with statement is optional. In the case of open, you’ll always need it to get a reference to the file, but some context managers return None because they have no useful object to give back to the user.

Example 15-2 shows the operation of a perfectly frivolous context manager designed to highlight the distinction between the context manager and the object returned by its __enter__ method.

Example 15-2. Test driving the LookingGlass context manager class

>>> from mirror import LookingGlass >>> with LookingGlass() as what: ... print('Alice, Kitty and Snowdrop') ... print(what) ... pordwonS dna yttiK ,ecilA YKCOWREBBAJ >>> what 'JABBERWOCKY' >>> print('Back to normal.') Back to normal.

The context manager is an instance of LookingGlass; Python calls __enter__ on the context manager and the result is bound to what.

Print a str, then the value of the target variable what.

The output of each print comes out backward.

Now the with block is over. We can see that the value returned by __enter__, held in what, is the string 'JABBERWOCKY'.

Program output is no longer backward.

Example 15-3 shows the implementation of LookingGlass.

Example 15-3. mirror.py: code for the LookingGlass context manager class

class LookingGlass: def __enter__(self): import sys self.original_write = sys.stdout.write sys.stdout.write = self.reverse_write return 'JABBERWOCKY' def reverse_write(self, text): self.original_write(text[::-1]) def __exit__(self, exc_type, exc_value, traceback): import sys sys.stdout.write = self.original_write if exc_type is ZeroDivisionError: print('Please DO NOT divide by zero!') return True

Python invokes __enter__ with no arguments besides self.

Hold the original sys.stdout.write method in an instance attribute for later use.

Monkey-patch sys.stdout.write, replacing it with our own method.

Return the 'JABBERWOCKY' string just so we have something to put in the target variable what.

Our replacement to sys.stdout.write reverses the text argument and calls the original implementation.

Python calls __exit__ with None, None, None if all went well; if an exception is raised, the three arguments get the exception data, as described next.

It’s cheap to import modules again because Python caches them.

Restore the original method to sys.stdout.write.

If the exception is not None and its type is ZeroDivisionError, print a message…

…and return True to tell the interpreter that the exception was handled.

If __exit__ returns None or anything but True, any exception raised in the with block will be propagated.

Tip

When real applications take over standard output, they often want to replace sys.stdout with another file-like object for a while, then switch back to the original. The contextlib.redirect_stdout context manager does exactly that: just pass it the file-like object that will stand in for sys.stdout.

The interpreter calls the __enter__ method with no arguments—beyond the implicit self. The three arguments passed to __exit__ are:

exc_type

The exception class (e.g., ZeroDivisionError).

exc_value

The exception instance. Sometimes, parameters passed to the exception constructor—such as the error message—can be found in exc_value.args.

traceback

A traceback object.[124]

For a detailed look at how a context manager works, see Example 15-4, where LookingGlass is used outside of a with block, so we can manually call its __enter__ and __exit__ methods.

Example 15-4. Exercising LookingGlass without a with block

>>> from mirror import LookingGlass >>> manager = LookingGlass() >>> manager <mirror.LookingGlass object at 0x2a578ac> >>> monster = manager.__enter__() >>> monster == 'JABBERWOCKY' eurT >>> monster 'YKCOWREBBAJ' >>> manager >ca875a2x0 ta tcejbo ssalGgnikooL.rorrim< >>> manager.__exit__(None, None, None) >>> monster 'JABBERWOCKY'

Instantiate and inspect the manager instance.

Call the context manager __enter__() method and store result in monster.

Monster is the string 'JABBERWOCKY'. The True identifier appears reversed because all output via stdout goes through the write method we patched in __enter__.

Call manager.__exit__ to restore previous stdout.write.

Context managers are a fairly novel feature and slowly but surely the Python community is finding new, creative uses for them. Some examples from the standard library are:

Managing transactions in the sqlite3 module; see「12.6.7.3. Using the connection as a context manager」.

Holding locks, conditions, and semaphores in threading code; see「17.1.10. Using locks, conditions, and semaphores in the with statement」.

Setting up environments for arithmetic operations with Decimal objects; see the decimal.localcontext documentation.

Applying temporary patches to objects for testing; see the unittest.mock.patch function.

The standard library also includes the contextlib utilities, covered next.

The contextlib Utilities

Before rolling your own context manager classes, take a look at「29.6 contextlib — Utilities for with-statement contexts」in The Python Standard Library. Besides the already mentioned redirect_stdout, the contextlib module includes classes and other functions that are more widely applicable:

closing

A function to build context managers out of objects that provide a close() method but don’t implement the __enter__/__exit__ protocol.

suppress

A context manager to temporarily ignore specified exceptions.

@contextmanager

A decorator that lets you build a context manager from a simple generator function, instead of creating a class and implementing the protocol.

ContextDecorator

A base class for defining class-based context managers that can also be used as function decorators, running the entire function within a managed context.

ExitStack

A context manager that lets you enter a variable number of context managers. When the with block ends, ExitStack calls the stacked context managers’ __exit__ methods in LIFO order (last entered, first exited). Use this class when you don’t know beforehand how many context managers you need to enter in your with block; for example, when opening all files from an arbitrary list of files at the same time.

The most widely used of these utilities is surely the @contextmanager decorator, so it deserves more attention. That decorator is also intriguing because it shows a use for the yield statement unrelated to iteration. This paves the way to the concept of a coroutine, the theme of the next chapter.

Using @contextmanager

The @contextmanager decorator reduces the boilerplate of creating a context manager: instead of writing a whole class with __enter__/__exit__ methods, you just implement a generator with a single yield that should produce whatever you want the __enter__ method to return.

In a generator decorated with @contextmanager, yield is used to split the body of the function in two parts: everything before the yield will be executed at the beginning of the while block when the interpreter calls __enter__; the code after yield will run when __exit__ is called at the end of the block.

Here is an example. Example 15-5 replaces the LookingGlass class from Example 15-3 with a generator function.

Example 15-5. mirror_gen.py: a context manager implemented with a generator

import contextlib @contextlib.contextmanager def looking_glass(): import sys original_write = sys.stdout.write def reverse_write(text): original_write(text[::-1]) sys.stdout.write = reverse_write yield 'JABBERWOCKY' sys.stdout.write = original_write

Apply the contextmanager decorator.

Preserve original sys.stdout.write method.

Define custom reverse_write function; original_write will be available in the closure.

Replace sys.stdout.write with reverse_write.

Yield the value that will be bound to the target variable in the as clause of the with statement. This function pauses at this point while the body of the with executes.

When control exits the with block in any way, execution continues after the yield; here the original sys.stdout.write is restored.

Example 15-6 shows the looking_glass function in operation.

Example 15-6. Test driving the looking_glass context manager function

>>> from mirror_gen import looking_glass >>> with looking_glass() as what: ... print('Alice, Kitty and Snowdrop') ... print(what) ... pordwonS dna yttiK ,ecilA YKCOWREBBAJ >>> what 'JABBERWOCKY'

The only difference from Example 15-2 is the name of the context manager: looking_glass instead of LookingGlass.

Essentially the contextlib.contextmanager decorator wraps the function in a class that implements the __enter__ and __exit__ methods.[125]

The __enter__ method of that class:

Invokes the generator function and holds on to the generator object—let’s call it gen.

Calls next(gen) to make it run to the yield keyword.

Returns the value yielded by next(gen), so it can be bound to a target variable in the with/as form.

When the with block terminates, the __exit__ method:

Checks an exception was passed as exc_type; if so, gen.throw(exception) is invoked, causing the exception to be raised in the yield line inside the generator function body.

Otherwise, next(gen) is called, resuming the execution of the generator function body after the yield.

Example 15-5 has a serious flaw: if an exception is raised in the body of the with block, the Python interpreter will catch it and raise it again in the yield expression inside looking_glass. But there is no error handling there, so the looking_glass function will abort without ever restoring the original sys.stdout.write method, leaving the system in an invalid state.

Example 15-7 adds special handling of the ZeroDivisionError exception, making it functionally equivalent to the class-based Example 15-3.

Example 15-7. mirror_gen_exc.py: generator-based context manager implementing exception handling—same external behavior as Example 15-3

import contextlib @contextlib.contextmanager def looking_glass(): import sys original_write = sys.stdout.write def reverse_write(text): original_write(text[::-1]) sys.stdout.write = reverse_write msg = '' try: yield 'JABBERWOCKY' except ZeroDivisionError: msg = 'Please DO NOT divide by zero!' finally: sys.stdout.write = original_write if msg: print(msg)

Create a variable for a possible error message; this is the first change in relation to Example 15-5.

Handle ZeroDivisionError by setting an error message.

Undo monkey-patching of sys.stdout.write.

Display error message, if it was set.

Recall that the __exit__ method tells the interpreter that it has handled the exception by returning True; in that case, the interpreter suppresses the exception. On the other hand, if __exit__ does not explicitly return a value, the interpreter gets the usual None, and propagates the exception. With @contextmanager, the default behavior is inverted: the __exit__ method provided by the decorator assumes any exception sent into the generator is handled and should be suppressed.[126] You must explicitly re-raise an exception in the decorated function if you don’t want @contextmanager to suppress it.[127]

Tip

Having a try/finally (or a with block) around the yield is an unavoidable price of using @contextmanager, because you never know what the users of your context manager are going to do inside their with block.[128]

An interesting real-life example of @contextmanager outside of the standard library is Martijn Pieters’ in-place file rewriting context manager. Example 15-8 shows how it’s used.

Example 15-8. A context manager for rewriting files in place

import csv with inplace(csvfilename, 'r', newline='') as (infh, outfh): reader = csv.reader(infh) writer = csv.writer(outfh) for row in reader: row += ['new', 'columns'] writer.writerow(row)

The inplace function is a context manager that gives you two handles—infh and outfh in the example—to the same file, allowing your code to read and write to it at the same time. It’s easier to use than the standard library’s fileinput.input function (which also provides a context manager, by the way).

If you want to study Martijn’s inplace source code (listed in the post), find the yield keyword: everything before it deals with setting up the context, which entails creating a backup file, then opening and yielding references to the readable and writable file handles that will be returned by the __enter__ call. The __exit__ processing after the yield closes the file handles and restores the file from the backup if something went wrong.

Note that the use of yield in a generator used with the @contextmanager decorator has nothing to do with iteration. In the examples shown in this section, the generator function is operating more like a coroutine: a procedure that runs up to a point, then suspends to let the client code run until the client wants the coroutine to proceed with its job. Chapter 16 is all about coroutines.

Chapter Summary

This chapter started easily enough with discussion of else blocks in for, while, and try statements. Once you get used to the peculiar meaning of the else clause in these statements, I believe else can clarify your intentions.

We then covered context managers and the meaning of the with statement, quickly moving beyond its common use to automatically close opened files. We implemented a custom context manager: the LookingGlass class with the __enter__/__exit__ methods, and saw how to handle exceptions in the __exit__ method. A key point that Raymond Hettinger made in his PyCon US 2013 keynote is that with is not just for resource management, but it’s a tool for factoring out common setup and teardown code, or any pair of operations that need to be done before and after another procedure (slide 21, What Makes Python Awesome?).

Finally, we reviewed functions in the contextlib standard library module. One of them, the @contextmanager decorator, makes it possible to implement a context manager using a simple generator with one yield—a leaner solution than coding a class with at least two methods. We reimplemented the LookingGlass as a looking_glass generator function, and discussed how to do exception handling when using @contextmanager.

The @contextmanager decorator is an elegant and practical tool that brings together three distinctive Python features: a function decorator, a generator, and the with statement.

Further Reading

Chapter 8,「Compound Statements,」in The Python Language Reference says pretty much everything there is to say about else clauses in if, for, while, and try statements. Regarding Pythonic usage of try/except, with or without else, Raymond Hettinger has a brilliant answer to the question「Is it a good practice to use try-except-else in Python?」in StackOverflow. Alex Martelli’s Python in a Nutshell, 2E (O’Reilly), has a chapter about exceptions with an excellent discussion of the EAFP style, crediting computing pioneer Grace Hopper for coining the phrase「It’s easier to ask forgiveness than permission.」

The Python Standard Library, Chapter 4,「Built-in Types,」has a section devoted to Context Manager Types. The __enter__/__exit__ special methods are also documented in The Python Language Reference in「3.3.8. With Statement Context Managers」. Context managers were introduced in PEP 343 — The「with」Statement. This PEP is not easy reading because it spends a lot of time covering corner cases and arguing against alternative proposals. That’s the nature of PEPs.

Raymond Hettinger highlighted the with statement as a「winning language feature」in his PyCon US 2013 keynote. He also showed some interesting applications of context managers in his talk「Transforming Code into Beautiful, Idiomatic Python」at the same conference.

Jeff Preshing’ blog post「The Python with Statement by Example」is interesting for the examples using context managers with the pycairo graphics library.

Beazley and Jones devised context managers for very different purposes in their Python Cookbook, 3E (O’Reilly).「Recipe 8.3. Making Objects Support the Context-Management Protocol」implements a LazyConnection class whose instances are context managers that open and close network connections automatically in with blocks.「Recipe 9.22. Defining Context Managers the Easy Way」introduces a context manager for timing code, and another for making transactional changes to a list object: within the with block, a working copy of the list instance is made, and all changes are applied to that working copy. Only when the with block completes without an exception, the working copy replaces the original list. Simple and ingenious.

Soapbox

Factoring Out the Bread

In his PyCon US 2013 keynote,「What Makes Python Awesome,」Raymond Hettinger says when he first saw the with statement proposal he thought it was「a little bit arcane.」Initially, I had a similar reaction. PEPs are often hard to read, and PEP 343 is typical in that regard.

Then—Hettinger told us—he had an insight: subroutines are the most important invention in the history of computer languages. If you have sequences of operations like A;B;C and P;B;Q, you can factor out B in a subroutine. It’s like factoring out the filling in a sandwich: using tuna with different breads. But what if you want to factor out the bread, to make sandwiches with wheat bread, using a different filling each time? That’s what the with statement offers. It’s the complement of the subroutine. Hettinger went on to say:

The with statement is a very big deal. I encourage you to go out and take this tip of the iceberg and drill deeper. You can probably do profound things with the with statement. The best uses of it have not been discovered yet. I expect that if you make good use of it, it will be copied into other languages and all future languages will have it. You can be part of discovering something almost as profound as the invention of the subroutine itself.

Hettinger admits he is overselling the with statement. Nevertheless, it is a very useful feature. When he used the sandwich analogy to explain how with is the complement to the subroutine, many possibilities opened up in my mind.

If you need to convince anyone that Python is awesome, you should watch Hettinger’s keynote. The bit about context managers is from 23:00 to 26:15. But the entire keynote is excellent.

* * *

[122] PyCon US 2013 keynote:「What Makes Python Awesome」; the part about with starts at 23:00 and ends at 26:15.

[123] with blocks don’t define a new scope, as functions and modules do.

[124] The three arguments received by self are exactly what you get if you call sys.exc_info() in the finally block of a try/finally statement. This makes sense, considering that the with statement is meant to replace most uses of try/finally, and calling sys.exc_info() was often necessary to determine what clean-up action would be required.

[125] The actual class is named _GeneratorContextManager. If you want to see exactly how it works, read its source code in Lib/contextlib.py in the Python 3.4 distribution.

[126] The exception is sent into the generator using the throw method, covered in Coroutine Termination and Exception Handling.

[127] This convention was adopted because when context managers were created, generators could not return values, only yield. They now can, as explained in Returning a Value from a Coroutine. As you’ll see, returning a value from a generator does involve an exception.

[128] This tip is quoted literally from a comment by Leonardo Rochael, one of the tech reviewers for this book. Nicely said, Leo!

Chapter 16. Coroutines

If Python books are any guide, [coroutines are] the most poorly documented, obscure, and apparently useless feature of Python.

— David Beazley Python author

We find two main senses for the verb「to yield」in dictionaries: to produce or to give way. Both senses apply in Python when we use the yield keyword in a generator. A line such as yield item produces a value that is received by the caller of next(…), and it also gives way, suspending the execution of the generator so that the caller may proceed until it’s ready to consume another value by invoking next() again. The caller pulls values from the generator.

A coroutine is syntactically like a generator: just a function with the yield keyword in its body. However, in a coroutine, yield usually appears on the right side of an expression (e.g., datum = yield), and it may or may not produce a value—if there is no expression after the yield keyword, the generator yields None. The coroutine may receive data from the caller, which uses .send(datum) instead of next(…) to feed the coroutine. Usually, the caller pushes values into the coroutine.

It is even possible that no data goes in or out through the yield keyword. Regardless of the flow of data, yield is a control flow device that can be used to implement cooperative multitasking: each coroutine yields control to a central scheduler so that other coroutines can be activated.

When you start thinking of yield primarily in terms of control flow, you have the mindset to understand coroutines.

Python coroutines are the product of a series of enhancements to the humble generator functions we’ve seen so far in the book. Following the evolution of coroutines in Python helps understand their features in stages of increasing functionality and complexity.

After a brief overview of how generators were enable to act as a coroutine, we jump to the core of the chapter. Then we’ll see:

The behavior and states of a generator operating as a coroutine

Priming a coroutine automatically with a decorator

How the caller can control a coroutine through the .close() and .throw(…) methods of the generator object

How coroutines can return values upon termination

Usage and semantics of the new yield from syntax

A use case: coroutines for managing concurrent activities in a simulation

How Coroutines Evolved from Generators

The infrastructure for coroutines appeared in PEP 342 — Coroutines via Enhanced Generators, implemented in Python 2.5 (2006): since then, the yield keyword can be used in an expression, and the .send(value) method was added to the generator API. Using .send(…), the caller of the generator can post data that then becomes the value of the yield expression inside the generator function. This allows a generator to be used as a coroutine: a procedure that collaborates with the caller, yielding and receiving values from the caller.

In addition to .send(…), PEP 342 also added .throw(…) and .close() methods that respectively allow the caller to throw an exception to be handled inside the generator, and to terminate it. These features are covered in the next section and in Coroutine Termination and Exception Handling.

The latest evolutionary step for coroutines came with PEP 380 - Syntax for Delegating to a Subgenerator, implemented in Python 3.3 (2012). PEP 380 made two syntax changes to generator functions, to make them more useful as coroutines:

A generator can now return a value; previously, providing a value to the return statement inside a generator raised a SyntaxError.

The yield from syntax enables complex generators to be refactored into smaller, nested generators while avoiding a lot of boilerplate code previously required for a generator to delegate to subgenerators.

These latest changes will be addressed in Returning a Value from a Coroutine and Using yield from.

Let’s follow the established tradition of Fluent Python and start with some very basic facts and examples, then move into increasingly mind-bending features.

Basic Behavior of a Generator Used as a Coroutine

Example 16-1 illustrates the behavior of a coroutine.

Example 16-1. Simplest possible demonstration of coroutine in action

>>> def simple_coroutine(): # ... print('-> coroutine started') ... x = yield # ... print('-> coroutine received:', x) ... >>> my_coro = simple_coroutine() >>> my_coro # <generator object simple_coroutine at 0x100c2be10> >>> next(my_coro) # -> coroutine started >>> my_coro.send(42) # -> coroutine received: 42 Traceback (most recent call last): # ... StopIteration

A coroutine is defined as a generator function: with yield in its body.

