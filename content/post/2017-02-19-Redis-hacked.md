+++
date = "2017-02-18T16:34:55+08:00"
title = "记一次redis被黑事件"
categories = ["开发"]
tags = ["redis", "被黑", "入侵"]

+++


## 事情的经过

* 当天0点多突然接到洪水般的队列报警信息，本应是返回数组的zrangebyscore方法，
返回是一个false的布尔类型，导致爆出了数据异常。当时深夜被报警叫醒，也没考虑太多，只是简单的做了个判断
过滤掉错误的数据。

* 早上9点，接到反馈，项目A微信授权出错。排查代码没有发现有问题，考虑到之前前端有出现上线时丢失文件的情况，
重新部署代码，本地测试故障解除。

* 早上10点，接到redis队列报警信息（Timed out attempting to find data in the correct node! ）

* 早上11点，接到反馈，项目B无法登陆，开始排查是否是redis集群的问题，发现master01节点无法连接，
slave节点也没有被选举成新的master节点，重启master01节点，服务恢复正常。




## 复盘

事情发生后，一直有个点让我想不明白，流量不大的情况下master的一个节点为什么会挂掉？退一万步来讲，
即是挂掉，为何slave节点没有“挺身而出”？

随即我对redis的日志进行排查，希望能得到什么信息，首先就先查看master01这个挂掉的节点日志，0点27分，
有几条错误日志，这个错误的时间和事发当天0点多的报警时间吻合，而且这个错误的内容直接导致了slave节点失联。


master01日志

```
17989:M 18 Feb 00:26:49.431 # Failed opening the RDB file root (in server root dir /var/spool/cron) for saving: Permission denied
17989:M 18 Feb 00:26:49.432 # Failed opening the RDB file root (in server root dir /var/spool/cron) for saving: Permission denied
17989:M 18 Feb 00:27:49.906 # Disconnecting timedout slave: SLAVE01IP:PORT
17989:M 18 Feb 00:27:49.906 # Connection with slave SLAVE01IP:PORT lost.
```

slave01日志

```
4720:S 18 Feb 00:27:49.908 # Connection with master lost.
4720:S 18 Feb 00:27:49.908 * Caching the disconnected master state.
4720:S 18 Feb 00:27:50.144 * Connecting to MASTER MASTER01IP:PORT
4720:S 18 Feb 00:27:50.144 * MASTER <-> SLAVE sync started
4720:S 18 Feb 00:27:50.146 * Non blocking connect for SYNC fired the event.
4720:S 18 Feb 00:27:50.147 * Master replied to PING, replication can continue...
4720:S 18 Feb 00:27:50.149 * (Non critical) Master does not understand REPLCONF listening-port: -NOAUTH Authentication required.
4720:S 18 Feb 00:27:50.150 * (Non critical) Master does not understand REPLCONF capa: -NOAUTH Authentication required.
4720:S 18 Feb 00:27:50.150 * Trying a partial resynchronization (request 005a426e630acfa4a64a082b02bb97cb8a0256ad:3731868328).
4720:S 18 Feb 00:27:50.151 # Unexpected reply to PSYNC from master: -NOAUTH Authentication required.
4720:S 18 Feb 00:27:50.151 * Discarding previously cached master state.
4720:S 18 Feb 00:27:50.151 * Retrying with SYNC...
4720:S 18 Feb 00:27:50.153 # MASTER aborted replication with an error: NOAUTH Authentication required.
```

上网一查，原来是被攻击了，攻击者连上了redis，然后利用redis的config set dir的漏洞，尝试去注入恶意执行代码到系统的crontab中执行，
幸亏我们是使用非root用户启动，攻击者的攻击被系统权限给阻止了。

redis的这个漏洞应该大家都知道，也包括我们，当初在部署redis集群的时候，就已经把服务器公网IP去掉，只允许应用在内网访问，
没想到也竟然会出这样的事情，难道是受到阿里云同机房下的其他账户机器的攻击？

我带着疑问向阿里云提交了工单，回复是:

> 您好 内网的默认策略是内网入方向 拒绝所有，出方向允许所有；

> 1 如果你是经典网络 您设置入方向允许0.0.0.0 的话 经典网络的内网都可以访问您的服务器了

> 2 同一安全组设置内网拒绝0.0.0.0  也是可以通的，请您知晓

我一直以为阿里云会自动隔离不同账户下的内网网络，防火墙上设置的内网允许我还以为是针对自己的机器的，
这下就栽了跟头，使用阿里云的其他同学要注意下了，看看自己的redis有没有限制好内网网络的权限了，
不然的话，很容易被内网下的其他账户的机器攻击。

## 反思

* 事情本可在影响面没扩大之前得到处理，当天凌晨redis队列突然出现异常时，本应该发现能基础服务的不正常，但是却没引起关注。

* 基础服务监控缺失，连redis接点不可用这么严重的事情都没能第一时间获取信息。

* redis安全措施没做好，虽然使用了非root用户启动，恶意代码也没能注入成功，但是明知redis这个高危的漏洞，却还是在防火墙配置上留下了漏洞。


## 最后的疑问

* 为什么slave和master失联后没能被选举成新的master节点?

* 为什么事发时应用没有捕捉到redis的异常错误？我们在本地尝试复现攻击，一旦save失败，
整个cluster立即不可用，所有依赖redis服务均会抛出异常，究竟攻击者对redis执行了什么命令，导致了这个情况？
