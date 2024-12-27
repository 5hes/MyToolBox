import argparse
from fontTools.ttLib import TTFont

def convert_otf_to_woff(input_file, woff_file):
    # 打开 OTF 文件
    font = TTFont(input_file)
    
    # 保存为 WOFF 文件
    font.flavor = 'woff'
    font.save(woff_file)
    print(f"Converted {input_file} to {woff_file}")

def convert_woff_to_otf(woff_file, output_file):
    # 打开 WOFF 文件
    font = TTFont(woff_file)
    
    # 保存为 OTF 文件
    font.flavor = 'otf'
    font.save(output_file)
    print(f"Converted {woff_file} back to {output_file}")

def main():
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(description='Convert OTF to WOFF and back to OTF.')
    parser.add_argument('otf_file', type=str, help='Input OTF file to convert')
    parser.add_argument('woff_file', type=str, help='Output WOFF file')
    parser.add_argument('converted_otf_file', type=str, help='Output OTF file after conversion from WOFF')

    args = parser.parse_args()

    # 转换 OTF 到 WOFF
    convert_otf_to_woff(args.otf_file, args.woff_file)

    # 转换 WOFF 回 OTF
    convert_woff_to_otf(args.woff_file, args.converted_otf_file)

if __name__ == '__main__':
    main()
