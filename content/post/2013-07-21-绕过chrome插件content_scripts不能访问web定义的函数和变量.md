---
id: 1190
title: 绕过chrome插件content_scripts不能访问web定义的函数和变量
date: 2013-07-21T22:54:19+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1190
permalink: /?p=1190
categories:
  - 开发
tags:
  - chrome
  - chrome插件
  - content_scripts
---

因为插件打算利用jsonp来调用远程服务器上的API接口…而尝试了很多次都发现报错说对象不存在, 查了下文档, 原来是chrome的安全机制限制了content_scripts...

具体请看:

> 不能使用除了chrome.extension之外的chrome.* 的接口
> 不能访问它所在扩展中定义的函数和变量
> 不能访问web页面或其它content script中定义的函数和变量
> 不能做cross-site XMLHttpRequests

正是第三点导致了, 返回的jsonp无法调用content\_scripts里面定义的全局函数...但是好险, content\_scripts是有DOM操作的权限的…这也为我们提供了一个解决方案, 就是利用DOM的操作权限, 往web页面里面注入script脚本...

就像这样…创建一个script节点, 然后注入head或者body里面….

```js
var script= document.createElement("script");
script.type = "text/javascript";
script.innerText='ISHGO = {go : function(url){console.log(url);}};';
var Head = document.getElementsByTagName('body').item(0);
Head.appendChild(script);
```

 

 