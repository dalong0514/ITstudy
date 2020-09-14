# 0202. ESLint

[ESLint | vue-element-admin](https://panjiachen.github.io/vue-element-admin-site/zh/guide/advanced/eslint.html)

不管是多人合作还是个人项目，代码规范都是很重要的。这样做不仅可以很大程度地避免基本语法错误，也保证了代码的可读性。

## 2.1 配置项

所有的配置文件都在 .eslintrc.js 中。本项目基本规范是依托于 vue 官方的 eslint 规则 eslint-config-vue 做了少许的修改。大家可以按照自己的需求进行定制化配置。比如：我个人或者项目组习惯于使用两个空格，但你可能觉得四个空格更顺眼，你可以做如下修改。 进入项目 .eslintrc.js 中，找到 indent，然后修改为 4 即可。 还有各种各样的配置信息，详情见 ESLint 文档。

在 v3.8.1版本之后，增加了 eslint-plugin-vue 来更好的校验 vue 相关代码。默认情况下使用了最严格的 plugin:vue/recommended 来校验代码，若你觉得太严格可自行修改。

```js
// https://github.com/PanJiaChen/vue-element-admin/blob/master/.eslintrc.js

module.exports = {
  extends: ['plugin:vue/recommended', 'eslint:recommended']
  //你可以修改为  extends: ['plugin:vue/essential', 'eslint:recommended']
}
```

3『

[vuejs/eslint-config-vue](https://github.com/vuejs/eslint-config-vue)

[List of available rules - ESLint - Pluggable JavaScript linter](https://eslint.org/docs/rules/)

[vuejs/eslint-plugin-vue: Official ESLint plugin for Vue.js](https://github.com/vuejs/eslint-plugin-vue)

』

## 2.2 取消 ESLint 校验

如果你不想使用 ESLint 校验（不推荐取消），只要找到 vue.config.js 文件。 进行如下设置 lintOnSave: false 即可。

## 2.3 vscode 配置 ESLint

这所谓工欲善其事，必先利其器，个人推荐 eslint+vscode 来写 vue，绝对有种飞一般的感觉。每次保存，vscode 就能标红不符合 eslint 规则的地方，同时还会做一些简单的自我修正。安装步骤如下：

首先安装 eslint 插件 ESLint。安装并配置完成 ESLint 后，我们继续回到 VSCode 进行扩展设置，依次点击 文件 > 首选项 > 设置，打开 VSCode 配置文件，添加如下配置：

```json
{
  "files.autoSave": "off",
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "vue-html",
    {
      "language": "vue",
      "autoFix": true
    }
  ],
  "eslint.run": "onSave",
  "eslint.autoFixOnSave": true
}
```

这样每次保存的时候就可以根据根目录下.eslintrc.js 你配置的 eslint 规则来检查和做一些简单的 fix。每个人和团队都有自己的代码规范，统一就好了，去打造一份属于自己的 eslint 规则上传到 npm 吧，如饿了么团队的 config，vue 的 config。

3『

[eslint-config-elemefe - npm](https://www.npmjs.com/package/eslint-config-elemefe)

[vuejs/eslint-config-vue](https://github.com/vuejs/eslint-config-vue)

[VSCode拓展推荐（前端开发） · Issue #10 · varHarrie/varharrie.github.io](https://github.com/varHarrie/varharrie.github.io/issues/10)

』

由于本项目是基于 vue-cli 进行构建，所以更多配置可参考官方文档。

## 2.4 自动修复

```
npm run lint -- --fix
```

运行如上命令，eslint 会自动修复一些简单的错误。

1『

从墨菲那边学到，直接跑一下命令即可，前提要设置里先设置好（2020-09-14）。

```
npm run lint
```

』