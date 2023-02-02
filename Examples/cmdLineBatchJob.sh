#!/bin/sh
lua Examples/cmdLineBatchJob.lua

mkdir -p Examples/stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_30mm.stl -o Examples/stl/moon_lamp_30mm.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_40mm.stl -o Examples/stl/moon_lamp_40mm.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_50mm.stl -o Examples/stl/moon_lamp_50mm.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_60mm.stl -o Examples/stl/moon_lamp_60mm.stl

# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.00_inches.stl -o Examples/stl/moon_lamp_1.00_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.25_inches.stl -o Examples/stl/moon_lamp_1.25_inches.stl

# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2.0_inches.stl -o Examples/stl/moon_lamp_2.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2.5_inches.stl -o Examples/stl/moon_lamp_2.5_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.0_inches.stl -o Examples/stl/moon_lamp_3.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.5_inches.stl -o Examples/stl/moon_lamp_3.5_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.0_inches.stl -o Examples/stl/moon_lamp_4.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.5_inches.stl -o Examples/stl/moon_lamp_4.5_inches.stl

# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5.0_inches.stl -o Examples/stl/moon_lamp_5.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6.0_inches.stl -o Examples/stl/moon_lamp_6.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_7.0_inches.stl -o Examples/stl/moon_lamp_7.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8.0_inches.stl -o Examples/stl/moon_lamp_8.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_9.0_inches.stl -o Examples/stl/moon_lamp_9.0_inches.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_10_inches.stl -o Examples/stl/moon_lamp_10_inches.stl

#fixed refinement level to cater Thingiverse 262144000 size limit
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_5_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_6_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_7_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_7_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_8_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_9_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_9_inches_refinement_level_360.stl
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_10_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_10_inches_refinement_level_360.stl

#Moon model for placing on Desktop
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_98mm.stl -o Examples/stl/moon_lamp_98mm_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.0_inches.stl -o Examples/stl/moon_lamp_4_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6.0_inches.stl -o Examples/stl/moon_lamp_6_inches_Y170.stl -s Examples/mlx/MeshLabRotateY170.mlx

#Moon Model for hanging
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.00_inches.stl -o Examples/stl/moon_lamp_1.00_inches_Y170.stl -s Examples/mlx/MeshLabRotateY170.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.25_inches.stl -o Examples/stl/moon_lamp_1.25_inches_Y170.stl -s Examples/mlx/MeshLabRotateY170.mlx
xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_1.33_inches.stl -o Examples/stl/moon_lamp_1.33_inches_Y175.stl -s Examples/mlx/MeshLabRotateY175.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2.5_inches.stl -o Examples/stl/moon_lamp_2.5_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.0_inches.stl -o Examples/stl/moon_lamp_3.0_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.5_inches.stl -o Examples/stl/moon_lamp_3.5_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.0_inches.stl -o Examples/stl/moon_lamp_4.0_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5.0_inches.stl -o Examples/stl/moon_lamp_5.0_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_6_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_6_inches_refinement_level_360_Y170.stl -s Examples/mlx/MeshLabRotateY170.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_8_inches_refinement_level_360.stl -o Examples/stl/moon_lamp_8_inches_refinement_level_360_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx

#FDM 3D printing (high details for low translucent material, 0.4 mm extruder)
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_2.75_inches.stl -o Examples/stl/moon_lamp_2.75_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_3.5_inches.stl -o Examples/stl/moon_lamp_3.5_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.0_inches.stl -o Examples/stl/moon_lamp_4.0_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_4.75_inches.stl -o Examples/stl/moon_lamp_4.75_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx
# xvfb-run -a -s "-screen 0 800x600x24" meshlabserver -i Examples/moon_lamp_5.0_inches.stl -o Examples/stl/moon_lamp_5.0_inches_Y165.stl -s Examples/mlx/MeshLabRotateY165.mlx

rm Examples/*.stl
