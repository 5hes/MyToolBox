from fontTools.ttLib import TTFont

def merge_fonts(source_font_path, eng_font_path, merged_font_path):
    # 加载字体文件
    font1 = TTFont(source_font_path)
    font2 = TTFont(eng_font_path)

    # 合并字体
    for table in font2.keys():
        if table not in font1.keys():
            font1[table] = font2[table]
        else:
            # 处理 glyf 表
            if table == "glyf":
                for glyph in font2["glyf"].keys():
                    # 如果 glyph 不在 font1 中，添加它
                    if glyph not in font1["glyf"].keys():
                        font1["glyf"][glyph] = font2["glyf"][glyph]
                    else:
                        # 如果 glyph 已存在，您可以选择覆盖或跳过
                        # 这里选择覆盖
                        font1["glyf"][glyph] = font2["glyf"][glyph]

    # 保存合并后的字体
    font1.save(merged_font_path)

# 使用示例
merge_fonts("SourceHanSansCN-Regular-nohint.ttf", "eng.ttf", "merged_font.ttf")
