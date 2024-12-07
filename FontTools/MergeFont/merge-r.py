from fontTools.ttLib import TTFont

def merge_fonts(source_font_path, eng_font_path, merged_font_path):
    # 加载字体文件
    font1 = TTFont(source_font_path)
    font2 = TTFont(eng_font_path)

    # 合并 glyf 表
    if "glyf" in font2.keys():
        for glyph in font2["glyf"].keys():
            if glyph not in font1["glyf"].keys():
                font1["glyf"][glyph] = font2["glyf"][glyph]
            else:
                font1["glyf"][glyph] = font2["glyf"][glyph]

    # 合并 hmtx 表
    if "hmtx" in font2.keys():
        for glyph in font2["hmtx"].metrics.keys():
            if glyph not in font1["hmtx"].metrics.keys():
                font1["hmtx"].metrics[glyph] = font2["hmtx"].metrics[glyph]
            else:
                font1["hmtx"].metrics[glyph] = font2["hmtx"].metrics[glyph]

    # 保存合并后的字体
    font1.save(merged_font_path)

# 使用示例
merge_fonts("eng.ttf", "cjk.ttf", "merged-font-r.ttf")
