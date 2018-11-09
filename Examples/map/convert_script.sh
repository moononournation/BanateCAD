#!/bin/sh
convert Moon_23k_Color_v001.tif -type grayscale -level 0,100%,1.8 moonColorMap.23k.png
convert Moon_23k_Disp_v002.tif -type grayscale -level 0,100%,1.8 moonBumpMap.23k.png

convert moonColorMap.23k.png -negate +level 0,50% invertedColorMap.5.tif
convert moonBumpMap.23k.png +level 0,50% bumpMap.5.tif
convert -define registry:temporary-path=/2t_data/tmp invertedColorMap.5.tif bumpMap.5.tif -background black -compose plus -layers flatten moonBumpAddInvertedColorMap.23k.png

# convert moonColorMap.23k.png -negate +level 0,37.5% invertedColorMap3.tif
# convert moonBumpMap.23k.png +level 0,62.5% bumpMap5.tif
# convert -define registry:temporary-path=/2t_data/tmp invertedColorMap3.tif bumpMap5.tif -background black -compose plus -layers flatten moonBumpAddInvertedColorMap5to3.23k.png

# convert moonColorMap.23k.png -sample 2048x1024 moonColorMap.png
# convert moonBumpMap.23k.png -sample 2048x1024 moonBumpMap.png
# convert moonBumpAddInvertedColorMap.23k.png -sample 2048x1024 moonBumpAddInvertedColorMap.png
# convert moonBumpAddInvertedColorMap5to3.23k.png -sample 2048x1024 moonBumpAddInvertedColorMap5to3.png
