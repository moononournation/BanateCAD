-- settings
local extrudeSize = 0.4 -- mm
local constantHeightSize = 0.050 -- basic height in inches
local variableHeightFactor = 0.025 -- height factor growth with output size
local shadowFactor = 6 -- larger is thicker and darker

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
	local h = (constantHeightSize + (outputSize * variableHeightFactor)) * inchesToMmConstant
	local r = ((outputSize * inchesToMmConstant) / 2) - h
	local t = extrudeSize * shadowFactor --color map thickness

	local heightmap = ImageSampler({
		Filename = 'Examples/map/moonBumpAddInvertedColorMap.3.6k.png',
		Interpolate = true,
	})
	-- smoothen surface
	heightmap.Blur = math.max(math.ceil(((heightmap.Width / 10 /refinementLevel) - 1) / 2), 0)

	local thicknessMap = ImageSampler({
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
		Thickness = -t,
		ThicknessMap = thicknessMap,
		BasicThickness = -(extrudeSize * 1.5), -- a little bit thicker
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

-- GenerateMoon(1.0, 96, 'moon_lamp_1_inch', false)
-- GenerateMoon(1.25, 120, 'moon_lamp_1.25_inches', false)
-- GenerateMoon(1.5, 144, 'moon_lamp_1.5_inches', false)
-- GenerateMoon(1.75, 168, 'moon_lamp_1.75_inches', false)
GenerateMoon(2.0, 192, 'moon_lamp_2_inches', true)
-- GenerateMoon(2.5, 240, 'moon_lamp_2.5_inches', false)
-- GenerateMoon(3.0, 288, 'moon_lamp_3_inches', false)
-- GenerateMoon(3.5, 336, 'moon_lamp_3.5_inches', false)
-- GenerateMoon(4.0, 384, 'moon_lamp_4_inches', true)
-- GenerateMoon(5.0, 480, 'moon_lamp_5_inches', true)
-- GenerateMoon(6.0, 576, 'moon_lamp_6_inches', false)

-- GenerateMoon(7.0, 672, 'moon_lamp_7_inches', false)
-- GenerateMoon(8.0, 768, 'moon_lamp_8_inches', false)
-- GenerateMoon(9.0, 864, 'moon_lamp_9_inches', false)
-- GenerateMoon(10.0, 960, 'moon_lamp_10_inches', false)
-- GenerateMoon(11.0, 1056, 'moon_lamp_11_inches', false)
-- GenerateMoon(12.0, 1152, 'moon_lamp_12_inches', false)
-- GenerateMoon(13.0, 1248, 'moon_lamp_13_inches', false)
-- GenerateMoon(14.0, 1344, 'moon_lamp_14_inches', false)
-- GenerateMoon(15.0, 1440, 'moon_lamp_15_inches', false)
-- GenerateMoon(16.0, 1536, 'moon_lamp_16_inches', false)
-- GenerateMoon(17.0, 1632, 'moon_lamp_17_inches', false)
-- GenerateMoon(18.0, 1728, 'moon_lamp_18_inches', false)
-- GenerateMoon(19.0, 1824, 'moon_lamp_19_inches', false)
-- GenerateMoon(20.0, 1920, 'moon_lamp_20_inches', false)
-- GenerateMoon(21.0, 2016, 'moon_lamp_21_inches', false)
-- GenerateMoon(22.0, 2112, 'moon_lamp_22_inches', false)
-- GenerateMoon(23.0, 2208, 'moon_lamp_23_inches', false)
-- GenerateMoon(24.0, 2304, 'moon_lamp_24_inches', false)

-- fixed refinement level to cater Thingiverse 262144000 size limit
-- GenerateMoon(2.0, 360, 'moon_lamp_2_inches_refinement_level_360', true)
-- GenerateMoon(4.0, 360, 'moon_lamp_4_inches_refinement_level_360', true)
-- GenerateMoon(5.0, 360, 'moon_lamp_5_inches_refinement_level_360', false)
-- GenerateMoon(6.0, 360, 'moon_lamp_6_inches_refinement_level_360', false)
-- GenerateMoon(7.0, 360, 'moon_lamp_7_inches_refinement_level_360', false)
-- GenerateMoon(8.0, 360, 'moon_lamp_8_inches_refinement_level_360', false)

-- GenerateMoon(9.0, 360, 'moon_lamp_9_inches_refinement_level_360', false)
-- GenerateMoon(10, 360, 'moon_lamp_10_inches_refinement_level_360', false)
-- GenerateMoon(11, 360, 'moon_lamp_11_inches_refinement_level_360', false)
-- GenerateMoon(12, 360, 'moon_lamp_12_inches_refinement_level_360', false)
-- GenerateMoon(13, 360, 'moon_lamp_13_inches_refinement_level_360', false)
-- GenerateMoon(14, 360, 'moon_lamp_14_inches_refinement_level_360', false)
-- GenerateMoon(15, 360, 'moon_lamp_15_inches_refinement_level_360', false)
-- GenerateMoon(16, 360, 'moon_lamp_16_inches_refinement_level_360', false)
-- GenerateMoon(17, 360, 'moon_lamp_17_inches_refinement_level_360', false)
-- GenerateMoon(18, 360, 'moon_lamp_18_inches_refinement_level_360', false)
-- GenerateMoon(19, 360, 'moon_lamp_19_inches_refinement_level_360', false)
-- GenerateMoon(20, 360, 'moon_lamp_20_inches_refinement_level_360', false)
-- GenerateMoon(21, 360, 'moon_lamp_21_inches_refinement_level_360', false)
-- GenerateMoon(22, 360, 'moon_lamp_22_inches_refinement_level_360', false)
-- GenerateMoon(23, 360, 'moon_lamp_23_inches_refinement_level_360', false)
-- GenerateMoon(24, 360, 'moon_lamp_24_inches_refinement_level_360', false)
