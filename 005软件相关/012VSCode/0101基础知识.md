# 0101基本信息

[Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)

[microsoft/vscode: Visual Studio Code](https://github.com/microsoft/vscode)

[为什么VS Code会迅速占领JavaScript开发者社区-InfoQ](https://www.infoq.cn/article/0dmxg9Oo1UCRGhZ2g_cy)

[强大的 VS Code - 掘金](https://juejin.im/post/5b123ace6fb9a01e6f560a4b)

[使用顶级 VSCode 扩展来加快开发 JavaScript-WEB前端开发](https://www.html.cn/archives/9507)

## 01. 基础配置

### 1. 汉化

打开命令面板，输入：configure display language，会自动弹出中文的插件，安装一下，重启。

### 2. 80 个字符处设置绘标尺

设置里直接搜「editor.rulers」进入设置文件 settings.json，添加如下设置：

```
// 在一定数量的等宽字符后显示垂直标尺。输入多个值，显示多个标尺。若数组为空，则不绘制标尺。
"editor.rulers": [80]
```

## 02. 常用快捷键

1、打开跳转到某个函数所在的文件：「shift + command + 点鼠标」。

2、自动插入多行注释，`shift + option + A` 会自动插入 `/*  */`，然后可以在中间输入一个 `*`，接着剔除第一个 `*` 和第二个 `*` 时间的空格，在第二个 `*` 后面直接按回车键，系统会自动插入多行注释所需要的 `*`。

