---
id: 1092
title: mac 下配置memcached小记
date: 2013-05-08T16:25:16+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1092
permalink: /?p=1092
categories:
  - 开发
tags:
  - mac
  - memcached
  - 配置
---
用homebrew安装的话，是很简单的，不过由于自己不懂，走了很多弯路。。。

简单点说

1. 先安装memcached服务，用 brew install memcached 安装

2. 安装memcached 的php扩展， 用 brew install php54-memcached （ps:如果你的php版本是5.3.x 那么就是brew install php53-memcached）

 

安装完后，记得要启动memcached服务，就和nginx那样，不启动的话，你在php使用是没办法连得上服务器的。。。

如果你和我这样，没什么只是用于本地开发，没特别需求的话可以直接启动

memcached -d 即可

最后附上 memcached的一些参数说明：

> -d 启动为守护进程
>
> -m <num> 分配给Memcached使用的内存数量，单位是MB，默认为64MB
>
> -u <username> 运行Memcached的用户，仅当作为root运行时
>
> -l <ip\_addr> 监听的服务器IP地址，默认为环境变量INDRR\_ANY的值
>
> -p <num> 设置Memcached监听的端口，最好是1024以上的端口
>
> -c <num> 设置最大并发连接数，默认为1024
>
> -P <file> 设置保存Memcached的pid文件，与-d选择同时使用