#!/usr/bin/env bash
# Description: Nginx 安装初始化

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

check_nginx () {
    # 判断是否已安装 nginx

    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi

    # 检测 weget，使用者可以做个软连接
    if [ ! -x /usr/bin/wget ];then
        echo "ERROR: not found command /usr/bin/wget"
        exit 1
    fi
    # 简写
    # [ ! -x /usr/bin/wget] && echo "not found command /usr/bin/wget" && exit 1
    echo -e "\033[31m[1]\033[0m check done"
}


prepare_nginx () {
    # 1. 安装依赖
    # 0-stdin 1-stdout 2-stderr
    if ! (yum install -y gcc-* pcre-devel zlib-devel elinks 1>/etc/null); then
        echo "ERROR: yum install error"
        exit 1
    fi
    echo -e "\033[31m[2]\033[0m prepare dependency done"
    
    # 2. 下载源码包 
    if wget $NGINX_URL 1>/etc/null; then
        tar xf "$NGINX_PKG"
        if [ ! -d "$NGINX_VER" ]; then
            echo "ERROR: not found $NGINX_VER"
            exit 1
        fi
    else
        echo "ERROR: wget file $NGINX_PKG error"
        exit
    fi
    echo -e "\033[31m[3]\033[0m prepare wget done"

}

# 安装
install_nginx () {
    # 创建管理用户
    useradd -r -s /sbin/nologin "$NGINX_USER"
    cd "$NGINX_VER"
    echo "nginx configure..."
    if ./configure --prefix="$NGINX_INSTALL_DIR" --user="$NGINX_USER" --group="$NGXIN_GROUP" 1> /etc/null; then
        echo "nginx make..."
        if make 1> /etc/null; then
            echo "nginx make install..."
            if make install 1> /etc/null; then
                echo "SUCCESS: nginx has installed"
            else
                echo "ERROR: nginx make install fail" && exit 1
            fi
        else
            echo "ERROR: nginx make fail" && exit 1
        fi
    else
        echo "ERROR: nginx configure fail" && exit 1
    fi
}

# 测试
test_nginx () {
    if $NGINX_INSTALL_DIR/sbin/nginx; then
        echo "SUCCESS: nginx start"
        elinks http://localhost --dump
    else
        echo "ERROR: nginx start fail"
    fi
}

remove_nginx_pkg () {
    # 删除下载文件
    if rm -rf "$NGINX_VER"; then
        echo "remove $NGINX_VER success"
    else
        echo "remove $NGINX_VER fail"
    fi

    rm -rf "$NGINX_PKG"

}

# 执行函数
check_nginx; prepare_nginx; install_nginx; remove_nginx_pkg; test_nginx