#!/bin/bash
if [ "$EXTRA" = true ]; then
    while true; do
        any_extracted=false
        for file in *; do
            case "$file" in
                *.zip)
                    echo "解压缩 $file ..."
                    unzip -o "$file" -d . && any_extracted=true
                    ;;
                *.tar.gz | *.tgz)
                    echo "解压缩 $file ..."
                    tar -xzf "$file" -C . && any_extracted=true
                    ;;
                *.tar.bz2 | *.tbz2)
                    echo "解压缩 $file ..."
                    tar -xjf "$file" -C . && any_extracted=true
                    ;;
                *.tar)
                    echo "解压缩 $file ..."
                    tar -xf "$file" -C . && any_extracted=true
                    ;;
                *.gz)
                    echo "解压缩 $file ..."
                    gunzip -f "$file" && any_extracted=true
                    ;;
                *.bz2)
                    echo "解压缩 $file ..."
                    bunzip2 -f "$file" && any_extracted=true
                    ;;
                *)
                    echo "$file 不是一个支持的压缩文件格式，跳过。"
                    ;;
            esac
        done
        
        if [ "$any_extracted" = false ]; then
            echo "没有更多的压缩文件可以解压，退出。"
            break
        fi
    done
else
    echo "解压缩操作被跳过。"
fi
