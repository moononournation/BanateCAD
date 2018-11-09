cd ..
lua Examples\cmdLineBatchJob.lua
cd Examples

@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inches.stl -o stl\moonLamp2inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp3inches.stl -o stl\moonLamp3inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp4inches.stl -o stl\moonLamp4inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inches.stl -o stl\moonLamp5inches.stl
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp6inches.stl -o stl\moonLamp6inches.stl

@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inches.stl -o stl\moonLamp2inchesY30.stl -s mlx\MeshLabRotateY30.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inchesOuterOnly.stl -o stl\moonLamp2inchesY30OuterOnly.stl -s mlx\MeshLabRotateY30.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inches.stl -o stl\moonLamp2inchesY175.stl -s mlx\MeshLabRotateY75.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp2inchesOuterOnly.stl -o stl\moonLamp2inchesY175OuterOnly.stl -s mlx\MeshLabRotateY175.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inches.stl -o stl\moonLamp5inchesY30.stl -s mlx\MeshLabRotateY30.mlx
@rem "C:\Program Files\VCG\MeshLab\meshlabserver" -i moonLamp5inchesOuterOnly.stl -o stl\moonLamp5inchesY30OuterOnly.stl -s mlx\MeshLabRotateY30.mlx

pause
