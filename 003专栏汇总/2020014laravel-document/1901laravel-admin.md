## 01. 安装

[z-song/laravel-admin: Build a full-featured administrative interface in ten minutes](https://github.com/z-song/laravel-admin)

[首页 | Laravel-admin](https://laravel-admin.org/)

[文档 | Laravel-admin](https://laravel-admin.org/docs/zh)

[Laravel Development Guide, Setting up Laravel on Mac OS with XAMPP](https://medium.com/@sunilk/laravel-development-guide-setting-up-laravel-on-mac-os-with-xampp-f6d18bb2b55d)

[Installation - Laravel - The PHP Framework For Web Artisans](https://laravel.com/docs/5.8/installation)

[快速上手 | laravel-admin-api](http://laravel-admin-api.plasr.cn/shangshou.html#_3-%E7%B3%BB%E7%BB%9F%E7%AE%A1%E7%90%86%E5%91%98%E9%AA%8C%E8%AF%81)

### 1. 安装 Composer

戴强推荐的链接：[简介 | Composer 中文文档 | Composer 中文网](https://docs.phpcomposer.com/00-intro.html)

Composer 是 php 包管理工具，可以类比 node.js 的包管理工具 npm，Laravel 可以依赖 Composer 进行安装，所以安装 Laravel 之前先安装好 Composer。运行 Composer 需要 PHP 5.3.2+ 以上版本，但是很多 php 包现在都要求 7.x 以上版本了，所以建议系统升级 php 版本为 7.2。

可以通过 brew 来安装：

    brew install composer

安装 cask 的参考命令：

brew cask install sequel-pro

brew install homebrew/cask-versions/sequel-pro-nightly

cask 是安装图形界面软件的命令，Homebrew cask。

### 2. 安装 Laravel

使用如下命令安装 Laravel：

    composer global require "laravel/installer"

报错：

```
  Problem 1
    - laravel/installer v3.0.1 requires ext-zip * -> the requested PHP extension zip is missing from your system.
    - laravel/installer v3.0.0 requires ext-zip * -> the requested PHP extension zip is missing from your system.
    - Installation request for laravel/installer ^3.0 -> satisfiable by laravel/installer[v3.0.0, v3.0.1].
```

用 brew 再安装一次 php：

brew install php@7.3

安装后显示：

```
==> php@7.3
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php7_module /usr/local/opt/php@7.3/lib/httpd/modules/libphp7.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /usr/local/etc/php/7.3/

php@7.3 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have php@7.3 first in your PATH run:
  echo 'export PATH="/usr/local/opt/php@7.3/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/php@7.3/sbin:$PATH"' >> ~/.zshrc

For compilers to find php@7.3 you may need to set:
  export LDFLAGS="-L/usr/local/opt/php@7.3/lib"
  export CPPFLAGS="-I/usr/local/opt/php@7.3/include"


To have launchd start php@7.3 now and restart at login:
  brew services start php@7.3
Or, if you don't want/need a background service you can just run:
  php-fpm
```

安装后还是没有解决问题。stack 上找到了解决方案。[php - install ext-zip for Mac - Stack Overflow](https://stackoverflow.com/questions/58290566/install-ext-zip-for-mac)

首先：

    brew link php@7.3 --force

然后设置全局变量（之前设置的路径弄错了，也可能不需要上面的 link 命令，没验证过）：

```
echo 'export PATH="/usr/local/opt/php@7.3/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/php@7.3/sbin:$PATH"' >> ~/.zshrc
```

重新加载 zshrc。

    source ~/.zshrc

验证下 mac 里的 php 是否改成了 brew 安装的 php@7.3 了，输入命令：pho -v 来看版本，现在的版本是 7.3.15，之前 mac 自带的是 7.3.11。另外命令 php -m 可以查看所有的包（modules）。

再重新安装即可：

    composer global require "laravel/installer"

由于接下来的命令是直接使用 laravel 命令新建一个项目试试（laravel new demoweb），发现找不到命令。所以需要将 laravel 的路径写进全局环境变量中。

    echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.zshrc

### 3. 新建项目

进 laravel 新建一个项目：

    composer create-project laravel/laravel readnote

也可以用下面的命令：

    composer create-project --prefer-dist laravel/laravel readnote

发现报错：

```
Content-Length mismatch, received 13855 bytes out of the expected 1491897
http://repo.packagist.org could not be fully loaded, package information was loaded from the local cache and may be out of date
```

结果找到一个方案是修改配置文件「.composer.json」。原来的文件内心如下：

```
{
    "require": {
        "laravel/installer": "^3.0"
        }
}
```

修改为下面的：[How to fix composer error "Content-Length Mismatch"](https://gist.github.com/oanhnn/112f68e5b91a7dac7641bcd8b0ab13ac)

```
{
    "require": {
        "laravel/installer": "^3.0"
        },

    "config": {
        "github-protocols": ["https,ssh"]
        },

    "repositories": {
        "packagist": {
            "type": "composer",
            "url": "https://packagist.org"
        }
    }
}
```
    
结果发现还是解决不了，接着找到的解释是国外镜像速度太慢。[Packagist / Composer 中国全量镜像](https://pkg.phpcomposer.com/)

有两种方式启用本镜像服务：1）系统全局配置： 即将配置信息添加到 Composer 的全局配置文件 config.json 中。见「方法一」。2）单个项目配置： 将配置信息添加到某个项目的 composer.json 文件中。见「方法二」。

方法一： 修改 composer 的全局配置文件（推荐方式）。打开命令行窗口（windows 用户）或控制台（Linux、Mac 用户）并执行如下命令：

    composer config -g repo.packagist composer https://packagist.phpcomposer.com

方法二： 修改当前项目的 composer.json 配置文件：

打开命令行窗口（windows 用户）或控制台（Linux、Mac 用户），进入你的项目的根目录（也就是 composer.json 文件所在目录），执行如下命令：

    composer config repo.packagist composer https://packagist.phpcomposer.com

上述命令将会在当前项目中的 composer.json 文件的末尾自动添加镜像的配置信息（你也可以自己手工添加）：

```
"repositories": {
    "packagist": {
        "type": "composer",
        "url": "https://packagist.phpcomposer.com"
    }
}
```

以 laravel 项目的 composer.json 配置文件为例，执行上述命令后如下所示（注意最后几行）：

```
{
    "name": "laravel/laravel",
    "description": "The Laravel Framework.",
    "keywords": ["framework", "laravel"],
    "license": "MIT",
    "type": "project",
    "require": {
        "php": ">=5.5.9",
        "laravel/framework": "5.2.*"
    },
    "config": {
        "preferred-install": "dist"
    },
    "repositories": {
        "packagist": {
            "type": "composer",
            "url": "https://packagist.phpcomposer.com"
        }
    }
}
```

镜像原理：一般情况下，安装包的数据（主要是 zip 文件）一般是从 github.com 上下载的，安装包的元数据是从 packagist.org 上下载的。然而，由于众所周知的原因，国外的网站连接速度很慢，并且随时可能被「墙」甚至「不存在」。

「Packagist 中国全量镜像」所做的就是缓存所有安装包和元数据到国内的机房并通过国内的 CDN 进行加速，这样就不必再去向国外的网站发起请求，从而达到加速 composer install 以及 composer update 的过程，并且更加快速、稳定。因此，即使 packagist.org、github.com 发生故障（主要是连接速度太慢和被墙），你仍然可以下载、更新安装包。

解除镜象：如果需要解除镜像并恢复到 packagist 官方源，请执行以下命令：

    composer config -g --unset repos.packagist

执行之后，composer 会利用默认值（也就是官方源）重置源地址。将来如果还需要使用镜像的话，只需要根据前面的「镜像用法」中介绍的方法再次设置镜像地址即可。

然后还是启动不了。

最终解决用的是阿里的镜像：[阿里云Composer镜像站-阿里云开发者社区-阿里云官网开发者社区_云计算社区](https://developer.aliyun.com/composer)

所有项目都会使用该镜像地址：

    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

取消配置的话：

    composer config -g --unset repos.packagist

最新找到的淘宝镜像（2020-04-10），但资源还是不行，最后尝试后还是用上面的镜像。（composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/）

[Packagist / Composer 中国全量镜像](https://pkg.phpcomposer.com/)

修改 composer 的全局配置文件：

    composer config -g repo.packagist composer https://packagist.phpcomposer.com

解除镜像：

    composer config -g --unset repos.packagist

### 4. laravel-admin

先进通过 laravel 创建好的项目里，使用下面命令：

composer require encore/laravel-admin

注意，命令后面是 laravel-admin，而不是自己的项目名称 readnote。然后运行下面的命令来发布资源：

php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"

在该命令会生成配置文件 config/admin.php，可以在里面修改安装的地址、数据库连接、以及表名，建议都是用默认配置不修改。然后运行下面的命令完成安装：

php artisan admin:install -v

启动服务器的命令：php artisan serve

发现报错：

```
Illuminate\Database\QueryException  : SQLSTATE[HY000] [1049] Unknown database 'laravel' (SQL: select * from information_schema.tables where table_schema = laravel and table_name = migrations and table_type = 'BASE TABLE')
```

[[1049] Unknown database](https://laracasts.com/discuss/channels/laravel/1049-unknown-database?page=0)

首先的一个错误是 mysql 的 root 账户设置了密码，root 登入后将密码设置为空；第二个问题，log 的意思是找不到「laravel」数据库，那么进入项目根目录后，用 root 登入，新建一个「laravel」数据库。

mysql -uroot

create database laravel;
use laravel;

接着重新启动：php artisan serve

即可进入 http://localhost:8000/admin

发现进化工 101 后端的项目里启动不了。请教戴强后知道 vendor 文件夹是用 composer 拉取下来的，需要在根目录下执行命令：

composer install

装完之后即可启动服务了。

### 5. 生成的文件

安装完成之后，会在项目目录中生成以下的文件:

#### 01. 配置文件

安装完成之后，laravel-admin 所有的配置都在 config/admin.php 文件中。

#### 02. 后台项目文件

安装完成之后，后台的安装目录为 app/Admin，之后大部分的后台开发编码工作都是在这个目录下进行。

```
app/Admin
├── Controllers
│   ├── ExampleController.php
│   └── HomeController.php
├── bootstrap.php
└── routes.php
```

app/Admin/routes.php 文件用来配置后台路由。

app/Admin/bootstrap.php 是 laravel-admin 的启动文件, 使用方法请参考文件里面的注释。

app/Admin/Controllers 目录用来存放后台控制器文件，该目录下的 HomeController.php 文件是后台首页的显示控制器，ExampleController.php 为实例文件。

#### 03. 静态文件

后台所需的前端静态文件在 /public/vendor/laravel-admin 目录下。

## 02. 快速开始

### 1. 数据表结构

用 Laravel 自带的 users 表举例，表结构为：

```
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
```

对应的数据模型为文件 App\User.php。laravel-admin 可以通过使用以下几步来快速生成 users 表的 CURD 操作页面：

### 2. 添加路由器

使用下面的命令来创建一个对应 App\User 模型的路由器。

php artisan admin:make UserController --model=App\\User

```
// 在 windows 系统中

php artisan admin:make UserController --model=App\User

上面的命令会创建路由器文件 app/Admin/Controllers/UserController.php.
```

1『按上面的命令创建了 UserController.php。路由器即「控制器」文件。路由器添加了还得在 routes.php 里配置。』

### 3. 添加路由配置

在 laravel-admin 的路由配置文件 app/Admin/routes.php 里添加一行：

    $router->resource('users', UserController::class);

2『添加了。』

```
<?php

use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
], function (Router $router) {

    $router->get('/', 'HomeController@index')->name('admin.home');
    $router->resource('users', UserController::class);

});

```

### 4. 添加左侧菜单栏连接

打开 http://localhost:8000/admin/auth/menu，添加对应的 menu, 然后就能在后台管理页面的左侧边栏看到用户管理页面的链接入口了。其中 url 填写不包含路由前缀的的路径部分，比如完整路径是 http://localhost:8000/admin/demo/users, 那么就填 demo/users，如果要添加外部链接，只要填写完整的 url 即可，比如 http://laravel-admin.org/。

### 5. 创建表格表单

剩下的工作就是构建数据表格和表单了，打开 app/Admin/Contollers/UserController.php, 找到 show ()、grid () 和 form () 方法，然后添加构建代码更多详细使用请查看 model-grid 和 model-form。

## 03. 配置

安装完成之后，会生成两个配置文件，用来对管理后台进行配置，config/admin.php 和 app/Admin/bootstrap.php

app/Admin/bootstrap.php，在这个配置文件中可以扩展或者移除你的组件，或者引入前端资源。

2『发现 hg101 里 bootstrap.php 有新增代码。』

## 04. 版本升级

### 查看当前版本

```
composer show encore/laravel-admin

// or 

php artisan admin
```

### 更新到最新版本

    composer require encore/laravel-admin -vvv

### 更新到开发版本

    composer require encore/laravel-admin:dev-master -vvv

### 更新指定版本

    composer require encore/laravel-admin:1.6.15 -vvv

### 注意事项

由于每个版本的静态资源或者语言包都有可能会有更新，所以升级版本之后最好运行下面的命令。

```
// 强制发布静态资源文件

php artisan vendor:publish --tag=laravel-admin-assets --force

// 强制发布语言包文件

php artisan vendor:publish --tag=laravel-admin-lang --force

// 清理视图缓存

php artisan view:clear
```

最后不要忘记清理浏览器缓存。

## 05. 页面内容 & 布局

默认情况下用命令行生成的控制文件提供数据的 CURD 操作，如果你的页面内容需要自定义，参考下面两部分的文档说明。

### 1. 页面内容

laravel-admin 的布局可参考后台首页的布局文件 HomeController.php 的 index () 方法。

Encore\Admin\Layout\Content 类用来实现内容区的布局。Content::body (\$content) 方法用来添加页面内容：

一个简单的后台页面代码如下：

```
public function index(Content $content)
{
    // 选填
    $content->header('填写页面头标题');

    // 选填
    $content->description('填写页面描述小标题');

    // 添加面包屑导航 since v1.5.7
    $content->breadcrumb(
        ['text' => '首页', 'url' => '/admin'],
        ['text' => '用户管理', 'url' => '/admin/users'],
        ['text' => '编辑用户']
    );

    // 填充页面body部分，这里可以填入任何可被渲染的对象
    $content->body('hello world');

    // 在body中添加另一段内容
    $content->body('foo bar');

    // `row`是`body`方法的别名
    $content->row('hello world');

    // 直接渲染视图输出，Since v1.6.12
    $content->view('dashboard', ['data' => 'foo']);

    return $content;
}
```

其中 \$content->body (); 方法可以接受任何可字符串化的对象作为参数，可以是字符串、数字、包含了__toString 方法的对象，实现了 Renderable、Htmlable 接口的对象，包括 laravel 的视图。

### 2. 布局

laravel-admin 的布局使用 bootstrap 的栅格系统，每行的长度是 12，下面是几个简单的布局示例：

添加一行内容：

    $content->row('hello');

行内添加多列：

```
$content->row(function(Row $row) {
    $row->column(4, 'foo');
    $row->column(4, 'bar');
    $row->column(4, 'baz');
});

$content->row(function(Row $row) {
    $row->column(4, 'foo');
    $row->column(8, 'bar');
});
```

列中添加行：

```
$content->row(function (Row $row) {

    $row->column(4, 'xxx');

    $row->column(8, function (Column $column) {
        $column->row('111');
        $column->row('222');
        $column->row('333');
    });
});
```

列中添加行，行内再添加列：

```
$content->row(function (Row $row) {

    $row->column(4, 'xxx');

    $row->column(8, function (Column $column) {
        $column->row('111');
        $column->row('222');
        $column->row(function(Row $row) {
            $row->column(6, '444');
            $row->column(6, '555');
        });
    });
});
```
