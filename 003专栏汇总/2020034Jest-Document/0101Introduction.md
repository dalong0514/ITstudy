# 0101. Introduction

[Getting Started · Jest](https://jestjs.io/docs/en/getting-started)

## 1.1 Getting Started

Install Jest using yarn:

```
yarn add --dev jest
```

Or npm:

```
npm install --save-dev jest
```

Note: Jest documentation uses yarn commands, but npm will also work. You can compare yarn and npm commands in the yarn docs, here. Let's get started by writing a test for a hypothetical function that adds two numbers. First, create a sum.js file:

```js
function sum(a, b) {
  return a + b;
}

module.exports = sum;
```

Then, create a file named sum.test.js. This will contain our actual test:

```js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

Add the following section to your package.json:

```js
{
  "scripts": {
    "test": "jest"
  }
}
```

Finally, run yarn test or npm run test and Jest will print this message:

```
PASS  ./sum.test.js
✓ adds 1 + 2 to equal 3 (5ms)
```

You just successfully wrote your first test using Jest! This test used expect and toBe to test that two values were exactly identical. To learn about the other things that Jest can test, see Using Matchers.

## 1.2 Running from command line

You can run Jest directly from the CLI (if it's globally available in your PATH, e.g. by yarn global add jest or npm install jest --global) with a variety of useful options. Here's how to run Jest on files matching my-test, using config.json as a configuration file and display a native OS notification after the run:

```
jest my-test --notify --config=config.json
```

If you'd like to learn more about running jest through the command line, take a look at the Jest CLI Options page.

## 1.3 Additional Configuration

Generate a basic configuration file. Based on your project, Jest will ask you a few questions and will create a basic configuration file with a short description for each option:

```
jest --init
```

Using Babel. To use Babel, install required dependencies via yarn:

```
yarn add --dev babel-jest @babel/core @babel/preset-env
```

Configure Babel to target your current version of Node by creating a babel.config.js file in the root of your project:

```js
// babel.config.js
module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current',
        },
      },
    ],
  ],
};
```

The ideal configuration for Babel will depend on your project. See Babel's docs for more details.

Making your Babel config jest-aware.

Babel 6 support.

Using webpack. Jest can be used in projects that use webpack to manage assets, styles, and compilation. webpack does offer some unique challenges over other tools. Refer to the webpack guide to get started.

Using parcel. Jest can be used in projects that use parcel-bundler to manage assets, styles, and compilation similar to webpack. Parcel requires zero configuration. Refer to the official docs to get started.

Using TypeScript. Jest supports TypeScript, via Babel. First, make sure you followed the instructions on using Babel above. Next, install the @babel/preset-typescript via yarn:

```
yarn add --dev @babel/preset-typescript
```

Then add @babel/preset-typescript to the list of presets in your babel.config.js.

```js
// babel.config.js
module.exports = {
  presets: [
    ['@babel/preset-env', {targets: {node: 'current'}}],
+    '@babel/preset-typescript',
  ],
};
```

However, there are some caveats to using TypeScript with Babel. Because TypeScript support in Babel is transpilation, Jest will not type-check your tests as they are run. If you want that, you can use ts-jest.