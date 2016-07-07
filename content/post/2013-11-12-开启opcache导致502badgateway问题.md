---
id: 1245
title: 开启opcache导致502 bad gateway问题
date: 2013-11-12T18:05:37+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1245
permalink: /?p=1245
categories:
  - 开发
tags:
  - opcache
  - php
  - zendOpcache
  - 兼容性
---

本想开启opcache来做code cache， 木想到开了就502错误，googe许久也找不到解决方案，上stackoverflow提问也木有人回答。。。

如果不加载opcache.so 就一切正常，说明是opcache的内部问题。。。看nginx error.log 和 php5-fpm.log也找不到什么解决方法。。

我怀疑是版本兼容的问题，我使用的PHP版本是ubuntu apt源默认的版本，也就是php5.3.10-ubuntu ，因为在服务器上和本地2台机器都是这样，一加载opcache访问就报502错误。。。

中午趁有休息的时间，速度把PHP版本升级到5.5，这样就可以使用内置的opcache（PHP5.5开始默认带zend opcache，而且是默认开启的）。。。

```
add-apt-repository ppa:ondrej/php5
apt-get update
apt-get install php5-fpm
```

按照上面代码就可以把系统的php版本升级到最新的stable版本，目前是PHP5.5.5。。。

果然，安装好后，一切正常。。。我看了下PHP官方，PHP5.3的稳定版本是PHP5.3.27，看来真的是APT源默认的版本和opcache 7.0.2不兼容。。。

ok，至此，问题圆满解决!