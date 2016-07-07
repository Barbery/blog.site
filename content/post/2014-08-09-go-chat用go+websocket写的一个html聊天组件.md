---
id: 1358
title: go-chat 用go+websocket写的一个html聊天组件
date: 2014-08-09T16:03:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1358
permalink: /?p=1358
categories:
  - 开发
tags:
  - go
  - go-chat
  - golang
  - html
  - websocket
---

最近闲着蛋疼，就折腾下go语言。。。据说go的长连接性能异常高效。。。so，我就用go+html5的websocket搞了个聊天组件玩玩。。。

经过几天的学习，我对go语言的评价是：快速，性能高效，goroutine很好用。go有着做大型项目的基因。。

### 怎么使用？

把下面的代码放到head标签中

<div class="dp-highlighter">
  <div class="bar">
  </div>

  <ol class="dp-xml">
    <li class="alt">
      <span><span class="tag"><</span><span class="tag-name">script</span><span>&nbsp;</span><span class="attribute">type</span><span>=</span><span class="attribute-value">"text/javascript"</span><span class="tag">></span><span>&nbsp; </span></span> <li>
        <span>&nbsp;&nbsp;&nbsp; <span class="attribute">window.onload</span><span> = </span><span class="attribute-value">function</span><span>() {&nbsp; </span></span> <li class="alt">
          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var <span class="attribute">js</span><span> = </span><span class="attribute-value">document</span><span>.createElement("script");&nbsp; </span></span> <li>
            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="attribute">js.type</span><span> = </span><span class="attribute-value">"text/javascript"</span><span>;&nbsp; </span></span> <li class="alt">
              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="attribute">js.src</span><span> = </span><span class="attribute-value">"http://stutostu.qiniudn.com/app.js"</span><span>;&nbsp; </span></span> <li>
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; document.getElementsByTagName("body")[0].appendChild(js);&nbsp; </span> <li class="alt">
                  <span>&nbsp;&nbsp;&nbsp; };&nbsp; </span> <li>
                    <span><span class="tag"></</span><span class="tag-name">script</span><span class="tag">></span><span>&nbsp; </span></span>
                  </li></ol> </div>
                  <p>
                    更多引入方式，请看：<a title="https://gist.github.com/Barbery/8f36d999193da2a29ab3" href="https://gist.github.com/Barbery/8f36d999193da2a29ab3">https://gist.github.com/Barbery/8f36d999193da2a29ab3</a>
                  </p>

                  <h3>
                    go-chat分为4个频道，分别为：
                  </h3>

                  <p>
                    <strong>本页面</strong>：这个频道是根据用户所在页面的url来建立的，不包括url上的？参数和#参数，即<a href="http://stutostu.com/page1">http://stutostu.com/page1</a> 和 <a href="http://stutostu.com/page1?param1=value1#aa">http://stutostu.com/page1?param1=value1#aa</a> 为同一个页面。使用场景：当你只想和访问这个页面的人交流的时候。
                  </p>

                  <p>
                    <strong>本域名</strong>：这个频道是根据用户所在页面的域名来建立的，即<a href="http://www.stutostu.com/page1.html">http://www.stutostu.com/page1.html</a> 和 <a href="http://www.stutostu.com/page2.html">http://www.stutostu.com/page2.html</a> 虽然所在页面不同，但是所在域名均为<a href="http://www.stutostu.com">www.stutostu.com</a> ，都可以通过这个频道跨页面进行聊天。使用场景：想和同一个域名的用户交流的时候。
                  </p>

                  <p>
                    <strong>根域名</strong>：这个频道是根据用户所在页面的根域名来建立的，即news.stutostu.com和blog.stutostu.com的根域名均为stutostu.com，所以均可通过这个频道进行交流。使用场景：如果你想和这个站的所有人交流的时候
                  </p>

                  <p>
                    <strong>世界</strong>：这个范围最大。。。无论在什么页面和域名，均可通过这个频道进行交流。使用场景：如果你想和所有使用go-chat的人交流的时候
                  </p>

                  <p>
                    <strong>注意：目前只能加入和订阅1个频道，例如你加入了世界频道，那么只能和世界频道的人进行交流，无法接收到其他频道发送的消息，也无法发送消息到其他频道。</strong>
                  </p>

                  <p>
                    &nbsp;
                  </p>

                  <p>
                    源码: <a title="https://github.com/Barbery/blog/tree/master/go-chat" href="https://github.com/Barbery/blog/tree/master/go-chat">https://github.com/Barbery/blog/tree/master/go-chat</a>
                  </p>