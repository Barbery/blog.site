---
id: 1351
title: 说说phalcon怎么连接mysqld.sock
date: 2014-07-18T11:11:00+00:00
author: 偶尔陶醉
layout: post
guid: http://www.stutostu.com/?p=1351
permalink: /?p=1351
categories:
  - 开发
tags:
  - mysql
  - PDO
  - phalcon
  - socket
---
phalcon官方的demo都是连接tcp的，没有连接unix socket的demo可以看。。看了下phalcon的源码，发现，原来phalcon的PDO支持DSN模式的。。。汗~~ 官方文档也没有说明一下。。。

查了下php官方的PDO是怎么连socket的，折腾了一下，终于搞掂。。。

    $db = new Phalcon\Db\Adapter\Pdo\Mysql([
        'dsn' => 'mysql:unix_socket=/var/run/mysqld/mysqld.sock;dbname=test;charset=utf8;',
        'username' => 'root',
        'password' => '****',
    ]);

注意哦，这个dsn，一定unix_socket放前面，如果你是

> mysql:dbname=test;unix_socket=/var/run/mysqld/mysqld.sock;&nbsp; //错误
>
> mysql:unix_socket=/var/run/mysqld/mysqld.sock;dbname=test; //正确