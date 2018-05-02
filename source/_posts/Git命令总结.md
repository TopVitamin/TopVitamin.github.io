---
title: Git命令总结
date: 2017-11-5 21:27:24
tags: git
categories: git

---

> 从知乎上摘下来的一些常用的命令总结，以备不时之需！

<!--more-->


## 基本命令操作

**配置个人信息**

    $ git config --global user.name "Your Name"
    $ git config --global user.email "email@example.com"

**切换目录初始化**

    $ git init

**文件添加到仓库**

    $ git add -p <file>

 **把文件提交到仓库**

    $ git commit -m "add LICENSE"

 **查看仓库当前状态**

    $ git status

 **查看difference**

    $ git diff     # git status告诉你有文件改动，git diff则才可以查看改动的内容

 **显示从最近到最远的提交日志**

    $ git log --pretty=oneline     # 格式化输出信息

 
 **查看命令记录**

    $ git reflog

 **丢弃工作区的修改，回到最近一次git commit或git add时的状态：**

    $ git checkout -- README.md
    
    # 如果README.md修改了没有add那么就是回到add前的状态
      如果README.md修改了且add了，那么就回到add后commit前的状态
      git checkout其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。
      一定要加 -- ,不然就变成了切换分支操作

 **把暂存区的修改撤销掉（unstage）**

    $ git reset HEAD READER.md
    
    # git reset命令既可以回退版本，也可以把暂存区的修改回退到工作区。当我们用HEAD时，表示最新的版本
    然后再一次执行 git checkout README.md 就丢弃了本次add操作并且撤销了工作区的修改

**关于git reset的几个点**

    $ git reset --hard
    $ git reset --soft
    $ git reset --mixed
    
    # 有三种模式，默认不加参数就是最后一个mixed方式，git reset有两个作用，一个是git reset HEAD file 意思就是在当前版本中的暂存区将某文件变成unstage，如果执行git reset HEAD^ file 就是把上个版本的暂存区的文件取出来并改成unstage，但是版本并没有切换。最后如果是git reset [-- hard] HAED^ 就是回退到上个版本，HEAD^也可以改成commit的id，前几位就够
    
    **版本退回**

     $ git reset --hard HEAD^     # 回到上一次commit的版本

**当前版本HEAD，上一个版本HEAD^，上上个版本HEAD^^**

    $ git reset --hard 130f10a 或 HEAD~100，herd只是一个模式

 **从版本库中删除该文件，会将文件从工作区删除，然后推送到版本库**

    $ git rm README.md
    $ git commit -m "remove READER.md"

 **把误删的文件恢复到最新版本，checkout其实用版本库里的版本替换工作区的版本，此时应该是没有commit**

    $ git checkout -- README.md #从版本库中检出这个文件

## 远程仓库

**生成密钥文件和私钥文件，windows一般是放在"C:\Users\xxx\.ssh"里面**
 
    $ ssh-keygen -t rsa -C "youremail@example.com"
   
**把一个已有的本地仓库与之关联**

    $ git remote add origin git@github.com:xxx/learngit.git

**从远程库克隆**

    $ git clone git@github.com:xxx/learngit.git

**把本地库的所有内容推送到远程库上（推送master分支的内容）**
  
    $ git push -u origin master   # -u选项会指定一个默认主机，这样后面就可以不加任何参数使用git push


## 分支管理

**创建+切换dev分支**

    $ git checkout -b dev
    # 相当于
    $ git branch dev # 创建分支
    $ git checkout dev

**查看当前分支，当前分支前面标有×号**

    $ git branch

**切换回master分支**

    $ git checkout master

**合并指定分支到当前分支**

    $ git merge dev  # dev表示分支的名称

**删除dev分支**

    $ git branch -d dev
    
**删除远程分支**

    $ git push origin :branch-name  # 注意origin后面有一个`空格`，表示推送空到分支就是删除

**查看分支合并情况**

    $ git log --graph --pretty=oneline --abbrev-commit  # 简略模式显示或者直接 git log 就可以显示详细模式
    
    *   59bc1cb conflict fixed
    |\
    | * 75a857c AND simple
    * | 400b400 & simple
    |/
    * fec145a branch test

**删除feature1分支**

    $ git branch -d feature1

**创建并切换dev分支**

    $ git checkout -b dev

**修改readme.txt文件，并提交一个新的commit**

    $ git add readme.txt
    $ git commit -m "add merge"

**切换回master**

    $ git checkout master

**合并dev分支，请注意--no-ff参数，表示禁用Fast forward**

    $ git merge --no-ff -m "merge with no-ff" dev

**看看分支历史**

    $ git log --graph --pretty=oneline --abbrev-commit
    
    *   7825a50 merge with no-ff
    |\
    | * 6224937 add merge
    |/
    *   59bc1cb conflict fixed

**如果需要临时修复Bug，可以把当前工作现场“储藏”起来，等Bug修复后恢复现场后继续工作**

    $ git stash

**切换到需要修复Bug的分支，创建临时分支来修复**

    $ git checkout master
    $ git checkout -b issue-101

**修复完成后切换到master分支，完成合并，删除临时分支**

    $ git checkout master
    $ git merge --no-ff -m "merged bug fix 101" issue-101
    $ git branch -d issue-101
    
**Bug修复后，切换回dev分支继续干活**

    $ git checkout dev

**查看工作现场列表**

    $ git stash list

**恢复工作现场**

    $ git stash pop # 恢复的同时把stash内容也删了
$ git stash apply # 恢复，不删除stash的内容，使用git stash drop进行删除

**再次查看工作现场列表，是否干净**

    $ git stash list

**可以多次stash，恢复时指定恢复**

    $ git stash apply stash@{0}

**强行删除一个没有合并过的分支**

    $ git branch -D <name>

**要查看远程库的信息**

    $ git remote
    $ git remote -v

**推送其他分支**

    $ git push origin dev

**从远程库clone，默认情况只能看到master分支，需要在dev分支，必须创建远程origin的dev分支到本地**

    $ git checkout -b dev origin/dev
    $ git checkout -b branch-name origin/branch-name  #基于远程分支创建本地分支
    $ git branch --set-upstream branch-name origin/branch-name # 关联

**向远程库推送dev有冲突**

    $ git pull # 拉取到本地合并解决冲突，再向远程推送
    $ git push origin dev

## 标签管理

**切换到需要打标签的分支**

    $ git branch
    $ git checkout master

**创建标签**

    $ git tag v1.0

**查看所有标签**

    $ git tag

**给历史提高的commit id打标签**

    $ git log --pretty=oneline --abbrev-commit # 查看commit id
    $ git tag v0.9 6224937

**查看标签信息**

    $ git show v0.9

**创建带有说明的标签**

    $ git tag -a v0.1 -m "version 0.1 released" 3628164

**用PGP签名标签**

    $ git tag -s <tagname> -m "blablabla..."

**推送某个标签到远程**

    $ git push origin v1.0

**一次性推送全部尚未推送到远程的本地标签**

    $ git push origin --tags

**删除远程标签**

    $ git tag -d v0.9 # 删除本地
    $ git push origin :refs/tags/v0.9 # 删除远程

## 自定义 Git

**显示颜色，会让命令输出看起来更醒目**

    $ git config --global color.ui true

**忽略某些文件时，需要编写.gitignore，然后将.gitignore放到版本库中
st就表示status**

    $ git config --global alias.st status # 重命名

**配置一个unstage别名**

    $ git config --global alias.unstage 'reset HEAD'
    $ git unstage test.py # 等价于
    $ git reset HEAD test.py

**显示最后一次提交信息**

    $ git config --global alias.last 'log -1'

**log**

    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    
    # 每个仓库的配置文件放在.git/config
    # 当前用户的配置文件放在用户主目录下的一个隐藏文件.gitconfig中
    
## 搭建 Git 服务器

**1. 安装 git**

    $ sudo apt-get install git
    
**2. 创建一个 git 用户，用来运行 git 服务**

    $ sudo adduser git
    
**3. 创建证书登录：收集所有需要登录的用户的公钥，就是他们自己的 id_rsa.pub 文件，把所有公钥导入到 /home/git/.ssh/authorized_keys 文件里，一行一个**

**4. 初始化 Git 仓库**

    选定一个目录作为 Git 仓库，假定是 /srv/sample.git，在 /srv 目录下输入命令
    
        $ sudo git init --bare sample.git
        $ sudo chown -R git:git sample.git  # 把 owner 改为 git
    
**5. 禁用 shell 登录**

    编辑/etc/passwd文件
    git:x:1001:1001:,,,:/home/git:/bin/bash # 修改成下面的内容
    git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell
    
**6. 克隆远程仓库，在各自的电脑上运行：**

    $ git clone git@server:/srv/sample.git

 **参考**
 
收集自：[知乎 - Git 命令总结](https://zhuanlan.zhihu.com/p/25892137)
Git教程：[Git教程 - 廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)














