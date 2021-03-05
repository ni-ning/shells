#!/usr/bin/bash
# Author: Lightnning
# Script Description: 判断目录是否存在

# 存在删除目录里内容；不存在新建

TEST_DIR=/tmp/run

if [ -d "$TEST_DIR" ]; then
    # 避免出现 /* 情况
    rm -rf "${TEST_DIR:?}/"*
else
    mkdir -p "$TEST_DIR"
fi