+++
date = "2017-03-19T21:29:27+08:00"
title = "PHP高并发下问题总结"
categories = ["开发"]
tags = ["问题", "RedisCluster", "phpredis", "redis集群", "高并发", "负载不均"]

+++


上周，我们搞了一个活动，没有预想到活动会那么火爆，最高峰的一天有6千万的PV，一周下来累计接近2.6亿的PV。
这么大的流量突然涌入，真是把我们杀个措手不及，最终还是要把接口往GO迁才能扛下来。其中也暴露出了不少问题。


## phpredis问题

### 超时问题

phpredis应该说是大家非常普遍使用的一个redis client，以往在单机redis下使用情况也非常稳定。但是非常遗憾的是，
在redis cluster模式下，phpredis非常不稳定，经常会出现超时的异常错误，例如：


> RedisClusterException: Timed out attempting to find data in the correct node!

> ErrorException: RedisCluster::setex(): connect() failed: Connection timed out

第一个问题的话，是早期的phpredis的一个BUG，使用新的版本或者使用phpredis的develop分支就可以解决了。
我们使用了最新的develop分之后，第一个问题就没再出现了，转而是常常出现问题而这种连接超时的情况，
这个问题暂时不知道如何解决。


### redis集群负载不均问题

使用phpredis还有一个问题是，读取策略的问题，请使用`RedisCluster::FAILOVER_DISTRIBUTE_SLAVES`的读取策略，
其他策略例如`RedisCluster::FAILOVER`，或者`RedisCluster::FAILOVER_DISTRIBUTE`，都会造成整个集群的负载非常不均衡。
使用`RedisCluster::FAILOVER`的话会导致redis读写都会发送给redis master机器，导致master和slave负载不均，
如果使用`RedisCluster::FAILOVER_DISTRIBUTE`虽然读会随机分发给master和slave，但是我们实际看到，slave机器负载和master的差异还是很大。
目前来看，使用`RedisCluster::FAILOVER_DISTRIBUTE_SLAVES`的读取策略是最佳的选择，但是同一个节点下的多个slave机器之间还是会存在负载差异。


### 性能损耗问题

phpredis在cluster模式下，有个额外的性能损耗问题，就是每次创建连接的时候，都会去获取一次cluster slots, 而由于
每次获取这个slots都是从seeds里面循环去获取，直至获取到slots信息，所以`new RedisCluster(null, $servers)`时，传入的servers中第一个会压力很大，
在高并发的情况下，频发的短链接创建，会直接导致redis集群负载不均，这也是导致了redis集群负载不均的一个原因。


## 阿里云相关

连接不稳定

> SQLSTATE[HY000] [2002] php_network_getaddresses: getaddrinfo failed: Name or service not known

坑爹阿里云，内网dns解析非常不稳定，大流量的情况下，连自家的RDS地址都不认了，解决办法：把IP地址写入host，缺点是，主从切换时需要手动更新IP。



## 系统其他

增大nf_conntrack_max参数，可以增大服务器的并发数

> sudo sysctl net.nf_conntrack_max=512000
