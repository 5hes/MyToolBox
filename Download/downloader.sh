#!/bin/bash

# 定义文件路径
link_file="link"  # 包含链接的文件

# 逐行读取链接文件
while IFS= read -r link; do
    # 使用 wget 下载文件
    wget -q -P good -O "1.7z.$(printf "%03d" $((i+1)))" "$link" &
    ((i++))  # 增加计数器
done < "$link_file"

wait  # 等待所有后台进程完成

echo "所有文件下载完成，执行下一步操作。"
