#!/bin/sh
# echo "download color map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles.tif -o lroc_color_poles.tif

# echo "download bump map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/ldem_64_uint.tif -o ldem_64_uint.tif


echo "shrink color map"
# convert lroc_color_poles.tif -sample 6000x3000 -normalize -type grayscale moonColorMap.6k.png
convert lroc_color_poles.tif -sample 3600x1800 -normalize -type grayscale moonColorMap.3.6k.png

echo "shrink bump map"
# convert ldem_64_uint.tif -sample 6000x3000 -normalize -type grayscale moonBumpMap.6k.tif
convert ldem_64_uint.tif -sample 3600x1800 -normalize -type grayscale moonBumpMap.3.6k.tif
convert moonBumpMap.3.6k.tif -sample 2048x1024 -type grayscale moonBumpMap.2k.png

echo "combine color and bump map"
# convert moonColorMap.6k.png -negate +level 0,50% invertedColorMap.6k.0.5.tif
# convert moonBumpMap.6k.tif +level 0,50% bumpMap.6k.0.5.tif
# convert invertedColorMap.6k.0.5.tif bumpMap.6k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.6k.png
convert moonColorMap.3.6k.png -negate +level 0,50% invertedColorMap.0.5.tif
convert moonBumpMap.3.6k.tif +level 0,50% bumpMap.0.5.tif
convert invertedColorMap.0.5.tif bumpMap.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.3.6k.png
