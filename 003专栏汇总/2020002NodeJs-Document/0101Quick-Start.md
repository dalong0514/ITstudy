# 0101. Quick Start

## 1.1 Introduction to Node.js

[Introduction to Node.js](https://nodejs.dev/learn)

[Guides | Node.js](https://nodejs.org/en/docs/guides/)

Node.js is an open-source and cross-platform JavaScript runtime environment. It is a popular tool for almost any kind of project!

Node.js runs the V8 JavaScript engine, the core of Google Chrome, outside of the browser. This allows Node.js to be very performant.

A Node.js app is run in a single process, without creating a new thread for every request. Node.js provides a set of asynchronous I/O primitives in its standard library that prevent JavaScript code from blocking and generally, libraries in Node.js are written using non-blocking paradigms, making blocking behavior the exception rather than the norm.

When Node.js performs an I/O operation, like reading from the network, accessing a database or the filesystem, instead of blocking the thread and wasting CPU cycles waiting, Node.js will resume the operations when the response comes back.

This allows Node.js to handle thousands of concurrent connections with a single server without introducing the burden of managing thread concurrency, which could be a significant source of bugs.

Node.js has a unique advantage because millions of frontend developers that write JavaScript for the browser are now able to write the server-side code in addition to the client-side code without the need to learn a completely different language.

In Node.js the new ECMAScript standards can be used without problems, as you don't have to wait for all your users to update their browsers - you are in charge of deciding which ECMAScript version to use by changing the Node.js version, and you can also enable specific experimental features by running Node.js with flags.

### 1.1.1 A Vast Number of Libraries

npm with its simple structure helped the ecosystem of Node.js proliferate, and now the npm registry hosts over 1,000,000 open source packages you can freely use.

### An Example Node.js Application

The most common example Hello World of Node.js is a web server:

Once we have installed Node.js, let's build our first web server. Create a file named app.js containing the following contents:

```js
const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
```

Now, run your web server using `node app.js`. Visit http://localhost:3000 and you will see a message saying "Hello World".

This code first includes the Node.js http `module`.

Node.js has a fantastic `standard library`, including first-class support for networking.

The `createServer()` method of http creates a new HTTP server and returns it.

The server is set to listen on the specified port and host name. When the server is ready, the callback function is called, in this case informing us that the server is running.

Whenever a new request is received, the request event is called, providing two objects: a request (an `http.IncomingMessage` object) and a response (an `http.ServerResponse` object). Those 2 objects are essential to handle the HTTP call.

The first provides the request details. In this simple example, this is not used, but you could access the request headers and request data. The second is used to return data to the caller.

In this case with:

```js
res.statusCode = 200
```

we set the statusCode property to 200, to indicate a successful response.

We set the Content-Type header:

```js
res.setHeader('Content-Type', 'text/plain')
```

and we close the response, adding the content as an argument to `end()`:

```js
res.end('Hello World\n')
```

### 1.1.2 Node.js Frameworks and Tools

Node.js is a low-level platform. In order to make things easy and exciting for developers, thousands of libraries were built upon Node.js by the community. Many of those established over time as popular options. Here is a non-comprehensive list of the ones worth learning:

AdonisJs: A full-stack framework highly focused on developer ergonomics, stability, and confidence. Adonis is one of the fastest Node.js web frameworks.

Express: It provides one of the most simple yet powerful ways to create a web server. Its minimalist approach, unopinionated, focused on the core features of a server, is key to its success.

Fastify: A web framework highly focused on providing the best developer experience with the least overhead and a powerful plugin architecture. Fastify is one of the fastest Node.js web frameworks.

hapi: A rich framework for building applications and services that enables developers to focus on writing reusable application logic instead of spending time building infrastructure.

koa: It is built by the same team behind Express, aims to be even simpler and smaller, building on top of years of knowledge. The new project born out of the need to create incompatible changes without disrupting the existing community.

Loopback.io: Makes it easy to build modern applications that require complex integrations.

Meteor: An incredibly powerful full-stack framework, powering you with an isomorphic approach to building apps with JavaScript, sharing code on the client and the server. Once an off-the-shelf tool that provided everything, now integrates with frontend libs 

React, Vue, and Angular. Can be used to create mobile apps as well.

Micro: It provides a very lightweight server to create asynchronous HTTP microservices.

NestJS: A TypeScript based progressive Node.js framework for building enterprise-grade efficient, reliable and scalable server-side applications.

Next.js: A framework to render server-side rendered React applications.

Nx: A toolkit for full-stack monorepo development using NestJS, Express, React, Angular, and more! Nx helps scale your development from one team building one application to many teams collaborating on multiple applications!

Socket.io: A real-time communication engine to build network applications.

## 1.2 A brief history of Node.js

[A brief history of Node.js](https://nodejs.dev/learn/a-brief-history-of-nodejs)

Believe it or not, Node.js is only eleven years old.

In comparison, JavaScript is 24 years old and the Web is 31 years old.

Eleven years isn't a very long time in tech, but Node.js seems to have been around forever.

I've had the pleasure to work with Node.js since the early days when it was only 2 years old, and despite the limited information in the wild, you could already feel that it was going to be a huge thing.

In this post, we draw the big picture of Node.js in its history, to put things in perspective.

A little bit of history

JavaScript is a programming language that was created at Netscape as a scripting tool to manipulate web pages inside their browser, Netscape Navigator.

Part of the business model of Netscape was to sell Web Servers, which included an environment called Netscape LiveWire that could create dynamic pages using server-side JavaScript. Unfortunately, Netscape LiveWire wasn't very successful and server-side JavaScript wasn't popularized until recently, by the introduction of Node.js.

One key factor that led to the rise of Node.js was the timing. Just a few years earlier, JavaScript had started to be considered as a more serious language, thanks to "Web 2.0" applications (such as Flickr, Gmail, etc.) that showed the world what a modern experience on the web could be like.

JavaScript engines also became considerably better as many browsers competed to offer users the best performance. Development teams behind major browsers worked hard to offer better support for JavaScript and find ways to make JavaScript run faster. The engine that Node.js uses under the hood, V8 (also known as Chrome V8 for being the open-source JavaScript engine of The Chromium Project), improved significantly due to this competition.

Node.js happened to be built in the right place and right time, but luck isn't the only reason why it is popular today. It introduces a lot of innovative thinking and approaches for JavaScript server-side development that have already helped many developers.