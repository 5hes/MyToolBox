import sys
from fontTools.ttLib import TTFont

def modify_font_spacing(font_path, new_spacing, output_path):
    # 打开字体文件
    font = TTFont(font_path)

    # 获取 'hmtx' 表（水平度量表）
    hmtx = font['hmtx']

    # 修改所有字形的间距
    for glyph_name in hmtx.metrics.keys():
        # 获取当前的宽度和间距
        current_width, _ = hmtx.metrics[glyph_name]
        # 设置新的间距
        hmtx.metrics[glyph_name] = (current_width, new_spacing)

    # 保存修改后的字体文件
    font.save(output_path)
    print(f"Modified font saved as: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python modify_spacing.py <font_file.ttf> <new_spacing> <output_file.ttf>")
        sys.exit(1)

    font_file = sys.argv[1]
    try:
        new_spacing_value = int(sys.argv[2])
    except ValueError:
        print("Error: new_spacing must be an integer.")
        sys.exit(1)

    output_file = sys.argv[3]

    modify_font_spacing(font_file, new_spacing_value, output_file)
