# Currency As Value

26 August 2003

Photo of Martin Fowler

Martin Fowler

DOMAIN DRIVEN DESIGN

There are many common examples of Value Object, my favorite is Money - and one closely linked to Money is currency.

For many systems currency works well as a value, the key part you need is the internationally recognized currency code (such as USD for US Dollars).

However I was once involved with a system where it got a bit more interesting. If my memory serves me correctly, one of the things they wanted from their currency was a 'pip value'. On their UI they had nudge buttons to nudge the currencies up and down in value. Each currency had its own pip value, and this pip value could change. It didn't change often, but it did change. This violates a very useful rule of value objects - that they are immutable.

The solution we did was to have two currency classes. One was a value object, it held the currency code and maybe a couple of other immutable things. The second was a reference object (I think we called them something like CurrencyValue and CurrencyReference). The value object was passed around most of the time, but some methods in the value object, such as pip value, delegated to the reference object - which was mostly static data. The reference objects were held in a lookup table indexed by the currency code (that's not the only way to do it.)

This bi-semantic behavior is unusual - it's the only time I've seen it. Certainly most systems can get away with a simple value object for currency.
