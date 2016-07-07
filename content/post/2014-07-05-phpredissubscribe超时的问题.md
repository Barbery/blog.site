---
id: 1347
title: php redis subscribe超时的问题
date: 2014-07-05T14:38:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1347
permalink: /?p=1347
categories:
  - 开发
tags:
  - default_socket_timeout
  - php
  - redis
  - subscribe
---
最近发现一个奇怪的情况，就是redis的subscribe运行几十秒后，就会抛出一个RedisException.. 上github的issue上找找看，发现也有不少朋友遇到这个问题。

原因处在于，php的redis库使用的subscribe是使用PHP内置的socket，而php.ini默认是设置了socket的超时时间是60秒，所以大家只要找到default\_socket\_timeout 这个配置项，把时间改长点就可以了。。。这里注意哦，我看了下官方的说明，似乎没有不限时间的选项，也就是不能填0，你如果填0，那么socket就会立即返回失败，而不是你预想中的不设超时。。。所以目前只能暂且填个很大的数，例如 1000000