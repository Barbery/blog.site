---
id: 1285
title: 说说luasocket http的使用
date: 2013-12-01T19:54:06+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1285
permalink: /?p=1285
categories:
  - 开发
tags:
  - http
  - lua
  - luajit
  - luasocket
  - socket
---

luasocket包中的socket.http比较简单， 关于它的使用方法，网上内容也比较少， 常用的方法是GET和POST比较多。。。

GET的话， 可以直接传入URL地址，例如这样：

```go
local res, code = http.request("http://127.0.0.1/")
```

返回的2个参数中， res是http body的内容， 也就是请求网页的内容， code是http状态码， 返回200的话就表示正常返回。

也可以这样：

```go
local response_body = {}
local res, code = http.request({
  url = "http://127.0.0.1/",
  sink = ltn12.sink.table(response_body)
})
```

如果传入的是table的话， 就需要用一个容器来接收http body的内容， 也就是sink那个参数

POST的话就要这样：

```go
local response_body = {}
local post_data = 'asd';
res, code = http.request{
  url = "http://127.0.0.1/post.php",
  method = "POST",
  headers =
  {
    ["Content-Type"] = "application/x-www-form-urlencoded",
    ["Content-Length"] = #post_data,
  },
  source = ltn12.source.string('data=' .. post_data),
  sink = ltn12.sink.table(response_body)
}
```

这里注意记得method传入POST， 因为默认是GET， 然后就是要注意下headers参数， 由一个table组成， key为header， value为header内容， 最后注意的就是source参数， 这里是填入POST的参数， 多个数据的情况用&隔开， 例如"data1=a&data2=b"

POST这里的source和sink参数分别是由ltn2.source和ltn12.sink组成， 除了我举例的string和table， 还有file类型。。。

想了解更多？ 看看拓展阅读： <http://w3.impa.br/~diego/software/luasocket/ltn12.html>