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

# 使用 ttx 提取 fvar 表信息
echo "获取所有可用的字重..."
ttx -o - "$VF_FILE" | grep -A 10 "<fvar>" | grep "<instance" | sed -E 's/.*wght="([^"]+)".*/\1/' > weights.txt

# 检查是否成功获取字重
if [ ! -s weights.txt ]; then
    echo "未能获取任何字重，请检查字体文件。"
    exit 1
fi

# 遍历所有字重并执行相应的操作
while read -r weight; do
  echo "正在提取字重：$weight"
  OUTPUT_FILE="$OUTPUT_DIR/${VF_FILE%.*}_wght_$weight.ttf"
  fonttools varLib.instancer "$VF_FILE" "wght=$weight" -o "$OUTPUT_FILE"
  if [ $? -ne 0 ]; then
    echo "提取字重 $weight 失败。"
  fi
done < weights.txt

# 清理临时文件
rm weights.txt

echo "提取字重已完成！文件保存在以原文件名命名的文件夹中"
