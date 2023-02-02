local gd = require("gd")

local class = require "pl.class"

class.ImageSampler();

function ImageSampler:_init(params)
	params = params or {}

	self.Image = params.Image or nil
	self.Interpolate = params.Interpolate or false
	self.Blur = params.Blur or nil
	self.Invert = params.Invert or nill

	if params.Image == nil then
		self.Filename = params.Filename or nil

		-- Need to load the image data
		-- Assume a .png file for now
		self.Image = gd.createFromPng(self.Filename)
		assert(self.Image, "Failed to load image: " .. self.Filename)
	end

	self.Width, self.Height = self.Image:sizeXY()
end

function loopValue(v, range)
	if v < 0 then
		return v + range
	elseif v > range then
		return v - range
	else
		return v
	end
end

function interpolate(v1, v2, dp)
	if dp == 0 then
		return v1
	else
		return (v1 * (1 - dp)) + (v2 * (dp))
	end
end

function luminance(rgb)
	local lum = vec3_dot({0.2125, 0.7154, 0.0721}, rgb);
		return lum;
end

function ImageSampler.GetLuminance(self, x, y)
	local pixel = self.Image:getPixel(x,y)
	local r = self.Image:red(pixel)
	local g = self.Image:green(pixel)
	local b = self.Image:blue(pixel)

	-- Turn it to a grayscale value
	if self.Invert ~= nil then
		return 1 - luminance({r/255,g/255,b/255,1});
	else
		return luminance({r/255,g/255,b/255,1});
	end
end

function ImageSampler.GetPixelHeight(self, x, y)
	if self.Blur ~= nil then
		local h = 0
		local i = 0
		for dx = x - self.Blur, x + self.Blur do
			for dy = y - self.Blur, y - self.Blur do
				h = h + self:GetLuminance(loopValue(dx, self.Width - 1), loopValue(dy, self.Height - 1))
				i = i + 1
			end
		end
		return h / i
	else
		return self:GetLuminance(x, y)
	end
end

function ImageSampler.GetHeight(self, u, w)
	-- calculate pixel coordinates
	local xf = u * self.Width
	local yf = (1 - w) * self.Height -- flipped
	if yf == self.Height then
		yf = 0 -- loop back 1 to 0
	end

	local x = math.floor(xf)
	local y = math.floor(yf)
	local xdp = xf - x
	local ydp = yf - y

	local x1 = loopValue(x + 1, self.Width - 1)
	local y1 = loopValue(y + 1, self.Height - 1)

	if self.Interpolate then
		-- print(u,x,interpolate(x,x1,xdp),w,y,interpolate(y,y1,ydp))
		return interpolate(
						interpolate(
							self:GetPixelHeight(x,y),
							self:GetPixelHeight(x1,y),
							xdp
						),
						interpolate(
							self:GetPixelHeight(x,y1),
							self:GetPixelHeight(x1,y1),
							xdp
						),
						ydp
					)
	else
		return self:GetPixelHeight(x,y)
	end
end
