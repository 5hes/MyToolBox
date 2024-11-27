#!/bin/bash
found_file=true
if [ "$EXTRA" = true ]; then
    while [ "$found_file" = "true" ]; do
        any_extracted=false
        found_file=false  # {{ edit_1 }} 新增变量，标记是否找到文件
        for file in *; do
            case "$file" in
                *.zip)
                    echo "解压缩 $file ..."
                    unzip -o "$file" -d . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar.gz | *.tgz)
                    echo "解压缩 $file ..."
                    tar -xzf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar.bz2 | *.tbz2)
                    echo "解压缩 $file ..."
                    tar -xjf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar.xz)
                    echo "解压缩 $file ..."
                    tar -xJf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar)
                    echo "解压缩 $file ..."
                    tar -xf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.gz)
                    echo "解压缩 $file ..."
                    gunzip -f "$file" && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.bz2)
                    echo "解压缩 $file ..."
                    bunzip2 -f "$file" && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.xz)
                    echo "解压缩 $file ..."
                    unxz -f "$file" && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.7z)
                    echo "解压缩 $file ..."
                    7z x "$file" -o. && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.rar)
                    echo "解压缩 $file ..."
                    unrar x "$file" . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar.lz4)
                    echo "解压缩 $file ..."
                    tar --lzip -xf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.lz4)
                    echo "解压缩 $file ..."
                    lz4 -d "$file" && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.zst)
                    echo "解压缩 $file ..."
                    unzstd "$file" && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *.tar.zst)
                    echo "解压缩 $file ..."
                    tar --zstd -xf "$file" -C . && any_extracted=true
                    found_file=true  # {{ edit_1 }} 标记找到文件
                    ;;
                *)
                    echo "$file 不是一个支持的压缩文件格式，跳过。"
                    ;;
            esac
        done
        
        # 调试信息
        echo "本轮循环：any_extracted=$any_extracted, found_file=$found_file"

        if [ "$any_extracted" = false ] && [ "$found_file" = false ]; then
            echo "没有更多的压缩文件可以解压，退出。"
            break
        fi
        
        # 如果没有找到文件但有文件被处理，继续下一轮循环
        if [ "$found_file" = false ]; then
            echo "没有找到新的压缩文件，退出。"
            break
        fi
    done
else
    echo "解压缩操作被跳过。"
fi
