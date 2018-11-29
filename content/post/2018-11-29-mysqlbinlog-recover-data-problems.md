+++
date = "2018-11-28T18:05:09+08:00"
title = "记mysqlbinlog数据恢复遇到的问题"
categories = ["开发"]
tags = ["mysqlbinlog","恢复","mysql","db","binlog"]

+++

## 事件复盘
事情的原因是，手下一名开发在部署的时候，执行错了错误的脚本，把生产的一个重要的表的数据给清空了。

我得知消息后，登陆数据库确认了数据已被删除，立即公告停服维护，然后停掉从库同步，然后利用mysqlbinlog查找出删除语句所在的position。

幸亏db有个每日备份的脚本，所以我们只要把db恢复到最近的备份版本，然后只要执行备份时间到刚刚的position之间的sql就可以恢复回到删除前的状态。

利用
```
mysqlbinlog --start-datetime="YYYY-mm-dd HH:ii:ss" --stop-position="xxxxx" > recover.sql
```
就可以把恢复的sql导出来，然后只要执行这个sql就可以了。


## GTID的导致恢复数据没有生效的问题
本以为就这么结束了，没想到发现虽然执行完了，但是数据却没有写入到db里。查了一圈发现，原来是由于生产的服务器启用了GTID，所以在执行binlog恢复的时候，会自动跳过已经执行过的GTID命令，所以在执行mysqlbinlog时要加上--skip-gtids=true选项。
```sql
mysqlbinlog --skip-gtids=true
```


##  ERROR 1609 (HY000): Table_map的问题
在恢复的过程，有些binlog的内容无法正常解析导入，会提示错误：
`ERROR 1609 (HY000): The BINLOG statement of type Table_map was not preceded by a format description BINLOG statement`

这个问题还真心奇怪，网上找了一圈，能搜到的文章也寥寥无几，后面同事不停的尝试才发现了一个`神奇`的解决办法，是的，要用神奇来形容！

我们参考了知乎的一篇文章["mysqlbinlog工具使用的几个疑惑点和解释"](https://zhuanlan.zhihu.com/p/24689474)

里面提到
>即不管执行多少次同一个BINLOG，都无法成功。除非先执行了Format_description_event：
```
mysql> BINLOG '                                  > bTXkUw8KAAAAdQAAAHkAAAABAAQANS42LjE5LWxvZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
     > AAAAAAAAAAAAAAAAAAAAAAAAEzgNAAgAEgAEBAQEEgAAXQAEGggAAAAICAgCAAAACgoKGRkADQEe
     > sjFX
     > '/*!*/;  //这是一个Format_description_event
Query OK, 0 rows affected (0.00 sec)

mysql> BINLOG '
     > kTXkUxMKAAAALQAAAPoDAAAAAEgAAAAAAAEABHRlc3QAAnQzAAEDAAFS1mTW
     > kTXkUx4KAAAALQAAACcEAAAAAEgAAAAAAAEAAgAB//4BAAAA/gIAAAC52uck
     > '/*!*/;
Query OK, 0 rows affected (0.00 sec)
```
就是这个神奇的magic binlog，在执行完
```
BINLOG 'bTXkUw8KAAAAdQAAAHkAAAABAAQANS42LjE5LWxvZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEzgNAAgAEgAEBAQEEgAAXQAEGggAAAAICAgCAAAACgoKGRkADQEesjFX'/*!*/;
```
后，再执行之前有问题的table_map的语句居然就可以正常执行了。所以接下来的问题就好办了，所有执行binlog之前都让它先执行这条magic binlog就好了。

利用sed可以完成这个任务。
```
sed "s/BINLOG/BINLOG 'bTXkUw8KAAAAdQAAAHkAAAABAAQANS42LjE5LWxvZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEzgNAAgAEgAEBAQEEgAAXQAEGggAAAAICAgCAAAACgoKGRkADQEesjFX'\/\*\!\*\/;\nBINLOG/" NEED_REPLACE.sql > NEW.sql
```

## 总结
1. db的定时备份很重要，如果没有每日的备份，要从0恢复起来，这个过程和遇到问题肯定非常艰辛。
2. 注意导入过程中的ERROR 1609 (HY000): Table_map的报错，这会导致部分数据没有写入成功，从而丢失了数据。
3. 干死那个误操作的人。