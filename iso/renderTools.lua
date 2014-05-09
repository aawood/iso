renderOrder = {“backWall”, “backdoor”, “floor”, “objects”, “frontWall”, “frontDoor”}

function genDepthMaps()
	zMap = {}
	xyMap = {}
	-- Populate tables with Z and XY values of all objects
	for i, object in ipairs(objects) do
		table.insert(zMap, object.curZ)
		table.insert(xyMap, object.curXY)
	end
	
	-- Generate table with unique Z values, then sort, then reverse
	local zHash = {}
	local zRes = {}
	for _, v in ipairs(zMap) do
		if (not zHash[v]) then
			zRes[#zRes+1] = v
			zHash[v] = true
		end
	end

	table.sort(zRes)
	local size = #zRes+1
	zMap = {}
	for i, v in ipairs(zRes) do
		zMap[size-i] = v
	end
	
	-- Generate table with unique XY values, then sort, then reverse
	local xyHash = {}
	local xyRes = {}
	for _, v in ipairs(xyMap) do
		if (not xyHash[v]) then
			xyRes[#xyRes+1] = v
			xyHash[v] = true
		end
	end

	table.sort(xyRes)
	local size = #xyRes+1
	xyMap = {}
	for i, v in ipairs(xyRes) do
		xyMap[size-i] = v
	end	
end

function drawObjects()
	for zi, z in ipairs(zMap) do
		for xyi, xy in ipairs (xyMap) do
			for index, object in ipairs(objects) do
				if object.curZ == z and object.curXY == xy then
					local tileID = object.tileID
					local x = object.curX * tileW
					local y = object.curY * tileH
					local z = object.curZ * tileH
					local drawX = (cenX + (x/2) - (y/2)) + xOffset
					local drawY = ((cenY - (x/2) - (y/2) + z) / 2) + yOffset
					love.graphics.draw(tileset, quads[tileID], drawX, drawY)
				end
			end
		end
	end
end

function loadTileset()
	tileset = love.graphics.newImage('assets/template.png')
	
	tileW, tileH = 32, 32
	tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
	
	quads = {}
	
	for ix = 0, tilesetW, tileW do
		for iy = 0, tilesetH, tileH do
			local quad = love.graphics.newQuad(ix, iy, tileW, tileH, tilesetW, tilesetH)
			table.insert(quads, quad)
		end
	end
end
