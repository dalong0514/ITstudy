## 202104问题记录

### 01. 打包报错找不到合适的版本

2021-04-11

`yarn builder:mac` 后的报错信息：

```
Error: editions-autoloader-not-suitable: Unable to determine a suitable edition, as none were suitable.
```

墨菲感觉是 electron-builder 版本号导致的错误。接着试了下重装这个组件解决了。

1、先整体删除 node_modules 包：

```
rm -rf node_modules
```

2、配置文件 package.json 里修改一下 electron-builder 版本号：

```
    "electron": "11.0.2",
    "electron-builder": "^22.7.0",
```

更改为：

```
    "electron": "11.0.2",
    "electron-builder": "22.7.0",
```

3、重新安装一下包依赖：`yarn` 或者 `yarn install`。

### 02. 生产环境配置导致登录不进账号

发现登录的 URL  不对：

```
http://pre.test.hg101.vip/admin/admin/login
```

前面的 pre 是多余的。那么就是打包时配置里的信息有问题。webpack => renderer => webpack.config.prod.js

```js
module.exports = merge(baseConfig,  {
  // webpack 4.x 默认使用的 uglyJsPlugin 进行压缩效率较低，可以使用 terser 进行优化
  mode: 'production',

  devtool: "source-map",

  optimization: {
    minimize: false,
  },

  plugins: [
    // 每次打包前清除dist
    new CleanWebpackPlugin(),
    // 分离css文件
    new MiniCssExtractPlugin({
      filename: 'css/[name].[contenthash].css',
      chunkFilename: 'css/[id].[contenthash].css'
    }),
    new webpack.DefinePlugin({
      'process.env': {
        // 运行时环境，production: 生产，此时应该是安装包；development: 开发，表示在通过代码运行
        NODE_ENV: '"production"',
        // 通信环境：dev: 测试环境，pre: 预生产，prod: 生产
        HTTP_ENV: '"pre"',
      },
    }),
  ]
})
```

`HTTP_ENV: '"pre"'` 更改为 `HTTP_ENV: '"dev"'` 即可。

