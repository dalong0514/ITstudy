# Value Object

14 November 2016

[ValueObject](https://martinfowler.com/bliki/ValueObject.html)

Martin Fowler

DOMAIN DRIVEN DESIGN

API DESIGN

When programming, I often find it's useful to represent things as a compound. A 2D coordinate consists of an x value and y value. An amount of money consists of a number and a currency. A date range consists of start and end dates, which themselves can be compounds of year, month, and day.

As I do this, I run into the question of whether two compound objects are the same. If I have two point objects that both represent the Cartesian coordinates of (2,3), it makes sense to treat them as equal. Objects that are equal due to the value of their properties, in this case their x and y coordinates, are called value objects.

But unless I'm careful when programming, I may not get that behavior in my programs

Say I want to represent a point in JavaScript.

const p1 = {x: 2, y: 3};
const p2 = {x: 2, y: 3};
assert(p1 !== p2);  // NOT what I want
Sadly that test passes. It does so because JavaScript tests equality for js objects by looking at their references, ignoring the values they contain.

In many situations using references rather than values makes sense. If I'm loading and manipulating a bunch of sales orders, it makes sense to load each order into a single place. If I then need to see if the Alice's latest order is in the next delivery, I can take the memory reference, or identity, of Alice's order and see if that reference is in the list of orders in the delivery. For this test, I don't have to worry about what's in the order. Similarly I might rely on a unique order number, testing to see if Alice's order number is on the delivery list.

Therefore I find it useful to think of two classes of object: value objects and reference objects, depending on how I tell them apart [1]. I need to ensure that I know how I expect each object to handle equality and to program them so they behave according to my expectations. How I do that depends on the programming language I'm working in.

Some languages treat all compound data as values. If I make a simple compound in Clojure, it looks like this.

> (= {:x 2, :y 3} {:x 2, :y 3})
true
That's the functional style - treating everything as immutable values.

But if I'm not in a functional language, I can still often create value objects. In Java for example, the default point class behaves how I'd like.

assertEquals(new Point(2, 3), new Point(2, 3)); // Java
The way this works is that the point class overrides the default equals method with the tests for the values. [2] [3]

I can do something similar in JavaScript.

class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  equals (other) {
    return this.x === other.x && this.y === other.y;
  }
}
const p1 = new Point(2,3);
const p2 = new Point(2,3);
assert(p1.equals(p2));
The problem with JavaScript here is that this equals method I defined is a mystery to any other JavaScript library.

const somePoints = [new Point(2,3)];
const p = new Point(2,3);
assert.isFalse(somePoints.includes(p)); // not what I want

//so I have to do this
assert(somePoints.some(i => i.equals(p)));
This isn't an issue in Java because Object.equals is defined in the core library and all other libraries use it for comparisons (== is usually used only for primitives).

One of the nice consequences of value objects is that I don't need to care about whether I have a reference to the same object in memory or a different reference with an equal value. However if I'm not careful that happy ignorance can lead to a problem, which I'll illustrate with a bit of Java.

Date retirementDate = new Date(Date.parse("Tue 1 Nov 2016"));

// this means we need a retirement party
Date partyDate = retirementDate;

// but that date is a Tuesday, let's party on the weekend
partyDate.setDate(5);

assertEquals(new Date(Date.parse("Sat 5 Nov 2016")), retirementDate);
// oops, now I have to work three more days :-(
This is an example of an Aliasing Bug, I change a date in one place and it has consequences beyond what I expected [4]. To avoid aliasing bugs I follow a simple but important rule: value objects should be immutable. If I want to change my party date, I create a new object instead.

Date retirementDate = new Date(Date.parse("Tue 1 Nov 2016"));
Date partyDate = retirementDate;

// treat date as immutable
partyDate = new Date(Date.parse("Sat 5 Nov 2016"));

// and I still retire on Tuesday
assertEquals(new Date(Date.parse("Tue 1 Nov 2016")), retirementDate);
Of course, it makes it much easier to treat value objects as immutable if they really are immutable. With objects I can usually do this by simply not providing any setting methods. So my earlier JavaScript class would look like this: [5]

class Point {
  constructor(x, y) {
    this._data = {x: x, y: y};
  }
  get x() {return this._data.x;}
  get y() {return this._data.y;}
  equals (other) {
    return this.x === other.x && this.y === other.y;
  }
}
While immutability is my favorite technique to avoid aliasing bugs, it's also possible to avoid them by ensuring assignments always make a copy. Some languages provide this ability, such as structs in C#.

Whether to treat a concept as a reference object or value object depends on your context. In many situations it's worth treating a postal address as a simple structure of text with value equality. But a more sophisticated mapping system might link postal addresses into a sophisticated hierarchic model where references make more sense. As with most modeling problems, different contexts lead to different solutions. [6]

It's often a good idea to replace common primitives, such as strings, with appropriate value objects. While I can represent a telephone number as a string, turning into a telephone number object makes variables and parameters more explicit (with type checking when the language supports it), a natural focus for validation, and avoiding inapplicable behaviors (such as doing arithmetic on integer id numbers).

Small objects, such as points, monies, or ranges, are good examples of value objects. But larger structures can often be programmed as value objects if they don't have any conceptual identity or don't need share references around a program. This is a more natural fit with functional languages that default to immutability. [7]

I find that value objects, particularly small ones, are often overlooked - seen as too trivial to be worth thinking about. But once I've spotted a good set of value objects, I find I can create a rich behavior over them. For taste of this try using a Range class and see how it prevents all sorts of duplicate fiddling with start and end attributes by using richer behaviors. I often run into code bases where domain-specific value objects like this can act as a focus for refactoring, leading to a drastic simplification of a system. Such a simplification often surprises people, until they've seen it a few times - by then it is a good friend.

Acknowledgements
James Shore, Beth Andres-Beck, and Pete Hodgson shared their experiences of using value objects in JavaScript.

Graham Brooks, James Birnie, Jeroen Soeters, Mariano Giuffrida, Matteo Vaccari, Ricardo Cavalcanti, and Steven Lowe provided valuable comments on our internal mailing lists.

Further Reading
Vaughn Vernon's description is probably the best in-depth discussion of value objects from a DDD perspective. He covers how to decide between values and entities, implementation tips, and the techniques for persisting value objects.

The term started gaining traction in the early noughties. Two books that talk about them from that time are PoEAA and DDD. There was also some interesting discussion on Ward's Wiki.

One source of terminological confusion is that around the turn of the century some J2EE literature used "value object" for Data Transfer Object. That usage has mostly disappeared by now, but you might run into it.

Notes
1: In Domain-Driven Design the Evans Classification contrasts value objects with entities. I consider entities to be a common form of reference object, but use the term "entity" only within domain models while the reference/value object dichotomy is useful for all code.

2: Strictly this is done in awt.geom.Point2D, which is a superclass of awt.Point

3: Most object comparisons in Java are done with equals - which is itself a bit awkward since I have to remember to use that rather than the equals operator ==. This is annoying, but Java programmers soon get used to it since String behaves the same way. Other OO languages can avoid this - Ruby uses the == operator, but allows it to be overridden.

4: There is robust competition for the worst feature of the pre-Java-8 date and time system - but my vote would be this one. Thankfully we can avoid most of this now with Java 8's java.time package

5: This isn't strictly immutable since a client can manipulate the _data property. But a suitably disciplined team can make it immutable in practice. If I was concerned that a team wouldn't be disciplined enough I might use freeze. Indeed I could just use freeze on a simple JavaScript object, but I prefer the explicitness of a class with declared accessors.

6: There is more discussion of this in Evans's DDD book.

7: Immutability is valuable for reference objects too - if a sales order doesn't change during a get request, then making it immutable is valuable; and that would make it safe to copy it, if that were useful. But that wouldn't make the sales order be a value object if I'm determining equality based on a unique order number.

Translations: Chinese

© Martin Fowler | Privacy Policy | Disclosures