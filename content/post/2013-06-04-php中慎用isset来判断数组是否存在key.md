---
id: 1123
title: php中慎用isset来判断数组是否存在key
date: 2013-06-04T14:57:13+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1123
permalink: /?p=1123
categories:
  - 开发
tags:
  - isset
  - php
  - 数组
---

直接上代码,  不知道是php5.4版本的问题, 还是本来就这样...

```php
$a['hello'] = '123';
$a['xx'] = NULL;

var_dump(isset($a['hello'])); //bool(true)

var_dump(isset($a['xx'])); //bool(false)

# 应该使用这个来判断
var_dump(array_key_exists('xx', $a)); //bool(true)
```