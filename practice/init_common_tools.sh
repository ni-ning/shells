#!/usr/bin/env bash

# netstat -plnt
yum install -y net-tools

# lsof -i :80
yum install -y lsof

# killall nginx
yum install -y psmisc.x86_64