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

function GenerateMoon(outputSize, refinementLevel, outputName, genOuterSTL)
	local extrudeSize = 0.4
	local heightFactor = 0.025 -- suface detail height
	local basicHeight = 0.050 -- inches
	local shadowFactor = 6 -- larger is darker
	local h = (basicHeight + (outputSize * heightFactor)) * inchesToMmConstant
	local r = ((outputSize * inchesToMmConstant) / 2) - h
	local t = extrudeSize * shadowFactor --color map thickness
	
	local heightmap = ImageSampler({
		-- Filename = 'Examples/map/moonBumpMap.png',
		Filename = 'Examples/map/moonBumpAddInvertedColorMap.png',
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap5to3.png',
		-- Filename = 'Examples/map/moonBumpAddInvertedColorMap.23k.png',
		Interpolate = true,
		Blur = 1, -- smoothen surface
	})

	local thicknessMap = ImageSampler({
		Filename = 'Examples/map/moonColorMap.png',
		-- Filename = 'Examples/map/moonColorMap.23k.png',
		Interpolate = true,
		Blur = 1, -- smoothen interior shape
	})

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
		BasicThickness = -(extrudeSize + 0.1), -- a little bit thicker
	})

	--direct output to STL
	local f = io.open('Examples/' .. outputName .. '.stl', 'w+')
	local writer = STLASCIIWriter({file = f})
	writer:WriteBiParametric(lshape, outputName)
	f:close()

	collectgarbage()

	if genOuterSTL then
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

GenerateMoon(1.0, 96, 'moon_lamp_1_inch', false)
GenerateMoon(1.5, 144, 'moon_lamp_1.5_inches', true)
GenerateMoon(2.0, 192, 'moon_lamp_2_inches', false)
GenerateMoon(2.5, 240, 'moon_lamp_2.5_inches', false)
GenerateMoon(3.0, 288, 'moon_lamp_3_inches', false)
GenerateMoon(3.5, 336, 'moon_lamp_3.5_inches', false)
GenerateMoon(4.0, 384, 'moon_lamp_4_inches', false)
GenerateMoon(5.0, 480, 'moon_lamp_5_inches', false)
GenerateMoon(6.0, 576, 'moon_lamp_6_inches', false)
GenerateMoon(7.0, 672, 'moon_lamp_7_inches', false)
GenerateMoon(8.0, 768, 'moon_lamp_8_inches', false)
