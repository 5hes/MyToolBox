from fontTools.ttLib import TTFont
from fontTools.merge import merge

def merge_fonts(source_font_path, eng_font_path, merged_font_path):
    font1 = TTFont(source_font_path)
    font2 = TTFont(eng_font_path)

    # 使用 merge 函数合并字体
    merged_font = merge([font1, font2])

    # 保存合并后的字体
    merged_font.save(merged_font_path)
    print(f"Fonts merged and saved to {merged_font_path}")

# 使用示例
merge_fonts("cjk.ttf", "eng.ttf", "merged_font2.ttf")
