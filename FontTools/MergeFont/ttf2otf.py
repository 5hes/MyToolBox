import os
import sys
from os import path
from sys import argv
from fontforge import *

if len(sys.argv) < 2:
        print("Usage : {0} file.otf".format(sys.argv[0]))
        exit(1)

def check_file(filePath):
    if path.exists(filePath):
        numb = 1
        while True:
            newPath = "{0}_{2}{1}".format(*path.splitext(filePath) + (numb,))
            if path.exists(newPath):
                numb += 1
            else:
                return newPath
    return filePath

input_file = sys.argv[1]
otf_file = "{0}.otf".format(input_file.split(".")[0])
safe_path = check_file(otf_file)

font = open(input_file)
font.generate(safe_path)
font.close()
