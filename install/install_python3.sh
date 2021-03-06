#!/usr/bin/env bash
# Description: python virtualenv django

# PYTHON_VER="Python-3.9.2"
# PYTHON_PKG="${PYTHON_VER}.tgz"
# PYTHON_URL="https://www.python.org/ftp/python/3.9.2/${PYTHON_PKG}"

# 版本版本
PYTHON_VER="Python-3.8.6"
PYTHON_PKG="${PYTHON_VER}.tgz"
PYTHON_URL="https://static-global.121learn.com/Python-3.8.6.tgz"

# 安装路径
PYTHON_INSTALL_DIR="/usr/local/python3"
PYTHON_DAEMON="$PYTHON_INSTALL_DIR/bin/python3"

# 具体项目虚拟环境目录
PYTHON_ENV="/opt/env/project3"
DJANGO_VER="django==3.1.7"

prepare () {
     # 检测当前用户 要求为 root
    if [ "$USER" != 'root' ];then
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
    cd "$PYTHON_VER" || (echo "ERROR: not found $PYTHON_VER" && exit 1)
    echo "python configure..."
    
    # 在低版本的gcc版本中带 --enable-optimizations 会出现 Could not import runpy module 错误
    if ./configure --with-ssl --prefix="$PYTHON_INSTALL_DIR" 1>/etc/null; then
        echo "python make..."
        if make 1> /etc/null; then
            echo "python make install..."
            if make install 1> /etc/null; then
                # ln -s /usr/local/python3/bin/python3 /usr/bin/python3
                # ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
                echo "SUCCESS: python has installed"
            else
                echo "ERROR: python make install fail" && exit 1
            fi
        else
            echo "ERROR: python make fail" && exit 1
        fi
    else
        echo "ERROR: python configure fail" && exit 1
    fi
}

virtual () {
    # 安装虚拟环境
    . /etc/init.d/functions
    daemon "$PYTHON_DAEMON" -m venv "$PYTHON_ENV"
    # /usr/local/python3/bin/python3 -m venv "$PYTHON_ENV"
}

django () {

    # source 内尽量不包含变量
    # source "${PYTHON_ENV/bin/activate}"
    source "/opt/env/project3/bin/activate"
    pip install -i  https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com "$DJANGO_VER"
}


# 实际执行
prepare; install; virtual; django

# 删除临时文件
rm -rf "$PYTHON_VER"
rm -rf "$PYTHON_PKG"