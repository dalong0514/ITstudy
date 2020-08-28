# EvansClassification

14 December 2005

[EvansClassification](https://martinfowler.com/bliki/EvansClassification.html)

Photo of Martin Fowler

Martin Fowler

DOMAIN DRIVEN DESIGN

In his excellent book Domain Driven Design, Eric Evans creates a classification of the different kinds of domain objects that you're likely to run into.

Entity: Objects that have a distinct identity that runs through time and different representations. You also hear these called "reference objects".
Value Object: Objects that matter only as the combination of their attributes. Two value objects with the same values for all their attributes are considered equal. I also describe value objects in P of EAA.
Service: A standalone operation within the context of your domain. A Service Object collects one or more services into an object. Typically you will have only one instance of each service object type within your execution context.
This classification is something that resonates well with my experience of what you need in domain models. The trouble is that the trio are hard to define precisely, they are of the "I know them when I see them" category.

As such some examples may help. Entities are usually big things like Customer, Ship, Rental Agreement. Values are usually little things like Date, Money, Database Query. Services are usually accesses to external resources like Database Connection, Messaging Gateway, Repository, Product Factory.

One clear division between entities and values is that values override the equality method (and thus hash) while entities usually don't. This is because you usually don't want to have more than one object representing the same conceptual entity within your processing context, however you don't care about multiple "5.0" objects. Values may be primitives (in languages that make the distinction) or have special language support (as they do in .NET) but they don't have to. One important rule to follow is that value objects should be immutable (otherwise you get into all sorts of trouble with aliasing bugs). To change a value (such as my height) you don't change the height object, you replace it with a new one.

Service objects are often implemented by using global variables, class fields (monostates in Robert Martin's terminology) or singletons. Certainly they are usually singular, in that you only have one of them, but how you do that is more varied. Usually the singularity is within a processing context - so one per thread in a multi-threaded environment. In any case you should ensure that your implementation mechanism is hidden from other domain objects so you can easily change it. Eric states in his book that services should be stateless, although we've talked about that and he no longer thinks that is necessary - although it's nice if you can do it.

One of the problems with this area is that this terminology, although evocative, gets terribly muddled up with other ideas. Entity is often used to represent a database table or an object that corresponds to a database table. Service has the whole Service Oriented Architecture thing going on, as well as service layers in application architecture. So if I use these terms I have to make it clear I'm using them within the context of Domain Models and according to their meaning within Eric's book. So be wary of assuming people are using these words like this - they are heavily overloaded. Sadly there's not much alternative.


© Martin Fowler | Privacy Policy | Disclosures