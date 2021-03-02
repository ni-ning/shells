#!/usr/bin/env bash

# 每个代码块执行完毕之后以 ;; 结束，最后以 esac 结尾

clear

read -p "num: " N

case "$N" in
1)
    echo "case 1"
;;
2)
    echo "case 2"
;;
3)
    echo "case 3"
;;
*)
    echo "1|2|3"
;;
esac