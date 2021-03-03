#!/usr/bin/env bash


# 背景命令介绍
# lsof -i :80
# ps aux | grep nginx | grep -v "grep"
# yum search killall --> yum install psmisc.x86_64
# killall nginx

# 定义变量 - 常规操作
nginx_install_dir="/usr/local/nginx"
nginxd="$nginx_install_dir/sbin/nginx"
pid_file="$nginx_install_dir/logs/nginx.pid"
process="nginx"

# 导入系统提供内置函数
if [[ -f /etc/init.d/functions ]]; then
    . /etc/init.d/functions
else
    echo "not found file /etc/init.d/functions"
    exit
fi

if [[ -f "$pid_file" ]]; then
    nginx_process_id=$(cat "$pid_file")
    nginx_process_num=$(ps aux | grep "$nginx_process_id" | grep -v "grep" | wc -l)
fi

# 分布函数
start () {
    if [[ -f "$pid_file" ]] && [[ $nginx_process_num -ge 1 ]]; then
        echo "nginx running...."
    else
        if [[ -f "$pid_file" ]] && [[ $nginx_process_num -lt 1 ]]; then
            rm -f "$pid_file"
            echo "nginx start `daemon "$nginxd"`"
        fi
        echo "nginx start `daemon "$nginxd"`"
    fi
}

stop () {
    echo "stop..."
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


# 主干逻辑
case "$1" in
"start") start ;;
"stop") stop ;;
"restart") restart ;;
"reload") reload ;;
"status") status ;;
*) echo "USAGE: $0 start|stop|restart|reload|status"
esac