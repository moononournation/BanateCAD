--
-- STLCodec.lua
--
-- Copyright (c) 2011  William Adams
--
-- STL Coder and Decoder
--

require ("test_lpeg")
local class = require "pl.class"

--
-- Construct like this
--	filehandle = io.open(filename, "w+")
--    writer = STLASCIIWriter:new({file = filehandle})
--    writer.WriteMesh(trimesh, solidname)
class.STLASCIIWriter()

function STLASCIIWriter:_init(params)
	params = params or {}		-- create object if user does not provide one

	self.file = params.file
end



function STLASCIIWriter.WriteMesh(self, mesh, solidname)
	self.file:write(string.format('solid %s\n',solidname))

	for i=1,#mesh.faces  do
		local face = mesh.faces[i]
		local tri = {mesh.vertices[face[1]], mesh.vertices[face[2]], mesh.vertices[face[3]]}

		self:WriteFace(tri, face.normal)
	end

	self.file:write(string.format("endsolid %s\n", solidname))
end

function STLASCIIWriter.WriteFace(self, facet, normal)
	-- header
	if normal ~= nil then
		self.file:write("facet normal ")
		self.file:write(normal[1])
		self.file:write(" ")
		self.file:write(normal[2])
		self.file:write(" ")
		self.file:write(normal[3])
		self.file:write("\n")
	else
		self.file:write('facet normal 0 0 0\n')
	end
	self.file:write('outer loop\n')

	-- print vertices
	self:WriteSTLVertex(facet[1])
	self:WriteSTLVertex(facet[2])
	self:WriteSTLVertex(facet[3])

	-- footer
	self.file:write('endloop\n')
	self.file:write('endfacet\n')
end

function STLASCIIWriter.WriteSTLVertex(self, v)
	self.file:write("vertex ")
	self.file:write(v[1])
	self.file:write(" ")
	self.file:write(v[2])
	self.file:write(" ")
	self.file:write(v[3])
	self.file:write("\n")
end

function STLASCIIWriter.WriteBiParametric(self, shape, solidname)
	self.file:write(string.format('solid %s\n',solidname))
	-- hand over to shape internal function handle the write loop
	-- it can avoid generation a huge mesh object and substantially reduce
	-- the memory consumption
	shape:WriteFaces(self)
	self.file:write(string.format("endsolid %s\n", solidname))
end






-- Construct like this
--	filehandle = io.open(filename, "r")
--    reader = STLASCIIReader:new({file = filehandle})
--    trimesh = reader.Read()
class.STLASCIIReader()
function STLASCIIReader:_init(params)
	params = params or {}		-- create object if user does not provide one

	self.file = params.file
end


function STLASCIIReader.Read(self)

local amesh = parsestl(self.file)

	--[[
	-- Process the text one line at a time
	-- Read all the text into a string
	local t = self.file:read("*all")
	for line in t:gmatch("[^\r\n]+") do
		io.write(line)
	end
--]]
	return amesh
end

function import_stl_mesh(filename)
	local filehandle = io.open(filename, 'r')

	local reader = STLASCIIReader({file = filehandle})
	local tmesh = reader:Read()

	-- close the file
	filehandle:close()

	return tmesh

end
