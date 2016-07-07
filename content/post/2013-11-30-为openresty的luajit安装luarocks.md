---
id: 1282
title: 为openresty的luajit安装luarocks
date: 2013-11-30T17:35:22+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1282
permalink: /?p=1282
categories:
  - 开发
tags:
  - luajit
  - luarocks
  - openresty
---

[lualocks](http://luarocks.org/)是一个包管理器，类似nodejs的npm那样。。。总之装了以后安装第三方包就很方便，路径什么的，人家都帮你搞掂，不用自己每次都要--prefix。。。

因为openresty已经装了luajit，所以就不需要装luajit了，下载好[luarocks](http://luarocks.org/)，解压，用命令行进入刚刚解压出来的文件夹，输入以下代码

```bash
sudo ./configure --with-lua="/usr/local/openresty/luajit" --lua-suffix="jit" --with-lua-include="/usr/local/openresty/luajit/include/luajit-2.0"
make
sudo make install
sudo ln -s /usr/local/openresty/luajit/bin/luajit-2.0.2 /usr/local/bin/luajit
```

最后一句是把openresty的luajit，软连接到系统路径下，这样想要在命令行下玩luajit就可以随时随地了。。。

#### ok, enjoy luajit!