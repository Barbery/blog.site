---
id: 1102
title: 用ngx_drizzle时遇到一个坑，记录下。。。
date: 2013-05-08T22:11:38+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1102
permalink: /?p=1102
categories:
  - 开发
tags:
  - drizzle
  - openresty
---

刚刚装好ngx_drizzle的时候，老是连接不上，代码都是安装官方demo来写的，竟然都不行。。。看了文档，报错如下：

> failed to connect: 23: Access denied for user 'root'@'localhost' (using password: YES) while connecting to drizzle upstream, client: 127.0.0.1, server: localhost, request: "GET /users HTTP/1.1", upstream: "drizzle://127.0.0.1:3306", host: "localhost:8080"

上网google一下，我擦，内容少得可怜，我看除了我这世界上没几个人遇到这个错误了。。。

后来我看到有个using password：YES，而我的配置是

> drizzle_server 127.0.0.1:3306 dbname=aicaike user=root password=‘’ protocol=mysql;
> drizzle_keepalive max=100 mode=single overflow=reject;

我擦，不会是把‘’当成密码了吧。。。果断把password整个关键词都删掉。。。curl看下，哟西。。。果然是这个问题。。。