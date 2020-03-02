#!/bin/sh
# echo "download color map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles.tif -o lroc_color_poles.tif

# echo "download bump map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/ldem_64_uint.tif -o ldem_64_uint.tif


echo "shrink color map"
# convert lroc_color_poles.tif -sample 9000x4500 -normalize -type grayscale moonColorMap.9k.png
convert lroc_color_poles.tif -sample 3600x1800 -normalize -type grayscale moonColorMap.3.6k.png

echo "shrink bump map"
# convert ldem_64_uint.tif -sample 9000x4500 -normalize -type grayscale moonBumpMap.9k.png
convert ldem_64_uint.tif -sample 3600x1800 -normalize -type grayscale moonBumpMap.3.6k.png

echo "combine color and bump map"
# convert moonColorMap.9k.png -negate +level 0,50% invertedColorMap.9k.0.5.tif
# convert moonBumpMap.9k.png +level 0,50% moonBumpMap.9k.0.5.tif
# convert invertedColorMap.9k.0.5.tif moonBumpMap.9k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.9k.png
convert moonColorMap.3.6k.png -negate +level 0,50% invertedColorMap.3.6k.0.5.tif
convert moonBumpMap.3.6k.png +level 0,50% moonBumpMap.3.6k.0.5.tif
convert invertedColorMap.3.6k.0.5.tif moonBumpMap.3.6k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.3.6k.png
