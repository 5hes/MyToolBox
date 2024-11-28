from fontTools.ttLib import TTFont

font = TTFont('merged.ttf')

font['OS/2'].xAvgCharWidth = 500
font['OS/2'].panose.bProportion = 0

font.save('merged-fixed.ttf')
