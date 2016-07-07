---
id: 955
title: 擦，终于搞懂怎么在SAE python上装第三方包了
date: 2012-10-27T14:48:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/955.html
permalink: /?p=955
categories:
  - 开发
tags:
  - beautifulsoup
  - python
  - sae
---

本来想装个beautifulsoup玩下的，我擦，上网一搜，全部都是打命令行的，什么解释也没有，擦，我就一个window 7系统，搞个毛啊。。。上google到处搜，换了6~7个关键词，终于，皇天不负有心人，让我在一个介绍如何装djxxx框架的博文中找到答案。。。

首先，你先把你要安装的包给下回来先，然后在sae python的根目录下 创建一个名为：virtualenv.bundle.zip 的压缩包 把你要安装的包都放到这个压缩包里。。。然后修改index.wsgi 在import后面 添加

```python
import sys

app_root = os.path.dirname(__file__)
sys.path.insert(0, os.path.join(app_root, 'virtualenv.bundle.zip'))
```

注意sys.path.insert 的位置是在import后 不要放在urls响应后面，否则会提示没这个包。。。

在使用时，可以参考我的一个demo

```python
import os
import web
import urllib2

from bs4 import BeautifulSoup          # For processing HTML

app_root = os.path.dirname(__file__)
templates_root = os.path.join(app_root, 'templates')
render = web.template.render(templates_root)

class index:
    def GET(self):
        soup = BeautifulSoup(urllib2.urlopen('http://www.sina.com.cn/').read())
        return render.bs_test(soup)
```