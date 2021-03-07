#!/usr/bin/env bash
# Description: vsftpd 安装

# NAS 共享的是文件夹;  SAN 共享的是设备

install () {
    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi

    # 安装软件
    yum install -y vsftpd

}

install

# systemctl status vsftpd
# lfof -i: 21

# 配置文件 /etc/vsftpd/vsftpd.conf
# 下载目录 /var/ftp/
# FTP日志 /var/log/xferlog