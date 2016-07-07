---
id: 1225
title: 果然nginx使用socket来与php-fpm通讯是更高效率的
date: 2013-10-03T00:28:32+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1225
permalink: /?p=1225
categories:
  - 开发
tags:
  - nginx
  - PHP-FPM
  - socket
  - 通讯
---

## 1000次累加测试

### php5-fpm.sock下的测试结果

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
Time taken for tests:   1.773 seconds
Complete requests:      10000
Failed requests:        8603
   (Connect: 0, Receive: 0, Length: 8603, Exceptions: 0)
Write errors:           0
Non-2xx responses:      8603
Total transferred:      3196701 bytes
HTML transferred:       1576922 bytes
Requests per second:    5639.07 [#/sec] (mean)
Time per request:       88.667 [ms] (mean)
Time per request:       0.177 [ms] (mean, across all concurrent requests)
Transfer rate:          1760.39 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0   22 130.2      2    1009
Processing:     2   46  71.0     22     703
Waiting:        1   44  71.2     20     703
Total:          5   68 172.6     25    1701
Percentage of the requests served within a certain time (ms)
  50%     25
  66%     28
  75%     36
  80%     44
  90%    178
  95%    222
  98%    255
  99%   1241
 100%   1701 (longest request)
```

### 使用TCP方式下：

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
Time taken for tests:   10.283 seconds
Complete requests:      10000
Failed requests:        195
   (Connect: 0, Receive: 0, Length: 195, Exceptions: 0)
Write errors:           0
Non-2xx responses:      195
Total transferred:      1792565 bytes
HTML transferred:       113930 bytes
Requests per second:    972.44 [#/sec] (mean)
Time per request:       514.170 [ms] (mean)
Time per request:       1.028 [ms] (mean, across all concurrent requests)
Transfer rate:          170.23 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   6.1      0      35
Processing:    15  401 1389.5     91    8794
Waiting:       13  401 1389.4     91    8794
Total:         48  402 1393.7     91    8820
Percentage of the requests served within a certain time (ms)
  50%     91
  66%     94
  75%     97
  80%    101
  90%    130
  95%   1136
  98%   8735
  99%   8757
 100%   8820 (longest request)
```

## mysql select数据测试

### php5-fpm.sock下的测试结果

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
Time taken for tests:   2.259 seconds
Complete requests:      10000
Failed requests:        8276
   (Connect: 0, Receive: 0, Length: 8276, Exceptions: 0)
Write errors:           0
Non-2xx responses:      8276
Total transferred:      3924788 bytes
HTML transferred:       2302720 bytes
Requests per second:    4426.98 [#/sec] (mean)
Time per request:       112.944 [ms] (mean)
Time per request:       0.226 [ms] (mean, across all concurrent requests)
Transfer rate:          1696.77 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0   23 131.5      3    1005
Processing:     2   43  70.9     19    2199
Waiting:        1   41  71.1     17    2199
Total:          4   66 163.2     23    2199
Percentage of the requests served within a certain time (ms)
  50%     23
  66%     27
  75%     36
  80%     48
  90%    163
  95%    176
  98%    197
  99%   1023
 100%   2199 (longest request)
```

### 使用TCP方式下：

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
Time taken for tests:   14.971 seconds
Complete requests:      10000
Failed requests:        68
   (Connect: 0, Receive: 0, Length: 68, Exceptions: 0)
Write errors:           0
Non-2xx responses:      68
Total transferred:      6280484 bytes
HTML transferred:       4600960 bytes
Requests per second:    667.96 [#/sec] (mean)
Time per request:       748.548 [ms] (mean)
Time per request:       1.497 [ms] (mean, across all concurrent requests)
Transfer rate:          409.68 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   6.2      0      39
Processing:    10  376 1497.2     79   14927
Waiting:       10  376 1497.2     79   14927
Total:         48  378 1501.3     79   14954
Percentage of the requests served within a certain time (ms)
  50%     79
  66%     82
  75%     84
  80%     87
  90%     95
  95%   1081
  98%   7877
  99%   7910
 100%  14954 (longest request)
```

## 总结

果然nginx使用socket来与php-fpm通讯是更高效率的。。。