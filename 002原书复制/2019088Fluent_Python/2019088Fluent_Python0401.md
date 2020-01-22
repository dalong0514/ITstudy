StrKeyDict extends UserDict.

__missing__ is exactly as in Example 3-7.

__contains__ is simpler: we can assume all stored keys are str and we can check on self.data instead of invoking self.keys() as we did in StrKeyDict0.

__setitem__ converts any key to a str. This method is easier to overwrite when we can delegate to the self.data attribute.

Because UserDict subclasses MutableMapping, the remaining methods that make StrKeyDict a full-fledged mapping are inherited from UserDict, MutableMapping, or Mapping. The latter have several useful concrete methods, in spite of being abstract base classes (ABCs). The following methods are worth noting:

MutableMapping.update

This powerful method can be called directly but is also used by __init__ to load the instance from other mappings, from iterables of (key, value) pairs, and keyword arguments. Because it uses self[key] = value to add items, it ends up calling our implementation of __setitem__.

Mapping.get

In StrKeyDict0 (Example 3-7), we had to code our own get to obtain results consistent with __getitem__, but in Example 3-8 we inherited Mapping.get, which is implemented exactly like StrKeyDict0.get (see Python source code).

Tip

After I wrote StrKeyDict, I discovered that Antoine Pitrou authored PEP 455 — Adding a key-transforming dictionary to collections and a patch to enhance the collections module with a TransformDict. The patch is attached to issue18986 and may land in Python 3.5. To experiment with TransformDict, I extracted it into a standalone module (03-dict-set/transformdict.py in the Fluent Python code repository). TransformDict is more general than StrKeyDict, and is complicated by the requirement to preserve the keys as they were originally inserted.

We know there are several immutable sequence types, but how about an immutable dictionary? Well, there isn’t a real one in the standard library, but a stand-in is available. Read on.

Immutable Mappings

The mapping types provided by the standard library are all mutable, but you may need to guarantee that a user cannot change a mapping by mistake. A concrete use case can be found, again, in the Pingo.io project I described in The __missing__ Method: the board.pins mapping represents the physical GPIO pins on the device. As such, it’s nice to prevent inadvertent updates to board.pins because the hardware can’t possibly be changed via software, so any change in the mapping would make it inconsistent with the physical reality of the device.

Since Python 3.3, the types module provides a wrapper class called MappingProxyType, which, given a mapping, returns a mappingproxy instance that is a read-only but dynamic view of the original mapping. This means that updates to the original mapping can be seen in the mappingproxy, but changes cannot be made through it. See Example 3-9 for a brief demonstration.

Example 3-9. MappingProxyType builds a read-only mappingproxy instance from a dict

>>> from types import MappingProxyType >>> d = {1: 'A'} >>> d_proxy = MappingProxyType(d) >>> d_proxy mappingproxy({1: 'A'}) >>> d_proxy[1] 'A' >>> d_proxy[2] = 'x' Traceback (most recent call last): File "<stdin>", line 1, in <module> TypeError: 'mappingproxy' object does not support item assignment >>> d[2] = 'B' >>> d_proxy mappingproxy({1: 'A', 2: 'B'}) >>> d_proxy[2] 'B' >>>

Items in d can be seen through d_proxy.

Changes cannot be made through d_proxy.

d_proxy is dynamic: any change in d is reflected.

Here is how this could be used in practice in the Pingo.io scenario: the constructor in a concrete Board subclass would fill a private mapping with the pin objects, and expose it to clients of the API via a public .pins attribute implemented as a mappingproxy. That way the clients would not be able to add, remove, or change pins by accident.[15]

Now that we’ve covered most mapping types in the standard library and when to use them, we will move to the set types.

Set Theory

Sets are a relatively new addition in the history of Python, and somewhat underused. The set type and its immutable sibling frozenset first appeared in a module in Python 2.3 and were promoted to built-ins in Python 2.6.

Note

In this book, the word「set」is used to refer both to set and frozenset. When talking specifically about the set class, its name appears in the constant width font used for source code: set.

A set is a collection of unique objects. A basic use case is removing duplication:

>>> l = ['spam', 'spam', 'eggs', 'spam'] >>> set(l) {'eggs', 'spam'} >>> list(set(l)) ['eggs', 'spam']

Set elements must be hashable. The set type is not hashable, but frozenset is, so you can have frozenset elements inside a set.

In addition to guaranteeing uniqueness, the set types implement the essential set operations as infix operators, so, given two sets a and b, a | b returns their union, a & b computes the intersection, and a - b the difference. Smart use of set operations can reduce both the line count and the runtime of Python programs, at the same time making code easier to read and reason about—by removing loops and lots of conditional logic.

For example, imagine you have a large set of email addresses (the haystack) and a smaller set of addresses (the needles) and you need to count how many needles occur in the haystack. Thanks to set intersection (the & operator) you can code that in a simple line (see Example 3-10).

Example 3-10. Count occurrences of needles in a haystack, both of type set

found = len(needles & haystack)

Without the intersection operator, you’d have write Example 3-11 to accomplish the same task as Example 3-10.

Example 3-11. Count occurrences of needles in a haystack (same end result as Example 3-10)

found = 0 for n in needles: if n in haystack: found += 1

Example 3-10 runs slightly faster than Example 3-11. On the other hand, Example 3-11 works for any iterable objects needles and haystack, while Example 3-10 requires that both be sets. But, if you don’t have sets on hand, you can always build them on the fly, as shown in Example 3-12.

Example 3-12. Count occurrences of needles in a haystack; these lines work for any iterable types

found = len(set(needles) & set(haystack)) # another way: found = len(set(needles).intersection(haystack))

Of course, there is an extra cost involved in building the sets in Example 3-12, but if either the needles or the haystack is already a set, the alternatives in Example 3-12 may be cheaper than Example 3-11.

Any one of the preceding examples are capable of searching 1,000 values in a haystack of 10,000,000 items in a little over 3 milliseconds—that’s about 3 microseconds per needle.

Besides the extremely fast membership test (thanks to the underlying hash table), the set and frozenset built-in types provide a rich selection of operations to create new sets or, in the case of set, to change existing ones. We will discuss the operations shortly, but first a note about syntax.

set Literals

The syntax of set literals—{1}, {1, 2}, etc.—looks exactly like the math notation, with one important exception: there’s no literal notation for the empty set, so we must remember to write set().

Syntax Quirk

Don’t forget: to create an empty set, you should use the constructor without an argument: set(). If you write {}, you’re creating an empty dict—this hasn’t changed.

In Python 3, the standard string representation of sets always uses the {...} notation, except for the empty set:

>>> s = {1} >>> type(s) <class 'set'> >>> s {1} >>> s.pop() 1 >>> s set()

Literal set syntax like {1, 2, 3} is both faster and more readable than calling the constructor (e.g., set([1, 2, 3])). The latter form is slower because, to evaluate it, Python has to look up the set name to fetch the constructor, then build a list, and finally pass it to the constructor. In contrast, to process a literal like {1, 2, 3}, Python runs a specialized BUILD_SET bytecode.

Take a look at the bytecode for the two operations, as output by dis.dis (the disassembler function):

>>> from dis import dis >>> dis('{1}') 1 0 LOAD_CONST 0 (1) 3 BUILD_SET 1 6 RETURN_VALUE >>> dis('set([1])') 1 0 LOAD_NAME 0 (set) 3 LOAD_CONST 0 (1) 6 BUILD_LIST 1 9 CALL_FUNCTION 1 (1 positional, 0 keyword pair) 12 RETURN_VALUE

Disassemble bytecode for literal expression {1}.

Special BUILD_SET bytecode does almost all the work.

Bytecode for set([1]).

Three operations instead of BUILD_SET: LOAD_NAME, BUILD_LIST, and CALL_FUNCTION.

There is no special syntax to represent frozenset literals—they must be created by calling the constructor. The standard string representation in Python 3 looks like a frozenset constructor call. Note the output in the console session:

>>> frozenset(range(10)) frozenset({0, 1, 2, 3, 4, 5, 6, 7, 8, 9})

Speaking of syntax, the familiar shape of listcomps was adapted to build sets as well.

Set Comprehensions

Set comprehensions (setcomps) were added in Python 2.7, together with the dictcomps that we saw in dict Comprehensions. Example 3-13 is a simple example.

Example 3-13. Build a set of Latin-1 characters that have the word「SIGN」in their Unicode names

>>> from unicodedata import name >>> {chr(i) for i in range(32, 256) if 'SIGN' in name(chr(i),'')} {'§', '=', '¢', '#', '¤', '<', '¥', 'µ', '×', '$', '¶', '£', '©', '°', '+', '÷', '±', '>', '¬', '®', '%'}

Import name function from unicodedata to obtain character names.

Build set of characters with codes from 32 to 255 that have the word 'SIGN' in their names.

Syntax matters aside, let’s now review the rich assortment of operations provided by sets.

Set Operations

Figure 3-2 gives an overview of the methods you can expect from mutable and immutable sets. Many of them are special methods for operator overloading. Table 3-2 shows the math set operators that have corresponding operators or methods in Python. Note that some operators and methods perform in-place changes on the target set (e.g., &=, difference_update, etc.). Such operations make no sense in the ideal world of mathematical sets, and are not implemented in frozenset.

Figure 3-2. UML class diagram for MutableSet and its superclasses from collections.abc (names in italic are abstract classes and abstract methods; reverse operator methods omitted for brevity)

Tip

The infix operators in Table 3-2 require that both operands be sets, but all other methods take one or more iterable arguments. For example, to produce the union of four collections, a, b, c, and d, you can call a.union(b, c, d), where a must be a set, but b, c, and d can be iterables of any type.

Table 3-2. Mathematical set operations: these methods either produce a new set or update the target set in place, if it’s mutable

Math symbol Python operator Method Description

S ∩ Z

s & z

s.__and__(z)

Intersection of s and z

z & s

s.__rand__(z)

Reversed & operator

s.intersection(it, …)

Intersection of s and all sets built from iterables it, etc.

s &= z

s.__iand__(z)

s updated with intersection of s and z

s.intersection_update(it, …)

s updated with intersection of s and all sets built from iterables it, etc.

S ∪ Z

s | z

s.__or__(z)

Union of s and z

z | s

s.__ror__(z)

Reversed |

s.union(it, …)

Union of s and all sets built from iterables it, etc.

s |= z

s.__ior__(z)

s updated with union of s and z

s.update(it, …)

s updated with union of s and all sets built from iterables it, etc.

S \ Z

s - z

s.__sub__(z)

Relative complement or difference between s and z

z - s

s.__rsub__(z)

Reversed - operator

s.difference(it, …)

Difference between s and all sets built from iterables it, etc.

s -= z

s.__isub__(z)

s updated with difference between s and z

s.difference_update(it, …)

s updated with difference between s and all sets built from iterables it, etc.

s.symmetric_difference(it)

Complement of s & set(it)

S ∆ Z

s ^ z

s.__xor__(z)

Symmetric difference (the complement of the intersection s & z)

z ^ s

s.__rxor__(z)

Reversed ^ operator

s.symmetric_difference_update(it, …)

s updated with symmetric difference of s and all sets built from iterables it, etc.

s ^= z

s.__ixor__(z)

s updated with symmetric difference of s and z

Warning

As I write this, there is a Python bug report—(issue 8743)—that says:「The set() operators (or, and, sub, xor, and their in-place counterparts) require that the parameter also be an instance of set().」, with the undesired side effect that these operators don’t work with collections.abc.Set subclasses. The bug is already fixed in trunk for Python 2.7 and 3.4, and should be history by the time you read this.

Table 3-3 lists set predicates: operators and methods that return True or False.

Table 3-3. Set comparison operators and methods that return a bool

Math symbol Python operator Method Description

s.isdisjoint(z)

s and z are disjoint (have no elements in common)

e ∈ S

e in s

s.__contains__(e)

Element e is a member of s

S ⊆ Z

s <= z

s.__le__(z)

s is a subset of the z set

s.issubset(it)

s is a subset of the set built from the iterable it

S ⊂ Z

s < z

s.__lt__(z)

s is a proper subset of the z set

S ⊇ Z

s >= z

s.__ge__(z)

s is a superset of the z set

s.issuperset(it)

s is a superset of the set built from the iterable it

S ⊃ Z

s > z

s.__gt__(z)

s is a proper superset of the z set

In addition to the operators and methods derived from math set theory, the set types implement other methods of practical use, summarized in Table 3-4.

Table 3-4. Additional set methods

set frozenset

s.add(e)

●

Add element e to s

s.clear()

●

Remove all elements of s

s.copy()

●

●

Shallow copy of s

s.discard(e)

●

Remove element e from s if it is present

s.__iter__()

●

●

Get iterator over s

s.__len__()

●

●

len(s)

s.pop()

●

Remove and return an element from s, raising KeyError if s is empty

s.remove(e)

●

Remove element e from s, raising KeyError if e not in s

This completes our overview of the features of sets.

We now change gears to discuss how dictionaries and sets are implemented with hash tables. After reading the rest of this chapter, you will no longer be surprised by the apparently unpredictable behavior sometimes exhibited by dict, set, and their brethren.

dict and set Under the Hood

Understanding how Python dictionaries and sets are implemented using hash tables is helpful to make sense of their strengths and limitations.

Here are some questions this section will answer:

How efficient are Python dict and set?

Why are they unordered?

Why can’t we use any Python object as a dict key or set element?

Why does the order of the dict keys or set elements depend on insertion order, and may change during the lifetime of the structure?

Why is it bad to add items to a dict or set while iterating through it?

To motivate the study of hash tables, we start by showcasing the amazing performance of dict and set with a simple test involving millions of items.

A Performance Experiment

From experience, all Pythonistas know that dicts and sets are fast. We’ll confirm that with a controlled experiment.

To see how the size of a dict, set, or list affects the performance of search using the in operator, I generated an array of 10 million distinct double-precision floats, the「haystack.」I then generated an array of needles: 1,000 floats, with 500 picked from the haystack and 500 verified not to be in it.

For the dict benchmark, I used dict.fromkeys() to create a dict named haystack with 1,000 floats. This was the setup for the dict test. The actual code I clocked with the timeit module is Example 3-14 (like Example 3-11).

Example 3-14. Search for needles in haystack and count those found

found = 0 for n in needles: if n in haystack: found += 1

The benchmark was repeated another four times, each time increasing tenfold the size of haystack, to reach a size of 10,000,000 in the last test. The result of the dict performance test is in Table 3-5.

Table 3-5. Total time for using in operator to search for 1,000 needles in haystack dicts of five sizes on a Core i7 laptop running Python 3.4.0 (tests timed the loop in Example 3-14)

len of haystack Factor dict time Factor

1,000

1x

0.000202s

1.00x

10,000

10x

0.000140s

0.69x

100,000

100x

0.000228s

1.13x

1,000,000

1,000x

0.000290s

1.44x

10,000,000

10,000x

0.000337s

1.67x

In concrete terms, to check for the presence of 1,000 floating-point keys in a dictionary with 1,000 items, the processing time on my laptop was 0.000202s, and the same search in a dict with 10,000,000 items took 0.000337s. In other words, the time per search in the haystack with 10 million items was 0.337µs for each needle—yes, that is about one third of a microsecond per needle.

To compare, I repeated the benchmark, with the same haystacks of increasing size, but storing the haystack as a set or as list. For the set tests, in addition to timing the for loop in Example 3-14, I also timed the one-liner in Example 3-15, which produces the same result: count the number of elements from needles that are also in haystack.

Example 3-15. Use set intersection to count the needles that occur in haystack

found = len(needles & haystack)

Table 3-6 shows the tests side by side. The best times are in the「set& time」column, which displays results for the set & operator using the code from Example 3-15. The worst times are—as expected—in the「list time」column, because there is no hash table to support searches with the in operator on a list, so a full scan must be made, resulting in times that grow linearly with the size of the haystack.

Table 3-6. Total time for using in operator to search for 1,000 keys in haystacks of 5 sizes, stored as dicts, sets, and lists on a Core i7 laptop running Python 3.4.0 (tests timed the loop in Example 3-14 except the set&, which uses Example 3-15)

len of haystack Factor dict time Factor set time Factor set& time Factor list time Factor

1,000

1x

0.000202s

1.00x

0.000143s

1.00x

0.000087s

1.00x

0.010556s

1.00x

10,000

10x

0.000140s

0.69x

0.000147s

1.03x

0.000092s

1.06x

0.086586s

8.20x

100,000

100x

0.000228s

1.13x

0.000241s

1.69x

0.000163s

1.87x

0.871560s

82.57x

1,000,000

1,000x

0.000290s

1.44x

0.000332s

2.32x

0.000250s

2.87x

9.189616s

870.56x

10,000,000

10,000x

0.000337s

1.67x

0.000387s

2.71x

0.000314s

3.61x

97.948056s

9,278.90x

If your program does any kind of I/O, the lookup time for keys in dicts or sets is negligible, regardless of the dict or set size (as long as it does fit in RAM). See the code used to generate Table 3-6 and accompanying discussion in Appendix A, Example A-1.

Now that we have concrete evidence of the speed of dicts and sets, let’s explore how that is achieved. The discussion of the hash table internals explains, for example, why the key ordering is apparently random and unstable.

Hash Tables in Dictionaries

This is a high-level view of how Python uses a hash table to implement a dict. Many details are omitted—the CPython code has some optimization tricks[16]—but the overall description is accurate.

Note

To simplify the ensuing presentation, we will focus on the internals of dict first, and later transfer the concepts to sets.

A hash table is a sparse array (i.e., an array that always has empty cells). In standard data structure texts, the cells in a hash table are often called「buckets.」In a dict hash table, there is a bucket for each item, and it contains two fields: a reference to the key and a reference to the value of the item. Because all buckets have the same size, access to an individual bucket is done by offset.

Python tries to keep at least 1/3 of the buckets empty; if the hash table becomes too crowded, it is copied to a new location with room for more buckets.

To put an item in a hash table, the first step is to calculate the hash value of the item key, which is done with the hash() built-in function, explained next.

Hashes and equality

The hash() built-in function works directly with built-in types and falls back to calling __hash__ for user-defined types. If two objects compare equal, their hash values must also be equal, otherwise the hash table algorithm does not work. For example, because 1 == 1.0 is true, hash(1) == hash(1.0) must also be true, even though the internal representation of an int and a float are very different.[17]

Also, to be effective as hash table indexes, hash values should scatter around the index space as much as possible. This means that, ideally, objects that are similar but not equal should have hash values that differ widely. Example 3-16 is the output of a script to compare the bit patterns of hash values. Note how the hashes of 1 and 1.0 are the same, but those of 1.0001, 1.0002, and 1.0003 are very different.

Example 3-16. Comparing hash bit patterns of 1, 1.0001, 1.0002, and 1.0003 on a 32-bit build of Python (bits that are different in the hashes above and below are highlighted with ! and the right column shows the number of bits that differ)

32-bit Python build 1 00000000000000000000000000000001 != 0 1.0 00000000000000000000000000000001 ------------------------------------------------ 1.0 00000000000000000000000000000001 ! !!! ! !! ! ! ! ! !! !!! != 16 1.0001 00101110101101010000101011011101 ------------------------------------------------ 1.0001 00101110101101010000101011011101 !!! !!!! !!!!! !!!!! !! ! != 20 1.0002 01011101011010100001010110111001 ------------------------------------------------ 1.0002 01011101011010100001010110111001 ! ! ! !!! ! ! !! ! ! ! !!!! != 17 1.0003 00001100000111110010000010010110 ------------------------------------------------

The code to produce Example 3-16 is in Appendix A. Most of it deals with formatting the output, but it is listed as Example A-3 for completeness.

Note

Starting with Python 3.3, a random salt value is added to the hashes of str, bytes, and datetime objects. The salt value is constant within a Python process but varies between interpreter runs. The random salt is a security measure to prevent a DOS attack. Details are in a note in the documentation for the __hash__ special method.

With this basic understanding of object hashes, we are ready to dive into the algorithm that makes hash tables operate.

The hash table algorithm

To fetch the value at my_dict[search_key], Python calls hash(search_key) to obtain the hash value of search_key and uses the least significant bits of that number as an offset to look up a bucket in the hash table (the number of bits used depends on the current size of the table). If the found bucket is empty, KeyError is raised. Otherwise, the found bucket has an item—a found_key:found_value pair—and then Python checks whether search_key == found_key. If they match, that was the item sought: found_value is returned.

However, if search_key and found_key do not match, this is a hash collision. This happens because a hash function maps arbitrary objects to a small number of bits, and—in addition—the hash table is indexed with a subset of those bits. In order to resolve the collision, the algorithm then takes different bits in the hash, massages them in a particular way, and uses the result as an offset to look up a different bucket.[18] If that is empty, KeyError is raised; if not, either the keys match and the item value is returned, or the collision resolution process is repeated. See Figure 3-3 for a diagram of this algorithm.

Figure 3-3. Flowchart for retrieving an item from a dict; given a key, this procedure either returns a value or raises KeyError

The process to insert or update an item is the same, except that when an empty bucket is located, the new item is put there, and when a bucket with a matching key is found, the value in that bucket is overwritten with the new value.

Additionally, when inserting items, Python may determine that the hash table is too crowded and rebuild it to a new location with more room. As the hash table grows, so does the number of hash bits used as bucket offsets, and this keeps the rate of collisions low.

This implementation may seem like a lot of work, but even with millions of items in a dict, many searches happen with no collisions, and the average number of collisions per search is between one and two. Under normal usage, even the unluckiest keys can be found after a handful of collisions are resolved.

Knowing the internals of the dict implementation we can explain the strengths and limitations of this data structure and all the others derived from it in Python. We are now ready to consider why Python dicts behave as they do.

Practical Consequences of How dict Works

In the following subsections, we’ll discuss the limitations and benefits that the underlying hash table implementation brings to dict usage.

Keys must be hashable objects

An object is hashable if all of these requirements are met:

It supports the hash() function via a hash() method that always returns the same value over the lifetime of the object.

It supports equality via an eq() method.

If a == b is True then hash(a) == hash(b) must also be True.

User-defined types are hashable by default because their hash value is their id() and they all compare not equal.

Warning

If you implement a class with a custom __eq__ method, you must also implement a suitable __hash__, because you must always make sure that if a == b is True then hash(a) == hash(b) is also True. Otherwise you are breaking an invariant of the hash table algorithm, with the grave consequence that dicts and sets will not deal reliably with your objects. If a custom __eq__ depends on mutable state, then __hash__ must raise TypeError with a message like unhashable type: 'MyClass'.

dicts have significant memory overhead

Because a dict uses a hash table internally, and hash tables must be sparse to work, they are not space efficient. For example, if you are handling a large quantity of records, it makes sense to store them in a list of tuples or named tuples instead of using a list of dictionaries in JSON style, with one dict per record. Replacing dicts with tuples reduces the memory usage in two ways: by removing the overhead of one hash table per record and by not storing the field names again with each record.

For user-defined types, the __slots__ class attribute changes the storage of instance attributes from a dict to a tuple in each instance. This will be discussed in Saving Space with the __slots__ Class Attribute (Chapter 9).

Keep in mind we are talking about space optimizations. If you are dealing with a few million objects and your machine has gigabytes of RAM, you should postpone such optimizations until they are actually warranted. Optimization is the altar where maintainability is sacrificed.

Key search is very fast

The dict implementation is an example of trading space for time: dictionaries have significant memory overhead, but they provide fast access regardless of the size of the dictionary—as long as it fits in memory. As Table 3-5 shows, when we increased the size of a dict from 1,000 to 10,000,000 elements, the time to search grew by a factor of 2.8, from 0.000163s to 0.000456s. The latter figure means we could search more than 2 million keys per second in a dict with 10 million items.

Key ordering depends on insertion order

When a hash collision happens, the second key ends up in a position that it would not normally occupy if it had been inserted first. So, a dict built as dict([(key1, value1), (key2, value2)]) compares equal to dict([(key2, value2), (key1, value1)]), but their key ordering may not be the same if the hashes of key1 and key2 collide.

Example 3-17 demonstrates the effect of loading three dicts with the same data, just in different order. The resulting dictionaries all compare equal, even if their order is not the same.

Example 3-17. dialcodes.py fills three dictionaries with the same data sorted in different ways

# dial codes of the top 10 most populous countries DIAL_CODES = [ (86, 'China'), (91, 'India'), (1, 'United States'), (62, 'Indonesia'), (55, 'Brazil'), (92, 'Pakistan'), (880, 'Bangladesh'), (234, 'Nigeria'), (7, 'Russia'), (81, 'Japan'), ] d1 = dict(DIAL_CODES) print('d1:', d1.keys()) d2 = dict(sorted(DIAL_CODES)) print('d2:', d2.keys()) d3 = dict(sorted(DIAL_CODES, key=lambda x:x[1])) print('d3:', d3.keys()) assert d1 == d2 and d2 == d3

d1: built from the tuples in descending order of country population.

d2: filled with tuples sorted by dial code.

d3: loaded with tuples sorted by country name.

The dictionaries compare equal, because they hold the same key:value pairs.

Example 3-18 shows the output.

Example 3-18. Output from dialcodes.py shows three distinct key orderings

d1: dict_keys([880, 1, 86, 55, 7, 234, 91, 92, 62, 81]) d2: dict_keys([880, 1, 91, 86, 81, 55, 234, 7, 92, 62]) d3: dict_keys([880, 81, 1, 86, 55, 7, 234, 91, 92, 62])

Adding items to a dict may change the order of existing keys

Whenever you add a new item to a dict, the Python interpreter may decide that the hash table of that dictionary needs to grow. This entails building a new, bigger hash table, and adding all current items to the new table. During this process, new (but different) hash collisions may happen, with the result that the keys are likely to be ordered differently in the new hash table. All of this is implementation-dependent, so you cannot reliably predict when it will happen. If you are iterating over the dictionary keys and changing them at the same time, your loop may not scan all the items as expected—not even the items that were already in the dictionary before you added to it.

This is why modifying the contents of a dict while iterating through it is a bad idea. If you need to scan and add items to a dictionary, do it in two steps: read the dict from start to finish and collect the needed additions in a second dict. Then update the first one with it.

Tip

In Python 3, the .keys(), .items(), and .values() methods return dictionary views, which behave more like sets than the lists returned by these methods in Python 2. Such views are also dynamic: they do not replicate the contents of the dict, and they immediately reflect any changes to the dict.

We can now apply what we know about hash tables to sets.

How Sets Work—Practical Consequences

The set and frozenset types are also implemented with a hash table, except that each bucket holds only a reference to the element (as if it were a key in a dict, but without a value to go with it). In fact, before set was added to the language, we often used dictionaries with dummy values just to perform fast membership tests on the keys.

Everything said in Practical Consequences of How dict Works about how the underlying hash table determines the behavior of a dict applies to a set. Without repeating the previous section, we can summarize it for sets with just a few words:

Set elements must be hashable objects.

Sets have a significant memory overhead.

Membership testing is very efficient.

Element ordering depends on insertion order.

Adding elements to a set may change the order of other elements.

Chapter Summary

Dictionaries are a keystone of Python. Beyond the basic dict, the standard library offers handy, ready-to-use specialized mappings like defaultdict, OrderedDict, ChainMap, and Counter, all defined in the collections module. The same module also provides the easy-to-extend UserDict class.

Two powerful methods available in most mappings are setdefault and update. The setdefault method is used to update items holding mutable values, for example, in a dict of list values, to avoid redundant searches for the same key. The update method allows bulk insertion or overwriting of items from any other mapping, from iterables providing (key, value) pairs and from keyword arguments. Mapping constructors also use update internally, allowing instances to be initialized from mappings, iterables, or keyword arguments.

A clever hook in the mapping API is the __missing__ method, which lets you customize what happens when a key is not found.

The collections.abc module provides the Mapping and MutableMapping abstract base classes for reference and type checking. The little-known MappingProxyType from the types module creates immutable mappings. There are also ABCs for Set and MutableSet.

The hash table implementation underlying dict and set is extremely fast. Understanding its logic explains why items are apparently unordered and may even be reordered behind our backs. There is a price to pay for all this speed, and the price is in memory.

Further Reading

In The Python Standard Library, 8.3. collections — Container datatypes includes examples and practical recipes with several mapping types. The Python source code for the module Lib/collections/init.py is a great reference for anyone who wants to create a new mapping type or grok the logic of the existing ones.

Chapter 1 of Python Cookbook, Third edition (O’Reilly) by David Beazley and Brian K. Jones has 20 handy and insightful recipes with data structures—the majority using dict in clever ways.

Written by A.M. Kuchling—a Python core contributor and author of many pages of the official Python docs and how-tos—Chapter 18,「Python’s Dictionary Implementation: Being All Things to All People, in the book Beautiful Code (O’Reilly) includes a detailed explanation of the inner workings of the Python dict. Also, there are lots of comments in the source code of the dictobject.cCPython module. Brandon Craig Rhodes’ presentation The Mighty Dictionary is excellent and shows how hash tables work by using lots of slides with… tables!

The rationale for adding sets to the language is documented in PEP 218 — Adding a Built-In Set Object Type. When PEP 218 was approved, no special literal syntax was adopted for sets. The set literals were created for Python 3 and backported to Python 2.7, along with dict and set comprehensions. PEP 274 — Dict Comprehensions is the birth certificate of dictcomps. I could not find a PEP for setcomps; apparently they were adopted because they get along well with their siblings—a jolly good reason.

Soapbox

My friend Geraldo Cohen once remarked that Python is「simple and correct.」

The dict type is an example of simplicity and correctness. It’s highly optimized to do one thing well: retrieve arbitrary keys. It’s fast and robust enough to be used all over the Python interpreter itself. If you need predictable ordering, use OrderedDict. That is not a requirement in most uses of mappings, so it makes sense to keep the core implementation simple and offer variations in the standard library.

Contrast with PHP, where arrays are described like this in the official PHP Manual:

An array in PHP is actually an ordered map. A map is a type that associates values to keys. This type is optimized for several different uses; it can be treated as an array, list (vector), hash table (an implementation of a map), dictionary, collection, stack, queue, and probably more.

From that description, I don’t know what is the real cost of using PHP’s list/OrderedDict hybrid.

The goal of this and the previous chapter in this book was to showcase the Python collection types optimized for particular uses. I made the point that beyond the trusty list and dict there are specialized alternatives for different use cases.

Before finding Python, I had done web programming using Perl, PHP, and JavaScript. I really enjoyed having a literal syntax for mappings in these languages, and I badly miss it whenever I have to use Java or C. A good literal syntax for mappings makes it easy to do configuration, table-driven implementations, and to hold data for prototyping and testing. The lack of it pushed the Java community to adopt the verbose and overly complex XML as a data format.

JSON was proposed as「The Fat-Free Alternative to XML」and became a huge success, replacing XML in many contexts. A concise syntax for lists and dictionaries makes an excellent data interchange format.

PHP and Ruby imitated the hash syntax from Perl, using => to link keys to values. JavaScript followed the lead of Python and uses :. Of course, JSON came from JavaScript, but it also happens to be an almost exact subset of Python syntax. JSON is compatible with Python except for the spelling of the values true, false, and null. The syntax everybody now uses for exchanging data is the Python dict and list syntax.

Simple and correct.

* * *

[12] The original script appears in slide 41 of Martelli’s「Re-learning Python」presentation. His script is actually a demonstration of dict.setdefault, as shown in our Example 3-4.

[13] This is an example of using a method as a first-class function, the subject of Chapter 5.

[14] The exact problem with subclassing dict and other built-ins is covered in Subclassing Built-In Types Is Tricky.

[15] We are not actually using MappingProxyType in Pingo.io because it is new in Python 3.3 and we need to support Python 2.7 at this time.

[16] The source code for the CPython dictobject.c module is rich in comments. See also the reference for the Beautiful Code book in Further Reading.

[17] Because we just mentioned int, here is a CPython implementation detail: the hash value of an int that fits in a machine word is the value of the int itself.

[18] The C function that shuffles the hash bits in case of collision has a curious name: perturb. For all the details, see dictobject.c in the CPython source code.

Chapter 4. Text versus Bytes

Humans use text. Computers speak bytes.[19]

— Esther Nam and Travis Fischer Character Encoding and Unicode in Python

Python 3 introduced a sharp distinction between strings of human text and sequences of raw bytes. Implicit conversion of byte sequences to Unicode text is a thing of the past. This chapter deals with Unicode strings, binary sequences, and the encodings used to convert between them.

Depending on your Python programming context, a deeper understanding of Unicode may or may not be of vital importance to you. In the end, most of the issues covered in this chapter do not affect programmers who deal only with ASCII text. But even if that is your case, there is no escaping the str versus byte divide. As a bonus, you’ll find that the specialized binary sequence types provide features that the「all-purpose」Python 2 str type does not have.

In this chapter, we will visit the following topics:

Characters, code points, and byte representations

Unique features of binary sequences: bytes, bytearray, and memoryview

Codecs for full Unicode and legacy character sets

Avoiding and dealing with encoding errors

Best practices when handling text files

The default encoding trap and standard I/O issues

Safe Unicode text comparisons with normalization

Utility functions for normalization, case folding, and brute-force diacritic removal

Proper sorting of Unicode text with locale and the PyUCA library

Character metadata in the Unicode database

Dual-mode APIs that handle str and bytes

Let’s start with the characters, code points, and bytes.

Character Issues

The concept of「string」is simple enough: a string is a sequence of characters. The problem lies in the definition of「character.」

In 2015, the best definition of「character」we have is a Unicode character. Accordingly, the items you get out of a Python 3 str are Unicode characters, just like the items of a unicode object in Python 2—and not the raw bytes you get from a Python 2 str.

The Unicode standard explicitly separates the identity of characters from specific byte representations:

The identity of a character—its code point—is a number from 0 to 1,114,111 (base 10), shown in the Unicode standard as 4 to 6 hexadecimal digits with a「U+」prefix. For example, the code point for the letter A is U+0041, the Euro sign is U+20AC, and the musical symbol G clef is assigned to code point U+1D11E. About 10% of the valid code points have characters assigned to them in Unicode 6.3, the standard used in Python 3.4.

The actual bytes that represent a character depend on the encoding in use. An encoding is an algorithm that converts code points to byte sequences and vice versa. The code point for A (U+0041) is encoded as the single byte \x41 in the UTF-8 encoding, or as the bytes \x41\x00 in UTF-16LE encoding. As another example, the Euro sign (U+20AC) becomes three bytes in UTF-8—\xe2\x82\xac—but in UTF-16LE it is encoded as two bytes: \xac\x20.

Converting from code points to bytes is encoding; converting from bytes to code points is decoding. See Example 4-1.

Example 4-1. Encoding and decoding

>>> s = 'café' >>> len(s) # 4 >>> b = s.encode('utf8') # >>> b b'caf\xc3\xa9' # >>> len(b) # 5 >>> b.decode('utf8') # 'café'

The str 'café' has four Unicode characters.

Encode str to bytes using UTF-8 encoding.

bytes literals start with a b prefix.

bytes b has five bytes (the code point for「é」is encoded as two bytes in UTF-8).

Decode bytes to str using UTF-8 encoding.

Tip

If you need a memory aid to help distinguish .decode() from .encode(), convince yourself that byte sequences can be cryptic machine core dumps while Unicode str objects are「human」text. Therefore, it makes sense that we decode bytes to str to get human-readable text, and we encode str to bytes for storage or transmission.

Although the Python 3 str is pretty much the Python 2 unicode type with a new name, the Python 3 bytes is not simply the old str renamed, and there is also the closely related bytearray type. So it is worthwhile to take a look at the binary sequence types before advancing to encoding/decoding issues.

Byte Essentials

The new binary sequence types are unlike the Python 2 str in many regards. The first thing to know is that there are two basic built-in types for binary sequences: the immutable bytes type introduced in Python 3 and the mutable bytearray, added in Python 2.6. (Python 2.6 also introduced bytes, but it’s just an alias to the str type, and does not behave like the Python 3 bytes type.)

Each item in bytes or bytearray is an integer from 0 to 255, and not a one-character string like in the Python 2 str. However, a slice of a binary sequence always produces a binary sequence of the same type—including slices of length 1. See Example 4-2.

Example 4-2. A five-byte sequence as bytes and as bytearray

>>> cafe = bytes('café', encoding='utf_8') >>> cafe b'caf\xc3\xa9' >>> cafe[0] 99 >>> cafe[:1] b'c' >>> cafe_arr = bytearray(cafe) >>> cafe_arr bytearray(b'caf\xc3\xa9') >>> cafe_arr[-1:] bytearray(b'\xa9')

bytes can be built from a str, given an encoding.

Each item is an integer in range(256).

Slices of bytes are also bytes—even slices of a single byte.

There is no literal syntax for bytearray: they are shown as bytearray() with a bytes literal as argument.

A slice of bytearray is also a bytearray.

