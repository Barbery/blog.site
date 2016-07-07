---
id: 1406
title: 说说怎么给virtualbox扩容
date: 2015-11-19T16:39:13+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1406
permalink: /?p=1406
categories:
  - 开发
tags:
  - docker
  - vagrant
  - virtualbox
  - 容量
  - 扩容
---

前几天用vagrant+virtualbox+docker 来搭建本地开发环境，由于要导入的SQL太大，virtualbox的容量被挤爆了，而vagrant创建时似乎是不能指定容量大小的，系统默认分配的16G明显不够用。。。上网找了下，有些教程操作过程中报错，没法进行下去，有些教程又很长，看起来很复杂。。。自己折腾了下，其实非常简单。

首先找到自己box的安装位置，默认应该都是安装在 ~/VirtualBox VMs/default-xxxxxxx/ 下的，打开命令行终端，进入目录下。。。如果你发现你的xxxx.vdi格式的话，那么恭喜你，这个格式扩容很简单，直接执行

> $> VBoxManage modifyhd xxxx.vdi  --resize 30000

后面30000代表30000MB约等于30G，根据自己的实际需要调整。

实际上，我们看到的文件格式很大概率是xxxxxx.vmdk，不用怕，也很简单。。。

首先，先利用virtualbox提供的工具，将其格式转换成vdi。。。

> $> VBoxManage clonehd xxxx.vmdk xxxx.vdi --format=vdi

等待一会儿，转换完成后，就会在目录上出现一个xxxx.vdi的文件，这个文件就是克隆自你原来的那个文件，只是把格式换成了vdi，再执行上面我说的扩容的命令，就可以实现这个vdi的容量扩容。

扩容完成后，打开virtualbox GUI程序（就是点击virtualbox图标运行界面程序），找到你刚刚扩容的那个box，右键设置->储存，在储存器 IDE Controller那里点击添加磁盘

![图片](http://ww2.sinaimg.cn/large/6915c7dcgw1ey6dbhb450j207x067mxg.jpg)

然后选择”选择现有虚拟盘”选项，找到刚刚生成的vdi文件，添加进去，然后点击之前的盘符，点击下方的删除磁盘的ico删掉即可（请先自行备份之前的文件）

还有一点，就是要保证添加进来的vdi磁盘设置如下所示。

![图片](http://ww3.sinaimg.cn/large/6915c7dcgw1ey6dfr4ckfj207x0650t4.jpg)