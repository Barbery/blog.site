---
id: 784
title: 实现Linechart 一线多色，局部变色问题
date: 2012-04-27T10:44:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/784.html
permalink: /?p=784
categories:
  - 开发
tags:
  - flex
  - Linechart
  - 局部颜色
---

最近，在做一个股票的指标图。。。需要实现的情况是，当线条向上走时，需要加粗红色显示，而当线条向下时，就变为绿色。。。这里涉及到的就是，一条线需要根据情况，来动态调整它的样式，而flex中的linechart只是一种颜色。。。我本以为这个问题，应该会有些博主解决了。。。没想到google了好久也没见到答复，倒是询问的人不少。ok，只能自己动手做了。。。


思路很简单，找源码，看看哪个function是处理画线的，在画线前做你的业务逻辑判断，然后再动态设置linestyle即可。。。额。多说无益，程序猿都爱源码，都爱demo。。。我附上源码，大家自己折腾去吧。。。不懂再留言吧，我会回复你D～

以下是效果图：
![效果图](http://ww3.sinaimg.cn/large/6915c7dcjw1e69wih26kgj20sg0baab2.jpg)

使用的话，在你的linechart 的series里，找到你要应用的线，然后设置成这个

```
<mx:LineSeries yField="Profit"  lineSegmentRenderer="skin.MyLineRenderer"/>
```

业务逻辑，以及颜色都在MyLineRenderer.as 里面修改，我都有注释，应该能看得懂的。。。

原创内容，转载请注明来源哟。

<a href="http://pan.baidu.com/share/link?shareid=1110129343&#038;uk=3036724125" target="_blank">MyLineRenderer.rar</a>