---
id: 1243
title: 解决新建的用户apt-get tab不能代码补全的问题
date: 2013-11-10T16:37:26+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1243
permalink: /?p=1243
categories:
  - 开发
tags:
  - apt-get
  - tab
  - 补全
---

root账户下是木有问题的， 但是为了安全起见， 标准做法都是禁止root用户登录， 然后新建一个用户， 使用SSH key验证的方式登录， 然后再su root， 来获取root权限。。。

但是有个奇怪的情况， su root的确是获得root权限了， 但是apt-get tab键却不能代码补全了， 特别是在apt-get install 和 apt-get remove 的情况下， 木有补全的搜索， 真是巨难用。。。。

最终发现， 原来问题出在/root/.bashrc 这个文件这里。。。

```bash
vim /root/.bashrc
# 把下面的内容前面的“#”井号去掉， 如果你找不到， 就把下面的内容追加的文件的内容后面
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
```

ok, 解决了！