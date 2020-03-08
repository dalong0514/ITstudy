# 0102Kbone，十分钟让 Vue 项目同时支持小程序

微信团队 微信开发者 2 月 18 日

[Kbone，十分钟让 Vue 项目同时支持小程序](https://mp.weixin.qq.com/s/d1QpYF0jSay9-ouBd6CWGg)

Kbone 简介

微信小程序开发过程中，许多开发者会遇到 小程序 与 Web 端一起的需求，由于 小程序 与 Web 端的运行环境不同，开发者往往需要维护两套类似的代码，这对开发者来说比较耗费力气，并且会出现不同步的情况。

为了解决上述问题，微信小程序推出了同构解决方案 Kbone 来解决此问题。

那么，Kbone 要怎么使用呢？这里我们将通过一个 todo 的例子来跟大家讲解。

基本结构

首先，我们来看下一个基本的 kbone 项目的目录结构（这里的 todo 是基于 Vue 的示例，Kbone 也有 React，Preact，Omi 等版本，详情可移步 kbone github）。

因为 kbone 是为了解决 小程序 与 Web 端的问题，所以每个目录下的配置都会有两份（小程序 与 Web 端各一份）

入口

不管是 小程序 端还是 Web 端，都需要入口文件。在 src/index 目录下，main.js 为 Web 端用主入口，main.mp.js 则为 小程序 端用主入口。

当然，Web 端会比 小程序 多一个入口页面，即 index.html（位于根目录下）。

下面两段代码分别是 小程序端 入口与 Web 端入口的代码，可以看到 小程序端的入口代码封装在 createApp 函数里面（这里固定即可），内部会比 Web 端多一个创建 app 节点的操作，其他的基本就是一致的。

// 小程序端入口

import Vue from 'vue'

import todo from './todo.vue'

export default function createApp() {

// 创建 app 节点用于绑定

  const container = document.createElement('div')

  container.id = 'app'

  document.body.appendChild(container)

  return new Vue({

    el: '#app',

    render: h => h(todo)

  })

}

//web 端入口

import Vue from 'vue'

import todo from './todo.vue'

new Vue({

  el: '#app',

  render: h => h(todo)

})

todo.vue

在上面的入口图可以看到，源码目录中，除了入口文件分开之前，页面文件就是共用的了，这里直接使用 Vue 的写法即可，不用做特殊的适应。

配置

写完代码之后，我们要怎么跑项目呢？这时，配置就派上用场啦。

Web 端配置为正常的 Vue 配置，小程序端配置与 Web 端配置的唯一不同就是需要引入 mp-webpack-plugin 插件来将 Vue 组件转化为小程序代码。

构建代码

接着，我们需要构建代码，让代码可以运行到各自的运行环境中去。构建完成后，生产代码会位于 dist 目录中。

// 构建 web 端代码

// 目标代码在 dist/web

npm run build

// 构建小程序端代码

// 目标代码在 dist/mp

npm run mp

小程序端 的构建会比 Web 端的构建多一个步骤，就是 npm 构建。

进入 dist/mp 目录，执行 npm install 安装依赖，用开发者工具将 dist/mp 目录作为小程序项目导入之后，点击工具栏下的 构建 npm，即可预览效果。

效果

最后，我们来看一下 todo 的效果。kbone 初体验，done~

todo 代码可到 kbone/demo13 自提。

关于 Kbone 你有什么使用问题或建议，欢迎访问 Kbone 社区主页发帖交流（PC 网页端可发帖）。查看更多 Kbone 相关干货内容，欢迎来到 Kbone 文章专区。

阅读原文

微信扫一扫

关注该公众号

