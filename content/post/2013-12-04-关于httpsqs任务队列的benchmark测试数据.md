---
id: 1297
title: 关于httpsqs任务队列的benchmark测试数据
date: 2013-12-04T17:27:20+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1297
permalink: /?p=1297
categories:
  - 开发
tags:
  - benchmark
  - httpsqs
  - 任务队列
---

选择httpsqs的原因是，轻量，高效，整个流程也在掌控之中，所以就没有选择比较成熟的Gearman。。

好了，看数据把：

## 100k times test about httpsqs

|  method | ab |  php | php with extension  | php reuse object  |  shell  |  lua  |
|---|---|---|---|---|
| GET(times/sec)  | 10927.82  |  2861.93 | 3605.92  | 5131.06  |  83.33 |  3903.2 |
|  POST(times/sec) |  7578.21 |  2686.34 | 3216.49  | 4219.84  | too slow | 4000 |

**test script**
<https://github.com/Barbery/blog/tree/master/httpsqs_benchmark>