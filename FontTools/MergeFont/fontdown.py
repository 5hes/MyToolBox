import argparse
from fontTools.ttLib import TTFont

def modify_font_baseline(font_path, move_amount, output_path):
    # 打开字体文件
    font = TTFont(font_path)

    # 修改每个字形的基线
    for table in font['glyf'].glyphs.values():
        if table.isComposite():
            continue  # 跳过复合字形
        table.yMin -= move_amount  # 下移字形的最小 Y 值
        table.yMax -= move_amount  # 下移字形的最大 Y 值

    # 保存修改后的字体文件
    font.save(output_path)
    print(f"字体已成功下移并保存为 {output_path}")

if __name__ == "__main__":
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(description="Modify font baseline.")
    parser.add_argument("font_path", type=str, help="Path to the input font file.")
    parser.add_argument("move_amount", type=int, help="Amount to move the baseline (in units).")
    parser.add_argument("output_path", type=str, help="Path to save the modified font file.")

    # 解析参数
    args = parser.parse_args()

    # 调用修改函数
    modify_font_baseline(args.font_path, args.move_amount, args.output_path)
