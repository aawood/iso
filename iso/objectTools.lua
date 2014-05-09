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

function addObject(x, y, z, tileID, oType, oBehaviour)
	local x = x or 0
	local y = y or 0
	local z = z or 0
	local tileID = tileID or 1
	local oType = oType or "object"
	local oBehaviour = oBehaviour or {{"all"}}
	local xy = x + y
	table.insert(objects, {tileID = tileID, curX = x, curY = y, curZ = z, oType = oType, behaviour = oBehaviour, curXY = xy})
end

function buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviour)
	local x1 = x1 or 0
	local y1 = y1 or 0
	local x2 = x2 or 16
	local y2 = y2 or 16
	local z = z or 0
	local tileID = tileID or 2
	local oType = oType or "floor"
	local oBehaviour = oBehaviour
	for x = x1, x2 do
		for y = y1, y2 do
			addObject(x, y, z, tileID, oType, oBehaviour)
		end
	end
end
