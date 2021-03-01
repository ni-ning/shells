#!/usr/bin/env bash

# sleep N 控制循环节奏, 减少对CPU的影响

echo -n "倒计时: "
for i in `seq 9 -1 1`
    do
        echo -n -e "\b$i"
        sleep 1
done
echo