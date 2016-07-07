---
id: 1141
title: 说说wordpress页面静态化多说插件和admin bar的问题
date: 2013-06-21T15:21:24+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1141
permalink: /?p=1141
categories:
  - 开发
tags:
  - admin-bar
  - wordpress
  - 多说
  - 静态
---

由于页面做了memcache缓存, 没想到连登陆后的头部admin-bar 和 多说的auth_key 也缓存进去了….

要想去掉admin-bar这个简单, 如果你的博客只有你1个人是管理员, 那你可以到用户设置里面把是否显示那个勾去掉就可以了…要是你是多管理员的情况下, 那这样做就不好了, 要每个人都改一下多麻烦… 你可以直接修改wp-include/admin-bar.php 文件  就在第一个函数 \_wp\_admin\_bar\_init 直接return false,

就像这样:
![img](http://ww4.sinaimg.cn/large/6915c7dcjw1e5v0h0dujhj209m0393yj.jpg)

让他初始化失败, 这样就不会加载admin bar了,也不会在页面那里留下20px的空白条….

 

多说自动登陆的话, 这个问题是由于把auth_key 也缓存进去了, 只要把wp-content/plugins/duoshuo/WordPress.php 这个文件的 buildQuery 这个方法里面的关键数组注释掉就可以了…

就像这样...
![img](http://ww2.sinaimg.cn/large/6915c7dcjw1e5v0mzy155j20jb06d0th.jpg)