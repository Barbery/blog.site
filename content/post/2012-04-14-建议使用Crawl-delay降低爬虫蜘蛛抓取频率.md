---
id: 736
title: 建议使用Crawl-delay降低爬虫蜘蛛抓取频率
date: 2012-04-14T09:45:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/736.html
permalink: /?p=736
categories:
  - 开发
tags:
  - Crawl-delay
  - robots
  - sae
  - 爬虫
  - 蜘蛛
---

如题，当然，谈这个之前，必须说说，蜘蛛爬取你的站是好事，因为只有这样，你的站才能让更多人知道。。。这里之所以说，建议降低抓取频率，是相当服务器以及你的预算而已的，像我的一个sae上的站，每天IP量就1～2个人，主要服务对象是自己的朋友，而蜘蛛每天抓取的频率非常频繁，导致每天都差不多跑了1G的流量。。。真心伤不起，每天都消耗我200豆豆，还不如直接买盛大云主机了，我汗。。。自从限制了蜘蛛抓取频率后，主机速度加快了，豆豆消耗变小了，由每天200个直线下降到可以接受的50个<img style="border-bottom-style: none; border-left-style: none; border-top-style: none; border-right-style: none" class="wlEmoticon wlEmoticon-openmouthedsmile" alt="大笑" src="http://www.stutostu.com/wp-content/uploads/2012/04/wlEmoticon-openmouthedsmile.png" />

ok，言归正传。在你的服务器根目录下建一个robots.txt 名字必须是这个，不要乱改了哦～～否则蜘蛛可认不了。。。

说再多也没用，直接贴上我自己的robots.txt 吧

```
User-agent: *
Disallow: /admin/
Crawl-delay:300
```