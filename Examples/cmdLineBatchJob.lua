-- settings
local variableHeightFactor = 0.006 -- ratio, surface height factor growth with output size
local variableShadowFactor = 0.011 -- ratio, wall thickness factor growth with output size

require "BAppContext"
local appctx = BAppContext({
	Modules={
		"physics",
		"animation",
		"codec",		-- Coder/Decoder for files
		"BanateCAD",	-- For BanateCAD specifics
		"UI",
		"Solids",
		"core",			-- Guts of the system
		}
	})
require "ImageSampler"
require "DisplacementSampler"
require "Vector"
require "STLCodec"
require "Icosahedron"
require "shape_ellipsoid"

function GenerateMoon(outputSize, refinementLevel, basicWallSize, basicShadowSize, basicHeightSize, outputName, alsoGenOuterSTL)
	local h = basicHeightSize + (outputSize * variableHeightFactor)
	local r = (outputSize / 2) - h

	local heightmap = ImageSampler({
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.8k.png',
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.4.8k.png',
		-- Filename = 'Examples/map/moonBump5AddInvertedColorMap2.4.8k.png',
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.3.84k.png',
		Filename = 'Examples/map/moonBumpAddInvertedColorMap.3.6k.png',
		Interpolate = true,
	})
	-- smoothen surface
	heightmap.Blur = math.max(math.ceil(((heightmap.Width / 10 /refinementLevel) - 1) / 2), 0)

	local thicknessMap = ImageSampler({
		-- Filename = 'Examples/map/moonColorMap.8k.png',
		-- Filename = 'Examples/map/moonColorMap.4.8k.png',
		-- Filename = 'Examples/map/moonColorMap.3.84k.png',
		Filename = 'Examples/map/moonColorMap.3.6k.png',
		Interpolate = true,
	})
	-- smoothen interior shape
	thicknessMap.Blur = math.max(math.ceil(((thicknessMap.Width / 10 / refinementLevel) - 1) / 2), 0)

	local vertsampler = shape_ellipsoid({
		XRadius = r,
		ZRadius = r,
		MaxTheta = math.rad(360),
		MaxPhi = math.rad(180),
	})

	local dispSampler = DisplacementSampler({
		VertexSampler = vertsampler,
		HeightSampler = heightmap,
		MaxHeight = h,
	})

	local lshape =  Icosahedron({
		RefinementLevel = refinementLevel,
	-- local lshape =  BiParametric({
	-- 	USteps = refinementLevel * 10,
	-- 	WSteps = refinementLevel * 5,
		VertexFunction = dispSampler,
		Thickness = -(basicShadowSize + (outputSize * variableShadowFactor)),
		ThicknessMap = thicknessMap,
		BasicThickness = -basicWallSize,
	})

	--direct output to STL
	local f = io.open('Examples/' .. outputName .. '.stl', 'w+')
	local writer = STLASCIIWriter({file = f})
	writer:WriteBiParametric(lshape, outputName)
	f:close()

	collectgarbage()

	if alsoGenOuterSTL then
		-- generate the outer surface only object for post edit purpose
		local lshape =  Icosahedron({
			RefinementLevel = refinementLevel,
			-- local lshape =  BiParametric({
			-- 	USteps = refinementLevel * 10,
			-- 	WSteps = refinementLevel * 5,
			VertexFunction = dispSampler,
		})

		local f = io.open('Examples/' .. outputName .. 'OuterOnly.stl', 'w+')
		local writer = STLASCIIWriter({file = f})
		writer:WriteBiParametric(lshape, outputName)
		f:close()

		collectgarbage()
	end
end

--[[
outputSize:      in mm, output model diameter
refinementLevel: number of subdivision for each edge of Icosahedron
basicWallSize:   in mm, add a little bit on extrude size
basicShadowSize: in mm, larger is thicker and darker
basicHeightSize: in mm, basic surface height size
outputName:      output filename
alsoGenOuterSTL: also generate a solid object only have surface detail for post-edit reason
--]]
local inchesToMmConstant = 25.4

-- Resin 3D printing
-- GenerateMoon(30, 180, 0.1, 2.0, 1.2, 'moon_lamp_30mm', false)
-- GenerateMoon(40, 240, 0.1, 2.0, 1.2, 'moon_lamp_40mm', false)
-- GenerateMoon(50, 300, 0.1, 2.0, 1.2, 'moon_lamp_50mm', false)
-- GenerateMoon(60, 360, 0.1, 2.0, 1.2, 'moon_lamp_60mm', false)

-- FDM 3D printing (high details for low translucent material, 0.25 mm extruder)
-- GenerateMoon(1.00 * inchesToMmConstant, 240, 0.3, 0.2, 0.5, 'moon_lamp_1.00_inches', false)
-- GenerateMoon(1.25 * inchesToMmConstant, 240, 0.3, 0.2, 0.5, 'moon_lamp_1.25_inches', false)

-- FDM 3D printing (high details, 0.25 mm extruder)
GenerateMoon(1.33 * inchesToMmConstant, 240, 0.26, 0.64, 0.64, 'moon_lamp_1.33_inches', false)

-- FDM 3D printing (high details, 0.3 mm extruder)
-- GenerateMoon(1.00 * inchesToMmConstant, 384, 0.3, 0.8, 0.8, 'moon_lamp_1.00_inches', false)
-- GenerateMoon(1.25 * inchesToMmConstant, 480, 0.3, 0.8, 0.8, 'moon_lamp_1.25_inches', false)
-- GenerateMoon(98, 480, 0.3, 0.8, 0.8, 'moon_lamp_98mm', false)

-- FDM 3D printing (high details, 0.4 mm extruder)
-- GenerateMoon(1.25 * inchesToMmConstant, 200, 0.5, 0.8, 0.8, 'moon_lamp_1.25_inches', false)
-- GenerateMoon(2.5 * inchesToMmConstant, 360, 0.4, 0.3, 0.8, 'moon_lamp_2.5_inches', false)
-- GenerateMoon(3.0 * inchesToMmConstant, 360, 0.4, 0.4, 0.8, 'moon_lamp_3.0_inches', false)
-- GenerateMoon(3.5 * inchesToMmConstant, 360, 0.4, 0.4, 0.8, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_4.0_inches', false)
-- GenerateMoon(5.0 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_5.0_inches', false)

-- FDM 3D printing (high details for low translucent material, 0.4 mm extruder)
-- GenerateMoon(2.75 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_2.75_inches', false)
-- GenerateMoon(2.75 * inchesToMmConstant, 480, 0.41, 0.19, 0.8, 'moon_lamp_2.75_inches', false)
-- GenerateMoon(3.5 * inchesToMmConstant, 480, 0.41, 0.19, 0.8, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_4.0_inches', false)
-- GenerateMoon(4.75 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_4.75_inches', false)
-- GenerateMoon(5.0 * inchesToMmConstant, 360, 0.41, 0.19, 0.8, 'moon_lamp_5.0_inches', false)

-- FDM 3D printing
-- GenerateMoon(2.0 * inchesToMmConstant, 160, 0.5, 0.8, 0.8, 'moon_lamp_2.0_inches', false)
-- GenerateMoon(2.5 * inchesToMmConstant, 200, 0.5, 0.8, 0.8, 'moon_lamp_2.5_inches', false)
-- GenerateMoon(3.0 * inchesToMmConstant, 240, 0.5, 0.8, 0.8, 'moon_lamp_3.0_inches', false)
-- GenerateMoon(3.5 * inchesToMmConstant, 280, 0.5, 0.8, 0.8, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0 * inchesToMmConstant, 320, 0.5, 0.8, 0.8, 'moon_lamp_4.0_inches', false)
-- GenerateMoon(4.5 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_4.5_inches', false)

-- require 8k map files
-- GenerateMoon(5.0 * inchesToMmConstant, 400, 0.5, 0.8, 0.8, 'moon_lamp_5.0_inches', false)
-- GenerateMoon(6.0 * inchesToMmConstant, 480, 0.5, 0.8, 0.8, 'moon_lamp_6.0_inches', false)
-- GenerateMoon(7.0 * inchesToMmConstant, 560, 0.5, 0.8, 0.8, 'moon_lamp_7.0_inches', false)
-- GenerateMoon(8.0 * inchesToMmConstant, 640, 0.5, 0.8, 0.8, 'moon_lamp_8.0_inches', false)
-- GenerateMoon(9.0 * inchesToMmConstant, 720, 0.5, 0.8, 0.8, 'moon_lamp_9.0_inches', false)
-- GenerateMoon(10 * inchesToMmConstant,  800, 0.5, 0.8, 0.8, 'moon_lamp_10_inches', false)

-- fixed refinement level to cater Thingiverse 262144000 size limit
-- GenerateMoon(5 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_5_inches_refinement_level_360', false)
-- GenerateMoon(6 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_6_inches_refinement_level_360', false)
-- GenerateMoon(7 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_7_inches_refinement_level_360', false)
-- GenerateMoon(8 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_8_inches_refinement_level_360', false)
-- GenerateMoon(9 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_9_inches_refinement_level_360', false)
-- GenerateMoon(10 * inchesToMmConstant, 360, 0.5, 0.8, 0.8, 'moon_lamp_10_inches_refinement_level_360', false)
