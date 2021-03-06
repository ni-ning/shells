#!/usr/bin/env bash

# 背景命令介绍
# lsof -i :80
# ps aux | grep nginx | grep -v "grep"
# yum search killall --> yum install psmisc.x86_64
# killall nginx

# 定义变量 - 常规操作
NGINX_INSTALL_DIR="/usr/local/nginx"
NGINX_DAEMON="$NGINX_INSTALL_DIR/sbin/nginx"
PID_FILE="$NGINX_INSTALL_DIR/logs/nginx.pid"
PROCESS_NAME="nginx"

# 导入系统提供内置函数
if [ -f /etc/init.d/functions ]; then
    . /etc/init.d/functions
else
    echo "Not found file /etc/init.d/functions"
    exit 1
fi

if [ -f "$PID_FILE" ]; then
    NGXIN_PROCESS_ID=$(cat "$PID_FILE")
    NGINX_PROCESS_NUM=$(ps aux | grep "$NGXIN_PROCESS_ID" | grep -v "grep" | wc -l)
fi

# 功能函数
start () {
    # 存在服务的pid文件且进程服务数大于1，说明服务正在运行
    if [ -f "$PID_FILE" ] && [ "$NGINX_PROCESS_NUM" -ge 1 ]; then
        echo "Info: nginx has been running."
    else
        # 存在服务的pid文件 但是进程服务不存在，可能是断电导致的
        if [[ -f "$PID_FILE" ]] && [[ $NGINX_PROCESS_NUM -lt 1 ]]; then
            # 删除进程文件
            rm -f "$PID_FILE"
        fi
        # 利用工具函数 启动服务
        echo "Success: nginx start $(daemon "$NGINX_DAEMON")"
        # action "Nginx start success" $(daemon "$NGINX_DAEMON")
    fi
}

stop () {
    if [ -f "$PID_FILE" ] && [ "$NGINX_PROCESS_NUM" -ge 1 ]; then
        if killall -s QUIT "$PROCESS_NAME"; then
            echo "Success: nginx has stopped."
            rm -f "$PID_FILE"
            exit 0
        fi
    fi

    echo "ERROR: not found nginx" && exit 1
}

restart () {
    echo "restart..."
}

reload () {
    echo "reload..."
}

status () {
    echo "status...."
}

remove () {
    # 关闭服务
    stop

    read -p "Are you sure to remove nginx totally? (Y/N)" inp
    if [ "$inp" == "Y" ]; then
        rm -rf "$NGINX_INSTALL_DIR"
    elif [ "$inp" == "N" ]; then
        exit 1
    fi
}


# 主干逻辑
case "$1" in
"start") start ;;
"stop") stop ;;
"restart") restart ;;
"reload") reload ;;
"status") status ;;
"remove") remove ;;
*) echo "USAGE: $0 start|stop|restart|reload|status"
esac