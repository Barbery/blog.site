---
id: 1279
title: gitlab web hook的没接受到POST数据的一个坑！
date: 2013-11-28T00:19:51+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1279
permalink: /?p=1279
categories:
  - 开发
tags:
  - gitlab
  - php
  - post
---

额。。。 在help那里， 明明说好是POST数据给我的， 仲么$_POST收不到？ 额。。。原来要用PHP input流来接收。。 使用

```php
$josn = file_get_contents("php://input");
```

来接受数据就可以了。。。