# Chapter 3. Dictionaries and Sets

Any running Python program has many dictionaries active at the same time, even if the user’s program code doesn’t explicitly use a dictionary.

— A. M. Kuchling Chapter 18,「Python’s Dictionary Implementation

The dict type is not only widely used in our programs but also a fundamental part of the Python implementation. Module namespaces, class and instance attributes, and function keyword arguments are some of the fundamental constructs where dictionaries are deployed. The built-in functions live in __builtins__.__dict__.

Because of their crucial role, Python dicts are highly optimized. Hash tables are the engines behind Python’s high-performance dicts.

We also cover sets in this chapter because they are implemented with hash tables as well. Knowing how a hash table works is key to making the most of dictionaries and sets.

Here is a brief outline of this chapter:

Common dictionary methods

Special handling for missing keys

Variations of dict in the standard library

The set and frozenset types

How hash tables work

Implications of hash tables (key type limitations, unpredictable ordering, etc.)

Generic Mapping Types

The collections.abc module provides the Mapping and MutableMapping ABCs to formalize the interfaces of dict and similar types (in Python 2.6 to 3.2, these classes are imported from the collections module, and not from collections.abc). See Figure 3-1.

Figure 3-1. UML class diagram for the MutableMapping and its superclasses from collections.abc (inheritance arrows point from subclasses to superclasses; names in italic are abstract classes and abstract methods)

Implementations of specialized mappings often extend dict or collections.UserDict, instead of these ABCs. The main value of the ABCs is documenting and formalizing the minimal interfaces for mappings, and serving as criteria for isinstance tests in code that needs to support mappings in a broad sense:

>>> my_dict = {} >>> isinstance(my_dict, abc.Mapping) True

Using isinstance is better than checking whether a function argument is of dict type, because then alternative mapping types can be used.

All mapping types in the standard library use the basic dict in their implementation, so they share the limitation that the keys must be hashable (the values need not be hashable, only the keys).

What Is Hashable?

Here is part of the definition of hashable from the Python Glossary:

An object is hashable if it has a hash value which never changes during its lifetime (it needs a __hash__() method), and can be compared to other objects (it needs an __eq__() method). Hashable objects which compare equal must have the same hash value. […]

The atomic immutable types (str, bytes, numeric types) are all hashable. A frozenset is always hashable, because its elements must be hashable by definition. A tuple is hashable only if all its items are hashable. See tuples tt, tl, and tf:

>>> tt = (1, 2, (30, 40)) >>> hash(tt) 8027212646858338501 >>> tl = (1, 2, [30, 40]) >>> hash(tl) Traceback (most recent call last): File "<stdin>", line 1, in <module> TypeError: unhashable type: 'list' >>> tf = (1, 2, frozenset([30, 40])) >>> hash(tf) -4118419923444501110

Warning

At the time of this writing, the Python Glossary states:「All of Python’s immutable built-in objects are hashable」but that is inaccurate because a tuple is immutable, yet it may contain references to unhashable objects.

User-defined types are hashable by default because their hash value is their id() and they all compare not equal. If an object implements a custom __eq__ that takes into account its internal state, it may be hashable only if all its attributes are immutable.

Given these ground rules, you can build dictionaries in several ways. The Built-in Types page in the Library Reference has this example to show the various means of building a dict:

>>> a = dict(one=1, two=2, three=3) >>> b = {'one': 1, 'two': 2, 'three': 3} >>> c = dict(zip(['one', 'two', 'three'], [1, 2, 3])) >>> d = dict([('two', 2), ('one', 1), ('three', 3)]) >>> e = dict({'three': 3, 'one': 1, 'two': 2}) >>> a == b == c == d == e True

In addition to the literal syntax and the flexible dict constructor, we can use dict comprehensions to build dictionaries. See the next section.

dict Comprehensions

Since Python 2.7, the syntax of listcomps and genexps was applied to dict comprehensions (and set comprehensions as well, which we’ll soon visit). A dictcomp builds a dict instance by producing key:value pair from any iterable. Example 3-1 shows the use of dict comprehensions to build two dictionaries from the same list of tuples.

Example 3-1. Examples of dict comprehensions

>>> DIAL_CODES = [ ... (86, 'China'), ... (91, 'India'), ... (1, 'United States'), ... (62, 'Indonesia'), ... (55, 'Brazil'), ... (92, 'Pakistan'), ... (880, 'Bangladesh'), ... (234, 'Nigeria'), ... (7, 'Russia'), ... (81, 'Japan'), ... ] >>> country_code = {country: code for code, country in DIAL_CODES} >>> country_code {'China': 86, 'India': 91, 'Bangladesh': 880, 'United States': 1, 'Pakistan': 92, 'Japan': 81, 'Russia': 7, 'Brazil': 55, 'Nigeria': 234, 'Indonesia': 62} >>> {code: country.upper() for country, code in country_code.items() ... if code < 66} {1: 'UNITED STATES', 55: 'BRAZIL', 62: 'INDONESIA', 7: 'RUSSIA'}

A list of pairs can be used directly with the dict constructor.

Here the pairs are reversed: country is the key, and code is the value.

Reversing the pairs again, values uppercased and items filtered by code < 66.

If you’re used to liscomps, dictcomps are a natural next step. If you aren’t, the spread of the listcomp syntax means it’s now more profitable than ever to become fluent in it.

We now move to a panoramic view of the API for mappings.

Overview of Common Mapping Methods

The basic API for mappings is quite rich. Table 3-1 shows the methods implemented by dict and two of its most useful variations: defaultdict and OrderedDict, both defined in the collections module.

Table 3-1. Methods of the mapping types dict, collections.defaultdict, and collections.OrderedDict (common object methods omitted for brevity); optional arguments are enclosed in […]

dict defaultdict OrderedDict

d.clear()

●

●

●

Remove all items

d.__contains__(k)

●

●

●

k in d

d.copy()

●

●

●

Shallow copy

d.__copy__()

●

Support for copy.copy

d.default_factory

●

Callable invoked by __missing__ to set missing values[a]

d.__delitem__(k)

●

●

●

del d[k]—remove item with key k

d.fromkeys(it, [initial])

●

●

●

New mapping from keys in iterable, with optional initial value (defaults to None)

d.get(k, [default])

●

●

●

Get item with key k, return default or None if missing

d.__getitem__(k)

●

●

●

d[k]—get item with key k

d.items()

●

●

●

Get view over items—(key, value) pairs

d.__iter__()

●

●

●

Get iterator over keys

d.keys()

●

●

●

Get view over keys

d.__len__()

●

●

●

len(d)—number of items

d.__missing__(k)

●

Called when __getitem__ cannot find the key

d.move_to_end(k, [last])

●

Move k first or last position (last is True by default)

d.pop(k, [default])

●

●

●

Remove and return value at k, or default or None if missing

d.popitem()

●

●

●

Remove and return an arbitrary (key, value) item[b]

d.__reversed__()

●

Get iterator for keys from last to first inserted

d.setdefault(k, [default])

●

●

●

If k in d, return d[k]; else set d[k] = default and return it

d.__setitem__(k, v)

●

●

●

d[k] = v—put v at k

d.update(m, [**kargs])

●

●

●

Update d with items from mapping or iterable of (key, value) pairs

d.values()

●

●

●

Get view over values

[a] default_factory is not a method, but a callable instance attribute set by the end user when defaultdict is instantiated.

[b] OrderedDict.popitem() removes the first item inserted (FIFO); an optional last argument, if set to True, pops the last item (LIFO).

The way update handles its first argument m is a prime example of duck typing: it first checks whether m has a keys method and, if it does, assumes it is a mapping. Otherwise, update falls back to iterating over m, assuming its items are (key, value) pairs. The constructor for most Python mappings uses the logic of update internally, which means they can be initialized from other mappings or from any iterable object producing (key, value) pairs.

A subtle mapping method is setdefault. We don’t always need it, but when we do, it provides a significant speedup by avoiding redundant key lookups. If you are not comfortable using it, the following section explains how, through a practical example.

Handling Missing Keys with setdefault

In line with the fail-fast philosophy, dict access with d[k] raises an error when k is not an existing key. Every Pythonista knows that d.get(k, default) is an alternative to d[k] whenever a default value is more convenient than handling KeyError. However, when updating the value found (if it is mutable), using either __getitem__ or get is awkward and inefficient. Consider Example 3-2, a suboptimal script written just to show one case where dict.get is not the best way to handle a missing key.

Example 3-2 is adapted from an example by Alex Martelli,[12] which generates an index like that in Example 3-3.

Example 3-2. index0.py uses dict.get to fetch and update a list of word occurrences from the index (a better solution is in Example 3-4)

"""Build an index mapping word -> list of occurrences""" import sys import re WORD_RE = re.compile('\w+') index = {} with open(sys.argv[1], encoding='utf-8') as fp: for line_no, line in enumerate(fp, 1): for match in WORD_RE.finditer(line): word = match.group() column_no = match.start()+1 location = (line_no, column_no) # this is ugly; coded like this to make a point occurrences = index.get(word, []) occurrences.append(location) index[word] = occurrences # print in alphabetical order for word in sorted(index, key=str.upper): print(word, index[word])

Get the list of occurrences for word, or [] if not found.

Append new location to occurrences.

Put changed occurrences into index dict; this entails a second search through the index.

In the key= argument of sorted I am not calling str.upper, just passing a reference to that method so the sorted function can use it to normalize the words for sorting.[13]

Example 3-3. Partial output from Example 3-2 processing the Zen of Python; each line shows a word and a list of occurrences coded as pairs: (line-number, column-number)

$ python3 index0.py ../../data/zen.txt a [(19, 48), (20, 53)] Although [(11, 1), (16, 1), (18, 1)] ambiguity [(14, 16)] and [(15, 23)] are [(21, 12)] aren [(10, 15)] at [(16, 38)] bad [(19, 50)] be [(15, 14), (16, 27), (20, 50)] beats [(11, 23)] Beautiful [(3, 1)] better [(3, 14), (4, 13), (5, 11), (6, 12), (7, 9), (8, 11), (17, 8), (18, 25)] ...

The three lines dealing with occurrences in Example 3-2 can be replaced by a single line using dict.setdefault. Example 3-4 is closer to Alex Martelli’s original example.

Example 3-4. index.py uses dict.setdefault to fetch and update a list of word occurrences from the index in a single line; contrast with Example 3-2

"""Build an index mapping word -> list of occurrences""" import sys import re WORD_RE = re.compile('\w+') index = {} with open(sys.argv[1], encoding='utf-8') as fp: for line_no, line in enumerate(fp, 1): for match in WORD_RE.finditer(line): word = match.group() column_no = match.start()+1 location = (line_no, column_no) index.setdefault(word, []).append(location) # print in alphabetical order for word in sorted(index, key=str.upper): print(word, index[word])

Get the list of occurrences for word, or set it to [] if not found; setdefault returns the value, so it can be updated without requiring a second search.

In other words, the end result of this line…

my_dict.setdefault(key, []).append(new_value)

…is the same as running…

if key not in my_dict: my_dict[key] = [] my_dict[key].append(new_value)

…except that the latter code performs at least two searches for key—three if it’s not found—while setdefault does it all with a single lookup.

A related issue, handling missing keys on any lookup (and not only when inserting), is the subject of the next section.

Mappings with Flexible Key Lookup

Sometimes it is convenient to have mappings that return some made-up value when a missing key is searched. There are two main approaches to this: one is to use a defaultdict instead of a plain dict. The other is to subclass dict or any other mapping type and add a __missing__ method. Both solutions are covered next.

defaultdict: Another Take on Missing Keys

Example 3-5 uses collections.defaultdict to provide another elegant solution to the problem in Example 3-4. A defaultdict is configured to create items on demand whenever a missing key is searched.

Here is how it works: when instantiating a defaultdict, you provide a callable that is used to produce a default value whenever __getitem__ is passed a nonexistent key argument.

For example, given an empty defaultdict created as dd = defaultdict(list), if 'new-key' is not in dd, the expression dd['new-key'] does the following steps:

Calls list() to create a new list.

Inserts the list into dd using 'new-key' as key.

Returns a reference to that list.

The callable that produces the default values is held in an instance attribute called default_factory.

Example 3-5. index_default.py: using an instance of defaultdict instead of the setdefault method

"""Build an index mapping word -> list of occurrences""" import sys import re import collections WORD_RE = re.compile('\w+') index = collections.defaultdict(list) with open(sys.argv[1], encoding='utf-8') as fp: for line_no, line in enumerate(fp, 1): for match in WORD_RE.finditer(line): word = match.group() column_no = match.start()+1 location = (line_no, column_no) index[word].append(location) # print in alphabetical order for word in sorted(index, key=str.upper): print(word, index[word])

Create a defaultdict with the list constructor as default_factory.

If word is not initially in the index, the default_factory is called to produce the missing value, which in this case is an empty list that is then assigned to index[word] and returned, so the .append(location) operation always succeeds.

If no default_factory is provided, the usual KeyError is raised for missing keys.

Warning

The default_factory of a defaultdict is only invoked to provide default values for __getitem__ calls, and not for the other methods. For example, if dd is a defaultdict, and k is a missing key, dd[k] will call the default_factory to create a default value, but dd.get(k) still returns None.

The mechanism that makes defaultdict work by calling default_factory is actually the __missing__ special method, a feature supported by all standard mapping types that we discuss next.

The __missing__ Method

Underlying the way mappings deal with missing keys is the aptly named __missing__ method. This method is not defined in the base dict class, but dict is aware of it: if you subclass dict and provide a __missing__ method, the standard dict.__getitem__ will call it whenever a key is not found, instead of raising KeyError.

Warning

The __missing__ method is just called by __getitem__ (i.e., for the d[k] operator). The presence of a __missing__ method has no effect on the behavior of other methods that look up keys, such as get or __contains__ (which implements the in operator). This is why the default_factory of defaultdict works only with __getitem__, as noted in the warning at the end of the previous section.

Suppose you’d like a mapping where keys are converted to str when looked up. A concrete use case is the Pingo.io project, where a programmable board with GPIO pins (e.g., the Raspberry Pi or the Arduino) is represented by a board object with a board.pins attribute, which is a mapping of physical pin locations to pin objects, and the physical location may be just a number or a string like "A0" or "P9_12". For consistency, it is desirable that all keys in board.pins are strings, but it is also convenient that looking up my_arduino.pin[13] works as well, so beginners are not tripped when they want to blink the LED on pin 13 of their Arduinos. Example 3-6 shows how such a mapping would work.

Example 3-6. When searching for a nonstring key, StrKeyDict0 converts it to str when it is not found

Tests for item retrieval using `d[key]` notation:: >>> d = StrKeyDict0([('2', 'two'), ('4', 'four')]) >>> d['2'] 'two' >>> d[4] 'four' >>> d[1] Traceback (most recent call last): ... KeyError: '1' Tests for item retrieval using `d.get(key)` notation:: >>> d.get('2') 'two' >>> d.get(4) 'four' >>> d.get(1, 'N/A') 'N/A' Tests for the `in` operator:: >>> 2 in d True >>> 1 in d False

Example 3-7 implements a class StrKeyDict0 that passes the preceding tests.

Note

A better way to create a user-defined mapping type is to subclass collections.UserDict instead of dict (as we’ll do in Example 3-8). Here we subclass dict just to show that __missing__ is supported by the built-in dict.__getitem__ method.

Example 3-7. StrKeyDict0 converts nonstring keys to str on lookup (see tests in Example 3-6)

class StrKeyDict0(dict): def __missing__(self, key): if isinstance(key, str): raise KeyError(key) return self[str(key)] def get(self, key, default=None): try: return self[key] except KeyError: return default def __contains__(self, key): return key in self.keys() or str(key) in self.keys()

StrKeyDict0 inherits from dict.

Check whether key is already a str. If it is, and it’s missing, raise KeyError.

Build str from key and look it up.

The get method delegates to __getitem__ by using the self[key] notation; that gives the opportunity for our __missing__ to act.

If a KeyError was raised, __missing__ already failed, so we return the default.

Search for unmodified key (the instance may contain non-str keys), then for a str built from the key.

Take a moment to consider why the test isinstance(key, str) is necessary in the __missing__ implementation.

Without that test, our __missing__ method would work OK for any key k—str or not str—whenever str(k) produced an existing key. But if str(k) is not an existing key, we’d have an infinite recursion. The last line, self[str(key)] would call __getitem__ passing that str key, which in turn would call __missing__ again.

The __contains__ method is also needed for consistent behavior in this example, because the operation k in d calls it, but the method inherited from dict does not fall back to invoking __missing__. There is a subtle detail in our implementation of __contains__: we do not check for the key in the usual Pythonic way—k in my_dict—because str(key) in self would recursively call __contains__. We avoid this by explicitly looking up the key in self.keys().

Note

A search like k in my_dict.keys() is efficient in Python 3 even for very large mappings because dict.keys() returns a view, which is similar to a set, and containment checks in sets are as fast as in dictionaries. Details are documented in the「Dictionary」view objects section of the documentation. In Python 2, dict.keys() returns a list, so our solution also works there, but it is not efficient for large dictionaries, because k in my_list must scan the list.

The check for the unmodified key—key in self.keys()—is necessary for correctness because StrKeyDict0 does not enforce that all keys in the dictionary must be of type str. Our only goal with this simple example is to make searching「friendlier」and not enforce types.

So far we have covered the dict and defaultdict mapping types, but the standard library comes with other mapping implementations, which we discuss next.

Variations of dict

In this section, we summarize the various mapping types included in the collections module of the standard library, besides defaultdict:

collections.OrderedDict

Maintains keys in insertion order, allowing iteration over items in a predictable order. The popitem method of an OrderedDict pops the first item by default, but if called as my_odict.popitem(last=True), it pops the last item added.

collections.ChainMap

Holds a list of mappings that can be searched as one. The lookup is performed on each mapping in order, and succeeds if the key is found in any of them. This is useful to interpreters for languages with nested scopes, where each mapping represents a scope context. The「ChainMap objects」section of the collections docs has several examples of ChainMap usage, including this snippet inspired by the basic rules of variable lookup in Python:

import builtins pylookup = ChainMap(locals(), globals(), vars(builtins))

collections.Counter

A mapping that holds an integer count for each key. Updating an existing key adds to its count. This can be used to count instances of hashable objects (the keys) or as a multiset—a set that can hold several occurrences of each element. Counter implements the + and - operators to combine tallies, and other useful methods such as most_common([n]), which returns an ordered list of tuples with the n most common items and their counts; see the documentation. Here is Counter used to count letters in words:

>>> ct = collections.Counter('abracadabra') >>> ct Counter({'a': 5, 'b': 2, 'r': 2, 'c': 1, 'd': 1}) >>> ct.update('aaaaazzz') >>> ct Counter({'a': 10, 'z': 3, 'b': 2, 'r': 2, 'c': 1, 'd': 1}) >>> ct.most_common(2) [('a', 10), ('z', 3)]

collections.UserDict

A pure Python implementation of a mapping that works like a standard dict.

While OrderedDict, ChainMap, and Counter come ready to use, UserDict is designed to be subclassed, as we’ll do next.

Subclassing UserDict

It’s almost always easier to create a new mapping type by extending UserDict rather than dict. Its value can be appreciated as we extend our StrKeyDict0 from Example 3-7 to make sure that any keys added to the mapping are stored as str.

The main reason why it’s preferable to subclass from UserDict rather than from dict is that the built-in has some implementation shortcuts that end up forcing us to override methods that we can just inherit from UserDict with no problems.[14]

Note that UserDict does not inherit from dict, but has an internal dict instance, called data, which holds the actual items. This avoids undesired recursion when coding special methods like __setitem__, and simplifies the coding of __contains__, compared to Example 3-7.

Thanks to UserDict, StrKeyDict (Example 3-8) is actually shorter than StrKeyDict0 (Example 3-7), but it does more: it stores all keys as str, avoiding unpleasant surprises if the instance is built or updated with data containing nonstring keys.

Example 3-8. StrKeyDict always converts non-string keys to str—on insertion, update, and lookup

import collections class StrKeyDict(collections.UserDict): def __missing__(self, key): if isinstance(key, str): raise KeyError(key) return self[str(key)] def __contains__(self, key): return str(key) in self.data def __setitem__(self, key, item): self.data[str(key)] = item

