---
id: 1267
title: 分享一个openresty的service脚本
date: 2013-11-23T14:48:39+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1267
permalink: /?p=1267
categories:
  - 开发
tags:
  - init.d
  - nginx
  - openresty
  - service
---

因为openresty的nginx位置和官方源安装的位置不同，所以大多数网上找到的nginx service脚本都无法应用于openresty，今天不巧在社区里发现一个不错的脚本，经过测试，确实可用。。。本来代码是放在google code 的，为了方便大家配置，我把它移到我blog的，七牛云储存里面。。。

```
# 下载脚本并把脚本放置到init.d里面
sudo wget http://stutostu.qiniudn.com/openresty.init.d.script -O /etc/init.d/nginx;
```

操作的话，只需要

```
sudo service nginx [start|stop|restart|reload|info]
```

如果提示nginx: unrecognized service 只需要赋予执行权限即可，如下所示

```
sudo chmod +x /etc/init.d/nginx
```

如果需要把nginx 添加为开机启动，只需要

```
sudo update-rc.d -f nginx defaults
```