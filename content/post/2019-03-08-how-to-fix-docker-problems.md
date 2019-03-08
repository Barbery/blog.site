+++
date = "2019-03-08T14:59:09+08:00"
title = "docker翻车记"
categories = ["开发"]
tags = ["docker","daemon","error","OCI","network"]

+++


## Error starting daemon: Error initializing network controller: list bridge addresses failed: no available network
如果你的docker daemon启动不起来，可以试试用dockerd启动，看看打印出来的日志是什么错误，如果是这个错误的话，需要手动创建一个docker0的network，正常情况下运行`ifconfig` 都能看到有一个叫docker0网络，如果不知道什么原因没了，就会导致docker启动的问题，正确的处理办法是手动创建回来。
```
sudo brctl addbr docker0
sudo ip addr add 172.10.0.0/24 dev docker0
sudo ip link set dev docker0 up
ip addr show docker0
sudo service docker restart
sudo iptables -t nat -L -n
```

## could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network
这个错误本质上也是网络的错误，可以试试上面的方法，不行的话可以到`/etc/docker/daemon.json`下添加以下配置
```
{
    "default-address-pools": [
    {"base":"172.16.0.0/16","size":24}
  ],
}
```


## Service 'xxxx' failed to build: OCI runtime create failed: container_linux.go:348
最坑是这个错误，毫无头绪，google许久也没找到解决办法，正怪自己为什么手贱升级了docker的版本的时候，突然想起来会不会是版本和系统不兼容导致的，换了个关键词google，果然如此，最新版本的`18.06.2~ce~3-0~ubuntu`和`ubunut 14.04 LTS`有兼容性问题。参考[Latest package on Ubuntu trusty/14.04 (18.06.2~ce~3-0~ubuntu) is broken with runc ](https://github.com/docker/for-linux/issues/591)文章，最后的解决办法是先降级docker。
```
apt install docker-ce=18.06.1~ce~3-0~ubuntu
```