# 0205. 通过 Axios 库构建 API 请求

2020 年

[nonfu/roastapp: Laravel学院 Roast 应用源码](https://github.com/nonfu/roastapp)

[通过 Axios 库构建 API 请求 | 学院君](https://xueyuanjun.com/post/9508.html)

在上一篇教程中，我们在 Laravel 后端定义好了 API 接口，在本篇教程中，我们将通过 JavaScript 构建 API 请求来访问那些后端 API。由于我们已经配置好了 Vue 和前端路由，构建这些请求应该非常顺利，并且我们还可以通过 Vuex 模块来保存数据。

第一步：配置 config.js 文件
和 .env 类似，config.js 对多环境前端开发来说非常重要，我将所有的 JavaScript 环境配置信息都放在了这个文件中。目前只需要配置一个变量用于标识不同环境下 API URL 的前缀 —— api_url，在我的开发环境中，配置的域名是 roast.test，而在生产环境中域名是 roast.demo.laravelacademy.org，每当构建应用时，我希望 Node 都能基于不同环境调用正确的 API 路由，所以在 resources/assets/js/config.js 文件中，我使用了一个简单的 switch 语句基于不同环境设置相应的 api_url，然后将配置导出：

1
/**
2
 * Defines the API route we are using.
3
 */
4
var api_url = '';
5
​
6
switch( process.env.NODE_ENV ){
7
    case 'development':
8
        api_url = 'http://roast.test/api/v1';
9
        break;
10
    case 'production':
11
        api_url = 'http://roast.demo.laravelacademy.org/api/v1';
12
        break;
13
}
14
​
15
export const ROAST_CONFIG = {
16
    API_URL: api_url,
17
}
我们可以以对象形式导出任何需要的变量以便在应用的其它地方使用，比如下一章节定义 API 路由的地方。

第二步：新增 cafe.js 文件
我喜欢用 JavaScript 中的资源来模仿 API 结构，这样就可以通过资源对 API 路由进行分组。为此首先需要在 resources/assets/js/api 目录下新增 cafe.js 文件。然后需要在该文件中引入上一步导出的 ROAST_CONFIG，以便获取 API_URL 来发起请求：

1
/**
2
 * Imports the Roast API URL from the config.
3
 */
4
import { ROAST_CONFIG } from '../config.js';
接下来我们需要导出一个默认模块以便可以在应用的其它任何地方使用 API 请求，最终我们的 cafe.js 文件内容如下：

1
/**
2
 * Imports the Roast API URL from the config.
3
 */
4
import { ROAST_CONFIG } from '../config.js';
5
​
6
export default {
7
    
8
}
第三步：发起请求获取咖啡店列表
现在我们需要在上述导出默认模块代码中添加一个方法来获取所有咖啡店，该方法会访问 Laravel 后端的 /api/v1/cafes 路由。在所有前端请求中，我们都将使用之前安装配置过的 Axios 库。要新增访问咖啡店列表的请求，需要在默认模块中插入如下代码：

1
export default {
2
    /**
3
     * GET /api/v1/cafes
4
     */
5
    getCafes: function(){
6
        return axios.get( ROAST_CONFIG.API_URL + '/cafes' );
7
    },
8
}
该操作会对传入的路由发起 GET 请求，在 Vuex 中我们会以动作的方式调用这个 API 请求并将数据保存到构建的模块中。

第四步：发起请求获取单个咖啡店信息
和上一个请求类似，我们在 cafe.js 导出模块中新增一个获取单个咖啡店信息的方法，不同之处在于这次请求的路由是 /api/v1/cafes/{cafeID}，cafeID 会以参数的方式传入：

1
/**
2
 * GET /api/v1/cafes/{cafeID}
3
 */
4
getCafe: function( cafeID ){
5
    return axios.get( ROAST_CONFIG.API_URL + '/cafes/' + cafeID );
6
}
该方法会返回通过 cafeID 指定的咖啡店信息。

第五步：发起请求新增一个咖啡店
构建 Axios 请求的思路都是一致的，这一次需要构建的是一个 POST 请求，所以需要更多参数，再次强调我们将会在下一篇教程中通过 Vuex 来调用这些请求：

1
/**
2
 * POST /api/v1/cafes
3
 */
4
postAddNewCafe: function( name, address, city, state, zip ){
5
    return axios.post( ROAST_CONFIG.API_URL + '/cafes',
6
        {
7
            name: name,
8
            address: address,
9
            city: city,
10
            state: state,
11
            zip: zip
12
        }
13
    );
14
}
该方法传入的参数需要和用于新增咖啡店的 /api/v1/cafes 路由（POST）接收参数相匹配。

小结
至此，我们已经在 resources/assets/js/api/cafe.js 文件中添加了所有请求动作，cafe.js 代码最终版本如下：

1
/**
2
 * Imports the Roast API URL from the config.
3
 */
4
import { ROAST_CONFIG } from '../config.js';
5
​
6
export default {
7
    /**
8
     * GET /api/v1/cafes
9
     */
10
    getCafes: function(){
11
        return axios.get( ROAST_CONFIG.API_URL + '/cafes' );
12
    },
13
    /**
14
     * GET /api/v1/cafes/{cafeID}
15
     */
16
    getCafe: function( cafeID ){
17
        return axios.get( ROAST_CONFIG.API_URL + '/cafes/' + cafeID );
18
    },
19
    /**
20
     * POST /api/v1/cafes
21
     */
22
    postAddNewCafe: function( name, address, city, state, zip ){
23
        return axios.post( ROAST_CONFIG.API_URL + '/cafes',
24
            {
25
                name: name,
26
                address: address,
27
                city: city,
28
                state: state,
29
                zip: zip
30
            }
31
        );
32
    }
33
}
我们返回的是 Axios 请求以便可以监听并在 Vuex 动作中执行，听起来很复杂，不过在下一篇教程中你就可以看到这些东西如何优雅地组合到一起，这将会跟踪应用前端所需的所有数据，并按需轻松加载所有这些数据，此外，我们还可以处理错误或成功状态。

项目源码位于 Github 上：nonfu/roastapp。

Laravel
 
API
 
Roast
 
路由
 
请求
 
JavaScript
 
Vue
 
前端
 
Axios

 
上一篇: 实现 Laravel 后端 API 接口

下一篇: 构建 Vuex 模块

分享到以下平台：
相关推荐：
引入 Vue 2、Vue Router 和 Vuex
基于 Laravel + Vue 构建前后端分离应用  JavaScript 初始化
通过 Vue Router 配置前端路由
基于 Laravel + Vue 构建前后端分离应用  JavaScript 初始化
通过 Vue 组件、Vue Router、Vuex 和 Laravel 实现表单提交
基于 Laravel + Vue 构建前后端分离应用  Vuex & Vue Router 使用入门：表单提交
通过 Vue + 高德地图 JS API 在地图上标记咖啡店
基于 Laravel + Vue 构建前后端分离应用  在地图上标记咖啡店
咖啡店标签前端输入及显示功能实现
基于 Laravel + Vue 构建前后端分离应用  添加喜欢、标签功能
8 条评论
#1    Mr_White_DT   Mr_White_DT 评论于 1年前
学院君，设置laravel的不同环境（生产、线上这些）是在.env文件中，process.env.NODE_ENV这个要在哪里设置啊

#2    学院君   学院君 评论于 1年前
回复 #1
不需要你配置 根据编译资源时运行的是 npm run dev 还是 npm run prod 来区分

#3    Mr_White_DT   Mr_White_DT 评论于 1年前
回复 #2
学到了，谢谢学院君

#4    Marc Yin   Marc Yin 评论于 1年前
感谢站长的教程！正好工作需要

#5    aracta   aracta 评论于 5个月前
第一步配置config.js的路径错误：resources/assets/config.js，应为resources/assets/js/config.js

#6    学院君   学院君 评论于 5个月前
回复 #5
嗯 是的 漏了这个目录

#7    dzkjz   dzkjz 评论于 2周前
教程和 https://serversideup.net/courses/api-driven-development-laravel-vuejs/ 有异曲同工之妙

#8    学院君   学院君 评论于 2周前
回复 #7
是的 我是基于这个项目进行汉化的 在目录索引页已经声明了 我的目标是通过通俗的教程让大家以最低成本学会这个东西 不追求100%原创 就好比老师交给你的东西 不可能都是他自己写的一样