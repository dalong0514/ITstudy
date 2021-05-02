# 0101. Tutorial: Intro to React

[Getting Started – React](https://reactjs.org/docs/getting-started.html)

[Tutorial: Intro to React – React](https://reactjs.org/tutorial/tutorial.html)

This tutorial doesn't assume any existing React knowledge.

## 1.1 Before We Start the Tutorial

We will build a small game during this tutorial. You might be tempted to skip it because you're not building games — but give it a chance. The techniques you'll learn in the tutorial are fundamental to building any React app, and mastering it will give you a deep understanding of React.

Tip: This tutorial is designed for people who prefer to learn by doing. If you prefer learning concepts from the ground up, check out our step-by-step guide. You might find this tutorial and the guide complementary to each other.

The tutorial is divided into several sections:

1 Setup for the Tutorial will give you a starting point to follow the tutorial.

2 Overview will teach you the fundamentals of React: components, props, and state.

3 Completing the Game will teach you the most common techniques in React development.

4 Adding Time Travel will give you a deeper insight into the unique strengths of React.

You don't have to complete all of the sections at once to get the value out of this tutorial. Try to get as far as you can — even if it's one or two sections.

我们将会在这个教程中开发一个小游戏。你可能并不打算做游戏开发，然后就直接跳过了这个教程——但是不妨尝试一下！你将在该教程中学到关于构建 React 应用的基础知识，掌握这些知识后，你将会对 React 有更加深刻的理解。

提示：这篇教程适用于更喜欢边学边做的开发者，如果你更喜欢从头开始学习一些概念，请参考逐步学习指南。你会发现这篇教程和逐步学习指南是互补的。

这篇教程分为以下几个部分：1）环境准备是学习该教程的起点。2）概览介绍了 React 的基础知识：组件、props 和 state。3）游戏完善介绍了在 React 开发过程中最常用的技术。4）时间旅行可以让你更加深刻地了解 React 的独特优势。5）你不必着急一口气学完这篇教程的所有内容，尽力就行，哪怕是先学习一两节。

### 1.1.1 What Are We Building?

In this tutorial, we'll show how to build an interactive tic-tac-toe game with React.

You can see what we'll be building here: Final Result ([Tic Tac Toe](https://codepen.io/gaearon/pen/gWWZgR?editors=0011)). If the code doesn't make sense to you, or if you are unfamiliar with the code's syntax, don't worry! The goal of this tutorial is to help you understand React and its syntax.

We recommend that you check out the tic-tac-toe game before continuing with the tutorial. One of the features that you'll notice is that there is a numbered list to the right of the game's board. This list gives you a history of all of the moves that have occurred in the game, and it is updated as the game progresses.

You can close the tic-tac-toe game once you're familiar with it. We'll be starting from a simpler template in this tutorial. Our next step is to set you up so that you can start building the game.

接下来，我们一起用 React 开发一个井字棋（tic-tac-toe）。你可以提前预览我们要写的游戏的最终效果。如果你看不懂其中的代码，或不熟悉这些语法，别担心！接下来的教程会一步一步帮助你理解 React 及其语法。在继续后面的教程之前，推荐你先玩一下这个井字棋。在游戏里，你会看到游戏面板的右边有一个标有序号的列表。这个列表记录了游戏中的每个步骤，并且会随着游戏的进行不断更新。等你熟悉游戏功能，便可关掉它！我们会在一个简单的模板上开始写起。下一步就是帮做好准备工作，这样你就可以开始游戏开发了。

### 1.1.2 Prerequisites

We'll assume that you have some familiarity with HTML and JavaScript, but you should be able to follow along even if you're coming from a different programming language. We'll also assume that you're familiar with programming concepts like functions, objects, arrays, and to a lesser extent, classes.

If you need to review JavaScript, we recommend reading this guide. Note that we're also using some features from ES6 — a recent version of JavaScript. In this tutorial, we're using arrow functions, classes, let, and const statements. You can use the Babel REPL to check what ES6 code compiles to.

3『

[A re-introduction to JavaScript (JS tutorial) - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

[Arrow function expressions - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

[Classes - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)

[let - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let)

[const - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const)

[Babel · The compiler for next generation JavaScript](https://babeljs.io/repl/#?browsers=defaults%2C%20not%20ie%2011%2C%20not%20ie_mob%2011&build=&builtIns=false&spec=false&loose=false&code_lz=MYewdgzgLgBApgGzgWzmWBeGAeAFgRgD4AJRBEAGhgHcQAnBAEwEJsB6AwgbgChRJY_KAEMAlmDh0YWRiGABXVOgB0AczhQAokiVQAQgE8AkowAUAcjogQUcwEpeAJTjDgUACIB5ALLK6aRklTRBQ0KCohMQk6Bx4gA&debug=false&forceAllTransforms=false&shippedProposals=false&circleciRepo=&evaluate=false&fileSize=false&timeTravel=false&sourceType=module&lineWrap=true&presets=react&prettier=false&targets=&version=7.13.15&externalPlugins=)

』

我们假定你已经对 HTML 和 JavaScript 都比较熟悉了。即便你之前使用其他编程语言，你也可以跟上这篇教程的。除此之外，我们假定你也已经熟悉了一些编程的概念，例如，函数、对象、数组，以及 class 的一些内容。如果你想回顾一下 JavaScript，你可以阅读这篇教程。注意，我们也用到了一些 ES6（较新的 JavaScript 版本）的特性。在这篇教程里，我们主要使用了箭头函数（arrow functions）、class、let 语句和 const 语句。你可以使用 Babel REPL 在线预览 ES6 的编译结果。

## 1.2 Setup for the Tutorial

There are two ways to complete this tutorial: you can either write the code in your browser, or you can set up a local development environment on your computer.

Setup Option 1: Write Code in the Browser

This is the quickest way to get started!

First, open this Starter Code in a new tab. The new tab should display an empty tic-tac-toe game board and React code. We will be editing the React code in this tutorial.

You can now skip the second setup option, and go to the Overview section to get an overview of React.

Setup Option 2: Local Development Environment

This is completely optional and not required for this tutorial!

This setup requires more work but allows you to complete the tutorial using an editor of your choice. Here are the steps to follow:

1 Make sure you have a recent version of Node.js installed.

2 Follow the installation instructions for Create React App to make a new project.

```
npx create-react-app my-app
```

1『

```
yarn create react-app my-app
```

也是可以的。不过新建项目失败了，报错：

```
The engine "node" is incompatible with this module. Expected version "^10 || ^12 || >=14". Got "13.10.1"
```

显示是 node.js 版本的原因，自己 Mac 里的 node 当时是用 brew 安装的，那么：

```
brew upgrade node
```

brew 更新失败了，网络的问题。去 node 的官网下载了打包版安装了一下。

```
This package has installed:
	•	Node.js v14.16.1 to /usr/local/bin/node
	•	npm v6.14.12 to /usr/local/bin/npm
Make sure that /usr/local/bin is in your $PATH.
```

安装项目成功：

```
Success! Created my-app at /Users/Daglas/dalong.react/my-app
Inside that directory, you can run several commands:

  yarn start
    Starts the development server.

  yarn build
    Bundles the app into static files for production.

  yarn test
    Starts the test runner.

  yarn eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd my-app
  yarn start

Happy hacking!
```

』

3 Delete all files in the src/ folder of the new project

Note: Don't delete the entire src folder, just the original source files inside it. We'll replace the default source files with examples for this project in the next step.

```
cd my-app
cd src

# If you're using a Mac or Linux:
rm -f *

# Or, if you're on Windows:
del *

# Then, switch back to the project folder
cd ..
```

4 Add a file named index.css in the src/ folder with this CSS code.

5 Add a file named index.js in the src/ folder with this JS code.

6 Add these three lines to the top of index.js in the src/ folder:

1『这里需要把提供的 js 和 css 代码拷进 index.js、index.css 文件里。（2021-04-27）』

```js
import React from 'react'
import ReactDOM from 'react-dom'
import './index.css'
```

Now if you run npm start in the project folder and open http://localhost:3000 in the browser, you should see an empty tic-tac-toe field.

We recommend following these instructions to configure syntax highlighting for your editor.

Help, I'm Stuck!

If you get stuck, check out the community support resources. In particular, Reactiflux Chat is a great way to get help quickly. If you don't receive an answer, or if you remain stuck, please file an issue, and we'll help you out.

3『 [Where To Get Support – React](https://reactjs.org/community/support.html) 』

## 1.3 Overview

Now that you're set up, let's get an overview of React!

### 1.3.1 What Is React?

React is a declarative, efficient, and flexible JavaScript library for building user interfaces. It lets you compose complex UIs from small and isolated pieces of code called "components".

React has a few different kinds of components, but we'll start with React.Component subclasses:

```js
class ShoppingList extends React.Component {
  render() {
    return (
      <div className="shopping-list">
        <h1>Shopping List for {this.props.name}</h1>
        <ul>
          <li>Instagram</li>
          <li>WhatsApp</li>
          <li>Oculus</li>
        </ul>
      </div>
    );
  }
}

// Example usage: <ShoppingList name="Mark" />
```

We'll get to the funny XML-like tags soon. We use components to tell React what we want to see on the screen. When our data changes, React will efficiently update and re-render our components.

Here, ShoppingList is a React component class, or React component type. A component takes in parameters, called props (short for "properties"), and returns a hierarchy of views to display via the render method.

The render method returns a description of what you want to see on the screen. React takes the description and displays the result. In particular, render returns a React element, which is a lightweight description of what to render. Most React developers use a special syntax called "JSX" which makes these structures easier to write. The `<div />` syntax is transformed at build time to React.createElement('div'). The example above is equivalent to:

```js
return React.createElement('div', {className: 'shopping-list'},
  React.createElement('h1', /* ... h1 children ... */),
  React.createElement('ul', /* ... ul children ... */)
);
```

If you're curious, createElement() is described in more detail in the API reference, but we won't be using it in this tutorial. Instead, we will keep using JSX.

JSX comes with the full power of JavaScript. You can put any JavaScript expressions within braces inside JSX. Each React element is a JavaScript object that you can store in a variable or pass around in your program.

The ShoppingList component above only renders built-in DOM components like `<div />` and `<li />`. But you can compose and render custom React components too. For example, we can now refer to the whole shopping list by writing `<ShoppingList />`. Each React component is encapsulated and can operate independently; this allows you to build complex UIs from simple components.

React 是什么？React 是一个声明式，高效且灵活的用于构建用户界面的 JavaScript 库。使用 React 可以将一些简短、独立的代码片段组合成复杂的 UI 界面，这些代码片段被称作「组件」。React 中拥有多种不同类型的组件，我们先从 React.Component 的子类开始介绍：

我们马上会讨论这些又奇怪、又像 XML 的标签。我们通过使用组件来告诉 React 我们希望在屏幕上看到什么。当数据发生改变时，React 会高效地更新并重新渲染我们的组件。其中，ShoppingList 是一个 React 组件类，或者说是一个 React 组件类型。一个组件接收一些参数，我们把这些参数叫做 props（props 是 properties 简写），然后通过 render 方法返回需要展示在屏幕上的视图的层次结构。

render 方法的返回值描述了你希望在屏幕上看到的内容。React 根据描述，然后把结果展示出来。更具体地来说，render 返回了一个 React 元素，这是一种对渲染内容的轻量级描述。大多数的 React 开发者使用了一种名为 JSX 的特殊语法，JSX 可以让你更轻松地书写这些结构。语法 `<div />` 会被编译成 `React.createElement('div')`。上述的代码等同于：

如果你对这个比较感兴趣，可以查阅 API 文档了解有关 createElement() 更详细的用法。但在接下来的教程中，我们并不会直接使用这个方法，而是继续使用 JSX。在 JSX 中你可以任意使用 JavaScript 表达式，只需要用一个大括号把表达式括起来。每一个 React 元素事实上都是一个 JavaScript 对象，你可以在你的程序中把它当保存在变量中或者作为参数传递。

前文中的 ShoppingList 组件只会渲染一些内置的 DOM 组件，如 `<div />`、`<li />`等。但是你也可以组合和渲染自定义的 React 组件。例如，你可以通过 `<ShoppingList />` 来表示整个购物清单组件。每个组件都是封装好的，并且可以单独运行，这样你就可以通过组合简单的组件来构建复杂的 UI 界面。

### 1.3.2 Inspecting the Starter Code

If you're going to work on the tutorial in your browser, open this code in a new tab: Starter Code. If you're going to work on the tutorial locally, instead open src/index.js in your project folder (you have already touched this file during the setup).

This Starter Code is the base of what we're building. We've provided the CSS styling so that you only need to focus on learning React and programming the tic-tac-toe game.

By inspecting the code, you'll notice that we have three React components: 1) Square. 2) Board. 3) Game.

The Square component renders a single `<button>` and the Board renders 9 squares. The Game component renders a board with placeholder values which we'll modify later. There are currently no interactive components.

如果你要在浏览器中学习该教程，在新标签页中打开初始代码。如果你在本地环境中学习开发该教程的内容，就在你的工程文件夹下打开 src/index.js（你已经在前面的环境准备中创建过这个文件了）。这些初始代码是我们要开发的小游戏的基础代码。我们已经提供了 CSS 样式，这样你只需要关注使用 React 来开发这个井字棋了。

通过阅读代码，你可以看到我们有三个 React 组件：Square、Board、Game。Square 组件渲染了一个单独的 `<button>`。Board 组件渲染了 9 个方块。Game 组件渲染了含有默认值的一个棋盘，我们一会儿会修改这些值。到目前为止还没有可以交互的组件。

### 1.3.3 Passing Data Through Props

To get our feet wet, let's try passing some data from our Board component to our Square component. We strongly recommend typing code by hand as you're working through the tutorial and not using copy/paste. This will help you develop muscle memory and a stronger understanding.

In Board's renderSquare method, change the code to pass a prop called value to the Square:

```js
class Board extends React.Component {
  renderSquare(i) {
    return <Square value={i} />;
  }
}
```

Change Square's render method to show that value by replacing {/* TODO */} with {this.props.value}:

```js
class Square extends React.Component {
  render() {
    return (
      <button className="square">
        {this.props.value}
      </button>
    );
  }
}
```

Before:

After: You should see a number in each square in the rendered output.

Congratulations! You've just "passed a prop" from a parent Board component to a child Square component. Passing props is how information flows in React apps, from parents to children.

让我们试试水，尝试将数据从 Board 组件传递到 Square 组件中。我们强烈建议你动手编写本教程中的代码，不要使用复制/粘贴。这将加深你对 React 的记忆和理解。在 Board 组件的 renderSquare 方法中，我们将代码改写成下面这样，传递一个名为 value 的 prop 到 Square 当中：

### 1.3.4 Making an Interactive Component

Let's fill the Square component with an "X" when we click it. First, change the button tag that is returned from the Square component's render() function to this:

```js
class Square extends React.Component {
  render() {
    return (
      <button className="square" onClick={function() { alert('click'); }}>
        {this.props.value}
      </button>
    );
  }
}
```

If you click on a Square now, you should see an alert in your browser.

Note: To save typing and avoid the confusing behavior of this, we will use the arrow function syntax for event handlers here and further below:

3『

[Understanding JavaScript Function Invocation and "this"](https://yehudakatz.com/2011/08/11/understanding-javascript-function-invocation-and-this/)

[箭头函数 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

[Classes - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)

』

```js
class Square extends React.Component {
  render() {
    return (
      <button className="square" onClick={() => {alert('click')}}>
        {this.props.value}
      </button>
    )
  }
}
```

Notice how with onClick={() => alert('click')}, we're passing a function as the onClick prop. React will only call this function after a click. Forgetting () => and writing onClick={alert('click')} is a common mistake, and would fire the alert every time the component re-renders.

As a next step, we want the Square component to "remember" that it got clicked, and fill it with an "X" mark. To "remember" things, components use state.

React components can have state by setting this.state in their constructors. this.state should be considered as private to a React component that it's defined in. Let's store the current value of the Square in this.state, and change it when the Square is clicked.

First, we'll add a constructor to the class to initialize the state:

```js
class Square extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: null
    }
  }
  render() {
    return (
      <button className="square" onClick={() => {alert('click')}}>
        {this.props.value}
      </button>
    )
  }
}
```

Note: In JavaScript classes, you need to always call super when defining the constructor of a subclass. All React component classes that have a constructor should start with a super(props) call.

Now we'll change the Square's render method to display the current state's value when clicked:

1 Replace this.props.value with this.state.value inside the `<button>` tag. 

2 Replace the `onClick={...}` event handler with `onClick={() => this.setState({value: 'X'})}`. 

3 Put the className and onClick props on separate lines for better readability. After these changes, the `<button>` tag that is returned by the Square's render method looks like this:

```js
class Square extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: null
    }
  }
  render() {
    return (
      <button 
        className="square" 
        onClick={() => {this.setState({value: 'X'})}}
      >
        {this.state.value}
      </button>
    )
  }
}
```

By calling this.setState from an onClick handler in the Square's render method, we tell React to re-render that Square whenever its `<button>` is clicked. After the update, the Square's this.state.value will be 'X', so we'll see the X on the game board. If you click on any Square, an X should show up.

When you call setState in a component, React automatically updates the child components inside of it too.

接下来我们试着让棋盘的每一个格子在点击之后能落下一颗「X」作为棋子。 首先，我们把 Square 组件中 render() 方法的返回值中的 button 标签修改为如下内容：

如果此刻点击某个格子，浏览器会弹出提示框。

注意：为了少输入代码，同时为了避免 this 造成的困扰，我们在这里使用箭头函数 来进行事件处理，如下所示：

注意：此处使用了 `onClick={() => alert('click')} `的方式向 onClick 这个 prop 传入一个函数。 React 将在单击时调用此函数。但很多人经常忘记编写 `() =>`，而写成了 `onClick={alert('click')}`，这种常见的错误会导致每次这个组件渲染的时候都会触发弹出框。

接下来，我们希望 Square 组件可以「记住」它被点击过，然后用「X」来填充对应的方格。我们用 state 来实现所谓「记忆」的功能。可以通过在 React 组件的构造函数中设置 this.state 来初始化 state。this.state 应该被视为一个组件的私有属性。我们在 this.state 中存储当前每个方格（Square）的值，并且在每次方格被点击的时候改变这个值。

首先，我们向这个 class 中添加一个构造函数，用来初始化 state：

注意：在 JavaScript class 中，每次你定义其子类的构造函数时，都需要调用 super 方法。因此，在所有含有构造函数的的 React 组件中，构造函数必须以 `super(props)` 开头。现在，我们来修改一下 Square 组件的 render 方法，这样，每当方格被点击的时候，就可以显示当前 state 的值了：

1、在 `<button>` 标签中，把 this.props.value 替换为 this.state.value。

2、将 `onClick={...}` 事件监听函数替换为 `onClick={() => this.setState({value: 'X'})}`。

3、为了更好的可读性，将 className 和 onClick 的 prop 分两行书写。

4、修改之后，Square 组件中 render 方法的返回值中的 `<button>` 标签就变成了下面这样：

在 Square 组件 render 方法中的 onClick 事件监听函数中调用 this.setState，我们就可以在每次 `<button>` 被点击的时候通知 React 去重新渲染 Square 组件。组件更新之后，Square 组件的 this.state.value 的值会变为 'X'，因此，我们在游戏棋盘上就能看见 X 了。点击任意一个方格，X 就会出现了。

每次在组件中调用 setState 时，React 都会自动更新其子组件。

### 1.3.5 Developer Tools

The React Devtools extension for Chrome and Firefox lets you inspect a React component tree with your browser's developer tools.

The React DevTools let you check the props and the state of your React components.

After installing React DevTools, you can right-click on any element on the page, click "Inspect" to open the developer tools, and the React tabs ("⚛️ Components" and "⚛️ Profiler") will appear as the last tabs to the right. Use "⚛️ Components" to inspect the component tree.

However, note there are a few extra steps to get it working with CodePen:

1 Log in or register and confirm your email (required to prevent spam).

2 Click the "Fork" button.

3 Click "Change View" and then choose "Debug mode".

4 In the new tab that opens, the devtools should now have a React tab.

1『

先在 Chrome 商店安装「React Developer Tools」，接着发现测试环境跑的浏览器里，开发工具里显示不出来。查了下需要 `yarn build` 项目后才可以。build 之后，提示：

```
The project was built assuming it is hosted at /.
You can control this with the homepage field in your package.json.

The build folder is ready to be deployed.
You may serve it with a static server:

  yarn global add serve
  serve -s build
```

按上面的指示，先全局安装依赖，再跑起来后，进浏览器的开发者工具就正常显示了。奇怪的事，只要上面 build 操作过一次之后，后面用 `yarn start` 命令跑测试环境，开发者工具里也能正常显示了。而且最好跑测试环境，这样修改的地方马上能得到反馈。否者改完一下打包 build 一次，再跑，太麻烦了。（2021-04-29）

』

## 1.4 Completing the Game

We now have the basic building blocks for our tic-tac-toe game. To have a complete game, we now need to alternate placing "X"s and "O"s on the board, and we need a way to determine a winner.

### 1.4.1 Lifting State Up

Currently, each Square component maintains the game's state. To check for a winner, we'll maintain the value of each of the 9 squares in one location.

We may think that Board should just ask each Square for the Square's state. Although this approach is possible in React, we discourage it because the code becomes difficult to understand, susceptible to bugs, and hard to refactor. Instead, the best approach is to store the game's state in the parent Board component instead of in each Square. The Board component can tell each Square what to display by passing a prop, just like we did when we passed a number to each Square.

To collect data from multiple children, or to have two child components communicate with each other, you need to declare the shared state in their parent component instead. The parent component can pass the state back down to the children by using props; this keeps the child components in sync with each other and with the parent component.

Lifting state into a parent component is common when React components are refactored — let's take this opportunity to try it out.

Add a constructor to the Board and set the Board's initial state to contain an array of 9 nulls corresponding to the 9 squares:

```js
class Board extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      squares: Array(9).fill(null)
    }
  }
  renderSquare(i) {
    return <Square value={i} />
  }
```

When we fill the board in later, the this.state.squares array will look something like this:

```js
[
  'O', null, 'X',
  'X', 'X', 'O',
  'O', null, null,
]
```

The Board's renderSquare method currently looks like this:

```js
  renderSquare(i) {
    return <Square value={i} />
  }
```

In the beginning, we passed the value prop down from the Board to show numbers from 0 to 8 in every Square. In a different previous step, we replaced the numbers with an "X" mark determined by Square's own state. This is why Square currently ignores the value prop passed to it by the Board.

We will now use the prop passing mechanism again. We will modify the Board to instruct each individual Square about its current value ('X', 'O', or null). We have already defined the squares array in the Board's constructor, and we will modify the Board's renderSquare method to read from it:

```js
  renderSquare(i) {
    return <Square value={this.state.squares[i]} />
  }
```

Each Square will now receive a value prop that will either be 'X', 'O', or null for empty squares.

Next, we need to change what happens when a Square is clicked. The Board component now maintains which squares are filled. We need to create a way for the Square to update the Board's state. Since state is considered to be private to a component that defines it, we cannot update the Board's state directly from Square.

Instead, we'll pass down a function from the Board to the Square, and we'll have Square call that function when a square is clicked. We'll change the renderSquare method in Board to:

```js
  renderSquare(i) {
    return (
      <Square 
        value={this.state.squares[i]} 
        onClick={() => {this.handleClick(i)}}
      />
    )
  }
```

Note: We split the returned element into multiple lines for readability, and added parentheses so that JavaScript doesn't insert a semicolon after return and break our code.

Now we're passing down two props from Board to Square: value and onClick. The onClick prop is a function that Square can call when clicked. We'll make the following changes to Square:

1 Replace this.state.value with this.props.value in Square's render method

2 Replace this.setState() with this.props.onClick() in Square's render method

3 Delete the constructor from Square because Square no longer keeps track of the game's state

After these changes, the Square component looks like this:

```js
class Square extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: null
    }
  }
  render() {
    return (
      <button 
        className="square" 
        onClick={() => {this.props.onClick()}}
      >
        {this.props.value}
      </button>
    )
  }
}
```

When a Square is clicked, the onClick function provided by the Board is called. Here's a review of how this is achieved:

1 The onClick prop on the built-in DOM `<button>` component tells React to set up a click event listener.

2 When the button is clicked, React will call the onClick event handler that is defined in Square's render() method.

3 This event handler calls this.props.onClick(). The Square's onClick prop was specified by the Board.

4 Since the Board passed onClick={() => this.handleClick(i)} to Square, the Square calls this.handleClick(i) when clicked.

5 We have not defined the handleClick() method yet, so our code crashes. If you click a square now, you should see a red error screen saying something like "this.handleClick is not a function".

Note: The DOM `<button>` element's onClick attribute has a special meaning to React because it is a built-in component. For custom components like Square, the naming is up to you. We could give any name to the Square's onClick prop or Board's handleClick method, and the code would work the same. In React, it's conventional to use on[Event] names for props which represent events and handle[Event] for the methods which handle the events.

1-2『 react 里约定俗成的时间监听和事件处理函数命名原则，做一张信息数据卡片。（2021-04-29）』

When we try to click a Square, we should get an error because we haven't defined handleClick yet. We'll now add handleClick to the Board class:

```js
  handleClick(i) {
    const squares = this.state.squares.slice()
    squares[i] = 'X'
    this.setState({squares: squares})
  }
```

After these changes, we're again able to click on the Squares to fill them, the same as we had before. However, now the state is stored in the Board component instead of the individual Square components. When the Board's state changes, the Square components re-render automatically. Keeping the state of all squares in the Board component will allow it to determine the winner in the future.

Since the Square components no longer maintain state, the Square components receive values from the Board component and inform the Board component when they're clicked. In React terms, the Square components are now controlled components. The Board has full control over them.

Note how in handleClick, we call .slice() to create a copy of the squares array to modify instead of modifying the existing array. We will explain why we create a copy of the squares array in the next section.

当前，每个 Square 组件都维护了游戏的状态。我们可以把所有 9 个 Square 的值放在一个地方，这样我们就可以判断出胜者了。你可能会想，我们也可以在棋盘 Board 组件中收集每个格子 Square 组件中的 state。虽然技术上来讲是可以实现的，但是代码如此编写会让人很难理解，并且我们以后想要维护重构时也会非常困难。所以，最好的解决方式是直接将所有的 state 状态数据存储在 Board 父组件当中。之后 Board 组件可以将这些数据通过 props 传递给各个 Square 子组件，正如上文我们把数字传递给每一个 Square 一样。

当你遇到需要同时获取多个子组件数据，或者两个组件之间需要相互通讯的情况时，需要把子组件的 state 数据提升至其共同的父组件当中保存。之后父组件可以通过 props 将状态数据传递到子组件当中。这样应用当中所有组件的状态数据就能够更方便地同步共享了。像这种将组件的 state 提升到父组件的情形在重构 React 组件时经常会遇到 —— 借此我们来实践一下。

为 Board 组件添加构造函数，将 Board 组件的初始状态设置为长度为 9 的空值数组：

当我们填充棋盘后，this.state.squares 数组的值可能如下所示：

```js
[
  'O', null, 'X',
  'X', 'X', 'O',
  'O', null, null,
]
```

Board 组件当前的 renderSquare 方法看起来像下面这样：

开始时，我们依次使把 0 到 8 的值通过 prop 从 Board 向下传递，从而让它们显示出来。上一步与此不同，我们根据 Square 自己内部的 state，使用了 "X" 来代替之前的数字。因此，Square 忽略了当前从 Board 传递给它的那个 value prop。

让我们再一次使用 prop 的传递机制。我们通过修改 Board 来指示每一个 Square 的当前值（'X', 'O', 或者 null）。我们在 Board 的构造函数中已经定义好了 squares 数组，这样，我们就可以通过修改 Board 的 renderSquare 方法来读取这些值了。

```js
  renderSquare(i) {
    return <Square value={this.state.squares[i]} />
  }
```

这样，每个 Square 就都能接收到一个 value prop 了，这个 prop 的值可以是 'X'、 'O'、 或 null（null 代表空方格）。

接下来，我们要修改一下 Square 的点击事件监听函数。Board 组件当前维护了那些已经被填充了的方格。我们需要想办法让 Square 去更新 Board 的 state。由于 state 对于每个组件来说是私有的，因此我们不能直接通过 Square 来更新 Board 的 state。相反，从 Board 组件向 Square 组件传递一个函数，当 Square 被点击的时候，这个函数就会被调用。接着，我们将 Board 组件的 renderSquare 方法改写为如下效果：

注意：为了提高可读性，我们把返回的 React 元素拆分成了多行，同时在最外层加了小括号，这样 JavaScript 解析的时候就不会在 return 的后面自动插入一个分号从而破坏代码结构了。

现在我们从 Board 组件向 Square 组件中传递两个 props 参数：value 和 onClick。onClick prop 是一个 Square 组件点击事件监听函数。接下来，我们需要修改 Square 的代码：

1、将 Square 组件的 render 方法中的 this.state.value 替换为 this.props.value 。

2、将 Square 组件的 render 方法中的 this.setState() 替换为 this.props.onClick() 。

3、删掉 Square 组件中的构造函数 constructor，因为该组件不需要再保存游戏的 state。

4、进行上述修改之后，代码会变成下面这样:

每一个 Square 被点击时，Board 提供的 onClick 函数就会触发。我们回顾一下这是怎么实现的：

1、向 DOM 内置元素 `<button>` 添加 onClick prop，让 React 开启对点击事件的监听。

2、当 button 被点击时，React 会调用 Square 组件的 render() 方法中的 onClick 事件处理函数。

3、事件处理函数触发了传入其中的 this.props.onClick() 方法。这个方法是由 Board 传递给 Square 的。

4、由于 Board 把 `onClick={() => this.handleClick(i)}` 传递给了 Square，所以当 Square 中的事件处理函数触发时，其实就是触发的 Board 当中的 `this.handleClick(i)` 方法。

现在我们还尚未定义 `handleClick()` 方法，所以代码还不能正常工作。如果此时点击 Square，你会在屏幕上看到红色的错误提示，提示内容为：this.handleClick is not a function。

注意：因为 DOM 元素 `<button>` 是一个内置组件，因此其 onClick 属性在 React 中有特殊的含义。而对于用户自定义的组件来说，命名就可以由用户自己来定义了。我们给 Square 的 onClick 和 Board 的 handleClick 赋予任意的名称，代码依旧有效。在 React 中，有一个命名规范，通常会将代表事件的监听 prop 命名为 `on[Event]`，将处理事件的监听方法命名为 `handle[Event]` 这样的格式。

这时候我们点击 Square 的时候，浏览器会报错，因为我们还没有定义 handleClick 方法。我们现在来向 Board 里添加 handleClick 方法：

现在，我们可以通过点击 Square 来填充那些方格，效果与之前相同。但是，当前 state 没有保存在单个的 Square 组件中，而是保存在了 Board 组件中。每当 Board 的 state 发生变化的时候，这些 Square 组件都会重新渲染一次。把所有 Square 的 state 保存在 Board 组件中可以让我们在将来判断出游戏的胜者。

因为 Square 组件不再持有 state，因此每次它们被点击的时候，Square 组件就会从 Board 组件中接收值，并且通知 Board 组件。在 React 术语中，我们把目前的 Square 组件称做「受控组件」。在这种情况下，Board 组件完全控制了 Square 组件。

注意，我们调用了 `.slice()` 方法创建了 squares 数组的一个副本，而不是直接在现有的数组上进行修改。在下一节，我们会介绍为什么我们需要创建 square 数组的副本。

1『又一次体验到函数式编程范式里的「数据不变性」。（2021-04-29）』

### 1.4.2 Why Immutability Is Important

In the previous code example, we suggested that you use the .slice() method to create a copy of the squares array to modify instead of modifying the existing array. We'll now discuss immutability and why immutability is important to learn.

There are generally two approaches to changing data. The first approach is to mutate the data by directly changing the data's values. The second approach is to replace the data with a new copy which has the desired changes.

Data Change with Mutation

```js
var player = {score: 1, name: 'Jeff'};
player.score = 2;
// Now player is {score: 2, name: 'Jeff'}
```

Data Change without Mutation

```js
var player = {score: 1, name: 'Jeff'};

var newPlayer = Object.assign({}, player, {score: 2});
// Now player is unchanged, but newPlayer is {score: 2, name: 'Jeff'}

// Or if you are using object spread syntax proposal, you can write:
// var newPlayer = {...player, score: 2};
```

The end result is the same but by not mutating (or changing the underlying data) directly, we gain several benefits described below.

Complex Features Become Simple

Immutability makes complex features much easier to implement. Later in this tutorial, we will implement a "time travel" feature that allows us to review the tic-tac-toe game's history and "jump back" to previous moves. This functionality isn't specific to games — an ability to undo and redo certain actions is a common requirement in applications. Avoiding direct data mutation lets us keep previous versions of the game's history intact, and reuse them later.

Detecting Changes

Detecting changes in mutable objects is difficult because they are modified directly. This detection requires the mutable object to be compared to previous copies of itself and the entire object tree to be traversed.

Detecting changes in immutable objects is considerably easier. If the immutable object that is being referenced is different than the previous one, then the object has changed.

Determining When to Re-Render in React

The main benefit of immutability is that it helps you build pure components in React. Immutable data can easily determine if changes have been made, which helps to determine when a component requires re-rendering.

You can learn more about shouldComponentUpdate() and how you can build pure components by reading Optimizing Performance.

在上一节内容当中，我们建议使用 `.slice()` 函数对数组进行拷贝，而非直接修改现有的数组。接下来我们来学习不可变性以及不可变性的重要性。

一般来说，有两种改变数据的方式。第一种方式是直接修改变量的值，第二种方式是使用新的一份数据替换旧数据。不直接修改（或改变底层数据）这种方式和前一种方式的结果是一样的，这种方式有以下几点好处：

1、简化复杂的功能。不可变性使得复杂的特性更容易实现。在后面的章节里，我们会实现一种叫做「时间旅行」的功能。「时间旅行」可以使我们回顾井字棋的历史步骤，并且可以「跳回」之前的步骤。这个功能并不是只有游戏才会用到 —— 撤销和恢复功能在开发中是一个很常见的需求。不直接在数据上修改可以让我们追溯并复用游戏的历史记录。

2、跟踪数据的改变。如果直接修改数据，那么就很难跟踪到数据的改变。跟踪数据的改变需要可变对象可以与改变之前的版本进行对比，这样整个对象树都需要被遍历一次。跟踪不可变数据的变化相对来说就容易多了。如果发现对象变成了一个新对象，那么我们就可以说对象发生改变了。

3、确定在 React 中何时重新渲染。不可变性最主要的优势在于它可以帮助我们在 React 中创建 pure components。我们可以很轻松的确定不可变数据是否发生了改变，从而确定何时对组件进行重新渲染。

查阅性能优化章节，以了解更多有关 shouldComponentUpdate() 函数及如何构建 pure components 的内容。

### 1.4.3 Function Components

We'll now change the Square to be a function component.

In React, function components are a simpler way to write components that only contain a render method and don't have their own state. Instead of defining a class which extends React.Component, we can write a function that takes props as input and returns what should be rendered. Function components are less tedious to write than classes, and many components can be expressed this way.

Replace the Square class with this function:

```js
function Square(props) {
  return (
    <button className="square" onClick={props.onClick}>
      {props.value}
    </button>
  )
}
```

We have changed this.props to props both times it appears.

Note: When we modified the Square to be a function component, we also changed `onClick={() => this.props.onClick()}` to a shorter `onClick={props.onClick}` (note the lack of parentheses on both sides).

接下来我们把 Square 组件重写为一个函数组件。如果你想写的组件只包含一个 render 方法，并且不包含 state，那么使用函数组件就会更简单。我们不需要定义一个继承于 React.Component 的类，我们可以定义一个函数，这个函数接收 props 作为参数，然后返回需要渲染的元素。函数组件写起来并不像 class 组件那么繁琐，很多组件都可以使用函数组件来写。

把 Square 类替换成下面的函数：

我们把两个 this.props 都替换成了 props。

注意：当我们把 Square 修改成函数组件时，我们同时也把 `onClick={() => this.props.onClick()}` 改成了更短的 `onClick={props.onClick}`（注意两侧都没有括号）。

### 1.4.4 Taking Turns

We now need to fix an obvious defect in our tic-tac-toe game: the "O"s cannot be marked on the board.

We'll set the first move to be "X" by default. We can set this default by modifying the initial state in our Board constructor:

```js
  constructor(props) {
    super(props)
    this.state = {
      squares: Array(9).fill(null),
      xIsNext: true
    }
  }
```

Each time a player moves, xIsNext (a boolean) will be flipped to determine which player goes next and the game's state will be saved. We'll update the Board's handleClick function to flip the value of xIsNext:

```js
  handleClick(i) {
    const squares = this.state.squares.slice()
    squares[i] = this.state.xIsNext ? 'X' : 'O'
    this.setState({
      squares: squares,
      xIsNext: !this.state.xIsNext
    })
  }
```

With this change, "X"s and "O"s can take turns. Try it!

Let's also change the "status" text in Board's render so that it displays which player has the next turn:

```js
  render() {
    const status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O')

    return (
      // the rest has not changed
```

After applying these changes, you should have this Board component:

```js
class Board extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      squares: Array(9).fill(null),
      xIsNext: true
    }
  }

  handleClick(i) {
    const squares = this.state.squares.slice()
    squares[i] = this.state.xIsNext ? 'X' : 'O'
    this.setState({
      squares: squares,
      xIsNext: !this.state.xIsNext
    })
  }

  renderSquare(i) {
    return (
      <Square 
        value={this.state.squares[i]} 
        onClick={() => {this.handleClick(i)}}
      />
    )
  }

  render() {
    const status = 'Next player: X' + (this.state.xIsNext ? 'X' : 'O')
    return (
      <div>
        <div className="status">{status}</div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
        </div>
      </div>
    )
  }
}
```

现在井字棋还有一个明显的缺陷有待完善：目前还不能在棋盘上标记 “O”。我们将 “X” 默认设置为先手棋。你可以通过修改 Board 组件的构造函数中的初始 state 来设置默认的第一步棋子：

棋子每移动一步，xIsNext（布尔值）都会反转，该值将确定下一步轮到哪个玩家，并且游戏的状态会被保存下来。我们将通过修改 Board 组件的 handleClick 函数来反转 xIsNext 的值：

修改之后，我们就实现了 “X” 和 “O” 轮流落子的效果。尝试玩一下。

接下来修改 Board 组件 render 方法中 “status” 的值，这样就可以显示下一步是哪个玩家的了。

现在你整个的 Board 组件的代码应该是下面这样的：

### 1.4.5 Declaring a Winner

Now that we show which player's turn is next, we should also show when the game is won and there are no more turns to make. Copy this helper function and paste it at the end of the file:

```js
function calculateWinner(squares) {
  const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]
  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i]
    if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
      return squares[a]
    }
  }
  return null
}
```

Given an array of 9 squares, this function will check for a winner and return 'X', 'O', or null as appropriate.

We will call calculateWinner(squares) in the Board's render function to check if a player has won. If a player has won, we can display text such as "Winner: X" or "Winner: O". We'll replace the status declaration in Board's render function with this code:

```js
  render() {
    const winner = calculateWinner(this.state.squares)
    let status
    if (winner) status = 'winner: ' + winner
    else status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O')

    return (
      // the rest has not changed
```

We can now change the Board's handleClick function to return early by ignoring a click if someone has won the game or if a Square is already filled:

```js
  handleClick(i) {
    const squares = this.state.squares.slice()
    if (calculateWinner(squares) || squares[i]) return
    squares[i] = this.state.xIsNext ? 'X' : 'O'
    this.setState({
      squares: squares,
      xIsNext: !this.state.xIsNext
    })
  }
```

Congratulations! You now have a working tic-tac-toe game. And you've just learned the basics of React too. So you're probably the real winner here.

至此我们就可以看出下一步会轮到哪位玩家，与此同时，我们还需要显示游戏的结果来判定游戏结束。拷贝如下 calculateWinner 函数并粘贴到文件底部：

传入长度为 9 的数组，此函数将判断出获胜者，并根据情况返回 “X”，“O” 或 “null”。

接着，在 Board 组件的 render 方法中调用 calculateWinner(squares) 检查是否有玩家胜出。一旦有一方玩家胜出，就把获胜玩家的信息显示出来，比如，「胜者：X」或者「胜者：O」。现在，我们把 Board 的 render 函数中的 status 的定义修改为如下代码：

最后，修改 handleClick 事件，当有玩家胜出时，或者某个 Square 已经被填充时，该函数不做任何处理直接返回。

恭喜！现在你已经完成了井字棋！除此之外，你也已经掌握了 React 的基本常识。所以坚持到这一步的你才是真正的赢家呀！

## 1.5 Adding Time Travel

As a final exercise, let's make it possible to "go back in time" to the previous moves in the game.

### 1.5.1 Storing a History of Moves

If we mutated the squares array, implementing time travel would be very difficult.

However, we used slice() to create a new copy of the squares array after every move, and treated it as immutable. This will allow us to store every past version of the squares array, and navigate between the turns that have already happened.

We'll store the past squares arrays in another array called history. The history array represents all board states, from the first to the last move, and has a shape like this:

```js
history = [
  // Before first move
  {
    squares: [
      null, null, null,
      null, null, null,
      null, null, null,
    ]
  },
  // After first move
  {
    squares: [
      null, null, null,
      null, 'X', null,
      null, null, null,
    ]
  },
  // After second move
  {
    squares: [
      null, null, null,
      null, 'X', null,
      null, null, 'O',
    ]
  },
  // ...
]
```

Now we need to decide which component should own the history state.

如果我们直接修改了 square 数组，实现时间旅行就会变得很棘手了。不过，我们可以使用 slice() 函数为每一步创建 squares 数组的副本，同时把这个数组当作不可变对象。这样我们就可以把所有 squares 数组的历史版本都保存下来了，然后可以在历史的步骤中随意跳转。

我们把历史的 squares 数组保存在另一个名为 history 的数组中。history 数组保存了从第一步到最后一步的所有的棋盘状态。history 数组的结构如下所示：

现在，我们需要确定应该在哪一个组件里保存 history 这个 state。

### 1.5.2 Lifting State Up, Again

We'll want the top-level Game component to display a list of past moves. It will need access to the history to do that, so we will place the history state in the top-level Game component.

Placing the history state into the Game component lets us remove the squares state from its child Board component. Just like we "lifted state up" from the Square component into the Board component, we are now lifting it up from the Board into the top-level Game component. This gives the Game component full control over the Board's data, and lets it instruct the Board to render previous turns from the history.

First, we'll set up the initial state for the Game component within its constructor:

```js
class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      history: [{
        squares: Array(9).fill(null)
      }],
      xIsNext: true
    }
  }
  
  render() {
    return (
      <div className="game">
        <div className="game-board">
          <Board />
        </div>
        <div className="game-info">
          <div>{/* status */}</div>
          <ol>{/* TODO */}</ol>
        </div>
      </div>
    )
  }
}
```

Next, we'll have the Board component receive squares and onClick props from the Game component. Since we now have a single click handler in Board for many Squares, we'll need to pass the location of each Square into the onClick handler to indicate which Square was clicked. Here are the required steps to transform the Board component:

1 Delete the constructor in Board.

2 Replace this.state.squares[i] with this.props.squares[i] in Board's renderSquare.

3 Replace this.handleClick(i) with this.props.onClick(i) in Board's renderSquare.

The Board component now looks like this:

```js
  renderSquare(i) {
    return (
      <Square 
        value={this.props.squares[i]} 
        onClick={() => {this.props.onClick(i)}}
      />
    )
  }
```

We'll update the Game component's render function to use the most recent history entry to determine and display the game's status:

```js
class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      history: [{
        squares: Array(9).fill(null)
      }],
      xIsNext: true
    }
  }

  render() {
    const history = this.state.history
    const current = history[history.length -1]
    const winner = calculateWinner(current.squares)
    let status
    if (winner) status = 'winner: ' + winner
    else status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O')

    return (
      <div className="game">
        <div className="game-board">
          <Board 
            squares={current.squares}
            onClick={(i) => this.handleClick(i)}
          />
        </div>
        <div className="game-info">
          <div>{status}</div>
          <ol>{/* TODO */}</ol>
        </div>
      </div>
    )
  }
}
```

Since the Game component is now rendering the game's status, we can remove the corresponding code from the Board's render method. After refactoring, the Board's render function looks like this:

```js
class Board extends React.Component {
  renderSquare(i) {
    return (
      <Square 
        value={this.state.squares[i]} 
        onClick={() => {this.props.onClick(i)}}
      />
    )
  }

  render() {
    return (
      <div>
        <div className="status">{status}</div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
        </div>
      </div>
    )
  }
}
```

Finally, we need to move the handleClick method from the Board component to the Game component. We also need to modify handleClick because the Game component's state is structured differently. Within the Game's handleClick method, we concatenate new history entries onto history.

```js
  handleClick(i) {
    const history = this.state.history
    const current = history[history.length -1]
    const squares = current.squares.slice()
    if (calculateWinner(squares) || squares[i]) return
    squares[i] = this.state.xIsNext ? 'X' : 'O'
    this.setState({
      history: history.concat([{
        squares: squares,
      }]),
      xIsNext: !this.state.xIsNext
    })
  }
```

Note: Unlike the array push() method you might be more familiar with, the concat() method doesn't mutate the original array, so we prefer it.

At this point, the Board component only needs the renderSquare and render methods. The game's state and the handleClick method should be in the Game component.

我们希望顶层 Game 组件展示出一个历史步骤的列表。这个功能需要访问 history 的数据，因此我们把 history 这个 state 放在顶层 Game 组件中。

我们把 history state 放在了 Game 组件中，这样就可以从它的子组件 Board 里面删除掉 square 中的 state。正如我们把 Square 组件的状态提升到 Board 组件一样，现在我们来把 state 从 Board 组件提升到顶层的 Game 组件里。这样，Game 组件就拥有了对 Board 组件数据的完全控制权，除此之外，还可以让 Game 组件控制 Board 组件，并根据 history 渲染历史步骤。

首先，我们在 Game 组件的构造函数中初始化 state：

下一步，我们让 Board 组件从 Game 组件中接收 squares 和 onClick 这两个 props。因为当前在 Board 组件中已经有一个对 Square 点击事件的监听函数了，所以我们需要把每一个 Square 的对应位置传递给 onClick 监听函数，这样监听函数就知道具体哪一个 Square 被点击了。以下是修改 Board 组件的几个必要步骤：

1、删除 Board 组件中的 constructor 构造函数。

2、把 Board 组件的 renderSquare 中的 this.state.squares[i] 替换为 this.props.squares[i]。

3、把 Board 组件的 renderSquare 中的 this.handleClick(i) 替换为 this.props.onClick(i)。

修改后的 Board 组件如下所示：

接着，更新 Game 组件的 render 函数，使用最新一次历史记录来确定并展示游戏的状态：

由于 Game 组件渲染了游戏的状态，因此我们可以将 Board 组件 render 方法中对应的代码移除。修改之后，Board 组件的 render 函数如下所示：

最后，我们需要把 Board 组件的 handleClick 方法移动 Game 组件中。同时，我们也需要修改一下 handleClick 方法，因为这两个组件的 state 在结构上有所不同。在 Game 组件的 handleClick 方法中，我们需要把新的历史记录拼接到 history 上。

注意：concat() 方法可能与你比较熟悉的 push() 方法不太一样，它并不会改变原数组，所以我们推荐使用 concat()。

到目前为止，Board 组件只需要 renderSquare 和 render 这两个方法。而游戏的状态和 handleClick 方法则会放在 Game 组件当中。

### 1.5.3 Showing the Past Moves

Since we are recording the tic-tac-toe game's history, we can now display it to the player as a list of past moves.

We learned earlier that React elements are first-class JavaScript objects; we can pass them around in our applications. To render multiple items in React, we can use an array of React elements.

In JavaScript, arrays have a map() method that is commonly used for mapping data to other data, for example:

```js
const numbers = [1, 2, 3];
const doubled = numbers.map(x => x * 2); // [2, 4, 6]
```

Using the map method, we can map our history of moves to React elements representing buttons on the screen, and display a list of buttons to "jump" to past moves. Let's map over the history in the Game's render method:

```js
  render() {
    const history = this.state.history
    const current = history[history.length -1]
    const winner = calculateWinner(current.squares)

    const moves = history.map((step, move) => {
      const desc = move ?
        'Go to move #' + move :
        'Go to game start'
      return (
        <li>
          <button onClick={() => this.jumpTo(move)}>{desc}</button>
        </li>
      )
    })

    let status
    if (winner) status = 'winner: ' + winner
    else status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O')

    return (
      <div className="game">
        <div className="game-board">
          <Board 
            squares={current.squares}
            onClick={(i) => this.handleClick(i)}
          />
        </div>
        <div className="game-info">
          <div>{status}</div>
          <ol>{moves}</ol>
        </div>
      </div>
    )
  }
```

For each move in the tic-tac-toe game's history, we create a list item `<li> `which contains a button `<button>`. The button has a onClick handler which calls a method called this.jumpTo(). We haven't implemented the jumpTo() method yet. For now, we should see a list of the moves that have occurred in the game and a warning in the developer tools console that says:

Warning: Each child in an array or iterator should have a unique "key" prop. Check the render method of "Game".

Let's discuss what the above warning means.

由于我们已经记录了井字棋的历史记录，因此我们可以把这些记录以历史步骤列表的形式展示给玩家。

在前文中提到的 React 元素被视为 JavaScript 一等公民中的对象（first-class JavaScript objects），因此我们可以把 React 元素在应用程序中当作参数来传递。在 React 中，我们还可以使用 React 元素的数组来渲染多个元素。

在 JavaScript 中，数组拥有 map() 方法，该方法通常用于把某数组映射为另一个数组，例如：

我们可以通过使用 map 方法，把历史步骤映射为代表按钮的 React 元素，然后可以展示出一个按钮的列表，点击这些按钮，可以「跳转」到对应的历史步骤。

现在，我们在 Game 组件的 render 方法中调用 history 的 map 方法：

对于井字棋历史记录的每一步，我们都创建出了一个包含按钮 `<button>` 元素的 `<li>` 的列表。这些按钮拥有一个 onClick 事件处理函数，在这个函数里调用了 `this.jumpTo()` 方法。但是我们还没有实现 `jumpTo()` 方法。到目前为止，我们可以看到一个游戏历史步骤的列表，以及开发者工具控制台的警告信息，警告信息如下：

```
Warning: Each child in an array or iterator should have a unique "key" prop. Check the render method of "Game".
```

我们来看一下上面的警告信息是什么意思。

### 1.5.4 Picking a Key

When we render a list, React stores some information about each rendered list item. When we update a list, React needs to determine what has changed. We could have added, removed, re-arranged, or updated the list's items.

Imagine transitioning from

```htmk
<li>Alexa: 7 tasks left</li>
<li>Ben: 5 tasks left</li>
```

to

```html
<li>Ben: 9 tasks left</li>
<li>Claudia: 8 tasks left</li>
<li>Alexa: 5 tasks left</li>
```

In addition to the updated counts, a human reading this would probably say that we swapped Alexa and Ben's ordering and inserted Claudia between Alexa and Ben. However, React is a computer program and does not know what we intended. Because React cannot know our intentions, we need to specify a key property for each list item to differentiate each list item from its siblings. One option would be to use the strings alexa, ben, claudia. If we were displaying data from a database, Alexa, Ben, and Claudia's database IDs could be used as keys.

```html
<li key={user.id}>{user.name}: {user.taskCount} tasks left</li>
```

When a list is re-rendered, React takes each list item's key and searches the previous list's items for a matching key. If the current list has a key that didn't exist before, React creates a component. If the current list is missing a key that existed in the previous list, React destroys the previous component. If two keys match, the corresponding component is moved. Keys tell React about the identity of each component which allows React to maintain state between re-renders. If a component's key changes, the component will be destroyed and re-created with a new state.

key is a special and reserved property in React (along with ref, a more advanced feature). When an element is created, React extracts the key property and stores the key directly on the returned element. Even though key may look like it belongs in props, key cannot be referenced using this.props.key. React automatically uses key to decide which components to update. A component cannot inquire about its key.

It's strongly recommended that you assign proper keys whenever you build dynamic lists. If you don't have an appropriate key, you may want to consider restructuring your data so that you do.

If no key is specified, React will present a warning and use the array index as a key by default. Using the array index as a key is problematic when trying to re-order a list's items or inserting/removing list items. Explicitly passing key={i} silences the warning but has the same problems as array indices and is not recommended in most cases.

Keys do not need to be globally unique; they only need to be unique between components and their siblings.

当我们需要渲染一个列表的时候，React 会存储这个列表每一项的相关信息。当我们要更新这个列表时，React 需要确定哪些项发生了改变。我们有可能增加、删除、重新排序或者更新列表项。

想象一下把下面的代码：

转换成下面的代码：

除了数字发生了改变之外，阅读这段代码的人也许会认为我们把 Alexa 和 Ben 的顺序交换了位置，然后把 Claudia 插入到 Alexa 和 Ben 之间。然而，React 是电脑程序，它并不知道我们想要什么。因为 React 无法得知我们人类的意图，所以我们需要给每一个列表项一个确定的 key 属性，它可以用来区分不同的列表项和他们的同级兄弟列表项。你可以使用字符串，比如 alexa、ben、claudia。如果我们使用从数据库里获取的数据，那么 Alexa、Ben 和 Claudia 的数据库 ID 就可以作为 key 来使用。

每当一个列表重新渲染时，React 会根据每一项列表元素的 key 来检索上一次渲染时与每个 key 所匹配的列表项。如果 React 发现当前的列表有一个之前不存在的 key，那么就会创建出一个新的组件。如果 React 发现和之前对比少了一个 key，那么就会销毁之前对应的组件。如果一个组件的 key 发生了变化，这个组件会被销毁，然后使用新的 state 重新创建一份。

key 是 React 中一个特殊的保留属性（还有一个是 ref，拥有更高级的特性）。当 React 元素被创建出来的时候，React 会提取出 key 属性，然后把 key 直接存储在返回的元素上。虽然 key 看起来好像是 props 中的一个，但是你不能通过 this.props.key 来获取 key。React 会通过 key 来自动判断哪些组件需要更新。组件是不能访问到它的 key 的。

我们强烈推荐，每次只要你构建动态列表的时候，都要指定一个合适的 key。如果你没有找到一个合适的 key，那么你就需要考虑重新整理你的数据结构了，这样才能有合适的 key。

如果你没有指定任何 key，React 会发出警告，并且会把数组的索引当作默认的 key。但是如果想要对列表进行重新排序、新增、删除操作时，把数组索引作为 key 是有问题的。显式地使用 `key={i}` 来指定 key 确实会消除警告，但是仍然和数组索引存在同样的问题，所以大多数情况下最好不要这么做。

组件的 key 值并不需要在全局都保证唯一，只需要在当前的同一级元素之前保证唯一即可。

### 1.5.5 Implementing Time Travel

In the tic-tac-toe game's history, each past move has a unique ID associated with it: it's the sequential number of the move. The moves are never re-ordered, deleted, or inserted in the middle, so it's safe to use the move index as a key.

In the Game component's render method, we can add the key as <li key={move}> and React's warning about keys should disappear:

```js
    const moves = history.map((step, move) => {
      const desc = move ?
        'Go to move #' + move :
        'Go to game start'
      return (
        <li key={move}>
          <button onClick={() => this.jumpTo(move)}>{desc}</button>
        </li>
      )
    })
```

Clicking any of the list item's buttons throws an error because the jumpTo method is undefined. Before we implement jumpTo, we'll add stepNumber to the Game component's state to indicate which step we're currently viewing.

First, add stepNumber: 0 to the initial state in Game's constructor:

```js
  constructor(props) {
    super(props)
    this.state = {
      history: [{
        squares: Array(9).fill(null)
      }],
      stepNumber: 0,
      xIsNext: true
    }
  }
```

Next, we'll define the jumpTo method in Game to update that stepNumber. We also set xIsNext to true if the number that we're changing stepNumber to is even:

```js
  handleClick(i) {
    // this method has not changed
  }

  jumpTo(step) {
    this.setState({
      stepNumber: step,
      xIsNext: (step % 2) === 0
    })
  }
  
  render() {
    // this method has not changed
  }
```

We will now make a few changes to the Game's handleClick method which fires when you click on a square.

The stepNumber state we've added reflects the move displayed to the user now. After we make a new move, we need to update stepNumber by adding stepNumber: history.length as part of the this.setState argument. This ensures we don't get stuck showing the same move after a new one has been made.

We will also replace reading this.state.history with this.state.history.slice(0, this.state.stepNumber + 1). This ensures that if we "go back in time" and then make a new move from that point, we throw away all the "future" history that would now become incorrect.

```js
  handleClick(i) {
    const history = this.state.history.slice(0, this.state.stepNumber + 1)
    const current = history[history.length -1]
    const squares = current.squares.slice()
    if (calculateWinner(squares) || squares[i]) return
    squares[i] = this.state.xIsNext ? 'X' : 'O'
    this.setState({
      history: history.concat([{
        squares: squares,
      }]),
      stepNumber: history.length,
      xIsNext: !this.state.xIsNext
    })
  }
```

Finally, we will modify the Game component's render method from always rendering the last move to rendering the currently selected move according to stepNumber:

```js
  render() {
    const history = this.state.history
    const current = history[this.state.stepNumber]
    const winner = calculateWinner(current.squares)

    // the rest has not changed
```

If we click on any step in the game's history, the tic-tac-toe board should immediately update to show what the board looked like after that step occurred.

在井字棋的历史记录中，每一个历史步骤都有一个与之对应的唯一 ID：这个 ID 就是每一步棋的序号。因为历史步骤不需要重新排序、新增、删除，所以使用步骤的索引作为 key 是安全的。

在 Game 组件的 render 方法中，我们可以这样添加 key，`<li key={move}>`，这样关于 key 的警告就会消失了。

因为 jumpTo 还未定义，所以你点击列表项的按钮时，会出现报错。在我们实现 jumpTo 之前，我们向 Game 组件的 state 中添加 stepNumber，这个值代表我们当前正在查看哪一项历史记录。

首先，我们在 Game 的构造函数 constructor 中向初始 state 中添加 stepNumber: 0：

然后，我们在 Game 组件中定义 jumpTo 方法以更新状态 stepNumber。除此之外，当状态 stepNumber 是偶数时，我们还要把 xIsNext 设为 true：

接下来，我们还要修改 Game 组件的 handleClick 方法，当你点击方格的时候触发该方法。新添加的 stepNumber state 用于给用户展示当前的步骤。每当我们落下一颗新棋子的时候，我们需要调用 this.setState 并传入参数 stepNumber: history.length，以更新 stepNumber。这就保证了保证每走一步 stepNumber 会跟着改变。

我们还把读取 this.state.history 换成了读取 `this.state.history.slice(0, this.state.stepNumber + 1)` 的值。如果我们「回到过去」，然后再走一步新棋子，原来的「未来」历史记录就不正确了，这个替换可以保证我们把这些「未来」的不正确的历史记录丢弃掉。

最后，修改 Game 组件的 render 方法，将代码从始终根据最后一次移动渲染修改为根据当前 stepNumber 渲染。

如果我们点击游戏历史记录的任何一步，井字棋的棋盘就会立即更新为刚走那一步棋时候的样子。

### 1.5.6 Wrapping Up

Congratulations! You've created a tic-tac-toe game that:

1 Lets you play tic-tac-toe,

2 Indicates when a player has won the game,

3 Stores a game's history as a game progresses,

4 Allows players to review a game's history and see previous versions of a game's board.

Nice work! We hope you now feel like you have a decent grasp of how React works. Check out the final result here: Final Result.

If you have extra time or want to practice your new React skills, here are some ideas for improvements that you could make to the tic-tac-toe game which are listed in order of increasing difficulty:

1 Display the location for each move in the format (col, row) in the move history list.

2 Bold the currently selected item in the move list.

3 Rewrite Board to use two loops to make the squares instead of hardcoding them.

4 Add a toggle button that lets you sort the moves in either ascending or descending order.

5 When someone wins, highlight the three squares that caused the win.

6 When no one wins, display a message about the result being a draw.

Throughout this tutorial, we touched on React concepts including elements, components, props, and state. For a more detailed explanation of each of these topics, check out the rest of the documentation. To learn more about defining components, check out the React.Component API reference.

3『

[Hello World – React](https://zh-hans.reactjs.org/docs/hello-world.html)

[React.Component – React](https://zh-hans.reactjs.org/docs/react-component.html)

』

恭喜你！你已经完成了一个拥有以下功能的井字棋啦：

1、tic-tac-toe（三连棋）游戏的所有功能。

2、能够判定玩家何时获胜。

3、能够记录游戏进程。

4、允许玩家查看游戏的历史记录，也可以查看任意一个历史版本的游戏棋盘状态。

干的不错！我们希望你至此已经基本掌握了 React 的使用。如果你还有充裕的时间，或者想练习一下刚刚学会的 React 新技能，这里有一些可以改进游戏的想法供你参考，这些功能的实现顺序的难度是递增的：

1、在游戏历史记录列表显示每一步棋的坐标，格式为（列号、行号）。

2、在历史记录列表中加粗显示当前选择的项目。

3、使用两个循环来渲染出棋盘的格子，而不是在代码里写死（hardcode）。

4、添加一个可以升序或降序显示历史记录的按钮。

5、每当有人获胜时，高亮显示连成一线的 3 颗棋子。

6、当无人获胜时，显示一个平局的消息。

通过这篇教程，我们接触了 React 中的一些概念，比如 React 元素、React 组件、props，还有 state。更多关于这些概念的细节的解释，参考文档的其他部分。了解更多关于组件定义的内容，参考React.Component API reference。