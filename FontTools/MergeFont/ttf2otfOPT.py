import sys
import os
import fontforge

def convert_ttf_to_otf(input_file, backup=False):
    """
    Convert a TTF font file to OTF format with super ultimate high quality settings.

    Parameters:
    - input_file: str, path to the input TTF file.
    - backup: bool, whether to create a backup of the original TTF file.
    """
    # 检查输入文件是否存在
    if not os.path.isfile(input_file):
        print(f"Error: The file '{input_file}' does not exist.")
        return

    # 生成输出文件名
    output_file = input_file.rsplit('.', 1)[0] + '.otf'

    # 备份原始 TTF 文件
    if backup:
        backup_file = input_file + '.bak'
        os.rename(input_file, backup_file)
        print(f"Backup created: {backup_file}")

    try:
        # 打开 TTF 文件
        font = fontforge.open(input_file)

        # 进行优化设置
        font.removeOverlap()  # 移除重叠
        font.correctDirection()  # 确保方向正确
        font.simplify()  # 简化路径以提高质量

        # 额外的优化步骤
        # font.autoHint()  # 自动提示以提高渲染质量
        # font.smooth()  # 平滑轮廓
        # font.round()  # 四舍五入坐标以提高兼容性
        # font.removeOverlap()  # 再次移除重叠以确保没有问题

        # 设置字体特性
        # font.addLookup("gpos", "gpos", (("gpos", "1.0"),))
        # font.addLookup("gsub", "gsub", (("gsub", "1.0"),))

        # 生成 OTF 文件，使用更高质量的选项
        font.generate(output_file, flags=("opentype", "no-kerning", "no-embed", "no-embed-fonts"))
        print(f"Successfully converted '{input_file}' to '{output_file}' with super ultimate high quality settings.")

    except Exception as e:
        print(f"An error occurred during conversion: {e}")

    finally:
        # 关闭字体
        font.close()

if __name__ == "__main__":
    # 确保传入了文件名
    if len(sys.argv) < 2:
        print("Usage: fontforge -script super_ultimate_high_quality_ttf_to_otf.py <input.ttf> [--backup]")
        sys.exit(1)

    # 获取输入文件名
    input_file = sys.argv[1]
    backup = '--backup' in sys.argv

    # 执行转换
    convert_ttf_to_otf(input_file, backup)
