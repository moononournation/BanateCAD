local outputSize = 3 -- inches
local extrudeSize = 0.4

local heightFactor = 0.3 -- bump map height factor
local shadowFactor = 0.8 -- larger is darker
local h = outputSize * heightFactor
local r = ((outputSize * 25.4) / 2) - (h /2)
local t = outputSize * shadowFactor --color map thickness

local heightmap = ImageSampler({
	Filename = 'map/moonBumpMap.3.6k.png',
})

local thicknessMap = ImageSampler({
	Filename = 'map/moonColorMap.3.6k.png',
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

local lshape =  BiParametric({
	USteps = 720,
	WSteps = 360,
    VertexFunction = dispSampler,
	Thickness = -t,
	ThicknessMap = thicknessMap,
	BasicThickness = -(extrudeSize + 0.1), -- a little bit thicker
	})

addshape(lshape)