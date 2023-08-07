# Type Instance Homonym

11 January 2007

Photo of Martin Fowler

Martin Fowler

DOMAIN DRIVEN DESIGN

"'War and Peace' is a wonderful book.

"Let me see... pity this book has such a tattered cover"

Two sentences, each uses the word 'book'. We glance over combinations like this every day without remarking that the word 'book' means something completely different in each of those sentences.

In the first sentence 'book' refers to a literary work, one that's been with us for over a hundred years. In the second sentence 'book' now refers to a physical object that's probably been around for a lot less. I can easily destroy the latter in my fire, but the former isn't touched by my flames and will doubtless last longer than I will. I can put the former on my hard disk with many siblings that collectively weigh less than the latter.

This particular ambiguity is startlingly common in natural language. Think about words like 'car', 'oak', and 'programmer'. Trying to straighten this out can easily lead you into the darker corners of semantics in philosophy. For the moment, I'll just explain how I think about this.

The word 'book' is a term that can refer to multiple concepts. The two sentences above illustrate two concepts that 'book' refers to: the literary work and the physical copy. Since most of my readers are programmers I'll use a programming analogy and say that there are two distinct classes both of which are called 'book'. We can disambiguate them by referring to them as the classes LiteraryWork and PhysicalCopy. When in the first sentence I say that 'War and Peace' is a book, I'm saying that 'War and Peace' is an instance of the class LiteraryWork. The second sentence refers to the properties of an instance of PhysicalCopy.

These two concepts are not independent. Unlike a homonym like right and right (the opposites of left and wrong), these two concepts have a close relationship [1]. A book [PhysicalCopy] carries on it a rendering of the book [LiteraryWork]. So I might say that my War and Peace has a tattered cover. Similarly my Subaru Legacy [instance of physical car] has a relationship with Subaru Legacy [instance of car model]. Indeed we might say that the type of my car is Subaru Legacy [car model]. This kind of relationship is very common and is familiar to people who do any kind of object or data modeling. You often see similar structures involving things like Product and Product Type. I wouldn't use the terms Book and Book Type, but it's fundamentally the same relationship.

Spend time modeling, or programming, in almost any domain and you'll reach a point where you have to take some common term in that domain and realize it denotes two separate concepts which mean separate classes (or tables) with different names in your code. When you get homonyms in your domain language, it's often because the terms are used differently in different contexts - what Eric Evans calls Bounded Contexts. As Jim Odell liked to point out: "Mary had a little lamb" means quite different things to a veterinarian than to a restaurateur. The trouble with the type-instance homonym is that it occurs even within very tight bounded contexts.

My purpose here isn't to talk much further about modeling these kind of situations, that's quite a topic on its own, but to reflect on the ambiguity that this common type of homonym causes. The really interesting thing about this ambiguity is how little trouble it causes. Humans seem to have no trouble at all switching between the multiple concepts and only rarely getting tripped up in the process. What's worse, if you actively try to use different terms in everyday conversation, it's nearly impossible to keep it up. I certainly tried, both in conversation and writing and quickly realized it was a lost cause. Not just did I not have the discipline but it made me sound like someone with some obscure mental condition. (The type-instance case isn't the only one with this property, as the phrase "go through the door we painted last week" suggests.)

There's a particularly fascinating case of this in my own specialty of object-oriented design. We often talk about things like "add a method to an object". Yet, of course, we don't add methods to objects, we add them to classes. At some point in your career you've been the pedant who's pointed that out in a meeting. You've also effortlessly glossed over that point in countless conversations since.

So I came to the conclusion that we absolutely have to be aware of this homonym. We need to represent the concepts separately and with different names in our software. But we shouldn't expect to make a distinction between them in our conversation unless we're in a context where there is a real danger of confusion, because most of the time our brains resolve the ambiguity automatically.

So what does this mean in the context of a UbiquitousLanguage? Firstly we have to do the modeling and realize we have different concepts (aware of the homonym). We then come up with names for the different concepts that we'll use in our Ubiquitous Language and thus in the software representation. When coming up with these names, I like to avoid the bare homonym: so I wouldn't use "book" in the library context, preferring something like 'Literary Work' and 'Physical Copy'. These disambiguating terms need to be comprehensible to the domain experts, as with anything else in the Ubiquitous Language. Therefore the domain experts need to be aware of the homonym and help come up with the new terms. We then use the new terms whenever we need the precision we gain. However we should be wary of trying to completely exorcise the homonym. It effectively becomes a synonym for each of the new terms. So if a domain person says "a book has authors" we might say "you mean a literary work there, right?" Remember that it will feel unnatural to everyone to not use the homonym term, so apply the precision with a light touch. Fortunately awareness is 90% of the battle here.

A further consequence of this homonym is that you should always have your antenna scanning for it - particularly in the early days of working in a new domain. Usually it occurs in terms that are absolutely central to that domain - as with books and libraries. I've liked using informal class diagrams to model a ubiquitous language and I've found it does a good job of rooting out these kinds of homonyms.

Notes
1: Jim White emailed me to let me know that in Linguistics, the term "polysemy" is sometimes used to indicate a word that has different, but related, meanings.

reposted on 19 Mar 2013


© Martin Fowler | Privacy Policy | Disclosures