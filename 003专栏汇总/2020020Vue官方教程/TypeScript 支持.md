TypeScript 支持

文档视频教程帮助工具核心插件信息
          
          教程
          
            
          
        基础深入了解组件过渡 & 动画可复用性 & 组合工具规模化内在迁移更多Vue CLI 提供了内建的 TypeScript 工具支持。发布为 NPM 包的官方声明文件静态类型系统能帮助你有效防止许多潜在的运行时错误，而且随着你的应用日渐丰满会更加显著。这就是为什么 Vue 不仅仅为 Vue core 提供了针对 TypeScript 的官方类型声明，还为 Vue Router 和 Vuex 也提供了相应的声明文件。而且，我们已经把它们发布到了 NPM，最新版本的 TypeScript 也知道该如何自己从 NPM 包里解析类型声明。这意味着只要你成功地通过 NPM 安装了，就不再需要任何额外的工具辅助，即可在 Vue 中使用 TypeScript 了。推荐配置注意你需要引入 strict: true（或者至少 noImplicitThis: true，这是 strict 模式的一部分）以利用组件方法中 this 的类型检查，否则它会始终被看作 any 类型。参阅 TypeScript 编译器选项文档（英）了解更多。开发工具链工程创建Vue CLI 3 可以使用 TypeScript 生成新工程。创建方式：编辑器支持要使用 TypeScript 开发 Vue 应用程序，我们强烈建议您使用 Visual Studio Code，它为 TypeScript 提供了极好的「开箱即用」支持。如果你正在使用单文件组件（SFC)，可以安装提供 SFC 支持以及其他更多实用功能的 Vetur 插件。WebStorm 同样为 TypeScript 和 Vue 提供了「开箱即用」的支持。基本用法要让 TypeScript 正确推断 Vue 组件选项中的类型，您需要使用 Vue.component 或 Vue.extend 定义组件：基于类的 Vue 组件如果您在声明组件时更喜欢基于类的 API，则可以使用官方维护的 vue-class-component 装饰器：增强类型以配合插件使用插件可以增加 Vue 的全局/实例属性和组件选项。在这些情况下，在 TypeScript 中制作插件需要类型声明。庆幸的是，TypeScript 有一个特性来补充现有的类型，叫做模块补充（module augmentation)。例如，声明一个 string 类型的实例属性 $myProperty：在你的项目中包含了上述作为声明文件的代码之后（像 my-property.d.ts)，你就可以在 Vue 实例上使用 $myProperty 了。你也可以声明额外的属性和组件选项：上述的声明允许下面的代码顺利编译通过：标注返回值因为 Vue 的声明文件天生就具有循环性，TypeScript 可能在推断某个方法的类型的时候存在困难。因此，你可能需要在 render 或 computed 里的方法上标注返回值。如果你发现类型推导或成员补齐不工作了，标注某个方法也许可以帮助你解决这个问题。使用 --noImplicitAny 选项将会帮助你找到这些未标注的方法。