#!/usr/bin/env bash
# Description: virtualenv python django

PYTHON_VER="Python-3.9.2"
PYTHON_PKG="${PYTHON_VER}.tgz"
PYTHON_URL="https://www.python.org/ftp/python/3.9.2/${PYTHON_PKG}"


def prepare () {
     # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi

        # 1. 安装依赖
    # 0-stdin 1-stdout 2-stderr
    if ! (yum install -y gcc-* openssl-* libffi-devel sqlite-devel 1>/etc/null); then
        echo "ERROR: yum install error"
        exit 1
    fi
    echo -e "prepare dependency done"
    
    # 2. 下载源码包 
    if wget $PYTHON_URL 1>/etc/null; then
        tar xf "$PYTHON_PKG"
        if [ ! -d "$PYTHON_VER" ]; then
            echo "ERROR: not found $PYTHON_VER"
            exit 1
        fi
    else
        echo "ERROR: wget file $PYTHON_PKG error"
        exit
    fi
    echo -e "prepare wget done"
}

