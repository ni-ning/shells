#!/usr/bin/env bash

clear

# kill -9 $(echo $$) = exit 退出当前会话
echo -e "当前所在进程的进程号: $$"
echo -e "当前所在进程/程序名: $0"

echo -e "位置参数变量1: $1"
echo -e "位置参数变量2: $2"
echo -e "位置参数变量3: $3"

echo -e "位置参数的个数: $#"

echo -e "\$@ 变量值是独立的"
for i in "$@"
  do
    echo "$i"
done

echo -e "\$* 变量值是是一个整体"
for i in "$*"
  do
    echo "$i"
done

