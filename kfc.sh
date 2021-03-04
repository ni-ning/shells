#!/usr/bin/bash
# Author: Lightnning
# Created Time: 2021-02-15 01:01:01
# Script Description: KFC 点餐系统

clear

# 录入单价
HAMBURG=19.8
CH_WING=12.3
COKE=9.9

# 输出菜单信息
cat<<EOF
               Welcome to KFC
今天KFC提供菜品如下:
   1）汉堡
   2）鸡翅
   3）可乐
EOF
echo -e "\n请您输入希望购买菜品的数据，不需要输入0\n"

# 用户交互
declare -i HANBURG_NUM
declare -i CH_WING_NUM
declare -i COKE_NUM

read -p "汉堡：" HANBURG_NUM
read -p "鸡翅：" CH_WING_NUM
read -p "可乐：" COKE_NUM

# 计算总价
HANBURG_PRICE=`echo "scale=2;$HANBURG_NUM*$HAMBURG" | bc`
CH_WING_PRICE=`echo "scale=2;$CH_WING_NUM*$CH_WING" | bc`
COKE_PRICE=`echo "scale=2;$COKE_NUM*$COKE" | bc`
TOTAL_PRICE=`echo "scale=2;$HANBURG_PRICE+$CH_WING_PRICE+$COKE_PRICE" | bc`

# 付款
echo -n "合计：$TOTAL_PRICE "
read -p "请付款：" USER_PRICE

# 打印小票
clear
echo -e "\t\tKFC结算清单"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "商品\t单价\t数量\t合计"
echo -e "汉堡\t$HAMBURG\t$HANBURG_NUM\t$HANBURG_PRICE"
echo -e "鸡翅\t$CH_WING\t$CH_WING_NUM\t$CH_WING_PRICE"
echo -e "可乐\t$COKE\t$COKE_NUM\t$COKE_PRICE"
echo -e "\n\n"
echo -e "总计：$TOTAL_PRICE"
echo -e "支付：$USER_PRICE"
echo -e "找零: `echo "scale=2;$USER_PRICE - $TOTAL_PRICE" | bc`"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "地址：北京路东大街256号\n电话：18810889988\n网站：www.kfc.com"
