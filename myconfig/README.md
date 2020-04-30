# 我的踩坑记录

## 设置 tlog-rec-session 后无法远程登录问题

在我的服务器上运行下面命令启动 `tlog-rec-session`，

```bash
# usermod -s /usr/bin/tlog-rec-session root
```

然后远程 ssh 登录不成功，错误如下：

```bash
EnhuadeMacBook-Pro:Downloads lienhua34$ ssh root@hostname -p xxxxx -i /path/to/lienhua_rsa
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.9.0-8-amd64 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.
Last login: Thu Apr 30 07:43:13 2020 from 192.168.16.1
No such file or directory
Failed setting locale from environment variables
Connection to hostname closed.
```

Google 后，查看到 https://askubuntu.com/questions/144235/locale-variables-have-no-effect-in-remote-shell-perl-warning-setting-locale-f ，摘抄如下：

> - Generate the locale. Generate the German locale on the server with sudo locale-gen de.
> 
> - Stop forwarding locale from the client. Do not forward the locale environment variable from your local machine to the server. You can comment out the SendEnv LANG LC_* line in the local /etc/ssh/ssh_config file.
>
> - Stop accepting locale on the server. Do not accept the locale environment variable from your local machine to the server. You can comment out the AcceptEnv LANG LC_* line in the remote /etc/ssh/sshd_config file.

我采用了方法3 对服务器 ssh_config 文件进行了配置，从重新启动 sshd 服务后，可以正常登录了。


## syslog 将 session record 发送到 ES

在尝试使用 syslog 将 session record 发送到 ES 时，`/etc/rsyslog.conf` 配置文件设置了很久才设置正确。参考[本目录下的 rsyslog.conf](./rsyslog.conf)。
