---
id: 966
title: 为你的sublime text 2 配置SVN
date: 2012-11-28T13:26:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/966.html
permalink: /?p=966
categories:
  - 开发
tags:
  - sublime text 2
  - SVN
  - 配置
---

如题所示，在coding的时候，每次都需要点出去commit是灰常浪费时间和麻烦的事情。。。所以就抱着试试的心态去在package install 里搜索下SVN，嘿，还不错，有2个SVN的相关插件。。。我建议大家装TortoiseSVN 这个，功能和SVN那个一样，而且TortoiseSVN这个是免费的，SVN那个还要收费授权。。。擦。。。

安装完之后还要配置一下才能使用，因为编辑器不知道你电脑的SVN程序地址在哪里（ps：这个问题浪费了好长时间去搜索，竟然没有人提？）

ok，言归正传，打开 preference –> Browse package  然后找到文件夹名称为 TortoiseSVN 的，点进去，用sublime text 2 或者其他文本编辑器打开 TortoiseSVN.sublime-settings 这个文件。。。把这个地址改成你的SVN地址就可以了。。。什么？你不知道你的SVN地址是什么？那你就逐个硬盘搜索一下 TortoiseProc.exe 这个文件。。。找个文件的地址就是你的SVN程序地址。。。

上图

<img title="" src="http://t1.qpic.cn/mblogpic/6c7e831e3b62c476eaf8/2000" alt="" width="" height="" border="0" />