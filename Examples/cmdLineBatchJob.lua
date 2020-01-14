-- settings
local extrudeSize = 0.4 -- mm
local minWallFactor = 1.5 -- ratio, extrudeSize multiplier, a little bit thicker than extrudeSize to avoid holes
local shadowSize = 2.4 -- mm, larger is thicker and darker
local constantHeightSize = 0.63 -- mm, basic surface height
local variableHeightFactor = 0.013 -- ratio, surface height factor growth with output size

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

local inchesToMmConstant = 25.4

function GenerateMoon(outputSize, refinementLevel, outputName, alsoGenOuterSTL)
	local h = constantHeightSize + (outputSize * inchesToMmConstant * variableHeightFactor)
	local r = ((outputSize * inchesToMmConstant) / 2) - h

	local heightmap = ImageSampler({
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.3.6k.png',
		Filename = 'Examples/map/moonBumpAddInvertedColorMap.6k.png',
		Interpolate = true,
	})
	-- smoothen surface
	heightmap.Blur = math.max(math.ceil(((heightmap.Width / 10 /refinementLevel) - 1) / 2), 0)

	local thicknessMap = ImageSampler({
		-- Filename = 'Examples/map/moonColorMap.3.6k.png',
		Filename = 'Examples/map/moonColorMap.6k.png',
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
		BasicThickness = -extrudeSize,
		MinThickness = -(extrudeSize * minWallFactor),
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
			VertexFunction = dispSampler,
		})

		local f = io.open('Examples/' .. outputName .. 'OuterOnly.stl', 'w+')
		local writer = STLASCIIWriter({file = f})
		writer:WriteBiParametric(lshape, outputName)
		f:close()

		collectgarbage()
	end
end

GenerateMoon(2.0, 240, 'moon_lamp_2_inches', true)
-- GenerateMoon(2.5, 300, 'moon_lamp_2.5_inches', false)
-- GenerateMoon(3.0, 360, 'moon_lamp_3_inches', false)
-- GenerateMoon(3.5, 420, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0, 480, 'moon_lamp_4_inches', false)
-- GenerateMoon(5.0, 600, 'moon_lamp_5_inches', false)

-- GenerateMoon(6.0, 720, 'moon_lamp_6_inches', false)
-- GenerateMoon(7.0, 840, 'moon_lamp_7_inches', false)
-- GenerateMoon(8.0, 960, 'moon_lamp_8_inches', false)
-- GenerateMoon(9.0, 1080, 'moon_lamp_9_inches', false)
-- GenerateMoon(10.0, 1200, 'moon_lamp_10_inches', false)
-- GenerateMoon(11.0, 1320, 'moon_lamp_11_inches', false)
-- GenerateMoon(12.0, 1440, 'moon_lamp_12_inches', false)
-- GenerateMoon(13.0, 1560, 'moon_lamp_13_inches', false)
-- GenerateMoon(14.0, 1680, 'moon_lamp_14_inches', false)
-- GenerateMoon(15.0, 1800, 'moon_lamp_15_inches', false)
-- GenerateMoon(16.0, 1920, 'moon_lamp_16_inches', false)

-- fixed refinement level to cater Thingiverse 262144000 size limit
-- GenerateMoon(4.0, 360, 'moon_lamp_4_inches_refinement_level_360', true)
-- GenerateMoon(5.0, 360, 'moon_lamp_5_inches_refinement_level_360', false)
-- GenerateMoon(6.0, 360, 'moon_lamp_6_inches_refinement_level_360', false)
-- GenerateMoon(7.0, 360, 'moon_lamp_7_inches_refinement_level_360', false)
-- GenerateMoon(8.0, 360, 'moon_lamp_8_inches_refinement_level_360', true)
-- GenerateMoon(9.0, 360, 'moon_lamp_9_inches_refinement_level_360', false)
-- GenerateMoon(10, 360, 'moon_lamp_10_inches_refinement_level_360', false)
-- GenerateMoon(11, 360, 'moon_lamp_11_inches_refinement_level_360', false)
-- GenerateMoon(12, 360, 'moon_lamp_12_inches_refinement_level_360', false)
-- GenerateMoon(13, 360, 'moon_lamp_13_inches_refinement_level_360', false)
-- GenerateMoon(14, 360, 'moon_lamp_14_inches_refinement_level_360', false)
-- GenerateMoon(15, 360, 'moon_lamp_15_inches_refinement_level_360', false)
-- GenerateMoon(16, 360, 'moon_lamp_16_inches_refinement_level_360', false)

-- fixed refinement level to cater Thingiverse 262144000 size limit after xz
-- GenerateMoon(6, 600, 'moon_lamp_6_inches_refinement_level_600', false)
