# 0000个人ESLint

## 01. 个人配置增加记录

因为是用 cli3 搭建的项目，eslint 用是 vue 的插件 @vue/cli-plugin-eslint，所以没有生成单独的配置文件「.eslintrc.js」，配置规则是在文件「package.json」里的。

### 2020-09-15

```json
    "rules": {
      "space-before-function-paren": [2, "never"]
    }
```

保证 function() 后面的括号可以不用跟 function 单词之间空一格。

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
      "space-before-function-paren": [2, "never"]
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