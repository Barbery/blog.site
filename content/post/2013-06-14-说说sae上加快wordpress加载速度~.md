---
id: 1134
title: 说说sae上加快wordpress加载速度~
date: 2013-06-14T20:03:25+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1134
permalink: /?p=1134
categories:
  - 开发
tags:
  - sae
  - wordpress
  - 加速
---

因为最近和朋友搞了另外一个博客, 而且也优化了一下, 速度提升还是明显的, 在此写下, 权当记录...

优化的重点是放在静态资源的加载速度上, 虽然域名没备案, 走的是日本节点反向代理国内的节点, 但是加载页面的html再慢, 也就2~3s加载完了… 但是其他的静态资源 例如css js 和图片那些, 要是把这些优化好了, 页面加载的速度也就非常可观了...

1. 静态资源不要用绑定的域名, 用sae自带的二级域名, 因为这样就不用走海外节点, 加载速度快很多,至少快1倍左右...

2. 一些大的类库, 不要用自己服务器加载, 像jquery, boostrap, jquery-ui 等等这些类库 有100k那么大, 应该用一些共用CDN资源来加载, 例如百度这个:<http://developer.baidu.com/wiki/index.php?title=docs/cplat/libs#jQuery>  或者 新浪这个:<http://sae.sina.com.cn/?m=devcenter&catId=147>  都是非常不错的外链资源…. 起码比链接到自己服务器的类库加载速度快1倍以上...

3. 图片, 特别是背景图等大图, 可以考虑外链, 你也许会问, 现在哪里有那么好的地方给你外链图片? 嘿,还别说, 还真有一个….就是微博, 当然, 这里我推荐使用 围脖是个好图床: <http://weibotuchuang.sinaapp.com/bookmark.html>

4. 打开SAE appconfig的 GZIP压缩 以及 设置好静态资源缓存时间

 

以上都做好了….. 速度就能明显上来了~~