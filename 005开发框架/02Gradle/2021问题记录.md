## 01. 问题汇总

新建的 gradle 项目，gradle 初始化错误，报错：

```
Could not find method testCompile() for arguments [{group=junit, name=junit, version=4.12}] on object
```

解决方案：[java - Build error with gradle Could not find method testCompile() - Stack Overflow](https://stackoverflow.com/questions/38385680/build-error-with-gradle-could-not-find-method-testcompile)。

The java plugin is only applied to subprojects, so the testCompile configuration, added by the java plugin, can only be used in subprojects. The below works:

```java
allprojects {
    //Put instructions for all projects
    task hello << { task -> println "I'm $task.project.name" }
}

subprojects {
    //Put instructions for each sub project
    apply plugin: "java"
    repositories {
        mavenCentral()
    }

    dependencies {
        testCompile group: 'junit', name: 'junit', version: '4.+'
    }
}
```