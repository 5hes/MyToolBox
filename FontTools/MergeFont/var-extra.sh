#!/bin/bash

# 查找当前目录下的 TTF 文件
TTF_FILES=(*.ttf)

# 检查是否有 TTF 文件
if [ ${#TTF_FILES[@]} -eq 0 ]; then
    echo "当前目录下没有找到 TTF 文件。"
    exit 1
fi

# 列出 TTF 文件供用户选择
echo "请选择要提取的字体文件："
select VF_FILE in "${TTF_FILES[@]}"; do
    if [[ -n "$VF_FILE" ]]; then
        echo "您选择了： $VF_FILE"
        break
    else
        echo "无效选择，请重试。"
    fi
done

# 检查是否成功选择了文件
if [ -z "$VF_FILE" ]; then
    echo "没有选择有效的文件，脚本终止。"
    exit 1
fi

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
