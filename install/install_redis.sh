#!/usr/bin/env bash

install () {

    # 检测当前用户 要求为 root
    if [ $USER != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi

    if which redis-cli; then
        systemctl status redis
    else
    fi
        # https://www.digitalocean.com/community/tutorials/how-to-install-secure-redis-centos-7
        yum install -y redis
        systemctl start redis.service
        systemctl enable redis.service
        redis-cli ping
    fi
}

install