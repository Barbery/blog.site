---
id: 962
title: 擦~~终于搞定FlashBuider 自动关闭的问题了
date: 2012-11-03T16:36:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/962.html
permalink: /?p=962
categories:
  - 开发
tags:
  - FlashBuider
  - 自动关闭
---

FlashBuider 好卡有木有？设计模式自动关闭有木有？代码写着写着，FlashBuider 就自动关闭了有木有？？？？

擦，这个问题困扰我已久，google许久，得到的解决方法都是叫我改FlashBuider.ini，但是，我擦，完全没效果。。。今日竟然在我全身心投入写代码的时候，竟然又自动关闭了，擦，我再也忍受不了了。。。最终，在FlashBuiderC.exe中，我找到了这个问题的根源。。。就是 out of memory，当命令行出现这个错误时，Flashbuider就会在几s内就自动关闭了。。。抱着试试的心态，上网google一下，嘿，遇到这个问题的人还不少。。。比搜索 “FlashBuider 自动关闭”这个关键词的人多了。。。按照部分博客的介绍，设置完后，重启下Flashbuider，感觉速度快了，写代码也变快了，人也变聪明了。。。

好吧，言归正传，下面教你怎么设置Flashbuider来解决这个问题。。。作者这里的版本是Flashbuider 4.6 不过都大同小异，应该没有版本的差异问题。。。



打开你的Flashbuider –》 window（窗口）--》preference（首选项）--》Java—》Installed JREs

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://ww2.sinaimg.cn/large/6915c7dcjw1e69w7xirpsj20mo0ivacs.jpg" width="640" height="535" />](http://ww2.sinaimg.cn/large/6915c7dcjw1e69w7xirpsj20mo0ivacs.jpg)

选择Edit（编辑）

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://ww2.sinaimg.cn/large/6915c7dcjw1e69w8rqknuj20hc0estbb.jpg" width="545" height="466" />](http://ww2.sinaimg.cn/large/6915c7dcjw1e69w8rqknuj20hc0estbb.jpg)

然后按照上图的位置所示，填入 –Xmx1024m&nbsp; 别漏了前面那个半角减号。。。设置完成，重启下FlashBuider 即可解决这个问题了。。。

困扰那么久的问题，竟然在意料之外中解决了~~~