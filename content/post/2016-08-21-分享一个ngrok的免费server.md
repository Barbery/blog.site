+++
date = "2016-08-21T11:02:31+08:00"
title = "分享一个ngrok的免费server"
categories = ["开发"]
tags = ["ngrok", "免费", "server", "微信调试"]
+++

ngrok是一个开源的内网穿透的工具，简单点说就是解决外网访问内网的问题，你可以把外网的80端口随意绑定到
内网的某个端口上，日常开发中多用于调试微信支付或者微信的测试公众号。

虽说ngrok是开源的，但是还是需要一个server端去做转发，如果自己搞就太麻烦了，这里推荐一个不错的免费ngrok server
(http://www.ngrok.cc/)

注册一个账号，登陆进去就可以创建一个穿透的隧道，把需要绑定的信息填写好，就会自动生成一个clientid，
把客户端下载到本地解压出来，执行

```bash
./sunny clientid {你的clientid}
```

启动完毕后，你会看到有个http://127.0.0.1:4040/http/in 的地址，这个是ngrok的web管理界面，
可以看到所有的request和response，是不是很方便呐！

目前ngrok还没能设置以daemon的方式启动，不过我们可以用别的方法来实现在后台运行，只要把ngrok的日志输出重定向一下，
就可以使用nohup命令来启动，例如这样：

```
nohup ./sunny -log=stdout > /dev/null &
```