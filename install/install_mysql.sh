#!/usr/bin/env bash
# Description: MySQL 安装脚本

# 安装文档 https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html

MYSQL_VER="mysql80-community-release-el7-3.noarch.rpm"
MYSQL_URL="https://dev.mysql.com/get/${MYSQL_VER}"


remove () {
    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi
    
    # 删除系统自带旧版本
    rpm -e --nodeps $(rpm -qa | grep -i mariadb)
    rpm -e --nodeps $(rpm -qa | grep -i mysql)
}


install () {
    # 下载 repo
    wget "$MYSQL_URL"
    
    # /etc/yum.repos.d/ 添加mysql源
    yum install -y "$MYSQL_VER"
    
    # 安装 mysql 服务
    yum install -y mysql-community-server
}

# 实际执行函数
remove; install