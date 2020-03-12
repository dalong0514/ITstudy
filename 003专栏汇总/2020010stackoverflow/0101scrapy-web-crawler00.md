搜索关键词：[scrapy] [web-crawler]

Scrapy - Reactor not Restartable [duplicate]

8-Bit Borges

[Scrapy - Reactor not Restartable [duplicate]](https://stackoverflow.com/questions/41495052/scrapy-reactor-not-restartable)

with:I've always ran this process sucessfully:but since I've moved this code into a web_crawler(self) function, like so:and started calling the method using class instantiation, like:and running:I am getting the following error:what is wrong?

2017-01-05 21:32:14Z

with:I've always ran this process sucessfully:but since I've moved this code into a web_crawler(self) function, like so:and started calling the method using class instantiation, like:and running:I am getting the following error:what is wrong?You cannot restart the reactor, but you should be able to run it more times by forking a separate process:Run it twice:Result:This is what helped for me to win the battle against ReactorNotRestartable error: last answer from the author of the question

0) pip install crochet

1) import from crochet import setup

2) setup() - at the top of the file

3) remove 2 lines:

a) d.addBoth(lambda _: reactor.stop())

b) reactor.run()



I had the same problem with this error, and spend 4+ hours to solve this problem, read all questions here about it. Finally found that one - and share it. That is how i solved this. The only meaningful lines from Scrapy docs left are 2 last lines in this my code:This code allows me to select what spider to run just with its name passed to run_spider function and after scrapping finishes - select another spider and run it again. 

Hope this will help somebody, as it helped for me :)As per the Scrapy documentation, the start() method of the CrawlerProcess class does the following:The error you are receiving is being thrown by Twisted, because a Twisted reactor cannot be restarted.  It uses a ton of globals, and even if you do jimmy-rig some sort of code to restart it (I've seen it done), there's no guarantee it will work.  Honestly, if you think you need to restart the reactor, you're likely doing something wrong.Depending on what you want to do, I would also review the Running Scrapy from a Script portion of the documentation, too.The mistake is in this code:web_crawler() returns two results, and for that purpose it is trying to start the process twice, restarting the Reactor, as pointed by @Rejected.obtaining results running one single process, and storing both results in a tuple, is the way to go here:This solved my problem,put below code after reactor.run() or process.start():As some people pointed out already: You shouldn't need to restart the reactor.Ideally if you want to chain your processes (crawl1 then crawl2 then crawl3) you simply add callbacks.For example, I've been using this loop spider that follows this pattern:And this is how it looks in scrapy:To explain the process more the crawl function schedules a crawl and adds two extra callbacks that are being called when crawling is over: blocking sleep and recursive call to itself (schedule another crawl).

is Scrapy single-threaded or multi-threaded?

Gill Bates

[is Scrapy single-threaded or multi-threaded?](https://stackoverflow.com/questions/24761074/is-scrapy-single-threaded-or-multi-threaded)

There are few concurrency settings in Scrapy, like CONCURRENT_REQUESTS. Does it mean, that Scrapy crawler is multi-threaded? So if I run scrapy crawl my_crawler it will literally fire multiple simultaneous requests in parallel? 

Im asking because, I've read that Scrapy is single-threaded.

2014-07-15 14:38:43Z

There are few concurrency settings in Scrapy, like CONCURRENT_REQUESTS. Does it mean, that Scrapy crawler is multi-threaded? So if I run scrapy crawl my_crawler it will literally fire multiple simultaneous requests in parallel? 

Im asking because, I've read that Scrapy is single-threaded.Scrapy is single-threaded, except the interactive shell and some tests, see source.It's built on top of Twisted, which is single-threaded too, and makes use of it's own asynchronous concurrency capabilities, such as twisted.internet.interfaces.IReactorThreads.callFromThread, see source.Scrapy does most of it's work synchronously. However, the handling of requests is done asynchronously. I suggest this page if you haven't already seen it.http://doc.scrapy.org/en/latest/topics/architecture.htmledit:

I realize now the question was about threading and not necessarily whether it's asynchronous or not. That link would still be a good read though :)regarding your question about CONCURRENT_REQUESTS. This setting changes the number of requests that twisted will defer at once. Once that many requests have been started it will wait for some of them to finish before starting more.Scrapy is single-threaded framework, we cannot use multiple threads within a spider at the same time. However, we can create multiple spiders and piplines at the same time to make the process concurrent.

Scrapy does not support multi-threading because it is built on Twisted, which is an Asynchronous http protocol framework.

Scrapy Vs Nutch [closed]

Vidhu

[Scrapy Vs Nutch [closed]](https://stackoverflow.com/questions/17199457/scrapy-vs-nutch)

I am planning to use webcrawling in an application i am currently working on. I did some research on Nutch and run some preliminary test using it. But then i came across scrapy. But when i did some preliminary research and went through the documentation about scrapy i found that it can capture only structed data (You have to give the div name from which you want to capture data). The backend of the application i am developing is based on Python and i understand scrapy is Python based and some have suggested that scrapy is better than Nutch.My requirement is to capture the data from more than a 1000 different webpages and run search for relevant keywords in that information.Is there any way scrapy can satisfy the same requirement. 1)If yes can you point out some example on how it can be done ?2)Or Nutch+Solr is best suited for my requirement

2013-06-19 19:14:32Z

I am planning to use webcrawling in an application i am currently working on. I did some research on Nutch and run some preliminary test using it. But then i came across scrapy. But when i did some preliminary research and went through the documentation about scrapy i found that it can capture only structed data (You have to give the div name from which you want to capture data). The backend of the application i am developing is based on Python and i understand scrapy is Python based and some have suggested that scrapy is better than Nutch.My requirement is to capture the data from more than a 1000 different webpages and run search for relevant keywords in that information.Is there any way scrapy can satisfy the same requirement. 1)If yes can you point out some example on how it can be done ?2)Or Nutch+Solr is best suited for my requirementScrapy would work perfectly in your case. You are not required to give divs names - you can get anything you want:Plus, you can use BeautifulSoup and lxml for extracting the data from the page content.Besides, scrapy is based on twisted and is completely async and fast. There are plenty of examples scrapy spiders here on SO - just look through the scrapy tag questions. If you have a more specific question - just ask.Hope that helps.

Scrapy, only follow internal URLS but extract all links found

sboss

[Scrapy, only follow internal URLS but extract all links found](https://stackoverflow.com/questions/27964410/scrapy-only-follow-internal-urls-but-extract-all-links-found)

I want to get all external links from a given website using Scrapy. Using the following code the spider crawls external links as well:What am I missing? Doesn't "allowed_domains" prevent the external links to be crawled? If I set "allow_domains" for LinkExtractor it does not extract the external links. Just to clarify: I wan't to crawl internal links but extract external links. Any help appriciated!

2015-01-15 13:22:03Z

I want to get all external links from a given website using Scrapy. Using the following code the spider crawls external links as well:What am I missing? Doesn't "allowed_domains" prevent the external links to be crawled? If I set "allow_domains" for LinkExtractor it does not extract the external links. Just to clarify: I wan't to crawl internal links but extract external links. Any help appriciated!You can also use the link extractor to pull all the links once you are parsing each page. The link extractor will filter the links for you. In this example the  link extractor will deny links in the allowed domain so it only gets outside links.An updated code based on 12Ryan12's answer,A solution would be make usage a process_link function in the SgmlLinkExtractor

Documentation here http://doc.scrapy.org/en/latest/topics/link-extractors.html 

Is it possible for Scrapy to get plain text from raw HTML data?

inix

[Is it possible for Scrapy to get plain text from raw HTML data?](https://stackoverflow.com/questions/17721782/is-it-possible-for-scrapy-to-get-plain-text-from-raw-html-data)

For example:Then, I get the following raw HTML code:But I want to get plain text directly from scrapy.I do not want to use any xPath selectors to extract the p, h2, h3... tags, since I am crawling a website whose main content is embedded into a table, tbody; recursively. It can be a tedious task to find the xPath.Can this be implemented by a built in function in Scrapy? Or do I need external tools to convert it? I have read through all of Scrapy's docs, but have gained nothing.This is a sample site which can convert raw HTML into plain text: http://beaker.mailchimp.com/html-to-text

2013-07-18 11:08:47Z

For example:Then, I get the following raw HTML code:But I want to get plain text directly from scrapy.I do not want to use any xPath selectors to extract the p, h2, h3... tags, since I am crawling a website whose main content is embedded into a table, tbody; recursively. It can be a tedious task to find the xPath.Can this be implemented by a built in function in Scrapy? Or do I need external tools to convert it? I have read through all of Scrapy's docs, but have gained nothing.This is a sample site which can convert raw HTML into plain text: http://beaker.mailchimp.com/html-to-textScrapy doesn't have such functionality built-in. html2text is what you are looking for.Here's a sample spider that scrapes wikipedia's python page, gets first paragraph using xpath and converts html into plain text using html2text:prints:Another solution using lxml.html's tostring() with parameter method="text". lxml is used in Scrapy internally. (parameter encoding=unicode is usually what you want.)See http://lxml.de/api/lxml.html-module.html for details.At this moment, I don't think you need to install any 3rd party library. scrapy provides this functionality using selectors:

Assume this complex selector:

    we can get the entire text using: 

    then you can join them together easily: 

    

Should I create pipeline to save files with scrapy?

John Lotacs

[Should I create pipeline to save files with scrapy?](https://stackoverflow.com/questions/7123387/should-i-create-pipeline-to-save-files-with-scrapy)

I need to save a file (.pdf) but I'm unsure how to do it. I need to save .pdfs and store them in such a way that they are organized in a directories much like they are stored on the site I'm scraping them off. From what I can gather I need to make a pipeline, but from what I understand pipelines save "Items" and "items" are just basic data like strings/numbers. Is saving files a proper use of pipelines, or should I save file in spider instead?

2011-08-19 14:51:46Z

I need to save a file (.pdf) but I'm unsure how to do it. I need to save .pdfs and store them in such a way that they are organized in a directories much like they are stored on the site I'm scraping them off. From what I can gather I need to make a pipeline, but from what I understand pipelines save "Items" and "items" are just basic data like strings/numbers. Is saving files a proper use of pipelines, or should I save file in spider instead?Yes and no[1]. If you fetch a pdf it will be stored in memory, but if the pdfs are not big enough to fill up your available memory so it is ok.You could save the pdf in the spider callback:If you choose to do it in a pipeline:[1] another approach could be only store pdfs' urls and use another process to fetch the documents without buffering into memory. (e.g. wget)There is a FilesPipeline that you can use directly, assuming you already have the file url, the link shows how to use FilesPipeline:https://groups.google.com/forum/print/msg/scrapy-users/kzGHFjXywuY/O6PIhoT3thsJIt's a perfect tool for the job. The way Scrapy works is that you have spiders that transform web pages into structured data(items). Pipelines are postprocessors, but they use same asynchronous infrastructure as spiders so it's perfect for fetching media files.In your case, you'd first extract location of PDFs in spider, fetch them in pipeline and have another pipeline to save items.

Locally run all of the spiders in Scrapy

Blender

[Locally run all of the spiders in Scrapy](https://stackoverflow.com/questions/15564844/locally-run-all-of-the-spiders-in-scrapy)

Is there a way to run all of the spiders in a Scrapy project without using the Scrapy daemon? There used to be a way to run multiple spiders with scrapy crawl, but that syntax was removed and Scrapy's code changed quite a bit.I tried creating my own command:But once a spider is registered with self.crawler.crawl(), I get assertion errors for all of the other spiders:Is there any way to do this? I'd rather not start subclassing core Scrapy components just to run all of my spiders like this.

2013-03-22 07:17:42Z

Is there a way to run all of the spiders in a Scrapy project without using the Scrapy daemon? There used to be a way to run multiple spiders with scrapy crawl, but that syntax was removed and Scrapy's code changed quite a bit.I tried creating my own command:But once a spider is registered with self.crawler.crawl(), I get assertion errors for all of the other spiders:Is there any way to do this? I'd rather not start subclassing core Scrapy components just to run all of my spiders like this.Here is an example that does not run inside a custom command, but runs the Reactor manually and creates a new Crawler for each spider:You will have to design some signal system to stop the reactor when all spiders are finished.EDIT: And here is how you can run multiple spiders in a custom command:Why didn't you just use something like:?the answer of @Steven Almeroth will be failed in Scrapy 1.0, and you should edit the script like this:this code is works on My scrapy version is 1.3.3 (save it in same directory in scrapy.cfg):for scrapy 1.5.x (so you don't get the deprecation warning)

How to make Scrapy show user agent per download request in log?

Alok Singh Mahor

[How to make Scrapy show user agent per download request in log?](https://stackoverflow.com/questions/23152739/how-to-make-scrapy-show-user-agent-per-download-request-in-log)

I am learning Scrapy, a web crawling framework.  I know I can set USER_AGENT in settings.py file of the Scrapy project. When I run the Scrapy, I can see the USER_AGENT's value in INFO logs.

This USER_AGENT gets set in every download request to the server I want to crawl.  But I am using multiple USER_AGENT randomly with the help of this solution. I guess this randomly chosen USER_AGENT would be working. I want to confirm it. So, how I can make Scrapy shows USER_AGENT per download request so I can see the value of USER_AGENT in the logs? 

2014-04-18 10:59:46Z

I am learning Scrapy, a web crawling framework.  I know I can set USER_AGENT in settings.py file of the Scrapy project. When I run the Scrapy, I can see the USER_AGENT's value in INFO logs.

This USER_AGENT gets set in every download request to the server I want to crawl.  But I am using multiple USER_AGENT randomly with the help of this solution. I guess this randomly chosen USER_AGENT would be working. I want to confirm it. So, how I can make Scrapy shows USER_AGENT per download request so I can see the value of USER_AGENT in the logs? Just FYI.I've implemented a simple RandomUserAgentMiddleware middleware based on fake-useragent.Thanks to fake-useragent, you don't need to configure the list of User-Agents - it picks them up based on browser usage statistics from a real-world database.You can see it by using this:You can use scrapy-fake-useragent python library. It works perfectly and it chooses user agent based on world usage statistic. But be careful, check if it's already working perfectly using above code since you might do some mistake when applying it. Read the instruction carefully.You can add logging to solution you're using:EDIT: I came here because I was looking for the functionality to change the user agent.Based to alecxe's RandomUserAgent, this is what I use to set the user agent only once per crawl and only from a predefined list (works for me with scrapy v. 0.24 & 0.25):The actual answer to your question is: Check for the UA by using a local webserver and see check the logs (e.g. /var/log/apache2/access.log on *NIX).

Scrapy SgmlLinkExtractor is ignoring allowed links

Zeynel

[Scrapy SgmlLinkExtractor is ignoring allowed links](https://stackoverflow.com/questions/1811132/scrapy-sgmllinkextractor-is-ignoring-allowed-links)

Please take a look at this spider example in Scrapy documentation. The explanation is:I copied the same spider exactly, and replaced "example.com" with another initial url.But my spider "stb" does not collect links from "/bios/" as it is supposed to do. It runs the initial url, scrapes the item['JD'] and writes it on a file and then quits.Why is it that SgmlLinkExtractor is ignored? The Rule is read because it catches syntax errors inside the Rule line.Is this a bug? is there something wrong in my code? There are no errors except a bunch unhandled errors that I see with every run.It would be nice to know what I am doing wrong here. Thanks for any clues. Am I misunderstanding what SgmlLinkExtractor is supposed to do?

2009-11-28 00:34:23Z

Please take a look at this spider example in Scrapy documentation. The explanation is:I copied the same spider exactly, and replaced "example.com" with another initial url.But my spider "stb" does not collect links from "/bios/" as it is supposed to do. It runs the initial url, scrapes the item['JD'] and writes it on a file and then quits.Why is it that SgmlLinkExtractor is ignored? The Rule is read because it catches syntax errors inside the Rule line.Is this a bug? is there something wrong in my code? There are no errors except a bunch unhandled errors that I see with every run.It would be nice to know what I am doing wrong here. Thanks for any clues. Am I misunderstanding what SgmlLinkExtractor is supposed to do?The parse function is actually implemented and used in the CrawlSpider class, and you're unintentionally overriding it. If you change the name to something else, like parse_item, then the Rule should work.

What is the difference between Scrapy's spider middleware and downloader middleware? [closed]

Zhang Jiuzhou

[What is the difference between Scrapy's spider middleware and downloader middleware? [closed]](https://stackoverflow.com/questions/17872753/what-is-the-difference-between-scrapys-spider-middleware-and-downloader-middlew)

Both middleware can process Request and Response. But what is the difference?

2013-07-26 04:10:13Z

Both middleware can process Request and Response. But what is the difference?While they have almost identical interfaces, they serve different purposes:Some middlewares can function as either a downloader middleware or a spider middleware, but they're often trivial and will be forced into one category or the other once you add more complex functionality.

Scrapy delay request

Arkan Kalu

[Scrapy delay request](https://stackoverflow.com/questions/30404364/scrapy-delay-request)

every time i run my code my ip gets banned. I need help to delay each request for 10 seconds. I've tried to place DOWNLOAD_DELAY in code but it gives no results. Any help is appreciated.

2015-05-22 19:18:32Z

every time i run my code my ip gets banned. I need help to delay each request for 10 seconds. I've tried to place DOWNLOAD_DELAY in code but it gives no results. Any help is appreciated.You need to set DOWNLOAD_DELAY in settings.py of your project. Note that you may also need to limit concurrency. By default concurrency is 8 so you are hitting website with 8 simultaneous requests. Starting with Scrapy 1.0 you can also place custom settings in spider, so you could do something like this:Delay and concurrency are set per downloader slot not per requests. To actually check what download you have you could try something like this

Scrapy Crawling Speed is Slow (60 pages / min)

somewire

[Scrapy Crawling Speed is Slow (60 pages / min)](https://stackoverflow.com/questions/13505194/scrapy-crawling-speed-is-slow-60-pages-min)

I am experiencing slow crawl speeds with scrapy (around 1 page / sec).

I'm crawling a major website from aws servers so I don't think its a network issue. Cpu utilization is nowhere near 100 and if I start multiple scrapy processes crawl speed is much faster.Scrapy seems to crawl a bunch of pages, then hangs for several seconds, and then repeats.I've tried playing with:

CONCURRENT_REQUESTS = CONCURRENT_REQUESTS_PER_DOMAIN = 500but this doesn't really seem to move the needle past about 20.

2012-11-22 02:45:08Z

I am experiencing slow crawl speeds with scrapy (around 1 page / sec).

I'm crawling a major website from aws servers so I don't think its a network issue. Cpu utilization is nowhere near 100 and if I start multiple scrapy processes crawl speed is much faster.Scrapy seems to crawl a bunch of pages, then hangs for several seconds, and then repeats.I've tried playing with:

CONCURRENT_REQUESTS = CONCURRENT_REQUESTS_PER_DOMAIN = 500but this doesn't really seem to move the needle past about 20.Are you sure you are allowed to crawl the destination site at high speed? Many sites implement download threshold and "after a while" start responding slowly.

How to prevent Scrapy from URL encoding request URLs

flyingtriangle

[How to prevent Scrapy from URL encoding request URLs](https://stackoverflow.com/questions/24884011/how-to-prevent-scrapy-from-url-encoding-request-urls)

I would like Scrapy to not URL encode my Requests. I see that scrapy.http.Request is importing scrapy.utils.url which imports w3lib.url which contains the variable _ALWAYS_SAFE_BYTES. I just need to add a set of characters to _ALWAYS_SAFE_BYTES but I am not sure how to do that from within my spider class.scrapy.http.Request relevant line:canonicalize_url is from scrapy.utils.url, relevant line in scrapy.utils.url:safe_url_string() is from w3lib.url, relevant lines in w3lib.url:within w3lib.url.safe_url_string():

2014-07-22 09:46:29Z

I would like Scrapy to not URL encode my Requests. I see that scrapy.http.Request is importing scrapy.utils.url which imports w3lib.url which contains the variable _ALWAYS_SAFE_BYTES. I just need to add a set of characters to _ALWAYS_SAFE_BYTES but I am not sure how to do that from within my spider class.scrapy.http.Request relevant line:canonicalize_url is from scrapy.utils.url, relevant line in scrapy.utils.url:safe_url_string() is from w3lib.url, relevant lines in w3lib.url:within w3lib.url.safe_url_string():I wanted to not to encode [ and ] and I did this.When creating a Request object scrapy applies some url encoding methods. To revert these you can utilize a custom middleware and change the url to your needs.You could use a Downloader Middleware like this:Don't forget to "activate" the middleware in settings.py like so:My project is named so and in the folder there is a file middlewares.py. You need to adjust those to your environment.Credit goes to: Frank Martin

scrapyd-client command not found

dropax

[scrapyd-client command not found](https://stackoverflow.com/questions/45750739/scrapyd-client-command-not-found)

I'd just installed the scrapyd-client(1.1.0) in a virtualenv, and run command 'scrapyd-deploy' successfully, but when I run 'scrapyd-client', the terminal said: command not found: scrapyd-client.According to the readme file(https://github.com/scrapy/scrapyd-client), there should be a 'scrapyd-client' command.I had checked the path '/lib/python2.7/site-packages/scrapyd-client', only 'scrapyd-deploy' in the folder.Is the command 'scrapyd-client' being removed for now? 

2017-08-18 07:19:29Z

I'd just installed the scrapyd-client(1.1.0) in a virtualenv, and run command 'scrapyd-deploy' successfully, but when I run 'scrapyd-client', the terminal said: command not found: scrapyd-client.According to the readme file(https://github.com/scrapy/scrapyd-client), there should be a 'scrapyd-client' command.I had checked the path '/lib/python2.7/site-packages/scrapyd-client', only 'scrapyd-deploy' in the folder.Is the command 'scrapyd-client' being removed for now? Create a fresh environment and install scrapyd-client first using belowAnd it should work. I was able to get itThe package on pip may not be the latest one

How to include the start url in the “allow” rule in SgmlLinkExtractor using a scrapy crawl spider

user1068961

[How to include the start url in the “allow” rule in SgmlLinkExtractor using a scrapy crawl spider](https://stackoverflow.com/questions/8293432/how-to-include-the-start-url-in-the-allow-rule-in-sgmllinkextractor-using-a-sc)

I have searched a lot of topics but does not seem to find the answer for my specific question.

I have created a crawl spider for a website and it works perfectly. I then made a similar one to crawl a similar website but this time I have a small issue. Down to the business:my start url looks as follows: www.example.com . The page contains the links I want to apply my spider look like: ...I now have a issue:

Every time when I enter the start url, it redirects to  www.example.com/locationA automatically and all links I got my spider working include So my problem is how I can include the www.example.com/locationA in the returned URLs.I even got the log info like:-2011-11-28 21:25:33+1300 [example.com] DEBUG: Redirecting (302) to  from http://www.example.com/>-2011-11-28 21:25:34+1300[example.com] DEBUG: Redirecting (302) to  (referer: None)Print out from parse_item:  www.example.com/locationB....I think the issue might be related to that (referer: None) some how. Could anyone please shed some light on this??I have narrow down this issue by changing the start url to www.example.com/locationB. Since all the pages contain the lists of all locations, this time I got my spider works on:-www.example.com/locationA-www.example.com/locationC

...In a nut shell, I am looking for the way to include the url which is same as (or being redirected from) the start url into the list that the parse_item callback will work on.

2011-11-28 08:51:46Z

I have searched a lot of topics but does not seem to find the answer for my specific question.

I have created a crawl spider for a website and it works perfectly. I then made a similar one to crawl a similar website but this time I have a small issue. Down to the business:my start url looks as follows: www.example.com . The page contains the links I want to apply my spider look like: ...I now have a issue:

Every time when I enter the start url, it redirects to  www.example.com/locationA automatically and all links I got my spider working include So my problem is how I can include the www.example.com/locationA in the returned URLs.I even got the log info like:-2011-11-28 21:25:33+1300 [example.com] DEBUG: Redirecting (302) to  from http://www.example.com/>-2011-11-28 21:25:34+1300[example.com] DEBUG: Redirecting (302) to  (referer: None)Print out from parse_item:  www.example.com/locationB....I think the issue might be related to that (referer: None) some how. Could anyone please shed some light on this??I have narrow down this issue by changing the start url to www.example.com/locationB. Since all the pages contain the lists of all locations, this time I got my spider works on:-www.example.com/locationA-www.example.com/locationC

...In a nut shell, I am looking for the way to include the url which is same as (or being redirected from) the start url into the list that the parse_item callback will work on.For others have the same problem, after a lot of searching, all you need to do is name your callback function to parse_start_url.Eg: Adding sample code based on mindcast suggestion:At first I thought that there is a simple solution using start_requests() like:But tests showed, that when start_requests() is used instead of a start_urls list, spider ignores rules, because CrawlSpider.parse(response) is not called.So, here is my solution:Perhaps there is a better way.A simple workaround is to specifically add a rule for the start_urls(in your case: http://example.com/locationA )(please ignore indentation issue):

How to disable robots.txt when you launch scrapy shell?

DARDAR SAAD

[How to disable robots.txt when you launch scrapy shell?](https://stackoverflow.com/questions/40823516/how-to-disable-robots-txt-when-you-launch-scrapy-shell)

I use Scrapy shell without problems with several websites, but I find problems when the robots (robots.txt) does not allow access to a site.

How can I disable robots detection by Scrapy (ignored the existence)?

Thank you in advance.

I'm not talking about the project created by Scrapy, but Scrapy shell command: scrapy shell 'www.example.com'

2016-11-26 21:49:12Z

I use Scrapy shell without problems with several websites, but I find problems when the robots (robots.txt) does not allow access to a site.

How can I disable robots detection by Scrapy (ignored the existence)?

Thank you in advance.

I'm not talking about the project created by Scrapy, but Scrapy shell command: scrapy shell 'www.example.com'In the settings.py file of your scrapy project, look for ROBOTSTXT_OBEY and set it to False.If you run scrapy from project directory scrapy shell will use the projects settings.py. If you run outside of the project scrapy will use default settings. However you can override and add settings via --set flag.

So to turn off ROBOTSTXT_OBEY setting you can simply: 

Running Multiple spiders in scrapy for 1 website in parallel?

parik

[Running Multiple spiders in scrapy for 1 website in parallel?](https://stackoverflow.com/questions/39365131/running-multiple-spiders-in-scrapy-for-1-website-in-parallel)

I want to crawl a website with 2 parts and my script is not as fast as I need.Is it possible to launch 2 spiders, one for scraping the first part and the second one for the second part? I tried to have 2 different classes, and run thembut i think that it is not smart.I read the documentation of scrapyd but I don't know if it's good for my case.

2016-09-07 08:41:25Z

I want to crawl a website with 2 parts and my script is not as fast as I need.Is it possible to launch 2 spiders, one for scraping the first part and the second one for the second part? I tried to have 2 different classes, and run thembut i think that it is not smart.I read the documentation of scrapyd but I don't know if it's good for my case.I think what you are looking for is something like this:You can read more at: running-multiple-spiders-in-the-same-process.Or you can run with like this, you need to save this code at the same directory with scrapy.cfg (My scrapy version is 1.3.3) :Better solution is (if you have multiple spiders) it dynamically get spiders and run them.(Second Solution):

Because spiders.list() is deprecated in Scrapy 1.4 Yuda solution should be converted to something like 

Crawling with Scrapy - HTTP status code is not handled or not allowed?

gait

[Crawling with Scrapy - HTTP status code is not handled or not allowed?](https://stackoverflow.com/questions/46746701/crawling-with-scrapy-http-status-code-is-not-handled-or-not-allowed)

I want to get product title,link,price in category https://tiki.vn/dien-thoai-may-tinh-bang/c1789But it fails "HTTP status code is not handled or not allowed"

https://i.stack.imgur.com/KCFw2.jpgMy file: spiders/tiki.pyFile: items.pyPlease help me!!!! thanks!

2017-10-14 16:20:00Z

I want to get product title,link,price in category https://tiki.vn/dien-thoai-may-tinh-bang/c1789But it fails "HTTP status code is not handled or not allowed"

https://i.stack.imgur.com/KCFw2.jpgMy file: spiders/tiki.pyFile: items.pyPlease help me!!!! thanks!You are being blocked based on scrapy's user-agent.You have two options:I assume you want to take option 2.Go to your settings.py in your scrapy project and set your user-agent to a non-default value. Either your own project name (it probably should not contain the word scrapy) or a standard browser's user-agent.We all want to learn, so here is an explanation of how I got to this result and what you can do if you see such behavior again.The website tiki.vn seems to return HTTP status 404 for all requests of your spider. You can see in your screenshot that you get a 404 for both your requests to /robots.txt and /dien-thoai-may-tinh-bang/c1789.404 means "not found" and web servers use this to show that a URL does not exist. However, if we check the same sites manually, we can see that both sites contain valid content. Now, it could technically be possible that these sites return both content and a 404 error code at the same time, but we can check this with the developer console of our browser (e.g. Chrome or Firefox).Here we can see that robots.txt returns a valid 200 status code.Many web sites try to restrict scraping, so they try to detect scraping behavior. So, they will look at some indicators and decide if they will serve content to you or block your request. I assume that exactly this is what's happening to you.I wanted to crawl one website, which worked totally fine from my home PC, but did not respond at all (not even 404) to any request from my server (scrapy, wget, curl, ...).Next steps you'll have to take to analyze the reason for this issue:You can fetch it with wget like this:wget does send a custom user-agent, so you might want to set it to a web browser's user-agent if this command does not work (it does from my PC).This will help you to find out if the problem is with the server (e.g. they blocked the IP or a whole IP range) or if you need to make some modifications to your spider.If it works with wget for your server, I would suspect the user-agent of scrapy to be the problem. According to the documentation, scrapy does use Scrapy/VERSION (+http://scrapy.org) as the user-agent unless you set it yourself. It's quite possible that they block your spider based on the user-agent.So, you have to go to settings.py in your scrapy project and look for the settings USER_AGENT there. Now, set this to anything which does not contain the keyword scrapy. If you want to be nice, use your project name + domain, otherwise use a standard browser user-agent.Nice variant:Not so nice (but common in scraping) variant:In fact, I was able to verify that they block on the user-agent with this wget command from my local PC:which results inApart from the Aufziehvogel user agent change, please refer the http error code also. In your case http error code is 404, which indicates a CLIENT ERROR(NOT FOUND). If the website requires an authenticated session to scrape the content then the http error code might be 401 which indicates a CLIENT ERROR(UNAUTHORIZED)

scrapy - how to get text from 'div'

user2499003

[scrapy - how to get text from 'div'](https://stackoverflow.com/questions/17180460/scrapy-how-to-get-text-from-div)

I just started to get to know scrapy. Now I am trying to crawl by following tutorials. But I have difficulty to crawl text from div.This is items.pyThis is dmoz_spider.pyAnd now I am trying to crawl from top folder by commanding this:But the file was created with only '['.It perfectly works in the console(by commanding each select), but somehow it doesn't work as a script. I am really a starter of scrapy. Could you guys let me know how can I get the data in 'div'? Thanks in advance.* In addition, this is what I get.

2013-06-18 23:05:28Z

I just started to get to know scrapy. Now I am trying to crawl by following tutorials. But I have difficulty to crawl text from div.This is items.pyThis is dmoz_spider.pyAnd now I am trying to crawl from top folder by commanding this:But the file was created with only '['.It perfectly works in the console(by commanding each select), but somehow it doesn't work as a script. I am really a starter of scrapy. Could you guys let me know how can I get the data in 'div'? Thanks in advance.* In addition, this is what I get.I can get you the title of the film, but I'm somewhat crappy with XPath so the description XPath will get you everything within the <div class="tabbertab" title="Synopsis"> element. It's not ideal, but it's a starting point. Getting the image URL is left as an exercise for the OP. :)Just replacewithHope that helps.

Best web graph crawler for speed?

OregonTrail

[Best web graph crawler for speed?](https://stackoverflow.com/questions/3424027/best-web-graph-crawler-for-speed)

For the past month I've been using Scrapy for a web crawling project I've begun.This project involves pulling down the full document content of all web pages in a single domain name that are reachable from the home page. Writing this using Scrapy was quite easy, but it simply runs too slowly. In 2-3 days I can only pull down 100,000 pages.I've realized that my initial notion that Scrapy isn't meant for this type of crawl is revealing itself.I've begun to focus my sights on Nutch and Methabot in hopes of better performance. The only data that I need to store during the crawl is the full content of the web page and preferably all the links on the page (but even that can be done in post-processing).I'm looking for a crawler that is fast and employs many parallel requests.

2010-08-06 13:08:47Z

For the past month I've been using Scrapy for a web crawling project I've begun.This project involves pulling down the full document content of all web pages in a single domain name that are reachable from the home page. Writing this using Scrapy was quite easy, but it simply runs too slowly. In 2-3 days I can only pull down 100,000 pages.I've realized that my initial notion that Scrapy isn't meant for this type of crawl is revealing itself.I've begun to focus my sights on Nutch and Methabot in hopes of better performance. The only data that I need to store during the crawl is the full content of the web page and preferably all the links on the page (but even that can be done in post-processing).I'm looking for a crawler that is fast and employs many parallel requests.This my be fault of server not Scrapy. Server may be not so fast as you want or may be it (or webmaster) detects crawling and limit speed for this connection/cookie.

Do you use proxy? This may slow down crawling too.

This may be Scrapy wisdom, if you will crawl too intensive you may get ban on this server. For my C++ handwritten crawler I artificially set 1 request per second limit. But this speed is enough for 1 thread ( 1 req * 60 secs * 60 minutes * 24 hours = 86400 req / day ). If you interested you may write email to whalebot.helmsman {AT} gmail.com .Scrapy allows you to determine the number of concurrent requests and the delay between the requests in its settings.Do you know where the bottleneck is?. As whalebot.helmsman pointed out, the limit may not be on Scrapy itself, but on the server you're crawling.You should start by finding out whether the bottleneck is the network or CPU.

Scraping data out of facebook using scrapy

Aryabhatt

[Scraping data out of facebook using scrapy](https://stackoverflow.com/questions/16863425/scraping-data-out-of-facebook-using-scrapy)

The new graph search on facebook lets you search for current employees of a company using query token - Current Google employees (for example). I want to scrape the results page (http://www.facebook.com/search/104958162837/employees/present) via scrapy.Initial problem was facebook allows only a facebook user to access the information, so directing me to login.php. So, before scraping this url, I logged in via scrapy and then this result page. But even though the http response is 200 for this page, it does not scraps any data. The code is as follows: What could I have missed or done incorrectly?

2013-05-31 18:16:37Z

The new graph search on facebook lets you search for current employees of a company using query token - Current Google employees (for example). I want to scrape the results page (http://www.facebook.com/search/104958162837/employees/present) via scrapy.Initial problem was facebook allows only a facebook user to access the information, so directing me to login.php. So, before scraping this url, I logged in via scrapy and then this result page. But even though the http response is 200 for this page, it does not scraps any data. The code is as follows: What could I have missed or done incorrectly?The problem is that search results (specifically div initial_browse_result) are loaded dynamically via javascript. Scrapy receives the page before those actions, so there is no results yet there.Basically, you have two options here:If you go with first option, you should analyze all requests going during the page load and figure out which one is responsible for getting the data you want to scrape.The second is pretty straightforward, but will definitely work - you just use other tool to get the page with loaded via js data, then parse it to scrapy items.Hope that helps.

Scrapy CrawlSpider: how to access item across different levels of parsing

Andrew Chen

[Scrapy CrawlSpider: how to access item across different levels of parsing](https://stackoverflow.com/questions/11128596/scrapy-crawlspider-how-to-access-item-across-different-levels-of-parsing)

I'm crawling a web site (only two levels deep), and I want to scrape information from sites on both levels. The problem I'm running into, is I want to fill out the fields of one item with information from both levels. How do I do this?I was thinking having a list of items as an instance variable that will be accessible by all threads (since it's the same instance of the spider), and parse_1 will fill out some fields, and parse_2 will have to check for the correct key before filling out the corresponding value. This method seems burdensome, and I'm still not sure how to make it work.What I'm thinking is there must be a better way, maybe somehow passing an item to the callback. I don't know how to do that with the Request() method though. Ideas?

2012-06-20 21:38:30Z

I'm crawling a web site (only two levels deep), and I want to scrape information from sites on both levels. The problem I'm running into, is I want to fill out the fields of one item with information from both levels. How do I do this?I was thinking having a list of items as an instance variable that will be accessible by all threads (since it's the same instance of the spider), and parse_1 will fill out some fields, and parse_2 will have to check for the correct key before filling out the corresponding value. This method seems burdensome, and I'm still not sure how to make it work.What I'm thinking is there must be a better way, maybe somehow passing an item to the callback. I don't know how to do that with the Request() method though. Ideas?From scrapy documentation:In some cases you may be interested in passing arguments to those callback functions so you can receive the arguments later, in the second callback. You can use the Request.meta attribute for that.Here’s an example of how to pass an item using this mechanism, to populate different fields from different pages:So, basically you can scrape first page and store all information in item and then send whole item with request for that second level url and have all the information in one item.

Docker Scrapinghub/splash exited with 139

MtziSam

[Docker Scrapinghub/splash exited with 139](https://stackoverflow.com/questions/45722034/docker-scrapinghub-splash-exited-with-139)

I'm using Scrapy to do some crawling with Splash using the Scrapinghub/splash docker container however the container exit after a while by itself with exit code 139, I'm running the scraper on an AWS EC2 instance with 1GB swap assigned.i also tried to run it in background and view the logs later but nothing indicates an error it just exit.From what i understand 139 is for Segmentation Fault errors in UNIX, is there anyway to check or log what part of memory being accessed or code being executed to debug this? Or can i increase the container memory or swap size to avoid this?

2017-08-16 19:59:55Z

I'm using Scrapy to do some crawling with Splash using the Scrapinghub/splash docker container however the container exit after a while by itself with exit code 139, I'm running the scraper on an AWS EC2 instance with 1GB swap assigned.i also tried to run it in background and view the logs later but nothing indicates an error it just exit.From what i understand 139 is for Segmentation Fault errors in UNIX, is there anyway to check or log what part of memory being accessed or code being executed to debug this? Or can i increase the container memory or swap size to avoid this?

Python Scrapy function to be called just before spider_closed signal sent?

corg

[Python Scrapy function to be called just before spider_closed signal sent?](https://stackoverflow.com/questions/13047120/python-scrapy-function-to-be-called-just-before-spider-closed-signal-sent)

I wrote a spider using scrapy, one that makes a whole bunch of HtmlXPathSelector Requests to separate sites. It creates a row of data in a .csv file after each request is (asynchronously) satisfied. It's impossible to see which request is satisfied last, because the request is repeated if no data was extracted yet (occasionally it misses the data a few times). Even though I start with a neat list, the output is jumbled because the rows are written immediately after data is extracted.Now I'd like to sort that list based on one column, but after every request is done. Can the 'spider_closed' signal be used to trigger a real function? As below, I tried connecting the signal with dispatcher, but this function seems to only print out things, rather than work with variables or even call other functions.

2012-10-24 10:12:19Z

I wrote a spider using scrapy, one that makes a whole bunch of HtmlXPathSelector Requests to separate sites. It creates a row of data in a .csv file after each request is (asynchronously) satisfied. It's impossible to see which request is satisfied last, because the request is repeated if no data was extracted yet (occasionally it misses the data a few times). Even though I start with a neat list, the output is jumbled because the rows are written immediately after data is extracted.Now I'd like to sort that list based on one column, but after every request is done. Can the 'spider_closed' signal be used to trigger a real function? As below, I tried connecting the signal with dispatcher, but this function seems to only print out things, rather than work with variables or even call other functions.I hacked together a pipeline to solve this problem for you.file: Project.middleware_module.SortedCSVPipelinefile: settings.pyWhen running this you won't need to use an item exporter anymore because this pipeline will do the csv writing for you. Also, the 1000 in the pipeline entry in your setting needs to be a higher value than all other pipelines that you want to run before this one. I tested this in my project and it resulted in a csv file sorted by the column I specified! HTHCheers

How to properly use Rules, restrict_xpaths to crawl and parse URLs with scrapy?

Marc

[How to properly use Rules, restrict_xpaths to crawl and parse URLs with scrapy?](https://stackoverflow.com/questions/15192362/how-to-properly-use-rules-restrict-xpaths-to-crawl-and-parse-urls-with-scrapy)

I am trying to program a crawl spider to crawl RSS feeds of a website and then parsing the meta tags of the article.The first RSS page is a page that displays the RSS categories. I managed to extract the link because the  tag is in a  tag. It looks like this:Once you click that link it brings you the the articles for that RSS category that looks like this:As You can see I can get the link with xpath again if I use the  tag

I want my crawler to go to the link inside that tag and parse the meta tags for me.Here is my crawler code:However this is the output when I run the crawler:What am I doing wrong here? I've been reading the documentation over and over again but I feel like I keep overlooking something. Any help would be appreciated.EDIT: Added: items.append(item) . Had forgotten it in original post.

EDIT: : I've tried this as well and it resulted in the same output:

2013-03-03 23:47:32Z

I am trying to program a crawl spider to crawl RSS feeds of a website and then parsing the meta tags of the article.The first RSS page is a page that displays the RSS categories. I managed to extract the link because the  tag is in a  tag. It looks like this:Once you click that link it brings you the the articles for that RSS category that looks like this:As You can see I can get the link with xpath again if I use the  tag

I want my crawler to go to the link inside that tag and parse the meta tags for me.Here is my crawler code:However this is the output when I run the crawler:What am I doing wrong here? I've been reading the documentation over and over again but I feel like I keep overlooking something. Any help would be appreciated.EDIT: Added: items.append(item) . Had forgotten it in original post.

EDIT: : I've tried this as well and it resulted in the same output:You've returned an empty items, you need to append item to items.

You can also yield item in the loop.

Trying to crawl all links of a webpage with scrapy. But I cannot output the links on a page

Jasper Nugteren

[Trying to crawl all links of a webpage with scrapy. But I cannot output the links on a page](https://stackoverflow.com/questions/13740825/trying-to-crawl-all-links-of-a-webpage-with-scrapy-but-i-cannot-output-the-link)

My first question here :)I was trying to crawl my schools website for all possible webpages there are. But I cannot get the links into a text file. I have the right permissions, so that  is not the problem.So I am only scanning on the hsleiden.nl page. And I would like to have the response.url into the textfile hsleiden-output.txt.Is there any way to do this right?

2012-12-06 09:44:01Z

My first question here :)I was trying to crawl my schools website for all possible webpages there are. But I cannot get the links into a text file. I have the right permissions, so that  is not the problem.So I am only scanning on the hsleiden.nl page. And I would like to have the response.url into the textfile hsleiden-output.txt.Is there any way to do this right?With reference to the documentation for CrawlSpider, if multiple rules match the same link then only the first will be used. Thus, as a result of redirects, using the first rule results in a seemingly infinite loop. Since the second rule is ignored, none of the matching links are ever passed to the parse_item callback, which means no output file.Some investigation is required to fix the redirect issue (and to modify the first rule so that it doesn't clash with the second), but commenting it out entirely will produce an output file of links like so: etcThey were all munged together on a single line, so you might want to add a newline character or separator each time you write to the output file.

Dynamic spider generation with Scrapy subclass init error

JLR

[Dynamic spider generation with Scrapy subclass init error](https://stackoverflow.com/questions/35662146/dynamic-spider-generation-with-scrapy-subclass-init-error)

I am trying to write a generic "Master" spider that I use with "start_urls" and "allowed_domains" inserted dynamically during execution. (Eventually, I will have these in a database, that I will pull and then use to initialize and crawl a new spider for each DB entry.)At the moment, I have two files: For writing these two files, I referenced the following: I considered scrapyD, but I don't think its what I'm looking for... Here is what I have written: MySpider.py --RunSpider.py --PROBLEM: Here is my problem -- When I execute this, it appears to successfully pass in my arguments for allowed_domains and start_urls; HOWEVER, after MySpider is initialized, when I run the spider to crawl, the specified urls / domains are no longer found and no website is crawled. I added the print statement above to show this:Why is my spider initialized correctly, but when I try to execute the spider the urls are missing?  Is this a basic Python programming (class?) error that I am just missing?

2016-02-26 21:32:04Z

I am trying to write a generic "Master" spider that I use with "start_urls" and "allowed_domains" inserted dynamically during execution. (Eventually, I will have these in a database, that I will pull and then use to initialize and crawl a new spider for each DB entry.)At the moment, I have two files: For writing these two files, I referenced the following: I considered scrapyD, but I don't think its what I'm looking for... Here is what I have written: MySpider.py --RunSpider.py --PROBLEM: Here is my problem -- When I execute this, it appears to successfully pass in my arguments for allowed_domains and start_urls; HOWEVER, after MySpider is initialized, when I run the spider to crawl, the specified urls / domains are no longer found and no website is crawled. I added the print statement above to show this:Why is my spider initialized correctly, but when I try to execute the spider the urls are missing?  Is this a basic Python programming (class?) error that I am just missing?Please refer to the documentation on CrawlerProcessSo you need to do something like this:You can see this in action with scrapy commands themselves, for example scrapy runspider:

A web crawler in a self-contained python file

Basj

[A web crawler in a self-contained python file](https://stackoverflow.com/questions/27742542/a-web-crawler-in-a-self-contained-python-file)

I have found lots of Scrapy tutorials (such as this good tutorial) that all need the steps listed below. The result is a project, with lots of files (project.cfg + some .py files + a specific folder structure).How to make the steps (listed below) work as a self-contained python file that can be run with python mycrawler.py ?(instead of a full project with lots of files, some .cfg files, etc., and having to use scrapy crawl myproject -o myproject.json... by the way, it seems that scrapy is a new shell command? is this true?)Note: here could be an answer to this question but unfortunately it is deprecated and no longer works.1) Create a new scrapy project with scrapy startproject myproject2) Define the data structure with Item like this:3) Define the crawler with4) Run with: 

2015-01-02 12:51:40Z

I have found lots of Scrapy tutorials (such as this good tutorial) that all need the steps listed below. The result is a project, with lots of files (project.cfg + some .py files + a specific folder structure).How to make the steps (listed below) work as a self-contained python file that can be run with python mycrawler.py ?(instead of a full project with lots of files, some .cfg files, etc., and having to use scrapy crawl myproject -o myproject.json... by the way, it seems that scrapy is a new shell command? is this true?)Note: here could be an answer to this question but unfortunately it is deprecated and no longer works.1) Create a new scrapy project with scrapy startproject myproject2) Define the data structure with Item like this:3) Define the crawler with4) Run with: You can run scrapy spiders as a single script without starting a project by using runspider

Is this what you wanted?Now you can run this with scrapy runspider myscript.py -o out.jsonScrapy is not unix command  it just executable like python,javac,gcc etc.

bcz u are using framework for this you have to use command given provided by 

framework. 

one thing you can do is create a bash script and simply execute whenever you need or execute it from some other program program.you can write crawler using urllib3 its simple  

Scrapy - parsing all sub-pages of a given domain

Boiler_Maker

[Scrapy - parsing all sub-pages of a given domain](https://stackoverflow.com/questions/15400215/scrapy-parsing-all-sub-pages-of-a-given-domain)

I would like to parse kickstarter.com projects using scrapy, but can't figure out how to make the spider search projects that I don't explicitly specify under start_urls. I have the first part of the scrapy code figured out (I can extract the necessary information from one website), I just can't get it to do this for all projects under the domain kickstarter.com/projects.From what I've read, I believe that parsing is possible (1) using links on the starting page (kickstarter.com/projects), (2) using links from one project page to jump to another project, and (3) using a site map (which I don't think kickstarter.com has) to locate webpages to parse.I've spent hours trying each of these methods but and I am getting nowhere. I've used the scrapy tutorial code and built on it.Here is the part so far that works:

2013-03-14 02:38:36Z

I would like to parse kickstarter.com projects using scrapy, but can't figure out how to make the spider search projects that I don't explicitly specify under start_urls. I have the first part of the scrapy code figured out (I can extract the necessary information from one website), I just can't get it to do this for all projects under the domain kickstarter.com/projects.From what I've read, I believe that parsing is possible (1) using links on the starting page (kickstarter.com/projects), (2) using links from one project page to jump to another project, and (3) using a site map (which I don't think kickstarter.com has) to locate webpages to parse.I've spent hours trying each of these methods but and I am getting nowhere. I've used the scrapy tutorial code and built on it.Here is the part so far that works:Since you're subclassing CrawlSpider, do not override parse. CrawlSpider's link crawling logic is contained within parse, which you really need.As for the crawling itself, that's what the rules class attribute is for. I haven't tested it, but it should work:The spider crawls the pages of the recently launched projects.Also, use yield instead of return. It's better to keep your spider's output a generator and it lets you yield multiple items/requests without making a list to hold them.

Scrapy spider difference between Crawled pages and Scraped items

André Teixeira

[Scrapy spider difference between Crawled pages and Scraped items](https://stackoverflow.com/questions/15957853/scrapy-spider-difference-between-crawled-pages-and-scraped-items)

Im writing a Scrapy CrawlSpider that reads a list of ADs on first page, takes some info like thumbs of the listings and AD urls, then yields a request to each of this AD urls to take their details. It was working and paginating apparently well on test enviroment, but today trying to make a complete run I realized that in log: Crawled 3852 pages (at 228 pages/min), scraped 256 items (at 15 items/min) I'm not understanding the reason of this big difference between Crawled pages and Scraped items. Anybody can help me to realize where that items are getting lost?My spider code:

2013-04-11 20:03:43Z

Im writing a Scrapy CrawlSpider that reads a list of ADs on first page, takes some info like thumbs of the listings and AD urls, then yields a request to each of this AD urls to take their details. It was working and paginating apparently well on test enviroment, but today trying to make a complete run I realized that in log: Crawled 3852 pages (at 228 pages/min), scraped 256 items (at 15 items/min) I'm not understanding the reason of this big difference between Crawled pages and Scraped items. Anybody can help me to realize where that items are getting lost?My spider code:Let's say you go to your first start_urls (actually you only have one) and on this page there is only one anchor link (<a>).  So your spider crawls the href url in this link and you get control in your callback, parse_start_url.  And inside of this page you have 5000 div's with an hlist class.  And let's suppose all 5000 of these subsequent URLs were returned 404, not found.In this case  you would have:Let's take another example: on your start url page you have 5000 anchors, but none (as in zero) of those pages have any divs with a class parameter of hlist.In this case  you would have:Your answer lies in the DEBUG log output.

Run Multiple Spider sequentially

Huazhe Yin

[Run Multiple Spider sequentially](https://stackoverflow.com/questions/36109400/run-multiple-spider-sequentially)

The above is the architecture of my spider.py file. and i am trying to run the Myspider1 first and then run the Myspider2 multiples times depend on some conditions. How Could I do that??? any tips? I am trying to use this way.but have no idea how to run it. Should I run the cmd on the cmd(what commands?) or just run the python file??thanks a lot!!!

2016-03-20 01:50:40Z

The above is the architecture of my spider.py file. and i am trying to run the Myspider1 first and then run the Myspider2 multiples times depend on some conditions. How Could I do that??? any tips? I am trying to use this way.but have no idea how to run it. Should I run the cmd on the cmd(what commands?) or just run the python file??thanks a lot!!!run the python file

for example:

test.pyNow run python test.py > output.txt

You can observe from the output.txt that your spiders run sequentially.You need to use the Deferred object returned by process.crawl(), which allows you to add a callback when the crawl is finished.Here is my code

Scrapy process.crawl() to export data to json

Carele

[Scrapy process.crawl() to export data to json](https://stackoverflow.com/questions/37876514/scrapy-process-crawl-to-export-data-to-json)

This might be a subquestion of Passing arguments to process.crawl in Scrapy python but the author marked the answer (that doesn't answer the subquestion i'm asking myself) as a satisfying one.Here's my problem : I cannot use scrapy crawl mySpider -a start_urls(myUrl) -o myData.json

Instead i want/need to use crawlerProcess.crawl(spider) I have already figured out several way to pass the arguments (and anyway it is answered in the question I linked) but i can't grasp how i am supposed to tell it to dump the data into myData.json... the -o myData.json part

Anyone got a suggestion ? Or am I just not understanding how it is supposed to work..?Here is the code :

2016-06-17 08:19:12Z

This might be a subquestion of Passing arguments to process.crawl in Scrapy python but the author marked the answer (that doesn't answer the subquestion i'm asking myself) as a satisfying one.Here's my problem : I cannot use scrapy crawl mySpider -a start_urls(myUrl) -o myData.json

Instead i want/need to use crawlerProcess.crawl(spider) I have already figured out several way to pass the arguments (and anyway it is answered in the question I linked) but i can't grasp how i am supposed to tell it to dump the data into myData.json... the -o myData.json part

Anyone got a suggestion ? Or am I just not understanding how it is supposed to work..?Here is the code :You need to specify it on the settings:

Formatting Scrapy's output to XML

Nic Young

[Formatting Scrapy's output to XML](https://stackoverflow.com/questions/13962881/formatting-scrapys-output-to-xml)

So I am attempting to export data scraped from a website using Scrapy to be in a particular format when I export it to XML.Here is what I would like my XML to look like:I am running my scrape by using the command:The current output I am getting is along the lines of:As you can see it is adding the <value> fields and I am not able to rename the root nodes or item nodes. I know that I need to use XmlItemExporter, but I am not sure how to go about implementing this in my project. I have tried to add it to the pipelines.py as it is shown here but I always end up with with the error: AttributeError: 'CrawlerProcess' object has no attribute 'signals' Does any body know of examples of how to reformat the data when exporting it to XML using the XmlItemExporter?Edit:Showing my XmlItemExporter in my piplines.py module:Edit (Showing modifications and Traceback):I modified the spider_opened function:The trace back I get is:

2012-12-19 23:19:36Z

So I am attempting to export data scraped from a website using Scrapy to be in a particular format when I export it to XML.Here is what I would like my XML to look like:I am running my scrape by using the command:The current output I am getting is along the lines of:As you can see it is adding the <value> fields and I am not able to rename the root nodes or item nodes. I know that I need to use XmlItemExporter, but I am not sure how to go about implementing this in my project. I have tried to add it to the pipelines.py as it is shown here but I always end up with with the error: AttributeError: 'CrawlerProcess' object has no attribute 'signals' Does any body know of examples of how to reformat the data when exporting it to XML using the XmlItemExporter?Edit:Showing my XmlItemExporter in my piplines.py module:Edit (Showing modifications and Traceback):I modified the spider_opened function:The trace back I get is:You can make XmlItemExporter do most of what you want simply by supplying the names of the nodes you want:See the documentation.The problem you have with value elements in your fields is because those fields are not scalar values. If XmlItemExporter encounters a scalar value, it simply outputs <fieldname>data</fieldname>, but if it encounters an iterable value, it will serialize like this: <fieldname><value>data1</value><value>data2</value></fieldname>.  The solution is to stop emitting non-scalar field values for your items.If you aren't willing to do this, subclass XmlItemExporter and override its _export_xml_field method to do what you want when the item value is iterable. This is the code for XmlItemExporter so you can see the implementation.

What is the best way to download <very large> number of pages from a list of urls?

Anuvrat Parashar

[What is the best way to download <very large> number of pages from a list of urls?](https://stackoverflow.com/questions/16957276/what-is-the-best-way-to-download-very-large-number-of-pages-from-a-list-of-url)

I have a >100,000 urls (different domains) in a list that I want to download and save in a database for further processing and tinkering.Would it be wise to use scrapy instead of python's multiprocessing / multithreading? If yes, how do I write a standalone script to do the same?Also, feel free to suggest other awesome approaches that come to your mind. 

2013-06-06 08:32:16Z

I have a >100,000 urls (different domains) in a list that I want to download and save in a database for further processing and tinkering.Would it be wise to use scrapy instead of python's multiprocessing / multithreading? If yes, how do I write a standalone script to do the same?Also, feel free to suggest other awesome approaches that come to your mind. Scrapy does not seem relevant here if you know very well the URL to fetch (there's is no crawling involved here).The easiest way that comes to mind would be to use Requests. However, querying each URL in a sequence and block waiting for answers wouldn't be efficient, so you could consider GRequests to send batches of requests asynchronously.Most site owners try to block you crawler if you suddenly create hi-load. So even if you have fixed list of links you need control timeouts, http answer codes, proxies and etc. on scrapy or grabScrapy is still an option.But, at the same time, Scrapy might be an overhead. Remember that Scrapy was designed (and great at) to crawl, scrape the data from the web page. If you want just to download a bunch of pages without looking into them - then yes, grequests is a good alternative.AFAIK, with Scrapy, it's not possible if the URL list does not fit in memory.This should be possible to do with minet:

Can't get through a form with scrapy

Serphone

[Can't get through a form with scrapy](https://stackoverflow.com/questions/11213467/cant-get-through-a-form-with-scrapy)

I'm new with using scrapy and i'm trying to get some info from a real estate website. 

The site has a home page with a search form (method GET).

I'm trying to go to the results page in my start_requests (recherche.php), and setting all the get parameters i see in the address bar in the formdata parameter. 

I also set up the cookies i had, but he didn't work either..Here's my spider:When i run the spider, there is no problem, but the page loaded is not the good one (it's saying "Please specify your search" and i don't get any results..)Thanks for your help !

2012-06-26 18:13:02Z

I'm new with using scrapy and i'm trying to get some info from a real estate website. 

The site has a home page with a search form (method GET).

I'm trying to go to the results page in my start_requests (recherche.php), and setting all the get parameters i see in the address bar in the formdata parameter. 

I also set up the cookies i had, but he didn't work either..Here's my spider:When i run the spider, there is no problem, but the page loaded is not the good one (it's saying "Please specify your search" and i don't get any results..)Thanks for your help !I would use FormRequest.from_response() which does all the job for you, as you could still miss some fields:In your log output it says that the spider made a POST request to http://www.elyseavenue.com/recherche.php, but you said the form uses GET. Sure enough if you make a POST request to the URL and search for the "Please specify your search":FormRequest is a subclass of Request, which allows you to specify the request type. You should specify GET, like:

Scrapy handle 302 response code

bawejakunal

[Scrapy handle 302 response code](https://stackoverflow.com/questions/35330707/scrapy-handle-302-response-code)

I am using a simple CrawlSpider implementation to crawl websites. By default Scrapy follows 302 redirects to target locations and kind of ignores the originally requested link. On a particular site I encountered a page which 302 redirects to another page. What I aim to do is log both the original link(which responds 302) and the target location(specified in HTTP response header) and process them in parse_item method of CrawlSpider. Please guide me, how can I achieve this ?I came across solutions mentioning to use dont_redirect=True or REDIRECT_ENABLE=False but I do not actually want to ignore the redirects, in fact I want to consider(i.e not ignore) the redirecting page as well.eg: I visit http://www.example.com/page1 which sends a 302 redirect HTTP response and redirects to http://www.example.com/page2. By default, scrapy ignore page1, follows to page2 and processes it. I want to process both page1 and page2 in parse_item.EDIT

I am already using handle_httpstatus_list = [500, 404] in class definition of spider to handle 500 and 404 response codes in parse_item, but the same is not working for 302 if I specify it in handle_httpstatus_list.

2016-02-11 04:18:10Z

I am using a simple CrawlSpider implementation to crawl websites. By default Scrapy follows 302 redirects to target locations and kind of ignores the originally requested link. On a particular site I encountered a page which 302 redirects to another page. What I aim to do is log both the original link(which responds 302) and the target location(specified in HTTP response header) and process them in parse_item method of CrawlSpider. Please guide me, how can I achieve this ?I came across solutions mentioning to use dont_redirect=True or REDIRECT_ENABLE=False but I do not actually want to ignore the redirects, in fact I want to consider(i.e not ignore) the redirecting page as well.eg: I visit http://www.example.com/page1 which sends a 302 redirect HTTP response and redirects to http://www.example.com/page2. By default, scrapy ignore page1, follows to page2 and processes it. I want to process both page1 and page2 in parse_item.EDIT

I am already using handle_httpstatus_list = [500, 404] in class definition of spider to handle 500 and 404 response codes in parse_item, but the same is not working for 302 if I specify it in handle_httpstatus_list.Scrapy 1.0.5 (latest official as I write these lines) does not use handle_httpstatus_list in the built-in RedirectMiddleware -- see this issue.

From Scrapy 1.1.0 (1.1.0rc1 is available), the issue is fixed.Even if you disable redirects, you can still mimic its behavior in your callback, checking the Location header and returning a Request to the redirectionExample spider:Console log:Note that you'll need http_handlestatus_list with 302 in it, otherwise, you'll see this kind of log (coming from HttpErrorMiddleware):The redirect middleware will "catch" the response before it reaches your httperror middleware and launch a new request with the redirect url. At the same time the original response is not returned i.e., you don't even "see" the 302 codes as they don't reach httperror. Thus having 302 in handle_httpstatus_list has no effect.Have a look at its source in scrapy.downloadermiddlewares.redirect.RedirectMiddleware: In process_response(), you see what is happening. It launches a new request and replaces the original URL with the redirected_url. No "return response" -> the original response just gets discarded.Basically you just need to overwrite the process_response() function by adding a line with "return response", in addition to sending another request with the redirected_url.In parse_item, you probably want to set some conditional statements, depending if it is a redirect or not? I suppose it will not be exactly look the same, so maybe your item will also look quite different. Another option could also be to use a different parser for either response (depending on if the original or redirected url are "special pages"), all you then need is to have a different parse function e.g., parse_redirected_urls(), in your spider and call that parse function via callback in the redirect request

Web crawler update strategy

superb

[Web crawler update strategy](https://stackoverflow.com/questions/2576785/web-crawler-update-strategy)

I want to crawl useful resource (like background picture .. ) from certain websites. It is not a hard job, especially with the help of some wonderful projects like scrapy.The problem here is I not only just want crawl this site ONE TIME. I also want to keep my crawl long running and crawl the updated resource. So I want to know is there any good strategy for a web crawler to get updated pages?Here's a coarse algorithm I've thought of. I divided the crawl process into rounds. Each round URL repository will give crawler a certain number (like , 10000) of URLs to crawl. And then next round. The detailed steps are:To further specify that, I still need to solve following question:

How to decide the "refresh-ness" of a web page, which indicates the probability that this web page has been updated ?Since that is an open question, hopefully it will brought some fruitful discussion here.

2010-04-05 03:28:55Z

I want to crawl useful resource (like background picture .. ) from certain websites. It is not a hard job, especially with the help of some wonderful projects like scrapy.The problem here is I not only just want crawl this site ONE TIME. I also want to keep my crawl long running and crawl the updated resource. So I want to know is there any good strategy for a web crawler to get updated pages?Here's a coarse algorithm I've thought of. I divided the crawl process into rounds. Each round URL repository will give crawler a certain number (like , 10000) of URLs to crawl. And then next round. The detailed steps are:To further specify that, I still need to solve following question:

How to decide the "refresh-ness" of a web page, which indicates the probability that this web page has been updated ?Since that is an open question, hopefully it will brought some fruitful discussion here.The "batch" algorithm you describe is a common way to implement this, I have worked on a few such implementations with scrapy.The approach I took is to initialize your spider start URLs to get the next batch to crawl and output the data (resources + links) as normal. Then process these as you choose to generate the next batch. It is possible to parallelize all of this, so you have many spiders crawling different batches at once, if you put URLs belonging to the same site in the same batch, then scrapy will take care of politeness (with some configuration for your preferences).An interesting tweak is to break the scheduling into short term (within a single batch, inside scrapy) and long term (between crawl batches), giving some of the advantages of a more incremental approach, while keeping things a little simpler.There are many approaches to the crawl ordering problem (how to decide the "refresh-ness") you mention, and the best approach depends on what your priorities are (freshness vs. comprehensiveness, are come resources more important than others, etc.).I would like to recommend this Web Crawling article by Christopher Olston and Marc Najork. It's a great survey and covers the topics you are interested in (the batch crawling model and crawl ordering).

What is a good crawling speed rate?

Nilesh Guria

[What is a good crawling speed rate?](https://stackoverflow.com/questions/49494093/what-is-a-good-crawling-speed-rate)

I'm crawling web pages to create a search engine and have been able to crawl close to 9300 pages in 1 hour using Scrapy. I'd like to know how much more can I improve and what value is considered as a 'good' crawling speed.

2018-03-26 14:38:24Z

I'm crawling web pages to create a search engine and have been able to crawl close to 9300 pages in 1 hour using Scrapy. I'd like to know how much more can I improve and what value is considered as a 'good' crawling speed.Short answer: There is no real recommended speed for creating a search engine.Long answer:Crawling speed, in general, doesn't really determine if your crawler is good or bad, or even if it will work as the program that feeds your search engine.You also cannot talk about crawling speed when talking to crawl a lot of pages, on multiple sites. Crawling speed should be determined per site only, meaning that the crawler should be configurable in a way that it can be changed how often it hits a site at any specific time, you can see that Google also offers this.If we are talking about the current rate you mentioned (9300/hour), it means you are collecting ~2.5 pages per second, which I would say it is not bad, but as explained before, it doesn't help determine your end goal (create a search engine).Also, if you really decide to implement a broad crawler for creating a search engine with Scrapy, you'll never only send 1 process with Scrapy. You'll need to setup thousands (even more) of spiders running to check to get the more information needed. Also you'll have to setup different services to help you maintain those spiders and how they behave between processes. For starters I would recommend checking Frontera and Scrapyd.I'm no expert but I would say that your speed is pretty slow. I just went to google, typed in the word "hats", pressed enter and: about 650,000,000 results (0.63 seconds). That's gonna be tough to compete with. I'd say that there's plenty of room to improve.

How to control the order of yield in Scrapy

Aero Kang

[How to control the order of yield in Scrapy](https://stackoverflow.com/questions/33875339/how-to-control-the-order-of-yield-in-scrapy)

Help! Reading the following scrapy code and the result of crawler. I want to crawl some data from http://china.fathom.info/data/data.json, and only Scrapy is allowed. But I don't know how to control the order of yield. I look forward to process all parse_member request in the loop and then return the group_item, but seems yield item is always executed before yield request.Data on MongoDB

2015-11-23 16:02:37Z

Help! Reading the following scrapy code and the result of crawler. I want to crawl some data from http://china.fathom.info/data/data.json, and only Scrapy is allowed. But I don't know how to control the order of yield. I look forward to process all parse_member request in the loop and then return the group_item, but seems yield item is always executed before yield request.Data on MongoDByou need to yield the item on the final callback, parse isn't stopping for parse_member to finish, so the group_item in parse isn't changing while parse_member is working.Don't yield the group_item of parse, just the one on parse_member, as you already copied the previous item on meta and you already recovered it on parse_member with response.meta['group_item']

Handling Error Pages in Scrapy

Crypto

[Handling Error Pages in Scrapy](https://stackoverflow.com/questions/20877621/handling-error-pages-in-scrapy)

I have one URL in start_urlsThe first time the crawler loads the page, it is first shown a 403 error page after which the crawler shuts down.What I need to do is fill out a captcha on that page and it will then let me access the page. I know how to write the code for bypassing the captcha but where do I put this code in my spider class?I need to add this on other pages as well when it encounters the same problem.

2014-01-02 06:36:22Z

I have one URL in start_urlsThe first time the crawler loads the page, it is first shown a 403 error page after which the crawler shuts down.What I need to do is fill out a captcha on that page and it will then let me access the page. I know how to write the code for bypassing the captcha but where do I put this code in my spider class?I need to add this on other pages as well when it encounters the same problem.Set handle_httpstatus_list to treat 403 a successful response code:As for bypassing the actual captcha, you need to override parse to handle all pages with a 403 response code differently:

how to fetch content in web crawling

Ka Mal

[how to fetch content in web crawling](https://stackoverflow.com/questions/32773229/how-to-fetch-content-in-web-crawling)

Hi! I am trying to implement this pseudocode  for spider algorithm for exploring the web. 

Need some idea for my next step of pseudocode : "use SpiderLeg to fetch content" , 

i have a method in another class SpiderLeg which has a method to get all the URLs of that webpage but wondering how can i use it in this class??Cheers!! Will try that...However I tried this without using queue D.S, it's almost working but doesn't stop the program while searching for some word. And when it finds it shows just the link of Webpage not all the specific URLs where it finds the word. 

Wondering is it possible to do this way? 

2015-09-25 01:05:05Z

Hi! I am trying to implement this pseudocode  for spider algorithm for exploring the web. 

Need some idea for my next step of pseudocode : "use SpiderLeg to fetch content" , 

i have a method in another class SpiderLeg which has a method to get all the URLs of that webpage but wondering how can i use it in this class??Cheers!! Will try that...However I tried this without using queue D.S, it's almost working but doesn't stop the program while searching for some word. And when it finds it shows just the link of Webpage not all the specific URLs where it finds the word. 

Wondering is it possible to do this way? The crawling algorithm is essentially Breadth first search, you will need to maintain a queue of unvisited URL's and each time you visit a URL you de-queue it and you will need to en-queue any unvisited URL's that you find from your HTML parser (SpiderLeg). The conditions for adding a URL to the queue are up to you but typically you would need to hold the distance of the URL's from the seed URL's as a stopping point so you aren't forever traversing the web. These rules may also include specifics on what you are interested in searching so that you only add URL's that are relevant. 

how to extract asin from an amazon product page

Lior Magen

[how to extract asin from an amazon product page](https://stackoverflow.com/questions/33625602/how-to-extract-asin-from-an-amazon-product-page)

I have the following webpage Product page and I'm trying to get the ASIN from it (in this case ASIN=B014MHZ90M) and I don't have a clue on how to get it from the page. I'm using Python 3.4, Scrapy and the following code:In this way I don't get the required field (the ASIN number).

1. What should I do in order to get the product model (ASIN)?2.Is there a way to debug such code (I'm using PyCharm). I could not use debugger but only run it without seeing what's going on there in 'slow motion'.Thank everyone in advance.

2015-11-10 08:24:46Z

I have the following webpage Product page and I'm trying to get the ASIN from it (in this case ASIN=B014MHZ90M) and I don't have a clue on how to get it from the page. I'm using Python 3.4, Scrapy and the following code:In this way I don't get the required field (the ASIN number).

1. What should I do in order to get the product model (ASIN)?2.Is there a way to debug such code (I'm using PyCharm). I could not use debugger but only run it without seeing what's going on there in 'slow motion'.Thank everyone in advance.Looking at the Amazon page you linked, the ASIN number appears in the "Product Details" section. Using the scrapy shell the following xpathreturnsFor debugging XPATHs I always use scrapy shell and Firebug for Firefox.you can extract B014MHZ90M from the response.urlresponse.url.split("/dp/")[1] = B014MHZ90Mresponse.url.split("/dp/")[0] = http://www.amazon.comI use this:You can get that from the url.https://www.amazon.com/gp/seller/asin-upc-isbn-info.htmlYour best option and probably the easiest one is to run a regex on the URL looking for a 10 char string between two "/".You can then simply omit the "/"s from the result.

scrapy, how to separate text within a HTML tag element

HeadAboutToExplode

[scrapy, how to separate text within a HTML tag element](https://stackoverflow.com/questions/18609267/scrapy-how-to-separate-text-within-a-html-tag-element)

Code containing my data:**i want to getplace name: Century Square, Liat Towersaddress : 2 Tampines Central 5, 541 Liat towers #01-01postal code: Singapore 529509, Singapore 238888Opening hours: 7-12am, 24 hours daily**For example:the first <"p> in '<"td valign="top">' have 3 data which i want (name,adress,postal).

How do i split them?here is my spider code:

2013-09-04 08:47:12Z

Code containing my data:**i want to getplace name: Century Square, Liat Towersaddress : 2 Tampines Central 5, 541 Liat towers #01-01postal code: Singapore 529509, Singapore 238888Opening hours: 7-12am, 24 hours daily**For example:the first <"p> in '<"td valign="top">' have 3 data which i want (name,adress,postal).

How do i split them?here is my spider code:I would select all <td valign="top"> which contain a <span class="foodTitle">and then for each one of these td cell, get all text nodesYou get something like that:and Some of these text node have a string representation that is all whitespace, so strip them and look for "Opening hours" and "Telephone" keywords to process lines in a loop:

XPath to select an element if previous element contain a matching text() - Python, Scrapy

chheplo

[XPath to select an element if previous element contain a matching text() - Python, Scrapy](https://stackoverflow.com/questions/11766519/xpath-to-select-an-element-if-previous-element-contain-a-matching-text-pytho)

I want to extract an element if the previous elements text() matches specific criteria. for example,Now, I want to extract the URL if the previous  element has "Website:  " in text() properties. 

I am using python 2.x with scrapy 0.14. I was able to extract data using individual element such asBut this approach fails if the website parameter is missing and the tr[3] shift upward and i get 'Type' in website element and 'Awards offered' in Type.Is there a specific command in xPath like,Thanks in advance.

2012-08-01 19:50:13Z

I want to extract an element if the previous elements text() matches specific criteria. for example,Now, I want to extract the URL if the previous  element has "Website:  " in text() properties. 

I am using python 2.x with scrapy 0.14. I was able to extract data using individual element such asBut this approach fails if the website parameter is missing and the tr[3] shift upward and i get 'Type' in website element and 'Awards offered' in Type.Is there a specific command in xPath like,Thanks in advance.For python and scrapy you should use following to select "Type" field,

worked great for me.div/table[@class="layouttab"]\tr\td[text()="Website"]\following-sibling::node() will work, I think.  Otherwise, you could user parent and go to td[2] from there.The following XPath will do:This works for me:This will also work.. And is more generic..If there is only one table on the page where u are extracting data then this will also work..

How to remove u'' from python script result?

Gennadich

[How to remove u'' from python script result?](https://stackoverflow.com/questions/3329631/how-to-remove-u-from-python-script-result)

I'm trying to write parsing script using python/scrapy. How can I remove [] and u' from strings in result file?Now I have text like this:and I have result like this after running and this text in file:

2010-07-25 14:55:01Z

I'm trying to write parsing script using python/scrapy. How can I remove [] and u' from strings in result file?Now I have text like this:and I have result like this after running and this text in file:more prettier - print qqq.pop()Replace print qqq with print qqq[0]. You get that result because qqq is a list.Same problem with your text file. You have a list with one element that you're writing instead of the element within the list.It looks like the result from extract is a list.  Try:The u infront of the code, purely means it's a unicode string. See the reference here. http://docs.python.org/tutorial/introduction.html#unicode-strings. The fix would be to convert your content to a string using the str() method.

How to use Scrapy

Laurențiu Dascălu

[How to use Scrapy](https://stackoverflow.com/questions/3773035/how-to-use-scrapy)

I would like to know how can I start a crawler based on Scrapy. I installed the tool via apt-get install and I tried to run an example:I hacked the code from spiders/google_directory.py but it seems that it is not executed, because I don't see any prints that I inserted. I read their documentation, but I found nothing related to this; do you have any ideas?Also, if you think that for crawling a website I should use other tools, please let me know. I'm not experienced with Python tools and Python is a must.Thanks!

2010-09-22 19:46:14Z

I would like to know how can I start a crawler based on Scrapy. I installed the tool via apt-get install and I tried to run an example:I hacked the code from spiders/google_directory.py but it seems that it is not executed, because I don't see any prints that I inserted. I read their documentation, but I found nothing related to this; do you have any ideas?Also, if you think that for crawling a website I should use other tools, please let me know. I'm not experienced with Python tools and Python is a must.Thanks!You missed the spider name in the crawl command. Use:Also, I suggest you copy the example project to your home, instead of working in the /usr/share/doc/scrapy/examples/ directory, so you can modify it and play with it:EveryBlock.com released some quality scraping code using lxml, urllib2 and Django as their stack.Scraperwiki.com is inspirational, full of examples of python scrapers.Simple example with cssselect:

Scrapy response incomplete

user2628641

[Scrapy response incomplete](https://stackoverflow.com/questions/35370674/scrapy-response-incomplete)

I tried to crawl the following URL using Scrapy:

http://www.walgreens.com/search/results.jsp?Ntt=bounty+paper+towelbut the returned URL is not complete. Because when I dothen The webpage just doesn't load completely.  So my question is:

2016-02-12 19:25:33Z

I tried to crawl the following URL using Scrapy:

http://www.walgreens.com/search/results.jsp?Ntt=bounty+paper+towelbut the returned URL is not complete. Because when I dothen The webpage just doesn't load completely.  So my question is:The data for that page seems to be loaded in with javascript. If you inspect the page (e.g. firebug network tab) you'll see that once the base page is loaded the products are being loaded in by javascript which sends a POST request to http://www.walgreens.com/svc/products/search with contents:You can just send this request using scrapy as:And you should receive a json object full of product data.You can actually even view the response in the browser via this link:

http://www.walgreens.com/svc/products/search?p=1&s=15&sort=relevance&view=allView&geoTargetEnabled=false&q=bounty%20paper%20towel&requestType=search&deviceType=desktop

Callback for redirected requests Scrapy

a'-

[Callback for redirected requests Scrapy](https://stackoverflow.com/questions/35810260/callback-for-redirected-requests-scrapy)

I am trying to scrape using scrape framework. Some requests are redirected but the callback function set in the start_requests is not called for these redirected url requests but works fine for the non-redirected ones.I have the following code in the start_requests function:But this self.parse_p is called only for the Non-302 requests.

2016-03-05 05:04:00Z

I am trying to scrape using scrape framework. Some requests are redirected but the callback function set in the start_requests is not called for these redirected url requests but works fine for the non-redirected ones.I have the following code in the start_requests function:But this self.parse_p is called only for the Non-302 requests.I guess you get a callback for the final page (after the redirect). Redirects are been taken care by the RedirectMiddleware. You could disable it and then you would have to do all the redirects manually. If you wanted to selectively disable redirects for a few types of Requests you can do it like this:I'm not sure that the intermediate Requests/Responses are very interesting though. That's also what RedirectMiddleware believes. As a result, it does the redirects automatically and saves the intermediate URLs (the only interesting thing) in:You have a few options!Example spider:Example output...If you really want to scrape the 302 pages, you have to explicitcly allow it. For example here, I allow 302 and set dont_redirect to True:The end result is:This spider should manually follow 302 urls:Be careful. Don't omit setting handle_httpstatus_list = [302] otherwise you will get "HTTP status code is not handled or not allowed".By default, scrapy is not following 302 redirects.In your spider you can make use of the custom_settings attribute:Set the number of redirects that a url request can be redirected as follows:I set 333 as an example limit.I hope this helps.

Avoid bad requests due to relative urls

SylvainB

[Avoid bad requests due to relative urls](https://stackoverflow.com/questions/19769215/avoid-bad-requests-due-to-relative-urls)

I am trying to crawl a website using Scrapy, and the urls of every page I want to scrap are all written using a relative path of this kind:Now, in my browser, these links work, and you get to urls like https://www.domain-name.com/en/item-to-scrap.html (despite the relative path going back up twice in hierarchy instead of once)But my CrawlSpider does not manage to translate these urls into a "correct" one, and all I get is errors of that kind:Is there a way to fix this, or am I missing something?Here is my spider's code, fairly basic (on the basis of item urls matching "/en/item-*-scrap.html") :

2013-11-04 13:54:26Z

I am trying to crawl a website using Scrapy, and the urls of every page I want to scrap are all written using a relative path of this kind:Now, in my browser, these links work, and you get to urls like https://www.domain-name.com/en/item-to-scrap.html (despite the relative path going back up twice in hierarchy instead of once)But my CrawlSpider does not manage to translate these urls into a "correct" one, and all I get is errors of that kind:Is there a way to fix this, or am I missing something?Here is my spider's code, fairly basic (on the basis of item urls matching "/en/item-*-scrap.html") :Basically deep down, scrapy uses http://docs.python.org/2/library/urlparse.html#urlparse.urljoin for getting the next url by joining currenturl and url link scrapped. And if you join the urls provided you mentioned as example, the returned url is same as url mentioned in error scrapy error. Try this in python shell.The urljoin behaviour seems to be valid. See : http://tools.ietf.org/html/rfc1808.html#section-5.2If it is possible, can you pass the site, which you are crawling ? With this understanding, the solutions can be, 1) Manipulate the urls(remove those two dots and slash).  generated in crawl spider. Basically override parse or _request_to_folow. Source of crawl spider:  https://github.com/scrapy/scrapy/blob/master/scrapy/contrib/spiders/crawl.py2) Manipulate the url in the downloadmiddleware, this might be cleaner. You remove the ../ in the process_request of the downloadmiddleware. Documentation for downloadmiddleware : http://scrapy.readthedocs.org/en/0.16/topics/downloader-middleware.html3) Use base spider and also return the manipulated url requests you want to crawl furtherDocumentation for the basespider : http://scrapy.readthedocs.org/en/0.16/topics/spiders.html#basespiderPlease let me know if you have any questions. I finally found a solution thanks to this answer. I used process_links as follows:

error in scrapy web crawler tutorial

Yogesh D

[error in scrapy web crawler tutorial](https://stackoverflow.com/questions/21544926/error-in-scrapy-web-crawler-tutorial)

I am doing this simple scrapy crawler tutorial given on scrapy official website but getting some errors. I am doing this thing first time so completely unknown about all this. I need to implement web crawler in my application and i found scrapy to accomplish my needs so started with the tutorial and ended upon the error i have pasted below. Can any one please explain me whats wrong with the code..?  THIS IS MY CRAWLER CODETHIS IS THE ERROR I AM GETTING2014-02-04 10:45:51+0530 [scrapy] DEBUG: Web service listening on 0.0.0.0:6080

2014-02-04 10:45:51+0530 [dmoz] DEBUG: Crawled (200) http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/> (referer: None)ERROR: Spider error processing http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/>

    Traceback (most recent call last):

      File "/usr/lib/python2.7/dist-packages/twisted/internet/base.py", line 1178, in mainLoop

        self.runUntilCurrent()

      File "/usr/lib/python2.7/dist-packages/twisted/internet/base.py", line 800, in runUntilCurrent

        call.func(*call.args, **call.kw)

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 362, in callback

        self._startRunCallbacks(result)

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 458, in _startRunCallbacks

        self._runCallbacks()

    ---  ---

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 545, in _runCallbacks

        current.result = callback(current.result, *args, **kw)

      File "/usr/local/lib/python2.7/dist-packages/scrapy/spider.py", line 56, in parse

        raise NotImplementedError

    exceptions.NotImplementedError: 

2014-02-04 05:51:44Z

I am doing this simple scrapy crawler tutorial given on scrapy official website but getting some errors. I am doing this thing first time so completely unknown about all this. I need to implement web crawler in my application and i found scrapy to accomplish my needs so started with the tutorial and ended upon the error i have pasted below. Can any one please explain me whats wrong with the code..?  THIS IS MY CRAWLER CODETHIS IS THE ERROR I AM GETTING2014-02-04 10:45:51+0530 [scrapy] DEBUG: Web service listening on 0.0.0.0:6080

2014-02-04 10:45:51+0530 [dmoz] DEBUG: Crawled (200) http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/> (referer: None)ERROR: Spider error processing http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/>

    Traceback (most recent call last):

      File "/usr/lib/python2.7/dist-packages/twisted/internet/base.py", line 1178, in mainLoop

        self.runUntilCurrent()

      File "/usr/lib/python2.7/dist-packages/twisted/internet/base.py", line 800, in runUntilCurrent

        call.func(*call.args, **call.kw)

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 362, in callback

        self._startRunCallbacks(result)

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 458, in _startRunCallbacks

        self._runCallbacks()

    ---  ---

      File "/usr/lib/python2.7/dist-packages/twisted/internet/defer.py", line 545, in _runCallbacks

        current.result = callback(current.result, *args, **kw)

      File "/usr/local/lib/python2.7/dist-packages/scrapy/spider.py", line 56, in parse

        raise NotImplementedError

    exceptions.NotImplementedError: this error means you didn't implement parse function in your spider, on the other hand according to the posted code it seem that you did, leading me to think you are having an indentation issue causing the code to believe parse function is not a part of DmozSpider class

Scrapy: Can't strip unicode from my item data (price)

Demandar

[Scrapy: Can't strip unicode from my item data (price)](https://stackoverflow.com/questions/33247625/scrapy-cant-strip-unicode-from-my-item-data-price)

I'm building a scrapper to get the product prices from a website.At the moment I have the following code:And here is the json output:I've tried encoding("utf-8"), strip, replaces, but nothing seems to work.My question is: How do I make that output readable. Either make "5.00 €" ( \u20ac) or just "5.00"Thanks in advance!

2015-10-20 22:04:19Z

I'm building a scrapper to get the product prices from a website.At the moment I have the following code:And here is the json output:I've tried encoding("utf-8"), strip, replaces, but nothing seems to work.My question is: How do I make that output readable. Either make "5.00 €" ( \u20ac) or just "5.00"Thanks in advance!Simplest way may be to split once and replace any comma with a decimal:That will leave you with 5.00. Because you have a * in the string strip would not work, you could pass that character to strip i,e [0].rstrip("\n* ") but if there were other errant chars that would break.If you want the euro sign too, you can decode('unicode-escape'):If you want to combine it with split and keep the sign, also formatting it a bit nicer:Which will give you:

Using Scrapy for to get background image on CSS Style sheet

Roxy

[Using Scrapy for to get background image on CSS Style sheet](https://stackoverflow.com/questions/33027687/using-scrapy-for-to-get-background-image-on-css-style-sheet)

I am starting to use Scrapy, a crawling library for Python. After searching a lot, I still haven't found a way to crawl background-images in CSS style-sheets. For example, let's suppose I need the url of the store image from this store. By inspecting it, I realized that the image URL I need is here (in the CSS style sheet):How do I get to crawl "http://images.apple.com/retail/alamoana/images/alamoana_hero_medium.jpg" by using xpath on:which is the figure that contains the image as a background-image.Or what is the best way to get the store image URL?Thanks in advance!

2015-10-08 23:41:21Z

I am starting to use Scrapy, a crawling library for Python. After searching a lot, I still haven't found a way to crawl background-images in CSS style-sheets. For example, let's suppose I need the url of the store image from this store. By inspecting it, I realized that the image URL I need is here (in the CSS style sheet):How do I get to crawl "http://images.apple.com/retail/alamoana/images/alamoana_hero_medium.jpg" by using xpath on:which is the figure that contains the image as a background-image.Or what is the best way to get the store image URL?Thanks in advance!The solution is: there is no way to get the image with XPath from the site.As you already found the image URL is located in the CSS of the site. This means you have to load the CSS file with Scrapy and parse the response which is now a CSS content and not an XML meaning you cannot use XPath on a non-XML document.However there are some libraries which could be used to parse the CSS -- so based on the class attribute of the figure tag you can find the appropriate CSS class definition and extract the background image from there.

How to store the URLs crawled with Scrapy?

Marc

[How to store the URLs crawled with Scrapy?](https://stackoverflow.com/questions/15106029/how-to-store-the-urls-crawled-with-scrapy)

I have a web crawler that crawls for news stories on a web page. I know how to use the XpathSelector to scrape certain information from the elements in the page. However I cannot seem to figure out how to store the URL of the page that was just crawled.I want to store every link that passes those rule. What would I need to add to parse_articles to store the link in my item?

2013-02-27 07:00:55Z

I have a web crawler that crawls for news stories on a web page. I know how to use the XpathSelector to scrape certain information from the elements in the page. However I cannot seem to figure out how to store the URL of the page that was just crawled.I want to store every link that passes those rule. What would I need to add to parse_articles to store the link in my item?response.url is what you are looking for. See docs on response object and check this simple example.

scrapy crawling just 1 level of a web-site

riship89

[scrapy crawling just 1 level of a web-site](https://stackoverflow.com/questions/9406895/scrapy-crawling-just-1-level-of-a-web-site)

I am using scrapy to crawl all the web pages under a domain.I have seen this question. But there is no solution. My problem seems to be similar one. My output of crawl command looks like this:Problem here is the crawl finds links from first page, but does not visit them. Whats the use of such a crawler.EDIT:My crawler code is:All of my other settings are default.

2012-02-23 03:50:13Z

I am using scrapy to crawl all the web pages under a domain.I have seen this question. But there is no solution. My problem seems to be similar one. My output of crawl command looks like this:Problem here is the crawl finds links from first page, but does not visit them. Whats the use of such a crawler.EDIT:My crawler code is:All of my other settings are default.I think the best way to do this is by using a Crawlspider. So you have to modify your code to this below to be able to find all links from the first page and visit them:If you want to crawl all the links in the website (and not only those in the first level),

you have to add a rule to follow every link, so you have to change the rules variable to

this one:I have changed your 'parse' callback to 'parse_item' because of this:For more information you can see this: http://doc.scrapy.org/en/0.14/topics/spiders.html#crawlspiderif u are using basespider, in the parse method/ callback, you need to extract your desired urls and return Request objects if you intend to visit these urls. what parse does is to return you the response and you have to tell what you want to do with it. Its stated in the docs. Or if u wish to use the CrawlSpider, then u simply define rules for your spider instead.Just in case this is useful. When the crawler does not work like in this case, make sure you delete the following code from your spider file. This is because the spider is configured to call this method by default if it is declared in the file.

Scrapy Linkextractor duplicating(?)

yukclam9

[Scrapy Linkextractor duplicating(?)](https://stackoverflow.com/questions/31630771/scrapy-linkextractor-duplicating)

I have the crawler implemented as below.It is working and it would go through sites regulated under the link extractor.Basically what I am trying to do is to extract information from different places in the page:- href and text() under the class 'news' ( if exists)- image url under the class 'think block' ( if exists)I have three problems for my scrapy:1) duplicating linkextractorIt seems that it will duplicate processed page.  ( I check against the export file and found that the same ~.img appeared many times while it is hardly possible)And the fact is , for every page in the website, there are hyperlinks at the bottom that facilitate users to direct to the topic they are interested in, while my objective is to extract information from the topic's page ( here listed several passages's title under the same topic ) and the images found within a passage's page( you can arrive to the passage's page by clicking on the passage's title found at topic page).I suspect link extractor would loop the same page over again in this case.( maybe solve with depth_limit?)2) Improving parse_itemI think it is quite not efficient for parse_item. How could I improve it? I need to extract information from different places in the web ( for sure it only extracts if  it exists).Beside, it looks like that the parse_item could only progress HkejImage but not HkejItem (again I checked with the output file). How should I tackle this?3) I need the spiders to be able to read Chinese.I am crawling a site in HK and it would be essential to be capable to read Chinese.The site:As long as it belongs to 'dailynews', that's the thing I want.Thank you very much and I would appreciate any help!

2015-07-25 20:23:41Z

I have the crawler implemented as below.It is working and it would go through sites regulated under the link extractor.Basically what I am trying to do is to extract information from different places in the page:- href and text() under the class 'news' ( if exists)- image url under the class 'think block' ( if exists)I have three problems for my scrapy:1) duplicating linkextractorIt seems that it will duplicate processed page.  ( I check against the export file and found that the same ~.img appeared many times while it is hardly possible)And the fact is , for every page in the website, there are hyperlinks at the bottom that facilitate users to direct to the topic they are interested in, while my objective is to extract information from the topic's page ( here listed several passages's title under the same topic ) and the images found within a passage's page( you can arrive to the passage's page by clicking on the passage's title found at topic page).I suspect link extractor would loop the same page over again in this case.( maybe solve with depth_limit?)2) Improving parse_itemI think it is quite not efficient for parse_item. How could I improve it? I need to extract information from different places in the web ( for sure it only extracts if  it exists).Beside, it looks like that the parse_item could only progress HkejImage but not HkejItem (again I checked with the output file). How should I tackle this?3) I need the spiders to be able to read Chinese.I am crawling a site in HK and it would be essential to be capable to read Chinese.The site:As long as it belongs to 'dailynews', that's the thing I want.Thank you very much and I would appreciate any help!First, to set settings, make it on the settings.py file or you can specify the custom_settings parameter on the spider, like:Then, you have to make sure the spider is reaching the parse_item method (which I think it doesn't, haven't tested yet). And also you can't specify the callback and follow parameters on a rule, because they don't work together.First remove the follow on your rule, or add another rule, to check which links to follow, and which links to return as items.Second on your parse_item method, you are getting incorrect xpath, to get all the images, maybe you could use something like:and then to get the image url:for the news, it looks like this could work:Now, as and understand your problem, this isn't a Linkextractor duplicating error, but only poor rules specifications, also make sure you have valid xpath, because your question didn't indicate you needed xpath correction.

ScrapyJs Javascript is Not Enabled

AnovaConsultancy

[ScrapyJs Javascript is Not Enabled](https://stackoverflow.com/questions/32135475/scrapyjs-javascript-is-not-enabled)

I am trying to crawl a website that includes javascript codes and content of the web site preparing with javascript codes.Installed Scrapy and Splash.Splash is running with this codeWhen I wanted to get website code render.html shows "Javascript is not enabled. Please enable JavaScript in your browser".All settings are OK. I scrapped the web site successfully once. Then I am getting "Javascript is not enabled in your browser" error.If it helps to solve problem, this is splash output when I render the page.I couldn't understand what is the problem. Any help?Further InformationI have deleted the virtual machine. IP address is changed then I tried again. It get the results successfully for the first time. But, it couldn't get anything for second request. I think the web site is blocking my ip address.

2015-08-21 08:14:10Z

I am trying to crawl a website that includes javascript codes and content of the web site preparing with javascript codes.Installed Scrapy and Splash.Splash is running with this codeWhen I wanted to get website code render.html shows "Javascript is not enabled. Please enable JavaScript in your browser".All settings are OK. I scrapped the web site successfully once. Then I am getting "Javascript is not enabled in your browser" error.If it helps to solve problem, this is splash output when I render the page.I couldn't understand what is the problem. Any help?Further InformationI have deleted the virtual machine. IP address is changed then I tried again. It get the results successfully for the first time. But, it couldn't get anything for second request. I think the web site is blocking my ip address.

How to extract content inside html tag attr with python?

Juliano

[How to extract content inside html tag attr with python?](https://stackoverflow.com/questions/51238549/how-to-extract-content-inside-html-tag-attr-with-python)

I am running a scrapy project. I need to extract a content within a tag attribute like this:In this case would be the date within the content attribute. So far I was only able to extract content in the midle of tags.thanks!

2018-07-09 05:12:02Z

I am running a scrapy project. I need to extract a content within a tag attribute like this:In this case would be the date within the content attribute. So far I was only able to extract content in the midle of tags.thanks!Check this out ->Reference ->https://www.analyticsvidhya.com/blog/2017/07/web-scraping-in-python-using-scrapy/EDITIn your case code should be ->ThanksHere is XPath way:

Crawling too many links at the same time

P.Postrique

[Crawling too many links at the same time](https://stackoverflow.com/questions/45157041/crawling-too-many-links-at-the-same-time)

I'm trying to crawl a website and my spider (I don't know why) is crawling my links in such disorder!!It's crawling all the links I want but it stored only the first one (rank and url_seller as example after)... I'm new in this universe of crawling, python or scrapy but all I want is to learn!! I post my code here, somebody could help me ?I post also an example of what I want and of what I get... you'll see the problem I hope!!What I want :And what I get : You can see that the url_seller are exactly the same and the rank (by month, year or lifetime) also... but I want them to be different..... And the url_seller is not the same that the link I crawled, but it has to be the same..... Any help please?

2017-07-18 03:36:40Z

I'm trying to crawl a website and my spider (I don't know why) is crawling my links in such disorder!!It's crawling all the links I want but it stored only the first one (rank and url_seller as example after)... I'm new in this universe of crawling, python or scrapy but all I want is to learn!! I post my code here, somebody could help me ?I post also an example of what I want and of what I get... you'll see the problem I hope!!What I want :And what I get : You can see that the url_seller are exactly the same and the rank (by month, year or lifetime) also... but I want them to be different..... And the url_seller is not the same that the link I crawled, but it has to be the same..... Any help please?I'll walk through it step by step:To fix this, you should deal with your your URL and it's associated rankings in the same loop:That should fix your rank issues.I'm not too sure about the url_seller issue, because it seems like it should use the same url for both item['url_seller'] and its call to parse_3, and it seems like it's using the right info to call parse_3, but continuing to use the same information in item['url_seller'] over and over again.I'm kind of going out on a limb here, since if I'm understanding the situation properly, both methods should (in the particular case that I think this is) make equal strings, but the only difference I've noticed so far is that for one you're using ''.join(url_2).strip() and for the other you're using str(url_2).Since the part where you're using str(url_2) seems to be working properly where it's being used, perhaps you should try using it in the other spot too:

Scrapy - Crawl and Scrape a website

Srikanth

[Scrapy - Crawl and Scrape a website](https://stackoverflow.com/questions/15061702/scrapy-crawl-and-scrape-a-website)

As a part of learning to use Scrapy, I have tried to Crawl Amazon and there is a problem while scraping data,The output of my code is as follows:But, I wanted the output to be captured like this,I think its not a problem with the scrapy or the crawler, but with the FOR loop written. Following is the code,Any assistance!

2013-02-25 07:04:04Z

As a part of learning to use Scrapy, I have tried to Crawl Amazon and there is a problem while scraping data,The output of my code is as follows:But, I wanted the output to be captured like this,I think its not a problem with the scrapy or the crawler, but with the FOR loop written. Following is the code,Any assistance!problem is in your Xpath in above Xpaths you needs to use . in xpath to look into title only other wise your xpath will look on whole page , so it will get allot of matches and will return them, By the way - you can test our your Xpath expressions in the Scrapy Shell - http://doc.scrapy.org/en/latest/topics/shell.htmlDone right, it will save you hours of work and a headache. :)Use yield to make a generator and fix your xpath selectors:

Calling Scrapy Spider from python script?

user2823667

[Calling Scrapy Spider from python script?](https://stackoverflow.com/questions/19052639/calling-scrapy-spider-from-python-script)

I have created a spider with name aqaq

it is in the file name image.py.

the contents of image.py is as follows:i am trying to run this spider with my python script which is as follows:while running the above script i am getting the following error:I am a beginner and in need of help ???

2013-09-27 13:55:23Z

I have created a spider with name aqaq

it is in the file name image.py.

the contents of image.py is as follows:i am trying to run this spider with my python script which is as follows:while running the above script i am getting the following error:I am a beginner and in need of help ???You must use CrawlerSettings instead of Settings.Change this line:by:And this line:by:

Web crawling for multiple websites with different structures [closed]

Soheil Gharatape

[Web crawling for multiple websites with different structures [closed]](https://stackoverflow.com/questions/43712602/web-crawling-for-multiple-websites-with-different-structures)

I want to do a web crawl on multiple websites with different structures to find a specific data. However, I have some keywords to help me find what I want. To be more clear, I want to extract a list of profs names from a university's website and loop it on a given list of universities. The keywords, here, can be the word "Professor" or "Prof" or "Dr" before their names and an email after their names. However, it's a bit challenging to deal with different html structures that each website has.What's your suggestion?

2017-04-30 23:59:05Z

I want to do a web crawl on multiple websites with different structures to find a specific data. However, I have some keywords to help me find what I want. To be more clear, I want to extract a list of profs names from a university's website and loop it on a given list of universities. The keywords, here, can be the word "Professor" or "Prof" or "Dr" before their names and an email after their names. However, it's a bit challenging to deal with different html structures that each website has.What's your suggestion?It depends.Option 1: If "multiple websites" means a handful, maybe up to ten, you could try building a separate scraper for each of them. Advantage: you get exact results and you get all results. Disadvantage: whenever a site changes the scraper breaks and needs adjustments and this will be too much work when there are 100s of sites or more.Option 2: If "multiple websites" means really many websites, building a scraper for each site is most probably too expensive. In this case the only other option I can think of is to build a generic crawler that crawls all sites and then run NLP algorithms on the results to extract the data you need.I gave on overview how such an NLP based processing pipeline would look like in a recent, somewhat similar question: How to crawl thousands of pages using scrapy?Advantage: once it is running and fine tuned, it doesn't matter whether there are 100s or 1000s of sites to process and it is quite robust when sites change.Disadvantages: getting this up and running is more difficult than writing a scraper and you will never get 100% of the results neither will they be 100% accurate.

XPath doesn't point to the right HTML table elements with iterator (Scrapy)

Vy.Iv

[XPath doesn't point to the right HTML table elements with iterator (Scrapy)](https://stackoverflow.com/questions/22257429/xpath-doesnt-point-to-the-right-html-table-elements-with-iterator-scrapy)

I have a problem using XPath to select HTML elements with Scrapy from the table. 

The exemple that I am using is very basic example from Scrapy website: http://doc.scrapy.org/en/latest/intro/tutorial.html and the website that I want to parse would be http://www.euroleague.net/main/results/showgame?gamecode=5&gamenumber=1&phasetypecode=RS&seasoncode=E2013#!playbyplay  At first I used this code: Well it is basic and rules isn't very correct at this moment but the main concern with this example is XPath.And it works but not in the way that I want.

I would like that every item extracted only one value of td per tr but with this code it extracts all td elements to the item at once.

Item game_event_res_visitor:To get the result that I want, I decided to use loop (like in Scrapy tutorial (http://doc.scrapy.org/en/latest/intro/tutorial.html)), but it doesn't return any values at all. Here is the code:and terminal output:I understand that something wrong is with my XPath, but I don't understand what. If I use relative XPath in item elements it gives me the same results as I reached with first example. So it is out there, but I can't reach it with that code that I have. I even tried "wild card".It failed to get any text results.I am confused and I don't understand what is wrong with my XPath or my code.  

2014-03-07 18:02:11Z

I have a problem using XPath to select HTML elements with Scrapy from the table. 

The exemple that I am using is very basic example from Scrapy website: http://doc.scrapy.org/en/latest/intro/tutorial.html and the website that I want to parse would be http://www.euroleague.net/main/results/showgame?gamecode=5&gamenumber=1&phasetypecode=RS&seasoncode=E2013#!playbyplay  At first I used this code: Well it is basic and rules isn't very correct at this moment but the main concern with this example is XPath.And it works but not in the way that I want.

I would like that every item extracted only one value of td per tr but with this code it extracts all td elements to the item at once.

Item game_event_res_visitor:To get the result that I want, I decided to use loop (like in Scrapy tutorial (http://doc.scrapy.org/en/latest/intro/tutorial.html)), but it doesn't return any values at all. Here is the code:and terminal output:I understand that something wrong is with my XPath, but I don't understand what. If I use relative XPath in item elements it gives me the same results as I reached with first example. So it is out there, but I can't reach it with that code that I have. I even tried "wild card".It failed to get any text results.I am confused and I don't understand what is wrong with my XPath or my code.  Here's what works for me:Here's an example item I'm getting:For you, it's just a start though - sometimes items are not yielded due to IndexError exception - handle it properly.Hope that helps.

Scrapy on Ubuntu 14.04

CodeGuru

[Scrapy on Ubuntu 14.04](https://stackoverflow.com/questions/29452830/scrapy-on-ubuntu-14-04)

I"m getting these error when i create a scrapy project. I already went through all the google links and it just wont work out for me on ubuntu 14.04Some say do pip install pyOpenSSL==0.13 i get the following 

2015-04-05 00:21:36Z

I"m getting these error when i create a scrapy project. I already went through all the google links and it just wont work out for me on ubuntu 14.04Some say do pip install pyOpenSSL==0.13 i get the following You need to install libssl-dev package:

Scrapy - flow of the Crawl spider

Chris

[Scrapy - flow of the Crawl spider](https://stackoverflow.com/questions/31139237/scrapy-flow-of-the-crawl-spider)

I'm having a hard time figuring out how Scrapy works (or how I need to work with it).

This question is a bit broad - more for understanding.I setup a CrawlSpider and threw in 6 start urls.

From those (24 items to scrape on each of those start urls) I expected roughly 144 rows to end up in my database, but I only have 18 now.So I'm using to avoid complication with Rules for now.

Now Scrapy should take those 6 urls and crawl them and then process the items on those pages.

But instead it seems as if it takes those 6 urls and then checks each link on those pages and follows those links first - is this possible?

Does Scrapy just take URL 1, scan all links and follow everything allowed?

When does it take URL 2?

2015-06-30 13:11:09Z

I'm having a hard time figuring out how Scrapy works (or how I need to work with it).

This question is a bit broad - more for understanding.I setup a CrawlSpider and threw in 6 start urls.

From those (24 items to scrape on each of those start urls) I expected roughly 144 rows to end up in my database, but I only have 18 now.So I'm using to avoid complication with Rules for now.

Now Scrapy should take those 6 urls and crawl them and then process the items on those pages.

But instead it seems as if it takes those 6 urls and then checks each link on those pages and follows those links first - is this possible?

Does Scrapy just take URL 1, scan all links and follow everything allowed?

When does it take URL 2?You can find your answer in the official documentation page, but for completeness I will paste it here: Note:

The way you describe the crawl order is usuall called DFS (depth-first search) or BFS (breadth-first search). Scrapy uses DFO and BFO ('O' is for 'order', but the meaning is the same).

Scrapy CrawlSpider parse_item for a 302 redirect response

bawejakunal

[Scrapy CrawlSpider parse_item for a 302 redirect response](https://stackoverflow.com/questions/35307644/scrapy-crawlspider-parse-item-for-a-302-redirect-response)

I am using a Scrapy CrawlSpider to crawl websites and process on their page content. For this I am using the Scrapy Docs Crawlspider Example.A particular page on the links takes in a parameter target via GET request (say http://www.example.com?target=x) and redirects (302) if the value is erroneous. On receiving this 302 HTTP response, scrapy follows the redirect, but doesn't processes the response in parse_item method, as intended by me.I came across a few solutions suggesting meta/dont_redirect/http_status_list but none seem to be taking effect. Please suggest how can I parse the response of 302 redirection, without/before following on the 302 redirected location.Scrapy version: 0.24.6

2016-02-10 05:38:13Z

I am using a Scrapy CrawlSpider to crawl websites and process on their page content. For this I am using the Scrapy Docs Crawlspider Example.A particular page on the links takes in a parameter target via GET request (say http://www.example.com?target=x) and redirects (302) if the value is erroneous. On receiving this 302 HTTP response, scrapy follows the redirect, but doesn't processes the response in parse_item method, as intended by me.I came across a few solutions suggesting meta/dont_redirect/http_status_list but none seem to be taking effect. Please suggest how can I parse the response of 302 redirection, without/before following on the 302 redirected location.Scrapy version: 0.24.6To disable redirects you should add meta={'dont_redirect': True) to your yielded scrapy.Requests.

so your spider should look something like this:  What happens here is that scrapy has a default downloader middleware called RedirectMiddleware which is enabled by default and handles all redirections, by supplying this meta argument you are telling this middleware to not do it's job for this particular request.if you want to disable redirects for every request(which usually is not the best idea) you can just add  to your settings.py in scrapy project.There is a brilliant illustration on scrapy docs on how all of the scrapy pieces, like middlewares and spiders, work together:

http://doc.scrapy.org/en/latest/topics/architecture.html

Scrapy crawler doesnt work with a website i get partial results

Roberto Lozano

[Scrapy crawler doesnt work with a website i get partial results](https://stackoverflow.com/questions/39067592/scrapy-crawler-doesnt-work-with-a-website-i-get-partial-results)

I'm new to Scrapy and Python. I have been working to extract data from 2 websites and they work really well if I do it directly with python. I have investigated and I want to crawl these websites:Can someone tell me how can I make the the second link work?I see this message:but I can't find out how to solve it.I would appreciate any help and support. Here is the code and the log:Test.py (spider folder)

2016-08-21 18:34:26Z

I'm new to Scrapy and Python. I have been working to extract data from 2 websites and they work really well if I do it directly with python. I have investigated and I want to crawl these websites:Can someone tell me how can I make the the second link work?I see this message:but I can't find out how to solve it.I would appreciate any help and support. Here is the code and the log:Test.py (spider folder)You're seeing ['partial'] in your logs because the server at vallenproveedora.com.mx doesn't set the Content-Length header in its response; run curl -I to see for yourself. For more detail on the cause of the partial flag, see my answer here.However, you don't actually have to worry about this. The response body is all there and Scrapy will parse it. The problem you're really encountering is that there are no elements selected by the XPath //ul/li/a. You should look at the page source and modify your selectors accordingly. I would recommend writing a specific spider for each site, because sites usually need different selectors.

How to follow next pages in Scrapy Crawler to scrap content

leboMagma

[How to follow next pages in Scrapy Crawler to scrap content](https://stackoverflow.com/questions/35309120/how-to-follow-next-pages-in-scrapy-crawler-to-scrap-content)

I am able to scrap all the stories from the first page,my problem is how to move to the next page and continue scraping stories and name,kindly check my code below    

2016-02-10 07:22:46Z

I am able to scrap all the stories from the first page,my problem is how to move to the next page and continue scraping stories and name,kindly check my code below    You could change your scrapy.Spider for a CrawlSpider, and use Rule and LinkExtractor to follow the link to the next page.For this approach you have to include the code below:This way, for each page you visit the spider will create a request for the next page (if present), follow it when finishes the execution for the parse method, and repeat the process again.EDIT:The rule I wrote is just to follow the next page link not to extract the stories, if your first approach works it's not necessary to change it.Also, regarding the rule in your comment, SgmlLinkExtractor is deprecated so I recommend you to use the default link extractor, and the rule itself is not well defined.When the parameter attrs in the extractor is not defined, it searchs links looking for the href tags in the body, which in this case looks like ../story/mother-of-4435 and not /clickToGive/bcs/story/mother-of-4435. That's the reason it doesn't find any link to follow.you can follow next pages manually if you would use scrapy.spider class,example:

next_page = response.css('a.pageLink  ::attr(href)').extract_first()

if next_page:

       absolute_next_page_url = response.urljoin(next_page)

       yield scrapy.Request(url=absolute_next_page_url, callback=self.parse)

Do not forget to rename your parse method to parse_start_url if you want to use CralwSpider class

Overriding parse_start_url() in Scrapy and limiting crawl depth to 1

false_azure

[Overriding parse_start_url() in Scrapy and limiting crawl depth to 1](https://stackoverflow.com/questions/27851446/overriding-parse-start-url-in-scrapy-and-limiting-crawl-depth-to-1)

I'm using Scrapy to crawl a site and have overridden parse_start_url() in order to scrape the start URLs. However, this means that when I set the DEPTH_LIMIT setting to 1, Scrapy crawls at depth 2 (because I guess it makes sense for the start urls not to count towards the depth, if they're usually parsed). This is ok when crawling at any depth other than 1, because I can just reduce the DEPTH_LIMIT by 1 to account for this. However, this won't work when crawling at depth 1 because a DEPTH_LIMIT of 0 is treated as unlimited depth. Can anyone think of a way to parse start URLs and have a depth limit of 1?Or should I write my own DepthMiddleware?

2015-01-08 23:30:56Z

I'm using Scrapy to crawl a site and have overridden parse_start_url() in order to scrape the start URLs. However, this means that when I set the DEPTH_LIMIT setting to 1, Scrapy crawls at depth 2 (because I guess it makes sense for the start urls not to count towards the depth, if they're usually parsed). This is ok when crawling at any depth other than 1, because I can just reduce the DEPTH_LIMIT by 1 to account for this. However, this won't work when crawling at depth 1 because a DEPTH_LIMIT of 0 is treated as unlimited depth. Can anyone think of a way to parse start URLs and have a depth limit of 1?Or should I write my own DepthMiddleware?When you yield requests from parse_start_url() method, set the meta['depth']:This should do the trick since later, when the response would arrive, in the DepthMiddleware it would be incremented by 1:

Why my scrapy downloader middleware do not render javascript properly?

Treper

[Why my scrapy downloader middleware do not render javascript properly?](https://stackoverflow.com/questions/14096768/why-my-scrapy-downloader-middleware-do-not-render-javascript-properly)

I am using this scrapy code snippet to render javascript code of the website that I want to crawl data from. The site is a video search engine and the search results is rendered by javascript. I want to follow the next page link and scrap the whole searched items. Following is my spider code:I found that the link in the start_urls is correctly downloaded and rendered properly like this:Therefore the  extracting is successful on the first page while when the next page links is fetched the javascript is not rendered like this:So the scraping stopped because it can not extract the links as a result of the results-list is not rendered.Why the first page is rendered properly but the second is not? Should I use selenium instead of webkit and jswebkit?

2012-12-31 02:23:28Z

I am using this scrapy code snippet to render javascript code of the website that I want to crawl data from. The site is a video search engine and the search results is rendered by javascript. I want to follow the next page link and scrap the whole searched items. Following is my spider code:I found that the link in the start_urls is correctly downloaded and rendered properly like this:Therefore the  extracting is successful on the first page while when the next page links is fetched the javascript is not rendered like this:So the scraping stopped because it can not extract the links as a result of the results-list is not rendered.Why the first page is rendered properly but the second is not? Should I use selenium instead of webkit and jswebkit?I'm no expert but I've recently fell in love with Scrapy and Selenium.   I used to scrape hardcore with perl and python mainly with urllib2/beautifulsoup/regex/mechanize but ran into what I felt like were impossible sites to deal with, sites extensively using ajax with no data to be pulled from the source.  Sites that could not even be broken with masking post request parameters, so for awhile I gave up on my scraping hopes and dreams. It took me a little bit, but now I'm using Selenium with Webkit and it's amazing. I feel like a pro hacker.    In fact I'm pretty confident most sites cant stop me.   It perfectly emulates the user using the browser, I just use sleep to make sure I allow the page ajax to load correctly. For difficult sites like Amazon just don't be greedy, makes your hits randomly spaced out.  I've had selenium running for days with no problems. I would definitely recommend you look into selenium.  Everything uses Ajax nowadays.   Finally I figure out the problem. Some url are not properly formed.

Scrapy - doesn't crawl

Srikanth

[Scrapy - doesn't crawl](https://stackoverflow.com/questions/14775073/scrapy-doesnt-crawl)

I'm trying to get a recursive crawl running and since the one I wrote wasn't working fine, I pulled an example from web and tried. I really don't know, where the problem is, but the crawl doesn't display any ERRORS. Can anyone help me with this.Also, Is there any step-by-step debugging tool to help understand the crawl flow of a spider. Any help regarding this is greatly appreciated.the code I have used is as follows,

2013-02-08 14:46:46Z

I'm trying to get a recursive crawl running and since the one I wrote wasn't working fine, I pulled an example from web and tried. I really don't know, where the problem is, but the crawl doesn't display any ERRORS. Can anyone help me with this.Also, Is there any step-by-step debugging tool to help understand the crawl flow of a spider. Any help regarding this is greatly appreciated.the code I have used is as follows,These changes will fix the issue being experienced. I'd also make the following suggestion to the xpath used to select titles, as this will remove the empty items that will occur because the next page links are also being selected.Try substituting in your SgmlLinkExtractor "d00\.html" with ".*00\.html" or "index\d+00\.html"

Scrapy response is a different language from request and resposne url

tpstackexchange

[Scrapy response is a different language from request and resposne url](https://stackoverflow.com/questions/32507408/scrapy-response-is-a-different-language-from-request-and-resposne-url)

I'm trying to scrape search results from this pagehttp://eur-lex.europa.eu/search.html?qid=1437402891621&DB_TYPE_OF_ACT=advGeneral&CASE_LAW_SUMMARY=false&DTS_DOM=EU_LAW&typeOfActStatus=ADV_GENERAL&type=advanced&lang=fr&SUBDOM_INIT=EU_CASE_LAW&DTS_SUBDOM=EU_CASE_LAWThe language according to the url is french, and that is what I see in the scrapy shell, following 'crawled (200) 'If I try response.url I also get a url with lang=fr.Viewing the page in a browser shows me french results.However, the body of the response is English.I've tried disabling cookies in my scrapy settings.py file.

I've also set the DEFAULT_REQUEST HEADERS to 'Accept-Language': 'fr'.Any ideas?

2015-09-10 16:42:24Z

I'm trying to scrape search results from this pagehttp://eur-lex.europa.eu/search.html?qid=1437402891621&DB_TYPE_OF_ACT=advGeneral&CASE_LAW_SUMMARY=false&DTS_DOM=EU_LAW&typeOfActStatus=ADV_GENERAL&type=advanced&lang=fr&SUBDOM_INIT=EU_CASE_LAW&DTS_SUBDOM=EU_CASE_LAWThe language according to the url is french, and that is what I see in the scrapy shell, following 'crawled (200) 'If I try response.url I also get a url with lang=fr.Viewing the page in a browser shows me french results.However, the body of the response is English.I've tried disabling cookies in my scrapy settings.py file.

I've also set the DEFAULT_REQUEST HEADERS to 'Accept-Language': 'fr'.Any ideas?In the upper right corner of the webpage there's a drop down field to choose the language of the website. Selecting french there will add another parameter to the url: &locale=fr.So - add that parameter to your start_url.

How to get/crawl all the reviews of apps on play store or app store, I am just getting first 40 reviews?

n0unc3

[How to get/crawl all the reviews of apps on play store or app store, I am just getting first 40 reviews?](https://stackoverflow.com/questions/37400336/how-to-get-crawl-all-the-reviews-of-apps-on-play-store-or-app-store-i-am-just-g)

I am using python for this.

I am going to play store url for an app then parse the body into tree, extracting data with xpathand then wrting it in a fileBut with this I am able to get only first 40 reviews on the google play store instead of all reviews.After first 40 reviews are displayed Google Play starts to load more reviews by pinging http://play.google.com/store/getreviews

2016-05-23 20:52:18Z

I am using python for this.

I am going to play store url for an app then parse the body into tree, extracting data with xpathand then wrting it in a fileBut with this I am able to get only first 40 reviews on the google play store instead of all reviews.After first 40 reviews are displayed Google Play starts to load more reviews by pinging http://play.google.com/store/getreviewsYou must send a post request to https://play.google.com/store/getreviews. The post request must include the following header:Your query (pagenumber, review sorting, etc.) should be a urlencoded string, like:You can then send this request using the request module:Note: The response is actually in the form of a list with the html inside it that you will have to parse and it has this weird )]}' thing at the beginning that you will have to get rid of.

Scrapy headache - trying to debug. No errors but code not working

jwl298

[Scrapy headache - trying to debug. No errors but code not working](https://stackoverflow.com/questions/14191357/scrapy-headache-trying-to-debug-no-errors-but-code-not-working)

EDIT: THIS HAS BEEN RESOLVED! XPATH WAS THE ISSUE.I'm very confused. I'm trying to write a very simple spider, to crawl a website (talkbass.com) to get me a list of all the links in the classified bass section (http://www.talkbass.com/forum/f126/ ). I wrote the spider based off of the tutorial (which I completed with relative ease) and this one is just not working. I am probably doing a lot wrong, as I tried to incorporate a Rule as well, but I'm just getting nothing back.My item code is:my spider code is:I don't get any errors, but the log just doesn't return anything. Here's what I see in the console:I've never done an actual project and I thought this would be a good place to start but I can't seem to straighten this out.I'm also not sure if the XPath is correct. I'm using a chrome extension called XPath helper. An example of one of the sections I need is this:However if you see the " tr[6] " and the "944468" - those are not constant for each link (everything else is). I just removed the class names and the numbers which left me with what you see in my spider code.Also just to add - when I copy and paste the XPath directly from XPath Helper, it gives a syntax error:I have tried messing around with that (using wild cards where the elements are not constant) and have been receiving syntax errors each time I try

2013-01-07 07:04:19Z

EDIT: THIS HAS BEEN RESOLVED! XPATH WAS THE ISSUE.I'm very confused. I'm trying to write a very simple spider, to crawl a website (talkbass.com) to get me a list of all the links in the classified bass section (http://www.talkbass.com/forum/f126/ ). I wrote the spider based off of the tutorial (which I completed with relative ease) and this one is just not working. I am probably doing a lot wrong, as I tried to incorporate a Rule as well, but I'm just getting nothing back.My item code is:my spider code is:I don't get any errors, but the log just doesn't return anything. Here's what I see in the console:I've never done an actual project and I thought this would be a good place to start but I can't seem to straighten this out.I'm also not sure if the XPath is correct. I'm using a chrome extension called XPath helper. An example of one of the sections I need is this:However if you see the " tr[6] " and the "944468" - those are not constant for each link (everything else is). I just removed the class names and the numbers which left me with what you see in my spider code.Also just to add - when I copy and paste the XPath directly from XPath Helper, it gives a syntax error:I have tried messing around with that (using wild cards where the elements are not constant) and have been receiving syntax errors each time I tryOne reason that could be causing the issue is that you are using a BaseSpider which does not implement rules. Try changing BaseSpider to CrawlSpider. You should also rename parse to something like parse_item (since CrawlSpider implements a parse function), which will necessitate explicitly setting a callback in your rule. Eg:An updated Xpath to try is as follows. Note that this will include all of the sticky threads, so it's left as an exercise to the OP to work out how to filter out those out.Besides the fact that your trying to use rules in a BaseSpider which are not supported are you finding any matches with that hxs.select statement?   try opening a command prompt, and run scrapy shell http://www.talkbass.com/forum/f126/then type;then;then;if you do find a match keeps things simple try;  Then in your item pipelineThe bottom line is your hxs.select statement is not correct, so you should always open the shell and test your hxs.select statements until you know you have them right before running your spider. there are couple of issues in your code.BaseSpider doesn't support rules so extend your crawler from CrawlSpider rather then BaseSpider it will start crawling links.in extraction part convert your Xpath to relative rather then absolute , in most of the cases tbody tag doesn't not present on the source but browser show this while rendering , so Xapth that contains tbody work on browers but not in code ... so i recommend you to not to use tbody tag in xpath .As noted, the XPath was the big problem here. It has been edited to '//table[@id="threadslist"]/tbody/tr/td[@class="alt1"][2]/div'

Scrapy spider not including all requested pages

Eaners

[Scrapy spider not including all requested pages](https://stackoverflow.com/questions/23305502/scrapy-spider-not-including-all-requested-pages)

I have a Scrapy script for Yelp that is, for the most part, working. Essentially I can supply it with a list of Yelp pages and it should return all reviews from all pages. The script so far is below:However, the problem I'm running into is that this particular script scrapes every page of every requested review EXCEPT for the first page. If I comment out the last "if" statement, it only scrapes the FIRST page. I suspect all I need is a simple "else" command but I am stumped... help is greatly appreciated!EDIT: This is the code as it currently stands based on assistance received...As mentioned in a comment below, running this code as-is crawls every desired page, but it only returns one review per page rather than all of them.I tried Changing yield item to yield items, but an error message of ERROR: Spider must return Request, BaseItem or None, got 'list' in <GET http://www.yelp.com/biz/[...]> is returned for every URL crawled.

2014-04-26 01:26:45Z

I have a Scrapy script for Yelp that is, for the most part, working. Essentially I can supply it with a list of Yelp pages and it should return all reviews from all pages. The script so far is below:However, the problem I'm running into is that this particular script scrapes every page of every requested review EXCEPT for the first page. If I comment out the last "if" statement, it only scrapes the FIRST page. I suspect all I need is a simple "else" command but I am stumped... help is greatly appreciated!EDIT: This is the code as it currently stands based on assistance received...As mentioned in a comment below, running this code as-is crawls every desired page, but it only returns one review per page rather than all of them.I tried Changing yield item to yield items, but an error message of ERROR: Spider must return Request, BaseItem or None, got 'list' in <GET http://www.yelp.com/biz/[...]> is returned for every URL crawled.You need to reorganize the methods a bit. First parse restaurant page in parse() method. Then, return requests for reviews and handle responses in another method, e.g. parse_review():If you're returning items/requests in more than one place, you should replace your return statements with yield statements, which turn your function into a generator, which returns a new element each time it's generated (yields it), without exiting the function until they are all returned. Otherwise, as your code is now, your function will exit after the first return and won't get to sending the requests for the following pages.Edit: Correction - you should yield one item/request at a time, so:Replacewithand replacewithThe final answer did indeed lie in the indentation of one single yield line. This is the code that ended up doing what I needed it to do.Thanks to everyone for helping out a noob!

Webrawling in Python with Scrapy - How to force page to show breadcrumb menu?

munzwurf

[Webrawling in Python with Scrapy - How to force page to show breadcrumb menu?](https://stackoverflow.com/questions/22478079/webrawling-in-python-with-scrapy-how-to-force-page-to-show-breadcrumb-menu)

I am building some Web Crawlers in Python with the Scrapy library. The goal is to get some data from a couple of shops.When crawling, there are two kinds of sites:Now, as a user, when I open a product site from a catalogue site, I am shown a "breadcrumb-style" menu - this shows me where I am. For example, if the shop would be an electronics shop and the product would be an iPhone, the breadcrumbs could show: "Electronics -> Phones -> iPhones -> iPhone 5S 64GB"However, this only happens if I follow the direct path outlined above. My problem is that when I crawl these sites via Scrapy, the breadcrumb doesn't show up - even though with the crawler I am following the path as above (i.e. I start on the Electronics site and then keep going deeper until I reach the product site). I even tinkered with the referrer settings, but nothing helped. Is there another way, a way I could make these breadcrumb-menus appear?Would really appreciate some input. :)

2014-03-18 11:32:16Z

I am building some Web Crawlers in Python with the Scrapy library. The goal is to get some data from a couple of shops.When crawling, there are two kinds of sites:Now, as a user, when I open a product site from a catalogue site, I am shown a "breadcrumb-style" menu - this shows me where I am. For example, if the shop would be an electronics shop and the product would be an iPhone, the breadcrumbs could show: "Electronics -> Phones -> iPhones -> iPhone 5S 64GB"However, this only happens if I follow the direct path outlined above. My problem is that when I crawl these sites via Scrapy, the breadcrumb doesn't show up - even though with the crawler I am following the path as above (i.e. I start on the Electronics site and then keep going deeper until I reach the product site). I even tinkered with the referrer settings, but nothing helped. Is there another way, a way I could make these breadcrumb-menus appear?Would really appreciate some input. :)Most likely the site implements the breadcrumbs as cookies you are ignoring. You need to pass the session cookies from one request to the subsequent ones. This question demonstrates cookie usage with scrapy. 

Crawling table with scrapy, site has unusual html code.

Faddy Sunna

[Crawling table with scrapy, site has unusual html code.](https://stackoverflow.com/questions/52865617/crawling-table-with-scrapy-site-has-unusual-html-code)

first post. I appreciate any guidance, and cant wait to give back to the community. I am trying to make a crawler using scrapy, to collect data from this table.http://www.wikicfp.com/cfp/call?conference=machine%20learningSpecifically, the conference name, location, and date. But the table, tr, and td have no classes, and the table is within another table. No matter how i edit my codee, it keeps giving me the whole page.Later on, I will work on making it move on to the next page and output a csv or json, but for now im trying to get parts of this table. I have tested a few commands in  scrapy shell, but my knowledge is lacking. 

Thanks

2018-10-18 01:18:51Z

first post. I appreciate any guidance, and cant wait to give back to the community. I am trying to make a crawler using scrapy, to collect data from this table.http://www.wikicfp.com/cfp/call?conference=machine%20learningSpecifically, the conference name, location, and date. But the table, tr, and td have no classes, and the table is within another table. No matter how i edit my codee, it keeps giving me the whole page.Later on, I will work on making it move on to the next page and output a csv or json, but for now im trying to get parts of this table. I have tested a few commands in  scrapy shell, but my knowledge is lacking. 

ThanksBy the way the source looks, the structure of the page is like so:Edit: Try this

Scrapy timeout after a while

CKLu

[Scrapy timeout after a while](https://stackoverflow.com/questions/52555653/scrapy-timeout-after-a-while)

I work on crawling the text from https://www.dailynews.co.th, and here is my question.My spider worked almost perfect at first, crawled about 4000 pages. And then it started to raise tons of TimeoutErrors from almost all urls, like this.This was my second try and I decreased CONCURRENT_REQUESTS from 32 to 16, AUTOTHROTTLE_TARGET_CONCURRENCY from 32.0 to 4.0, and DOWNLOAD_TIMEOUT from 15 to 5. The problem was not solved but I got more pages than the first try (from 1000 to 4000).I also tried scrapy shell on the failed urls (while my spider was still running), I got a response with 200 which means the connection is fine itself.I wonder if I got banned or something else, can anybody give me a clue on this? Thanks a lot.FYI, here is my settings file.And here is my spider code.

2018-09-28 12:45:00Z

I work on crawling the text from https://www.dailynews.co.th, and here is my question.My spider worked almost perfect at first, crawled about 4000 pages. And then it started to raise tons of TimeoutErrors from almost all urls, like this.This was my second try and I decreased CONCURRENT_REQUESTS from 32 to 16, AUTOTHROTTLE_TARGET_CONCURRENCY from 32.0 to 4.0, and DOWNLOAD_TIMEOUT from 15 to 5. The problem was not solved but I got more pages than the first try (from 1000 to 4000).I also tried scrapy shell on the failed urls (while my spider was still running), I got a response with 200 which means the connection is fine itself.I wonder if I got banned or something else, can anybody give me a clue on this? Thanks a lot.FYI, here is my settings file.And here is my spider code.

Scrapy is not filtering results as per allowed_domains

Mohsin

[Scrapy is not filtering results as per allowed_domains](https://stackoverflow.com/questions/41923550/scrapy-is-not-filtering-results-as-per-allowed-domains)

Almost duplicate of scrapy allow all subdomains!Note: First of all I'm new to Scrapy & I don't have enough reputation to put a comment on this question. So, I decided to ask a new one!I was using BeautifulSoup to scrap email addresses from particular website. It is working fine if email address is available on that particular page (i.e. example.com), but not, if it's available on example.com/contact-us, pretty obvious!For that reason, I decided to use Scrapy. Though I'm using allowed_domains

to get only domain related links it gives me all the offsite links also. And I tried another approach suggested by @agstudy in this question to use SgmlLinkExtractor in rules.Then I got this error,Basically, ImportError is about deprecation of sgmlib (Simple SGML parser) in Python 3.xI also tried LxmlLinkExtractor with CrawlSpider, but still getting offsite links.What should I do to get this done? or Is my way of approach to solving the problem is wrong?Any help would be appreciated!Another Note:

Every time the website will be different to scrap emails. So, I can't use specific HTML or CSS selectors!

2017-01-29 17:03:18Z

Almost duplicate of scrapy allow all subdomains!Note: First of all I'm new to Scrapy & I don't have enough reputation to put a comment on this question. So, I decided to ask a new one!I was using BeautifulSoup to scrap email addresses from particular website. It is working fine if email address is available on that particular page (i.e. example.com), but not, if it's available on example.com/contact-us, pretty obvious!For that reason, I decided to use Scrapy. Though I'm using allowed_domains

to get only domain related links it gives me all the offsite links also. And I tried another approach suggested by @agstudy in this question to use SgmlLinkExtractor in rules.Then I got this error,Basically, ImportError is about deprecation of sgmlib (Simple SGML parser) in Python 3.xI also tried LxmlLinkExtractor with CrawlSpider, but still getting offsite links.What should I do to get this done? or Is my way of approach to solving the problem is wrong?Any help would be appreciated!Another Note:

Every time the website will be different to scrap emails. So, I can't use specific HTML or CSS selectors!You use xpath expression in hxs.select('//a/@href') which means extract href attribute values from all a tags on the page so you get exactly all the links including offsite ones. What you can to use instead is LinkExtractor and it would be like this:That is what LinkExtractor is really made for (I guess).By the way, keep in the mind that most Scrapy examples you can find in Internet (including Stackoverflow) are referred to earlier versions which haven't full compatibility with Python 3.

Using Xpath to take more element of the same type

RedVelvet

[Using Xpath to take more element of the same type](https://stackoverflow.com/questions/33060710/using-xpath-to-take-more-element-of-the-same-type)

I need to take all the answer in this page, structured for example with author name and text of the answer. https://answers.yahoo.com/question/index?qid=20151007080620AAVNtY1If i use this code I take only one element.

I Try also to change hxs or use a iterator for example:But not works

2015-10-11 01:33:55Z

I need to take all the answer in this page, structured for example with author name and text of the answer. https://answers.yahoo.com/question/index?qid=20151007080620AAVNtY1If i use this code I take only one element.

I Try also to change hxs or use a iterator for example:But not worksYou can get all the answers and relative authors with the expressions below.

This expression selects all the answers on the page, including the best answerNow iterate on for each answer answ, and the following xpath expressions (executed relatively to each answ node) will select the text and the author, respectively

Trigger scrapy shell using web page [duplicate]

Vasim

[Trigger scrapy shell using web page [duplicate]](https://stackoverflow.com/questions/31939024/trigger-scrapy-shell-using-web-page)

I am new to scrapy and python. I have written a spider which takes start_urls from command line and start scraping. Upto this, everything is fine.Now, i want to submit start_urls from a web page (Designed using Flask).After clicking on a button, it should trigger the scrapy shell and start scraping websites.

2015-08-11 10:14:52Z

I am new to scrapy and python. I have written a spider which takes start_urls from command line and start scraping. Upto this, everything is fine.Now, i want to submit start_urls from a web page (Designed using Flask).After clicking on a button, it should trigger the scrapy shell and start scraping websites.This is what scrapyd project can help with. There is a JSON API which you would use to deploy and run your spiders. This way your Web app part would not be blocked by the active web-scraping process:

Calling multiple spider from a script reactor not stopping

ashishk

[Calling multiple spider from a script reactor not stopping](https://stackoverflow.com/questions/19662537/calling-multiple-spider-from-a-script-reactor-not-stopping)

I have written this script to call more than one spider. It is working fine for single spider, but not for multiple spiders. I am new to Scrapy.Also, when one spider is running another spider starts running, and when one spider stops whole spider stops.

2013-10-29 15:28:56Z

I have written this script to call more than one spider. It is working fine for single spider, but not for multiple spiders. I am new to Scrapy.Also, when one spider is running another spider starts running, and when one spider stops whole spider stops.If you're trying to setup the same crawler to hit multiple domains, it's pretty well documented here: http://doc.scrapy.org/en/latest/topics/practices.html#running-multiple-spiders-in-the-same-process.Otherwise, removing this line might fix it:It's stopping the entire reactor when a single spider is closed, not allowing the second spider to finish.

Scrapy cannot handle bad headers properly [ScrapyHTTPPageGetter,client] Unhandled Error

EeE

[Scrapy cannot handle bad headers properly [ScrapyHTTPPageGetter,client] Unhandled Error](https://stackoverflow.com/questions/13839338/scrapy-cannot-handle-bad-headers-properly-scrapyhttppagegetter-client-unhandle)

Environment:Scrapy 0.16.2

Twisted-12.2.0

python 2.7

macosx-10.6Okey here is my problem:I try to runError:I found the solution from https://groups.google.com/forum/#!msg/scrapy-users/xFKo8ggzPxs/VXDl3CZ4V4cJ

They describe this is caused by twisted. Then I patched function extractHeader in /twisted/web/http.py from http://twistedmatrix.com/trac/ticket/2842. Its WORKSBUT BUT, Hold on NOt yet!!!I run another webError:I think something happen on response headers. Scrapy cannot handle it well.

Any idea?

Thank you!

2012-12-12 12:01:53Z

Environment:Scrapy 0.16.2

Twisted-12.2.0

python 2.7

macosx-10.6Okey here is my problem:I try to runError:I found the solution from https://groups.google.com/forum/#!msg/scrapy-users/xFKo8ggzPxs/VXDl3CZ4V4cJ

They describe this is caused by twisted. Then I patched function extractHeader in /twisted/web/http.py from http://twistedmatrix.com/trac/ticket/2842. Its WORKSBUT BUT, Hold on NOt yet!!!I run another webError:I think something happen on response headers. Scrapy cannot handle it well.

Any idea?

Thank you!

How to hold the cache in selenium in a loop after a page gets refreshed?

John Dene

[How to hold the cache in selenium in a loop after a page gets refreshed?](https://stackoverflow.com/questions/32584084/how-to-hold-the-cache-in-selenium-in-a-loop-after-a-page-gets-refreshed)

I am using this spider to click on the color and then page gets refreshed and then subsequent clicking on the links but it breaks in between and throw Element not found in the cache - perhaps the page has changed since it was looked up Error How to get hold of original page after completion of loop?Couldn't find any suitable solution for this. 

2015-09-15 10:47:24Z

I am using this spider to click on the color and then page gets refreshed and then subsequent clicking on the links but it breaks in between and throw Element not found in the cache - perhaps the page has changed since it was looked up Error How to get hold of original page after completion of loop?Couldn't find any suitable solution for this. 

Crawl AngularJS based website using scrapy

Anurag Mishra

[Crawl AngularJS based website using scrapy](https://stackoverflow.com/questions/43737455/crawl-angularjs-based-website-using-scrapy)

I am able crawl some pages but some pages are taking time to load because DOM is not fully rendered so that I am not able to crawl it. Can anyone have solution for this?Thanks in advance

2017-05-02 12:05:26Z

I am able crawl some pages but some pages are taking time to load because DOM is not fully rendered so that I am not able to crawl it. Can anyone have solution for this?Thanks in advanceI recommand scrapy splash. It is a rendering service for scrapy. (It is supported by scrapinghub, the guys behind scrapy).You can use a web driver like selenium with a headless browser like PhantomJS or Firefox. Use PhantomJS alone, or one of the plenty other alternatives available : CasperJS, SlimerJS, etc... As alternative to using Selenium you can use Firebug plugin for Firefox or Chrome Developer tools to watch the background requests the AngularJS app is doing in the background and then emulate these requests directly. While this requires more work, the scraper is much faster as it doesn't have to wait for the page to render.

Scraping items using scrapy

Swapnil Joshi

[Scraping items using scrapy](https://stackoverflow.com/questions/43423319/scraping-items-using-scrapy)

I have written the following spider for scraping the webmd site for patient reviewsExecuting this code gives me desired output but with a lot of duplication i.e. the same comments are repeated for at least 10 times.

Help me to solve this issue.

2017-04-15 07:11:37Z

I have written the following spider for scraping the webmd site for patient reviewsExecuting this code gives me desired output but with a lot of duplication i.e. the same comments are repeated for at least 10 times.

Help me to solve this issue.You can rewrite your spider code like this:It selects only full customer reviews without duplicate and saves them in Scrapy Items.

Note: instead of HtmlXPathSelector you can use more convenient shortcut response. Also, I change deprecated scrapy.BaseSpider to scrapy.Spider.For saving reviews to a csv format you can simply use Scrapy Feed exports and type in console scrapy crawl webmd -o reviews.csv.You can use sets to get unique comments. I hope you know that the selector returns the result as a list so if you use sets then you ll get only unique results. So

How to write a simple spider in Python?

Zeynel

[How to write a simple spider in Python?](https://stackoverflow.com/questions/1805231/how-to-write-a-simple-spider-in-python)

I've been trying to write this spider for weeks but without success. What is the best way for me to code this in Python:1) Initial url: http://www.whitecase.com/Attorneys/List.aspx?LastName=A2) from initial url pick up these urls with this regex:hxs.select('//td[@class="altRow"][1]/a/@href').re('/.a\w+')3) Go to each of these urls and scrape the school info with this regexhxs.select('//td[@class="mainColumnTDa"]').re('(?<=(JD,\s))(.*?)(\d+)'[u'JD, ', u'University of Florida Levin College of Law, <em>magna cum laude</em>

   , Order of the Coif, Symposium Editor, Florida Law Review, Awards for highest 

   grades in Comparative Constitutional History, Legal Drafting, Real Property and 

   Sales, ', u'2007']4) Write the scraped school info into schools.csv fileCan you help me write this spider in Python? I've been trying to write it in Scrapy but without success. See my previous question.Thank you.

2009-11-26 19:07:55Z

I've been trying to write this spider for weeks but without success. What is the best way for me to code this in Python:1) Initial url: http://www.whitecase.com/Attorneys/List.aspx?LastName=A2) from initial url pick up these urls with this regex:hxs.select('//td[@class="altRow"][1]/a/@href').re('/.a\w+')3) Go to each of these urls and scrape the school info with this regexhxs.select('//td[@class="mainColumnTDa"]').re('(?<=(JD,\s))(.*?)(\d+)'[u'JD, ', u'University of Florida Levin College of Law, <em>magna cum laude</em>

   , Order of the Coif, Symposium Editor, Florida Law Review, Awards for highest 

   grades in Comparative Constitutional History, Legal Drafting, Real Property and 

   Sales, ', u'2007']4) Write the scraped school info into schools.csv fileCan you help me write this spider in Python? I've been trying to write it in Scrapy but without success. See my previous question.Thank you.http://www.ibm.com/developerworks/linux/library/l-spider/ IBM article with good description orhttp://code.activestate.com/recipes/576551/ Python cookbook, better code but less explanationAlso, I suggest you read:RegEx match open tags except XHTML self-contained tagsBefore you try to parse HTML with a regular expression.  Then think about what happens the first time someone's name forces the page to be unicode instead of latin-1.EDIT: To answer your question about a library to use in Python, I would suggest Beautiful Soup, which is a great HTML parser and supports unicode throughout (and does a really good job with malformed HTML, which you're going to find all over the place).

How to count empty responses in Scrapy ?

tomasyany

[How to count empty responses in Scrapy ?](https://stackoverflow.com/questions/23361423/how-to-count-empty-responses-in-scrapy)

I want to know how many and which of my requests didn't return any data with Scrapy. There are many cases, like when a 404 response is returned, or when the server returned something but didn't scraped any data because the format was not the one expected (e.g. when I'm extracting from a type of particular named div, and it actually doesn't exists in one of the url's).

Thanks !

2014-04-29 09:59:42Z

I want to know how many and which of my requests didn't return any data with Scrapy. There are many cases, like when a 404 response is returned, or when the server returned something but didn't scraped any data because the format was not the one expected (e.g. when I'm extracting from a type of particular named div, and it actually doesn't exists in one of the url's).

Thanks !This is not actually an empty response in HTTP terms. Your selector just didn't match.You have to implement this logic by yourself:For stats you could use a Scrapy stats collector.

Scrapy weird output

Abhishek

[Scrapy weird output](https://stackoverflow.com/questions/21993674/scrapy-weird-output)

I have a scrapy spider that parses this linkMy spider looks as follows:The output i get looks like the following:So my question is: I would like to know if there is a better way of defining my xpaths so that i do not get the newline(\n) and tab(\t) characters in my output.

Also the required_skills Field was not able to scrape any text from the field. I would like to know where i have the mistake. Thank you in advance!

2014-02-24 16:43:24Z

I have a scrapy spider that parses this linkMy spider looks as follows:The output i get looks like the following:So my question is: I would like to know if there is a better way of defining my xpaths so that i do not get the newline(\n) and tab(\t) characters in my output.

Also the required_skills Field was not able to scrape any text from the field. I would like to know where i have the mistake. Thank you in advance!If you know you can expect 1 output string value from an XPath expression, you can wrap your XPath in normalize-space(). Also, within the for title in titles loop, you should use relative XPath expressions (starting with .//, not absolute XPath expressions starting with //)For example:For required_skills, I suggest you try normalize-space(.//*[@id="jobRequiredSkillsDiv"]/ul):You can clean it with python:

Scrapy AttributeError: 'Selector' object has no attribute 'extract_first'

Peyman

[Scrapy AttributeError: 'Selector' object has no attribute 'extract_first'](https://stackoverflow.com/questions/54637571/scrapy-attributeerror-selector-object-has-no-attribute-extract-first)

In crawling the page https://github.com/rg3/youtube-dl/pull/11272 with Scrapy 1.6, when I select with the selector:the result would be something that has no attribute 'extract_first'.for example running this code will be facing with that err:I can't understand it, do you know where am I wrong? thanks in advance.

2019-02-11 19:16:15Z

In crawling the page https://github.com/rg3/youtube-dl/pull/11272 with Scrapy 1.6, when I select with the selector:the result would be something that has no attribute 'extract_first'.for example running this code will be facing with that err:I can't understand it, do you know where am I wrong? thanks in advance.The reason is that in your code code_and_comment is already a single Selector, so there's no point in having extract_first. It only works on a list of Selectors (which is what you get from response.xpath(...)).You can just do the following:

Scrapy and possibilities available

Thierrydev

[Scrapy and possibilities available](https://stackoverflow.com/questions/55361023/scrapy-and-possibilities-available)

I’m looking into web scrapping /crawling possibilities and have been reading up on the Scrapy program. I was wondering if anyone knows if it’s possible to input instructions into the script so that once it’s visited the url it can then choose pre-selected dates from a calendar on the website. ? 

End result is for this to be used for price comparisons on sites such as Trivago. I’m hoping I can get the program to select certain criteria such as dates once on the website like a human would. Thanks,

Alex

2019-03-26 15:37:12Z

I’m looking into web scrapping /crawling possibilities and have been reading up on the Scrapy program. I was wondering if anyone knows if it’s possible to input instructions into the script so that once it’s visited the url it can then choose pre-selected dates from a calendar on the website. ? 

End result is for this to be used for price comparisons on sites such as Trivago. I’m hoping I can get the program to select certain criteria such as dates once on the website like a human would. Thanks,

AlexIn theory for a website like Trivago you can use the URL to set the dates you want to query but you will need to research user agents and proxies because otherwise your IP will get blacklisted really fast.

How to scrape the html code from the response received?

pap

[How to scrape the html code from the response received?](https://stackoverflow.com/questions/56376712/how-to-scrape-the-html-code-from-the-response-received)

I am trying to crawl-scrape a website with scrapy and splash. 

I want to scrape a specific html code from a response which seems in the image.

Here is the response with its headers:

Here is the response (the html I want to scrape):

I can find that HTML with the Inspect Tool. What my code returns is the html which I can see with "View page source" Tool. So, this means taht Javascript modifies the code before embedding it. But, the splash role is to run javascript and return HTML, isn't it??

The response.body returns the source code of the page without the html code i need from the response i mentioned above.

2019-05-30 10:44:31Z

I am trying to crawl-scrape a website with scrapy and splash. 

I want to scrape a specific html code from a response which seems in the image.

Here is the response with its headers:

Here is the response (the html I want to scrape):

I can find that HTML with the Inspect Tool. What my code returns is the html which I can see with "View page source" Tool. So, this means taht Javascript modifies the code before embedding it. But, the splash role is to run javascript and return HTML, isn't it??

The response.body returns the source code of the page without the html code i need from the response i mentioned above.In order to load the full page, you will need to add the "wait" parameter. 

Try adding "args={'wait': 1.0}" to your SplashRequest.

