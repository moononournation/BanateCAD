local class = require "pl.class"
require "Shape"

class.Icosahedron(Shape)

-- Every Icosahedron needs:
--	RefinementLevel
--	VertexFunction
function Icosahedron:_init(params)
	params = params or {}		-- create object if user does not provide one

	Shape._init(self, params)

	self.RefinementLevel = params.RefinementLevel or 1
	self.VertexFunction = params.VertexFunction or nil
	self.ColorSampler = params.ColorSampler or nil
	self.Thickness = params.Thickness or nil
	self.ThicknessMap = params.ThicknessMap or nil
	self.BasicThickness = params.BasicThickness or 0
end

function Icosahedron.WriteFace(self, writer, u1, w1, u2, w2, u3, w3)
	local v1, n1 = self.VertexFunction:GetVertex(u1, w1)
	local v2, n2 = self.VertexFunction:GetVertex(u2, w2)
	local v3, n3 = self.VertexFunction:GetVertex(u3, w3)
	writer:WriteFace({v1, v2, v3}, nil)

	if self.Thickness ~= nil then
		local iv1, iv2, iv3
		if self.ThicknessMap ~= nil then
			local t1, t2, t3
			t1 = self.BasicThickness + ((1 - self.ThicknessMap:GetHeight(u1, w1)) * self.Thickness)
			t2 = self.BasicThickness + ((1 - self.ThicknessMap:GetHeight(u2, w2)) * self.Thickness)
			t3 = self.BasicThickness + ((1 - self.ThicknessMap:GetHeight(u3, w3)) * self.Thickness)

			iv1 = vec3_add(vec3_mults(n1, t1), v1)
			iv2 = vec3_add(vec3_mults(n2, t2), v2)
			iv3 = vec3_add(vec3_mults(n3, t3), v3)
		else
			iv1 = vec3_add(vec3_mults(n1, self.Thickness), v1)
			iv2 = vec3_add(vec3_mults(n2, self.Thickness), v2)
			iv3 = vec3_add(vec3_mults(n3, self.Thickness), v3)
		end
		writer:WriteFace({iv1, iv3, iv2}, nil)
	end
end

function Icosahedron.GetStepPoint(self, a, b, steps, step)
	if steps == 0 then
		return a
	else
		if step == steps then
			return b
		else
			return a + ((b - a) / steps * step)
		end
	end
end

function Icosahedron.GetCircularStepPoint(self, ua, ub, steps, step)
	if ua == nil then -- special handle pole point
		if step == 0 then
			return 0
		else
			return ub
		end
	else
		if (ua < 0.25) and (ub > 0.75) then
			ua = ua + 1
		end
		if (ub < 0.25) and (ua > 0.75) then
			ub = ub + 1
		end
		local stepPoint = self:GetStepPoint(ua, ub, steps, step)
		if stepPoint >= 1 then
			stepPoint = stepPoint - 1
		end
		return stepPoint
	end
end

function Icosahedron.RefineFaces(self, writer, ua, wa, ub, wb, uc, wc)
	for i = 1, self.RefinementLevel do
		local uab0, uab1, uac0, uac1, u0, w0, u1, w1, u2, w2, u3, w3
		uab0 = self:GetCircularStepPoint(ua, ub, self.RefinementLevel, i - 1)
		uab1 = self:GetCircularStepPoint(ua, ub, self.RefinementLevel, i)
		uac0 = self:GetCircularStepPoint(ua, uc, self.RefinementLevel, i - 1)
		uac1 = self:GetCircularStepPoint(ua, uc, self.RefinementLevel, i)

		for j = 1, i do
			u1 = self:GetCircularStepPoint(uab0, uac0, i - 1, j - 1)
			w1 = self:GetStepPoint(wa, wb, self.RefinementLevel, i - 1)
			u2 = self:GetCircularStepPoint(uab1, uac1, i, j - 1)
			w2 = self:GetStepPoint(wa, wb, self.RefinementLevel, i)
			u3 = self:GetCircularStepPoint(uab1, uac1, i, j)
			w3 = self:GetStepPoint(wa, wc, self.RefinementLevel, i)
			if j > 1 then
				self:WriteFace(writer, u0, w0, u2, w2, u1, w1)
			end
			self:WriteFace(writer, u1, w1, u2, w2, u3, w3)
			if j < i then
				u0 = u1
				w0 = w1
			end
		end
	end
end

function Icosahedron.WriteFaces(self, writer)
	local steps = 5
	local t = 0.5 - (math.atan(0.5) / math.pi)
	local a = 1 / steps / 2

	for i = 0, steps - 1 do
		local i0 = i * 2
		local i2
		local i1 = i0 + 1
		if i < steps - 1 then
			i2 = (i + 1) * 2
		else
			i2 = 0
		end
		local i3 = i2 + 1
		self:RefineFaces(writer, nil, 0, a * i2, t, a * i0, t)
		self:RefineFaces(writer, a * i1, 1 - t, a * i0, t, a * i2, t)
		self:RefineFaces(writer, a * i2, t, a * i3, 1 - t, a * i1, 1 - t)
		self:RefineFaces(writer, nil, 1, a * i1, 1 - t, a * i3, 1 - t)
	end
end

return Icosahedron
