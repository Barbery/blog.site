---
id: 710
title: 解决淘宝 API 返回的json数据无法用json_decode的问题
date: 2012-04-02T15:18:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/710.html
permalink: /?p=710
categories:
  - 开发
tags:
  - json_decode
  - json数据
  - 淘宝 API
---

如题，这个问题困扰我已久。。。经过自己的多次尝试，和到网上搜索，我已大概猜测到是字符的问题，论坛上的朋友说，PHP的json_decode对json数据要求非常严格，必须是{“key”："value”}的双引号包围才行，而且，对一些特殊符号不兼容。。。例如UTF-8的 BOM头，或者是C++字符的结束符\0等等。。。

经过排查，我发现。。。淘宝API返回的json数据（特别是taobao.taobaoke.items.detail.get），之所以json_decode后，结果为null，原因就是返回的数据含有回车符。。。这可能是一些店主在装修时，或者填写店铺描述，商品描述不规范所留下的。。。所以用

```php
$json = str_replace(array("\r\n","\n","\r","\t",chr(9),\\n),'',$json );
$json = json_decode($json,true);
```

这样就可以解决这个问题了。