#!/bin/bash
if [ "$EXTRA" = true ]; then
    while true; do
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
                *.tar.xz)  # {{ edit_2 }}
                    echo "解压缩 $file ..."  # {{ edit_2 }}
                    tar -xJf "$file" -C . && any_extracted=true  # {{ edit_2 }}
                    found_file=true  # {{ edit_2 }} 标记找到文件
                    ;;  # {{ edit_2 }}
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
                *.xz)  # {{ edit_3 }}
                    echo "解压缩 $file ..."  # {{ edit_3 }}
                    unxz -f "$file" && any_extracted=true  # {{ edit_3 }}
                    found_file=true  # {{ edit_3 }} 标记找到文件
                    ;;  # {{ edit_3 }}
                *.7z)  # {{ edit_4 }}
                    echo "解压缩 $file ..."  # {{ edit_4 }}
                    7z x "$file" -o. && any_extracted=true  # {{ edit_4 }}
                    found_file=true  # {{ edit_4 }} 标记找到文件
                    ;;  # {{ edit_4 }}
                *.rar)  # {{ edit_5 }}
                    echo "解压缩 $file ..."  # {{ edit_5 }}
                    unrar x "$file" . && any_extracted=true  # {{ edit_5 }}
                    found_file=true  # {{ edit_5 }} 标记找到文件
                    ;;  # {{ edit_5 }}
                *.zipx)  # {{ edit_6 }}
                    echo "解压缩 $file ..."  # {{ edit_6 }}
                    zipx -d "$file" -o. && any_extracted=true  # {{ edit_6 }}
                    found_file=true  # {{ edit_6 }} 标记找到文件
                    ;;  # {{ edit_6 }}
                *.tar.lz | *.tlz)  # {{ edit_7 }}
                    echo "解压缩 $file ..."  # {{ edit_7 }}
                    tar --lzip -xf "$file" -C . && any_extracted=true  # {{ edit_7 }}
                    found_file=true  # {{ edit_7 }} 标记找到文件
                    ;;  # {{ edit_7 }}
                *.tar.lzma)  # {{ edit_8 }}
                    echo "解压缩 $file ..."  # {{ edit_8 }}
                    tar --lzma -xf "$file" -C . && any_extracted=true  # {{ edit_8 }}
                    found_file=true  # {{ edit_8 }} 标记找到文件
                    ;;  # {{ edit_8 }}
                *.lzma)  # {{ edit_9 }}
                    echo "解压缩 $file ..."  # {{ edit_9 }}
                    lzma -d "$file" && any_extracted=true  # {{ edit_9 }}
                    found_file=true  # {{ edit_9 }} 标记找到文件
                    ;;  # {{ edit_9 }}
                *.z)  # {{ edit_10 }}
                    echo "解压缩 $file ..."  # {{ edit_10 }}
                    uncompress "$file" && any_extracted=true  # {{ edit_10 }}
                    found_file=true  # {{ edit_10 }} 标记找到文件
                    ;;  # {{ edit_10 }}
                *.zst)  # {{ edit_11 }}
                    echo "解压缩 $file ..."  # {{ edit_11 }}
                    unzstd "$file" && any_extracted=true  # {{ edit_11 }}
                    found_file=true  # {{ edit_11 }} 标记找到文件
                    ;;  # {{ edit_11 }}
                *.tar.zst)  # {{ edit_12 }}
                    echo "解压缩 $file ..."  # {{ edit_12 }}
                    tar --zstd -xf "$file" -C . && any_extracted=true  # {{ edit_12 }}
                    found_file=true  # {{ edit_12 }} 标记找到文件
                    ;;  # {{ edit_12 }}
                *.zip.001)  # {{ edit_13 }}
                    echo "解压缩分卷文件 $file ..."  # {{ edit_13 }}
                    cat "$file" | unzip -o -d . && any_extracted=true  # {{ edit_13 }}
                    found_file=true  # {{ edit_13 }} 标记找到文件
                    ;;  # {{ edit_13 }}
                *)
                    echo "$file 不是一个支持的压缩文件格式，跳过。"
                    ;;
            esac
        done
        
        if [ "$any_extracted" = false ] && [ "$found_file" = false ]; then  # {{ edit_1 }} 检查是否找到文件
            echo "没有更多的压缩文件可以解压，退出。"
            break
        fi
    done
else
    echo "解压缩操作被跳过。"
fi
