#!/usr/bin/env bash
# Description: Nginx 安装初始化服务

# 安装用户
# 安装前准备 依赖包 源码包获得
# 安装
# 启动 测试

NGINX_VER=nginx-1.18.0
NGINX_TAR_GZ=${NGINX_VER}.tar.gz
NGINX_URL=http://nginx.org/download/${NGINX_TAR_GZ}

check () {
    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root."
        exit 1

    # 检测 weget，使用者可以做个软连接
    if [ ! -x /usr/bin/wget ];then
        echo "ERROR: not found command /usr/bin/wget"
        exit 1
    fi
    # 简写
    # [ ! -x /usr/bin/wget] && echo "not found command /usr/bin/wget" && exit 1
}


prepare () {
    # 1. 安装依赖
    # 0-stdin 1-stdout 2-stderr
    if ! (yum install -y gcc-* pcre-devel zlib-devel 1>/etc/null); then
        echo "ERROR: yum install error"
        exit 1
    fi

    # 2. 下载源码包 
    if wget $NGINX_URL 1>/etc/null; then
        tar xf NGINX_TAR_GZ
        if [! -d NGINX_VER]; then
            echo "ERROR: not found $NGINX_VER"
            exit 1
        fi
    else
        echo "ERROR: wegt file $NGINX_TAR_GZ error"
        exit
    fi

}