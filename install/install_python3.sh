#!/usr/bin/env bash
# Description: virtualenv python django

# PYTHON_VER="Python-3.9.2"
# PYTHON_PKG="${PYTHON_VER}.tgz"
# PYTHON_URL="https://www.python.org/ftp/python/3.9.2/${PYTHON_PKG}"

PYTHON_VER="Python-3.8.6"
PYTHON_PKG="${PYTHON_VER}.tgz"
PYTHON_URL="https://static-global.121learn.com/Python-3.8.6.tgz"

PYTHON_INSTALL_DIR="/usr/local/python3"
PYTHON_DEAMON="$PYTHON_INSTALL_DIR/bin/python3"

# 具体项目虚拟环境目录
PYTHON_ENV="~/envs/project3"

prepare () {
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


install () {
    cd "$PYTHON_VER"
    echo "pyhton configure..."
    
    # 在低版本的gcc版本中带 --enable-optimizations 会出现 Could not import runpy module 错误
    if ./configure --with-openssl=/usr/bin/openssl --prefix="$PYTHON_INSTALL_DIR" 1>/etc/null; then
        echo "python make..."
        if make 1> /etc/null; then
            echo "python make install..."
            if make install 1> /etc/null; then
                # ln -s /usr/local/python3/bin/python3 /usr/bin/python38
                # ln -s /usr/local/python3/bin/pip3 /usr/bin/pip38
                echo "SUCCESS: python has installed"
            else
                echo "ERROR: python make install fail" && exit 1
            fi
        else
            echo "ERROR: pyhton make fail" && exit 1
        fi
    else
        echo "ERROR: python configure fail" && exit 1
    fi
}

virtual () {
    # 安装虚拟环境
    PYTHON_DEAMON -m venv "$PYTHON_ENV"
}
# prepare
# install

virtual