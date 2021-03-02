#!/usr/bin/env bash

# 1. for 直接赋值
for var in 1 2 3 4 5
    do
        echo $var
        sleep 1
done

# 2. 使用命令赋值
for var in $(seq 1 3)
    do
        echo "$var"
        sleep 1
done

# 3. 赋值是一个字符串
for var in linda\'s a good girl, and she\'s lots of things.
    do
        echo $var
done

# 备注 一行for循环 do 后面无分号
for i in $(seq 1 10); do date +"%F %H:%M:%S"; sleep 1; done