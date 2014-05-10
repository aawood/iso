function loadTileset()
	tileset = love.graphics.newImage('assets/tileset.png')
	
	tileW, tileH = 32, 32
	tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
	
	quads = {}
	
	for ix = 0, tilesetW-1, tileW do
		for iy = 0, tilesetH-1, tileH do
			local quad = love.graphics.newQuad(ix, iy, tileW, tileH, tilesetW, tilesetH)
			table.insert(quads, quad)
		end
	end
end

function addObject(x, y, z, tileID, oType, oBehaviour, oHeight, xWidth, yWidth)
	local x = x or 0
	local y = y or 0
	local z = z or 0
	local oType = oType or "object"
	local height = 1
	if oType == "floor" then
		height =  0
	elseif oType == "backWall" or oType == "frontWall" then
		height = 1.5
	end
	local oHeight = oHeight or height
	local xWidth = xWidth or 1
	local yWidth = yWidth or 1
	local tileID = tileID or 1
	local oBehaviour = oBehaviour or {}
	local depth = x + y + (z*0.5) - oHeight
	table.insert(objects, {tileID = tileID, curX = x, curY = y, curZ = z, oType = oType, behaviour = oBehaviour, depth = depth, height = oHeight, xWidth = xWidth, yWidth = yWidth})
end

function buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviour, oHeight, xWidth, yWidth)
	local x1 = x1 or 0
	local y1 = y1 or 0
	local x2 = x2 or 16
	local y2 = y2 or 16
	local z = z or 0
	local tileID = tileID or 2
	local oType = oType or "floor"
	local oBehaviour = oBehaviour or {}
	local oHeight = oHeight
	local xWidth = xWidth
	local yWidth = yWidth
	for x = x1, x2 do
		for y = y1, y2 do
			addObject(x, y, z, tileID, oType, oBehaviour, oHeight, xWidth, yWidth)
		end
	end
end

function buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviour, oHeight, xWidth, yWidth)
	for z = z1, z2 do
		buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviour, oHeight, xWidth, yWidth)
	end
end
