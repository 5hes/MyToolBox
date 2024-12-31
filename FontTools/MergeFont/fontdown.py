import argparse
from fontTools.ttLib import TTFont
from fontTools.pens.recordingPen import RecordingPen

def modify_font_baseline(font_path, move_amount, output_path):
    # 打开字体文件
    font = TTFont(font_path)

    # 修改每个字形的基线
    for glyph_name, glyph in font['glyf'].glyphs.items():
        pen = RecordingPen()
        
        # 使用 glyfTable 作为参数
        glyph.draw(pen, font['glyf'])

        # 获取坐标
        coordinates = pen.value

        # 移动坐标
        new_coordinates = []
        for point in coordinates:
            if len(point) == 3:
                # point 是一个元组，包含 (x, y, onCurve)
                x, y, onCurve = point  # 解包元组
            elif len(point) == 2:
                # point 是一个元组，包含 (x, y)
                x, y = point
                onCurve = False  # 默认设置为 False，或根据需要进行调整
            else:
                continue  # 跳过不符合预期的点

            new_y = y + move_amount  # 移动 Y 坐标
            new_coordinates.append((x, new_y, onCurve))  # 重新构建元组

        # 清空当前字形并重新绘制
        glyph.clear()
        for point in new_coordinates:
            glyph.appendPoint(point[0], point[1], point[2])  # 添加移动后的点

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
