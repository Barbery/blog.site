---
id: 1094
title: 简单测试下ngx_drizzle_module
date: 2013-05-08T22:02:29+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1094
permalink: /?p=1094
categories:
  - 开发
tags:
  - drizzle
  - module
  - openresty
  - 测试
---

webbench -c 500 -t 30  测试结果

## TP框架

> Speed=19198 pages/min, 112866 bytes/sec.
> Requests: 6635 susceed, 2964 failed.

 

## 原生

> Speed=16602 pages/min, 89106 bytes/sec.
> Requests: 6027 susceed, 2274 failed.

 

## nginx with drizzle

> Speed=34116 pages/min, 212853 bytes/sec.
> Requests: 14347 susceed, 2711 failed.

 

毫无疑问的，nginx drizzle下速度是最快的。。。效果提升1倍。。。不过令人惊讶的是原生php连接速度竟然不够thinkphp框架下链接的效果好。。。这个疑问有待解决。。

 