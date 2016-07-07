---
id: 904
title: 使用CodeIgniter 创建 RESTful 服务 REST API【原创译文】
date: 2012-08-19T21:59:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/904.html
permalink: /?p=904
categories:
  - 开发
tags:
  - API
  - CodeIgniter
  - REST
  - RESTful
---

> 翻译之前，先简单介绍下自己的情况，避免误人子弟。。。本人英语不强（不是谦虚，真是很烂），我只是一个简简单单的CI程序猿。在现在到处都是RESTful服务的时代，我想大家都像我这样有一个疑问，怎么让CI机遇RESTful 服务工作呢。。。我上网一搜，发现有篇国外的文章非常不错，我就简单翻译下，纯粹当成备份了。。。
>
> 牛人可直接看原文，原文地址：<a title="http://net.tutsplus.com/tutorials/php/working-with-restful-services-in-codeigniter-2/" href="http://net.tutsplus.com/tutorials/php/working-with-restful-services-in-codeigniter-2/" target="_blank" rel="nofollow" >http://net.tutsplus.com/tutorials/php/working-with-restful-services-in-codeigniter-2/</a>

# <font style="font-weight: bold">介绍</font>

在现在这个时代，你很容易把例如blog，CMS等等的服务整合到自己的网站里面。有一件事你也许没想过就是利用CodeIgniter去创建API接口。尝试几个RESTful服务的实现方法后，我发现过程非常麻烦，而且缺少你所期望的一些RESTful的功能。所以我自己建了一个，这个教程将告诉你怎样去利用这些代码创建属于自己的REST API，而且我将举些例子告诉你如何与自己搭建的API进行交互。







# <font style="font-weight: bold">假设</font>

  * 你有自己的web 服务器，可以是本地localhost的，也可以是线上的，而且你知道如何去管理里面的问文件
      * 你必须阅读过<a title="CodeIgniter from Scratch" href="http://net.tutsplus.com/videos/screencasts/codeigniter-from-scratch-day-7-pagination/" target="_blank" rel="nofollow" >CodeIgniter from Scratch</a>教程（译者注：也就是懂得使用CodeIgniter框架）
          * 懂得怎么设置CodeIgniter
              * 懂一点点RESTful 服务知识</ul>
            这个教程将分成2个部分讲。第一部分将从学习如何搭建RESTful 服务说起，然后深入，第二部分将讲如何用多种方式与自己搭建的REST API交互。

            &nbsp;

            # <font style="font-weight: bold">第一部分---创建REST API</font>

            &nbsp;

            ##

            ##

            ## <font style="font-weight: bold">第一步：建立demo</font>

            首先，你需要从Git中下载一份 <a title="codeigniter-restserver" href="http://github.com/philsturgeon/codeigniter-restserver" target="_blank" rel="nofollow" >codeigniter-restserver</a> 代码回来。提取里面的代码，放置你的web server里面（<font color="#0000ff">译者注：下载方式如图所示，原作者的图片是Git改版前的，不适用于现在，所以本人斗胆替换掉了</font>）

            [<img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://ww3.sinaimg.cn/large/6915c7dcjw1e69wa2xfdyj20rx07d0u1.jpg" width="640" height="170" />](http://ww3.sinaimg.cn/large/6915c7dcjw1e69wa2xfdyj20rx07d0u1.jpg)

            下载回来解压后，你会发现这已经是一个完整的CodeIgniter框架。这样可以让大家完整的使用这个 REST demo，而不用添加进自己的文件里才能使用。

            打开<font color="#c0504d"><em>“application/config/config.php”</em> ，</font><font color="#666666">根据自己的情况设置base_url。。（<font color="#0000ff">译者注：其实就是CI的根目录的地址，这个我想用过CI的都懂吧。如果你真的什么都不懂，那么你把下载回来后的文件解压，然后重命名为restserver，把整个文件夹丢到WWW根目录下，把base_url设置成如图所示</font>）</font>

            [<img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="set-base-url" border="0" alt="set-base-url" src="http://ww4.sinaimg.cn/large/6915c7dcjw1e69waq8uqlj20eu04m3yv.jpg" width="640" height="202" />](http://ww4.sinaimg.cn/large/6915c7dcjw1e69waq8uqlj20eu04m3yv.jpg)

            &nbsp;



            ## <font style="font-weight: bold">第二步：了解URL</font>

            根据第一步的情况，解压好文件，配置好base\_url，我们就已经可以访问已经配置好RESTful的CodeIgniter框架了。。打开你的web server，输入你刚才设置的base\_url地址，看看是不是已经可以正常访问啦。。

            下面讲解下RESTful 的URL结构。基本情况如图所示：

            [<img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="url-disect-2" border="0" alt="url-disect-2" src="http://ww1.sinaimg.cn/large/6915c7dcjw1e69wb8qvu1j20go03b0sw.jpg" width="640" height="131" />](http://ww1.sinaimg.cn/large/6915c7dcjw1e69wb8qvu1j20go03b0sw.jpg)

            （<font color="#0000ff">译者注：这里的情况我就不多说了，只是说下RESTful的CodeIgniter与正常的情况下URL结构的差异，前面的传值和URL结构都和正常情况下一致，就是在最后添加了一个参数format，这里可以定义返回的类型</font>）

            关于format的类型情况，可以看下图

            [<img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="output-examples (1)" border="0" alt="output-examples (1)" src="http://ww2.sinaimg.cn/large/6915c7dcjw1e69wbsvrx6j20kc09pdgs.jpg" width="640" height="306" />](http://ww2.sinaimg.cn/large/6915c7dcjw1e69wbsvrx6j20kc09pdgs.jpg)

            为了让API提供更丰富的格式选择。。。format类型不仅仅只有上图所列举的3个情况，具体的类型如下所示：

              * **xml** – 几乎所有的语言都能识别XML格式
                  * **json** – 对javascript和PHP APP非常有用. (<font color="#0000ff">译者注：其实还有一个jsonp格式</font>)
                      * **csv** – 可以被电子表格程序打开
                          * **html** – 不解释
                              * **php** – 返回的PHP是可以被eval函数执行过的
                                  * **serialized** – 序列化格式，对PHP非常有用(<font color="#0000ff">译者注：原文有误，记得是有个d结尾</font>)</ul>
                                更RESTful的发送Content-type http 头部的方式将在后面提到。

                                &nbsp;

                                ## <font style="font-weight: bold">第三步：了解代码</font>

                                现在，你打开 “_<font color="#c0504d">application/controllers/example_api.php</font>_”你立即会发现一些与正常CodeIgniter 控制器不同的地方。

                                ### <font style="font-weight: bold">REST_Controller</font>

                                在MVC模式中，控制器是逻辑运算的中心。它们在用户请求或从控制器中获取数据时或者是需要输出html时，控制器的方法才会被调用。CodeIgniter 有它自己的逻辑来指挥控制器去怎么工作，但是我们现在情况和CodeIgniter不同，我们需要自己的REST\_Controller 类 去指挥 相关的REST 逻辑运算，所以我们需要继承REST\_Controller这个控制器。

                                正常情况下，我们的控制器是这样的

                                <div class="dp-highlighter">
                                  <div class="bar">
                                  </div>

                                  <ol class="dp-c">
                                    <li class="alt">
                                      <span><span><?php&nbsp;&nbsp; </span></span> <li>
                                        <span></span><span class="keyword">class</span><span> Example_api </span><span class="keyword">extends</span><span> Controller {&nbsp;&nbsp; </span></span> <li class="alt">
                                          <span>&nbsp; </span> <li>
                                            <span>}&nbsp;&nbsp; </span>
                                          </li></ol> </div>
                                          <p>
                                            现在我们需要变成这样
                                          </p>

                                          <div class="dp-highlighter">
                                            <div class="bar">
                                            </div>

                                            <ol class="dp-c">
                                              <li class="alt">
                                                <span><span><?php&nbsp;&nbsp;<br /> </span></span> <li>
                                                  <span></span><span class="keyword">require</span><span>(APPPATH'.libraries/REST_Controller.php');&nbsp;&nbsp; </span></span> <li class="alt">
                                                    <span>&nbsp; </span> <li>
                                                      <span></span><span class="keyword">class</span><span> Example_api </span><span class="keyword">extends</span><span> REST_Controller {&nbsp;&nbsp; </span></span> <li class="alt">
                                                        <span>&nbsp; </span> <li>
                                                          <span>}&nbsp;&nbsp; </span>
                                                        </li></ol> </div>
                                                        <p>
                                                          （<font color="#0000ff">译者注：只能require REST_Controller 不能加入autoload 里面，至于为什么，擦，我也不懂</font>）
                                                        </p>

                                                        <h3>
                                                          <font style="font-weight: bold">添加方法</font>
                                                        </h3>

                                                        <p>
                                                          现在，你已经建立一个空的控制器了，那么让我们开始添加一些方法进去。一般来说，你要根据需要的资源和相应的HTTP操作来命名方法名。所以，下面的代码中你将看到有<strong>user</strong>和<strong>users</strong> 2个方法。
                                                        </p>

                                                        <div class="dp-highlighter">
                                                          <div class="bar">
                                                          </div>

                                                          <ol class="dp-c">
                                                            <li class="alt">
                                                              <span><span><?php&nbsp;&nbsp; </span></span> <li>
                                                                <span></span><span class="keyword">require</span><span>(APPPATH'.libraries/REST_Controller.php');&nbsp;&nbsp; </span></span> <li class="alt">
                                                                  <span>&nbsp; </span> <li>
                                                                    <span></span><span class="keyword">class</span><span> Example_api </span><span class="keyword">extends</span><span> REST_Controller {&nbsp;&nbsp; </span></span> <li class="alt">
                                                                      <span>&nbsp; </span> <li>
                                                                        <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_get()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                          <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 返回关于1个用户的信息 </span><span>&nbsp; </span></span> <li class="alt">
                                                                              <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                  <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> users_get()&nbsp;&nbsp; </span></span> <li>
                                                                                    <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li class="alt">
                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 返回所有用户的信息 </span><span>&nbsp; </span></span> <li>
                                                                                        <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                          <span>}&nbsp;&nbsp; </span>
                                                                                        </li></ol> </div>
                                                                                        <p>
                                                                                          这看起来似乎有点奇怪，但是它可以让你使用一个相同的URL&nbsp; 根据实际的HTTP 请求来响应不同的动作。如果某人用了你不允许的方法去调用你的API，那么它会自动返回404错误码。如果你不太懂得HTTP动作的话，让我来解释下：
                                                                                        </p>

                                                                                        <h3>
                                                                                          <font style="font-weight: bold">GET</font>
                                                                                        </h3>

                                                                                        <p>
                                                                                          <font style="font-weight: bold">不解释</font><br />

                                                                                          <h3>
                                                                                            <font style="font-weight: bold">POST</font>
                                                                                          </h3>

                                                                                          <p>
                                                                                            不解释
                                                                                          </p>

                                                                                          <h3>
                                                                                            <font style="font-weight: bold">PUT</font>
                                                                                          </h3>

                                                                                          <p>
                                                                                            比较少用的一个HTTP动作，大多数浏览器都不支持，PUT动作用于创建一个资源。（<font color="#0000ff">译者注：与delete对应</font>）<br />

                                                                                            <h3>
                                                                                              <font style="font-weight: bold">DELETE</font>
                                                                                            </h3>

                                                                                            <p>
                                                                                              和PUT一样，很少用到。DELETE动作用于删除一个资源.

                                                                                              <p>
                                                                                                （<font color="#0000ff">译者注：其实GET,POST已经可以完全替代PUT和DELETE的功能，所以后面2个动作非常少用到</font>）

                                                                                                <p>
                                                                                                  如果我们把上面的代码，改成允许每个HTTP动作来响应请求user的资源，则，可以写成这样：
                                                                                                </p>

                                                                                                <div class="dp-highlighter">
                                                                                                  <div class="bar">
                                                                                                  </div>

                                                                                                  <ol class="dp-c">
                                                                                                    <li class="alt">
                                                                                                      <span><span><?php&nbsp;&nbsp; </span></span> <li>
                                                                                                        <span></span><span class="keyword">require</span><span>(APPPATH'.libraries/REST_Controller.php');&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                          <span>&nbsp; </span> <li>
                                                                                                            <span></span><span class="keyword">class</span><span> Example_api </span><span class="keyword">extends</span><span> REST_Controller {&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                              <span>&nbsp; </span> <li>
                                                                                                                <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_get()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                  <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// respond with information about a user </span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 返回一个用户信息 </span><span>&nbsp; </span></span> <li>
                                                                                                                        <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                          <span>&nbsp; </span> <li>
                                                                                                                            <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_put()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                              <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// create a new user and respond with a status/errors </span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 创建一个新用户和返回对应的状态码 </span><span>&nbsp; </span></span> <li>
                                                                                                                                    <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                      <span>&nbsp; </span> <li>
                                                                                                                                        <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_post()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                          <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// update an existing user and respond with a status/errors </span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 更新一个已存在的用户信息和返回对应的状态码 </span><span>&nbsp; </span></span> <li>
                                                                                                                                                <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                  <span>&nbsp; </span> <li>
                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_delete()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// delete a user and respond with a status/errors </span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="comment">// 删除一个用户和返回响应状态码 </span><span>&nbsp; </span></span> <li>
                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                              <span>}&nbsp;&nbsp; </span>
                                                                                                                                                            </li></ol> </div>
                                                                                                                                                            <p>
                                                                                                                                                              &nbsp;
                                                                                                                                                            </p>

                                                                                                                                                            <h3>
                                                                                                                                                              <font style="font-weight: bold">接受参数和返回数据</font>
                                                                                                                                                            </h3>

                                                                                                                                                            <p>
                                                                                                                                                              so,现在的控制器已经添加好相应的方法来响应不同的HTTP动作了，我们现在需要接受一些参数，然后我们可以使用CodeIgniter里的model和library的方法。正因为有这个好处，我们才使用CodeIgniter来建立我们的API，当然，我们也可以使用我们项目中已经存在的models和libraryies里的方法，而不用重新写过。
                                                                                                                                                            </p>

                                                                                                                                                            <div class="dp-highlighter">
                                                                                                                                                              <div class="bar">
                                                                                                                                                              </div>

                                                                                                                                                              <ol class="dp-c">
                                                                                                                                                                <li class="alt">
                                                                                                                                                                  <span><span><?php&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                    <span></span><span class="keyword">require</span><span>(APPPATH'.libraries/REST_Controller.php');&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                      <span>&nbsp; </span> <li>
                                                                                                                                                                        <span></span><span class="keyword">class</span><span> Example_api </span><span class="keyword">extends</span><span> REST_Controller {&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                          <span>&nbsp; </span> <li>
                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_get()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$data</span><span> = </span><span class="keyword">array</span><span>('returned: '. </span><span class="vars">$this</span><span>->get('id'));&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$data</span><span>);&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                        <span>&nbsp<br /> ;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_post()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$data</span><span> = </span><span class="keyword">array</span><span>('returned: '. </span><span class="vars">$this</span><span>->post('id'));&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$data</span><span>);&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                  <span>&nbsp; </span> <li>
                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_put()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$data</span><span> = </span><span class="keyword">array</span><span>('returned: '. </span><span class="vars">$this</span><span>->put('id'));&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$data</span><span>;&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                              <span>&nbsp; </span> <li>
                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_delete()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$data</span><span> = </span><span class="keyword">array</span><span>('returned: '. </span><span class="vars">$this</span><span>-></span><span class="func">delete</span><span>('id'));&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$data</span><span>);&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                          <span>}&nbsp;&nbsp; </span>
                                                                                                                                                                                                                        </li></ol> </div>
                                                                                                                                                                                                                        <h3>
                                                                                                                                                                                                                          <font style="font-weight: bold">$this->get()</font>
                                                                                                                                                                                                                        </h3>

                                                                                                                                                                                                                        <p>
                                                                                                                                                                                                                          用来接收GET参数
                                                                                                                                                                                                                        </p>

                                                                                                                                                                                                                        <h3>
                                                                                                                                                                                                                          <font style="font-weight: bold">$this->post()</font>
                                                                                                                                                                                                                        </h3>

                                                                                                                                                                                                                        <p>
                                                                                                                                                                                                                          是CodeIgniter内置方法$this->input->post() 的别名，用来接收$_POST参数, 受到XSS保护。
                                                                                                                                                                                                                        </p>

                                                                                                                                                                                                                        <h3>
                                                                                                                                                                                                                          <font style="font-weight: bold">$this->put()</font>
                                                                                                                                                                                                                        </h3>

                                                                                                                                                                                                                        <p>
                                                                                                                                                                                                                          接收put参数<br />

                                                                                                                                                                                                                          <h3>
                                                                                                                                                                                                                            <font style="font-weight: bold">$this->delete()</font>
                                                                                                                                                                                                                          </h3>

                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                            接收delete参数
                                                                                                                                                                                                                          </p>

                                                                                                                                                                                                                          <h3>
                                                                                                                                                                                                                            <font style="font-weight: bold">$this->response()</font>
                                                                                                                                                                                                                          </h3>

                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                            发送数据给浏览器，数据格式是什么，默认是XML格式，你可以设置返回的HTTP状态码，例如用户这个例子，加入ID不存在，你可以使用 $this->response(array(‘error’ => ‘User not found.’), 404);
                                                                                                                                                                                                                          </p>

                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                            &nbsp;<br />

                                                                                                                                                                                                                            <h2>
                                                                                                                                                                                                                              <font style="font-weight: bold">第四步：使用你的Models</font>
                                                                                                                                                                                                                            </h2>

                                                                                                                                                                                                                            <p>
                                                                                                                                                                                                                              从开始到现在，一个简单的DEMO API已经可以正常运行了。所以，下一步让我们用我们自己的Models来运行这些API
                                                                                                                                                                                                                            </p>

                                                                                                                                                                                                                            <p>
                                                                                                                                                                                                                              <a href="http://ww1.sinaimg.cn/large/6915c7dcjw1e69wci0p2tj205j0dt3z6.jpg"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="restserver-important-files" border="0" alt="restserver-important-files" src="http://ww1.sinaimg.cn/large/6915c7dcjw1e69wci0p2tj205j0dt3z6.jpg" width="203" height="501" /></a>
                                                                                                                                                                                                                            </p>

                                                                                                                                                                                                                            <p>
                                                                                                                                                                                                                              从下载回来的CodeIgniter中找到上图显示的2个文件，具体位置如下：
                                                                                                                                                                                                                            </p>

                                                                                                                                                                                                                            <ul>
                                                                                                                                                                                                                              <li>
                                                                                                                                                                                                                                application/config/rest.php <li>
                                                                                                                                                                                                                                  application/libraries/REST_Controller.php
                                                                                                                                                                                                                                </li></ul>
                                                                                                                                                                                                                                <p>
                                                                                                                                                                                                                                  把这2个文件拷入你现有的项目里面，位置不变。下面的完整项目的控制器demo
                                                                                                                                                                                                                                </p>

                                                                                                                                                                                                                                <div class="dp-highlighter">
                                                                                                                                                                                                                                  <div class="bar">
                                                                                                                                                                                                                                  </div>

                                                                                                                                                                                                                                  <ol class="dp-c">
                                                                                                                                                                                                                                    <li class="alt">
                                                                                                                                                                                                                                      <span><span><?php&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                        <span></span><span class="keyword">require</span><span>(APPPATH.'/libraries/REST_Controller.php');&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                          <span>&nbsp; </span> <li>
                                                                                                                                                                                                                                            <span></span><span class="keyword">class</span><span> Api </span><span class="keyword">extends</span><span> REST_Controller&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                              <span>{&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_get()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">if</span><span>(!</span><span class="vars">$this</span><span>->get('id'))&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(NULL, 400);&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                            <span>&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$user</span><span> = </span><span class="vars">$this</span><span>->user_model->get( </span><span class="vars">$this</span><span>->get('id') );&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">if</span><span>(</span><span class="vars">$user</span><span>)&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$user</span><span>, 200); </span><span class="comment">// 200 being the HTTP response code </span><span>&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                          <span>&nbsp; </span> <li>
                                                                                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">else</span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(NULL, 404);&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> user_post()&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$result</span><span> = </span><span class="vars">$this</span><span>->user_model->update( </span><span class="vars">$this</span><span>->post('id'), </span><span class="keyword">array</span><span>(&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'name' => </span><span class="vars">$this</span><span>->post('name'),&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'email' => </span><span class="vars">$this</span><span>->post('email')&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ));&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">if</span><span>(</span><span class="vars">$result</span><span> === FALSE)&<br /> nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="keyword">array</span><span>('status' => 'failed'));&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">else</span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="keyword">array</span><span>('status' => 'success'));&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                              <span>&nbsp;&nbsp;&nbsp; </span><span class="keyword">function</span><span> users_get()&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$users</span><span> = </span><span class="vars">$this</span><span>->user_model->get_all();&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">if</span><span>(</span><span class="vars">$users</span><span>)&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                          <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(</span><span class="vars">$users</span><span>, 200);&nbsp;&nbsp; </span></span> <li>
                                                                                                                                                                                                                                                                                                                                            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                              <span>&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="keyword">else</span><span>&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                                  <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                                                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class="vars">$this</span><span>->response(NULL, 404);&nbsp;&nbsp; </span></span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                                      <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                                                        <span>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; </span> <li class="alt">
                                                                                                                                                                                                                                                                                                                                                          <span>}&nbsp;&nbsp; </span> <li>
                                                                                                                                                                                                                                                                                                                                                            <span>?>&nbsp;&nbsp; </span>
                                                                                                                                                                                                                                                                                                                                                          </li></ol> </div>
                                                                                                                                                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                                                                                                                                                            这是一个通用型的demo，在第一个方法中，我们先把判断是否有id这个参数，如果没有就返回400状态码，如果有则继续执行，让user_model去获取user，有则返回数据，并返回200状态码，没则返回null以及404状态码。
                                                                                                                                                                                                                                                                                                                                                          </p>

                                                                                                                                                                                                                                                                                                                                                          <h3>
                                                                                                                                                                                                                                                                                                                                                            <font style="font-weight: bold">第五步: API安全</font>
                                                                                                                                                                                                                                                                                                                                                          </h3>

                                                                                                                                                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                                                                                                                                                            现在，你的API已经建立好了。你需要给予相应的调用权限来保护它。设置登陆权限，用户名密码等可以打开 <em>“<font color="#c0504d">application/config/rest.php</font>”文件来修改。</em>
                                                                                                                                                                                                                                                                                                                                                          </p>

                                                                                                                                                                                                                                                                                                                                                          <ol>
                                                                                                                                                                                                                                                                                                                                                            <li>
                                                                                                                                                                                                                                                                                                                                                              $config['rest_auth'] = 'basic';&nbsp; <font color="#008000">//设置REST权限</font>
                                                                                                                                                                                                                                                                                                                                                            </li>
                                                                                                                                                                                                                                                                                                                                                          </ol>

                                                                                                                                                                                                                                                                                                                                                          <h3>
                                                                                                                                                                                                                                                                                                                                                            <font style="font-weight: bold">None</font>
                                                                                                                                                                                                                                                                                                                                                          </h3>

                                                                                                                                                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                                                                                                                                                            设置为None的话，所有人都可以调用这个API.<br />

                                                                                                                                                                                                                                                                                                                                                            <h3>
                                                                                                                                                                                                                                                                                                                                                              <font style="font-weight: bold">Basic</font>
                                                                                                                                                                                                                                                                                                                                                            </h3>

                                                                                                                                                                                                                                                                                                                                                            <p>
                                                                                                                                                                                                                                                                                                                                                              设置为Basic的话，是一个相对不安全的登录方法，它应该只用于内部/安全网络.<br />

                                                                                                                                                                                                                                                                                                                                                              <h3>
                                                                                                                                                                                                                                                                                                                                                                <font style="font-weight: bold">Digest</font>
                                                                                                                                                                                                                                                                                                                                                              </h3>

                                                                                                                                                                                                                                                                                                                                                              <p>
                                                                                                                                                                                                                                                                                                                                                                这是一个更安全的选项，需要加密的用户名和密码，如果你想受保护的API让有权限的人调用，使用这个选项。

                                                                                                                                                                                                                                                                                                                                                                <p>
                                                                                                                                                                                                                                                                                                                                                                  &nbsp;

                                                                                                                                                                                                                                                                                                                                                                  <ol>
                                                                                                                                                                                                                                                                                                                                                                    <li>
                                                                                                                                                                                                                                                                                                                                                                      $config['rest_valid_logins'] = array('admin' => '1234');&nbsp;
                                                                                                                                                                                                                                                                                                                                                                    </li>
                                                                                                                                                                                                                                                                                                                                                                  </ol>

                                                                                                                                                                                                                                                                                                                                                                  <p>
                                                                                                                                                                                                                                                                                                                                                                    这个选项中，可以设置用户的账号和密码，账号是array的key，密码则是对应的value；你可以添加尽可能多的有权限调用你的API的用户进来。
                                                                                                                                                                                                                                                                                                                                                                  </p>

                                                                                                                                                                                                                                                                                                                                                                  <p>
                                                                                                                                                                                                                                                                                                                                                                    &nbsp;
                                                                                                                                                                                                                                                                                                                                                                  </p>

                                                                                                                                                                                                                                                                                                                                                                  <p>
                                                                                                                                                                                                                                                                                                                                                                    （<font color="#0000ff">译者注：第一部分到此结束。。。有点累，第二部分下次再翻译了。。。预告一下，下一部分主要讲如何建立公开调用的REST API，例如twitter API&nbsp; ， 新浪API&nbsp; 等等</font>）
                                                                                                                                                                                                                                                                                                                                                                  </p>