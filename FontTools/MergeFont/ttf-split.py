import os
import sys
from fontTools.ttLib import TTFont

def split_variable_font(input_file):
    font = TTFont(input_file)
    fvar = font['fvar']
    
    # 获取所有字重实例
    instances = fvar.instances

    # 打印所有实例的信息
    print("Instances:")
    for instance in instances:
        # 打印实例的所有属性
        print(f"  Instance ID: {instance.subfamilyNameID}, Location: {instance.coordinates}")

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
            print(f"Warning: Subfamily name not found for instance ID {instance.subfamilyNameID}. Skipping this instance.")
            continue  # 跳过没有名称的实例
        
        # 设置新字体的名称
        new_font['name'].setName(subfamily_name, 2, 3, 1, 1033)  # Subfamily Name
        
        # 只保留当前实例
        new_font['fvar'].instances = [instance]  
        
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
