#!/usr/bin/env bash

install () {

    # 检测当前用户 要求为 root
    if [ "$USER" != 'root' ];then
        echo "ERROR: need to be root"
        exit 1
    fi

    if which redis-cli &> /etc/null; then
        systemctl status redis
    else
        echo "redis install..."
        # https://www.digitalocean.com/community/tutorials/how-to-install-secure-redis-centos-7
        if yum install -y redis &> /etc/null; then
            systemctl start redis.service &>/etc/null
            systemctl enable redis.service &>/etc/null
            redis-cli ping
            echo "SUCCESS: redis install succeed"
        else
            echo "ERROR: redis install fail"
        fi
    fi
}

install