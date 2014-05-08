renderOrder = {“backWall”, “backdoor”, “floor”, “objects”, “frontWall”, “frontDoor”}

function genZMap()
	zMap = {}
	for i, object in ipairs(map) do
		table.insert(zMap, object.curZ)
	end
	local hash = {}
	local res = {}
	for _, v in ipairs(zMap) do
		if (not hash[v]) then
			res[#res+1] = v
			hash[v] = true
		end
	end
	table.sort(res)
	local size = #res+1
	zMap = {}
	for i, v in ipairs(res) do
		zMap[size-i] = v
	end
end

function drawMap()
	for i, z in ipairs(zMap) do
		for index, object in ipairs(map) do
			if object.curZ == z then
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
