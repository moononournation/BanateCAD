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

function GenerateMoon(outputSize, refinementLevel, outputName, genOuterSTL)
	local extrudeSize = 0.4
	-- local heightFactor = 0.4 -- bump map height factor
	local heightFactor = 0.9 -- double value for moonBumpAddInvertedColorMap
	local shadowFactor = 5 -- larger is darker
	local h = outputSize * heightFactor
	local r = ((outputSize * 25.4) / 2) - (h / 2)
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

GenerateMoon(2, 144, 'moonLamp2inches', true)
-- GenerateMoon(2.5, 180, 'moonLamp2.5inches', true)
GenerateMoon(3, 216, 'moonLamp3inches', false)
GenerateMoon(4, 288, 'moonLamp4inches', false)
GenerateMoon(5, 360, 'moonLamp5inches', true)
GenerateMoon(6, 432, 'moonLamp6inches', false)
