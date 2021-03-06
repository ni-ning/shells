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
        # https://www.digitalocean.com/community/tutorials/how-to-install-secure-redis-centos-7
        if yum install -y redis 1> /etc/null; then
            systemctl start redis.service 1>/etc/null
            systemctl enable redis.service 1>/etc/null
            redis-cli ping
            echo "SUCCESS: redis install succeed"
        else
            echo "ERROR: redis install fail"
        fi
    fi
}

install