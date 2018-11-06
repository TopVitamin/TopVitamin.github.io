---
title: valine--简单好用的静态博客评论插件
date: 2018-11-06 22:27:24
tags: 博客
categories: 博客

---

> 网上看了好几个关于valine的帖子都有点漏洞和BUG，所以自己把踩过的坑都拿出来记录一下！

<!--more-->

## Valine简介

**Valine**([官网](https://valine.js.org/))是一款基于[Leancloud](http://leancloud.cn/)的快速、简洁且高效的无后端评论系统。

> 配置和使用在官网都有介绍，需要注意的一点是，除了拿到了App ID和App Key之外，还需要在`存储`然后创建`Class`，名字就叫做`Comment`，然后权限设置为`无限制`就可以，这样以后的留言就会进入到这个数据池中。

## Hexo-NexT中的开启和设置

Hexo-NexT中高版本的已经默认安装了Valine插件，如果是低版本没有支持的话，可以使用以下命令安装：

```
npm install valine --save
```

完成后，在NexT主题配置文件`\themes\next\_config.yml`中修改代码以开启：

```javascript
# Valine.
# You can get your appid and appkey from https://leancloud.cn
# more info please open https://valine.js.org
valine:
  enable: true # 是否开启
  appid:                            # 填上之前获取的AppID
  appkey:                           # 填上之前获取的AppKey
  notify: false # 新留言是否需要通知 https://github.com/xCss/Valine/wiki
  verify: false # 是否需要验证，验证比较反人类建议false关闭
  placeholder: 请在此输入您的留言 # 默认留言框内的文字
  avatar: mm # 默认头像
  guest_info: nick,mail # 默认留言框的头部需要访问者输入的信息
  pageSize: 10 # pagination size #默认单页的留言条数
```

如果使用的主题是自带了Valine插件的话，那么布局的配置中也已经有了相应的配置，至此应该是完成了所有的操作，但是，如果主题没有带Valine的话，那么还需要在进行一步。

## 最关键的一步

为了保险起见，推荐你先备份下 `/themes/next/_config.yml` 和 `/themes/next/layout/_partials/comments.swig`，以防出现不备。

### 修改_config.yml

修改主题目录下的 `/themes/next/_config.yml` 中添加（如果现在使用着其他评论系统，请先去掉其他评论系统的配置）： 

```javascript
valine:
  enable: true
  appId: Your_AppId ##你的 Leancloud App ID
  appKey: Your_AppKey ##你的 Leancloud App Key
```

### 修改 comments.swig

>  注：因为我没有其他的评论系统需求，所以将其他评论系统的内容的删掉了。  

打开 `/themes/next/layout/_partials/comments.swig`，**整个文件**修改为：

```javascript
{% if page.comments %}
  <div class="comments" id="comments"></div>
    {% if (theme.valine and theme.valine.enable)%}
    <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
    <script src='//unpkg.com/valine/dist/Valine.min.js'></script>
    <script>
        new Valine({
            av: AV,
            el: '.comments',
            notify: false, 
            verify: false,
            app_id: '{{ theme.valine.appId }}',
            app_key: '{{ theme.valine.appKey }}',
            placeholder: '谈谈你的看法？'
        });
    </script>
    {% endif %}
{% endif %}
{% endif %}
```

> 关键在于上面两个js的引入，如果你想用新版本的内容，那么就需要在官网上引入最新的js路径，目前来说此路径是最新的，支持所有最新的内容

然后`hexo clean`清除缓存，`Hexo g -d`去看效果吧。

## 最后

后期如果需要管理留言，至`leancloud/控制台/储存/comment`即可进行添加、删除等操作。

还有其他高级操作可以参考官网或者其他网站！



>  本文参考：
>
> <https://shup.cn/2017/11/21/valine.html>
>
> https://cloud.tencent.com/developer/article/1142420
>
> https://blog.csdn.net/blue_zy/article/details/79071414