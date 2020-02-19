搜索关键词：[scrapy] [web-crawler]

## 01. Difference between BeautifulSoup and Scrapy crawler?

Nishant Bhakta

[Difference between BeautifulSoup and Scrapy crawler?](https://stackoverflow.com/questions/19687421/difference-between-beautifulsoup-and-scrapy-crawler)

I want to make a website that shows the comparison between amazon and e-bay product price. Which of these will work better and why? I am somewhat familiar with BeautifulSoup but not so much with Scrapy crawler.

2013-10-30 15:43:23Z

### 01

Scrapy is a Web-spider or web scraper framework, You give Scrapy a root URL to start crawling, then you can specify constraints on how many (number of) URLs you want to crawl and fetch, etc. It is a complete framework for web-scraping or crawling. WhileBeautifulSoup is a parsing library which also does a pretty good job of fetching contents from URL and allows you to parse certain parts of them without any hassle. It only fetches the contents of the URL that you give and then stops. It does not crawl unless you manually put it inside an infinite loop with certain criteria. In simple words, with Beautiful Soup you can build something similar to Scrapy. Beautiful Soup is a library while Scrapy is a complete framework.

### 02

I think both are good... I'm doing a project right now that use both. First I scrap all the pages using scrapy and save that on a mongodb collection using their pipelines, also downloading the images that exists on the page.

After that I use BeautifulSoup4 to make a pos-processing where i must change attributes values and get some special tags. If you don't know which pages products you want, a good tool will be scrapy since you can use their crawlers to run all amazon/ebay website looking for the products without making a explicit for loop. Take a look at the scrapy documentation, it's very simple to use. 

### 03

The way I do it is to use the eBay/Amazon API's rather than scrapy, and then parse the results using BeautifulSoup. The APIs gives you an official way of getting the same data that you would have got from scrapy crawler, with no need to worry about hiding your identity, mess about with proxies, etc.

Both are using to parse data. Scrapy with BeautifulSoup is one of the best combo we can work with for scraping static and dynamic contents. 

### 04

Scrapy. It is a web scraping framework which comes with tons of goodies which make scraping from easier so that we can focus on crawling logic only. Some of my favourite things scrapy takes care for us are below. 

Feed exports: It basically allows us to save data in various formats like CSV, JSON, jsonlines and XML.

Asynchronous scraping: Scrapy uses twisted framework which gives us power to visit multiple urls at once where each request is processed in non blocking way(Basically we don't have to wait for a request to finish before sending another request).

Selectors: This is where we can compare scrapy with beautiful soup. Selectors are what allow us to select particular data from the webpage like heading, certain div with a class name etc.). Scrapy uses lxml for parsing which is extremely fast than beautiful soup.

Setting proxy, user agent, headers etc: scrapy allows us to set and rotate proxy, and other headers dynamically.

Item Pipelines: Pipelines enable us to process data after extraction. For example we can configure pipeline to push data to your mysql server.

Cookies: scrapy automatically handles cookies for us.

TLDR: scrapy is a framework that provides everything that one might need to build large scale crawls. It provides various features that hide complexity of crawling the webs. one can simply start writing web crawlers without worrying about the setup burden.

Beautiful Soup is a Python package for parsing HTML and XML documents. So with Beautiful soup you can parse a webpage that has been already downloaded. BS4 is very popular and old. Unlike scrapy,You cannot use beautiful soup only to make crawlers. You will need other libraries like requests, urllib etc to make crawlers with bs4. Again, this means you would need to manage the list of urls being crawled, to be crawled, handle cookies, manage proxy, handle errors, create your own functions to push data to CSV, JSON, XML etc. If you want to speed up than you will have to use other libraries like multiprocessing.

To sum up.

Scrapy is a rich framework that you can use to start writing crawlers without any hassale.

Beautiful soup is a library that you can use to parse a webpage. It cannot be used alone to scrape web.

You should definitely use scrapy for your amazon and e-bay product price comparison website. You could build a database of urls and run the crawler every day(cron jobs, Celery for scheduling crawls) and update the price on your database. This way your website will always pull from the database and crawler and database will act as individual components.

### 05

BeautifulSoup is a library that lets you extract information from a web page. Scrapy on the other hand is a framework, which does the above thing and many more things you probably need in your scraping project like pipelines for saving data. You can check this blog to get started with Scrapy.

https://www.inkoop.io/blog/web-scraping-using-python-and-scrapy/

### 06

Using scrapy you can save tons of code and start with structured programming, If you dont like any of the scapy's pre-written methods then BeautifulSoup can be used in the place of scrapy method. Big project takes both advantages.The differences are many and selection of any tool/technology depends on individual needs. Few major differences are: 1) BeautifulSoup is comparatively is easy to learn than Scrapy. 2) The extensions, support, community is larger for Scrapy than for BeautifulSoup. 3) Scrapy should be considered as a Spider while BeautifulSoup is a Parser.

## 02. How to give URL to scrapy for crawling?

G Gill

[How to give URL to scrapy for crawling?](https://stackoverflow.com/questions/9681114/how-to-give-url-to-scrapy-for-crawling)

I want to use scrapy for crawling web pages. Is there a way to pass the start URL from the terminal itself?It is given in the documentation that either the name of the spider or the URL can be given, but when i given the url it throws an error://name of my spider is example, but i am giving url instead of my spider name(It works fine if i give spider name).ERROR:How can i make scrapy to use my spider on the url given in the terminal??

2012-03-13 09:11:31Z

I want to use scrapy for crawling web pages. Is there a way to pass the start URL from the terminal itself?It is given in the documentation that either the name of the spider or the URL can be given, but when i given the url it throws an error://name of my spider is example, but i am giving url instead of my spider name(It works fine if i give spider name).ERROR:How can i make scrapy to use my spider on the url given in the terminal??I'm  not really sure about the commandline option. However, you could write your spider like this.And start it like:

scrapy crawl my_spider -a start_url="http://some_url"An even easier way to allow multiple url-arguments than what Peter suggested is by giving them as a string with the urls separated by a comma, like this:In the spider you would then simply split the string on ',' and get an array of urls:Use scrapy parse command. You can parse a url with your spider. url is passed from command.http://doc.scrapy.org/en/latest/topics/commands.html#parseThis is an extension to the approach given by Sjaak Trekhaak in this thread. The approach as it is so far only works if you provide exactly one url. For example, if you want to provide more than one url like this, for instance: then Scrapy (I'm using the current stable version 0.14.4) will terminate with the following exception:However, you can circumvent this problem by choosing a different variable for each start url, together with an argument that holds the number of passed urls. Something like this:You can then do the following in your spider:This is a somewhat ugly hack but it works. Of course, it's tedious to explicitly write down all command line arguments for each url. Therefore, it makes sense to wrap the scrapy crawl command in a Python subprocess and generate the command line arguments in a loop or something.Hope it helps. :) Sjaak Trekhaak has the right idea and here is how to allow multiples:You can also try this:It will open a window in browser of requested URL.

Passing arguments to process.crawl in Scrapy python

yusuf

[Passing arguments to process.crawl in Scrapy python](https://stackoverflow.com/questions/34382356/passing-arguments-to-process-crawl-in-scrapy-python)

I would like to get the same result as this command line :

scrapy crawl linkedin_anonymous -a first=James -a last=Bond -o output.jsonMy script is as follows :I found out that process.crawl() in (1) is creating another LinkedInAnonymousSpider where first and last are None (printed in (2)), if so, then there is no point of creating the object spider and how is it possible to pass the arguments first and last to process.crawl()?linkedin_anonymous :

2015-12-20 15:06:10Z

I would like to get the same result as this command line :

scrapy crawl linkedin_anonymous -a first=James -a last=Bond -o output.jsonMy script is as follows :I found out that process.crawl() in (1) is creating another LinkedInAnonymousSpider where first and last are None (printed in (2)), if so, then there is no point of creating the object spider and how is it possible to pass the arguments first and last to process.crawl()?linkedin_anonymous :pass the spider arguments on the process.crawl method:You can do it the easy way:

How to generate the start_urls dynamically in crawling?

user1215269

[How to generate the start_urls dynamically in crawling?](https://stackoverflow.com/questions/9322219/how-to-generate-the-start-urls-dynamically-in-crawling)

I am crawling a site which may contain a lot of start_urls, like:I want to populate start_urls like [list_\d+_\d+_\d+\.htm],

and extract items from URLs like [node_\d+\.htm] during crawling. Can I use CrawlSpider to realize this function?

And how can I generate the start_urls dynamically in crawling?

2012-02-17 02:49:01Z

I am crawling a site which may contain a lot of start_urls, like:I want to populate start_urls like [list_\d+_\d+_\d+\.htm],

and extract items from URLs like [node_\d+\.htm] during crawling. Can I use CrawlSpider to realize this function?

And how can I generate the start_urls dynamically in crawling?The best way to generate URLs dynamically is to override the start_requests method of the spider:  There are two questions:1)yes you can realize this functionality by using Rules e.g ,suggested reading2) yes you can generate start_urls dynamically ,  start_urls is a e.g >>> start_urls = ['http://www.a.com/%d_%d_%d' %(n,n+1,n+2) for n in range(0, 26)]

unknown command: crawl error

Nits

[unknown command: crawl error](https://stackoverflow.com/questions/10123104/unknown-command-crawl-error)

I am a newbie to python. I am running python 2.7.3 version 32 bit on 64 bit OS. (I tried 64 bit but it didn't workout).I followed the tutorial and installed scrapy on my machine. I have created one project, demoz. But when I enter scrapy crawl demoz it shows an error. I came across this thing when i hit scrapy command under (C:\python27\scripts) it shows:I guess their is something missing in installation can anybody help please .. Thanks in advance..

2012-04-12 11:58:08Z

I am a newbie to python. I am running python 2.7.3 version 32 bit on 64 bit OS. (I tried 64 bit but it didn't workout).I followed the tutorial and installed scrapy on my machine. I have created one project, demoz. But when I enter scrapy crawl demoz it shows an error. I came across this thing when i hit scrapy command under (C:\python27\scripts) it shows:I guess their is something missing in installation can anybody help please .. Thanks in advance..You should run scrapy crawl spider_name command being in a scrapy project folder, where scrapy.cfg file resides.From the docs:You can run scrapy crawl demoz code from your scrapy project folder which you have created using following commandFor example, if you have started scrapy project of name tutorials, then go to tutorials folder first and run crawl command from thereFirst create a project:There will be two folders of project_name created, then create any python file in spiders folder and in that file:Save the file and open the terminal for this folder and then type:

Can Scrapy be replaced by pyspider?

alecxe

[Can Scrapy be replaced by pyspider?](https://stackoverflow.com/questions/27243246/can-scrapy-be-replaced-by-pyspider)

I've been using Scrapy web-scraping framework pretty extensively, but, recently I've discovered that there is another framework/system called pyspider, which, according to it's github page, is fresh, actively developed and popular.pyspider's home page lists several things being supported out-of-the-box:These are the things that Scrapy itself doesn't provide, but, it is possible with the help of portia (for Web UI), scrapyjs (for js pages) and scrapyd (deploying and distributing through API).Is it true that pyspider alone can replace all of these tools? In other words, is pyspider a direct alternative to Scrapy? If not, then which use cases does it cover?I hope I'm not crossing "too broad" or "opinion-based" line.

2014-12-02 06:33:53Z

I've been using Scrapy web-scraping framework pretty extensively, but, recently I've discovered that there is another framework/system called pyspider, which, according to it's github page, is fresh, actively developed and popular.pyspider's home page lists several things being supported out-of-the-box:These are the things that Scrapy itself doesn't provide, but, it is possible with the help of portia (for Web UI), scrapyjs (for js pages) and scrapyd (deploying and distributing through API).Is it true that pyspider alone can replace all of these tools? In other words, is pyspider a direct alternative to Scrapy? If not, then which use cases does it cover?I hope I'm not crossing "too broad" or "opinion-based" line.pyspider and Scrapy have the same purpose, web scraping, but a different view about doing that.and In fact, I have not referred much from Scrapy. pyspider is really different from Scrapy.But, why not try it yourself? pyspider is also fast, has easy-to-use API and you can try it without install.Since I use both scrapy and pyspider, I would like to suggest the following:If the website is really small / simple, try pyspider first since it has almost everything you needHowever, if you tried pyspider and found it can't fit your needs, it's time to use scrapy. 

 - migrate on_start to start_request 

 - migrate index_page to parse

 - migrate detail_age to detail_age 

 - change self.crawl to response.followThen you are almost done.

Now you can play with scrapy's advanced features like middleware, items, pipline etc. 

Writing items to a MySQL database in Scrapy

Shiva Krishna Bavandla

[Writing items to a MySQL database in Scrapy](https://stackoverflow.com/questions/10845839/writing-items-to-a-mysql-database-in-scrapy)

I am new to Scrapy, I had the spider codeAnd pipeline code is:After running this I am getting the following error I got the above error when I added the below code in process_item methodand without adding this line I am getting Can anyone make this code run and make sure that all the items saved into database?

2012-06-01 07:03:37Z

I am new to Scrapy, I had the spider codeAnd pipeline code is:After running this I am getting the following error I got the above error when I added the below code in process_item methodand without adding this line I am getting Can anyone make this code run and make sure that all the items saved into database?Try the following code in your pipelineYour process_item method should be declared as: def process_item(self, item, spider): instead of def process_item(self, spider, item): -> you switched the arguments around.This exception: exceptions.NameError: global name 'Exampleitem' is not defined indicates you didn't import the Exampleitem in your pipeline.

Try adding: from myspiders.myitems import Exampleitem (with correct names/paths ofcourse).I think this way is better and more concise:It's just likeCause (you can read more about Items in Scrapy)

How to force scrapy to crawl duplicate url?

Alok Singh Mahor

[How to force scrapy to crawl duplicate url?](https://stackoverflow.com/questions/23131283/how-to-force-scrapy-to-crawl-duplicate-url)

I am learning Scrapy a web crawling framework.

by default it does not crawl duplicate urls or urls which scrapy have already crawled.  How to make Scrapy to crawl duplicate urls or urls which have already crawled?

I tried to find out on internet but could not find relevant help.  I found DUPEFILTER_CLASS = RFPDupeFilter and SgmlLinkExtractor from Scrapy - Spider crawls duplicate urls but this question is opposite of what I am looking

2014-04-17 10:57:12Z

I am learning Scrapy a web crawling framework.

by default it does not crawl duplicate urls or urls which scrapy have already crawled.  How to make Scrapy to crawl duplicate urls or urls which have already crawled?

I tried to find out on internet but could not find relevant help.  I found DUPEFILTER_CLASS = RFPDupeFilter and SgmlLinkExtractor from Scrapy - Spider crawls duplicate urls but this question is opposite of what I am lookingYou're probably looking for the dont_filter=True argument on Request().

See http://doc.scrapy.org/en/latest/topics/request-response.html#request-objectsA more elegant solution is to disable the duplicate filter altogether:This way you don't have to clutter all your Request creation code with dont_filter=True. Another side effect: this only disables duplicate filtering and not any other filters like offsite filtering.If you want to use this setting selectively for only one or some of multiple spiders in your project, you can set it via custom_settings in the spider implementation:

How do I use the Python Scrapy module to list all the URLs from my website?

Adam F

[How do I use the Python Scrapy module to list all the URLs from my website?](https://stackoverflow.com/questions/9561020/how-do-i-use-the-python-scrapy-module-to-list-all-the-urls-from-my-website)

I want to use the Python Scrapy module to scrape all the URLs from my website and write the list to a file. I looked in the examples but didn't see any simple example to do this.

2012-03-05 02:43:47Z

I want to use the Python Scrapy module to scrape all the URLs from my website and write the list to a file. I looked in the examples but didn't see any simple example to do this.Here's the python program that worked for me:Save this in a file called spider.py.You can then use a shell pipeline to post process this text:This gives me a list of all the unique urls in my site.something cleaner (and maybe more useful) would be using LinkExtractor

How do Scrapy rules work with crawl spider

Vy.Iv

[How do Scrapy rules work with crawl spider](https://stackoverflow.com/questions/22082938/how-do-scrapy-rules-work-with-crawl-spider)

I have hard time to understand scrapy crawl spider rules. I have example that doesn't work as I would like it did, so it can be two things:OK here it is what I want to do:I want to write crawl spider that will get all available statistics information from http://www.euroleague.net website.

The website page that hosts all the information that I need for the start is here.Step 1First step what I am thinking is extract "Seasons" link(s) and fallow it.

Here it is HTML/href that I am intending to match (I want to match all links in the "Seasons" section one by one, but I think that it will be easer to have one link as an example):And here is a rule/regex that I created for it:Step 2When I am brought by spider to the web page http://www.euroleague.net/main/results/by-date?seasoncode=E2001 for the second step I want that spider extracted link(s) from section "Regular season". At this case lets say it should be "Round 1". The HTML/href that I am looking for is:And rule/regex that I constructed would be:Step 3Now I reached page (http://www.euroleague.net/main/results/by-date?seasoncode=E2001&gamenumber=1&phasetypecode=RS) I am ready to extract links that leads to the pages that has all the information that I need:

I am looking for HTML/href:And my regex that has to follow would be:The problemI think that crawler should work something like this:

That rules crawler is something like a loop. When first link is matched the crawler will follow to the "Step 2" page, than to "step 3" and after that it will extract data. After doing that it will return to "step 1" to match second link and start loop again to the point when there is no links in first step.What I see from terminal it seems that crawler loops in "Step 1". It loops through all "Step 1" links, but doesn't involves "step 2"/"step 3" rules. After it loops through all the "Seasons" links it starts with links that I don't see, in any of three steps that I mentioned:And such link structure you can find only if you loop through all the links in "Step 2" without returning to the "Step 1" starting point. The question would be:

How rules work? Is it working step by step like I am intending it should work with this example or every rule has it's own loop and goes from rule to rule only after it's finished looping through the first rule?That is how I see it. Of course it could be something wrong with my rules/regex and it is very possible.And here is all what I am getting from the terminal:And here is a rules part from the crawler:

2014-02-27 23:28:05Z

I have hard time to understand scrapy crawl spider rules. I have example that doesn't work as I would like it did, so it can be two things:OK here it is what I want to do:I want to write crawl spider that will get all available statistics information from http://www.euroleague.net website.

The website page that hosts all the information that I need for the start is here.Step 1First step what I am thinking is extract "Seasons" link(s) and fallow it.

Here it is HTML/href that I am intending to match (I want to match all links in the "Seasons" section one by one, but I think that it will be easer to have one link as an example):And here is a rule/regex that I created for it:Step 2When I am brought by spider to the web page http://www.euroleague.net/main/results/by-date?seasoncode=E2001 for the second step I want that spider extracted link(s) from section "Regular season". At this case lets say it should be "Round 1". The HTML/href that I am looking for is:And rule/regex that I constructed would be:Step 3Now I reached page (http://www.euroleague.net/main/results/by-date?seasoncode=E2001&gamenumber=1&phasetypecode=RS) I am ready to extract links that leads to the pages that has all the information that I need:

I am looking for HTML/href:And my regex that has to follow would be:The problemI think that crawler should work something like this:

That rules crawler is something like a loop. When first link is matched the crawler will follow to the "Step 2" page, than to "step 3" and after that it will extract data. After doing that it will return to "step 1" to match second link and start loop again to the point when there is no links in first step.What I see from terminal it seems that crawler loops in "Step 1". It loops through all "Step 1" links, but doesn't involves "step 2"/"step 3" rules. After it loops through all the "Seasons" links it starts with links that I don't see, in any of three steps that I mentioned:And such link structure you can find only if you loop through all the links in "Step 2" without returning to the "Step 1" starting point. The question would be:

How rules work? Is it working step by step like I am intending it should work with this example or every rule has it's own loop and goes from rule to rule only after it's finished looping through the first rule?That is how I see it. Of course it could be something wrong with my rules/regex and it is very possible.And here is all what I am getting from the terminal:And here is a rules part from the crawler:You are right, according to the source code before returning each response to the callback function, the crawler loops over the Rules, starting, from the first. You should have it in mind, when you write the rules. For example the following rules:The second rule will never be applied since all the links will be extracted by the first rule with parse_item callback. The matches for the second rule will be filtered out as duplicates by the scrapy.dupefilter.RFPDupeFilter. You should use deny for correct matching of links:If you are from china, I have a chinese blog post about this:别再滥用scrapy CrawlSpider中的follow=TrueLet's check out how the rules work under the hood:as you can see, when we follow a link, the link in the response is extracted by all the rule using a for loop then add them to a set object.and all the response will be handled by self._response_downloaded:and it goes back to the self._requests_to_follow(response) again and again.In summary:I would be tempted to use a BaseSpider scraper instead of a crawler. Using a basespider you can have more of a flow of intended request routes instead of finding ALL hrefs on the page and visiting them based on global rules. Use yield Requests() to continue looping through the parent sets of links and callbacks to pass the output object all the way to the end.From your description:A request callback stack like this would suit you very well. Since you know the order of the pages and which pages you need to scrape. This also has the added benefit of being able to collect information over multiple pages before returning the output object to be processed.

scrapy- how to stop Redirect (302)

user_2000

[scrapy- how to stop Redirect (302)](https://stackoverflow.com/questions/15476587/scrapy-how-to-stop-redirect-302)

I'm trying to crawl a url using Scrapy. But it redirects me to page that doesn't exist. The problem is http://www.shop.inonit.in/Products/Inonit-Home-Decor--Knick-Knacks-Cushions/Shor-Sharaba/Andaz-Apna-Apna-Cushion-Cover/pid-1275197.aspx exists, but http://www.shop.inonit.in/mobile/Products/Inonit-Home-Decor--Knick-Knacks-Cushions/Shor-Sharaba/Andaz-Apna-Apna-Cushion-Cover/1275197 doesn't, so the crawler cant find this. I've crawled many other websites as well but didn't have this problem anywhere else. Is there a way I can stop this redirect?Any help would be much appreciated. Thanks.Update: This is my spider class

2013-03-18 12:13:11Z

I'm trying to crawl a url using Scrapy. But it redirects me to page that doesn't exist. The problem is http://www.shop.inonit.in/Products/Inonit-Home-Decor--Knick-Knacks-Cushions/Shor-Sharaba/Andaz-Apna-Apna-Cushion-Cover/pid-1275197.aspx exists, but http://www.shop.inonit.in/mobile/Products/Inonit-Home-Decor--Knick-Knacks-Cushions/Shor-Sharaba/Andaz-Apna-Apna-Cushion-Cover/1275197 doesn't, so the crawler cant find this. I've crawled many other websites as well but didn't have this problem anywhere else. Is there a way I can stop this redirect?Any help would be much appreciated. Thanks.Update: This is my spider classyes you can do this simply by adding meta values likealso you can stop redirected for a particular response code likeit will stop redirecting only 302 response codes.exampleAfter looking at the documentation and looking through the relevant source, I was able to figure it out. If you look in the source for start_requests, you'll see that it calls make_requests_from_url for all URLs.Instead of modifying start_requests, I modified make_requests_from_urlAnd added this as part of my spider, right above parse().By default, Scrapy use RedirectMiddleware to handle redirection. You can set REDIRECT_ENABLED to False to disable redirection.See documentation. As explained here: Scrapy docsUse Request Meta

Scrapy - logging to file and stdout simultaneously, with spider names

goh

[Scrapy - logging to file and stdout simultaneously, with spider names](https://stackoverflow.com/questions/8532252/scrapy-logging-to-file-and-stdout-simultaneously-with-spider-names)

I've decided to use the Python logging module because the messages generated by Twisted on std error is too long, and I want to INFO level meaningful messages such as those generated by the StatsCollector to be written on a separate log file while maintaining the on screen messages.Well, this is fine, I've got my messages, but the downside is that I do not know the messages are generated by which spider! This is my log file, with "twisted" being displayed by %(name)s:As compared to the messages generated from twisted on standard error:I've tried %(name)s, %(module)s amongst others but I don't seem to be able to show the spider name. Does anyone knows the answer?EDIT:

the problem with using LOG_FILE and LOG_LEVEL in settings is that the lower level messages will not be shown on std error.

2011-12-16 09:37:41Z

I've decided to use the Python logging module because the messages generated by Twisted on std error is too long, and I want to INFO level meaningful messages such as those generated by the StatsCollector to be written on a separate log file while maintaining the on screen messages.Well, this is fine, I've got my messages, but the downside is that I do not know the messages are generated by which spider! This is my log file, with "twisted" being displayed by %(name)s:As compared to the messages generated from twisted on standard error:I've tried %(name)s, %(module)s amongst others but I don't seem to be able to show the spider name. Does anyone knows the answer?EDIT:

the problem with using LOG_FILE and LOG_LEVEL in settings is that the lower level messages will not be shown on std error.You want to use the ScrapyFileLogObserver.I'm glad you asked this question, I've been wanting to do this myself.It is very easy to redirect output using: scrapy some-scrapy's-args 2>&1 | tee -a lognameThis way, all what scrapy ouputs into stdout and stderr, will be redirected to a logname file and also, prited to the screen.For all those folks who came here before reading the current documentation version:I know this is old but it was a really helpful post since the class still isn't properly documented in the Scrapy docs. Also, we can skip importing logging and use scrapy logs directly. Thanks All!ScrapyFileLogObserver is no longer supported. You may use standard python logging module. As the Scrapy Official Doc said:So you can config your logger just as a normal Python script.First, you have to import the logging module:You can add this line to your spider:It adds a stream handler to log to console.After that, you have to config logging file path.Add a dict named custom_settings which consists of your spider-specified settings:The whole class looks like:

Creating a generic scrapy spider

user1284717

[Creating a generic scrapy spider](https://stackoverflow.com/questions/9814827/creating-a-generic-scrapy-spider)

My question is really how to do the same thing as a previous question, but in Scrapy 0.14.Using one Scrapy spider for several websitesBasically, I have GUI that takes parameters like domain, keywords, tag names, etc. and I want to create a generic spider to crawl those domains for those keywords in those tags.  I've read conflicting things, using older versions of scrapy, by either overriding the spider manager class or by dynamically creating a spider.  Which method is preferred and how do I implement and invoke the proper solution?  Thanks in advance.Here is the code that I want to make generic.  It also uses BeautifulSoup.  I paired it down so hopefully didn't remove anything crucial to understand it.

2012-03-22 00:24:39Z

My question is really how to do the same thing as a previous question, but in Scrapy 0.14.Using one Scrapy spider for several websitesBasically, I have GUI that takes parameters like domain, keywords, tag names, etc. and I want to create a generic spider to crawl those domains for those keywords in those tags.  I've read conflicting things, using older versions of scrapy, by either overriding the spider manager class or by dynamically creating a spider.  Which method is preferred and how do I implement and invoke the proper solution?  Thanks in advance.Here is the code that I want to make generic.  It also uses BeautifulSoup.  I paired it down so hopefully didn't remove anything crucial to understand it.You could create a run-time spider which is evaluated by the interpreter. This code piece could be evaluated at runtime like so:I use the Scrapy Extensions approach to extend the Spider class to a class named Masterspider that includes a generic parser.Below is the very "short" version of my generic extended parser. Note that you'll need to implement a renderer with a Javascript engine (such as Selenium or BeautifulSoup) a as soon as you start working on pages using AJAX. And a lot of additional code to manage differences between sites (scrap based on column title, handle relative vs long URL, manage different kind of data containers, etc...).What is interresting with the Scrapy Extension approach is that you can still override the generic parser method if something does not fit but I never had to. The Masterspider class checks if some methods have been created (eg. parser_start, next_url_parser...) under the site specific spider class to allow the management of specificies: send a form, construct the next_url request from elements in the page, etc.As I'm scraping very different sites, there's always specificities to manage. That's why I prefer to keep a class for each scraped site so that I can write some specific methods to handle it (pre-/post-processing except PipeLines, Request generators...).masterspider/sitespider/settings.pymasterspider/masterspdier/masterspider.pymasterspider/sitespider/spiders/somesite_spider.pyInstead of having the variables name,allowed_domains, start_urls and rules attached to the class, you should write a MySpider.__init__, call CrawlSpider.__init__ from that passing the necessary arguments, and setting name, allowed_domains etc. per object. 

MyProp and keywords also should be set within your __init__. So in the end you should have something like below. You don't have to add name to the arguments, as name is set by BaseSpider itself from kwargs: I am not sure which way is preferred, but I will tell you what I have done in the past. I am in no way sure that this is the best (or correct) way of doing this and I would be interested to learn what other people think.I usually just override the parent class (CrawlSpider) and either pass in arguments and then initialize the parent class via super(MySpider, self).__init__() from within my own init-function or I pull in that data from a database where I have saved a list of links to be appended to start_urls earlier.As far as crawling specific domains passed as arguments goes, I just override Spider.__init__: