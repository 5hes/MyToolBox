ctn=1
while [ $ctn -eq 1 ]; do
  ctn=0
  for file in *; do
    if [ -f "$file" ]; then  # 检查文件是否存在
      case "$file" in
        *.zip)
          unzip "$file" && rm "$file"  # 解压并删除 .zip 文件
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
          unzip "$file" && rm "$file"  # 解压并删除 .zipx 文件
          ctn=1
          ;;
        *.rar)
          unrar x "$file" && rm "$file"  # 解压并删除 .rar 文件
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
      esac
    fi
  done
done
