+++
date = "2018-06-11T19:22:09+08:00"
title = "imgcat--最佳的命令行图片浏览器"
categories = ["开发"]
tags = ["imgcat","mac","iterm2","xquartz"]

+++


## eog和feh
最近有个场景需要用到命令行去查看图片，google了一圈，尝试了一下`eog`和`feh`。

eog和feh差不多，feh在加载速度上会比eog快，但是这两种方式都非常麻烦，除了在server上会自动安装N多图形依赖外，还需要服务器的X11 forward，mac用户的话还需要安装X11的client `xquartz`，最让人崩溃的是，速度超级慢，不是网速的问题，server上打开一个30K的图片，本地的xquartz要加载出来起码要10秒左右。

## imgcat
如果是你`mac`+`iterm2`用户的话，这里我要严重推荐下一个最佳的命令行图片浏览器---`imgcat`, 忘掉那些X11的配置，忘掉本地的`xquartz`吧。

**注意：这个只能是iterm2这个ssh客户端能识别，所以前提条件是`mac`+`iterm2`用户**

现在只需要在服务器上[安装一下imgcat](https://gist.github.com/wesbos/eac5f93478002312db1f)

```
sudo curl -o /usr/local/bin/imgcat -O https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat && sudo chmod +x /usr/local/bin/imgcat
```

使用iterm2登陆服务器，直接运行下

```bash
imgcat YOUR_IMAGE
```

图片即可在命令行中加载出来。速度更是比上面说的eog和feh快了10倍以上。

### 请看效果图：

![效果图](http://ww1.sinaimg.cn/large/6915c7dcgy1fujs90hjxlj20q80pqad1.jpg)



