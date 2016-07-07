---
id: 1413
title: 说说用docker-swarm部署集群的一些问题
date: 2016-04-20T11:18:13+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1413
permalink: /?p=1413
categories:
  - 开发
tags:
  - docker
  - swarm
  - 部署
  - 集群
---
 

部署比较简单，这点官网文档说的非常详细，这里我就不重复叙述了，大家可以去看看

<https://docs.docker.com/swarm/install-manual/>

 

说说过程中遇到的问题，也希望后来者可以少踩坑。。。

首先就是部署前，要把docker engine配置到监听swarm的端口

> sudo vim /etc/default/docker
>
> #追加配置到DOCKER_OPTS配置项
>
> DOCKER_OPTS="-H 0.0.0.0:2375 -H unix:///var/run/docker.sock"

 

docker的id冲突时需要删掉key文件，重启service就可以重新生成

>  rm /etc/docker/key.json
>
> sudo service docker restart

 

还有一个就是discovery服务的话，consul目前还不支持多个节点ip，所以如果你有多个manage的节点也只能连一个consul的节点。。