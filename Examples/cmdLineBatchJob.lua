-- settings
local variableHeightFactor = 0.011 -- ratio, surface height factor growth with output size

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

function GenerateMoon(outputSize, refinementLevel, basicWallSize, shadowSize, basicHeightSize, outputName, alsoGenOuterSTL)
	local h = basicHeightSize + (outputSize * variableHeightFactor)
	local r = (outputSize / 2) - basicHeightSize

	local heightmap = ImageSampler({
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.21.6k.png',
		Filename = 'Examples/map/moonBumpAddInvertedColorMap.3.6k.png',
		Interpolate = true,
	})
	-- smoothen surface
	heightmap.Blur = math.max(math.ceil(((heightmap.Width / 10 /refinementLevel) - 1) / 2), 0)

	local thicknessMap = ImageSampler({
		-- Filename = 'Examples/map/moonColorMap.21.6k.png',
		Filename = 'Examples/map/moonColorMap.3.6k.png',
		Interpolate = true,
	})
	-- smoothen interior shape
	thicknessMap.Blur = math.max(math.ceil(((thicknessMap.Width / 10 /refinementLevel) - 1) / 2), 0)

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
		Thickness = -shadowSize,
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
shadowSize:      in mm, larger is thicker and darker
basicHeightSize: in mm, basic surface height size
outputName:      output filename
alsoGenOuterSTL: also generate a solid object only have surface detail for post-edit reason
--]]
local inchesToMmConstant = 25.4

-- Resin 3D printing
GenerateMoon(1.00 * inchesToMmConstant, 180, 0.1, 1.6, 0.9, 'moon_lamp_1.00_inches', false)
GenerateMoon(1.25 * inchesToMmConstant, 180, 0.1, 1.6, 0.9, 'moon_lamp_1.25_inches', false)
GenerateMoon(1.50 * inchesToMmConstant, 180, 0.1, 1.6, 0.9, 'moon_lamp_1.50_inches', false)
GenerateMoon(1.75 * inchesToMmConstant, 180, 0.1, 1.6, 0.9, 'moon_lamp_1.75_inches', false)
GenerateMoon(2.00 * inchesToMmConstant, 180, 0.1, 1.6, 0.9, 'moon_lamp_2.00_inches', false)

-- FDM 3D printing
-- GenerateMoon(2.0 * inchesToMmConstant, 180, 0.6, 2.4, 0.7, 'moon_lamp_2.0_inches', false)
-- GenerateMoon(2.5 * inchesToMmConstant, 225, 0.6, 2.4, 0.7, 'moon_lamp_2.5_inches', false)
-- GenerateMoon(3.0 * inchesToMmConstant, 270, 0.6, 2.4, 0.7, 'moon_lamp_3.0_inches', false)
-- GenerateMoon(3.5 * inchesToMmConstant, 315, 0.6, 2.4, 0.7, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_4.0_inches', false)
-- GenerateMoon(5.0 * inchesToMmConstant, 450, 0.6, 2.4, 0.7, 'moon_lamp_5.0_inches', false)
-- GenerateMoon(6.0 * inchesToMmConstant, 540, 0.6, 2.4, 0.7, 'moon_lamp_6.0_inches', false)
-- GenerateMoon(7.0 * inchesToMmConstant, 630, 0.6, 2.4, 0.7, 'moon_lamp_7.0_inches', false)
-- GenerateMoon(8.0 * inchesToMmConstant, 720, 0.6, 2.4, 0.7, 'moon_lamp_8.0_inches', false)
-- GenerateMoon(9.0 * inchesToMmConstant, 810, 0.6, 2.4, 0.7, 'moon_lamp_9.0_inches', false)
-- GenerateMoon(10 * inchesToMmConstant,  900, 0.6, 2.4, 0.7, 'moon_lamp_10_inches', false)
-- GenerateMoon(11 * inchesToMmConstant,  990, 0.6, 2.4, 0.7, 'moon_lamp_11_inches', false)
-- GenerateMoon(12 * inchesToMmConstant, 1080, 0.6, 2.4, 0.7, 'moon_lamp_12_inches', false)
-- GenerateMoon(13 * inchesToMmConstant, 1170, 0.6, 2.4, 0.7, 'moon_lamp_13_inches', false)
-- GenerateMoon(14 * inchesToMmConstant, 1260, 0.6, 2.4, 0.7, 'moon_lamp_14_inches', false)
-- GenerateMoon(15 * inchesToMmConstant, 1350, 0.6, 2.4, 0.7, 'moon_lamp_15_inches', false)
-- GenerateMoon(16 * inchesToMmConstant, 1440, 0.6, 2.4, 0.7, 'moon_lamp_16_inches', false)
-- GenerateMoon(17 * inchesToMmConstant, 1530, 0.6, 2.4, 0.7, 'moon_lamp_17_inches', false)
-- GenerateMoon(18 * inchesToMmConstant, 1620, 0.6, 2.4, 0.7, 'moon_lamp_18_inches', false)
-- GenerateMoon(19 * inchesToMmConstant, 1710, 0.6, 2.4, 0.7, 'moon_lamp_19_inches', false)
-- GenerateMoon(20 * inchesToMmConstant, 1800, 0.6, 2.4, 0.7, 'moon_lamp_20_inches', false)
-- GenerateMoon(21 * inchesToMmConstant, 1890, 0.6, 2.4, 0.7, 'moon_lamp_21_inches', false)
-- GenerateMoon(22 * inchesToMmConstant, 1980, 0.6, 2.4, 0.7, 'moon_lamp_22_inches', false)
-- GenerateMoon(23 * inchesToMmConstant, 2070, 0.6, 2.4, 0.7, 'moon_lamp_23_inches', false)
-- GenerateMoon(24 * inchesToMmConstant, 2160, 0.6, 2.4, 0.7, 'moon_lamp_24_inches', false)

-- fixed refinement level to cater Thingiverse 262144000 size limit
-- GenerateMoon(5.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_5_inches_refinement_level_360', false)
-- GenerateMoon(6.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_6_inches_refinement_level_360', false)
-- GenerateMoon(7.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_7_inches_refinement_level_360', false)
-- GenerateMoon(8.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_8_inches_refinement_level_360', false)
-- GenerateMoon(9.0 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_9_inches_refinement_level_360', false)
-- GenerateMoon(10 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_10_inches_refinement_level_360', false)
-- GenerateMoon(11 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_11_inches_refinement_level_360', false)
-- GenerateMoon(12 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_12_inches_refinement_level_360', false)
-- GenerateMoon(13 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_13_inches_refinement_level_360', false)
-- GenerateMoon(14 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_14_inches_refinement_level_360', false)
-- GenerateMoon(15 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_15_inches_refinement_level_360', false)
-- GenerateMoon(16 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_16_inches_refinement_level_360', false)
-- GenerateMoon(17 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_17_inches_refinement_level_360', false)
-- GenerateMoon(18 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_18_inches_refinement_level_360', false)
-- GenerateMoon(19 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_19_inches_refinement_level_360', false)
-- GenerateMoon(20 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_20_inches_refinement_level_360', false)
-- GenerateMoon(21 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_21_inches_refinement_level_360', false)
-- GenerateMoon(22 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_22_inches_refinement_level_360', false)
-- GenerateMoon(23 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_23_inches_refinement_level_360', false)
-- GenerateMoon(24 * inchesToMmConstant, 360, 0.6, 2.4, 0.7, 'moon_lamp_24_inches_refinement_level_360', false)
