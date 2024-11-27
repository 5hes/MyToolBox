from fontTools.ttLib import TTFont

# 要处理的字体文件列表
font_files = [
    'Hybrid.ttf',
    'Hybrid-r.ttf',
    'merged-font.ttf',
    'merged-font-r.ttf'
]

# 遍历每个字体文件
for font_file in font_files:
    # 打开字体文件
    font = TTFont(font_file)
    
    # 修改 OS/2 表中的 xAvgCharWidth 属性
    font['OS/2'].xAvgCharWidth = 500
    
    # 修改 panose.bProportion 属性
    font['OS/2'].panose.bProportion = 0  # 设置为 0，表示无特定比例

    # 保存修改后的字体，添加 "fixed" 后缀
    new_font_file = font_file.replace('.ttf', '_fixed.ttf')
    font.save(new_font_file)

    # 关闭字体文件
    font.close()

print("字体文件已成功修改并保存。")
