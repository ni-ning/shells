#!/usr/bin/env bash

# C 语言写法
for ((i=0; i<3;i++))
    do
        echo $i
        sleep 1
done

# 同时赋值两个值
for ((n=5,m=0; n>0,m<3; n--,m++))
    do
        echo -e "$n\t$m"
done