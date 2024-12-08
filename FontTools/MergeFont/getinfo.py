import sys
import os
from fontTools.ttLib import TTFont

def get_font_info(font_path):
    # 加载字体文件
    font = TTFont(font_path)

    # 获取 OS/2 表
    os2_table = font['OS/2']

    # 获取 panose.bProportion
    bProportion = os2_table.panose.bProportion

    # 获取 xAvgCharWidth
    xAvgCharWidth = os2_table.xAvgCharWidth

    # 打印结果
    print(f"Font: {font_path}")
    print(f"bProportion: {bProportion}")
    print(f"xAvgCharWidth: {xAvgCharWidth}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python getinfo.py <font_file.ttf>")
        sys.exit(1)

    font_file = sys.argv[1]

    # 获取当前工作目录
    current_dir = os.getcwd()
    # 构建字体文件的相对路径
    font_path = os.path.join(current_dir, font_file)

    # 打印调试信息
    print(f"Current directory: {current_dir}")
    print(f"Font path: {font_path}")

    get_font_info(font_path)
