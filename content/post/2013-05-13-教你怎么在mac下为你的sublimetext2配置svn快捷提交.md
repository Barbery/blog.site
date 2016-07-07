---
id: 1115
title: 教你怎么在mac下为你的sublime text2 配置svn快捷提交
date: 2013-05-13T21:45:20+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1115
permalink: /?p=1115
categories:
  - 心情随笔
tags:
  - mac
  - sublime text 2
  - SVN
  - 配置
---
如果你是windows系统，你应该看这篇文章：<http://www.stutostu.com/966.html>

ok，言归正传。。。

首先，你应该先在你的sublime text2中安装package controll (不懂的话，传送门：[http://wbond.net/sublime\_packages/package\_control/installation](http://wbond.net/sublime_packages/package_control/installation))

如果你已经安装好了，go head。。。

按command+shift+P  输入install package   再输入  svn，搜索出来第一位就是svn的，就安装那个。。。

安装完后，选择 sublime text2 -> Preferences -> Package Settings -> SVN -> Setting - Default     如下图所示。。。

[<img title="NewImage" src="http://farm3.staticflickr.com/2816/9190975011_bc053a0fd1.jpg" alt="NewImage" width="500" height="237" border="0" />](http://www.flickr.com/photos/95934850@N02/9190975011 "View 'NewImage' on Flickr.com")

 

在最后去掉注释，或者输入

> "svn\_binary\_path": "/usr/bin/svn"

然后保存关闭。。。点下左边的文件夹，如果出现下图这样的菜单，就证明可以了。。

[<img title="NewImage1" src="http://farm3.staticflickr.com/2880/9193773264_8e5e446b0e.jpg" alt="NewImage1" width="500" height="205" border="0" />](http://www.flickr.com/photos/95934850@N02/9193773264 "View 'NewImage1' on Flickr.com")

要是没有的话，那可能是你mac下的svn地址问题，你检查下你svn的路径下是否存在svn的应用，或者你可以用homebrew安装一个  输入brew install svn就可以了。。。路径会在安装完成的时候输出在终端那里。。。。

最后再说一下，这个sublime text 的svn提交，这个和windows那篇文章的svn提交方式有所不同。。。你选择commit后，会出现下图这样的情况，

[<img title="NewImage2" src="http://farm3.staticflickr.com/2814/9193773808_84c9d25bb2.jpg" alt="NewImage2" width="500" height="222" border="0" />](http://www.flickr.com/photos/95934850@N02/9193773808 "View 'NewImage2' on Flickr.com")

第一行的意思是，输入你这次提交的备注信息。。。然后16 17行是这次要提交的内容，红色的M是只内容被修改过了。。那个 [x] 是指被选中提交，默认是全选的，你要是不想提交某一个文件，你把光标移动到指定的行数，按键盘N，里面的x就会消失了，就代表这次提交不提交该文件。。。搞掂好按command+s 保存即可。。。

 