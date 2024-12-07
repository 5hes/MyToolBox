# 使用 FontForge 脚本合并字体
import fontforge

def merge_fonts(source_font_path, eng_font_path, merged_font_path):
    # 打开字体文件
    font1 = fontforge.open(source_font_path)
    font2 = fontforge.open(eng_font_path)

    # 合并字形
    for glyph in font2.glyphs():
        if glyph.isWorthOutputting():
            font1.addGlyph(glyph)

    # 保存合并后的字体
    font1.generate(merged_font_path)
    print(f"Fonts merged and saved to {merged_font_path}")

# 使用示例
merge_fonts("cjk.ttf", "eng.ttf", "merged_forge.ttf")
