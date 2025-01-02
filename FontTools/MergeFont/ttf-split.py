import os
import sys
from fontTools.ttLib import TTFont

def split_variable_font(input_file):
    font = TTFont(input_file)
    fvar = font['fvar']
    
    # 获取所有字重
    instances = fvar.instances

    # 创建输出目录
    output_dir = f"{os.path.splitext(input_file)[0]}_split"
    os.makedirs(output_dir, exist_ok=True)

    for instance in instances:
        # 创建新字体对象
        new_font = TTFont(input_file)
        
        # 设置实例的名称
        subfamily_name = font['name'].getName(instance.subfamilyNameID, 2, 3, 1, 1033).toUnicode()
        new_font['name'].setName(subfamily_name, 2, 3, 1, 1033)  # Subfamily Name
        
        # 设置其他必要的属性（如权重等）
        new_font['fvar'].instances = [instance]  # 只保留当前实例
        
        # 保存新字体文件
        output_file = os.path.join(output_dir, f"{subfamily_name}.ttf")
        new_font.save(output_file)
        print(f"Saved: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python split_variable_font.py <input_file.ttf>")
        sys.exit(1)

    input_file = sys.argv[1]
    split_variable_font(input_file)
