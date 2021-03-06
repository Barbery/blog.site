---
id: 1228
title: NGINX+PHP-FPM+SOCKET VS NGINX+PHP-FPM+TCP VS NGINX+APACHE+MOD_PHP
date: 2013-10-03T17:02:45+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1228
permalink: /?p=1228
categories:
  - 开发
tags:
  - APACHE
  - MOD_PHP
  - nginx
  - PHP-FPM
---

上一篇[果然nginx使用socket来与php-fpm通讯是更高效率](http://www.stutostu.com/?p=1225)中，测试了nginx 使用TCP与socket与php-fpm通讯的情况。。。

今天把apache给搞点了，正好验证下，究竟是NGINX+PHP-FPM效率好还是NGINX+APACHE+mod_php 效率好。。。

立即开搞，看ab测试记录。。。

## for 1000次累加测试

```
barbery@xie:~$ ab -c 500 -n 10000 http://localhost/bench/foreach_test.php
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/
Benchmarking localhost (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests
Server Software:        ngx_openresty/1.4.2.7
Server Hostname:        localhost
Server Port:            80
Document Path:          /bench/foreach_test.php
Document Length:        8 bytes
Concurrency Level:      500
Time taken for tests:   18.643 seconds
Complete requests:      10000
Failed requests:        218
   (Connect: 0, Receive: 0, Length: 218, Exceptions: 0)
Write errors:           0
Non-2xx responses:      218
Total transferred:      2187686 bytes
HTML transferred:       117932 bytes
Requests per second:    536.38 [#/sec] (mean)
Time per request:       932.173 [ms] (mean)
Time per request:       1.864 [ms] (mean, across all concurrent requests)
Transfer rate:          114.59 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    3  42.4      0    1000
Processing:    48  486 1895.6     99   14013
Waiting:       30  486 1895.6     99   14013
Total:         66  489 1899.5    100   14013
Percentage of the requests served within a certain time (ms)
  50%    100
  66%    107
  75%    113
  80%    120
  90%    153
  95%   1106
  98%   8848
  99%  12481
 100%  14013 (longest request)
```

## mysql select数据测试

```
barbery@xie:~$ ab -c 500 -n 10000 http://localhost/bench/mysql_test.php
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/
Benchmarking localhost (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests
Server Software:        ngx_openresty/1.4.2.7
Server Hostname:        localhost
Server Port:            80
Document Path:          /bench/mysql_test.php
Document Length:        462 bytes
Concurrency Level:      500
Time taken for tests:   14.451 seconds
Complete requests:      10000
Failed requests:        229
   (Connect: 0, Receive: 0, Length: 229, Exceptions: 0)
Write errors:           0
Non-2xx responses:      229
Total transferred:      6644659 bytes
HTML transferred:       4555880 bytes
Requests per second:    691.98 [#/sec] (mean)
Time per request:       722.565 [ms] (mean)
Time per request:       1.445 [ms] (mean, across all concurrent requests)
Transfer rate:          449.02 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   3.1      0      22
Processing:    84  600 2459.8    112   14425
Waiting:       84  600 2459.8    112   14425
Total:         84  601 2461.9    112   14439
Percentage of the requests served within a certain time (ms)
  50%    112
  66%    119
  75%    124
  80%    129
  90%    147
  95%   1105
  98%  14385
  99%  14390
 100%  14439 (longest request)
```


------

## 总结

为了更好的对比结果，我做了一个表格，成绩对比如下：

<img src="http://ww3.sinaimg.cn/large/6915c7dcgw1e983aheg9lj20la07sjsl.jpg" />

使用NGINX+PHP-FPM+TCP 和 NGINX+APACHE+MOD_PHP的测试结果不相上下。。。这个和网上各位博主测出来的结果相差不大。。。

<http://www.eschrade.com/page/why-is-fastcgi-w-nginx-so-much-faster-than-apache-w-mod_php/>这个博主就测出来，在关闭APACHE AllowOverride 可以获得性能上的提升，可以比NGINX+PHP-FPM+TCP高10～15%这样。。。比较可惜的是，该博主没有测使用NGINX+PHP-FPM+SOCKET的模式，也没有使用NIGNX+APACHE做方向代理的模式。。。

最后，这次的测试都在默认配置下进行，不排除NIGNX和APACHE在默认配置上的差异，导致结果悬殊。。但是，即便存在上述可能，NGINX+PHP-FPM+SOCKET的模式比NGINX+APACHE的测试结果高出10倍之多。。。差距如此之大也可以说明，NGINX+PHP-FPM+SOCKET才是王道。。。

如果你有不同的意见，欢迎交流。。。



PHP测试脚本：<https://github.com/Barbery/blog/tree/master/bench>