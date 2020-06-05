# 0306手摸手，带你封装一个 vue component

发布于 2017-04-17

## 6.1 为什么选择自己封装第三方库

最近几个月我司把之前两三年的所有业务都用了 vue 重构了一遍，前台使用 vue+ssr，后台使用了 vue+element，在此过程中封装和自己写了很多 vue component。其实 vue 写 component 相当简单和方便，github 上有很多的 vue component 都只是简单的包装了一些 jquery 或者原生 js 的插件，但我个人是不太喜欢使用这些第三方封装的。理由如下：

1、很多第三方封装的组件参数配置项其实是有缺损的。如一些富文本或者图表组件，配置项远比你想想中的多得多，第三方封装组件很难覆盖全部所有配置。

2、第三方组件的更新频率很难保证。很多第三方封装组件并不能一直和原始组件保持同步更新速度，万一原始组件更新了某个你需要的功能，但第三方并没有更新那岂不是很尴尬，而且很多第三方组件维护一段时间之后就不维护了。

3、灵活性和针对性。还是那富文本来说，富文本在我司有很多定制化需求，我们需要将图片上传七牛，需要将图片打水印，需要很多针对业务的特殊需求，使用第三方包装的组件是不合适的，一般基于第三方封装的组件是很难拓展的。

所以我觉得大部分组件还是自己封装来的更为方便和灵活一些。

## 6.2 动手开干

接下来我们一起手摸手教改造包装一个 js 插件，只要几分钟就可以封装一个专属于你的 vue component。封装对象：countUp.js「[inorganik/countUp.js: Animates a numerical value by counting to it](https://github.com/inorganik/countUp.js)」，改造后结果 vue-countTo「[PanJiaChen/vue-countTo: It's a vue component that will count to a target number at a specified duration https://panjiachen.github.io/countTo/demo/](https://github.com/PanJiaChen/vue-countTo)」。

首先我们用官方提供的 vue-cli 来构建项目，这里选择了 webpack-simple（组件相对而言比较简单，不需要很多复杂的功能，所以 webpack-simple 已经满足需求了）。

```
$ npm install -g vue-cli
$ vue init webpack-simple my-project
$ cd my-project
$ npm install
```

安装 countup.js：

```
$ npm install countup.js
$ npm run dev
```

启动项目之后按照 countup.js 官方 demo 初始化插件。

app.vue

```
<template>
  <span ref='countup'></span>
</template>

<script>
import CountUp from 'countup.js'
export default {
  name: 'countup-demo',
  data () {
    return {
      numAnim:null
    }
  },
  mounted(){
    this.initCountUp()
  },
  methods:{
    initCountUp(){
      this.numAnim = new CountUp(this.$refs.countup,0, 2017)
      this.numAnim.start();
    }
  }
}
</script>
```

刷新页面，就这么简单，countUp.js 已经生效了。

接下来查看 countUp.js 的 github 发现它定义了如下可配置参数。对应 vue 就是 props，类型和初始化一目了然。

1『图片里的是 countUp.js 的 params。』

```js
props: {
  start: {
    type: Number,
    default: 0
  },
  end: {
    type: Number,
    default: 2017
  },
  decimal: {
    type: Number,
    default: 0
  },
  duration: {
    type: Number,
    default: 2.5
  },
  options: {
    type: Object
  }
}
```

之后再将 countup 之前写死的配置项替换为动态 props 就可以了。

```js
this.numAnim = new CountUp(this.$refs.countup, 
                           this.start,
                           this.end,
                           this.decimal,
                           this.duration,
                           this.options)
```

使用组件：

```html
<vue-count-up :end="2500" :duration="2.5"></vue-count-up>
```

只要几分钟一个属于自己的原生组件就包装好了，就是这么简单。完整 demo「[countUp-demo/App.vue at master · PanJiaChen/countUp-demo](https://github.com/PanJiaChen/countUp-demo/blob/master/src/App.vue)」。

这时候你如果觉得使用 countUp.js 还有些不满足你的需求，那你可以选择自己来造轮子了。

## 6.3 造轮子篇

首先当然是阅读源码。其实源码也就两部分核心代码：

第一部分：主要是就是 requestAnimationFrame，在游览器不支持 requestAnimationFrame 的情况下使用 setTimeout 来模拟，这段代码值得仔细阅读，自己在平时的项目中也能借鉴使用这段代码。

第二部分：就是 count 函数。

看懂这两部分之后造轮子就相当的简单了，demo「[PanJiaChen/vue-countTo: It's a vue component that will count to a target number at a specified duration https://panjiachen.github.io/countTo/demo/](https://github.com/PanJiaChen/vue-countTo)」。造轮子过程中发现 countUp，并没有 autoplay 这个参数项可以让组件自动开始count，没关系。。。我们可以自己来撸，我们首先定义 autoplay 这个props为布尔值，默认所有组件 autoplay 为 true

```js
 props:{
   autoplay: {
     type: Boolean,
     required: false,
     default: true
   }
 }
 ```
 
定义好 props 之后只要在 mounted 生命周期内加一个判断就完事了。

```js
mounted() {
  if (this.autoplay) {
    this.start();
  }
}
```

我们的 countUp 组件可以自动 count 了！

## 6.4 上传 npm

在不跨项目的情况下之前所做的已经满足需求了。但我们不能就此满足，我想让世界上更多的人来使用我的插件，这时候就要上传  npm「[npm | build amazing things](https://www.npmjs.com/)」了 demo「[PanJiaChen/vue-countTo: It's a vue component that will count to a target number at a specified duration https://panjiachen.github.io/countTo/demo/](https://github.com/PanJiaChen/vue-countTo)」。

首先我们新建一个index.js。

```js
import CountTo from './vue-countTo.vue'

// 导出模块
export default CountTo

//global 情况下 自动安装
if (typeof window !== 'undefined' && window.Vue) {
  window.Vue.component('count-to', CountTo)
}
```

同时我们也要改造一下 webpack 的配置，因为不是所有使用你组件的人都是通过 npm 安装使用 import 引入组件的的。还有很多人是通过 \<script> 标签的方式直接引入的，所以我们要将 libraryTarget 改为 umd 格式「[Output | webpack](https://webpack.js.org/configuration/output/)」。

```js
library: 'CountTo',
libraryTarget: 'umd',
umdNamedDefine: true
```

大功告成，现在只要将它发布到 npm 就可以了，首先注册一个npm 账号，之后配置自己的 package.json（注意填写 version，每次发布的 version 不能相同；main 为入口文件地址）。之后只要一行命令 npm publish 你的项目就发到 npm 了，快让小伙伴们一起来用你的vue component 吧！

## 总结

这里这是拿了一个很简单的 countUp 组件举了一个简单例子，有的时候自己动手丰衣足食，很多插件的封装比想象中简单的多。产品经理再也不会看到我因为这个 fu\*\* 插件怎么不支持这个功能而愁眉苦脸了，我们可以更好地满足产品了。
