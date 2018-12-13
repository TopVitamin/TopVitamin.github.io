---
title: shadowsocks搭建的一些记录
date: 2018-12-01 22:27:24
tags: ss
categories: 技术相关

---

> 记录一下网上收集的SS的一些教程，防止每次都需要去别的地方找来找去啦，同时也可以对自己已有的知识进行一个归类和整理，虽然写技术教程真的很花时间，而且很繁琐。


![1544693953(1).jpg](https://i.loli.net/2018/12/13/5c1228d1cb5b1.jpg)


<!--more-->

## 1、准备工作

首先准备一台海外的VPS一台，同时用Xshell连接上，系统的话建议用centOS6+就OK。

至于VPS的话，可以考虑搬瓦工，vultr，GCP，或者其他的VPS服务商，随意即可。



## 2、运行BBR脚本

通过脚本一键升级内核并安装BBR加速。

Linux系统中root用户拥有最高权限,，同时考虑到一些兼容性和权限的问题你，建议先切换到root用户,，否则运行某些命令时会提示无权限。

先切换到root用户，Xshell连上服务器后, 输入命令：

`sudo -i`

切换后, 命令前面的提示符中也会显示root, 如图：
![img](https://www.wmsoho.com/wp-content/uploads/438f91b7c41f67689ce28eae3a467cd9.png)

依次运行以下4条命令

```
yum install -y wget
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh
```

安装完成后，脚本会提示需要重启VPS，输入 `y` 并`回车`后重启，这时Xshell连接也会自动断开。

VPS重启可能需要几分钟, 耐心等待一下。

重启完成后，再用Xshell重新连接VPS，`sudo -i`切换到root用户。

现在验证一下是否成功安装了最新内核并开启BBR.
输入以下命令：

`uname -r`

查看内核版本，如果返回值含有4.13或以上版本，就表示OK了。
![img](https://www.wmsoho.com/wp-content/uploads/48cb97a23c97981d6c51bbb9e97a569b.png)

`sysctl net.ipv4.tcp_available_congestion_control`
返回值一般为：
net.ipv4.tcp_available_congestion_control = bbr cubic reno

`sysctl net.ipv4.tcp_congestion_control`
返回值一般为：
net.ipv4.tcp_congestion_control = bbr

`sysctl net.core.default_qdisc`
返回值一般为：
net.core.default_qdisc = fq

`lsmod | grep bbr`
返回值有 tcp_bbr 模块即说明bbr已启动。

## 3、 安装SS

如果是采用[秋水逸冰](https://teddysun.com/486.html/comment-page-54#comments)的Shadowsocks一键安装脚本--四合一

> 2017.12.3更新: 记得先用`sudo -i`命令切换到root用户, 不然会显示This script must be run as root! 见下图:
> ![img](https://www.wmsoho.com/wp-content/uploads/8a096bb81ccd41d685e1b6df34895c00.png)

注意：四合一版本安装时间会比较久，估计要5分钟左右，如果是安装单版本的，估计只要1分钟就够了！

使用root用户登录，运行以下三条命令：**

```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```
**安装完成后，脚本提示如下：**

```
Congratulations, your_shadowsocks_version install completed!
Your Server IP        :your_server_ip
Your Server Port      :your_server_port
Your Password         :your_password
Your Encryption Method:your_encryption_method

Your QR Code: (For Shadowsocks Windows, OSX, Android and iOS clients)
 ss://your_encryption_method:your_password@your_server_ip:your_server_port
Your QR Code has been saved as a PNG file path:
 your_path.png

Welcome to visit:https://teddysun.com/486.html
Enjoy it!

```
**卸载方法：**

若已安装多个版本，则卸载时也需多次运行（每次卸载一种）

使用root用户登录，运行以下命令：

`./shadowsocks-all.sh uninstall`

**启动脚本：**

启动脚本后面的参数含义，从左至右依次为：启动，停止，重启，查看状态。

Shadowsocks-Python 版：
/etc/init.d/shadowsocks-python start | stop | restart | status

ShadowsocksR 版：
/etc/init.d/shadowsocks-r start | stop | restart | status

Shadowsocks-Go 版：
/etc/init.d/shadowsocks-go start | stop | restart | status

Shadowsocks-libev 版：
/etc/init.d/shadowsocks-libev start | stop | restart | status

**各版本默认配置文件：**
Shadowsocks-Python 版：
/etc/shadowsocks-python/config.json

ShadowsocksR 版：
/etc/shadowsocks-r/config.json

Shadowsocks-Go 版：
/etc/shadowsocks-go/config.json

Shadowsocks-libev 版：
/etc/shadowsocks-libev/config.json


