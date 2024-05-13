# 01. 基本信息

[sequelpro/sequelpro: MySQL/MariaDB database management for macOS](https://github.com/sequelpro/sequelpro)

[Mac 上的 MySQL 管理工具 -- Sequel Pro - hello, world - SegmentFault 思否](https://segmentfault.com/a/1190000006255923)

[mac安装mysql + sequel pro_数据库_飞菜博客-CSDN博客](https://blog.csdn.net/EASYgoing00/article/details/70233190)

## 0101. 安装

目前找到的最佳安装方式。（2020-09-20）

[Install Sequel Pro on Mac OSX – Mac App Store](http://macappstore.org/sequel-pro/)

```
brew cask install sequel-pro
```

通过 brew 来安装，先搜索软件：

```
brew search sequel-pro

homebrew/cask-versions/sequel-pro-nightly
```

然后按搜索结果安装相应的版本：

```
brew install homebrew/cask-versions/sequel-pro-nightly
```

安装完成后可以使用下面的命令来查看，brew 安装的图形界面软件。

```
brew list --cask
```

## 0201. 问题汇总

### 01. 连接不上数据库

报错：

```
MySQL said: Authentication plugin 'caching_sha2_password' cannot be loaded: dlopen(/usr/local/lib/plugin/caching_sha2_password.so, 2): image not found
```

解决方案：[Setting up mysql on mac with sequel pro and homebrew](https://gist.github.com/joeyklee/5ada6a254804c33dbebbca4161277836)

```
ALTER USER '<username>'@'<localhost>' IDENTIFIED WITH mysql_native_password BY '<your_password>'
```

```
mysql -u root -p
```

登入进 mysql 后通过下面的命令修改密码设置。

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'dalong0514';
```

注意，命令后记得以分号结尾。连接方法汇总如下：

```
1、先启动服务器：mysql.server start

2、地址：127.0.0.1

3、用户：root
```

密码为空。（密码设置为空印象中是为了在 xampp 环境下让 php 连接上数据库。）

### 02. 迁移到新电脑后遇到的问题

直接登录「mysql -uroot -p」，报错：

```
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
```

但是不通过 socket 登录，用 TCP/IP 连接是可以登录进去的，命令「mysql -uroot -h 127.0.0.1 -p」。

搞了半天没解决，解决方案基本的思路都是修改配置文件「my.cnf」。途中找了之前看的书籍「2019025MySQL-and-MariaDBR00」，查看 mysql 启动配置文件优先级的命令：

```
mysql --help | grep 'Default options' -A 1 可以跳出下列说明；
```

1『上面是个管道命令，以后必须得学 shell 里的管道，哈哈。（2020-09-20）』

```
Default options are read from the following files in the given order:

/etc/my.cnf /etc/mysql/my.cnf /usr/local/etc/my.cnf ~/.my.cnf
```

搜了下自己的配置文件，是属于「/usr/local/etc/my.cnf」，看了下，里面的内容很少的，如下。

```
# Default Homebrew MySQL server config
[mysqld]
# Only allow connections from localhost
bind-address = 127.0.0.1
```

该配置文件没解决问题，反而弄出一个新问题，mysql 启动不了了，报错：

```
ERROR! The server quit without updating PID file (/usr/local/var/mysql/dalongdeMacBook-Pro.local.pid
```

在 medium 上找到比较靠谱的解决方案：[MySQL ERROR! The server quit without updating PID file | by janac | Medium](https://medium.com/@7anac/mysql-error-the-server-quit-without-updating-pid-file-ce320ff75828)

试了里面的第二个方案，比 mysql 整个文件夹的权限改了：

```
sudo chmod 777 /usr/local/var/mysql
```

发现还是启动不了，接着准备按照文章里说的，完全卸载掉重新装。后面试了试重启电脑，竟然就可以启动 mysql 了，好怪，不知道是否是方案二起了作用。

虽然现在可以通过 socket 连接进去，「mysql -uroot -p」，但是一登进 Sequel Pro，选择一个数据库就报错。后来突然想起来之前遇到过这个问题，是  Sequel Pro 正式版与 mysql 8.0 版兼容性导致的。

1『文章里作者强烈建议启动 mysql 用命令「brew services start mysql」，而不要用「mysql.server start」，目前不知道为啥。（2020-09-20）』

3『[使用 Sequel Pro Nightly 解决 MySQL 8.x 报错的问题 - w3ctech](https://www.w3ctech.com/topic/2186)

Sequel Pro 现在官网推荐下载的正式版是 1.1.2。 所以我直接使用这个版本来管理MySQL。但是问题来了，最开始是连接的问题，因为强密码的问题引起的。

连接成功以后，新问题又来了，查看数据表报错等，在 Sequel Pro 项目的 GitHub 上有人反馈，后面下载了 Sequel Pro Nightly 版本，终于顺利解决了问题。

手动下载的地址：[Test Builds](https://sequelpro.com/test-builds)。自己目前是通过 brew 安装的，详见前面的安装部分。（2020-09-20）

』