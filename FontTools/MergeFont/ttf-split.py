import os
import sys
from fontTools.ttLib import TTFont

def print_name_table(font):
    print("Name Table:")
    for record in font['name'].names:
        print(f"  ID: {record.nameID}, Platform: {record.platformID}, Encoding: {record.platEncID}, Language: {record.langID}, String: {record.toUnicode()}")

def split_variable_font(input_file):
    font = TTFont(input_file)
    fvar = font['fvar']
    
    # 打印名称表内容
    print_name_table(font)

    # 获取所有字重实例
    instances = fvar.instances

    # 创建输出目录
    output_dir = f"{os.path.splitext(input_file)[0]}_split"
    os.makedirs(output_dir, exist_ok=True)

    for instance in instances:
        # 创建新字体对象
        new_font = TTFont(input_file)
        
        # 获取子家族名称
        subfamily_name_record = font['name'].getName(instance.subfamilyNameID, 2, 3, 1)
        
        if subfamily_name_record is not None:
            subfamily_name = subfamily_name_record.toUnicode()
        else:
            # 使用默认名称
            weight_value = instance.coordinates.get('wght', 'Unknown')
            subfamily_name = f"Weight-{weight_value}"
            print(f"Warning: Subfamily name not found for instance ID {instance.subfamilyNameID}. Using default name: {subfamily_name}.")
        
        # 设置新字体的名称
        new_font['name'].setName(subfamily_name, 2, 3, 1, 1033)  # Subfamily Name
        
        # 只保留当前实例
        new_font['fvar'].instances = [instance]  
        
        # 更新字体的其他相关信息
        new_font['fvar'].axes = font['fvar'].axes  # 保留轴信息
        new_font['fvar'].instanceCount = 1  # 设置实例数量为1
        
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
