## 01. 安装相关

1、破解。

详见破解说明。

2、安装依赖包。

Java 虚拟机的安装位置：

```
/Users/Daglas/Library/Java/JavaVirtualMachines/openjdk-15.0.1

/Users/Daglas/Library/Java/JavaVirtualMachines/openjdk-16.0.1
```

很多时候下载会很慢，可以借鉴 brew 安装软件慢的解决方案，自己去官网：[JDK 16.0.1 GA Release](https://jdk.java.net/16/)。下载安装包后直接丢进：

```
/Users/Daglas/Library/Java/JavaVirtualMachines/openjdk-16.0.1
```

接着通过 Intelli 里新建项目时的选项 => DownLoad SDK，选中路径后，它会自己省略掉下载步骤直接安装的。

## 02. 三方框架

1、构建工具 —— Gradle。

信息摘自「2020017郑晔的10倍程序员工作法R02」

今天，我们以一个典型的 Java REST 服务为例，介绍一下最基本的构建脚本应该做到什么样子。这里我采用的 Java 技术中最为常见的 Spring Boot 作为基础框架，而构建工具，我选择了 Gradle（Gradle Build Tool）。

估计很多 Java 程序员心中的第一个问题就是，为什么用 Gradle，而不是 Maven？Maven 明明是 Java 社区最经典的构建工具。答案是因为 Maven 不够灵活。你可以回想一下，你有多少次用 Maven 实现过特定需求？估计大部分人的答案都是没有。随着持续集成、持续交付的兴起，构建脚本的订制能力会变得越来越重要，Maven 则表现得力有不逮。其实，早在 2012 年，ThoughtWorks 技术雷达就将 Maven 放到了 暂缓（HOLD）里面，也就是说，能不用就不用。

官网：

[Installing Gradle](https://docs.gradle.org/current/userguide/installation.html)

最简单的方式是直接用 brew 安装：

```
brew install gradle
```

超级慢，直接放弃了。1）直接在官网上下载放到 brew 缓存区的话，但这里有个问题，brew 安装 gradle 之前非得安装 openjdk-15.0.1 包，但这个包下载很慢，官网上也找不到这个包了，卡在这个环节。2）Intelli 新建项目的时候选择带 Gradle 的项目，IDE 自动去帮我下载，但这个速度也很慢，中断了。最后还是用的 gradle 官网手动安装的方案解决的。下载好之后进行如下操作：

1、解压。

```
mkdir /opt/gradle
unzip -d /opt/gradle gradle-7.0-bin.zip
ls /opt/gradle/gradle-7.0
```

注意，解压的时候需要权限，所有得：`sudo unzip -d /opt/gradle gradle-7.0-bin.zip`。以为发现文件夹 `/opt/` 下面都是重量级应用，比如 homebrew-cask、vagrant。

2、设置全局变量。

```
export PATH=$PATH:/opt/gradle/gradle-7.0/bin
```

补充：测试了下，上面的命令指示临时有效，还是要把设局语句写在 `.zshrc` 里。

3、Intelli 里的 gradle 构建工具设置。

快捷键  `command + ,`，Build => Builder Tools => Use Gradle from 里选「Specified location」设置为：/opt/gradle/gradle-7.0。

补充：郑烨的项目例子里，这里设置的是：

'gradle-wrapper.properties' file

Gradle JVM 15

那么它的 gradle 版本的相关设置文件 gradle.builder

```
wrapper {
    gradleVersion = '6.4.1'
}
```