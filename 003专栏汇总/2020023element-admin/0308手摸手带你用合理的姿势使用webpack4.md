# 0308 手摸手，带你用合理的姿势使用 webpack4

本文作者来自 华尔街见闻技术团队 - 花裤衩

前几天 webpack 作者 Tobias Koppers 发布了一篇新的文章 webpack 4.0 to 4.16: Did you know?(需翻墙)，总结了一下 webpack 4 发布以来，做了哪些调整和优化。并且说自己正在着手开发 webpack 5。

Oh you are still on webpack 3. I’m sorry, what is blocking you? We already working on webpack 5, so your stack might be outdated soon…


翻译成中文就是：

正好我也在使用一个文档生成工具 docz (安利一波) 也最低需要 webpack 4+，新版 webpack 性能提高了不少，而且 webpack 4 都已经发布五个多月了，想必应该已经没什么坑了，应该可以安心的按照别人写的升级攻略升级了。之前一直迟迟不升级完全是被去年被 webpack 3 坑怕了。它在 code splitting 的情况下 CommonsChunkPlugin 会完全失效。过了好一段时间才修复，欲哭无泪。

所以这次我等了快大半年才准备升级到 webpack 4 但万万没想到还是遇到了不少的问题！ 有很多之前遗留的问题还是没有很好地解决。但最主要的问题还是它的文档有所欠缺，已经废除了的东西如 commonsChunkPlugin 还在官方文档中到处出现，很多重要的东西却一笔带过，甚至没写，需要用户自己去看源码才能解决。

还比如在 v4.16.0 版本中废除了 optimization.occurrenceOrder、optimization.namedChunks、optimization.hashedModuleIds、optimization.namedModules 这几个配置项，替换成了 optimization.moduleIds 和 optimization.chunkIds，但文档完中全没有任何体现，所以你在新版本中还按照文档那样配置其实是没有任何效果的。

最新最完整的文档还是看他项目的配置 WebpackOptions.json，强烈建议遇到不清楚的配置项可以看这个，因为它一定保证是和最新代码同步的。

吐槽了这么多，我们言归正传。由于本次手摸手篇幅有些长，所以拆解成了上下两篇文章：

上篇 -- 就是普通的在 webpack 3 的基础上升级，要做哪些操作和遇到了哪些坑

下篇 -- 是在 webpack 4 下怎么合理的打包和拆包，并且如何最大化利用 long term caching

本文章不是手摸手从零教你 webpack 配置，所以并不会讲太多很基础的配置问题。比如如何处理 css 文件，如何配置 webpack-dev-server，讲述 file-loader 和 url-loader 之间的区别等等，有需求的推荐看 官方文档 或者 survivejs 出的一个系列教程。或者推荐看我司的另一篇 wbepack 入门文章，已同步到 webpack4 传送门。

升级篇

前言

我一直认为模仿和借鉴是学习一个新东西最高效的方法。所以我建议还是通过借鉴一些成熟的 webpack 配置比较好。比如你项目是基于 react 生态圈的话可以借鉴 create-react-app ，下载之后 npm run eject 就可以看到它详细的 webpack 配置了。vue 的话由于新版 vue cli 不支持 eject 了，而且改用 webpack-chain 来配置，所以借鉴起来可能会不太方便，主要配置 地址。觉得麻烦的话你可以直接借鉴 vue-element-admin 的 配置。或者你想自己发挥，你可以借鉴 webpack 官方的各种 examples，来组合你的配置。

升级 webpack

首先将 webpack 升级到 4 之后，直接运行 webpack --xxx 是不行的，因为新版本将命令行相关的东西单独拆了出去封装成了 webpack-cli。会报如下错误：

The CLI moved into a separate package: webpack-cli. Please install webpack-cli in addition to webpack itself to use the CLI.


所有你需要安装 npm install webpack-cli -D -S。你也可将它安装在全局。

同时新版 webpack 需要 Node.js 的最低支持版本为 6.11.5 不要忘了升级。如果还需要维护老项目可以使用 nvm 来做一下 node 版本管理。

升级所有依赖

因为 webpack4 改了 它的 hook api ，所以所有的 loaders、plugins 都需要升级才能够适配。

可以使用命令行 npm outdated，列出所以可以更新的包。免得再一个个去 npm 找相对于的可用版本了。

反正把 devDependencies 的依赖都升级一下，总归不会有错。

带来的变化

其实这次升级带来了不少改变，但大部分其实对于普通用户来说是不需要关注的，比如这次升级带来的功能 SideEffects、Module Type’s Introduced、WebAssembly Support，基本平时是用不到的。我们主要关注那些对我们影响比较大的改动如：optimization.splitChunks 代替原有的 CommonsChunkPlugin (下篇文章会着重介绍)，和 Better Defaults-mode 更好的默认配置，这是大家稍微需要关注一下的。

如果想进一步了解 Tree Shaking 和 SideEffects 的可见文末拓展阅读。上图参考 Webpack 4 进阶

默认配置

webpack 4 引入了零配置的概念，被 parcel 刺激到了。不管效果怎样，这改变还是值得称赞的。

最近又新出了 Fastpack 可以关注一下。

言归正题，我们来看看 webpack 默认帮我们做了些什么？

development 模式下，默认开启了 NamedChunksPlugin 和 NamedModulesPlugin 方便调试，提供了更完整的错误信息，更快的重新编译的速度。

module.exports = {


+ mode: 'development'


- devtool: 'eval',


- plugins: [


-   new webpack.NamedModulesPlugin(),


-   new webpack.NamedChunksPlugin(),


-   new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("development") }),


- ]


}


复制代码

production 模式下，由于提供了 splitChunks 和 minimize，所以基本零配置，代码就会自动分割、压缩、优化，同时 webpack 也会自动帮你 Scope hoisting 和 Tree-shaking。

module.exports = {


+  mode: 'production',


-  plugins: [


-    new UglifyJsPlugin(/* ... */),


-    new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("production") }),


-    new webpack.optimize.ModuleConcatenationPlugin(),


-    new webpack.NoEmitOnErrorsPlugin()


-  ]


}


复制代码

webpack 一直以来最饱受诟病的就是其配置门槛极高，配置内容极其复杂和繁琐，容易让人从入门到放弃，而它的后起之秀如 rollup、parcel 等均在配置流程上做了极大的优化，做到开箱即用，所以 webpack 4 也从中借鉴了不少经验来提升自身的配置效率。愿世间再也不需要 webpack 配置工程师。

html-webpack-plugin


用最新版本的的 html-webpack-plugin 你可能还会遇到如下的错误：

throw new Error('Cyclic dependency' + nodeRep)


产生这个 bug 的原因是循环引用依赖，如果你没有这个问题可以忽略。

目前解决方案可以使用 Alpha 版本，npm i --save-dev html-webpack-plugin@next

或者加入 chunksSortMode: 'none' 就可以了。

但仔细查看文档发现设置成 chunksSortMode: 'none' 这样是会有问题的。

Allows to control how chunks should be sorted before they are included to the HTML.


这属性会决定你 chunks 的加载顺序，如果设置为 none，你的 chunk 加载在页面中加载的顺序就不能够保证了，可能会出现样式被覆盖的情况。比如我在 app.css 里面修改了一个第三方库 element-ui 的样式，通过加载顺序的先后来覆盖它，但由于设置为了 none，打包出来的结果变成了这样：

<link href="/app.8945fbfc.css" rel="stylesheet">


<link href="/chunk-elementUI.2db88087.css" rel="stylesheet">


复制代码

app.css 被先加载了，之前写的样式覆盖就失效了，除非你使用 important 或者其它 css 权重的方式覆盖它，但这明显是不太合理的。vue-cli 正好也有这个相关 issue，尤雨溪也在不使用 @next 版本的基础上 hack 了它，有兴趣的可以自己研究一下，本人在项目中直接使用了 @next 版本，也没遇到其它什么问题（除了不兼容 webpack 的 prefetch/preload 相关 issue）。两种方案都可以，自行选择。

其它 html-webpack-plugin 的配置和之前使用没有什么区别。

mini-css-extract-plugin


与 extract-text-webpack-plugin 区别

由于 webpack4 对 css 模块支持的完善以及在处理 css 文件提取的方式上也做了些调整，所以之前我们一直使用的 extract-text-webpack-plugin 也完成了它的历史使命，将让位于 mini-css-extract-plugin。

使用方式也很简单，大家看着 文档 抄就可以了。

它与 extract-text-webpack-plugin 最大的区别是：它在 code spliting 的时候会将原先内联写在每一个 js chunk bundle 的 css，单独拆成了一个个 css 文件。

原先 css 是这样内联在 js 文件里的：

将 css 独立拆包最大的好处就是 js 和 css 的改动，不会影响对方。比如我改了 js 文件并不会导致 css 文件的缓存失效。而且现在它自动会配合 optimization.splitChunks 的配置，可以自定义拆分 css 文件，比如我单独配置了 element-ui 作为单独一个 bundle, 它会自动也将它的样式单独打包成一个 css 文件，不会像以前默认将第三方的 css 全部打包成一个几十甚至上百 KB 的 app.xxx.css 文件了。

压缩与优化

打包 css 之后查看源码，我们发现它并没有帮我们做代码压缩，这时候需要使用 optimize-css-assets-webpack-plugin 这个插件，它不仅能帮你压缩 css 还能优化你的代码。

// 配置

optimization: {


  minimizer: [new OptimizeCSSAssetsPlugin()];


}


复制代码

如上图测试用例所示，由于 optimize-css-assets-webpack-plugin 这个插件默认使用了 cssnano 来作 css 优化，所以它不仅压缩了代码、删掉了代码中无用的注释、还去除了冗余的 css、优化了 css 的书写顺序，优化了你的代码 margin: 10px 20px 10px 20px; =>margin:10px 20px;。同时大大减小了你 css 的文件大小。更多优化的细节见文档。

contenthash


但使用 MiniCssExtractPlugin 有一个需求特别注意的地方，在默认文档中它是这样配置的：

new MiniCssExtractPlugin({


  // Options similar to the same options in webpackOptions.output


  // both options are optional


  filename: devMode ? "[name].css" : "[name].[hash].css",


  chunkFilename: devMode ? "[id].css" : "[id].[hash].css"


});


复制代码

简单说明一下： filename 是指在你入口文件 entry 中引入生成出来的文件名，而 chunkname 是指那些未被在入口文件 entry 引入，但又通过按需加载（异步）模块的时候引入的文件。

在 copy 如上代码使用之后发现情况不对！每次改动一个 xx.js 文件，它对应的 css 虽然没做任何改动，但它的 文件 hash 还是会发生变化。仔细对比发现原来是 hash 惹的祸。6.f3bfa3af.css => 6.40bc56f6.css

但我这是根据官方文档来写的！为什么还有问题！后来在文档的最最最下面发下了这么一段话！

For long term caching use filename: [contenthash].css. Optionally add [name].


非常的不理解，这么关键的一句话会放在 Maintainers 还后面的地方，默认写在配置里面提示大家不是更好？有热心群众已经开了一个 pr，将文档默认配置为 contenthash。chunkhash => contenthash 相关 issue。

这个真的蛮过分的，稍不注意就会让自己的 css 文件缓存无效。而且很多用户平时修改代码的时候都不会在意自己最终打包出来的 dist 文件夹中到底有哪些变化。所以这个问题可能就一直存在了。浪费了多少资源！人艰不拆！大家觉得 webpack 难用不是没道理的。

补充一点：目前 MiniCssExtractPlugin 也不是非常完美的，它现在默认会将每个 bundle 的 css 独立于 js 文件，单独拆成一个 css 文件。但这样会产生一个新的问题。比如我有一个页面它只有一行 css，但也会被拆成了一个独立的 css 文件，还需要额外的一次 http 请求，非常的不合理。所以我就给官方提了一个 issue，呼吁增加一个 minSize，当 css 的内容小于这个 size 的时候还是内联到 js 文件中，期待官方增加这个功能。

这里再简单说明一下几种 hash 的区别：

hash


hash 和每次 build 有关，没有任何改变的情况下，每次编译出来的 hash 都是一样的，但当你改变了任何一点东西，它的 hash 就会发生改变。

简单理解，你改了任何东西，hash 就会和上次不一样了。

chunkhash


chunkhash 是根据具体每一个模块文件自己的的内容包括它的依赖计算所得的 hash，所以某个文件的改动只会影响它本身的 hash，不会影响其它文件。

contenthash


它的出现主要是为了解决，让 css 文件不受 js 文件的影响。比如 foo.css 被 foo.js 引用了，所以它们共用相同的 chunkhash 值。但这样子是有问题的，如果 foo.js 修改了代码，css 文件就算内容没有任何改变，由于是该模块的 hash 发生了改变，其 css 文件的 hash 也会随之改变。

这个时候我们就可以使用 contenthash 了，保证即使 css 文件所处的模块里有任何内容的改变，只要 css 文件内容不变，那么它的 hash 就不会发生变化。

contenthash 你可以简单理解为是 moduleId + content 所生成的 hash。

热更新速度

其实相对 webpack 线上打包速度，我更关心的本地开发热更新速度，毕竟这才是和我们每一个程序员每天真正打交道的东西，打包一般都会扔给 CI 自动执行，而且一般项目每天也不会打包很多次。

webpack 4 一直说自己更好的利用了 cache 提高了编译速度，但实测发现是有一定的提升，但当你一个项目，路由懒加载的页面多了之后，50 + 之后，热更新慢的问题会很明显，之前的文章中也提到过这个问题，原以为新版本会解决这个问题，但并没有。

不过你首先要排斥你的热更新慢不是，如：

没有使用合理的 Devtool souce map 导致

没有正确使用 exclude/include 处理了不需要处理的如 node_modules

在开发环境不要压缩代码 UglifyJs、提取 css、babel polyfill、计算文件 hash 等不需要的操作

旧方案

最早的方案是开发环境中不是用路由懒加载了，只在线上环境中使用。封装一个_import 函数，通过环境变区分是否需要懒加载。

开发环境：

module.exports = file => require("@/views/" + file + ".vue").default;


复制代码

生成环境：

module.exports = file => () => import("@/views/" + file + ".vue");


复制代码

但由于 webpack import 实现机制问题，会产生一定的副作用。如上面的写法就会导致 @/views/ 下的 所有.vue 文件都会被打包。不管你是否被依赖引用了，会多打包一些可能永远都用不到 js 代码。相关 issue

目前新的解决方案思路还是一样的，只在生成模式中使用路由懒加载，本地开发不使用懒加载。但换了一种没副作用的实现方式。

新方案

使用 babel 的 plugins babel-plugin-dynamic-import-node。它只做一件事就是：将所有的 import () 转化为 require ()，这样就可以用这个插件将所有异步组件都用同步的方式引入了，并结合 BABEL_ENV 这个 bebel 环境变量，让它只作用于开发环境下。将开发环境中所有 import () 转化为 require ()，这种方案解决了之前重复打包的问题，同时对代码的侵入性也很小，你平时写路由的时候只需要按照官方文档路由懒加载的方式就可以了，其它的都交给 babel 来处理，当你不想用这个方案的时候，也只需要将它从 babel 的 plugins 中移除就可以了。

具体代码：

首先在 package.json 中增加 BABEL_ENV

"dev": "BABEL_ENV=development webpack-dev-server XXXX"


复制代码

接着在.babelrc 只能加入 babel-plugin-dynamic-import-node 这个 plugins，并让它只有在 development 模式中才生效。

{


  "env": {


    "development": {


      "plugins": ["dynamic-import-node"]


    }


  }


}


复制代码

之后就大功告成了，路由只要像平时一样写就可以了。文档

 { path: '/login', component: () => import('@/views/login/index')}


复制代码

这样能大大提升你热更新的速度。基本两百加页面也能在 2000ms 的热跟新完成，基本做到无感刷新。当然你的项目本身就不大页面也不多，完全没必要搞这些。当你的页面变化跟不是你写代码速度的时候再考虑也不迟。

打包速度

webpack 4 在项目中实际测了下，普遍能提高 20%~30% 的打包速度。

本文不准备太深入的讲解这部分内容，详细的打包优化速度可以参考 slack 团队的这篇文章，掘金还有译文.

这里有几个建议来帮你加速 webpack 的打包速度。

首先你需要知道你目前打包慢，是慢在哪里。

我们可以用 speed-measure-webpack-plugin 这个插件，它能监控 webpack 每一步操作的耗时。如下图：

可以看出其实大部分打包花费的时间是在 Uglifyjs 压缩代码。和前面的提升热更新的切入点差不多，查看 source map 的正确与否，exclude/include 的正确使用等等。

使用新版的 UglifyJsPlugin 的时候记住可以加上 cache: true、parall: true，可以提搞代码打包压缩速度。更多配置可以参考 文档 或者 vue-cli 的 配置。

编译的时候还有还有一个很慢的原因是那些第三方库。比如 echarts、element-ui 其实都非常的大，比如 echarts 打包完也还有 775kb。所以你想大大提高编译速度，可以将这些第三方库 externals 出去，使用 script 的方式引入，或者使用 dll 的方式打包。经测试一般如 echarts 这样大的包可以节省十几秒到几十秒不等。

还有可以使用一些并行执行 webpack 的库：如 parallel-webpack、happypack。

顺便说一下，升级一下 node 可能有惊喜。前不久将 CI 里面的 node 版本依赖从 6.9.2 => 8.11.3，打包速度直接提升了一分多钟。

总之我觉得打包时间控制在差不多的范围内就可以了，没必要过分的优化。可能你研究了半天，改了一堆参数发现其实也就提升了几秒，但维护成本上去了，得不偿失。还不如升级 node、升级 webpack、升级你的编译环境的硬件水平来的实在和简单。

比如我司 CI 使用的是腾讯云普通的的 8 核 16g 的机器，这个项目也是一个很大的后台管理项目 200 + 页面，引用了很多第三方的库，但没有使用什么 happypack、dll，只是用了最新版的 webpack4，node@8.11.3。编译速度稳定在两分多钟，完全不觉得有什么要优化的必要。

Tree-Shaking


这其实并不是 webpack 4 才提出来的概念，最早是 rollup 提出来并实现的，后来在 webpack 2 中就实现了，本次在 webpack 4 只是增加了 JSON Tree Shaking 和 sideEffects 能让你能更好的摇。

不过这里还是要提一下，默认 webpack 是支持 Tree-Shaking 的，但在你的项目中可能会因为 babel 的原因导致它失效。

因为 Tree Shaking 这个功能是基于 ES6 modules 的静态特性检测，来找出未使用的代码，所以如果你使用了 babel 插件的时候，如：babel-preset-env，它默认会将模块打包成 commonjs，这样就会让 Tree Shaking 失效了。

其实在 webpack 2 之后它自己就支持模块化处理。所以只要让 babel 不 transform modules 就可以了。配置如下：

// .babelrc


{


  "presets": [


    ["env", {


      modules: false,


      ...


    }]


  ]


}


复制代码

顺便说一下都 8102 年了，请不要在使用 babel-preset-esxxxx 系列了，请用 babel-preset-env，相关文章 再见，babel-preset-2015。

下部分内容

手摸手，带你用合理的姿势使用 webpack4 （下）

拓展阅读

Webpack 4 和单页应用入门

Webpack 中的 sideEffects 到底该怎么用？

你的 Tree-Shaking 并没什么卵用

对 webpack 文档的吐槽

Tree-Shaking 性能优化实践 - 原理篇

再见，babel-preset-2015

关注下面的标签，发现更多相似文章

推荐先阅读 webpack 入门教程之后再来阅读本文。

Webpack 4 和单页应用入门

手摸手，带你用合理的姿势使用 webpack4 （上）

本文为手摸手使用 webpack4（下），主要分为两部分：

怎么合理的运用浏览器缓存

怎么构建可靠的持久化缓存

默认分包策略

webpack 4 最大的改动就是废除了 CommonsChunkPlugin 引入了 optimization.splitChunks。

webpack 4 的 Code Splitting 它最大的特点就是配置简单，如果你的 mode 是 production，那么 webpack 4 就会自动开启 Code Splitting。

以下内容都会以 vue-element-admin 为例子。在线

bundle-report


如上图所示，在没配置任何东西的情况下，webpack 4 就智能的帮你做了代码分包。入口文件依赖的文件都被打包进了 app.js，那些大于 30kb 的第三方包，如：echarts、xlsx、dropzone 等都被单独打包成了一个个独立 bundle。

它内置的代码分割策略是这样的：

新的 chunk 是否被共享或者是来自 node_modules 的模块

新的 chunk 体积在压缩之前是否大于 30kb

按需加载 chunk 的并发请求数量小于等于 5 个

页面初始加载时的并发请求数量小于等于 3 个

但有一些小的组件，如上图：vue-count-to 在未压缩的情况下只有 5kb，虽然它被两个页面共用了，但 webpack 4 默认的情况下还是会将它和那些懒加载的页面代码打包到一起，并不会单独将它拆成一个独立的 bundle。（虽然被共用了，但因为体积没有大于 30kb）

你可能会觉得 webpack 默认策略是不是有问题，我一个组件被多个页面，你每个页面都将这个组件打包进去了，岂不是会重复打包很多次这个组件？就拿 vue-count-to 来举例，你可以把共用两次以上的组件或者代码单独抽出来打包成一个 bundle，但你不要忘了 vue-count-to 未压缩的情况下就只有 5kb，gizp 压缩完可能只有 1.5kb 左右，你为了共用这 1.5kb 的代码，却要额外花费一次 http 请求的时间损耗，得不偿失。我个人认为 webpack 目前默认的打包规则是一个比较合理的策略了。

但有些场景下这些规则可能就显得不怎么合理了。比如我有一个管理后台，它大部分的页面都是表单和 Table，我使用了一个第三方 table 组件，几乎后台每个页面都需要它，但它的体积也就 15kb，不具备单独拆包的标准，它就这样被打包到每个页面的 bundle 中了，这就很浪费资源了。这种情况下建议把大部分页面能共用的组件单独抽出来，合并成一个 component-vendor.js 的包（后面会介绍）。

优化没有银弹，不同的业务，优化的侧重点是不同的。个人认为 webpack 4 默认拆包已经做得不错了，对于大部分简单的应用来说已经够用了。但作为一个通用打包工具，它是不可能满足所有的业务形态和场景的，所以接下来就需要我们自己稍微做一些优化了。

优化分包策略

就拿 vue-element-admin 来说，它是一个基于 Element-UI 的管理后台，所以它会用到如 echarts、xlsx、dropzone 等各种第三方插件，同时又由于是管理后台，所以本身自己也会写很多共用组件，比如各种封装好的搜索查询组件，共用的业务模块等等，如果按照默认的拆包规则，结果就不怎么完美了。

如第一张图所示，由于 element-ui 在 entry 入口文件中被引入并且被大量页面共用，所以它默认会被打包到 app.js 之中。这样做是不合理的，因为 app.js 里还含有你的 router 路由声明、store 全局状态、utils 公共函数，icons 图标等等这些全局共用的东西。

但除了 element-ui，其它这些又是平时开发中经常会修改的东西，比如我新增了一个全局功能函数，utils 文件就会发生改变，或者我修改一个路由的 path，router 文件就变了，这些都会导致 app.js 的 hash 发生改变：app.1.js => app.2.js。但由于 element-ui 和 vue/react 等也被打包在其中，虽然你没改变它们，但它们的缓存也会随着 app.xxx.js 变化而失效了，这就非常不合理的。所以我们需要自己来优化一下缓存策略。

我们现在的策略是按照体积大小、共用率、更新频率重新划分我们的包，使其尽可能的利用浏览器缓存。

我们根据上表来重新划分我们的代码就变成了这样。

基础类库 chunk-libs

它是构成我们项目必不可少的一些基础类库，比如 vue+vue-router+vuex+axios 这种标准的全家桶，它们的升级频率都不高，但每个页面都需要它们。（一些全局被共用的，体积不大的第三方库也可以放在其中：比如 nprogress、js-cookie、clipboard 等）

UI 组件库

理论上 UI 组件库也可以放入 libs 中，但这里单独拿出来的原因是： 它实在是比较大，不管是 Element-UI 还是 Ant Design gizp 压缩完都可能要 200kb 左右，它可能比 libs 里面所有的库加起来还要大不少，而且 UI 组件库的更新频率也相对的比 libs 要更高一点。我们不时的会升级 UI 组件库来解决一些现有的 bugs 或使用它的一些新功能。所以建议将 UI 组件库也单独拆成一个包。

自定义组件 / 函数 chunk-commons

这里的 commons 主要分为 必要和非必要。

必要组件是指那些项目里必须加载它们才能正常运行的组件或者函数。比如你的路由表、全局 state、全局侧边栏 / Header/Footer 等组件、自定义 Svg 图标等等。这些其实就是你在入口文件中依赖的东西，它们都会默认打包到 app.js 中。

非必要组件是指被大部分页面使用，但在入口文件 entry 中未被引入的模块。比如：一个管理后台，你封装了很多 select 或者 table 组件，由于它们的体积不会很大，它们都会被默认打包到到每一个懒加载页面的 chunk 中，这样会造成不少的浪费。你有十个页面引用了它，就会包重复打包十次。所以应该将那些被大量共用的组件单独打包成 chunk-commons。

不过还是要结合具体情况来看。一般情况下，你也可以将那些非必要组件 \ 函数也在入口文件 entry 中引入，和必要组件 \ 函数一同打包到 app.js 之中也是没什么问题的。

低频组件

低频组件和上面的共用组件 chunk-commons 最大的区别是，它们只会在一些特定业务场景下使用，比如富文本编辑器、js-xlsx 前端 excel 处理库等。一般这些库都是第三方的且大于 30kb，所以 webpack 4 会默认打包成一个独立的 bundle。也无需特别处理。小于 30kb 的情况下会被打包到具体使用它的页面 bundle 中。

业务代码

这部分就是我们平时经常写的业务代码。一般都是按照页面的划分来打包，比如在 vue 中，使用路由懒加载的方式加载页面 component: () => import ('./Foo.vue') webpack 默认会将它打包成一个独立的 bundle。

完整配置代码：

splitChunks: {


  chunks: "all",


  cacheGroups: {


    libs: {


      name: "chunk-libs",


      test: /[\\/]node_modules[\\/]/,


      priority: 10,


chunks: "initial" // 只打包初始时依赖的第三方

    },


    elementUI: {


name: "chunk-elementUI", // 单独将 elementUI 拆包

priority: 20, // 权重要大于 libs 和 app 不然会被打包进 libs 或者 app

      test: /[\\/]node_modules[\\/]element-ui[\\/]/


    },


    commons: {


      name: "chunk-commons",


test: resolve ("src/components"), // 可自定义拓展你的规则

minChunks: 2, // 最小共用次数

      priority: 5,


      reuseExistingChunk: true


    }


  }


};


复制代码

上图就是最终拆包结果概要，你可以 点我点我点我，在线查看拆包结果。

这样就能尽可能的利用了浏览器缓存。当然这种优化还是需要因项目而异的。比如上图中的共用组件 chunk-commons，可能打包出来发现特别大，包含了很多组件，但又不是每一个页面或者大部分页面需要它。很可能出现这种状况：A 页面只需要 chunk-commons 里面的 A 组件，

但却要下载整个 chunk-commons.js，这时候就需要考虑一下，目前的拆包策略是否合理，是否还需要 chunk-commons？还是将这些组件打包到各自的 bundle 中？还是调整一下 minChunks: 2（ 最小共用次数）？或者修改一下它的拆包规则？

// 或者你可以把策略改为只提取那些你注册在全局的组件。

- test: resolve("src/components")


+ test: resolve ("src/components/global_components") // 你注册全局组件的目录

复制代码博弈

其实优化就是一个博弈的过程，是让 a bundle 大一点还是 b? 是让首次加载快一点还是让 cache 的利用率高一点？ 但有一点要切记，拆包的时候不要过分的追求颗粒化，什么都单独的打成一个 bundle，不然你一个页面可能需要加载十几个.js 文件，如果你还不是 HTTP/2 的情况下，请求的阻塞还是很明显的 (受限于浏览器并发请求数)。所以还是那句话资源的加载策略并没什么完全的方案，都需要结合自己的项目找到最合适的拆包策略。

比如支持 HTTP/2 的情况下，你可以使用 webpack4.15.0 新增的 maxSize，它能将你的 chunk 在 minSize 的范围内更加合理的拆分，这样可以更好地利用 HTTP/2 来进行长缓存 (在 HTTP/2 的情况下，缓存策略就和之前又不太一样了)。

Long term caching


持久化缓存其实是一个老生常谈的问题，前端发展到现在，缓存方案已经很成熟了。简单原理：

针对 html 文件：不开启缓存，把 html 放到自己的服务器上，关闭服务器的缓存

针对静态的 js，css，图片等文件：开启 cdn 和缓存，将静态资源上传到 cdn 服务商，我们可以对资源开启长期缓存，因为每个资源的路径都是独一无二的，所以不会导致资源被覆盖，保证线上用户访问的稳定性。

每次发布更新的时候，先将静态资源 (js, css, img) 传到 cdn 服务上，然后再上传 html 文件，这样既保证了老用户能否正常访问，又能让新用户看到新的页面。

相关文章 大公司里怎样开发和部署前端代码？

所以我们现在要做的就是要让 webpack 给静态资源生产一个可靠的 hash，让它能自动在合适的时候更新资源的 hash，

并且保证 hash 值的唯一性，即为每个打包后的资源生成一个独一无二的 hash 值，只要打包内容不一样，那么 hash 值就不一样。

其实 webpack 4 在持久化缓存这一块已经做得非常的不错了，但还是有一些欠缺，下面我们将要从这几个方面讨论这个问题。

RuntimeChunk(manifest)


Module vs Chunk


HashedModuleIdsPlugin


NamedChunksPlugin


RuntimeChunk(manifest)


webpack 4 提供了 runtimeChunk 能让我们方便的提取 manifest，以前我们需要这样配置

new webpack.optimize.CommonsChunkPlugin({


  name: "manifest",


  minChunks: Infinity


});


复制代码现在只要一行配置就可以了

{


  runtimeChunk: true;


}


复制代码它的作用是将包含 chunks 映射关系的 list 单独从 app.js 里提取出来，因为每一个 chunk 的 id 基本都是基于内容 hash 出来的，所以你每次改动都会影响它，如果不将它提取出来的话，等于 app.js 每次都会改变。缓存就失效了。

单独抽离 runtimeChunk 之后，每次打包都会生成一个 runtimeChunk.xxx.js。（默认叫这名字，可自行修改）

优化

其实我们发现打包生成的 runtime.js 非常的小，gzip 之后一般只有几 kb，但这个文件又经常会改变，我们每次都需要重新请求它，它的 http 耗时远大于它的执行时间了，所以建议不要将它单独拆包，而是将它内联到我们的 index.html 之中 (index.html 本来每次打包都会变)。

这里我选用了 script-ext-html-webpack-plugin，主要是因为它还支持 preload 和 prefetch，正好需要就不想再多引用一个插件了，你完全可以使用 inline-manifest-webpack-plugin 或者 assets-webpack-plugin 等来实现相同的效果。

const ScriptExtHtmlWebpackPlugin = require("script-ext-html-webpack-plugin");


// 注意一定要在 HtmlWebpackPlugin 之后引用

//inline 的 name 和你 runtimeChunk 的 name 保持一致

new ScriptExtHtmlWebpackPlugin({


  //`runtime` must same as runtimeChunk name. default is `runtime`


  inline: /runtime\..*\.js$/


});


复制代码 Module vs Chunk

我们经常看到 xxxModuleIdsPlugin、xxxChunksPlugin，所以在 webpack 中 module 和 chunk 到底是一个怎么样的关系呢？

chunk: 是指代码中引用的文件（如：js、css、图片等）会根据配置合并为一个或多个包，我们称一个包为 chunk。

module: 是指将代码按照功能拆分，分解成离散功能块。拆分后的代码块就叫做 module。可以简单的理解为一个 export/import 就是一个 module。

每个 chunk 包可含多个 module。比如：

//9.xxxxxxxxx.js


//chunk id 为 9 ，包含了 Vc2m 和 JFUb 两个 module

(window.webpackJsonp = window.webpackJsonp || []).push([


  [9],


  {


    Vc2m: function(e, t, l) {},


    JFUb: function(e, t, l) {}


  }


]);


复制代码一个 module 还能跨 chunk 引用另一个 module，比如我想在 app.js 里面需要引用 chunkId 为 13 的模块 2700 可以这样引用：

return n.e(13).then(n.bind(null, "27OO"));


复制代码 HashedModuleIdsPlugin

了解了 module 和 chunk 之后，我们来研究一下 moduleId。

首先要确定你的 filename 配置的是 chunkhash (它与 hash 的区别可以看上篇文章)。

output: {


  path: path.join(__dirname, 'dist'),


  filename: '[name].[chunkhash].js',


}


复制代码我们在入口文件中随便引入一个新文件 test.js

//main.js


import "./test";


//test.js


console.log("apple");


复制代码我们运行 npm run build，发现了一件奇怪的事情，我只是多引入了一个文件，但发现有十几个文件发生了变化。这是为什么呢？

我们随便挑一个文件 diff 一下，发现两个文件只有 module id 的不同。

这是因为：

webpack 内部维护了一个自增的 id，每个 module 都有一个 id。所以当增加或者删除 module 的时候，id 就会变化，导致其它文件虽然没有变化，但由于 id 被强占，只能自增或者自减，导致整个 id 的顺序都错乱了。

虽然我们使用 [chunkhash] 作为输出名，但仍然是不够的。

因为 chunk 内部的每个 module 都有一个 id，webpack 默认使用递增的数字作为 moduleId。

如果引入了一个新文件或删掉一个文件，都可能会导致其它文件的 moduleId 发生改变，

那这样缓存失效了。如：

本来是一个按序的 moduleId list，这时候我插入一个 orange 模块，插在第三个位置，这样就会导致它之后的所以 module id 都依次加了 1。

这到了原因，解决方案就很简单了。我们就不要使用一个自增的 id 就好了，这里我们使用 HashedModuleIdsPlugin。

或者使用 optimization.moduleIds v4.16.0 新发布，文档还没有。查看 源码发现它有 natural、named、hashed、size、total-size。这里我们设置为 optimization.moduleIds='hash' 等于 HashedModuleIdsPlugin。源码了也写了 webpack5 会优化这部分代码。

它的原理是使用文件路径的作为 id，并将它 hash 之后作为 moduleId。

使用了 HashedModuleIdsPlugin`，我们再对比一下发现 module id 不再是简单的 id 了，而是一个四位 hash 过得字符串 (不一定都是四位的，如果重复的情况下会增加位数，保证唯一性 源码)。

这样就固定住了 module id 了。

NamedModulesPlugin 和 HashedModuleIdsPlugin 原理是相同的，将文件路径作为 id，只不过没有把路径 hash 而已，适用于开发环境方便调试。不建议在生产环境配置，因为这样不仅会增加文件的大小（路径一般偶读比较长），更重要的是为暴露你的文件路径。

NamedChunkPlugin


我们在固定了 module id 之后同理也需要固定一下 chunk id，不然我们增加 chunk 或者减少 chunk 的时候会和 module id 一样，都可能会导致 chunk 的顺序发生错乱，从而让 chunk 的缓存都失效。

作者也意识到了这个问题，提供了一个叫 NamedChunkPlugin 的插件，但在使用路由懒加载的情况下，你会发现 NamedChunkPlugin 并没什么用。

供了一个线上 demo，可以自行测一下。这里提就直接贴一下结果：

产生的原因前面也讲了，使用自增 id 的情况下是不能保证你新添加或删除 chunk 的位置的，一旦它改变了，这个顺序就错乱了，就需要重排，就会导致它之后的所有 id 都发生改变了。

接着我们 查看源码 还发现它只对有 name 的 chunk 才奏效！所以我们那些异步懒加载的页面都是无效的。这启不是坑爹！我们迭代业务肯定会不断的添加删除页面，这岂不是每新增一个页面都会让之前的缓存都失效？那我们之前还费这么大力优化什么拆包呢？

其实这是一个古老的问题了 相关 issue: Vendor chunkhash changes when app code changes 早在 2015 年就有人提了这个问题，这个问题也一直讨论至今，' 网友们 ' 也提供了各种奇淫巧技，不过大部分随着 webpack 的迭代已经不适用或者是修复了。

这里我就结合一下 timse (webpack 第二多贡献) 写的持久缓存的文章 (在 medium 上需要翻墙)

总结一下目前能解决这个问题的三种方案。

目前解决方案有三种

records


webpackChunkName


自定义 nameResolver

webpack records


很多人可能连这个配置项都没有注意过，不过早在 2015 年就已经被设计出来让你更好的利用 cache。官方文档

要使用它配置也很简单：

recordsPath: path.join(__dirname, "records.json");


复制代码对，只要这一行代码就能开启这个选项，并打包的时候会自动生成一个 JSON 文件。它含有 webpack 的 records 记录 - 即「用于存储跨多次构建 (across multiple builds) 的模块标识符」的数据片段。可以使用此文件来跟踪在每次构建之间的模块变化。

大白话就是：等于每次构建都是基于上次构建的基础上进行的。它会先读取你上次的 chunk 和 module id 的信息之后再进行打包。所以这时候你再添加或者删除 chunk，并不会导致之前所说的乱序了。

简单看一下构建出来的 JSON 长啥样。

{


  "modules": {


    "byIdentifier": {


      "demo/vendor.js": 0,


      "demo/vendor-two.js": 1,


      "demo/index.js": 2,


      ....


    },


    "usedIds": {


      "0": 0,


      "1": 1,


      "2": 2,


      ...


    }


  },


  "chunks": {


    "byName": {


      "vendor-two": 0,


      "vendor": 1,


      "entry": 2,


      "runtime": 3


    },


    "byBlocks": {},


    "usedIds": [


      0,


      1,


      2


  }


}


复制代码我们和之前一样，在路由里面添加一个懒加载的页面，打包对比后发现 id 并不会像之前那样按照遍历到的顺序插入了，而是基于之前的 id 依次累加了。一般新增页面都会在末尾填写一个新 id，删除 chunk 的话，会将原来代表 chunk 的 id，保留，但不会再使用。

但这个方案不被大家知晓主要原因就是维护这个 records.json 比较麻烦。如果你是在本地打包运行 webpack 的话，你只要将 records.json 当做普通文件上传到 github、gitlab 或其它版本控制仓库。

但现在一般公司都会将打包放在 CI 里面，用 docker 打包，这时候这份 records.json 存在哪里就是一个问题了。它不仅需要每次打包之前先读取你这份 json，打包完之后它还需要再更新这份 json，并且还要找地方存贮，为了下次构建再使用。你可以存在 git 中或者找一个服务器存，但存在什么地其它方都感觉怪怪的。

如果你使用 Circle CI 可以使用它的 store_artifacts，相关教程。

本人在使用了之后还是放弃了这个方案，使用成本略高。前端打包应该更加的纯粹，不需要依赖太多其它的东西。

webpackChunkName


在 webpack2.4.0 版本之后可以自定义异步 chunk 的名字了，例如：

import(/* webpackChunkName: "my-chunk-name" */ "module");


复制代码我们在结合 vue 的懒加载可以这样写。

{


    path: '/test',


    component: () => import(/* webpackChunkName: "test" */ '@/views/test')


  },


复制代码打包之后就生成了名为 test 的 chunk 文件。

chunk 有了 name 之后就可以解决 NamedChunksPlugin 没有 name 的情况下的 bug 了。查看打包后的代码我们发现 chunkId 就不再是一个简单的自增 id 了。

不过这种写法还是有弊端的，首先你需要手动编写每一个 chunk 的 name，同时还需要保证它的唯一性，当页面一多，维护起来还是很麻烦的。这就违背了程序员的原则：能偷懒就偷懒。

所以有什么办法可以自动生成一个 name 给 chunk 么 ？查看 webpack 源码我们发现了 NamedChunksPlugin 其实可以自定义 nameResolver 的。

自定义 nameResolver

NamedChunksPlugin 支持自己写 nameResolver 的规则的。但目前大部分相关的文章里的自定义函数是不适合 webpack4 ，而且在结合 vue 的情况下还会报错。

社区旧方案：

new webpack.NamedChunksPlugin(chunk => {


  if (chunk.name) {


    return chunk.name;


  }


  return chunk.modules.map(m => path.relative(m.context, m.request)).join("_");


});


复制代码适配 webpack4 和 vue 的新实现方案：

new webpack.NamedChunksPlugin(chunk => {


  if (chunk.name) {


    return chunk.name;


  }


  return Array.from(chunk.modulesIterable, m => m.id).join("_");


});


复制代码当然这个方案还是有一些弊端的因为 id 会可能很长，如果一个 chunk 依赖了很多个 module 的话，id 可能有几十位，所以我们还需要缩短一下它的长度。我们首先将拼接起来的 id hash 以下，而且要保证 hash 的结果位数也能太长，浪费字节，但太短又容易发生碰撞，所以最后我们我们选择 4 位长度，并且手动用 Set 做一下碰撞校验，发生碰撞的情况下位数加 1，直到碰撞为止。详细代码如下：

const seen = new Set();


const nameLength = 4;


new webpack.NamedChunksPlugin(chunk => {


  if (chunk.name) {


    return chunk.name;


  }


  const modules = Array.from(chunk.modulesIterable);


  if (modules.length > 1) {


    const hash = require("hash-sum");


    const joinedHash = hash(modules.map(m => m.id).join("_"));


    let len = nameLength;


    while (seen.has(joinedHash.substr(0, len))) len++;


    seen.add(joinedHash.substr(0, len));


    return `chunk-${joinedHash.substr(0, len)}`;


  } else {


    return modules[0].id;


  }


});


复制代码我给 vue-cli 官方也提了一个相关

issue 尤雨溪最后也采纳了这个方案。

所以如果你现在下载最新 vue-cli@3 上面啰嗦了半天的东西，其实都已经默认配置好了 (但作者本人为了找到这个 hack 方法整整花了两天时间 o (╥﹏╥) o)。

目前测试了一段时间没发现有什么问题。不过有一点不是很理解，不知道 webpack 出于什么样的原因，官方一直没有修复这个问题？可能是在等 webpack5 的时候放大招吧。

总结

拆包策略：

基础类库 chunk-libs

UI 组件库 chunk-elementUI

自定义共用组件 / 函数 chunk-commons

低频组件 chunk-eachrts/chunk-xlsx 等

业务代码 lazy-loading xxxx.js

持久化缓存：

使用 runtimeChunk 提取 manifest，使用 script-ext-html-webpack-plugin 等插件内联到 index.html 减少请求

使用 HashedModuleIdsPlugin 固定 moduleId

使用 NamedChunkPlugin 结合自定义 nameResolver 来固定 chunkId

上述说的问题大部分在 webpack 官方文档都没明确指出，唯一可以参考的就是这份 cache 文档，在刚更新 webpack4 的时候，我以为官方已经将 id 不能固定的问题解决了，但现实是残酷的，结果并不理想。不过作者也在很多的 issue 中说他正在着手优化 long term caching。

We plan to add another way to assign module/chunk ids for long term caching, but this is not ready to be told yet.


在 webpack 的 issue 和源码中也经常见到 Long term caching will be improved in webpack@5 和 TODO webpack 5 xxxx 这样的代码注释。这让我对 webpack 5 很期待。真心希望 webpack 5 能真正的解决前面几个问题，并且让它更加的 out-of-the-box，更加的简单和智能，就像 webpack 4 的 optimization.splitChunks，你基本不用做什么，它就能很好的帮你拆分好 bundle 包，同时又给你非常的自由发挥空间。

展望

Whats next? 官方在这篇文章中展望了一下 webpack5 和讲述了一下未来的计划 -- 持续改进用户体验、提升构建速度和性能，降低使用门槛，完善 Persistent Caching 等等。同时 webpack 也已经支持 Prefetching/Preloading modules，我相信之后也会有更多的网站会使用这一属性。

同时 webpack 的团队已经承诺会通过投票的方式来决定一些功能。比如不久前发起的投票。

大家可以关注 Tobias Koppers 的 twitter 进行投票。

最后还是期待一下 webpack5 和它之后的发展吧。如果没有 webpack，也就不会有今天的前端。

其实如一开始就讲的，vue 有 vue-cli、react 有 creat-react-app，现在新建项目基本都是基于脚手架的，很少有人从零开始写 webpack 配置文件的，而且一般开发中，一般程序员也不需要经常去修改 webpack 的配置。webpack 官方本身也在不断完善默认配置项，相信 webpack 的配置门槛也会越来低多。

愿世间再无 webpack 配置工程师。

拓展阅读

Webpack 4 和单页应用入门

Long term caching using Webpack records


Predictable long term caching with Webpack


从 Bundle 文件看 Webpack 模块机制

minipack


各种可视化分析 webpack bundle 库

