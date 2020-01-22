Using yield from with a future automatically takes care of waiting for it to finish, without blocking the event loop—because in asyncio, yield from is used to give control back to the event loop.

Note that using yield from with a future is the coroutine equivalent of the functionality offered by add_done_callback: instead of triggering a callback, when the delayed operation is done, the event loop sets the result of the future, and the yield from expression produces a return value inside our suspended coroutine, allowing it to resume.

In summary, because asyncio.Future is designed to work with yield from, these methods are often not needed:

You don’t need my_future.add_done_callback(…) because you can simply put whatever processing you would do after the future is done in the lines that follow yield from my_future in your coroutine. That’s the big advantage of having coroutines: functions that can be suspended and resumed.

You don’t need my_future.result() because the value of a yield from expression on a future is the result (e.g., result = yield from my_future).

Of course, there are situations in which .done(), .add_done_callback(…), and .results() are useful. But in normal usage, asyncio futures are driven by yield from, not by calling those methods.

We’ll now consider how yield from and the asyncio API brings together futures, tasks, and coroutines.

Yielding from Futures, Tasks, and Coroutines

In asyncio, there is a close relationship between futures and coroutines because you can get the result of an asyncio.Future by yielding from it. This means that res = yield from foo() works if foo is a coroutine function (therefore it returns a coroutine object when called) or if foo is a plain function that returns a Future or Task instance. This is one of the reasons why coroutines and futures are interchangeable in many parts of the asyncio API.

In order to execute, a coroutine must be scheduled, and then it’s wrapped in an asyncio.Task. Given a coroutine, there are two main ways of obtaining a Task:

asyncio.async(coro_or_future, *, loop=None)

This function unifies coroutines and futures: the first argument can be either one. If it’s a Future or Task, it’s returned unchanged. If it’s a coroutine, async calls loop.create_task(…) on it to create a Task. An optional event loop may be passed as the loop= keyword argument; if omitted, async gets the loop object by calling asyncio.get_event_loop().

BaseEventLoop.create_task(coro)

This method schedules the coroutine for execution and returns an asyncio.Task object. If called on a custom subclass of BaseEventLoop, the object returned may be an instance of some other Task-compatible class provided by an external library (e.g., Tornado).

Warning

BaseEventLoop.create_task(…) is only available in Python 3.4.2 or later. If you’re using an older version of Python 3.3 or 3.4, you need to use asyncio.async(…), or install a more recent version of asyncio from PyPI.

Several asyncio functions accept coroutines and wrap them in asyncio.Task objects automatically, using asyncio.async internally. One example is BaseEventLoop.run_until_complete(…).

If you want to experiment with futures and coroutines on the Python console or in small tests, you can use the following snippet:[159]

>>> import asyncio >>> def run_sync(coro_or_future): ... loop = asyncio.get_event_loop() ... return loop.run_until_complete(coro_or_future) ... >>> a = run_sync(some_coroutine())

The relationship between coroutines, futures, and tasks is documented in section 18.5.3. Tasks and coroutines of the asyncio documentation, where you’ll find this note:

In this documentation, some methods are documented as coroutines, even if they are plain Python functions returning a Future. This is intentional to have a freedom of tweaking the implementation of these functions in the future.

Having covered these fundamentals, we’ll now study the code for the asynchronous flag download script flags_asyncio.py demonstrated along with the sequential and thread pool scripts in Example 17-1 (Chapter 17).

Downloading with asyncio and aiohttp

As of Python 3.4, asyncio only supports TCP and UDP directly. For HTTP or any other protocol, we need third-party packages; aiohttp is the one everyone seems to be using for asyncio HTTP clients and servers at this time.

Example 18-5 is the full listing for the flag downloading script flags_asyncio.py. Here is a high-level view of how it works:

We start the process in download_many by feeding the event loop with several coroutine objects produced by calling download_one.

The asyncio event loop activates each coroutine in turn.

When a client coroutine such as get_flag uses yield from to delegate to a library coroutine—such as aiohttp.request—control goes back to the event loop, which can execute another previously scheduled coroutine.

The event loop uses low-level APIs based on callbacks to get notified when a blocking operation is completed.

When that happens, the main loop sends a result to the suspended coroutine.

The coroutine then advances to the next yield, for example, yield from resp.read() in get_flag. The event loop takes charge again. Steps 4, 5, and 6 repeat until the event loop is terminated.

This is similar to the example we looked at in The Taxi Fleet Simulation, where a main loop started several taxi processes in turn. As each taxi process yielded, the main loop scheduled the next event for that taxi (to happen in the future), and proceeded to activate the next taxi in the queue. The taxi simulation is much simpler, and you can easily understand its main loop. But the general flow is the same as in asyncio: a single-threaded program where a main loop activates queued coroutines one by one. Each coroutine advances a few steps, then yields control back to the main loop, which then activates the next coroutine in the queue.

Now let’s review Example 18-5 play by play.

Example 18-5. flags_asyncio.py: asynchronous download script with asyncio and aiohttp

import asyncio import aiohttp from flags import BASE_URL, save_flag, show, main @asyncio.coroutine def get_flag(cc): url = '{}/{cc}/{cc}.gif'.format(BASE_URL, cc=cc.lower()) resp = yield from aiohttp.request('GET', url) image = yield from resp.read() return image @asyncio.coroutine def download_one(cc): image = yield from get_flag(cc) show(cc) save_flag(image, cc.lower() + '.gif') return cc def download_many(cc_list): loop = asyncio.get_event_loop() to_do = [download_one(cc) for cc in sorted(cc_list)] wait_coro = asyncio.wait(to_do) res, _ = loop.run_until_complete(wait_coro) loop.close() return len(res) if __name__ == '__main__': main(download_many)

aiohttp must be installed—it’s not in the standard library.

Reuse some functions from the flags module (Example 17-2).

Coroutines should be decorated with @asyncio.coroutine.

Blocking operations are implemented as coroutines, and your code delegates to them via yield from so they run asynchronously.

Reading the response contents is a separate asynchronous operation.

download_one must also be a coroutine, because it uses yield from.

The only difference from the sequential implementation of download_one are the words yield from in this line; the rest of the function body is exactly as before.

Get a reference to the underlying event-loop implementation.

Build a list of generator objects by calling the download_one function once for each flag to be retrieved.

Despite its name, wait is not a blocking function. It’s a coroutine that completes when all the coroutines passed to it are done (that’s the default behavior of wait; see explanation after this example).

Execute the event loop until wait_coro is done; this is where the script will block while the event loop runs. We ignore the second item returned by run_until_complete. The reason is explained next.

Shut down the event loop.

Note

It would be nice if event loop instances were context managers, so we could use a with block to make sure the loop is closed. However, the situation is complicated by the fact that client code never creates the event loop directly, but gets a reference to it by calling asyncio.get_event_loop(). Sometimes our code does not「own」the event loop, so it would be wrong to close it. For example, when using an external GUI event loop with a package like Quamash, the Qt library is responsible for shutting down the loop when the application quits.

The asyncio.wait(…) coroutine accepts an iterable of futures or coroutines; wait wraps each coroutine in a Task. The end result is that all objects managed by wait become instances of Future, one way or another. Because it is a coroutine function, calling wait(…) returns a coroutine/generator object; this is what the wait_coro variable holds. To drive the coroutine, we pass it to loop.run_until_complete(…).

The loop.run_until_complete function accepts a future or a coroutine. If it gets a coroutine, run_until_complete wraps it into a Task, similar to what wait does. Coroutines, futures, and tasks can all be driven by yield from, and this is what run_until_complete does with the wait_coro object returned by the wait call. When wait_coro runs to completion, it returns a 2-tuple where the first item is the set of completed futures, and the second is the set of those not completed. In Example 18-5, the second set will always be empty—that’s why we explicitly ignore it by assigning to _. But wait accepts two keyword-only arguments that may cause it to return even if some of the futures are not complete: timeout and return_when. See the asyncio.wait documentation for details.

Note that in Example 18-5 I could not reuse the get_flag function from flags.py (Example 17-2) because that uses the requests library, which performs blocking I/O. To leverage asyncio, we must replace every function that hits the network with an asynchronous version that is invoked with yield from, so that control is given back to the event loop. Using yield from in get_flag means that it must be driven as a coroutine.

That’s why I could not reuse the download_one function from flags_threadpool.py (Example 17-3) either. The code in Example 18-5 drives get_flag with yield_from, so download_one is itself also a coroutine. For each request, a download_one coroutine object is created in download_many, and they are all driven by the loop.run_until_complete function, after being wrapped by the asyncio.wait coroutine.

There are a lot of new concepts to grasp in asyncio but the overall logic of Example 18-5 is easy to follow if you employ a trick suggested by Guido van Rossum himself: squint and pretend the yield from keywords are not there. If you do that, you’ll notice that the code is as easy to read as plain old sequential code.

For example, imagine that the body of this coroutine…

@asyncio.coroutine def get_flag(cc): url = '{}/{cc}/{cc}.gif'.format(BASE_URL, cc=cc.lower()) resp = yield from aiohttp.request('GET', url) image = yield from resp.read() return image

…works like the following function, except that it never blocks:

def get_flag(cc): url = '{}/{cc}/{cc}.gif'.format(BASE_URL, cc=cc.lower()) resp = aiohttp.request('GET', url) image = resp.read() return image

Using the yield from foo syntax avoids blocking because the current coroutine is suspended (i.e., the delegating generator where the yield from code is), but the control flow goes back to the event loop, which can drive other coroutines. When the foo future or coroutine is done, it returns a result to the suspended coroutine, resuming it.

At the end of the section Using yield from, I stated two facts about every usage of yield from. Here they are, summarized:

Every arrangement of coroutines chained with yield from must be ultimately driven by a caller that is not a coroutine, which invokes next(…) or .send(…) on the outermost delegating generator, explicitly or implicitly (e.g., in a for loop).

The innermost subgenerator in the chain must be a simple generator that uses just yield—or an iterable object.

When using yield from with the asyncio API, both facts remain true, with the following specifics:

The coroutine chains we write are always driven by passing our outermost delegating generator to an asyncio API call, such as loop.run_until_complete(…).

In other words, when using asyncio our code doesn’t drive a coroutine chain by calling next(…) or .send(…) on it—the asyncio event loop does that.

The coroutine chains we write always end by delegating with yield from to some asyncio coroutine function or coroutine method (e.g., yield from asyncio.sleep(…) in Example 18-2) or coroutines from libraries that implement higher-level protocols (e.g., resp = yield from aiohttp.request('GET', url) in the get_flag coroutine of Example 18-5).

In other words, the innermost subgenerator will be a library function that does the actual I/O, not something we write.

To summarize: as we use asyncio, our asynchronous code consists of coroutines that are delegating generators driven by asyncio itself and that ultimately delegate to asyncio library coroutines—possibly by way of some third-party library such as aiohttp. This arrangement creates pipelines where the asyncio event loop drives—through our coroutines—the library functions that perform the low-level asynchronous I/O.

We are now ready to answer one question raised in Chapter 17:

How can flags_asyncio.py perform 5× faster than flags.py when both are single threaded?

Running Circling Around Blocking Calls

Ryan Dahl, the inventor of Node.js, introduces the philosophy of his project by saying「We’re doing I/O completely wrong.[160]" He defines a blocking function as one that does disk or network I/O, and argues that we can’t treat them as we treat nonblocking functions. To explain why, he presents the numbers in the first two columns of Table 18-1.

Table 18-1. Modern computer latency for reading data from different devices; third column shows proportional times in a scale easier to understand for us slow humans

Device CPU cycles Proportional「human」scale

L1 cache

3

3 seconds

L2 cache

14

14 seconds

RAM

250

250 seconds

disk

41,000,000

1.3 years

network

240,000,000

7.6 years

To make sense of Table 18-1, bear in mind that modern CPUs with GHz clocks run billions of cycles per second. Let’s say that a CPU runs exactly 1 billion cycles per second. That CPU can make 333,333,333 L1 cache reads in one second, or 4 (four!) network reads in the same time. The third column of Table 18-1 puts those numbers in perspective by multiplying the second column by a constant factor. So, in an alternate universe, if one read from L1 cache took 3 seconds, then a network read would take 7.6 years!

There are two ways to prevent blocking calls to halt the progress of the entire application:

Run each blocking operation in a separate thread.

Turn every blocking operation into a nonblocking asynchronous call.

Threads work fine, but the memory overhead for each OS thread—the kind that Python uses—is on the order of megabytes, depending on the OS. We can’t afford one thread per connection if we are handling thousands of connections.

Callbacks are the traditional way to implement asynchronous calls with low memory overhead. They are a low-level concept, similar to the oldest and most primitive concurrency mechanism of all: hardware interrupts. Instead of waiting for a response, we register a function to be called when something happens. In this way, every call we make can be nonblocking. Ryan Dahl advocates callbacks for their simplicity and low overhead.

Of course, we can only make callbacks work because the event loop underlying our asynchronous applications can rely on infrastructure that uses interrupts, threads, polling, background processes, etc. to ensure that multiple concurrent requests make progress and they eventually get done.[161] When the event loop gets a response, it calls back our code. But the single main thread shared by the event loop and our application code is never blocked—if we don’t make mistakes.

When used as coroutines, generators provide an alternative way to do asynchronous programming. From the perspective of the event loop, invoking a callback or calling .send() on a suspended coroutine is pretty much the same. There is a memory overhead for each suspended coroutine, but it’s orders of magnitude smaller than the overhead for each thread. And they avoid the dreaded「callback hell,」which we’ll discuss in From Callbacks to Futures and Coroutines.

Now the five-fold performance advantage of flags_asyncio.py over flags.py should make sense: flags.py spends billions of CPU cycles waiting for each download, one after the other. The CPU is actually doing a lot meanwhile, just not running your program. In contrast, when loop_until_complete is called in the download_many function of flags_asyncio.py, the event loop drives each download_one coroutine to the first yield from, and this in turn drives each get_flag coroutine to the first yield from, calling aiohttp.request(…). None of these calls are blocking, so all requests are started in a fraction of a second.

As the asyncio infrastructure gets the first response back, the event loop sends it to the waiting get_flag coroutine. As get_flag gets a response, it advances to the next yield from, which calls resp.read() and yields control back to the main loop. Other responses arrive in close succession (because they were made almost at the same time). As each get_flag returns, the delegating generator download_flag resumes and saves the image file.

Note

For maximum performance, the save_flag operation should be asynchronous, but asyncio does not provide an asynchronous filesystem API at this time—as Node does. If that becomes a bottleneck in your application, you can use the loop.run_in_executor function to run save_flag in a thread pool. Example 18-9 will show how.

Because the asynchronous operations are interleaved, the total time needed to download many images concurrently is much less than doing it sequentially. When making 600 HTTP requests with asyncio I got all results back more than 70 times faster than with a sequential script.

Now let’s go back to the HTTP client example to see how we can display an animated progress bar and perform proper error handling.

Enhancing the asyncio downloader Script

Recall from Downloads with Progress Display and Error Handling that the flags2 set of examples share the same command-line interface. This includes the flags2_asyncio.py we will analyze in this section. For instance, Example 18-6 shows how to get 100 flags (-al 100) from the ERROR server, using 100 concurrent requests (-m 100).

Example 18-6. Running flags2_asyncio.py

$ python3 flags2_asyncio.py -s ERROR -al 100 -m 100 ERROR site: http://localhost:8003/flags Searching for 100 flags: from AD to LK 100 concurrent connections will be used. -------------------- 73 flags downloaded. 27 errors. Elapsed time: 0.64s

Act Responsibly When Testing Concurrent Clients

Even if the overall download time is not different between the threaded and asyncio HTTP clients, asyncio can send requests faster, so it’s even more likely that the server will suspect a DOS attack. To really exercise these concurrent clients at full speed, set up a local HTTP server for testing, as explained in the README.rst inside the 17-futures/countries/ directory of the Fluent Python code repository.

Now let’s see how flags2_asyncio.py is implemented.

Using asyncio.as_completed

In Example 18-5, I passed a list of coroutines to asyncio.wait, which—when driven by loop.run_until.complete—would return the results of the downloads when all were done. But to update a progress bar we need to get results as they are done. Fortunately, there is an asyncio equivalent of the as_completed generator function we used in the thread pool example with the progress bar (Example 17-14).

Writing a flags2 example to leverage asyncio entails rewriting several functions that the concurrent.future version could reuse. That’s because there’s only one main thread in an asyncio program and we can’t afford to have blocking calls in that thread, as it’s the same thread that runs the event loop. So I had to rewrite get_flag to use yield from for all network access. Now get_flag is a coroutine, so download_one must drive it with yield from, therefore download_one itself becomes a coroutine. Previously, in Example 18-5, download_one was driven by download_many: the calls to download_one were wrapped in an asyncio.wait call and passed to loop.run_until_complete. Now we need finer control for progress reporting and error handling, so I moved most of the logic from download_many into a new downloader_coro coroutine, and use download_many just to set up the event loop and schedule downloader_coro.

Example 18-7 shows the top of the flags2_asyncio.py script where the get_flag and download_one coroutines are defined. Example 18-8 lists the rest of the source, with downloader_coro and download_many.

Example 18-7. flags2_asyncio.py: Top portion of the script; remaining code is in Example 18-8

import asyncio import collections import aiohttp from aiohttp import web import tqdm from flags2_common import main, HTTPStatus, Result, save_flag # default set low to avoid errors from remote site, such as # 503 - Service Temporarily Unavailable DEFAULT_CONCUR_REQ = 5 MAX_CONCUR_REQ = 1000 class FetchError(Exception): def __init__(self, country_code): self.country_code = country_code @asyncio.coroutine def get_flag(base_url, cc): url = '{}/{cc}/{cc}.gif'.format(base_url, cc=cc.lower()) resp = yield from aiohttp.request('GET', url) if resp.status == 200: image = yield from resp.read() return image elif resp.status == 404: raise web.HTTPNotFound() else: raise aiohttp.HttpProcessingError( code=resp.status, message=resp.reason, headers=resp.headers) @asyncio.coroutine def download_one(cc, base_url, semaphore, verbose): try: with (yield from semaphore): image = yield from get_flag(base_url, cc) except web.HTTPNotFound: status = HTTPStatus.not_found msg = 'not found' except Exception as exc: raise FetchError(cc) from exc else: save_flag(image, cc.lower() + '.gif') status = HTTPStatus.ok msg = 'OK' if verbose and msg: print(cc, msg) return Result(status, cc)

This custom exception will be used to wrap other HTTP or network exceptions and carry the country_code for error reporting.

get_flag will either return the bytes of the image downloaded, raise web.HTTPNotFound if the HTTP response status is 404, or raise an aiohttp.HttpProcessingError for other HTTP status codes.

The semaphore argument is an instance of asyncio.Semaphore, a synchronization device that limits the number of concurrent requests.

A semaphore is used as a context manager in a yield from expression so that the system as whole is not blocked: only this coroutine is blocked while the semaphore counter is at the maximum allowed number.

When this with statement exits, the semaphore counter is decremented, unblocking some other coroutine instance that may be waiting for the same semaphore object.

If the flag was not found, just set the status for the Result accordingly.

Any other exception will be reported as a FetchError with the country code and the original exception chained using the raise X from Y syntax introduced in PEP 3134 — Exception Chaining and Embedded Tracebacks.

This function call actually saves the flag image to disk.

In Example 18-7, you can see that the code for get_flag and download_one changed significantly from the sequential version because these functions are now coroutines using yield from to make asynchronous calls.

Network client code of the sort we are studying should always use some throttling mechanism to avoid pounding the server with too many concurrent requests—the overall performance of the system may degrade if the server is overloaded. In flags2_threadpool.py (Example 17-14), the throttling was done by instantiating the ThreadPoolExecutor with the required max_workers argument set to concur_req in the download_many function, so only concur_req threads are started in the pool. In flags2_asyncio.py, I used an asyncio.Semaphore, which is created by the downloader_coro function (shown next, in Example 18-8) and is passed as the semaphore argument to download_one in Example 18-7.[162]

A Semaphore is an object that holds an internal counter that is decremented whenever we call the .acquire() coroutine method on it, and incremented when we call the .release() coroutine method. The initial value of the counter is set when the Semaphore is instantiated, as in this line of downloader_coro:

semaphore = asyncio.Semaphore(concur_req)

Calling .acquire() does not block when the counter is greater than zero, but if the counter is zero, .acquire() will block the calling coroutine until some other coroutine calls .release() on the same Semaphore, thus incrementing the counter. In Example 18-7, I don’t call .acquire() or .release(), but use the semaphore as a context manager in this block of code inside download_one:

with (yield from semaphore): image = yield from get_flag(base_url, cc)

That snippet guarantees that no more than concur_req instances of get_flags coroutines will be started at any time.

Now let’s take a look at the rest of the script in Example 18-8. Note that most functionality of the old download_many function is now in a coroutine, downloader_coro. This was necessary because we must use yield from to retrieve the results of the futures yielded by asyncio.as_completed, therefore as_completed must be invoked in a coroutine. However, I couldn’t simply turn download_many into a coroutine, because I must pass it to the main function from flags2_common in the last line of the script, and that main function is not expecting a coroutine, just a plain function. Therefore I created downloader_coro to run the as_completed loop, and now download_many simply sets up the event loop and schedules downloader_coro by passing it to loop.run_until_complete.

Example 18-8. flags2_asyncio.py: Script continued from Example 18-7

@asyncio.coroutine def downloader_coro(cc_list, base_url, verbose, concur_req): counter = collections.Counter() semaphore = asyncio.Semaphore(concur_req) to_do = [download_one(cc, base_url, semaphore, verbose) for cc in sorted(cc_list)] to_do_iter = asyncio.as_completed(to_do) if not verbose: to_do_iter = tqdm.tqdm(to_do_iter, total=len(cc_list)) for future in to_do_iter: try: res = yield from future except FetchError as exc: country_code = exc.country_code try: error_msg = exc.__cause__.args[0] except IndexError: error_msg = exc.__cause__.__class__.__name__ if verbose and error_msg: msg = '*** Error for {}: {}' print(msg.format(country_code, error_msg)) status = HTTPStatus.error else: status = res.status counter[status] += 1 return counter def download_many(cc_list, base_url, verbose, concur_req): loop = asyncio.get_event_loop() coro = downloader_coro(cc_list, base_url, verbose, concur_req) counts = loop.run_until_complete(coro) loop.close() return counts if __name__ == '__main__': main(download_many, DEFAULT_CONCUR_REQ, MAX_CONCUR_REQ)

The coroutine receives the same arguments as download_many, but it cannot be invoked directly from main precisely because it’s a coroutine function and not a plain function like download_many.

Create an asyncio.Semaphore that will allow up to concur_req active coroutines among those using this semaphore.

Create a list of coroutine objects, one per call to the download_one coroutine.

Get an iterator that will return futures as they are done.

Wrap the iterator in the tqdm function to display progress.

Iterate over the completed futures; this loop is very similar to the one in download_many in Example 17-14; most changes have to do with exception handling because of differences in the HTTP libraries (requests versus aiohttp).

The easiest way to retrieve the result of an asyncio.Future is using yield from instead of calling future.result().

Every exception in download_one is wrapped in a FetchError with the original exception chained.

Get the country code where the error occurred from the FetchError exception.

Try to retrieve the error message from the original exception (__cause__).

If the error message cannot be found in the original exception, use the name of the chained exception class as the error message.

Tally outcomes.

Return the counter, as done in the other scripts.

download_many simply instantiates the coroutine and passes it to the event loop with run_until_complete.

When all work is done, shut down the event loop and return counts.

In Example 18-8, we could not use the mapping of futures to country codes we saw in Example 17-14 because the futures returned by asyncio.as_completed are not necessarily the same futures we pass into the as_completed call. Internally, the asyncio machinery replaces the future objects we provide with others that will, in the end, produce the same results.[163]

Because I could not use the futures as keys to retrieve the country code from a dict in case of failure, I implemented the custom FetchError exception (shown in Example 18-7). FetchError wraps a network exception and holds the country code associated with it, so the country code can be reported with the error in verbose mode. If there is no error, the country code is available as the result of the yield from future expression at the top of the for loop.

This wraps up the discussion of an asyncio example functionally equivalent to the flags2_threadpool.py we saw earlier. Next, we’ll implement enhancements to flags2_asyncio.py that will let us explore asyncio further.

While discussing Example 18-7, I noted that save_flag performs disk I/O and should be executed asynchronously. The following section shows how.

Using an Executor to Avoid Blocking the Event Loop

In the Python community, we tend to overlook the fact that local filesystem access is blocking, rationalizing that it doesn’t suffer from the higher latency of network access (which is also dangerously unpredictable). In contrast, Node.js programmers are constantly reminded that all filesystem functions are blocking because their signatures require a callback. Recall from Table 18-1 that blocking for disk I/O wastes millions of CPU cycles, and this may have a significant impact on the performance of the application.

In Example 18-7, the blocking function is save_flag. In the threaded version of the script (Example 17-14), save_flag blocks the thread that’s running the download_one function, but that’s only one of several worker threads. Behind the scenes, the blocking I/O call releases the GIL, so another thread can proceed. But in flags2_asyncio.py, save_flag blocks the single thread our code shares with the asyncio event loop, therefore the whole application freezes while the file is being saved. The solution to this problem is the run_in_executor method of the event loop object.

Behind the scenes, the asyncio event loop has a thread pool executor, and you can send callables to be executed by it with run_in_executor. To use this feature in our example, only a few lines need to change in the download_one coroutine, as shown in Example 18-9.

Example 18-9. flags2_asyncio_executor.py: Using the default thread pool executor to run save_flag

@asyncio.coroutine def download_one(cc, base_url, semaphore, verbose): try: with (yield from semaphore): image = yield from get_flag(base_url, cc) except web.HTTPNotFound: status = HTTPStatus.not_found msg = 'not found' except Exception as exc: raise FetchError(cc) from exc else: loop = asyncio.get_event_loop() loop.run_in_executor(None, save_flag, image, cc.lower() + '.gif') status = HTTPStatus.ok msg = 'OK' if verbose and msg: print(cc, msg) return Result(status, cc)

Get a reference to the event loop object.

The first argument to run_in_executor is an executor instance; if None, the default thread pool executor of the event loop is used.

The remaining arguments are the callable and its positional arguments.

Note

When I tested Example 18-9, there was no noticeable change in performance for using run_in_executor to save the image files because they are not large (13 KB each, on average). But you’ll see an effect if you edit the save_flag function in flags2_common.py to save 10 times as many bytes on each file—just by coding fp.write(img*10) instead of fp.write(img). With an average download size of 130 KB, the advantage of using run_in_executor becomes clear. If you’re downloading megapixel images, the speedup will be significant.

The advantage of coroutines over callbacks becomes evident when we need to coordinate asynchronous requests, and not just make completely independent requests. The next section explains the problem and the solution.

From Callbacks to Futures and Coroutines

Event-oriented programming with coroutines requires some effort to master, so it’s good to be clear on how it improves on the classic callback style. This is the theme of this section.

Anyone with some experience in callback-style event-oriented programming knows the term「callback hell」: the nesting of callbacks when one operation depends on the result of the previous operation. If you have three asynchronous calls that must happen in succession, you need to code callbacks nested three levels deep. Example 18-10 is an example in JavaScript.

Example 18-10. Callback hell in JavaScript: nested anonymous functions, a.k.a. Pyramid of Doom

api_call1(request1, function (response1) { // stage 1 var request2 = step1(response1); api_call2(request2, function (response2) { // stage 2 var request3 = step2(response2); api_call3(request3, function (response3) { // stage 3 step3(response3); }); }); });

In Example 18-10, api_call1, api_call2, and api_call3 are library functions your code uses to retrieve results asynchronously—perhaps api_call1 goes to a database and api_call2 gets data from a web service, for example. Each of these take a callback function, which in JavaScript are often anonymous functions (they are named stage1, stage2, and stage3 in the following Python example). The step1, step2, and step3 here represent regular functions of your application that process the responses received by the callbacks.

Example 18-11 shows what callback hell looks like in Python.

Example 18-11. Callback hell in Python: chained callbacks

def stage1(response1): request2 = step1(response1) api_call2(request2, stage2) def stage2(response2): request3 = step2(response2) api_call3(request3, stage3) def stage3(response3): step3(response3) api_call1(request1, stage1)

Although the code in Example 18-11 is arranged very differently from Example 18-10, they do exactly the same thing, and the JavaScript example could be written using the same arrangement (but the Python code can’t be written in the JavaScript style because of the syntactic limitations of lambda).

Code organized as Example 18-10 or Example 18-11 is hard to read, but it’s even harder to write: each function does part of the job, sets up the next callback, and returns, to let the event loop proceed. At this point, all local context is lost. When the next callback (e.g., stage2) is executed, you don’t have the value of request2 any more. If you need it, you must rely on closures or external data structures to store it between the different stages of the processing.

That’s where coroutines really help. Within a coroutine, to perform three asynchronous actions in succession, you yield three times to let the event loop continue running. When a result is ready, the coroutine is activated with a .send() call. From the perspective of the event loop, that’s similar to invoking a callback. But for the users of a coroutine-style asynchronous API, the situation is vastly improved: the entire sequence of three operations is in one function body, like plain old sequential code with local variables to retain the context of the overall task under way. See Example 18-12.

Example 18-12. Coroutines and yield from enable asynchronous programming without callbacks

@asyncio.coroutine def three_stages(request1): response1 = yield from api_call1(request1) # stage 1 request2 = step1(response1) response2 = yield from api_call2(request2) # stage 2 request3 = step2(response2) response3 = yield from api_call3(request3) # stage 3 step3(response3) loop.create_task(three_stages(request1)) # must explicitly schedule execution

Example 18-12 is much easier to follow the previous JavaScript and Python examples: the three stages of the operation appear one after the other inside the same function. This makes it trivial to use previous results in follow-up processing. It also provides a context for error reporting through exceptions.

Suppose in Example 18-11 the processing of the call api_call2(request2, stage2) raises an I/O exception (that’s the last line of the stage1 function). The exception cannot be caught in stage1 because api_call2 is an asynchronous call: it returns immediately, before any I/O is performed. In callback-based APIs, this is solved by registering two callbacks for each asynchronous call: one for handling the result of successful operations, another for handling errors. Work conditions in callback hell quickly deteriorate when error handling is involved.

In contrast, in Example 18-12, all the asynchronous calls for this three-stage operation are inside the same function, three_stages, and if the asynchronous calls api_call1, api_call2, and api_call3 raise exceptions we can handle them by putting the respective yield from lines inside try/except blocks.

This is a much better place than callback hell, but I wouldn’t call it coroutine heaven because there is a price to pay. Instead of regular functions, you must use coroutines and get used to yield from, so that’s the first obstacle. Once you write yield from in a function, it’s now a coroutine and you can’t simply call it, like we called api_call1(request1, stage1) in Example 18-11 to start the callback chain. You must explicitly schedule the execution of the coroutine with the event loop, or activate it using yield from in another coroutine that is scheduled for execution. Without the call loop.create_task(three_stages(request1)) in the last line, nothing would happen in Example 18-12.

The next example puts this theory into practice.

Doing Multiple Requests for Each Download

Suppose you want to save each country flag with the name of the country and the country code, instead of just the country code. Now you need to make two HTTP requests per flag: one to get the flag image itself, the other to get the metadata.json file in the same directory as the image: that’s where the name of the country is recorded.

Articulating multiple requests in the same task is easy in the threaded script: just make one request then the other, blocking the thread twice, and keeping both pieces of data (country code and name) in local variables, ready to use when saving the files. If you need to do the same in an asynchronous script with callbacks, you start to smell the sulfur of callback hell: the country code and name will need to be passed around in a closure or held somewhere until you can save the file because each callback runs in a different local context. Coroutines and yield from provide relief from that. The solution is not as simple as with threads, but more manageable than chained or nested callbacks.

Example 18-13 shows code from the third variation of the asyncio flag downloading script, using the country name to save each flag. The download_many and downloader_coro are unchanged from flags2_asyncio.py (Examples 18-7 and 18-8). The changes are:

download_one

This coroutine now uses yield from to delegate to get_flag and the new get_country coroutine.

get_flag

Most code from this coroutine was moved to a new http_get coroutine so it can also be used by get_country.

get_country

This coroutine fetches the metadata.json file for the country code, and gets the name of the country from it.

http_get

Common code for getting a file from the Web.

Example 18-13. flags3_asyncio.py: more coroutine delegation to perform two requests per flag

@asyncio.coroutine def http_get(url): res = yield from aiohttp.request('GET', url) if res.status == 200: ctype = res.headers.get('Content-type', '').lower() if 'json' in ctype or url.endswith('json'): data = yield from res.json() else: data = yield from res.read() return data elif res.status == 404: raise web.HTTPNotFound() else: raise aiohttp.errors.HttpProcessingError( code=res.status, message=res.reason, headers=res.headers) @asyncio.coroutine def get_country(base_url, cc): url = '{}/{cc}/metadata.json'.format(base_url, cc=cc.lower()) metadata = yield from http_get(url) return metadata['country'] @asyncio.coroutine def get_flag(base_url, cc): url = '{}/{cc}/{cc}.gif'.format(base_url, cc=cc.lower()) return (yield from http_get(url)) @asyncio.coroutine def download_one(cc, base_url, semaphore, verbose): try: with (yield from semaphore): image = yield from get_flag(base_url, cc) with (yield from semaphore): country = yield from get_country(base_url, cc) except web.HTTPNotFound: status = HTTPStatus.not_found msg = 'not found' except Exception as exc: raise FetchError(cc) from exc else: country = country.replace(' ', '_') filename = '{}-{}.gif'.format(country, cc) loop = asyncio.get_event_loop() loop.run_in_executor(None, save_flag, image, filename) status = HTTPStatus.ok msg = 'OK' if verbose and msg: print(cc, msg) return Result(status, cc)

If the content type has 'json' in it or the url ends with .json, use the response .json() method to parse it and return a Python data structure—in this case, a dict.

Otherwise, use .read() to fetch the bytes as they are.

metadata will receive a Python dict built from the JSON contents.

The outer parentheses here are required because the Python parser gets confused and produces a syntax error when it sees the keywords return yield from lined up like that.

I put the calls to get_flag and get_country in separate with blocks controlled by the semaphore because I want to keep it acquired for the shortest possible time.

The yield from syntax appears nine times in Example 18-13. By now you should be getting the hang of how this construct is used to delegate from one coroutine to another without blocking the event loop.

The challenge is to know when you have to use yield from and when you can’t use it. The answer in principle is easy, you yield from coroutines and asyncio.Future instances—including tasks. But some APIs are tricky, mixing coroutines and plain functions in seemingly arbitrary ways, like the StreamWriter class we’ll use in one of the servers in the next section.

Example 18-13 wraps up the flags2 set of examples. I encourage you to play with them to develop an intuition of how concurrent HTTP clients perform. Use the -a, -e, and -l command-line options to control the number of downloads, and the -m option to set the number of concurrent downloads. Run tests against the LOCAL, REMOTE, DELAY, and ERROR servers. Discover the optimum number of concurrent downloads to maximize throughput against each server. Tweak the settings of the vaurien_error_delay.sh script to add or remove errors and delays.

We’ll now go from client scripts to writing servers with asyncio.

Writing asyncio Servers

The classic toy example of a TCP server is an echo server. We’ll build slightly more interesting toys: Unicode character finders, first using plain TCP, then using HTTP. These servers will allow clients to query for Unicode characters based on words in their canonical names, using the unicodedata module we discussed in The Unicode Database. A Telnet session with the TCP character finder server, searching for chess pieces and characters with the word「sun」is shown in Figure 18-2.

Figure 18-2. A Telnet session with the tcp_charfinder.py server: querying for「chess black」and「sun」.

Now, on to the implementations.

An asyncio TCP Server

Most of the logic in these examples is in the charfinder.py module, which has nothing concurrent about it. You can use charfinder.py as a command-line character finder, but more importantly, it was designed to provide content for our asyncio servers. The code for charfinder.py is in the Fluent Python code repository.

The charfinder module indexes each word that appears in character names in the Unicode database bundled with Python, and creates an inverted index stored in a dict. For example, the inverted index entry for the key 'SUN' contains a set with the 10 Unicode characters that have that word in their names. The inverted index is saved in a local charfinder_index.pickle file. If multiple words appear in the query, charfinder computes the intersection of the sets retrieved from the index.

We’ll now focus on the tcp_charfinder.py script that is answering the queries in Figure 18-2. Because I have a lot to say about this code, I’ve split it into two parts: Example 18-14 and Example 18-15.

Example 18-14. tcp_charfinder.py: a simple TCP server using asyncio.start_server; code for this module continues in Example 18-15

import sys import asyncio from charfinder import UnicodeNameIndex CRLF = b'\r\n' PROMPT = b'?> ' index = UnicodeNameIndex() @asyncio.coroutine def handle_queries(reader, writer): while True: writer.write(PROMPT) # can't yield from! yield from writer.drain() # must yield from! data = yield from reader.readline() try: query = data.decode().strip() except UnicodeDecodeError: query = '\x00' client = writer.get_extra_info('peername') print('Received from {}: {!r}'.format(client, query)) if query: if ord(query[:1]) < 32: break lines = list(index.find_description_strs(query)) if lines: writer.writelines(line.encode() + CRLF for line in lines) writer.write(index.status(query, len(lines)).encode() + CRLF) yield from writer.drain() print('Sent {} results'.format(len(lines))) print('Close the client socket') writer.close()

UnicodeNameIndex is the class that builds the index of names and provides querying methods.

When instantiated, UnicodeNameIndex uses charfinder_index.pickle, if available, or builds it, so the first run may take a few seconds longer to start.[164]

This is the coroutine we need to pass to asyncio_startserver; the arguments received are an asyncio.StreamReader and an asyncio.StreamWriter.

This loop handles a session that lasts until any control character is received from the client.

The StreamWriter.write method is not a coroutine, just a plain function; this line sends the ?> prompt.

StreamWriter.drain flushes the writer buffer; it is a coroutine, so it must be called with yield from.

StreamWriter.readline is a coroutine; it returns bytes.

A UnicodeDecodeError may happen when the Telnet client sends control characters; if that happens, we pretend a null character was sent, for simplicity.

This returns the remote address to which the socket is connected.

Log the query to the server console.

Exit the loop if a control or null character was received.

This returns a generator that yields strings with the Unicode codepoint, the actual character and its name (e.g., U+0039\t9\tDIGIT NINE); for simplicity, I build a list from it.

Send the lines converted to bytes using the default UTF-8 encoding, appending a carriage return and a line feed to each; note that the argument is a generator expression.

Write a status line such as 627 matches for 'digit'.

Flush the output buffer.

Log the response to the server console.

Log the end of the session to the server console.

Close the StreamWriter.

The handle_queries coroutine has a plural name because it starts an interactive session and handles multiple queries from each client.

Note that all I/O in Example 18-14 is in bytes. We need to decode the strings received from the network, and encode strings sent out. In Python 3, the default encoding is UTF-8, and that’s what we are using implicitly.

One caveat is that some of the I/O methods are coroutines and must be driven with yield from, while others are simple functions. For example, StreamWriter.write is a plain function, on the assumption that most of the time it does not block because it writes to a buffer. On the other hand, StreamWriter.drain, which flushes the buffer and performs the actual I/O is a coroutine, as is Streamreader.readline. While I was writing this book, a major improvement to the asyncio API docs was the clear labeling of coroutines as such.

Example 18-15 lists the main function for the module started in Example 18-14.

Example 18-15. tcp_charfinder.py (continued from Example 18-14): the main function sets up and tears down the event loop and the socket server

def main(address='127.0.0.1', port=2323): port = int(port) loop = asyncio.get_event_loop() server_coro = asyncio.start_server(handle_queries, address, port, loop=loop) server = loop.run_until_complete(server_coro) host = server.sockets[0].getsockname() print('Serving on {}. Hit CTRL-C to stop.'.format(host)) try: loop.run_forever() except KeyboardInterrupt: # CTRL+C pressed pass print('Server shutting down.') server.close() loop.run_until_complete(server.wait_closed()) loop.close() if __name__ == '__main__': main(*sys.argv[1:])

The main function can be called with no arguments.

When completed, the coroutine object returned by asyncio.start_server returns an instance of asyncio.Server, a TCP socket server.

Drive server_coro to bring up the server.

Get address and port of the first socket of the server and…

…display it on the server console. This is the first output generated by this script on the server console.

Run the event loop; this is where main will block until killed when CTRL-C is pressed on the server console.

Close the server.

server.wait_closed() returns a future; use loop.run_until_complete to let the future do its job.

Terminate the event loop.

This is a shortcut for handling optional command-line arguments: explode sys.argv[1:] and pass it to a main function with suitable default arguments.

Note how run_until_complete accepts either a coroutine (the result of start_server) or a Future (the result of server.wait_closed). If run_until_complete gets a coroutine as argument, it wraps the coroutine in a Task.

You may find it easier to understand how control flows in tcp_charfinder.py if you take a close look at the output it generates on the server console, listed in Example 18-16.

Example 18-16. tcp_charfinder.py: this is the server side of the session depicted in Figure 18-2

$ python3 tcp_charfinder.py Serving on ('127.0.0.1', 2323). Hit CTRL-C to stop. Received from ('127.0.0.1', 62910): 'chess black' Sent 6 results Received from ('127.0.0.1', 62910): 'sun' Sent 10 results Received from ('127.0.0.1', 62910): '\x00' Close the client socket

This is output by main.

First iteration of the while loop in handle_queries.

Second iteration of the while loop.

The user hit CTRL-C; the server receives a control character and closes the session.

The client socket is closed but the server is still running, ready to service another client.

Note how main almost immediately displays the Serving on... message and blocks in the loop.run_forever() call. At that point, control flows into the event loop and stays there, occasionally coming back to the handle_queries coroutine, which yields control back to the event loop whenever it needs to wait for the network as it sends or receives data. While the event loop is alive, a new instance of the handle_queries coroutine will be started for each client that connects to the server. In this way, multiple clients can be handled concurrently by this simple server. This continues until a KeyboardInterrupt occurs or the process is killed by the OS.

The tcp_charfinder.py code leverages the high-level asyncio Streams API that provides a ready-to-use server so you only need to implement a handler function, which can be a plain callback or a coroutine. There is also a lower-level Transports and Protocols API, inspired by the transport and protocols abstractions in the Twisted framework. Refer to the asyncio Transports and Protocols documentation for more information, including a TCP echo server implemented with that lower-level API.

The next section presents an HTTP character finder server.

An aiohttp Web Server

The aiohttp library we used for the asyncio flags examples also supports server-side HTTP, so that’s what I used to implement the http_charfinder.py script. Figure 18-3 shows the simple web interface of the server, displaying the result of a search for a「cat face」emoji.

Figure 18-3. Browser window displaying search results for「cat face」on the http_charfinder.py server

Warning

Some browsers are better than others at displaying Unicode. The screenshot in Figure 18-3 was captured with Firefox on OS X, and I got the same result with Safari. But up-to-date Chrome and Opera browsers on the same machine did not display emoji characters like the cat faces. Other search results (e.g.,「chess」) looked fine, so it’s likely a font issue on Chrome and Opera on OSX.

We’ll start by analyzing the most interesting part of http_charfinder.py: the bottom half where the event loop and the HTTP server is set up and torn down. See Example 18-17.

Example 18-17. http_charfinder.py: the main and init functions

@asyncio.coroutine def init(loop, address, port): app = web.Application(loop=loop) app.router.add_route('GET', '/', home) handler = app.make_handler() server = yield from loop.create_server(handler, address, port) return server.sockets[0].getsockname() def main(address="127.0.0.1", port=8888): port = int(port) loop = asyncio.get_event_loop() host = loop.run_until_complete(init(loop, address, port)) print('Serving on {}. Hit CTRL-C to stop.'.format(host)) try: loop.run_forever() except KeyboardInterrupt: # CTRL+C pressed pass print('Server shutting down.') loop.close() if __name__ == '__main__': main(*sys.argv[1:])

The init coroutine yields a server for the event loop to drive.

The aiohttp.web.Application class represents a web application…

…with routes mapping URL patterns to handler functions; here GET / is routed to the home function (see Example 18-18).

The app.make_handler method returns an aiohttp.web.RequestHandler instance to handle HTTP requests according to the routes set up in the app object.

create_server brings up the server, using handler as the protocol handler and binding it to address and port.

Return the address and port of the first server socket.

Run init to start the server and get its address and port.

Run the event loop; main will block here while the event loop is in control.

Close the event loop.

As you get acquainted with the asyncio API, it’s interesting to contrast how the servers are set up in Example 18-17 and in the TCP example (Example 18-15) shown earlier.

In the earlier TCP example, the server was created and scheduled to run in the main function with these two lines:

server_coro = asyncio.start_server(handle_queries, address, port, loop=loop) server = loop.run_until_complete(server_coro)

In the HTTP example, the init function creates the server like this:

server = yield from loop.create_server(handler, address, port)

But init itself is a coroutine, and what makes it run is the main function, with this line:

host = loop.run_until_complete(init(loop, address, port))

Both asyncio.start_server and loop.create_server are coroutines that return asyncio.Server objects. In order to start up a server and return a reference to it, each of these coroutines must be driven to completion. In the TCP example, that was done by calling loop.run_until_complete(server_coro), where server_coro was the result of asyncio.start_server. In the HTTP example, create_server is invoked on a yield_from expression inside the init coroutine, which is in turn driven by the main function when it calls loop.run_until_complete(init(...)).

I mention this to emphasize this essential fact we’ve discussed before: a coroutine only does anything when driven, and to drive an asyncio.coroutine you either use yield from or pass it to one of several asyncio functions that take coroutine or future arguments, such as run_until_complete.

Example 18-18 shows the home function, which is configured to handle the / (root) URL in our HTTP server.

Example 18-18. http_charfinder.py: the home function

def home(request): query = request.GET.get('query', '').strip() print('Query: {!r}'.format(query)) if query: descriptions = list(index.find_descriptions(query)) res = '\n'.join(ROW_TPL.format(**vars(descr)) for descr in descriptions) msg = index.status(query, len(descriptions)) else: descriptions = [] res = '' msg = 'Enter words describing characters.' html = template.format(query=query, result=res, message=msg) print('Sending {} results'.format(len(descriptions))) return web.Response(content_type=CONTENT_TYPE, text=html)

A route handler receives an aiohttp.web.Request instance.

Get the query string stripped of leading and trailing blanks.

Log query to server console.

If there was a query, bind res to HTML table rows rendered from result of the query to the index, and msg to a status message.

Render the HTML page.

Log response to server console.

Build Response and return it.

Note that home is not a coroutine, and does not need to be if there are no yield from expressions in it. The aiohttp documentation for the add_route method states that the handler「is converted to coroutine internally when it is a regular function.」

There is a downside to the simplicity of the home function in Example 18-18. The fact that it’s a plain function and not a coroutine is a symptom of a larger issue: the need to rethink how we code web applications to achieve high concurrency. Let’s consider this matter.

Smarter Clients for Better Concurrency

The home function in Example 18-18 looks very much like a view function in Django or Flask. There is nothing asynchronous about its implementation: it gets a request, fetches data from a database, and builds a response by rendering a full HTML page. In this example, the「database」is the UnicodeNameIndex object, which is in memory. But accessing a real database should be done asynchronously, otherwise you’re blocking the event loop while waiting for database results. For example, the aiopg package provides an asynchronous PostgreSQL driver compatible with asyncio; it lets you use yield from to send queries and fetch results, so your view function can behave as a proper coroutine.

Besides avoiding blocking calls, highly concurrent systems must split large chunks of work into smaller pieces to stay responsive. The http_charfinder.py server illustrates this point: if you search for「cjk」you’ll get back 75,821 Chinese, Japanese, and Korean ideographs.[165] In this case, the home function will return a 5.3 MB HTML document, featuring a table with 75,821 rows.

On my machine, it takes 2s to fetch the response to the「cjk」query, using the curl command-line HTTP client from a local http_charfinder.py server. A browser takes even longer to actually layout the page with such a huge table. Of course, most queries return much smaller responses: a query for「braille」returns 256 rows in a 19 KB page and takes 0.017s on my machine. But if the server spends 2s serving a single「cjk」query, all the other clients will be waiting for at least 2s, and that is not acceptable.

The way to avoid the long response problem is to implement pagination: return results with at most, say, 200 rows, and have the user click or scroll the page to fetch more. If you look up the charfinder.py module in the Fluent Python code repository, you’ll see that the UnicodeNameIndex.find_descriptions method takes optional start and stop arguments: they are offsets to support pagination. So you could return the first 200 results, then use AJAX or even WebSockets to send the next batch when—and if—the user wants to see it.

Most of the necessary coding for sending results in batches would be on the browser. This explains why Google and all large-scale Internet properties rely on lots of client-side coding to build their services: smart asynchronous clients make better use of server resources.

Although smart clients can help even old-style Django applications, to really serve them well we need frameworks that support asynchronous programming all the way: from the handling of HTTP requests and responses, to the database access. This is especially true if you want to implement real-time services such as games and media streaming with WebSockets.[166]

Enhancing http_charfinder.py to support progressive download is left as an exercise to the reader. Bonus points if you implement「infinite scroll,」like Twitter does. With this challenge, I wrap up our coverage of concurrent programming with asyncio.

Chapter Summary

This chapter introduced a whole new way of coding concurrency in Python, leveraging yield from, coroutines, futures, and the asyncio event loop. The first simple examples, the spinner scripts, were designed to demonstrate a side-by-side comparison of the threading and the asyncio approaches to concurrency.

We then discussed the specifics of asyncio.Future, focusing on its support for yield from, and its relationship with coroutines and asyncio.Task. Next, we analyzed the asyncio-based flag download script.

We then reflected on Ryan Dahl’s numbers for I/O latency and the effect of blocking calls. To keep a program alive despite the inevitable blocking functions, there are two solutions: using threads or asynchronous calls—the latter being implemented as callbacks or coroutines.

In practice, asynchronous libraries depend on lower-level threads to work—down to kernel-level threads—but the user of the library doesn’t create threads and doesn’t need to be aware of their use in the infrastructure. At the application level, we just make sure none of our code is blocking, and the event loop takes care of the concurrency under the hood. Avoiding the overhead of user-level threads is the main reason why asynchronous systems can manage more concurrent connections than multithreaded systems.

Resuming the flag downloading examples, adding a progress bar and proper error handling required significant refactoring, particularly with the switch from asyncio.wait to asyncio.as_completed, which forced us to move most of the functionality of download_many to a new downloader_coro coroutine, so we could use yield from to get the results from the futures produced by asyncio.as_completed, one by one.

We then saw how to delegate blocking jobs—such as saving a file—to a thread pool using the loop.run_in_executor method.

This was followed by a discussion of how coroutines solve the main problems of callbacks: loss of context when carrying out multistep asynchronous tasks, and lack of a proper context for error handling.

The next example—fetching the country names along with the flag images—demonstrated how the combination of coroutines and yield from avoids the so-called callback hell. A multistep procedure making asynchronous calls with yield from looks like simple sequential code, if you pay no attention to the yield from keywords.

The final examples in the chapter were asyncio TCP and HTTP servers that allow searching for Unicode characters by name. Analysis of the HTTP server ended with a discussion on the importance of client-side JavaScript to support higher concurrency on the server side, by enabling the client to make smaller requests on demand, instead of downloading large HTML pages.

Further Reading

Nick Coghlan, a Python core developer, made the following comment on the draft of PEP-3156 — Asynchronous IO Support Rebooted: the「asyncio」Module in January 2013:

Somewhere early in the PEP, there may need to be a concise description of the two APIs for waiting for an asynchronous Future:

f.add_done_callback(…)

yield from f in a coroutine (resumes the coroutine when the future completes, with either the result or exception as appropriate)

At the moment, these are buried in amongst much larger APIs, yet they’re key to understanding the way everything above the core event loop layer interacts.[167]

Guido van Rossum, the author of PEP-3156, did not heed Coghlan’s advice. Starting with PEP-3156, the asyncio documentation is very detailed but not user friendly. The nine .rst files that make up the asyncio package docs total 128 KB—that’s roughly 71 pages. In the standard library, only the「Built-in Types」chapter is bigger, and it covers the API for the numeric types, sequence types, generators, mappings, sets, bool, context managers, etc.

Most pages in the asyncio manual focus on concepts and the API. There are useful diagrams and examples scattered all over it, but one section that is very practical is「18.5.11. Develop with asyncio,」which presents essential usage patterns. The asyncio docs need more content explaining how asyncio should be used.

Because it’s very new, asyncio lacks coverage in print. Jan Palach’s Parallel Programming with Python (Packt, 2014) is the only book I found that has a chapter about asyncio, but it’s a short chapter.

There are, however, excellent presentations about asyncio. The best I found is Brett Slatkin’s「Fan-In and Fan-Out: The Crucial Components of Concurrency,」subtitled「Why do we need Tulip? (a.k.a., PEP 3156—asyncio),」which he presented at PyCon 2014 in Montréal (video). In 30 minutes, Slatkin shows a simple web crawler example, highlighting how asyncio is intended to be used. Guido van Rossum is in the audience and mentions that he also wrote a web crawler as a motivating example for asyncio; Guido’s code does not depend on aiohttp—it uses only the standard library. Slatkin also wrote the insightful post「Python’s asyncio Is for Composition, Not Raw Performance.」

Other must-see asyncio talks are by Guido van Rossum himself: the PyCon US 2013 keynote, and talks he gave at LinkedIn and Twitter University. Also recommended are Saúl Ibarra Corretgé’s「A Deep Dive into PEP-3156 and the New asyncio Module」(slides, video).

Dino Viehland showed how asyncio can be integrated with the Tkinter event loop in his「Using futures for async GUI programming in Python 3.3」talk at PyCon US 2013. Viehland shows how easy it is to implement the essential parts of the asyncio.AbstractEventLoop interface on top of another event loop. His code was written with Tulip, prior to the addition of asyncio to the standard library; I adapted it to work with the Python 3.4 release of asyncio. My updated refactoring is on GitHub.

Victor Stinner—an asyncio core contributor and author of the Trollius backport—regularly updates a list of relevant links: The new Python asyncio module aka「tulip」. Other collections of asyncio resources are Asyncio.org and aio-libs on Github, where you’ll find asynchronous drivers for PostgreSQL, MySQL, and several NoSQL databases. I haven’t tested these drivers, but the projects seem very active as I write this.

Web services are going to be an important use case for asyncio. Your code will likely depend on the aiohttp library led by Andrew Svetlov. You’ll also want to set up an environment to test your error handling code, and the Vaurien「chaos TCP proxy」designed by Alexis Métaireau and Tarek Ziadé is invaluable for that. Vaurien was created for the Mozilla Services project and lets you introduce delays and random errors into the TCP traffic between your program and backend servers such as databases and web services providers.

Soapbox

The One Loop

For a long time, asynchronous programming has been the approach favored by most Pythonistas for network applications, but there was always the dilemma of picking one of the mutually incompatible libraries. Ryan Dahl cites Twisted as a source of inspiration for Node.js, and Tornado championed the use of coroutines for event-oriented programming in Python.

In the JavaScript world, there is some debate between advocates of simple callbacks and proponents of various competing higher-level abstractions. Early versions the Node.js API used Promises—similar to our Futures—but Ryan Dahl decided to standardize on callbacks only. James Coglan argues this was Node’s biggest missed opportunity.

In Python, the debate is over: the addition of asyncio to the standard library establishes coroutines and futures as the Pythonic way of writing asynchronous code. Furthermore, the asyncio package defines standard interfaces for asynchronous futures and the event loop, providing reference implementations for them.

The Zen of Python applies perfectly:

There should be one—and preferably only one—obvious way to do it.

Although that way may not be obvious at first unless you’re Dutch.

Maybe it takes a Dutch passport to find yield from obvious. It was not obvious at first for this Brazilian, but after a while I got the hang of it.

More importantly, asyncio was designed so that its event loop can be replaced by an external package. That’s why the asyncio.get_event_loop and set_event_loop functions exist; they are part of an abstract Event Loop Policy API.

Tornado already has an AsyncIOMainLoop class that implements the asyncio.AbstractEventLoop interface, so you can run asynchronous code using both libraries on the same event loop. There is also the intriguing Quamash project that integrates asyncio to the Qt event loop for developing GUI applications with PyQt or PySide. These are just two of a growing number of interoperable event-oriented packages made possible by asyncio.

Smarter HTTP clients such as single-page web applications (like Gmail) or smartphone apps demand quick, lightweight responses and push updates. These needs are better served by asynchronous frameworks instead of traditional web frameworks like Django, which are designed to serve fully rendered HTML pages and lack support for asynchronous database access.

The WebSockets protocol was designed to enable real-time updates for clients that are always connected, from games to streaming applications. This requires highly concurrent asynchronous servers able to keep ongoing interactions with hundreds or thousands of clients. WebSockets is very well supported by the asyncio architecture and at least two libraries already implement it on top of asyncio: Autobahn|Python and WebSockets.

This overall trend—dubbed「the real-time Web」—is a key factor in the demand for Node.js, and the reason why rallying around asyncio is so important for the Python ecosystem. There’s still a lot of work to do. For starters, we need an asynchronous HTTP server and client API in the standard library, an asynchronous DBAPI 3.0, and new database drivers built on asyncio.

The biggest advantage Python 3.4 with asyncio has over Node.js is Python itself: a better designed language, with coroutines and yield from to make asynchronous code more maintainable than the primitive callbacks of JavaScript. Our biggest disadvantage is the libraries: Python comes with「batteries included,」but our batteries are not designed for asynchronous programming. The rich ecosystem of libraries for Node.js is entirely built around async calls. But Python and Node.js both have a problem that Go and Erlang have solved from the start: we have no transparent way to write code that leverages all available CPU cores.

Standardizing the event loop interface and an asynchronous library was a major coup, and only our BDFL could have pulled it off, given that there were well-entrenched, high-quality alternatives available. He did it in consultation with the authors of the major Python asynchronous frameworks. The influence of Glyph Lefkowitz, the leader of Twisted, is most evident. Guido’s「Deconstructing Deferred」post to the Python-tulip group is a must-read if you want to understand why asyncio.Future is not like the Twisted Deferred class. Making clear his respect for the oldest and largest Python asynchronous framework, Guido also started the meme WWTD—What Would Twisted Do?—when discussing design options in the python-twisted group.[168]

Fortunately, Guido van Rossum led the charge so Python is better positioned to face the concurrency challenges of the present. Mastering asyncio takes effort. But if you plan to write concurrent network applications in Python, seek the One Loop:

One Loop to rule them all, One Loop to find them,

One Loop to bring them all and in liveness bind them.

* * *

[157] Slide 5 of the talk「Concurrency Is Not Parallelism (It’s Better)」.

[158] Imre Simon (1943–2009) was a pioneer of computer science in Brazil who made seminal contributions to Automata Theory and started the field of Tropical Mathematics. He was also an advocate of free software and free culture. I was fortunate to study, work, and hang out with him.

[159] Suggested by Petr Viktorin in a September 11, 2014, message to the Python-ideas list.

[160] Video: Introduction to Node.js at 4:55.

[161] In fact, although Node.js does not support user-level threads written in JavaScript, behind the scenes it implements a thread pool in C with the libeio library, to provide its callback-based file APIs—because as of 2014 there are no stable and portable asynchronous file handling APIs for most OSes.

[162] Thanks to Guto Maia who noted that Semaphore was not explained in the book draft.

[163] A detailed discussion about this can be found in a thread I started in the python-tulip group, titled「Which other futures my come out of asyncio.as_completed?」. Guido responds, and gives insight on the implementation of as_completed as well as the close relationship between futures and coroutines in asyncio.

[164] Leonardo Rochael pointed out that building the UnicodeNameIndex could be delegated to another thread using loop.run_with_executor() in the main function of Example 18-15, so the server would be ready to take requests immediately while the index is built. That is true, but querying the index is the only thing this app does, so that would not be a big win. It’s an interesting exercise to do as Leo suggests, though. Go ahead and do it, if you like.

[165] That’s what CJK stands for: the ever-expanding set of Chinese, Japanese, and Korean characters. Future versions of Python may support more CJK ideographs than Python 3.4 does.

[166] I have more to say about this trend in Soapbox.

[167] Comment on PEP-3156 in a Jan. 20, 2013 message to the python-ideas list.

[168] See Guido’s January 29, 2015, message, immediately followed by an answer from Glyph.

Part VI. Metaprogramming

Chapter 19. Dynamic Attributes and Properties

The crucial importance of properties is that their existence makes it perfectly safe and indeed advisable for you to expose public data attributes as part of your class’s public interface.[169]

— Alex Martelli Python contributor and book author

Data attributes and methods are collectively known as attributes in Python: a method is just an attribute that is callable. Besides data attributes and methods, we can also create properties, which can be used to replace a public data attribute with accessor methods (i.e., getter/setter), without changing the class interface. This agrees with the Uniform access principle:

All services offered by a module should be available through a uniform notation, which does not betray whether they are implemented through storage or through computation.[170]

Besides properties, Python provides a rich API for controlling attribute access and implementing dynamic attributes. The interpreter calls special methods such as __getattr__ and __setattr__ to evaluate attribute access using dot notation (e.g., obj.attr). A user-defined class implementing __getattr__ can implement「virtual attributes」by computing values on the fly whenever somebody tries to read a nonexistent attribute like obj.no_such_attribute.

Coding dynamic attributes is the kind of metaprogramming that framework authors do. However, in Python, the basic techniques are so straightforward that anyone can put them to work, even for everyday data wrangling tasks. That’s how we’ll start this chapter.

Data Wrangling with Dynamic Attributes

In the next few examples, we’ll leverage dynamic attributes to work with a JSON data feed published by O’Reilly for the OSCON 2014 conference. Example 19-1 shows four records from that data feed.[171]

Example 19-1. Sample records from osconfeed.json; some field contents abbreviated

{ "Schedule": { "conferences": [{"serial": 115 }], "events": [ { "serial": 34505, "name": "Why Schools Don´t Use Open Source to Teach Programming", "event_type": "40-minute conference session", "time_start": "2014-07-23 11:30:00", "time_stop": "2014-07-23 12:10:00", "venue_serial": 1462, "description": "Aside from the fact that high school programming...", "website_url": "http://oscon.com/oscon2014/public/schedule/detail/34505", "speakers": [157509], "categories": ["Education"] } ], "speakers": [ { "serial": 157509, "name": "Robert Lefkowitz", "photo": null, "url": "http://sharewave.com/", "position": "CTO", "affiliation": "Sharewave", "twitter": "sharewaveteam", "bio": "Robert ´r0ml´ Lefkowitz is the CTO at Sharewave, a startup..." } ], "venues": [ { "serial": 1462, "name": "F151", "category": "Conference Venues" } ] } }

Example 19-1 shows 4 out of the 895 records in the JSON feed. As you can see, the entire dataset is a single JSON object with the key "Schedule", and its value is another mapping with four keys: "conferences", "events", "speakers", and "venues". Each of those four keys is paired with a list of records. In Example 19-1, each list has one record, but in the full dataset, those lists have dozens or hundreds of records—with the exception of "conferences", which holds just the single record shown. Every item in those four lists has a "serial" field, which is a unique identifier within the list.

The first script I wrote to deal with the OSCON feed simply downloads the feed, avoiding unnecessary traffic by checking if there is a local copy. This makes sense because OSCON 2014 is history now, so that feed will not be updated.

There is no metaprogramming in Example 19-2; pretty much everything boils down to this expression: json.load(fp), but that’s enough to let us explore the dataset. The osconfeed.load function will be used in the next several examples.

Example 19-2. osconfeed.py: downloading osconfeed.json (doctests are in Example 19-3)

from urllib.request import urlopen import warnings import os import json URL = 'http://www.oreilly.com/pub/sc/osconfeed' JSON = 'data/osconfeed.json' def load(): if not os.path.exists(JSON): msg = 'downloading {} to {}'.format(URL, JSON) warnings.warn(msg) with urlopen(URL) as remote, open(JSON, 'wb') as local: local.write(remote.read()) with open(JSON) as fp: return json.load(fp)

Issue a warning if a new download will be made.

with using two context managers (allowed since Python 2.7 and 3.1) to read the remote file and save it.

The json.load function parses a JSON file and returns native Python objects. In this feed, we have the types: dict, list, str, and int.

With the code in Example 19-2, we can inspect any field in the data. See Example 19-3.

Example 19-3. osconfeed.py: doctests for Example 19-2

>>> feed = load() >>> sorted(feed['Schedule'].keys()) ['conferences', 'events', 'speakers', 'venues'] >>> for key, value in sorted(feed['Schedule'].items()): ... print('{:3} {}'.format(len(value), key)) ... 1 conferences 484 events 357 speakers 53 venues >>> feed['Schedule']['speakers'][-1]['name'] 'Carina C. Zona' >>> feed['Schedule']['speakers'][-1]['serial'] 141590 >>> feed['Schedule']['events'][40]['name'] 'There *Will* Be Bugs' >>> feed['Schedule']['events'][40]['speakers'] [3471, 5199]

feed is a dict holding nested dicts and lists, with string and integer values.

List the four record collections inside "Schedule".

Display record counts for each collection.

Navigate through the nested dicts and lists to get the name of the last speaker.

Get serial number of that same speaker.

Each event has a 'speakers' list with 0 or more speaker serial numbers.

Exploring JSON-Like Data with Dynamic Attributes

Example 19-2 is simple enough, but the syntax feed['Schedule']['events'][40]['name'] is cumbersome. In JavaScript, you can get the same value by writing feed.Schedule.events[40].name. It’s easy to implement a dict-like class that does the same in Python—there are plenty of implementations on the Web.[172] I implemented my own FrozenJSON, which is simpler than most recipes because it supports reading only: it’s just for exploring the data. However, it’s also recursive, dealing automatically with nested mappings and lists.

Example 19-4 is a demonstration of FrozenJSON and the source code is in Example 19-5.

Example 19-4. FrozenJSON from Example 19-5 allows reading attributes like name and calling methods like .keys() and .items()

>>> from osconfeed import load >>> raw_feed = load() >>> feed = FrozenJSON(raw_feed) >>> len(feed.Schedule.speakers) 357 >>> sorted(feed.Schedule.keys()) ['conferences', 'events', 'speakers', 'venues'] >>> for key, value in sorted(feed.Schedule.items()): ... print('{:3} {}'.format(len(value), key)) ... 1 conferences 484 events 357 speakers 53 venues >>> feed.Schedule.speakers[-1].name 'Carina C. Zona' >>> talk = feed.Schedule.events[40] >>> type(talk) <class 'explore0.FrozenJSON'> >>> talk.name 'There *Will* Be Bugs' >>> talk.speakers [3471, 5199] >>> talk.flavor Traceback (most recent call last): ... KeyError: 'flavor'

Build a FrozenJSON instance from the raw_feed made of nested dicts and lists.

FrozenJSON allows traversing nested dicts by using attribute notation; here we show the length of the list of speakers.

Methods of the underlying dicts can also be accessed, like .keys(), to retrieve the record collection names.

Using items(), we can retrieve the record collection names and their contents, to display the len() of each of them.

A list, such as feed.Schedule.speakers, remains a list, but the items inside are converted to FrozenJSON if they are mappings.

Item 40 in the events list was a JSON object; now it’s a FrozenJSON instance.

Event records have a speakers list with speaker serial numbers.

Trying to read a missing attribute raises KeyError, instead of the usual AttributeError.

The keystone of the FrozenJSON class is the __getattr__ method, which we already used in the Vector example in Vector Take #3: Dynamic Attribute Access, to retrieve Vector components by letter—v.x, v.y, v.z, etc. It’s essential to recall that the __getattr__ special method is only invoked by the interpreter when the usual process fails to retrieve an attribute (i.e., when the named attribute cannot be found in the instance, nor in the class or in its superclasses).

The last line of Example 19-4 exposes a minor issue with the implementation: ideally, trying to read a missing attribute should raise AttributeError. I actually did implement the error handling, but it doubled the size of the __getattr__ method and distracted from the most important logic I wanted to show, so I left it out for didactic reasons.

As shown in Example 19-5, the FrozenJSON class has only two methods (__init__, __getattr__) and a __data instance attribute, so attempts to retrieve an attribute by any other name will trigger __getattr__. This method will first look if the self.__data dict has an attribute (not a key!) by that name; this allows FrozenJSON instances to handle any dict method such as items, by delegating to self.__data.items(). If self.___data doesn’t have an attribute with the given name, __getattr__ uses name as a key to retrieve an item from self.__dict, and passes that item to FrozenJSON.build. This allows navigating through nested structures in the JSON data, as each nested mapping is converted to another FrozenJSON instance by the build class method.

Example 19-5. explore0.py: turn a JSON dataset into a FrozenJSON holding nested FrozenJSON objects, lists, and simple types

from collections import abc class FrozenJSON: """A read-only façade for navigating a JSON-like object using attribute notation """ def __init__(self, mapping): self.__data = dict(mapping) def __getattr__(self, name): if hasattr(self.__data, name): return getattr(self.__data, name) else: return FrozenJSON.build(self.__data[name]) @classmethod def build(cls, obj): if isinstance(obj, abc.Mapping): return cls(obj) elif isinstance(obj, abc.MutableSequence): return [cls.build(item) for item in obj] else: return obj

Build a dict from the mapping argument. This serves two purposes: ensures we got a dict (or something that can be converted to one) and makes a copy for safety.

__getattr__ is called only when there’s no attribute with that name.

If name matches an attribute of the instance __data, return that. This is how calls to methods like keys are handled.

Otherwise, fetch the item with the key name from self.__data, and return the result of calling FrozenJSON.build() on that.[173]

This is an alternate constructor, a common use for the @classmethod decorator.

If obj is a mapping, build a FrozenJSON with it.

If it is a MutableSequence, it must be a list,[174] so we build a list by passing every item in obj recursively to .build().

If it’s not a dict or a list, return the item as it is.

Note that no caching or transformation of the original feed is done. As the feed is traversed, the nested data structures are converted again and again into FrozenJSON. But that’s OK for a dataset of this size, and for a script that will only be used to explore or convert the data.

Any script that generates or emulates dynamic attribute names from arbitrary sources must deal with one issue: the keys in the original data may not be suitable attribute names. The next section addresses this.

The Invalid Attribute Name Problem

The FrozenJSON class has a limitation: there is no special handling for attribute names that are Python keywords. For example, if you build an object like this:

>>> grad = FrozenJSON({'name': 'Jim Bo', 'class': 1982})

You won’t be able to read grad.class because class is a reserved word in Python:

>>> grad.class File "<stdin>", line 1 grad.class ^ SyntaxError: invalid syntax

You can always do this, of course:

>>> getattr(grad, 'class') 1982

But the idea of FrozenJSON is to provide convenient access to the data, so a better solution is checking whether a key in the mapping given to FrozenJSON.__init__ is a keyword, and if so, append an _ to it, so the attribute can be read like this:

