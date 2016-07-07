---
id: 1277
title: 使用mysqlnd代替mysql
date: 2013-11-24T12:02:47+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1277
permalink: /?p=1277
categories:
  - 开发
tags:
  - mysql
  - mysqlnd
  - php
  - 类库
---

mysqlnd是PHP的一个由C拓展写的原生mysql驱动类库， 是目前**PHP官方推荐使用**的类库， 使用这个类库操作mysql， 可以支持多种最新的特征功能。 例如， 惰性连接（lazy connection），非阻塞异步查询等等。。装了这个类库， 以后还可以支持通过mysqlnd其他C拓展支持多mysql读写负债平衡（mysqlnd_ms）等的后续类库支持。。。。

有多少人还不知道这个类库的存在？ 你是不是还在默默使用PHP自带的mysql驱动类库？ 在php5.4之前， 默认的是mysql类库， 5.4之后， 源码编译安装的话， 默认使用mysqlnd类库。。。但是大多数人使用的apt or yum源安装的话是默认使用mysql的， 需要切换到mysqlnd， 还需要通过 apt-get install php5-mysqlnd 安装才行。。

拓展阅读： <http://www.php.net/manual/zh/mysqlinfo.library.choosing.php>
