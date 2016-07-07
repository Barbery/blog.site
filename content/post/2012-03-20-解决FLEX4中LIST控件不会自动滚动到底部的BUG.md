---
id: 687
title: 解决FLEX4 中 LIST控件不会自动滚动到底部的BUG
date: 2012-03-20T11:13:53+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=687
permalink: /?p=687
categories:
  - 开发
tags:
  - bug
  - LIST
  - scroll
  - 底部
  - 滚动
---

如题，这个问题，我也上网找了很久。。。国内的blog一般都是无解，只能到国外的论坛去转转看看，无意让我看到了一个解决方法。原理是（按照我的理解），就是从 layout.getVerticalScrollPositionDelta 获取到的delta有延迟，

&nbsp;只能获得上一次的结果，没有办法获得最新的，所以就导致了LIST没法滚动到最底部。。。解决方法是在利用 layout.getVerticalScrollPositionDelta 获取到delta 之前，先用 yourlist.validateNow();

来更新layout的对象，这样就不会出现延迟的问题了。