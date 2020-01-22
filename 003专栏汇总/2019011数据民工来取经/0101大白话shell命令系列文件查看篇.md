# 大白话 shell 命令系列：文件查看篇
> 原创 三十 数据民工来取经儿 2019-04-08

[大白话 shell 命令系列：文件查看篇](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456374080&idx=3&sn=cb060e5c89300f8be3ac5f1278d3566e&chksm=88cd169bbfba9f8d06f46548357b9907d9b9854ed0b41d52101e7efb299015a936fbb3ee7b35&scene=21#wechat_redirect)

## 01. 目的

本篇文章仅限于让没接触过 Linux 系统的同学，零距离接触并通过咔嚓咔嚓敲几条命令简单了解下，目的是了解如果用 Linux 命令查看文件信息，纯小白破冰文章。熟悉 Linux 环境的同学，可以跳过这篇文章，并且要果断跳过！以后直接看如何用 Linux 命令进行数据统计。

[如何在本机进入云端的数据环境](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456373937&idx=3&sn=20dc19df447ad144f294b771fc132523&chksm=88cd176abfba9e7c726b5bc7da32898e95210078fdd6bee69f453069583f5e25f4ce08a58cbb&token=499461625&lang=zh_CN&scene=21#wechat_redirect)

## 02. 命令介绍

每个命令陪一个截图，大家只要根据大白话 shell 命令系列：阿里云端 Linux 环境篇说明，连接上云端环境，直接按图中命令输入命令并回车，查看效果即可。

查看当前目录

    pwd

进入目录

    cd /home/dataworker/data/mypy

目录查看

    ll

文件查看

查看文件前 10 行

    head /home/dataworker/data/mypy/youcanlook.txt

查看文件后 10 行

    tail head /home/dataworker/data/mypy/youcanlook.txt

查看整个文件

    cat /home/dataworker/data/mypy/youcanlook.txt

编辑文件

    vim /home/dataworker/data/mypy/youcanlook.txt

