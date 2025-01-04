#!/bin/bash

# 查找当前目录下的 TTF 文件
TTF_FILES=(*.ttf)

# 检查是否有 TTF 文件
if [ ${#TTF_FILES[@]} -eq 0 ]; then
    echo "当前目录下没有找到 TTF 文件。"
    exit 1
fi

VF_FILE="${TTF_FILES[0]}"
echo "自动选择了： $VF_FILE"

# 检查是否成功选择了文件
if [ -z "$VF_FILE" ]; then
    echo "没有选择有效的文件，脚本终止。"
    exit 1
fi

# 创建输出目录，以字体名称命名
OUTPUT_DIR="${VF_FILE%.*}_fonts"
mkdir -p "$OUTPUT_DIR"

export weights="150 200 250 305 340 400 480 540 630 700"

# 将用户输入的字重分割成数组
IFS=' ' read -ra weight_array <<< "$weights"

# 遍历数组并执行相应的操作
for weight in "${weight_array[@]}"; do
  echo "正在提取字重：$weight"
  # 确保 fonttools 和 varLib.instancer 可用，这里假设它们已经被正确安装
  OUTPUT_FILE="$OUTPUT_DIR/${VF_FILE%.*}_wght_$weight.ttf"
  fonttools varLib.instancer "$VF_FILE" "wght=$weight" -o "$OUTPUT_FILE"
  if [ $? -ne 0 ]; then
    echo "提取字重 $weight 失败。"
  fi
done

echo "提取字重已完成！文件保存在以原文件名命名的文件夹中"
