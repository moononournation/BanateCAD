#!/bin/sh
lua Examples/cmdLineBatchJob.lua

mkdir -p Examples/stl
xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.5_inches.stl -o Examples/stl/moon_lamp_1.5_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2_inches.stl -o Examples/stl/moon_lamp_2_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2.5_inches.stl -o Examples/stl/moon_lamp_2.5_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3_inches.stl -o Examples/stl/moon_lamp_3_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.5_inches.stl -o Examples/stl/moon_lamp_3.5_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4_inches.stl -o Examples/stl/moon_lamp_4_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5_inches.stl -o Examples/stl/moon_lamp_5_inches.stl

# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6_inches.stl -o Examples/stl/moon_lamp_6_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_7_inches.stl -o Examples/stl/moon_lamp_7_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches.stl -o Examples/stl/moon_lamp_8_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_9_inches.stl -o Examples/stl/moon_lamp_9_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_10_inches.stl -o Examples/stl/moon_lamp_10_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_11_inches.stl -o Examples/stl/moon_lamp_11_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_12_inches.stl -o Examples/stl/moon_lamp_12_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_13_inches.stl -o Examples/stl/moon_lamp_13_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_14_inches.stl -o Examples/stl/moon_lamp_14_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_15_inches.stl -o Examples/stl/moon_lamp_15_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_16_inches.stl -o Examples/stl/moon_lamp_16_inches.stl

#fixed refinement level to cater Thingiverse 262144000 size limit
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_2_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_3_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_4_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_5_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_6_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_7_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_7_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_8_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_9_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_9_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_10_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_10_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_11_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_11_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_12_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_12_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_13_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_13_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_14_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_14_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_15_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_15_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_16_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_16_inches_refinement_level_360.stl

#Moon model for placing on Desktop
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4_inches_refinement_level_360OuterOnly.stl -o Examples/stl/moon_lamp_4_inches_refinement_level_360Y10OuterOnly.stl -s Examples/mlx/MeshLabRotateY10.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_4_inches_refinement_level_360Y10.stl -s Examples/mlx/MeshLabRotateY10.mlx

#Moon Model for hanging
xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.5_inchesOuterOnly.stl -o Examples/stl/moon_lamp_1.5_inchesY170OuterOnly.stl -s Examples/mlx/MeshLabRotateY170.mlx
xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.5_inches.stl -o Examples/stl/moon_lamp_1.5_inchesY170.stl -s Examples/mlx/MeshLabRotateY170.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2_inchesOuterOnly.stl -o Examples/stl/moon_lamp_2_inchesY170OuterOnly.stl -s Examples/mlx/MeshLabRotateY170.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2_inches.stl -o Examples/stl/moon_lamp_2_inchesY170.stl -s Examples/mlx/MeshLabRotateY170.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches_refinement_level_360OuterOnly.stl -o Examples/stl/moon_lamp_8_inches_refinement_level_360Y165OuterOnly.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_8_inches_refinement_level_360Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx

#fixed refinement level to cater Thingiverse 262144000 size limit after xz
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6_inches_refinement_level_600.stl -o Examples/stl/moon_lamp_6_inches_refinement_level_600.stl
