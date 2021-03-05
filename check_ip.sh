#!/usr/bin/bash
# Author: Lightnning
# Script Description: 监控目标主机状态

# 监控方法：ping ICMP协议
# ping 通 host up
# ping 不通 host down

# 遇到的问题
# 1. 禁ping问题 禁的是陌生人 允许自己的IP
# 2. ping 报警阈值 3次全部失败
# 3. ping 频率 5s or 1s  支持毫秒级

# ping 测试测试
PING_COUNT=3
# ping 失败次数
PING_ERROR_COUNT=0
# ping 超时秒数
PING_TIMEOUT=5
# sleep 秒数
SLEEP_SECONDS=1

# 测试代码 ((变量之前的$ 可以去掉)); command &>/dev/null可以直接作为if的判断条件
for (( i=1;i<=PING_COUNT;i++ ));do
    if ! ping -c1 -t"$PING_TIMEOUT" "$1" &>/dev/null; then
        PING_ERROR_COUNT=$((PING_ERROR_COUNT + 1))
    fi
    # 时间间隔
    sleep $SLEEP_SECONDS
done

# 三次都失败就报警
if [ $PING_ERROR_COUNT -eq $PING_COUNT ]; then
    echo "$1 is down"
else
    echo "$1 is up"
fi