---
id: 1200
title: 关于mac source bashrc引入path路径重启无效的问题小记
date: 2013-08-23T20:08:51+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1200
permalink: /?p=1200
categories:
  - 开发
tags:
  - bashrc
  - mac
  - path
  - source
---

今天同事的mac上遇到一个疑难杂症, 在bashrc设置好 export path后, source ~/.bashrc 重启后$PATH路径又被还原了…. 

捣鼓了好久都不行, 不知道为什么, .bashrc这个文件重启后不会自动引用, 最后没办法了, 只好在/etc/profile 里面写段代码, 让系统强制source ~/.bashrc

`sudo vi /etc/profile` 代码如下:

```
if [ -f ~/.bashrc ] ; then
   [ -r ~/.bashrc ] && source ~/.bashrc
fi
```

这样重启后, 问题就解决了...