---
id: 1322
title: 永久设置ubuntu ulimit
date: 2014-03-02T12:20:03+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1322
permalink: /?p=1322
categories:
  - 开发
tags:
  - ubuntu
  - ulimit
  - 设置
---

之前是ulimit -n 65535那样设置，不过貌似只是当前环境有效果，重启服务器的话，又失效了。。。今天无意找到一个设置的方法，可以永久设置ulimit的参数，转过来权当备份。。。

打开/etc/security/limits.conf

添加

```
* hard nofile 65535
* soft nofile 65535
root hard nofile 65535
root soft nofile 65535
```

或者直接执行

```bash
echo "* hard nofile 65535
* soft nofile 65535
root hard nofile 65535
root soft nofile 65535">>/etc/security/limits.conf
```


修改

> vim /etc/pam.d/su

注释掉(默认已经是注释掉)

> session required pam_limits.so

搞定，重启即可。。。重启后可以查看ulimit -n是否显示为65535