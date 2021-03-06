#!/usr/bin/env bash
# Description: Nginx 安装初始化服务

# 安装用户
# 安装前准备 依赖包 源码包获得
# 安装
# 启动 测试

NGINX_VER="nginx-1.18.0"
NGINX_PKG="${NGINX_VER}.tar.gz"
NGINX_URL="http://nginx.org/download/${NGINX_PKG}"

NGINX_INSTALL_DIR="/usr/local/nginx"
NGINX_USER="www"
NGINX_GROUP="www"

check () {
    # 判断是否已安装 nginx

    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root."
        exit 1
    fi

    # 检测 weget，使用者可以做个软连接
    if [ ! -x /usr/bin/wget ];then
        echo "ERROR: not found command /usr/bin/wget"
        exit 1
    fi
    # 简写
    # [ ! -x /usr/bin/wget] && echo "not found command /usr/bin/wget" && exit 1
    echo -e "\033[31m[1]\033[0m check done."
}


prepare () {
    # 1. 安装依赖
    # 0-stdin 1-stdout 2-stderr
    if ! (yum install -y gcc-* pcre-devel zlib-devel 1>/etc/null); then
        echo "ERROR: yum install error"
        exit 1
    fi
    echo -e "\033[31m[2]\033[0m prepare dependency done."
    
    # 2. 下载源码包 
    if wget $NGINX_URL 1>/etc/null; then
        tar xf "$NGINX_PKG"
        if [! -d "$NGINX_VER" ]; then
            echo "ERROR: not found $NGINX_VER"
            exit 1
        fi
    else
        echo "ERROR: wegt file $NGINX_PKG error"
        exit
    fi
    echo -e "\033[31m[3]\033[0m prepare weget done."

}


# 执行操作
check
prepare