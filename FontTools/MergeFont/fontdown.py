import argparse
from fontTools.ttLib import TTFont
from fontTools.pens.recordingPen import RecordingPen
from fontTools.pens.transformPen import TransformPen

def modify_font_baseline(font_path, move_amount, output_path):
    # 打开字体文件
    font = TTFont(font_path)

    # 修改每个字形的基线
    for glyph_name, glyph in font['glyf'].glyphs.items():
        if glyph.isComposite():
            # 对于复合字形，获取其组成部分的坐标
            pen = RecordingPen()
            glyph.draw(pen)
            coordinates = pen.value

            # 移动坐标
            for point in coordinates:
                point[1] += move_amount  # 移动 Y 坐标

            # 重新绘制字形
            glyph.clear()
            for point in coordinates:
                glyph.appendPoint(point[0], point[1], point[2])  # 添加移动后的点
        else:
            # 对于简单字形，获取坐标并移动
            pen = RecordingPen()
            glyph.draw(pen)
            coordinates = pen.value

            # 移动坐标
            for point in coordinates:
                point[1] += move_amount  # 移动 Y 坐标

            # 重新绘制字形
            glyph.clear()
            for point in coordinates:
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
