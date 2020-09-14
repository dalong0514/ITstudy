# 0101. Getting Started with ESLint

[ESLint - Pluggable JavaScript linter](https://eslint.org/)

[Getting Started with ESLint - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/user-guide/getting-started)

ESLint is a tool for identifying and reporting on patterns found in ECMAScript/JavaScript code, with the goal of making code more consistent and avoiding bugs. In many ways, it is similar to JSLint and JSHint with a few exceptions: 1) ESLint uses Espree for JavaScript parsing. 2) ESLint uses an AST to evaluate patterns in code. 3) ESLint is completely pluggable, every single rule is a plugin and you can add more at runtime.

1『

从墨菲那边学到，直接跑一下命令即可，前提要设置里先设置好（2020-09-14）。

```
npm run lint
```

』

## 1.1 Installation and Usage

Prerequisites: Node.js (^10.12.0, or >=12.0.0) built with SSL support. (If you are using an official Node.js distribution, SSL is always built in.) You can install ESLint using npm or yarn:

```
npm install eslint --save-dev

# or

yarn add eslint --dev
```

You should then set up a configuration file:

```
$ npx eslint --init

# or

$ yarn run eslint --init
```

After that, you can run ESLint on any file or directory like this:

```
$ npx eslint yourfile.js

# or

$ yarn run eslint yourfile.js
```

It is also possible to install ESLint globally rather than locally (using npm install eslint --global). However, this is not recommended, and any plugins or shareable configs that you use must be installed locally in either case.

## 1.2 Configuration

Note: If you are coming from a version before 1.0.0 please see the migration guide.

After running eslint --init, you'll have a .eslintrc.{js,yml,json} file in your directory. In it, you'll see some rules configured like this:

```json
{
    "rules": {
        "semi": ["error", "always"],
        "quotes": ["error", "double"]
    }
}
```

The names "semi" and "quotes" are the names of rules in ESLint. The first value is the error level of the rule and can be one of these values:

```
"off" or 0 - turn the rule off
"warn" or 1 - turn the rule on as a warning (doesn't affect exit code)
"error" or 2 - turn the rule on as an error (exit code will be 1)
```

The three error levels allow you fine-grained control over how ESLint applies rules (for more configuration options and details, see the configuration docs). 

Your .eslintrc.{js,yml,json} configuration file will also include the line:

```json
{
    "extends": "eslint:recommended"
}
```

Because of this line, all of the rules marked "√" on the rules page will be turned on. Alternatively, you can use configurations that others have created by searching for "eslint-config" on npmjs.com. ESLint will not lint your code unless you extend from a shared configuration or explicitly turn rules on in your configuration.

## 1.3 Next Steps

Learn about advanced configuration of ESLint.——[Configuring ESLint - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/user-guide/configuring)

Get familiar with the command line options.——[Command Line Interface - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/user-guide/command-line-interface)

Explore ESLint integrations into other tools like editors, build systems, and more.——[Integrations - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/user-guide/integrations)

Can't find just the right rule? Make your own custom rule.——[Working with Rules - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/developer-guide/working-with-rules)

Make ESLint even better by contributing.——[Contributing - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/developer-guide/contributing/)