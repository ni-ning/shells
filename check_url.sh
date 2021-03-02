#!/usr/bin/env bash
# Description: URL 监控脚本

# 脚本开头定义变量
init_url_status=200
temp_file=$(mktemp /tmp/check_url.XXX)

# 帮助信息
if [[ -z "$1" ]] || [[ "$1" == "--help" ]]; then
    echo "$0 url"
    echo "--help: print help info"
fi

# 用户没有传参则退出
[[ $# -lt 1 ]] && exit 1

# 判断脚本依赖的命令是否存在
[[ ! -x /usr/bin/curl ]] && echo "curl: not found command" && exit 1

# 访问一次URL
curl -I "$1" > "$temp_file"

# 从输出中截取状态码
url_status=$(grep "HTTP/1.1" "$temp_file" | cut -d " " -f2)

# 删除临时文件
rm -f "$temp_file"






