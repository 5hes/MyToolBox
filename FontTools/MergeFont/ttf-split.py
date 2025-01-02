import os
import sys
from fontTools.ttLib import TTFont

def split_ttf(input_file):
    # 打开 TTF 文件
    font = TTFont(input_file)
    
    # 获取字体名称
    family_name = font['name'].getName(1, 3, 1).toUnicode()  # Family Name
    styles = {}

    # 收集所有字重
    for record in font['name'].names:
        if record.nameID == 2:  # Subfamily Name
            styles[record.toUnicode()] = None

    # 创建输出目录
    output_dir = f"{family_name}_split"
    os.makedirs(output_dir, exist_ok=True)

    # 分离字重并保存
    for style in styles.keys():
        # 创建新字体对象
        new_font = TTFont(input_file)
        
        # 过滤字形
        new_font['name'].names = [
            n for n in new_font['name'].names 
            if n.nameID != 2 or n.toUnicode() == style
        ]
        
        # 保存新字体文件
        output_file = os.path.join(output_dir, f"{family_name}_{style}.ttf")
        new_font.save(output_file)
        print(f"Saved: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python split_multiple_weights.py <input_file.ttf>")
        sys.exit(1)

    input_file = sys.argv[1]
    split_ttf(input_file)
