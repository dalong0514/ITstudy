# TestCoverage

17 April 2012

Martin Fowler

[testing](https://martinfowler.com/tags/testing.html)

[metrics](https://martinfowler.com/tags/metrics.html)

From time to time I hear people asking what value of test coverage (also called code coverage) they should aim for, or stating their coverage levels with pride. Such statements miss the point. Test coverage is a useful tool for finding untested parts of a codebase. Test coverage is of little use as a numeric statement of how good your tests are.

Let's look at the second statement first. I've heard of places that may say things like "you can't go into production with less than 87% coverage". I've heard some people say that you should use things like TDD and must get 100% coverage. A wise man once said:

I expect a high level of coverage. Sometimes managers require one. There's a subtle difference.

—— Brian Marick

If you make a certain level of coverage a target, people will try to attain it. The trouble is that high coverage numbers are too easy to reach with low quality testing. At the most absurd level you have AssertionFreeTesting. But even without that you get lots of tests looking for things that rarely go wrong distracting you from testing the things that really matter.

[AssertionFreeTesting](https://martinfowler.com/bliki/AssertionFreeTesting.html)

Like most aspects of programming, testing requires thoughtfulness. TDD is a very useful, but certainly not sufficient, tool to help you get good tests. If you are testing thoughtfully and well, I would expect a coverage percentage in the upper 80s or 90s. I would be suspicious of anything like 100% — it would smell of someone writing tests to make the coverage numbers happy, but not thinking about what they are doing.

The reason, of course, why people focus on coverage numbers is because they want to know if they are testing enough. Certainly low coverage numbers, say below half, are a sign of trouble. But high numbers don't necessarily mean much, and lead to ignorance-promoting dashboards. Sufficiency of testing is much more complicated attribute than coverage can answer. I would say you are doing enough testing if the following is true:

1 You rarely get bugs that escape into production, and

2 You are rarely hesitant to change some code for fear it will cause production bugs.

Can you test too much? Sure you can. You are testing too much if you can remove tests while still having enough. But this is a difficult thing to sense. One sign you are testing too much is if your tests are slowing you down. If it seems like a simple change to code causes excessively long changes to tests, that's a sign that there's a problem with the tests. This may not be so much that you are testing too many things, but that you have duplication in your tests.

Some people think that you have too many tests if they take too long to run. I'm less convinced by this argument. You can always move slow tests to a later stage in your deployment pipeline, or even pull them out of the pipeline and run them periodically. Doing these things will slow down the feedback from those tests, but that's part of the trade-off of build times versus test confidence.

So what is the value of coverage analysis again? Well it helps you find which bits of your code aren't being tested. [1] It's worth running coverage tools every so often and looking at these bits of untested code. Do they worry you that they aren't being tested?

If a part of your test suite is weak in a way that coverage can detect, it's likely also weak in a way coverage can't detect.

—— Brian Marick

Further Reading: Brian Marick has an excellent article on the misuse of code coverage. And it's worth reading the pithy commentary of Testivus.

1: By "you" here I mean the people writing the tests. Coverage is of little value to management since you need a technical background to understand whether the tests are good or whether the uncovered code is a problem.

2『已下载「202105附件01How-to-Misuse-Code-Coverage」作为本专栏的附件。』

3『

[AssertionFreeTesting](https://martinfowler.com/bliki/AssertionFreeTesting.html)

AssertionFreeTesting

3 August 2004

Here's a story from a friend of a friend. I'm sure it must be true, at least somewhere.

A project got started to do a big system. It was outsourced to a big software/consultancy house — one I know you've heard of. They put in an impressive team for the bid, and naturally swapped them all out for a lot of junior people for the actual work. All standard procedure.

The twist is that the company made a big point of using heavy testing with JUnit. Every public method had to have JUnit tests. They proudly showed the client all the tests and the green bar. 

However there weren't any assertions in the JUnit tests. I don't know if they did code coverage analysis on this project, but of course you can do this and have 100% code coverage — which is one reason why you have to be careful on interpreting code coverage data.[1]

1: Although assertion-free testing is mostly a joke, it isn't entirely useless. As Carlos Villela reminded me, some faults do show up through code execution, eg null pointer exceptions.

』