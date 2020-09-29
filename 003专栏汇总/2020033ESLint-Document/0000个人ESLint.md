# 0000个人ESLint

## 01. 个人配置增加记录

因为是用 cli3 搭建的项目，eslint 用是 vue 的插件 @vue/cli-plugin-eslint，所以没有生成单独的配置文件「.eslintrc.js」，配置规则是在文件「package.json」里的。

### 1.1 function 后的括号不要空格

2020-09-15

```json
    "rules": {
      "space-before-function-paren": [2, "never"]
    }
```

保证 function() 后面的括号可以不用跟 function 单词之间空一格。

### 1.2 禁止未使用过的变量（no-unused-vars）

2020-09-15

[no-unused-vars - Rules - ESLint中文](https://cn.eslint.org/docs/rules/no-unused-vars)

默认值是：

```json
{
    "rules": {
        "no-unused-vars": ["error", { "vars": "all", "args": "after-used", "ignoreRestSiblings": false }]
    }
}
```

首先把 `error` 改成 `warn`，`yarn lint` 跑的时候确保这一项只是警告，先修复其他问题。

`vars`，此配置项有两个值：1）all 检测所有变量，包括全局环境中的变量。这是默认值。2）local 仅仅检测本作用域中声明的变量是否使用，允许不使用全局环境中的变量。

`args` 选项有三个值：1）after-used —— 不检查最后一个使用的参数之前出现的未使用的位置参数，但是检查最后一个使用的参数之后的所有命名参数和所有位置参数。2）all —— 所有命名参数必须使用。3）none —— 不检查参数。

## 02. 配置文件

2020-09-15

```json
  "eslintConfig": {
    "root": true,
    "env": {
      "node": true
    },
    "extends": [
      "plugin:vue/essential",
      "eslint:recommended",
      "@vue/standard"
    ],
    "parserOptions": {
      "parser": "babel-eslint"
    },
    "rules": {
      "space-before-function-paren": [2, "never"],
      "no-unused-vars": ["warn", { "vars": "all", "args": "after-used", "ignoreRestSiblings": false }]
    },
    "overrides": [
      {
        "files": [
          "**/__tests__/*.{j,t}s?(x)",
          "**/tests/unit/**/*.spec.{j,t}s?(x)"
        ],
        "env": {
          "jest": true
        }
      }
    ]
  },
```