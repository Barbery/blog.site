---
id: 869
title: 终于解决了FLEX CandlestickSeries 变形 缩小的问题
date: 2012-07-10T17:25:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/869.html
permalink: /?p=869
categories:
  - 开发
tags:
  - CandlestickChart
  - CandlestickSeries
  - flex
  - LineSeries
  - 缩小
---

虽然，其中的原理我不太清楚。。。但是，还是幸运的解决了这个问题。。。这是个神奇的问题，上网搜索竟然没有人问过这样的问题。。。我擦。。。这是间接说明我太水了么？

ok吧，言归正传，写出来，希望帮到一些新手。。。

在 CandlestickChart 中使用 CandlestickSeries 和 LineSeries 应该是股票图常常用到的，就是K线和均线，但是，当你加入lineseries 也就是均线时，你会发现，CandlestickSeries 的K线竟然 缩小了，任你如何设置，任你如何重写renderer 还是不行。。。今日RP爆发，弱弱的试试，把CandlestickChart 改成 LineChart 就解决问题了。。。也就是说，如果你想 CandlestickSeries 和 LineSeries&nbsp; 共存使用，而 CandlestickSeries 又不变形，那么千万别用 CandlestickChart ，用LineChart 就不会出现这个问题了。。。。--！弱爆了！

----

修正一下，应该用columnchart才对，linechart的话会导致最左和最右2个item有一半看不见~