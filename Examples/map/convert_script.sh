#!/bin/sh
#curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles.tif -o lroc_color_poles.tif
#curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/ldem_64_uint.tif -o ldem_64_uint.tif

convert lroc_color_poles.tif -sample 5760x2880 -type grayscale moonColorMap.5k.png
convert ldem_64_uint.tif -sample 5760x2880 -type grayscale moonBumpMap.5k.tif

convert moonColorMap.5k.png -negate +level 0,50% invertedColorMap.0.5.tif
convert moonBumpMap.5k.tif +level 0,50% bumpMap.0.5.tif
convert invertedColorMap.0.5.tif bumpMap.0.5.tif -background black -compose plus -layers flatten moonBumpAddInvertedColorMap.5k.png

convert moonBumpMap.5k.tif -sample 2048x1024 -type grayscale moonBumpMap.2k.png
