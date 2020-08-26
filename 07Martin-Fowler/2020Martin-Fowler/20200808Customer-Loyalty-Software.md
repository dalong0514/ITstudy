# Customer Loyalty Software

[CustomerLoyaltySoftware](https://martinfowler.com/bliki/CustomerLoyaltySoftware.html)

4 September 2007

Martin Fowler

DOMAIN DRIVEN DESIGN

I was in the Calgary office last week and had a good chat with John Kordyback, one of our most trusted technical leads. He's worked on, and dug into, a number of travel loyalty software systems (frequent flyer/sleeper etc) and we talked about the nature of these kinds of things and how to think about them in a more fruitful manner.

The core of of a loyalty system is a system to keep track of points (or miles). This should allow customers to see their points and also for the company to manage the unredeemed points. Although it seems that most people don't see it this way, this is essentially an accounting system, just switching points for dollars. John's observation was that repeatedly he runs into what people see as difficult problems that are much easier to deal with once you put accounting spectacles on.

An example of this is dealing with ad-hoc changes. However good your automated rules processing is, there always cases when something odd happens and you have to intervene manually. The result for many systems is and ad hoc change to totals that is error prone and unaudited. With an accounting frame of mind, however, you look at these changes as accounting adjustments and the patterns for this are well understood.

A notable difference between a loyalty program and most accounting systems is that a loyalty program is more about managing liabilities rather than managing assets. Hence there's more focus on things like risk management, as well as common themes like taxes and revenue reporting.

Many loyalty systems have multiple kinds of points, such as such as regular miles and elite qualifying miles. This is a common point of complexity. If you use an accounting viewpoint, however, you can track these easily as multiple currencies.

An interesting twist on this is potential points. If I book a flight for next month, the airline needs to know that there are miles I will earn when I fly next month (potential miles). These potential miles affect their liabilities. However it's only when I fly that they turn into real miles. Again accounting thinking can help here, we can use multiple currencies again, or use an accounts payable notion. The mechanisms are there and well understood, we just have to apply the model to the situation.

We fleshed this out in practice where we also found it really helpful to use TestDrivenDevelopment. A group of people spent a couple of weeks trying to sort out potential miles with planned design, but the core issue was cracked in a couple of days with TDD. The crucial part of this was focusing on examples to make the problem concrete.

The accounting analogy also applies, although partly less directly, to deciding how to award miles for activity. Any program has activity rules that need to be very flexible and need to cope with constant changes to the loyalty program. We can look at this as following the model of domain events triggering accounting entries through using Agreement Dispatchers. This is a pattern John and I have used lots of times and works well to these kinds of changing rules. Essentially we have agreements that represent the overall program rules for a class of participant. Each agreement consists of a set of posting rules keyed by the type of event and a date range. When an domain event occurs (a hotel stay) we look up the agreement dispatcher for the customer, and use the event to look up the right posting rule. We then run the posting rule to create the appropriate accounting entries to represent the miles for the event. The time dating of the events allow us to change posting rules over time but still be able to handle old events and correctly do automated processing of adjustments. (Some day I'll finish writing up these patterns, but what I have on the web is hopefully enough to give you some ideas.)

The second aspect of a loyalty system is tracking the customer experience. Since the accounting requires the system to record the customer's activity, the loyalty system acts as a natural base to learn from the customer's interactions with the company. Much of this is data mining - looking for patterns in customer behavior which can lead to new products and promotions. You can also use this activity history to assess the success of promotions - if you offer a mileage bonus for flying a route what is the response like?

Like me, John is a strong proponent of using ReportingDatabases, and this is a good fit for this kind of problem. The accounting side needs a very different set of data structures and uses regular updates as activities occur. The customer experience analysis is all read only, so you can use less normalized structures with regular, but not necessarily real time, feeds from the accounting side.

Taking it further, it seems reasonable to completely decouple the accounting and customer experience systems. They are both usually lodged together as a single customer loyalty system because they track the same events. Yet since they differ so much on the inside it may make more sense to treat them as two separate systems that feed off the same event stream (the accounting side would probably generate some events for the customer experience side too).

One of the habits of customer experience tracking is frequent changes to the system to support new kinds of analysis. We speculated that we could try an approach that had a single stored event log of customer activity, and plug in relatively independent 'miners' that would transform selected information from the log into more particular data structures to do different kinds of analysis. The miners could be relatively independent of each other and thus easier to build.

As you can see, our discussion did shift from looking at John's experiences to some of our joint speculations about how a system like this could be built in the future. What's clear to us is that there is a lot of room for exploring new ideas in this space that could introduce a new set of abstractions that would lead to systems that can provide better support to this business activity. More and more attention is being paid to this these days, so this seems like a fruitful territory for us to work in.