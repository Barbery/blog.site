+++
date = "2021-04-09T17:56:09+08:00"
title = "关于docker internal ip冲突的问题"
categories = ["开发"]
tags = ["docker","docker_internal","ip冲突"]
+++

今天在阿里云上，一台ESC死活连接不了另外一台ESC，VPC的设置和云企业网的设置都没问题，安全组策略也都放行，
就是死活连接不上，无果只能找阿里云客服，阿里云的客服真是出了名的效率低下，沟通了几个小时后，最终才定位到真正的原因。
原因是另外ESC的brige网络和VPC的网段冲突了，只能想办法把docker-compose自动生成的brige的ip改了。

找了一圈，好像都是教你怎么改docker0的ip，试了下各种配置，都没办法对brige生效。看来只能手动修改了。。。
```
# 先把旧的brige删掉,进入你的目录停掉应用
docker-compose down
# 看下docker_internal这个网络的ID是啥
docker network ls
# 把 $ID 换成你查到的ID
docker network rm $ID
# 手动创建一个docker_internal网络并指定ip
docker network create --driver=bridge --subnet=172.1.0.0/24 docker_internal
# 重新启动应用
docker-compose up -d
```

弄完后，可以ifconfig看一下，是不是br-\*这个网络变成了我们指定的网段
