#!/usr/bin/env bash

# 背景命令介绍
# lsof -i :80
# ps aux | grep nginx | grep -v "grep"
# yum search killall --> yum install psmisc.x86_64
# killall nginx

# 定义变量 - 常规操作
nginx_install_dir=/usr/local/nginx
nginxd=$nginx_install_dir/sbin/nginx
pid_file=$nginx_install_dir/logs/nginx.pid
process=nginx

# 导入系统提供内置函数
if [ -f /etc/init.d/functions ]; then
    . /etc/init.d/functions
else
    echo "not found file /etc/init.d/functions"
    exit
fi

if [ -f "$pid_file" ]; then
    nginx_process_id=$(cat "$pid_file")
    nginx_process_num=$(ps aux | grep "$nginx_process_id" | grep -v "grep" | wc -l)
fi

# 功能函数
start () {
    # 存在服务的pid文件且进程服务数大于1，说明服务正在运行
    if [ -f "$pid_file" ] && [ "$nginx_process_num" -ge 1 ]; then
        echo "nginx running...."
    else
        # 存在服务的pid文件 但是进程服务不存在，可能是断电导致的
        if [[ -f "$pid_file" ]] && [[ $nginx_process_num -lt 1 ]]; then
            # 删除进程文件
            rm -f "$pid_file"
        fi
        # 利用工具函数 启动服务
        echo "nginx start $(daemon "$nginxd")"
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