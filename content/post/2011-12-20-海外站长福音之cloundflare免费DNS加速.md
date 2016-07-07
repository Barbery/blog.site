---
id: 479
title: 海外站长福音之cloundflare 免费 DNS 加速
date: 2011-12-20T21:19:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/479.html
permalink: /?p=479
categories:
  - 开发
tags:
  - cloundflare
  - DNS
  - 加速
  - 海外站长
---

如果你是用godaddy的主机，或者海外主机，而且常常被墙，抽风等等。。。cloundflare就是你的大救星。。。cloundflare是国外知名的DNS加速器，平时我们被墙就是因为DNS污染的问题，用了DNS加速后大大可以减少被墙的概率，而且，cloundflare还可以免费进行分布式缓存，在全球各节点缓存静态文件进行加速。。总之功能多多，最重要是免费。。。嘎嘎！

OK，言归正传，首先，先去cloundflare注册个账号先：<a title="www.cloundflare.com" href="http://www.cloundflare.com" target="_blank" rel="nofollow" >www.cloundflare.com</a> ，注册完后回到首页。

下面看图：

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://www.stutostu.com/wp-content/uploads/2011/12/image_thumb12.png" alt="image" width="644" height="377" border="0" />](http://www.stutostu.com/wp-content/uploads/2011/12/image12.png)

很多人都不知道可以选中文，，，汗，不过也没关系，比较简单，大家都能看的懂。。。。至于怎么添加域名和设置DNS那些我就不啰嗦了，网上教程一大把。。。这里主要说的是教大家添加后，怎么利用cloundflare 加速网站加载速度。。。

事不宜迟，再你添加完域名，设置好MX记录后，等1~2个小时生效，生效后在首页添加域名的下方有你的域名记录，像我上面那个图，下面就有我stutostu.com的域名，记录的右边有设置，选择第二个。

如图：

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://www.stutostu.com/wp-content/uploads/2011/12/image_thumb13.png" alt="image" width="299" height="195" border="0" />](http://www.stutostu.com/wp-content/uploads/2011/12/image13.png)

点击后，就进入了一个设置的页面。。。这里我建议大家还是选中文，否则多少有些看不懂。。。

这里cloundflare默认的选项几乎不用改动，很多的选择都是最佳的了，这里我说说默认没选，但是选了更佳的选项。

第一个要开的是IPV6，虽然是测试版，但是百利而无一害的功能，当然要开启啦。。。如果你的网站多是在校学生浏览，那么开这个功能简直提速几倍，因为教育网的IPV6速度极快。。。

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://www.stutostu.com/wp-content/uploads/2011/12/image_thumb14.png" alt="image" width="644" height="76" border="0" />](http://www.stutostu.com/wp-content/uploads/2011/12/image14.png)

&nbsp;

第二个要开的是mini功能，自动压缩js，css，html  大大加快传输的速度，你懂的。

[<img style="background-image: none; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://www.stutostu.com/wp-content/uploads/2011/12/image_thumb15.png" alt="image" width="644" height="76" border="0" />](http://www.stutostu.com/wp-content/uploads/2011/12/image15.png)

剩下的功能，像防盗链，数据分析那些，都是可开可不开，大家自行把握吧。对我而言，也对大多数海外主机的同志们而言，最大的功能是防止抽风，拒绝电信的DNS污染。。。