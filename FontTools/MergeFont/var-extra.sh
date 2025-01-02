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

# 获取所有可用的字重
echo "正在提取所有字重..."
weights=$(fonttools varLib.instancer "$VF_FILE" --list-weights)

# 遍历所有字重并执行相应的操作
for weight in $weights; do
  echo "正在提取字重：$weight"
  OUTPUT_FILE="$OUTPUT_DIR/${VF_FILE%.*}_wght_$weight.ttf"
  fonttools varLib.instancer "$VF_FILE" "wght=$weight" -o "$OUTPUT_FILE"
  if [ $? -ne 0 ]; then
    echo "提取字重 $weight 失败。"
  fi
done

echo "提取字重已完成！文件保存在以原文件名命名的文件夹中"
