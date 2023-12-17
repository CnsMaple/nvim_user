# 快速安装

这些是依赖，目前主要更新的是windows的。

Windows：

`scoop install nodejs fd ripgrep sed gcc make fzf gzip deno`

archlinux:

`paru -S npm neovim gcc make`

然后clone AstroNvim到nvim目录下，然后创建user目录，再clone现在这个仓库到user目录下。

# 一些环境依赖问题

1. 可以显示颜色的终端。

2. Neovim >= 0.10.0（可以在文中显示虚拟文本）

下载appimage，然后建立一个链接就可以了。

3. Git >= 2.19.0 

copilot.lua插件需要git来登录：

需要设置ssh通道：

安装git

配置git账号

`git config --global user.name "yourname"`

`git config --global user.email "youremail"`

生成ssh key （生成过程中一路回车就行）

`ssh-keygen -t rsa -C "GitHub邮箱地址"`

找到一下这两句话，其中id_rsa.pub文件包含了你的公钥，关联账号需要用到：

Tip:xxxx是用户名

> Your identification has been saved in /home/xxxx/.ssh/id_rsa.

> Your public key has been saved in /home/xxxx/.ssh/id_rsa.pub.

关联GitHub账号

获取关键内容：`cat ~/.ssh/id_rsa.pub`

将输出都复制(从ssh-ras开头到最后)。

打开GitHub网站：setting --> SSH and GPGS Keys --> New  SSH Key-->复制cat id_rsa.pub里的秘钥到指定位置-->Add SSH Key

验证是否成功：`ssh -T git@github.com` 

在输出中看到自己的名字就可以了，在最后一行，有"Hi,xxxx~"。

如果出现错误：

```bash
kex_exchange_identification: Connection closed by remote host
Connection closed by 20.205.243.166 port 22
```

那就改端口，在/home/xxx/.ssh/config中添加：

```bash
Host github.com
    Hostname ssh.github.com
    User git
    Port 443
```

4. [a Nerd Font](https://www.nerdfonts.com/)

目前主要在使用[maple-font](https://github.com/subframe7536/Maple-font)：`Maple Mono SC NF` 

5. [ripgrep](https://github.com/BurntSushi/ripgrep)

6. [fd](https://github.com/sharkdp/fd)

可能还要fg

7. [rust(cargo)](https://www.rust-lang.org/tools/install)环境(暂不用)。

有个minimap需要，不过那个minimap不好用，现在弃用了，这个配置就留着。

可能要配置一下的全局变量:`$HOME/.cargo/env`

有时候慢，那就更换源

```txt
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'

[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
#registry = "https://mirrors.ustc.edu.cn/crates.io-index"

[http]
check-revoke = false
proxy = "127.0.0.1:7890"

[https]
proxy = "127.0.0.1:7890"
```

8. 需要node > 16.0 和 npm

安装npm就有node,nodejs,npm了

主要的代码树什么的，都要，它们是npm install xxx这些。还有copilote也要使用这个，而且必需大于16.0

[更新nodejs为16.x](https://joshtronic.com/2021/05/09/how-to-install-nodejs-16-on-ubuntu-2004-lts/)

```bash
sudo apt update
sudo apt upgrade

sudo apt install -y curl

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sudo apt install -y nodejs

node --version
```

9. [fzf](https://github.com/junegunn/fzf#installation)

fzf是一款功能强大的模糊查找工具，它提供了快速、交互式的文件和文本查找功能。fzf的全称是"fuzzy finder"，它可以根据输入的模糊关键词来匹配文件和文本，并以交互式的方式展示匹配结果。

主要配合telescope来使用。

fzf的插件中，gcc用来build这个插件的。需要环境中有gcc。

如果是Windows，需要make，不然插件编译不过。

10. gcc g++ make

treesitter需要这些，不同的代码语言需要不同的，这里暂时这些。

# 一些问题的解决办法

## wsl中实现neovim与系统的剪贴板共享

主要是wsl里面没有剪贴板,只需要下面几行指令

方法一：

网址可能有点旧，到[win32yank](https://github.com/equalsraf/win32yank)的releases中copy一个新的就好。

```bash
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```

方法二（更好）：

`sudo apt install xclip`

选择一个方法后：

然后在nvim设置:

`vim.opt.clipboard:append("unnamedplus")`
or
`set clipboard=unnamedplus`

上面做完基本可以做到了

## 安装nodejs时出现的问题:code ERR_INVALID_URL

```text
npm ERR! code ERR_INVALID_URL
npm ERR! Invalid URL

npm ERR! A complete log of this run can be found in:
npm ERR! C:\Users\....\AppData\Local\npm-cache\_logs\2021-11-04T09_13_08_065Z-debug.log
```

详细问题可以看它给出的日志。

一般是因为代理问题导致的：

办法：

```bash
npm config set proxy http://127.0.0.1:7890
```

## 安装的过程中出现的错误：sub-process /usr/bin/dpkg returned an error code 1

原因：这个是安装包被污染了。

办法：

比如在安装nodejs(sudo apt install nodejs)的时候出现的：

```bash
sudo apt-get --purge remove nodejs

sudo apt autoremove -f

sudo apt-get -f install
```

## 目标主机因重装不能再次连接ssh

办法：

去到：/home/xxxx/.ssh

可以看到有：known_hosts和known_hosts.old文件，删掉这两个就可以了。
