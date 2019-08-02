+++
date = "2019-08-02T15:24:09+08:00"
title = "记一次goroutine内存泄露"
categories = ["开发"]
tags = ["go","goroutine","内存泄露","泄露"]


+++

最近上线了一版go的代码，发现居然有内存溢出。。。找了好久没发现是什么原因，打开了`net/http/pprof`到线上收集goroutine的栈信息，居然神奇的发现，泄露的全部是底层的库？？？

截取部分如下：
```
goroutine 39381 [IO wait, 147 minutes]:
internal/poll.runtime_pollWait(0x7fb1bd640f00, 0x72, 0xffffffffffffffff)
    /usr/local/Cellar/go/1.12.7/libexec/src/runtime/netpoll.go:182 +0x56
internal/poll.(*pollDesc).wait(0xc002540e18, 0x72, 0x1000, 0x1000, 0xffffffffffffffff)
    /usr/local/Cellar/go/1.12.7/libexec/src/internal/poll/fd_poll_runtime.go:87 +0x9b
internal/poll.(*pollDesc).waitRead(...)
    /usr/local/Cellar/go/1.12.7/libexec/src/internal/poll/fd_poll_runtime.go:92
internal/poll.(*FD).Read(0xc002540e00, 0xc0010ef000, 0x1000, 0x1000, 0x0, 0x0, 0x0)
    /usr/local/Cellar/go/1.12.7/libexec/src/internal/poll/fd_unix.go:169 +0x19b
net.(*netFD).Read(0xc002540e00, 0xc0010ef000, 0x1000, 0x1000, 0x1, 0x42f1dc, 0xc0024cdb88)
    /usr/local/Cellar/go/1.12.7/libexec/src/net/fd_unix.go:202 +0x4f
net.(*conn).Read(0xc0015e35b8, 0xc0010ef000, 0x1000, 0x1000, 0x0, 0x0, 0x0)
    /usr/local/Cellar/go/1.12.7/libexec/src/net/net.go:177 +0x69
net/http.(*persistConn).Read(0xc00119fe60, 0xc0010ef000, 0x1000, 0x1000, 0xc0024cdc88, 0x404de5, 0xc002512180)
    /usr/local/Cellar/go/1.12.7/libexec/src/net/http/transport.go:1524 +0x7b
bufio.(*Reader).fill(0xc002897500)
    /usr/local/Cellar/go/1.12.7/libexec/src/bufio/bufio.go:100 +0x10f
bufio.(*Reader).Peek(0xc002897500, 0x1, 0x0, 0x0, 0x1, 0xc002255600, 0x0)
    /usr/local/Cellar/go/1.12.7/libexec/src/bufio/bufio.go:138 +0x4f
net/http.(*persistConn).readLoop(0xc00119fe60)
    /usr/local/Cellar/go/1.12.7/libexec/src/net/http/transport.go:1677 +0x1a3
created by net/http.(*Transport).dialConn
    /usr/local/Cellar/go/1.12.7/libexec/src/net/http/transport.go:1357 +0xae8

goroutine 39382 [select, 147 minutes]:
net/http.(*persistConn).writeLoop(0xc00119fe60)
    /usr/local/Cellar/go/1.12.7/libexec/src/net/http/transport.go:1976 +0x113
created by net/http.(*Transport).dialConn
    /usr/local/Cellar/go/1.12.7/libexec/src/net/http/transport.go:1358 +0xb0d
```

这。。。就不科学了，作为我大google亲儿子的go怎么可能会出现这种情况，肯定是我的锅。。

一番google之后，直到我看到了官方文档的这段话:`Clients and Transports are safe for concurrent use by multiple goroutines and for efficiency should only be created once and re-used.`

原来是transport重复创建的问题，因为transport默认是长连接的，导致goroutine完成后，堆栈里的fd没办法释放，以至于goroutine内存泄露。正确的做法是把transport移到init初始化，创建一个全局变量存储，后续请求全部复用一个transport。

至此，问题得到完美解决。。。