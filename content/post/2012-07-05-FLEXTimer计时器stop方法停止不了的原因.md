---
id: 860
title: FLEX Timer计时器stop方法停止不了的原因
date: 2012-07-05T15:41:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/860.html
permalink: /?p=860
categories:
  - 开发
tags:
  - flex
  - stop
  - Timer
---

今天发生一个奇异的问题，Timer方法，竟然注销不掉，断点调试，发现没什么问题，明明都成功调用了stop() ，但是就是停止不了。。。

经过自己的不断尝试，终于发现了，问题竟然出在，Timer的对象，不能替换，或者说，替换之前一定要注销掉原来的。。。一般出现在ViewStack里面的NavigatorContent里面的Timer事件。。。如果2次载入的NavigatorContent都是相同的，如果你没有在第二次载入之前注销掉Timer，而是在第二次重新new Timer 重新赋值的话，那么就会出现这种问题，就是，旧的Timer没有被完全被新的替换，可能还残留在内存中，所以。。。即使你对新的Timer调用stop() ，对残留在内存中的Timer却毫无作用。。。（PS：这算是BUG么？）

了解了问题之后，解决就简单了，每次切换ViewStack记得注销掉相应的Timer即可，这样就不会出现这个的问题了。。。