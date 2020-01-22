cls.__subclasses__()

This method returns a list of the immediate subclasses of the class. The implementation uses weak references to avoid circular references between the superclass and its subclasses—which hold a strong reference to the superclasses in their __bases__ attribute. The method returns the list of subclasses that currently exist in memory.

cls.mro()

The interpreter calls this method when building a class to obtain the tuple of superclasses that is stored in the __mro__ attribute of the class. A metaclass can override this method to customize the method resolution order of the class under construction.

Tip

None of the attributes mentioned in this section are listed by the dir(…) function.

With this, our study of class metaprogramming ends. This is a vast topic and I only scratched the surface. That’s why we have「Further Reading」sections in this book.

Chapter Summary

Class metaprogramming is about creating or customizing classes dynamically. Classes in Python are first-class objects, so we started the chapter by showing how a class can be created by a function invoking the type built-in metaclass.

In the next section, we went back to the LineItem class with descriptors from Chapter 20 to solve a lingering issue: how to generate names for the storage attributes that reflected the names of the managed attributes (e.g., _Quantity#price instead of _Quantity#1). The solution was to use a class decorator, essentially a function that gets a just-built class and has the opportunity to inspect it, change it, and even replace it with a different class.

We then moved to a discussion of when different parts of the source code of a module actually run. We saw that there is some overlap between the so-called「import time」and「runtime,」but clearly a lot of code runs triggered by the import statement. Understanding what runs when is crucial, and there are some subtle rules, so we used the evaluation-time exercises to cover this topic.

The following subject was an introduction to metaclasses. We saw that all classes are instances of type, directly or indirectly, so that is the「root metaclass」of the language. A variation of the evaluation-time exercise was designed to show that a metaclass can customize a hierarchy of classes—in contrast with a class decorator, which affects a single class and may have no impact on its descendants.

The first practical application of a metaclass was to solve the issue of the storage attribute names in LineItem. The resulting code is a bit trickier than the class decorator solution, but it can be encapsulated in a module so that the user merely subclasses an apparently plain class (model.Entity) without being aware that it is an instance of a custom metaclass (model.EntityMeta). The end result is reminiscent of the ORM APIs in Django and SQLAlchemy, which use metaclasses in their implementations but don’t require the user to know anything about them.

The second metaclass we implemented added a small feature to model.EntityMeta: a __prepare__ method to provide an OrderedDict to serve as the mapping from names to attributes. This preserves the order in which those attributes are bound in the body of the class under construction, so that metaclass methods like __new__ and __init__ can use that information. In the example, we implemented a _field_names class attribute, which made possible an Entity.field_names() so users could retrieve the Validated descriptors in the same order they appear in the source code.

The last section was a brief overview of attributes and methods available in all Python classes.

Metaclasses are challenging, exciting, and—sometimes—abused by programmers trying to be too clever. To wrap up, let’s recall Alex Martelli’s final advice from his essay Waterfowl and ABCs:

And, don’t define custom ABCs (or metaclasses) in production code… if you feel the urge to do so, I’d bet it’s likely to be a case of「all problems look like a nail」-syndrome for somebody who just got a shiny new hammer—you (and future maintainers of your code) will be much happier sticking with straightforward and simple code, eschewing such depths.

— Alex Martelli

Wise words from a man who is not only a master of Python metaprogramming but also an accomplished software engineer working on some of the largest mission-critical Python deployments in the world.

Further Reading

The essential references for this chapter in the Python documentation are「3.3.3. Customizing class creation」in the「Data Model」chapter of The Python Language Reference, the type class documentation in the「Built-in Functions」page, and「4.13. Special Attributes」of the「Built-in Types」chapter in the Library Reference. Also, in the Library Reference, the types module documentation covers two functions that are new in Python 3.3 and are designed to help with class metaprogramming: types.new_class(…) and types.prepare_class(…).

Class decorators were formalized in PEP 3129 - Class Decorators, written by Collin Winter, with the reference implementation authored by Jack Diederich. The PyCon 2009 talk「Class Decorators: Radically Simple」(video), also by Jack Diederich, is a quick introduction to the feature.

Python in a Nutshell, 2E by Alex Martelli features outstanding coverage of metaclasses, including a metaMetaBunch metaclass that aims to solve the same problem as our simple record_factory from Example 21-2 but is much more sophisticated. Martelli does not address class decorators because the feature appeared later than his book. Beazley and Jones provide excellent examples of class decorators and metaclasses in their Python Cookbook, 3E (O’Reilly). Michael Foord wrote an intriguing post titled「Meta-classes Made Easy: Eliminating self with Metaclasses」. The subtitle says it all.

For metaclasses, the main references are PEP 3115 — Metaclasses in Python 3000, in which the __prepare__ special method was introduced and Unifying types and classes in Python 2.2, authored by Guido van Rossum. The text applies to Python 3 as well, and it covers what were then called the「new-style」class semantics, including descriptors and metaclasses. It’s a must-read. One of the references cited by Guido is Putting Metaclasses to Work: a New Dimension in Object-Oriented Programming, by Ira R. Forman and Scott H. Danforth (Addison-Wesley, 1998), a book to which he gave 5 stars on Amazon.com, adding the following review:

This book contributed to the design for metaclasses in Python 2.2

Too bad this is out of print; I keep referring to it as the best tutorial I know for the difficult subject of cooperative multiple inheritance, supported by Python via the super() function.[199].

For Python 3.5—in alpha as I write this—PEP 487 - Simpler customization of class creation puts forward a new special method, __init_subclass__ that will allow a regular class (i.e., not a metaclass) to customize the initialization of its subclasses. As with class decorators, __init_subclass__ will make class metaprogramming more accessible and also make it that much harder to justify the deployment of the nuclear option—metaclasses.

If you are into metaprogramming, you may wish Python had the ultimate metaprogramming feature: syntactic macros, as offered by Elixir and the Lisp family of languages. Be careful what you wish for. I’ll just say one word: MacroPy.

Soapbox

I will start the last soapbox in the book with a long quote from Brian Harvey and Matthew Wright, two computer science professors from the University of California (Berkeley and Santa Barbara). In their book, Simply Scheme, Harvey and Wright wrote:

There are two schools of thought about teaching computer science. We might caricature the two views this way:

The conservative view: Computer programs have become too large and complex to encompass in a human mind. Therefore, the job of computer science education is to teach people how to discipline their work in such a way that 500 mediocre programmers can join together and produce a program that correctly meets its specification.

The radical view: Computer programs have become too large and complex to encompass in a human mind. Therefore, the job of computer science education is to teach people how to expand their minds so that the programs can fit, by learning to think in a vocabulary of larger, more powerful, more flexible ideas than the obvious ones. Each unit of programming thought must have a big payoff in the capabilities of the program.[200]

— Brian Harvey and Matthew Wright Preface to Simply Scheme

Harvey and Wright’s exaggerated descriptions are about teaching computer science, but they also apply to programming language design. By now, you should have guessed that I subscribe to the「radical」view, and I believe Python was designed in that spirit.

The property idea is a great step forward compared to the accessors-from-the-start approach practically demanded by Java and supported by Java IDEs generating getters/setters with a keyboard shortcut. The main advantage of properties is to let us start our programs simply exposing attributes as public—in the spirit of KISS—knowing a public attribute can become a property at any time without much pain. But the descriptor idea goes way beyond that, providing a framework for abstracting away repetitive accessor logic. That framework is so effective that essential Python constructs use it behind the scenes.

Another powerful idea is functions as first-class objects, paving the way to higher-order functions. Turns out the combination of descriptors and higher-order functions enable the unification of functions and methods. A function’s __get__ produces a method object on the fly by binding the instance to the self argument. This is elegant.[201]

Finally, we have the idea of classes as first-class objects. It’s an outstanding feat of design that a beginner-friendly language provides powerful abstractions such as class decorators and full-fledged, user-defined metaclasses. Best of all: the advanced features are integrated in a way that does not complicate Python’s suitability for casual programming (they actually help it, under the covers). The convenience and success of frameworks such as Django and SQLAlchemy owes much to metaclasses, even if many users of these tools aren’t aware of them. But they can always learn and create the next great library.

I haven’t yet found a language that manages to be easy for beginners, practical for professionals, and exciting for hackers in the way that Python is. Thanks, Guido van Rossum and everybody else who makes it so.

* * *

[194] Message to comp.lang.python, subject:「Acrimony in c.l.p.」. This is another part of the same message from December 23, 2002, quoted in the Preface. The TimBot was inspired that day.

[195] Thanks to my friend J.S. Bueno for suggesting this solution.

[196] Contrast with the import statement in Java, which is just a declaration to let the compiler know that certain packages are required.

[197] I’m not saying starting a database connection just because a module is imported is a good idea, only pointing out it can be done.

[198] Recall from ABC Syntax Details that in Python 2.7 the __metaclass__ class attribute is used, and the metaclass= keyword argument is not supported in the class declaration.

[199] Amazon.com catalog page for Putting Metaclasses to Work. You can still buy it used. I bought it and found it a hard read, but I will probably go back to it later.

[200] Brian Harvey and Matthew Wright, Simply Scheme (MIT Press, 1999), p. xvii. Full text available at Berkeley.edu.

[201] Machine Beauty by David Gelernter (Basic Books) is an intriguing short book about elegance and aesthetics in works of engineering, from bridges to software.

Afterword

Python is a language for consenting adults.

— Alan Runyan Cofounder of Plone

Alan’s pithy definition expresses one of the best qualities of Python: it gets out of the way and lets you do what you must. This also means it doesn’t give you tools to restrict what others can do with your code and the objects it builds.

Of course, Python is not perfect. Among the top irritants to me is the inconsistent use of CamelCase, snake_case and joinedwords in the standard library. But the language definition and the standard library are only part of an ecosystem. The community of users and contributors is the best part of the Python ecosystem.

Here is one example of the community at its best: one morning while writing about asyncio I was frustrated because the API has many functions, dozens of which are coroutines, and you have to call the coroutines with yield from but you can’t do that with regular functions. This was documented in the asyncio pages, but sometimes you had to read a few paragraphs to find out whether a particular function was a coroutine. So I sent a message to python-tulip titled「Proposal: make coroutines stand out in the asyncio docs」. Victor Stinner, an asyncio core developer, Andrew Svetlov, main author of aiohttp, Ben Darnell, lead developer of Tornado, and Glyph Lefkowitz, inventor of Twisted, joined the conversation. Darnell suggested a solution, Alexander Shorin explained how to implement it in Sphinx, and Stinner added the necessary configuration and markup. Less than 12 hours after I raised the issue, the entire asyncio documentation set online was updated with the coroutine tags you can see today.

That story did not happen in an exclusive club. Anybody can join the python-tulip list, and I had posted only a few times when I wrote the proposal. The story illustrates a community that is really open to new ideas and new members. Guido van Rossum hangs out in python-tulip and can regularly be seen answering even simple questions.

Another example of openness: the Python Software Foundation (PSF) has been working to increase diversity in the Python community. Some encouraging results are already in. The 2013–2014 PSF board saw the first women elected directors: Jessica McKellar and Lynn Root. And in the 2015 PyCon North America in Montréal—chaired by Diana Clarke—about 1/3 of the speakers were women. I am unaware of any other major IT conference that has gone so far in the pursuit of gender equality.

If you are a Pythonista but you have not engaged with the community, I encourage you to do so. Seek the Python Users Group (PUG) in your area. If there isn’t one, create it. Python is everywhere, so you will not be alone. Travel to events if you can. Come to a PythonBrasil conference—we’ve had international speakers regularly for many years now. Meeting fellow Pythonistas in person beats any online interaction and is known to bring real benefits besides all the knowledge sharing. Like real jobs and real friendships.

I know I could not have written this book without the help of many friends I made over the years in the Python community.

My father Jairo Ramalho used to say「Só erra quem trabalha」—Portuguese for「Only those who work make mistakes」—great advice to avoid being paralyzed by the fear of making errors. I certainly made my share of mistakes while writing this book. The reviewers, editors, and Early Release readers caught many of them. Within hours of the first Early Release, a reader was reporting typos in the errata page for the book. Other readers contributed more reports, and friends contacted me directly to offer suggestions and corrections. The O’Reilly copyeditors will catch other errors during the production process, which will start as soon as I manage to stop writing. I take responsibility and apologize for any errors and suboptimal prose that remains.

I am very happy to bring this work to conclusion, mistakes and all, and I am very grateful to everybody who helped along the way.

I hope to see you soon at some live event. Please come say hi if you see me around!

Further Reading

I will wrap up the book with references regarding what it its to be「Pythonic」—the main question this book tried to address.

Brandon Rhodes is an awesome Python teacher, and his talk「A Python Æsthetic: Beauty and Why I Python」is beautiful, starting with the use of Unicode U+00C6 (LATIN CAPITAL LETTER AE) in the title. Another awesome teacher, Raymond Hettinger, spoke of beauty in Python at PyCon US 2013:「Transforming Code into Beautiful, Idiomatic Python」.

The Evolution of Style Guides thread that Ian Lee started on Python-ideas is worth reading. Lee is the maintainer of the pep8 package that checks Python source code for PEP 8 compliance. To check the code in this book, I used flake8, which wraps pep8, pyflakes, and Ned Batchelder’s McCabe complexity plug-in.

Besides PEP 8, other influential style guides are the Google Python Style Guide and the Pocoo style guide, from the team who brings us Flake, Sphinx, Jinja 2, and other great Python libraries.

The Hitchhiker’s Guide to Python! is a collective work about writing Pythonic code. Its most prolific contributor is Kenneth Reitz, a community hero thanks to his beautifully Pythonic requests package. David Goodger presented a tutorial at PyCon US 2008 titled「Code Like a Pythonista: Idiomatic Python」. If printed, the tutorial notes are 30 pages long. Of course, the reStructuredText source is available and can be rendered to HTML and S5 slides by docutils. After all, Goodger created both reStructuredText and docutils—the foundations of Sphinx, Python’s excellent documentation system (which, by the way, is also the official documentation system for MongoDB and many other projects).

Martijn Faassen tackles the question head-on in「What is Pythonic?」In the python-list, there is a thread with that same title. Martijn’s post is from 2005, and the thread from 2003, but the Pythonic ideal hasn’t changed much—neither has the language, for that matter. A great thread with「Pythonic」in the title is「Pythonic way to sum n-th list element?」, from which I quoted extensively in Soapbox.

PEP 3099 — Things that will Not Change in Python 3000 explains why many things are the way they are, even after the major overhaul that was Python 3. For a long time, Python 3 was nicknamed Python 3000, but it arrived a few centuries sooner—to the dismay of some. PEP 3099 was written by Georg Brandl, compiling many opinions expressed by the BDFL, Guido van Rossum. The Python Essays page lists several texts by Guido himself.

Appendix A. Support Scripts

Here are full listings for some scripts that were too long to fit in the main text. Also included are scripts used to generate some of the tables and data fixtures used in this book.

These scripts are also available in the Fluent Python code repository, along with almost every other code snippet that appears in the book.

Chapter 3: in Operator Performance Test

Example A-1 is the code I used to produce the timings in Table 3-6 using the timeit module. The script mostly deals with setting up the haystack and needles samples and with formatting output.

While coding Example A-1, I found something that really puts dict performance in perspective. If the script is run in「verbose mode」(with the -v command-line option), the timings I get are nearly twice those in Table 3-5. But note that, in this script,「verbose mode」means only four calls to print while setting up the test, and one additional print to show the number of needles found when each test finishes. No output happens within the loop that does the actual search of the needles in the haystack, but these five print calls take about as much time as searching for 1,000 needles.

Example A-1. container_perftest.py: run it with the name of a built-in collection type as a command-line argument (e.g., container_perftest.py dict)

""" Container ``in`` operator performance test """ import sys import timeit SETUP = ''' import array selected = array.array('d') with open('selected.arr', 'rb') as fp: selected.fromfile(fp, {size}) if {container_type} is dict: haystack = dict.fromkeys(selected, 1) else: haystack = {container_type}(selected) if {verbose}: print(type(haystack), end=' ') print('haystack: %10d' % len(haystack), end=' ') needles = array.array('d') with open('not_selected.arr', 'rb') as fp: needles.fromfile(fp, 500) needles.extend(selected[::{size}//500]) if {verbose}: print(' needles: %10d' % len(needles), end=' ') ''' TEST = ''' found = 0 for n in needles: if n in haystack: found += 1 if {verbose}: print(' found: %10d' % found) ''' def test(container_type, verbose): MAX_EXPONENT = 7 for n in range(3, MAX_EXPONENT + 1): size = 10**n setup = SETUP.format(container_type=container_type, size=size, verbose=verbose) test = TEST.format(verbose=verbose) tt = timeit.repeat(stmt=test, setup=setup, repeat=5, number=1) print('|{:{}d}|{:f}'.format(size, MAX_EXPONENT + 1, min(tt))) if __name__=='__main__': if '-v' in sys.argv: sys.argv.remove('-v') verbose = True else: verbose = False if len(sys.argv) != 2: print('Usage: %s <container_type>' % sys.argv[0]) else: test(sys.argv[1], verbose)

The script container_perftest_datagen.py (Example A-2) generates the data fixture for the script in Example A-1.

Example A-2. container_perftest_datagen.py: generate files with arrays of unique floating point numbers for use in Example A-1

""" Generate data for container performance test """ import random import array MAX_EXPONENT = 7 HAYSTACK_LEN = 10 ** MAX_EXPONENT NEEDLES_LEN = 10 ** (MAX_EXPONENT - 1) SAMPLE_LEN = HAYSTACK_LEN + NEEDLES_LEN // 2 needles = array.array('d') sample = {1/random.random() for i in range(SAMPLE_LEN)} print('initial sample: %d elements' % len(sample)) # complete sample, in case duplicate random numbers were discarded while len(sample) < SAMPLE_LEN: sample.add(1/random.random()) print('complete sample: %d elements' % len(sample)) sample = array.array('d', sample) random.shuffle(sample) not_selected = sample[:NEEDLES_LEN // 2] print('not selected: %d samples' % len(not_selected)) print(' writing not_selected.arr') with open('not_selected.arr', 'wb') as fp: not_selected.tofile(fp) selected = sample[NEEDLES_LEN // 2:] print('selected: %d samples' % len(selected)) print(' writing selected.arr') with open('selected.arr', 'wb') as fp: selected.tofile(fp)

Chapter 3: Compare the Bit Patterns of Hashes

Example A-3 is a simple script to visually show how different are the bit patterns for the hashes of similiar floating-point numbers (e.g., 1.0001, 1.0002, etc.). Its output appears in Example 3-16.

Example A-3. hashdiff.py: display the difference of bit paterns from hash values

import sys MAX_BITS = len(format(sys.maxsize, 'b')) print('%s-bit Python build' % (MAX_BITS + 1)) def hash_diff(o1, o2): h1 = '{:>0{}b}'.format(hash(o1), MAX_BITS) h2 = '{:>0{}b}'.format(hash(o2), MAX_BITS) diff = ''.join('!' if b1 != b2 else ' ' for b1, b2 in zip(h1, h2)) count = '!= {}'.format(diff.count('!')) width = max(len(repr(o1)), len(repr(o2)), 8) sep = '-' * (width * 2 + MAX_BITS) return '{!r:{width}} {}\n{:{width}} {} {}\n{!r:{width}} {}\n{}'.format( o1, h1, ' ' * width, diff, count, o2, h2, sep, width=width) if __name__ == '__main__': print(hash_diff(1, 1.0)) print(hash_diff(1.0, 1.0001)) print(hash_diff(1.0001, 1.0002)) print(hash_diff(1.0002, 1.0003))

Chapter 9: RAM Usage With and Without __slots__

The memtest.py script was used for a demostration in Saving Space with the __slots__ Class Attribute: Example 9-12.

The memtest.py script takes a module name in the command line and loads it. Assuming the module defines a class named Vector, memtest.py creates a list with 10 million instances, reporting the memory usage before and after the list is created.

Example A-4. memtest.py: create lots of Vector instances reporting memory usage

import importlib import sys import resource NUM_VECTORS = 10**7 if len(sys.argv) == 2: module_name = sys.argv[1].replace('.py', '') module = importlib.import_module(module_name) else: print('Usage: {} <vector-module-to-test>'.format()) sys.exit(1) fmt = 'Selected Vector2d type: {.__name__}.{.__name__}' print(fmt.format(module, module.Vector2d)) mem_init = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss print('Creating {:,} Vector2d instances'.format(NUM_VECTORS)) vectors = [module.Vector2d(3.0, 4.0) for i in range(NUM_VECTORS)] mem_final = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss print('Initial RAM usage: {:14,}'.format(mem_init)) print(' Final RAM usage: {:14,}'.format(mem_final))

Chapter 14: isis2json.py Database Conversion Script

Example A-5 is the isis2json.py script discussed in Case Study: Generators in a Database Conversion Utility (Chapter 14). It uses generator functions to lazily convert CDS/ISIS databases to JSON for loading to CouchDB or MongoDB.

Note that this is a Python 2 script, designed to run on CPython or Jython, versions 2.5 to 2.7, but not on Python 3. Under CPython it can read only .iso files; with Jython it can also read .mst files, using the Bruma library available on the fluentpython/isis2json repository in GitHub. See usage documentation in that repository.

Example A-5. isis2json.py: dependencies and documentation available on GitHub repository fluentpython/isis2json

# this script works with Python or Jython (versions >=2.5 and <3) import sys import argparse from uuid import uuid4 import os try: import json except ImportError: if os.name == 'java': # running Jython from com.xhaus.jyson import JysonCodec as json else: import simplejson as json SKIP_INACTIVE = True DEFAULT_QTY = 2**31 ISIS_MFN_KEY = 'mfn' ISIS_ACTIVE_KEY = 'active' SUBFIELD_DELIMITER = '^' INPUT_ENCODING = 'cp1252' def iter_iso_records(iso_file_name, isis_json_type): from iso2709 import IsoFile from subfield import expand iso = IsoFile(iso_file_name) for record in iso: fields = {} for field in record.directory: field_key = str(int(field.tag)) # remove leading zeroes field_occurrences = fields.setdefault(field_key, []) content = field.value.decode(INPUT_ENCODING, 'replace') if isis_json_type == 1: field_occurrences.append(content) elif isis_json_type == 2: field_occurrences.append(expand(content)) elif isis_json_type == 3: field_occurrences.append(dict(expand(content))) else: raise NotImplementedError('ISIS-JSON type %s conversion ' 'not yet implemented for .iso input' % isis_json_type) yield fields iso.close() def iter_mst_records(master_file_name, isis_json_type): try: from bruma.master import MasterFactory, Record except ImportError: print('IMPORT ERROR: Jython 2.5 and Bruma.jar ' 'are required to read .mst files') raise SystemExit mst = MasterFactory.getInstance(master_file_name).open() for record in mst: fields = {} if SKIP_INACTIVE: if record.getStatus() != Record.Status.ACTIVE: continue else: # save status only there are non-active records fields[ISIS_ACTIVE_KEY] = (record.getStatus() == Record.Status.ACTIVE) fields[ISIS_MFN_KEY] = record.getMfn() for field in record.getFields(): field_key = str(field.getId()) field_occurrences = fields.setdefault(field_key, []) if isis_json_type == 3: content = {} for subfield in field.getSubfields(): subfield_key = subfield.getId() if subfield_key == '*': content['_'] = subfield.getContent() else: subfield_occurrences = content.setdefault(subfield_key, []) subfield_occurrences.append(subfield.getContent()) field_occurrences.append(content) elif isis_json_type == 1: content = [] for subfield in field.getSubfields(): subfield_key = subfield.getId() if subfield_key == '*': content.insert(0, subfield.getContent()) else: content.append(SUBFIELD_DELIMITER + subfield_key + subfield.getContent()) field_occurrences.append(''.join(content)) else: raise NotImplementedError('ISIS-JSON type %s conversion ' 'not yet implemented for .mst input' % isis_json_type) yield fields mst.close() def write_json(input_gen, file_name, output, qty, skip, id_tag, gen_uuid, mongo, mfn, isis_json_type, prefix, constant): start = skip end = start + qty if id_tag: id_tag = str(id_tag) ids = set() else: id_tag = '' for i, record in enumerate(input_gen): if i >= end: break if not mongo: if i == 0: output.write('[') elif i > start: output.write(',') if start <= i < end: if id_tag: occurrences = record.get(id_tag, None) if occurrences is None: msg = 'id tag #%s not found in record %s' if ISIS_MFN_KEY in record: msg = msg + (' (mfn=%s)' % record[ISIS_MFN_KEY]) raise KeyError(msg % (id_tag, i)) if len(occurrences) > 1: msg = 'multiple id tags #%s found in record %s' if ISIS_MFN_KEY in record: msg = msg + (' (mfn=%s)' % record[ISIS_MFN_KEY]) raise TypeError(msg % (id_tag, i)) else: # ok, we have one and only one id field if isis_json_type == 1: id = occurrences[0] elif isis_json_type == 2: id = occurrences[0][0][1] elif isis_json_type == 3: id = occurrences[0]['_'] if id in ids: msg = 'duplicate id %s in tag #%s, record %s' if ISIS_MFN_KEY in record: msg = msg + (' (mfn=%s)' % record[ISIS_MFN_KEY]) raise TypeError(msg % (id, id_tag, i)) record['_id'] = id ids.add(id) elif gen_uuid: record['_id'] = unicode(uuid4()) elif mfn: record['_id'] = record[ISIS_MFN_KEY] if prefix: # iterate over a fixed sequence of tags for tag in tuple(record): if str(tag).isdigit(): record[prefix+tag] = record[tag] del record[tag] # this is why we iterate over a tuple # with the tags, and not directly on the record dict if constant: constant_key, constant_value = constant.split(':') record[constant_key] = constant_value output.write(json.dumps(record).encode('utf-8')) output.write('\n') if not mongo: output.write(']\n') def main(): # create the parser parser = argparse.ArgumentParser( description='Convert an ISIS .mst or .iso file to a JSON array') # add the arguments parser.add_argument( 'file_name', metavar='INPUT.(mst|iso)', help='.mst or .iso file to read') parser.add_argument( '-o', '--out', type=argparse.FileType('w'), default=sys.stdout, metavar='OUTPUT.json', help='the file where the JSON output should be written' ' (default: write to stdout)') parser.add_argument( '-c', '--couch', action='store_true', help='output array within a "docs" item in a JSON document' ' for bulk insert to CouchDB via POST to db/_bulk_docs') parser.add_argument( '-m', '--mongo', action='store_true', help='output individual records as separate JSON dictionaries, one' ' per line for bulk insert to MongoDB via mongoimport utility') parser.add_argument( '-t', '--type', type=int, metavar='ISIS_JSON_TYPE', default=1, help='ISIS-JSON type, sets field structure: 1=string, 2=alist,' ' 3=dict (default=1)') parser.add_argument( '-q', '--qty', type=int, default=DEFAULT_QTY, help='maximum quantity of records to read (default=ALL)') parser.add_argument( '-s', '--skip', type=int, default=0, help='records to skip from start of .mst (default=0)') parser.add_argument( '-i', '--id', type=int, metavar='TAG_NUMBER', default=0, help='generate an "_id" from the given unique TAG field number' ' for each record') parser.add_argument( '-u', '--uuid', action='store_true', help='generate an "_id" with a random UUID for each record') parser.add_argument( '-p', '--prefix', type=str, metavar='PREFIX', default='', help='concatenate prefix to every numeric field tag' ' (ex. 99 becomes "v99")') parser.add_argument( '-n', '--mfn', action='store_true', help='generate an "_id" from the MFN of each record' ' (available only for .mst input)') parser.add_argument( '-k', '--constant', type=str, metavar='TAG:VALUE', default='', help='Include a constant tag:value in every record (ex. -k type:AS)') ''' # TODO: implement this to export large quantities of records to CouchDB parser.add_argument( '-r', '--repeat', type=int, default=1, help='repeat operation, saving multiple JSON files' ' (default=1, use -r 0 to repeat until end of input)') ''' # parse the command line args = parser.parse_args() if args.file_name.lower().endswith('.mst'): input_gen_func = iter_mst_records else: if args.mfn: print('UNSUPORTED: -n/--mfn option only available for .mst input.') raise SystemExit input_gen_func = iter_iso_records input_gen = input_gen_func(args.file_name, args.type) if args.couch: args.out.write('{ "docs" : ') write_json(input_gen, args.file_name, args.out, args.qty, args.skip, args.id, args.uuid, args.mongo, args.mfn, args.type, args.prefix, args.constant) if args.couch: args.out.write('}\n') args.out.close() if __name__ == '__main__': main()

iter_iso_records generator function reads .iso file, yields records.

iter_mst_records generator function reads .mst file, yields records.

write_json iterates over input_gen generator and outputs the .json file.

Main function reads command-line arguments then…

…selects iter_iso_records or…

…iter_mst_records depending on input file extension.

A generator object is built from the selected generator function.

write_json is called with the generator as the first argument.

Chapter 16: Taxi Fleet Discrete Event Simulation

Example A-6 is the full listing for taxi_sim.py discussed in The Taxi Fleet Simulation.

Example A-6. taxi_sim.py: the taxi fleet simulator

""" Taxi simulator ============== Driving a taxi from the console:: >>> from taxi_sim import taxi_process >>> taxi = taxi_process(ident=13, trips=2, start_time=0) >>> next(taxi) Event(time=0, proc=13, action='leave garage') >>> taxi.send(_.time + 7) Event(time=7, proc=13, action='pick up passenger') >>> taxi.send(_.time + 23) Event(time=30, proc=13, action='drop off passenger') >>> taxi.send(_.time + 5) Event(time=35, proc=13, action='pick up passenger') >>> taxi.send(_.time + 48) Event(time=83, proc=13, action='drop off passenger') >>> taxi.send(_.time + 1) Event(time=84, proc=13, action='going home') >>> taxi.send(_.time + 10) Traceback (most recent call last): File "<stdin>", line 1, in <module> StopIteration Sample run with two cars, random seed 10. This is a valid doctest:: >>> main(num_taxis=2, seed=10) taxi: 0 Event(time=0, proc=0, action='leave garage') taxi: 0 Event(time=5, proc=0, action='pick up passenger') taxi: 1 Event(time=5, proc=1, action='leave garage') taxi: 1 Event(time=10, proc=1, action='pick up passenger') taxi: 1 Event(time=15, proc=1, action='drop off passenger') taxi: 0 Event(time=17, proc=0, action='drop off passenger') taxi: 1 Event(time=24, proc=1, action='pick up passenger') taxi: 0 Event(time=26, proc=0, action='pick up passenger') taxi: 0 Event(time=30, proc=0, action='drop off passenger') taxi: 0 Event(time=34, proc=0, action='going home') taxi: 1 Event(time=46, proc=1, action='drop off passenger') taxi: 1 Event(time=48, proc=1, action='pick up passenger') taxi: 1 Event(time=110, proc=1, action='drop off passenger') taxi: 1 Event(time=139, proc=1, action='pick up passenger') taxi: 1 Event(time=140, proc=1, action='drop off passenger') taxi: 1 Event(time=150, proc=1, action='going home') *** end of events *** See longer sample run at the end of this module. """ import random import collections import queue import argparse import time DEFAULT_NUMBER_OF_TAXIS = 3 DEFAULT_END_TIME = 180 SEARCH_DURATION = 5 TRIP_DURATION = 20 DEPARTURE_INTERVAL = 5 Event = collections.namedtuple('Event', 'time proc action') # BEGIN TAXI_PROCESS def taxi_process(ident, trips, start_time=0): """Yield to simulator issuing event at each state change""" time = yield Event(start_time, ident, 'leave garage') for i in range(trips): time = yield Event(time, ident, 'pick up passenger') time = yield Event(time, ident, 'drop off passenger') yield Event(time, ident, 'going home') # end of taxi process # END TAXI_PROCESS # BEGIN TAXI_SIMULATOR class Simulator: def __init__(self, procs_map): self.events = queue.PriorityQueue() self.procs = dict(procs_map) def run(self, end_time): """Schedule and display events until time is up""" # schedule the first event for each cab for _, proc in sorted(self.procs.items()): first_event = next(proc) self.events.put(first_event) # main loop of the simulation sim_time = 0 while sim_time < end_time: if self.events.empty(): print('*** end of events ***') break current_event = self.events.get() sim_time, proc_id, previous_action = current_event print('taxi:', proc_id, proc_id * ' ', current_event) active_proc = self.procs[proc_id] next_time = sim_time + compute_duration(previous_action) try: next_event = active_proc.send(next_time) except StopIteration: del self.procs[proc_id] else: self.events.put(next_event) else: msg = '*** end of simulation time: {} events pending ***' print(msg.format(self.events.qsize())) # END TAXI_SIMULATOR def compute_duration(previous_action): """Compute action duration using exponential distribution""" if previous_action in ['leave garage', 'drop off passenger']: # new state is prowling interval = SEARCH_DURATION elif previous_action == 'pick up passenger': # new state is trip interval = TRIP_DURATION elif previous_action == 'going home': interval = 1 else: raise ValueError('Unknown previous_action: %s' % previous_action) return int(random.expovariate(1/interval)) + 1 def main(end_time=DEFAULT_END_TIME, num_taxis=DEFAULT_NUMBER_OF_TAXIS, seed=None): """Initialize random generator, build procs and run simulation""" if seed is not None: random.seed(seed) # get reproducible results taxis = {i: taxi_process(i, (i+1)*2, i*DEPARTURE_INTERVAL) for i in range(num_taxis)} sim = Simulator(taxis) sim.run(end_time) if __name__ == '__main__': parser = argparse.ArgumentParser( description='Taxi fleet simulator.') parser.add_argument('-e', '--end-time', type=int, default=DEFAULT_END_TIME, help='simulation end time; default = %s' % DEFAULT_END_TIME) parser.add_argument('-t', '--taxis', type=int, default=DEFAULT_NUMBER_OF_TAXIS, help='number of taxis running; default = %s' % DEFAULT_NUMBER_OF_TAXIS) parser.add_argument('-s', '--seed', type=int, default=None, help='random generator seed (for testing)') args = parser.parse_args() main(args.end_time, args.taxis, args.seed) """ Sample run from the command line, seed=3, maximum elapsed time=120:: # BEGIN TAXI_SAMPLE_RUN $ python3 taxi_sim.py -s 3 -e 120 taxi: 0 Event(time=0, proc=0, action='leave garage') taxi: 0 Event(time=2, proc=0, action='pick up passenger') taxi: 1 Event(time=5, proc=1, action='leave garage') taxi: 1 Event(time=8, proc=1, action='pick up passenger') taxi: 2 Event(time=10, proc=2, action='leave garage') taxi: 2 Event(time=15, proc=2, action='pick up passenger') taxi: 2 Event(time=17, proc=2, action='drop off passenger') taxi: 0 Event(time=18, proc=0, action='drop off passenger') taxi: 2 Event(time=18, proc=2, action='pick up passenger') taxi: 2 Event(time=25, proc=2, action='drop off passenger') taxi: 1 Event(time=27, proc=1, action='drop off passenger') taxi: 2 Event(time=27, proc=2, action='pick up passenger') taxi: 0 Event(time=28, proc=0, action='pick up passenger') taxi: 2 Event(time=40, proc=2, action='drop off passenger') taxi: 2 Event(time=44, proc=2, action='pick up passenger') taxi: 1 Event(time=55, proc=1, action='pick up passenger') taxi: 1 Event(time=59, proc=1, action='drop off passenger') taxi: 0 Event(time=65, proc=0, action='drop off passenger') taxi: 1 Event(time=65, proc=1, action='pick up passenger') taxi: 2 Event(time=65, proc=2, action='drop off passenger') taxi: 2 Event(time=72, proc=2, action='pick up passenger') taxi: 0 Event(time=76, proc=0, action='going home') taxi: 1 Event(time=80, proc=1, action='drop off passenger') taxi: 1 Event(time=88, proc=1, action='pick up passenger') taxi: 2 Event(time=95, proc=2, action='drop off passenger') taxi: 2 Event(time=97, proc=2, action='pick up passenger') taxi: 2 Event(time=98, proc=2, action='drop off passenger') taxi: 1 Event(time=106, proc=1, action='drop off passenger') taxi: 2 Event(time=109, proc=2, action='going home') taxi: 1 Event(time=110, proc=1, action='going home') *** end of events *** # END TAXI_SAMPLE_RUN """

Chapter 17: Cryptographic Examples

These scripts were used to show the use of futures.ProcessPoolExecutor to run CPU-intensive tasks.

Example A-7 encrypts and decrypts random byte arrays with the RC4 algorithm. It depends on the arcfour.py module (Example A-8) to run.

Example A-7. arcfour_futures.py: futures.ProcessPoolExecutor example

import sys import time from concurrent import futures from random import randrange from arcfour import arcfour JOBS = 12 SIZE = 2**18 KEY = b"'Twas brillig, and the slithy toves\nDid gyre" STATUS = '{} workers, elapsed time: {:.2f}s' def arcfour_test(size, key): in_text = bytearray(randrange(256) for i in range(size)) cypher_text = arcfour(key, in_text) out_text = arcfour(key, cypher_text) assert in_text == out_text, 'Failed arcfour_test' return size def main(workers=None): if workers: workers = int(workers) t0 = time.time() with futures.ProcessPoolExecutor(workers) as executor: actual_workers = executor._max_workers to_do = [] for i in range(JOBS, 0, -1): size = SIZE + int(SIZE / JOBS * (i - JOBS/2)) job = executor.submit(arcfour_test, size, KEY) to_do.append(job) for future in futures.as_completed(to_do): res = future.result() print('{:.1f} KB'.format(res/2**10)) print(STATUS.format(actual_workers, time.time() - t0)) if __name__ == '__main__': if len(sys.argv) == 2: workers = int(sys.argv[1]) else: workers = None main(workers)

Example A-8 implements the RC4 encryption algorithm in pure Python.

Example A-8. arcfour.py: RC4 compatible algorithm

"""RC4 compatible algorithm""" def arcfour(key, in_bytes, loops=20): kbox = bytearray(256) # create key box for i, car in enumerate(key): # copy key and vector kbox[i] = car j = len(key) for i in range(j, 256): # repeat until full kbox[i] = kbox[i-j] # [1] initialize sbox sbox = bytearray(range(256)) # repeat sbox mixing loop, as recommened in CipherSaber-2 # http://ciphersaber.gurus.com/faq.html#cs2 j = 0 for k in range(loops): for i in range(256): j = (j + sbox[i] + kbox[i]) % 256 sbox[i], sbox[j] = sbox[j], sbox[i] # main loop i = 0 j = 0 out_bytes = bytearray() for car in in_bytes: i = (i + 1) % 256 # [2] shuffle sbox j = (j + sbox[i]) % 256 sbox[i], sbox[j] = sbox[j], sbox[i] # [3] compute t t = (sbox[i] + sbox[j]) % 256 k = sbox[t] car = car ^ k out_bytes.append(car) return out_bytes def test(): from time import time clear = bytearray(b'1234567890' * 100000) t0 = time() cipher = arcfour(b'key', clear) print('elapsed time: %.2fs' % (time() - t0)) result = arcfour(b'key', cipher) assert result == clear, '%r != %r' % (result, clear) print('elapsed time: %.2fs' % (time() - t0)) print('OK') if __name__ == '__main__': test()

Example A-9 applies the SHA-256 hash algorithm to random byte arrays. It uses hashlib from the standard library, which in turn uses the OpenSSL library written in C.

Example A-9. sha_futures.py: futures.ProcessPoolExecutor example

import sys import time import hashlib from concurrent import futures from random import randrange JOBS = 12 SIZE = 2**20 STATUS = '{} workers, elapsed time: {:.2f}s' def sha(size): data = bytearray(randrange(256) for i in range(size)) algo = hashlib.new('sha256') algo.update(data) return algo.hexdigest() def main(workers=None): if workers: workers = int(workers) t0 = time.time() with futures.ProcessPoolExecutor(workers) as executor: actual_workers = executor._max_workers to_do = (executor.submit(sha, SIZE) for i in range(JOBS)) for future in futures.as_completed(to_do): res = future.result() print(res) print(STATUS.format(actual_workers, time.time() - t0)) if __name__ == '__main__': if len(sys.argv) == 2: workers = int(sys.argv[1]) else: workers = None main(workers)

Chapter 17: flags2 HTTP Client Examples

All flags2 examples from Downloads with Progress Display and Error Handling use functions from the flags2_common.py module (Example A-10).

Example A-10. flags2_common.py

"""Utilities for second set of flag examples. """ import os import time import sys import string import argparse from collections import namedtuple from enum import Enum Result = namedtuple('Result', 'status data') HTTPStatus = Enum('Status', 'ok not_found error') POP20_CC = ('CN IN US ID BR PK NG BD RU JP ' 'MX PH VN ET EG DE IR TR CD FR').split() DEFAULT_CONCUR_REQ = 1 MAX_CONCUR_REQ = 1 SERVERS = { 'REMOTE': 'http://flupy.org/data/flags', 'LOCAL': 'http://localhost:8001/flags', 'DELAY': 'http://localhost:8002/flags', 'ERROR': 'http://localhost:8003/flags', } DEFAULT_SERVER = 'LOCAL' DEST_DIR = 'downloads/' COUNTRY_CODES_FILE = 'country_codes.txt' def save_flag(img, filename): path = os.path.join(DEST_DIR, filename) with open(path, 'wb') as fp: fp.write(img) def initial_report(cc_list, actual_req, server_label): if len(cc_list) <= 10: cc_msg = ', '.join(cc_list) else: cc_msg = 'from {} to {}'.format(cc_list[0], cc_list[-1]) print('{} site: {}'.format(server_label, SERVERS[server_label])) msg = 'Searching for {} flag{}: {}' plural = 's' if len(cc_list) != 1 else '' print(msg.format(len(cc_list), plural, cc_msg)) plural = 's' if actual_req != 1 else '' msg = '{} concurrent connection{} will be used.' print(msg.format(actual_req, plural)) def final_report(cc_list, counter, start_time): elapsed = time.time() - start_time print('-' * 20) msg = '{} flag{} downloaded.' plural = 's' if counter[HTTPStatus.ok] != 1 else '' print(msg.format(counter[HTTPStatus.ok], plural)) if counter[HTTPStatus.not_found]: print(counter[HTTPStatus.not_found], 'not found.') if counter[HTTPStatus.error]: plural = 's' if counter[HTTPStatus.error] != 1 else '' print('{} error{}.'.format(counter[HTTPStatus.error], plural)) print('Elapsed time: {:.2f}s'.format(elapsed)) def expand_cc_args(every_cc, all_cc, cc_args, limit): codes = set() A_Z = string.ascii_uppercase if every_cc: codes.update(a+b for a in A_Z for b in A_Z) elif all_cc: with open(COUNTRY_CODES_FILE) as fp: text = fp.read() codes.update(text.split()) else: for cc in (c.upper() for c in cc_args): if len(cc) == 1 and cc in A_Z: codes.update(cc+c for c in A_Z) elif len(cc) == 2 and all(c in A_Z for c in cc): codes.add(cc) else: msg = 'each CC argument must be A to Z or AA to ZZ.' raise ValueError('*** Usage error: '+msg) return sorted(codes)[:limit] def process_args(default_concur_req): server_options = ', '.join(sorted(SERVERS)) parser = argparse.ArgumentParser( description='Download flags for country codes. ' 'Default: top 20 countries by population.') parser.add_argument('cc', metavar='CC', nargs='*', help='country code or 1st letter (eg. B for BA...BZ)') parser.add_argument('-a', '--all', action='store_true', help='get all available flags (AD to ZW)') parser.add_argument('-e', '--every', action='store_true', help='get flags for every possible code (AA...ZZ)') parser.add_argument('-l', '--limit', metavar='N', type=int, help='limit to N first codes', default=sys.maxsize) parser.add_argument('-m', '--max_req', metavar='CONCURRENT', type=int, default=default_concur_req, help='maximum concurrent requests (default={})' .format(default_concur_req)) parser.add_argument('-s', '--server', metavar='LABEL', default=DEFAULT_SERVER, help='Server to hit; one of {} (default={})' .format(server_options, DEFAULT_SERVER)) parser.add_argument('-v', '--verbose', action='store_true', help='output detailed progress info') args = parser.parse_args() if args.max_req < 1: print('*** Usage error: --max_req CONCURRENT must be >= 1') parser.print_usage() sys.exit(1) if args.limit < 1: print('*** Usage error: --limit N must be >= 1') parser.print_usage() sys.exit(1) args.server = args.server.upper() if args.server not in SERVERS: print('*** Usage error: --server LABEL must be one of', server_options) parser.print_usage() sys.exit(1) try: cc_list = expand_cc_args(args.every, args.all, args.cc, args.limit) except ValueError as exc: print(exc.args[0]) parser.print_usage() sys.exit(1) if not cc_list: cc_list = sorted(POP20_CC) return args, cc_list def main(download_many, default_concur_req, max_concur_req): args, cc_list = process_args(default_concur_req) actual_req = min(args.max_req, max_concur_req, len(cc_list)) initial_report(cc_list, actual_req, args.server) base_url = SERVERS[args.server] t0 = time.time() counter = download_many(cc_list, base_url, args.verbose, actual_req) assert sum(counter.values()) == len(cc_list), \ 'some downloads are unaccounted for' final_report(cc_list, counter, t0)

The flags2_sequential.py script (Example A-11) is the baseline for comparison with the concurrent implementations. flags2_threadpool.py (Example 17-14) also uses the get_flag and download_one functions from flags2_sequential.py.

Example A-11. flags2_sequential.py

"""Download flags of countries (with error handling). Sequential version Sample run:: $ python3 flags2_sequential.py -s DELAY b DELAY site: http://localhost:8002/flags Searching for 26 flags: from BA to BZ 1 concurrent connection will be used. -------------------- 17 flags downloaded. 9 not found. Elapsed time: 13.36s """ import collections import requests import tqdm from flags2_common import main, save_flag, HTTPStatus, Result DEFAULT_CONCUR_REQ = 1 MAX_CONCUR_REQ = 1 # BEGIN FLAGS2_BASIC_HTTP_FUNCTIONS def get_flag(base_url, cc): url = '{}/{cc}/{cc}.gif'.format(base_url, cc=cc.lower()) resp = requests.get(url) if resp.status_code != 200: resp.raise_for_status() return resp.content def download_one(cc, base_url, verbose=False): try: image = get_flag(base_url, cc) except requests.exceptions.HTTPError as exc: res = exc.response if res.status_code == 404: status = HTTPStatus.not_found msg = 'not found' else: raise else: save_flag(image, cc.lower() + '.gif') status = HTTPStatus.ok msg = 'OK' if verbose: print(cc, msg) return Result(status, cc) # END FLAGS2_BASIC_HTTP_FUNCTIONS # BEGIN FLAGS2_DOWNLOAD_MANY_SEQUENTIAL def download_many(cc_list, base_url, verbose, max_req): counter = collections.Counter() cc_iter = sorted(cc_list) if not verbose: cc_iter = tqdm.tqdm(cc_iter) for cc in cc_iter: try: res = download_one(cc, base_url, verbose) except requests.exceptions.HTTPError as exc: error_msg = 'HTTP error {res.status_code} - {res.reason}' error_msg = error_msg.format(res=exc.response) except requests.exceptions.ConnectionError as exc: error_msg = 'Connection error' else: error_msg = '' status = res.status if error_msg: status = HTTPStatus.error counter[status] += 1 if verbose and error_msg: print('*** Error for {}: {}'.format(cc, error_msg)) return counter # END FLAGS2_DOWNLOAD_MANY_SEQUENTIAL if __name__ == '__main__': main(download_many, DEFAULT_CONCUR_REQ, MAX_CONCUR_REQ)

Chapter 19: OSCON Schedule Scripts and Tests

Example A-12 is the test script for the schedule1.py module (Example 19-9). It uses the py.test library and test runner.

Example A-12. test_schedule1.py

import shelve import pytest import schedule1 as schedule @pytest.yield_fixture def db(): with shelve.open(schedule.DB_NAME) as the_db: if schedule.CONFERENCE not in the_db: schedule.load_db(the_db) yield the_db def test_record_class(): rec = schedule.Record(spam=99, eggs=12) assert rec.spam == 99 assert rec.eggs == 12 def test_conference_record(db): assert schedule.CONFERENCE in db def test_speaker_record(db): speaker = db['speaker.3471'] assert speaker.name == 'Anna Martelli Ravenscroft' def test_event_record(db): event = db['event.33950'] assert event.name == 'There *Will* Be Bugs' def test_event_venue(db): event = db['event.33950'] assert event.venue_serial == 1449

Example A-13 is the full listing of the schedule2.py example presented in Linked Record Retrieval with Properties in four parts.

Example A-13. schedule2.py

""" schedule2.py: traversing OSCON schedule data >>> import shelve >>> db = shelve.open(DB_NAME) >>> if CONFERENCE not in db: load_db(db) # BEGIN SCHEDULE2_DEMO >>> DbRecord.set_db(db) >>> event = DbRecord.fetch('event.33950') >>> event <Event 'There *Will* Be Bugs'> >>> event.venue <DbRecord serial='venue.1449'> >>> event.venue.name 'Portland 251' >>> for spkr in event.speakers: ... print('{0.serial}: {0.name}'.format(spkr)) ... speaker.3471: Anna Martelli Ravenscroft speaker.5199: Alex Martelli # END SCHEDULE2_DEMO >>> db.close() """ # BEGIN SCHEDULE2_RECORD import warnings import inspect import osconfeed DB_NAME = 'data/schedule2_db' CONFERENCE = 'conference.115' class Record: def __init__(self, **kwargs): self.__dict__.update(kwargs) def __eq__(self, other): if isinstance(other, Record): return self.__dict__ == other.__dict__ else: return NotImplemented # END SCHEDULE2_RECORD # BEGIN SCHEDULE2_DBRECORD class MissingDatabaseError(RuntimeError): """Raised when a database is required but was not set.""" class DbRecord(Record): __db = None @staticmethod def set_db(db): DbRecord.__db = db @staticmethod def get_db(): return DbRecord.__db @classmethod def fetch(cls, ident): db = cls.get_db() try: return db[ident] except TypeError: if db is None: msg = "database not set; call '{}.set_db(my_db)'" raise MissingDatabaseError(msg.format(cls.__name__)) else: # raise def __repr__(self): if hasattr(self, 'serial'): cls_name = self.__class__.__name__ return '<{} serial={!r}>'.format(cls_name, self.serial) else: return super().__repr__() # END SCHEDULE2_DBRECORD # BEGIN SCHEDULE2_EVENT class Event(DbRecord): @property def venue(self): key = 'venue.{}'.format(self.venue_serial) return self.__class__.fetch(key) @property def speakers(self): if not hasattr(self, '_speaker_objs'): spkr_serials = self.__dict__['speakers'] fetch = self.__class__.fetch self._speaker_objs = [fetch('speaker.{}'.format(key)) for key in spkr_serials] return self._speaker_objs def __repr__(self): if hasattr(self, 'name'): cls_name = self.__class__.__name__ return '<{} {!r}>'.format(cls_name, self.name) else: return super().__repr__() # END SCHEDULE2_EVENT # BEGIN SCHEDULE2_LOAD def load_db(db): raw_data = osconfeed.load() warnings.warn('loading ' + DB_NAME) for collection, rec_list in raw_data['Schedule'].items(): record_type = collection[:-1] cls_name = record_type.capitalize() cls = globals().get(cls_name, DbRecord) if inspect.isclass(cls) and issubclass(cls, DbRecord): factory = cls else: factory = DbRecord for record in rec_list: key = '{}.{}'.format(record_type, record['serial']) record['serial'] = key db[key] = factory(**record) # END SCHEDULE2_LOAD

Example A-14 was used to test Example A-13 with py.test.

Example A-14. test_schedule2.py

import shelve import pytest import schedule2 as schedule @pytest.yield_fixture def db(): with shelve.open(schedule.DB_NAME) as the_db: if schedule.CONFERENCE not in the_db: schedule.load_db(the_db) yield the_db def test_record_attr_access(): rec = schedule.Record(spam=99, eggs=12) assert rec.spam == 99 assert rec.eggs == 12 def test_record_repr(): rec = schedule.DbRecord(spam=99, eggs=12) assert 'DbRecord object at 0x' in repr(rec) rec2 = schedule.DbRecord(serial=13) assert repr(rec2) == "<DbRecord serial=13>" def test_conference_record(db): assert schedule.CONFERENCE in db def test_speaker_record(db): speaker = db['speaker.3471'] assert speaker.name == 'Anna Martelli Ravenscroft' def test_missing_db_exception(): with pytest.raises(schedule.MissingDatabaseError): schedule.DbRecord.fetch('venue.1585') def test_dbrecord(db): schedule.DbRecord.set_db(db) venue = schedule.DbRecord.fetch('venue.1585') assert venue.name == 'Exhibit Hall B' def test_event_record(db): event = db['event.33950'] assert repr(event) == "<Event 'There *Will* Be Bugs'>" def test_event_venue(db): schedule.Event.set_db(db) event = db['event.33950'] assert event.venue_serial == 1449 assert event.venue == db['venue.1449'] assert event.venue.name == 'Portland 251' def test_event_speakers(db): schedule.Event.set_db(db) event = db['event.33950'] assert len(event.speakers) == 2 anna_and_alex = [db['speaker.3471'], db['speaker.5199']] assert event.speakers == anna_and_alex def test_event_no_speakers(db): schedule.Event.set_db(db) event = db['event.36848'] assert len(event.speakers) == 0

Python Jargon

Many terms here are not exclusive to Python, of course, but particularly in the definitions you may find meanings that are specific to the Python community.

Also see the official Python glossary.

ABC (programming language)

A programming language created by Leo Geurts, Lambert Meertens, and Steven Pemberton. Guido van Rossum, who developed Python, worked as a programmer implementing the ABC environment in the 1980s. Block structuring by indentation, built-in tuples and dictionaries, tuple unpacking, the semantics of the for loop, and uniform handling of all sequence types are some of the distinctive characteristics of Python that came from ABC.

Abstract base class (ABC)

A class that cannot be instantiated, only subclassed. ABCs are how interfaces are formalized in Python. Instead of inheriting from an ABC, a class may also declare that it fulfills the interface by registering with the ABC to become a virtual subclass.

accessor

A method implemented to provide access to a single data attribute. Some authors use acessor as a generic term encompassing getter and setter methods, others use it to refer only to getters, referring to setters as mutators.

aliasing

Assigning two or more names to the same object. For example, in a = []; b = a the variables a and b are aliases for the same list object. Aliasing happens naturally all the time in any language where variables store references to objects. To avoid confusion, just forget the idea that variables are boxes that hold objects (an object can’t be in two boxes at the same time). It’s better to think of them as labels attached to objects (an object can have more than one label).

argument

An expression passed to a function when it is called. In Pythonic parlance, argument and parameter are almost always synonyms. See parameter for more about the distinction and usage of these terms.

attribute

Methods and data attributes (i.e.,「fields」in Java terms) are all known as attributes in Python. A method is just an attribute that happens to be a callable object (usually a function, but not necessarily).

BDFL

Benevolent Dictator For Life, alias for Guido van Rossum, creator of the Python language.

binary sequence

Generic term for sequence types with byte elements. The built-in binary sequence types are byte, bytearray, and memoryview.

BOM

Byte Order Mark, a sequence of bytes that may be present at the start of a UTF-16 encoded file. A BOM is the character U+FEFF (ZERO WIDTH NO-BREAK SPACE) encoded to produce either b'\xfe\xff' on a big-endian CPU, or b'\xff\xfe' on a little-endian one. Because there is no U+FFFE characer in Unicode, the presence of these bytes unambiguously reveals the byte ordering used in the encoding. Although redundant, a BOM encoded as b'\xef\xbb\xbf' may be found in UTF-8 files.

bound method

A method that is accessed through an instance becomes bound to that instance. Any method is actually a descriptor and when accessed, it returns itself wrapped in an object that binds the method to the instance. That object is the bound method. It can be invoked without passing the value of self. For example, given the assignment my_method = my_obj.method, the bound method can later be called as my_method(). Contrast with unbound method.

built-in function (BIF)

A function bundled with the Python interpreter, coded in the underlying implementation language (i.e., C for CPython; Java for Jython, and so on). The term often refers only to the functions that don’t need to be imported, documented in Chapter 2,「Built-in Functions,」of The Python Standard Library Reference. But built-in modules like sys, math, re, etc. also contain built-in functions.

byte string

An unfortunate name still used to refer to bytes or bytearray in Python 3. In Python 2, the str type was really a byte string, and the term made sense to distinguish str from unicode strings. In Python 3, it makes no sense to insist on this term, and I tried to use byte sequence whenever I needed to talk in general about…byte sequences.

bytes-like object

A generic sequence of bytes. The most common bytes-like types are bytes, bytearray, and memoryview but other objects supporting the low-level CPython buffer protocol also qualify, if their elements are single bytes.

callable object

An object that can be invoked with the call operator (), to return a result or to perform some action. There are seven flavors of callable objects in Python: user-defined functions, built-in functions, built-in methods, instance methods, generator functions, classes, and instances of classes that implement the __call__ special method.

CamelCase

The convention of writing identifiers by joining words with uppercased initials (e.g., ConnectionRefusedError). PEP-8 recommends class names should be written in CamelCase, but the advice is not followed by the Python standard library. See snake_case.

Cheese Shop

Original name of the Python Package Index (PyPI), after the Monty Python skit about a cheese shop where nothing is available. As of this writing, the alias https://cheeseshop.python.org still works. See PyPI.

class

A program construct defining a new type, with data attributes and methods specifying possible operations on them. See type.

code point

An integer in the range 0 to 0x10FFFF used to identify an entry in the Unicode character database. As of Unicode 7.0, less than 3% of all code points are assigned to characters. In the Python documentation, the term may be spelled as one or two words. For example, in Chapter 2,「Built-in Functions,」of the Python Library Reference, the chr function is said to take an integer「codepoint,」while its inverse, ord, is described as returning a「Unicode code point.」

code smell

A coding pattern that suggests there may be something wrong with the design of a program. For example, excessive use of isinstance checks against concrete classes is a code smell, as it makes the program harder to extend to deal with new types in the future.

codec

(encoder/decoder) A module with functions to encode and decode, usually from str to bytes and back, although Python has a few codecs that perform bytes to bytes and str to str transformations.

collection

Generic term for data structures made of items that can be accessed individually. Some collections can contain objects of arbitrary types (see container) and others only objects of a single atomic type (see flat sequence). list and bytes are both collections, but list is a container, and bytes is a flat sequence.

considered harmful

Edsger Dijkstra’s letter titled「Go To Statement Considered Harmful」established a formula for titles of essays criticizing some computer science technique. Wikipedia’s「Considered harmful」article lists several examples, including "Considered Harmful Essays Considered Harmful」by Eric A. Meyer.

constructor

Informally, the __init__ instance method of a class is called its constructor, because its semantics is similar to that of a Java constructor. However, a fitting name for __init__ is initializer, as it does not actually build the instance, but receives it as its self argument. The constructor term better describes the __new__ class method, which Python calls before __init__, and is responsible for actually creating an instance and returning it. See initializer.

container

An object that holds references to other objects. Most collection types in Python are containers, but some are not. Contrast with flat sequence, which are collections but not containers.

context manager

An object implementing both the __enter__ and __exit__ special methods, for use in a with block.

coroutine

A generator used for concurrent programming by receiving values from a scheduler or an event loop via coro.send(value). The term may be used to describe the generator function or the generator object obtained by calling the generator function. See generator.

CPython

The standard Python interpreter, implemented in C. This term is only used when discussing implementation-specific behavior, or when talking about the multiple Python interpreters available, such as PyPy.

CRUD

Acronym for Create, Read, Update, and Delete, the four basic functions in any application that stores records.

decorator

A callable object A that returns another callable object B and is invoked in code using the syntax @A right before the definition of a callable C. When reading such code, the Python interpreter invokes A(C) and binds the resulting B to the variable previously assigned to C, effectively replacing the definition of C with B. If the target callable C is a function, then A is a function decorator; if C is a class, then A is a class decorator.

deep copy

A copy of an object in which all the objects that are attributes of the object are themselves also copied. Contrast with shallow copy.

descriptor

A class implementing one or more of the __get__, __set__, or __delete__ special methods becomes a descriptor when one of its instances is used as a class attribute of another class, the managed class. Descriptors manage the access and deletion of managed attributes in the managed class, often storing data in the managed instances.

docstring

Short for documentation string. When the first statement in a module, class, or function is a string literal, it is taken to be the docstring for the enclosing object, and the interpreter saves it as the __doc__ attribute of that object. See also doctest.

doctest

A module with functions to parse and run examples embedded in the docstrings of Python modules or in plain-text files. May also be used from the command line as:

python -m doctest module_with_tests.py

DRY

Don’t Repeat Yourself—a software engineering principle stating that「Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.」It first appeared in the book The Pragmatic Programmer by Andy Hunt and Dave Thomas (Addison-Wesley, 1999).

duck typing

A form of polymorphism where functions operate on any object that implements the appropriate methods, regardless of their classes or explicit interface declarations.

dunder

Shortcut to pronounce the names of special methods and attributes that are written with leading and trailing double-underscores (i.e., __len__ is read as「dunder len」).

dunder method

See dunder and special methods.

EAFP

Acronym standing for the quote「It’s easier to ask forgiveness than permission,」attributed to computer pioneer Grace Hopper, and quoted by Pythonistas referring to dynamic programming practices like accessing attributes without testing first if they exist, and then catching the exception when that is the case. The docstring for the hasattr function actually says that it works「by calling getattr(object, name) and catching AttributeError.」

eager

An iterable object that builds all its items at once. In Python, a list comprehension is eager. Contrast with lazy.

fail-fast

A systems design approach recommending that errors should be reported as early as possible. Python adheres to this principle more closely than most dynamic languages. For example, there is no「undefined」value: variables referenced before initialization generate an error, and my_dict[k] raises an exception if k is missing (in contrast with JavaScript). As another example, parallel assignment via tuple unpacking in Python only works if every item is explicitly handled, while Ruby silently deals with item count mismatches by ignoring unused items on the right side of the =, or by assigning nil to extra variables on the left side.

falsy

Any value x for which bool(x) returns False; Python implicitly uses bool to evaluate objects in Boolean contexts, such as the expression controlling an if or while loop. The opposite of truthy.

file-like object

Used informally in the official documentation to refer to objects implementing the file protocol, with methods such as read, write, close, etc. Common variants are text files containing encoded strings with line-oriented reading and writing, StringIO instances which are in-memory text files, and binary files, containing unencoded bytes. The latter may be buffered or unbuffered. ABCs for the standard file types are defined in the io module since Python 2.6.

first-class function

Any function that is a first-class object in the language (i.e., can be created at runtime, assigned to variables, passed as an argument, and returned as the result of another function). Python functions are first-class functions.

flat sequence

A sequence type that physically stores the values of its items, and not references to other objects. The built-in types str, bytes, bytearray, memoryview, and array.array are flat sequences. Contrast with list, tuple, and collections.deque, which are container sequences. See container.

function

Strictly, an object resulting from evaluation of a def block or a lambda expression. Informally, the word function is used to describe any callable object, such as methods and even classes sometimes. The official Built-in Functions list includes several built-in classes like dict, range, and str. Also see callable object.

genexp

Short for generator expression.

generator

An iterator built with a generator function or a generator expression that may produce values without necessarily iterating over a collection; the canonical example is a generator to produce the Fibonacci series which, because it is infinite, would never fit in a collection. The term is sometimes used to describe a generator function, besides the object that results from calling it.

generator function

A function that has the yield keyword in its body. When invoked, a generator function returns a generator.

generator expression

An expression enclosed in parentheses using the same syntax of a list comprehension, but returning a generator instead of a list. A generator expression can be understood as a lazy version of a list comprehension. See lazy.

generic function

A group of functions designed to implement the same operation in customized ways for different object types. As of Python 3.4, the functools.singledispatch decorator is the standard way to create generic functions. This is known as multimethods in other languages.

GoF book

Alias for Design Patterns: Elements of Reusable Object-Oriented Software (Addison-Wesley, 1995), authored by the so-called Gang of Four (GoF): Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.

hashable

An object is hashable if it has both __hash__ and __eq__ methods, with the constraints that the hash value must never change and if a == b then hash(a) == hash(b) must also be True. Most immutable built-in types are hashable, but a tuple is only hashable if every one of its items is also hashable.

higher-order function

A function that takes another function as argument, like sorted, map, and filter, or a function that returns a function as result, as Python decorators do.

idiom

「A manner of speaking that is natural to native speakers of a language,」according to the Princeton WordNet.

import time

The moment of initial execution of a module when its code is loaded by the Python interpreter, evaluated from top to bottom, and compiled into bytecode. This is when classes and functions are defined and become live objects. This is also when decorators are executed.

initializer

A better name for the __init__ method (instead of constructor). Initializing the instance received as self is the task of __init__. Actual instance construction is done by the __new__ method. See constructor.

iterable

Any object from which the iter built-in function can obtain an iterator. An iterable object works as the source of items in for loops, comprehensions, and tuple unpacking. Objects implementing an __iter__ method returning an iterator are iterable. Sequences are always iterable; other objects implementing a __getitem__ method may also be iterable.

iterable unpacking

A modern, more precise synonym for tuple unpacking. See also parallel assignment.

iterator

Any object that implements the __next__ no-argument method, which returns the next item in a series, or raises StopIteration when there are no more items. Python iterators also implement the __iter__ method so they are also iterable. Classic iterators, according to the original design pattern, return items from a collection. A generator is also an iterator, but it’s more flexible. See generator.

KISS principle

The acronym stands for「Keep It Simple, Stupid.」This calls for seeking the simplest possible solution, with the fewest moving parts. The phrase was coined by Kelly Johnson, a highly accomplished aerospace engineer who worked in the real Area 51 designing some of the most advanced aircraft of the 20th century.

lazy

An iterable object that produces items on demand. In Python, generators are lazy. Contrast eager.

listcomp

Short for list comprehension.

list comprehension

An expression enclosed in brackets that uses the for and in keywords to build a list by processing and filtering the elements from one or more iterables. A list comprehension works eagerly. See eager.

liveness

An asynchronous, threaded, or distributed system exhibits the liveness property when「something good eventually happens」(i.e., even if some expected computation is not happening right now, it will be completed eventually). If a system deadlocks, it has lost its liveness.

magic method

Same as special method.

managed attribute

A public attribute managed by a descriptor object. Although the managed attribute is defined in the managed class, it operates like an instance attribute (i.e., it usually has a value per instance, held in a storage attribute). See descriptor.

managed class

A class that uses a descriptor object to manage one of its attributes. See descriptor.

managed instance

An instance of a managed class. See managed attribute and descriptor.

metaclass

A class whose instances are classes. By default, Python classes are instances of type, for example, type(int) is the class type, therefore type is a metaclass. User-defined metaclasses can be created by subclassing type.

metaprogramming

The practice of writing programs that use runtime information about themselves to change their behavior. For example, an ORM may introspect model class declarations to determine how to validate database record fields and convert database types to Python types.

monkey patching

Dynamically changing a module, class, or function at runtime, usually to add features or fix bugs. Because it is done in memory and not by changing the source code, a monkey patch only affects the currently running instance of the program. Monkey patches break encapsulation and tend to be tightly coupled to the implementation details of the patched code units, so they are seen as temporary workarounds and not a recommended technique for code integration.

mixin class

A class designed to be subclassed together with one or more additional classes in a multiple-inheritance class tree. A mixin class should never be instantiated, and a concrete subclass of a mixin class should also subclass another nonmixin class.

mixin method

A concrete method implementation provided in an ABC or in a mixin class.

mutator

See accessor.

name mangling

The automatic renaming of private attributes from __x to _MyClass__x, performed by the Python interpreter at runtime.

nonoverriding descriptor

A descriptor that does not implement __set__ and therefore does not interfere with setting of the managed attribute in the managed instance. Consequently, if a namesake attribute is set in the managed instance, it will shadow the descriptor in that instance. Also called nondata descriptor or shadowable descriptor. Contrast with overriding descriptor.

ORM

Object-Relational Mapper—an API that provides access to database tables and records as Python classes and objects, providing method calls to perform database operations. SQLAlchemy is a popular standalone Python ORM; the Django and Web2py frameworks have their own bundled ORMs.

overriding descriptor

A descriptor that implements __set__ and therefore intercepts and overrides attempts at setting the managed attribute in the managed instance. Also called data descriptor or enforced descriptor. Contrast with non-overriding descriptor.

parallel assignment

Assigning to several variables from items in an iterable, using syntax like a, b = [c, d]—also known as destructuring assignment. This is a common application of tuple unpacking.

parameter

Functions are declared with 0 or more「formal parameters,」which are unbound local variables. When the function is called, the arguments or「actual parameters」passed are bound to those variables. In this book, I tried to use argument to refer to an actual parameter passed to a function, and parameter for a formal parameter in the function declaration. However, that is not always feasible because the terms parameter and argument are used interchangeably all over the Python docs and API. See argument.

prime (verb)

Calling next(coro) on a coroutine to advance it to its first yield expression so that it becomes ready to receive values in succeeding coro.send(value) calls.

PyPI

The Python Package Index, where more than 60,000 packages are available, also known as the Cheese shop (see Cheese shop). PyPI is pronounced as「pie-P-eye」to avoid confusion with PyPy.

PyPy

An alternative implementation of the Python programming language using a toolchain that compiles a subset of Python to machine code, so the interpreter source code is actually written in Python. PyPy also includes a JIT to generate machine code for user programs on the fly—like the Java VM does. As of November 2014, PyPy is 6.8 times faster than CPython on average, according to published benchmarks. PyPy is pronounced as「pie-pie」to avoid confusion with PyPI.

Pythonic

Used to praise idiomatic Python code, that makes good use of language features to be concise, readable, and often faster as well. Also said of APIs that enable coding in a way that seems natural to proficient Python programmers. See idiom.

refcount

The reference counter that each CPython object keeps internally in order to determine when it can be destroyed by the garbage collector.

referent

The object that is the target of a reference. This term is most often used to discuss weak references.

REPL

Read-eval-print loop, an interactive console, like the standard python or alternatives like ipython, bpython, and Python Anywhere.

sequence

Generic name for any iterable data structure with a known size (e.g., len(s)) and allowing item access via 0-based integer indexes (e.g., s[0]). The word sequence has been part of the Python jargon from the start, but only with Python 2.6 was it formalized as an abstract class in collections.abc.Sequence.

serialization

Converting an object from its in-memory structure to a binary or text-oriented format for storage or transmission, in a way that allows the future reconstruction of a clone of the object on the same system or on a different one. The pickle module supports serialization of arbitrary Python objects to a binary format.

shallow copy

A copy of an object which shares references to all the objects that are attributes of the original object. Contrast with deep copy. Also see aliasing.

singleton

An object that is the only existing instance of a class—usually not by accident but because the class is designed to prevent creation of more than one instance. There is also a design pattern named Singleton, which is a recipe for coding such classes. The None object is a singleton in Python.

slicing

Producing a subset of a sequence by using the slice notation, e.g., my_sequence[2:6]. Slicing usually copies data to produce a new object; in particular, my_sequence[:] creates a shallow copy of the entire sequence. But a memoryview object can be sliced to produce a new memoryview that shares data with the original object.

snake_case

The convention of writing identifiers by joining words with the underscore character (_)—for example, run_until_complete. PEP-8 calls this style「lowercase with words separated by underscores」and recommends it for naming functions, methods, arguments, and variables. For packages, PEP-8 recommends concatenating words with no separators. The Python standard library has many examples of snake_case identifiers, but also many examples of identifiers with no separation between words (e.g., getattr, classmethod, isinstance, str.endswith, etc.). See CamelCase.

special method

A method with a special name such as __getitem__, spelled with leading and trailing double underscores. Almost all special methods recognized by Python are described in the「Data model」chapter of The Python Language Reference, but a few that are used only in specific contexts are documented in other parts of the documentation. For example, the __missing__ method of mappings is mentioned in「4.10. Mapping Types — dict" in The Python Standard Library.

storage attribute

An attribute in a managed instance used to store the value of an attribute managed by a descriptor. See also managed attribute.

strong reference

A reference that keeps an object alive in Python. Contrast with weak reference.

tuple unpacking

Assigning items from an iterable object to a tuple of variables (e.g., first, second, third == my_list). This is the usual term used by Pythonistas, but iterable unpacking is gaining traction.

truthy

Any value x for which bool(x) returns True; Python implicitly uses bool to evaluate objects in Boolean contexts, such as the expression controlling an if or while loop. The opposite of falsy.

type

Each specific category of program data, defined by a set of possible values and operations on them. Some Python types are close to machine data types (e.g., float and bytes) while others are extensions (e.g., int is not limited to CPU word size, str holds multibyte Unicode data points) and very high-level abstractions (e.g., dict, deque, etc.). Types may be user defined or built into the interpreter (a「built-in」type). Before the watershed type/class unification in Python 2.2, types and classes were different entities, and user-defined classes could not extend built-in types. Since then, built-in types and new-style classes became compatible, and a class is an instance of type. In Python 3 all classes are new-style classes. See class and metaclass.

unbound method

An instance method accessed directly on a class is not bound to an instance; therefore it’s said to be an「unbound method.」To succeed, a call to an unbound method must explicitly pass an instance of the class as the first argument. That instance will be assigned to the self argument in the method. See bound method.

uniform access principle

Bertrand Meyer, creator of the Eiffel Language, wrote:「All services offered by a module should be available through a uniform notation, which does not betray whether they are implemented through storage or through computation.」Properties and descriptors allow the implementation of the uniform access principle in Python. The lack of a new operator, making function calls and object instantiation look the same, is another form of this principle: the caller does not need to know whether the invoked object is a class, a function, or any other callable.

user-defined

Almost always in the Python docs the word user refers to you and I—programmers who use the Python language—as opposed to the developers who implement a Python interpreter. So the term「user-defined class」means a class written in Python, as opposed to built-in classes written in C, like str.

view

Python 3 views are special data structures returned by the dict methods .keys(), .values(), and .items(), providing a dynamic view into the dict keys and values without data duplication, which occurs in Python 2 where those methods return lists. All dict views are iterable and support the in operator. In addition, if the items referenced by the view are all hashable, then the view also implements the collections.abc.Set interface. This is the case for all views returned by the .keys() method, and for views returned by .items() when the values are also hashable.

virtual subclass

A class that does not inherit from a superclass but is registered using TheSuperClass.register(TheSubClass). See documentation for abc.ABCMeta.register.

wart

A misfeature of the language. Andrew Kuchling’s famous post「Python warts」has been acknowledged by the BDFL as influential in the decision to break backward-compatibility in the design of Python 3, as most of the failings could not be fixed otherwise. Many of Kuchling’s issues were fixed in Python 3.

weak reference

A special kind of object reference that does not increase the referent object reference count. Weak references are created with one of the functions and data structures in the weakref module.

YAGNI

「You Ain’t Gonna Need It,」a slogan to avoid implementing functionality that is not immediately necessary based on assumptions about future needs.

Zen of Python

Type import this into any Python console since version 2.2.

Index

Symbols

!= operator, Rich Comparison Operators

!r conversion field, String Representation

# operator, Why len Is Not a Method

% operator, String Representation

%r placeholder, String Representation

() (function invocation), Operator Overloading: Doing It Right

() (parentheses), List Comprehensions and Readability, The Seven Flavors of Callable Objects

() call operator, The Seven Flavors of Callable Objects

* operator, Emulating Numeric Types, Arithmetic Operators, Using * to grab excess items, Using + and * with Sequences, From Positional to Keyword-Only Parameters, Overloading * for Scalar Multiplication

** (double asterisk), From Positional to Keyword-Only Parameters

*= operator, Augmented Assignment with Sequences, Augmented Assignment Operators

*args, Using * to grab excess items

*extra, Further Reading

+ operator, Emulating Numeric Types, Arithmetic Operators, Using + and * with Sequences, Unary Operators, Overloading + for Vector Addition–Overloading + for Vector Addition

+= operator, Augmented Assignment with Sequences, Augmented Assignment Operators

+ELLIPSIS directive, A Pythonic Card Deck

+x, Unary Operators

. (attribute access), Operator Overloading: Doing It Right

.add_done_callback() method, Where Are the Futures?

.append method, Deques and Other Queues

.done() method, Where Are the Futures?

.frombytes method, An Alternative Constructor

.pop method, Deques and Other Queues

.result() method, Where Are the Futures?

2D vector addition, Emulating Numeric Types

404 errors (Not Found), Error Handling in the flags2 Examples

< operator, Rich Comparison Operators

<= operator, Rich Comparison Operators

== operator, Choosing Between == and is, Further Reading, Vector Take #4: Hashing and a Faster ==, Rich Comparison Operators

> operator, Rich Comparison Operators

>= operator, Rich Comparison Operators

@ operator, Overloading * for Scalar Multiplication

@abstractclassmethod, ABC Syntax Details

@abstractmethod, Defining and Using an ABC

@abstractproperty, ABC Syntax Details

@abstractstaticmethod, ABC Syntax Details

@asyncio.coroutine decorator, Thread Versus Coroutine: A Comparison, Thread Versus Coroutine: A Comparison

@classmethod decorator, Flexible Object Creation with __new__

@contextmanager decorator, The contextlib Utilities

@property decorator, Using a Property for Attribute Validation

[:] operator, Copies Are Shallow by Default

[] (square brackets), A Pythonic Card Deck, List Comprehensions and Readability, Multidimensional Slicing and Ellipsis, Operator Overloading: Doing It Right

\ (backslash), List Comprehensions and Readability

^ operator, A Hashable Vector2d, Vector Take #4: Hashing and a Faster ==

_ (underscore), Tuple Unpacking, Private and「Protected」Attributes in Python

__ (double underscore), The Python Data Model, The Python Data Model

__add__, Augmented Assignment with Sequences, Interfaces and Protocols in Python Culture, Overloading + for Vector Addition, Augmented Assignment Operators

__bool__, Boolean Value of a Custom Type

__builtins__, Dictionaries and Sets

__bytes__, Object Representations

__call__, User-Defined Callable Types

__class__, Special Attributes that Affect Attribute Handling

__delattr__, Handling Attribute Deletion, Special Methods for Attribute Handling

__delete__, Attribute Descriptors

__del__, del and Garbage Collection

__dict__, Dictionaries and Sets, Function Introspection, Special Attributes that Affect Attribute Handling

__doc__, Treating a Function Like an Object, Function Introspection

__enter__, Context Managers and with Blocks

__eq__, Rich Comparison Operators

__exit__, Context Managers and with Blocks

__float__, A Hashable Vector2d

__format__, Object Representations, Formatted Displays, Vector Take #5: Formatting, Further Reading

__getattribute__, Special Methods for Attribute Handling

__getattr__, Vector Take #3: Dynamic Attribute Access, Special Methods for Attribute Handling

__getitem__, A Pythonic Card Deck, defaultdict: Another Take on Missing Keys, A Slice-Aware __getitem__, Interfaces and Protocols in Python Culture, Python Digs Sequences

__get__, Attribute Descriptors

__hash__, Hashes and equality, A Hashable Vector2d, Vector Take #4: Hashing and a Faster ==

__iadd__, Augmented Assignment with Sequences, Augmented Assignment Operators

__imatmul__, Overloading * for Scalar Multiplication

__init__, Sentence Take #4: A Lazy Implementation, Flexible Object Creation with __new__, Metaclasses 101

__int__, A Hashable Vector2d

__invert__, Unary Operators

__iter__, Why Sequences Are Iterable: The iter Function, Iterables Versus Iterators, Sentence Take #2: A Classic Iterator

__len__, A Pythonic Card Deck, Why len Is Not a Method, A Slice-Aware __getitem__

