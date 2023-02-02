#!/bin/sh
# echo "download color map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles.tif -o lroc_color_poles.tif

# echo "download bump map from NASA"
# curl https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/ldem_64_uint.tif -o ldem_64_uint.tif

echo "shrink color map"
# convert lroc_color_poles.tif -sample 8000x4000 -normalize -type grayscale moonColorMap.8k.png
# convert lroc_color_poles.tif -sample 4800x2400 -normalize -type grayscale moonColorMap.4.8k.png
# convert lroc_color_poles.tif -sample 3840x1920 -normalize -type grayscale moonColorMap.3.84k.png
# convert lroc_color_poles.tif -sample 3600x1800 -normalize -type grayscale moonColorMap.3.6k.png

echo "shrink bump map"
# convert ldem_64_uint.tif -sample 8000x4000 -normalize -type grayscale moonBumpMap.8k.png
# convert ldem_64_uint.tif -sample 4800x2400 -normalize -type grayscale moonBumpMap.4.8k.png
# convert ldem_64_uint.tif -sample 3840x1920 -normalize -type grayscale moonBumpMap.3.84k.png
# convert ldem_64_uint.tif -sample 3600x1800 -normalize -type grayscale moonBumpMap.3.6k.png

echo "combine color and bump map"
# convert moonColorMap.8k.png -negate +level 0,50% invertedColorMap.8k.0.5.tif
# convert moonBumpMap.8k.png +level 0,50% moonBumpMap.8k.0.5.tif
# convert invertedColorMap.8k.0.5.tif moonBumpMap.8k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.8k.png
# convert moonColorMap.4.8k.png -negate +level 0,50% invertedColorMap.4.8k.0.5.tif
# convert moonBumpMap.4.8k.png +level 0,50% moonBumpMap.4.8k.0.5.tif
# convert invertedColorMap.4.8k.0.5.tif moonBumpMap.4.8k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.4.8k.png
# convert moonColorMap.3.84k.png -negate +level 0,50% invertedColorMap.3.84k.0.5.tif
# convert moonBumpMap.3.84k.png +level 0,50% moonBumpMap.3.84k.0.5.tif
# convert invertedColorMap.3.84k.0.5.tif moonBumpMap.3.84k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.3.84k.png
# convert moonColorMap.3.6k.png -negate +level 0,50% invertedColorMap.3.6k.0.5.tif
# convert moonBumpMap.3.6k.png +level 0,50% moonBumpMap.3.6k.0.5.tif
# convert invertedColorMap.3.6k.0.5.tif moonBumpMap.3.6k.0.5.tif -background black -compose plus -layers flatten -normalize moonBumpAddInvertedColorMap.3.6k.png
