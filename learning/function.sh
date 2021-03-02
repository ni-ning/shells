#!/usr/bin/env bash

# 定义函数
start () {
    clear

    echo "Service start........[OK]"
    echo "Service start........[OK]"
    echo "Service start........[OK]"
    echo "Service start........[OK]"
}

function stop {
    echo "Service stop.........[OK]"
}


# 调用函数, 可多次调用
start
stop
