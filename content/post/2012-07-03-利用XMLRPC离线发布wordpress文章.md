---
id: 857
title: 利用XMLRPC 离线发布wordpress 文章
date: 2012-07-03T10:14:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/857.html
permalink: /?p=857
categories:
  - 开发
tags:
  - wordpress
  - XMLRPC
  - 离线发布
---

还是直接上demo吧～～这样可以让大家更容易理解。。。



```php
<?php
include("xmlrpc.inc");
$GLOBALS['xmlrpc_internalencoding'] = 'UTF-8';
$c = new xmlrpc_client("/xmlrpc.php", "stutostu.com", 80);
$c->return_type = 'phpvals';
$content['title']="标题"; //标题
$content['description']="正文内容<img src='upload.jpg' />打死打伤阿斯顿"; //内容
$content['mt_keywords']="标签1,标签2"; //标签
$content['wp_password']=""; //文章密码，输入后显示加密
$content['categories'] = array("老木头"); //分类名
//如果需要查看是否存在此类，可以调用wp.getCategories来调用
/*
wp.getCategory demo
$x = new xmlrpcmsg( 'wp.getCategories' ,
    array
    (
        php_xmlrpc_encode("1"), //BLOG ID 填1就可以了
        php_xmlrpc_encode("用户名"),
        php_xmlrpc_encode("密码"),
    )
);
$r =$c->send($x);
print_r($r);
*/
//新建分类
$param = array(
    'name' => '偶尔陶醉',
    'slug' => 'something',//别名
    'parent_id' => 3,//父类ID，如果填0则为顶级分类，如果填其他分类ID，则为该类的子类
    'description' => '偶尔陶醉的分类'
);
//调用接口
$x = new xmlrpcmsg( 'wp.newCategory' ,
    array
    (
        php_xmlrpc_encode("1"), //BLOG ID 填1就可以了
        php_xmlrpc_encode("用户名"),
        php_xmlrpc_encode("密码"),
        php_xmlrpc_encode( $param )
    )
);
$r =$c->send($x);
//匹配图片，如果有图片，需要在发表文章前调用上传接口 把图片上传上去
$pattern = "/<img.+src=('|\"|)?(.*)(\\1)([\s].*)?>/ismUe";
preg_match_all ($pattern,$content['description'],$matches);
$img = array(
    'name'=>$matches[2][0],
    'type'=>mime_content_type( $matches[2][0] ),
    'bits'=>base64_encode(file_get_contents($matches[2][0])) //这里注意一定要转为字符串
);
//如果你安装我上述的操作进行，记得修改wordpress wp-include/class-wp-xmlrpc-server.php 文件
//找到4528行 或者 找到 function mw_newMediaObject 把 $bits = $data['bits']; 修改成 $bits = base64_decode($data['bits']);
//调用上传接口
$x = new xmlrpcmsg(
    'metaWeblog.newMediaObject',
    array
    (
        php_xmlrpc_encode("1"), //BLOG ID 填1就可以了
        php_xmlrpc_encode("用户名"),
        php_xmlrpc_encode("密码"),
        php_xmlrpc_encode($img)
    )
);
$c->return_type = 'phpvals';
$r =$c->send($x);
//把文章中的图片地址替换成上传后的
$content['description'] = str_replace( $matches[2][0] ,$r->val['url'] an>/* 返回上传后的图片地址 */ , $content['description'] );
$x = new xmlrpcmsg(
    "metaWeblog.newPost",
    array(
        php_xmlrpc_encode("1"), //BLOG ID 填1就可以了
        php_xmlrpc_encode("用户名"),
        php_xmlrpc_encode("密码"),
        php_xmlrpc_encode($content),
        php_xmlrpc_encode("1")
    )
); //立即发表
$r =$c->send($x);
if ($r->errno=="0")
    echo "发表成功，文章ID为：".$r->val;
else
    echo "出错了";

print_r($r);
}
```