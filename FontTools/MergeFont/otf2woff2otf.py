import argparse
import subprocess
from fontTools.ttLib import TTFont

def convert_otf_to_woff2(input_file, woff2_file):
    # 打开 OTF 文件
    font = TTFont(input_file)
    
    # 保存为 WOFF2 文件
    font.flavor = 'woff2'
    font.save(woff2_file)
    print(f"Converted {input_file} to {woff2_file}")

def convert_woff2_to_otf(woff2_file, output_file):
    # 使用 woff2_decompress 命令将 WOFF2 转换回 OTF
    subprocess.run(['woff2_decompress', woff2_file, output_file], check=True)
    print(f"Converted {woff2_file} back to {output_file}")

def main():
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(description='Convert OTF to WOFF2 and back to OTF.')
    parser.add_argument('otf_file', type=str, help='Input OTF file to convert')
    parser.add_argument('woff2_file', type=str, help='Output WOFF2 file')
    parser.add_argument('converted_otf_file', type=str, help='Output OTF file after conversion from WOFF2')

    args = parser.parse_args()

    # 转换 OTF 到 WOFF2
    convert_otf_to_woff2(args.otf_file, args.woff2_file)

    # 转换 WOFF2 回 OTF
    convert_woff2_to_otf(args.woff2_file, args.converted_otf_file)

if __name__ == '__main__':
    main()
