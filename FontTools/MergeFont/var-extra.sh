#!/bin/bash

# 查找当前目录下的 TTF 文件
TTF_FILES=(*.ttf)

# 检查是否有 TTF 文件
if [ ${#TTF_FILES[@]} -eq 0 ]; then
    echo "当前目录下没有找到 TTF 文件。"
    exit 1
fi

# 自动选择第一个 TTF 文件
VF_FILE="${TTF_FILES[0]}"
echo "自动选择了： $VF_FILE"

# 创建输出目录，以字体名称命名
OUTPUT_DIR="${VF_FILE%.*}_fonts"
mkdir -p "$OUTPUT_DIR"

# 指定要提取的字重
TARGET_WEIGHT="400"  # 通常 Regular 字重对应的数值是 400

# 提取 Regular 字重
echo "正在提取 Regular 字重..."
OUTPUT_FILE="$OUTPUT_DIR/${VF_FILE%.*}_Regular.ttf"
fonttools varLib.instancer "$VF_FILE" "wght=$TARGET_WEIGHT" -o "$OUTPUT_FILE"

# 检查提取是否成功
if [ $? -eq 0 ]; then
    echo "Regular 字重已成功提取！文件保存在：$OUTPUT_FILE"
else
    echo "提取 Regular 字重失败。"
fi
