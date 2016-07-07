---
id: 1088
title: mac下配置nginx+php+mysql小记
date: 2013-05-04T01:05:43+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1088
permalink: /?p=1088
categories:
  - 开发
tags:
  - mac
  - nginx
  - 配置
---
额。。。本来以为mac下可以用lnmp一键安装包的，但是使用后才发现，竟然不行。。。

后来使用了大家都推荐的homebrew来安装。。。具体教程大家可以上网搜，都不算太难。。。

这里具体要说说的是，安装nginx的问题。。。如果是用homebrew安装nginx的话，是没办法添加第三方module的。。。至少我找了好久，也上stackoverflow问了  都没有找到解决方法。。。

最后木办法，只能手动编译安装nginx，php和mysql 以及pecl的话就通过homebrew来安装。。。

大概记录下我的安装步骤：

1. 先到官网下载nginx源码，解压出来。
2. cd进去解压出来的文件夹里面
3. 执行./configure --prefix=/usr/local/Cellar/nginx-1.4.0 --add-module=/path/to/your/modules
4. make & make install

最后安装成功后，进入/usr/local/Cellar/nginx-1.4.0/sbin 下面 sudo nginx 就可以启动nginx服务了。。。要是不想那么麻烦，就要把 /usr/local/Cellar/nginx-1.4.0/sbin这个路径添加进PATH里面去，可以用命令 vi /etc/paths 打开把路径添加进去即可，这样就可以在任何路径下直接sudo nginx启动服务。。

大致就这样。。。

这次配置的过程中常常遇到error\_log 报错，说没这个目录，一般这个问题的解决方法都是找到conf文件，把error\_log的路径改过来就行了，要不就是木有写权限的问题。。。如果遇到报错说has no permission 就在执行命令的前面加上sudo 用管理员权限操作。。。

 