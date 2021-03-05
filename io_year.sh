#!/usr/bin/bash
# Author: Lightnning
# Script Description: 判断 闰年 平年
# 四年一闰，百年不闰，四百年再闰

clear

read -rp "Input year: " year

if [ -z "$year" ]; then
    echo "$0 needs a year num."
    exit 1

elif (( year % 400 == 0 )); then
    echo "闰年"

elif (( year % 100 !=0 )) && (( year % 4 == 0 )); then
    echo "闰年"

else
    echo "平年"
fi

