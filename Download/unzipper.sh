ctn=1
if [ "$EXTRA" = "false" ]; then
  exit 0
fi
while [ $ctn -eq 1 ]; do
  i=0
  let i +=1
  if [ $i -eq 10 ]; then
    exit 0
  fi
  ctn=0
  for file in *; do
    if [ -f "$file" ]; then  # 检查文件是否存在
      case "$file" in
        *.zip)
          if [ "$crypt" = "true" ]; then
            unzip -P "$password" "$file" && rm "$file"  # 解压并删除 .zip 文件
          else
            unzip "$file" && rm "$file"
          fi
          ctn=1
          ;;
        *.tar)
          tar -xf "$file" && rm "$file"  # 解压并删除 .tar 文件
          ctn=1
          ;;
        *.tar.gz | *.tgz)
          tar -xzf "$file" && rm "$file"  # 解压并删除 .tar.gz 文件
          ctn=1
          ;;
        *.tar.bz2 | *.tbz2)
          tar -xjf "$file" && rm "$file"  # 解压并删除 .tar.bz2 文件
          ctn=1
          ;;
        *.tar.xz)
          tar -xJf "$file" && rm "$file"  # 解压并删除 .tar.xz 文件
          ctn=1
          ;;
        *.tar.lz)
          tar --lzip -xf "$file" && rm "$file"  # 解压并删除 .tar.lz 文件
          ctn=1
          ;;
        *.tar.lzma)
          tar --lzma -xf "$file" && rm "$file"  # 解压并删除 .tar.lzma 文件
          ctn=1
          ;;
        *.gz)
          gunzip "$file"  # 解压 .gz 文件，删除原文件
          ctn=1
          ;;
        *.bz2)
          bunzip2 "$file"  # 解压 .bz2 文件，删除原文件
          ctn=1
          ;;
        *.xz)
          unxz "$file"  # 解压 .xz 文件，删除原文件
          ctn=1
          ;;
        *.lz)
          lz -d "$file"  # 解压 .lz 文件，删除原文件
          ctn=1
          ;;
        *.lzma)
          unlzma "$file"  # 解压 .lzma 文件，删除原文件
          ctn=1
          ;;
        *.z)
          uncompress "$file"  # 解压 .z 文件，删除原文件
          ctn=1
          ;;
        *.zipx)
          if [ "$crypt" = "true" ]; then
            unzip -P "$password" "$file" && rm "$file"  # 解压并删除 .zipx 文件
          else
            unzip "$file" && rm "$file"
          fi
          ctn=1
          ;;
        *.rar)
          if [ "$crypt" = "true" ]; then
            unrar x -p"$password" "$file" && rm "$file"  # 解压并删除 .rar 文件
          else
            unrar x "$file" && rm "$file"
          fi
          ctn=1
          ;;
        *.tbz)
          tar -xjf "$file" && rm "$file"  # 解压并删除 .tbz 文件
          ctn=1
          ;;
        *.tbz.xz)
          tar -xJf "$file" && rm "$file"  # 解压并删除 .tbz.xz 文件
          ctn=1
          ;;
        *.tbz.lz)
          tar --lzip -xf "$file" && rm "$file"  # 解压并删除 .tbz.lz 文件
          ctn=1
          ;;
        *.tbz.lzma)
          tar --lzma -xf "$file" && rm "$file"  # 解压并删除 .tbz.lzma 文件
          ctn=1
          ;;
        # 支持分卷文件
        *.001 | *.7z.001 | *.zip.001 | *.tar.001)
          # 处理分卷文件
          # base_name="${file%.*}"  # 去掉后缀
          if [ "$crypt" = "true" ]; then
            7z e -p "$password" "$file" && rm "$file"  # 使用 7z 解压分卷文件
          else
            7z e "$file" && rm "$file"  # 使用 7z 解压分卷文件
          fi
          ctn=1
          ;;
      esac
    fi
  done
done
