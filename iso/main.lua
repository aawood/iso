function love.load()
	screenX = love.graphics.getWidth()
	screenY = love.graphics.getHeight()
	cenX = screenX/2
	cenY = screenY/2
	xLimit = cenX/1.5
	yLimit = cenY/1.5
	love.window.setMode(screenX, screenY, {fullscreen=false, vsync=true, fsaa=0})
	timeElapsed = 0
	grav = 0

	loadTileset()
--	loadMap()
	genMap()
end

function love.draw()
	genZMap()
	drawMap()
	moveTile()
--	love.graphics.print(map, 0, 0)
end

function moveTile()
	if map[1][4] <= 6 then
		map[1][4] = map[1][4] + grav
		map[2][4] = map[2][4] + grav
		map[4][4] = map[4][4] + grav
		map[5][4] = map[5][4] + grav
		grav = grav + 0.002
	end
	if map[7][2] <= 4.5 then
		map[7][2] = map[7][2] + 0.02
		map[8][2] = map[8][2] + 0.02
		map[9][2] = map[9][2] + 0.02
		map[10][2] = map[10][2] + 0.02
		map[11][2] = map[11][2] + 0.02
	end
end

function love.update(dt)
	timeElapsed = dt
end

function loadTileset()
	tileset = love.graphics.newImage('8x8tile.png')
	
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

function loadMap()
	map = {}
	local quadID = 1
	for ix = 0, tilesetW, tileW do
		local tileRow = {}
		for iy = 0, tilesetH, tileH do
			table.insert(tileRow, {quadID, 0})
--			quadID = quadID + 1
		end
		table.insert(map, tileRow)
	end
end

function genMap()
	map = {}
--	Object format {tileID, x, y, z}
	table.insert(map, {1, 1, 1, 1})
	table.insert(map, {1, 2, 1, 1})
	table.insert(map, {1, 1, 2, 1})
	table.insert(map, {1, 2, 2, 1})
	table.insert(map, {1, 3, 1, 1})
	table.insert(map, {1, 1, 3, 1})
	table.insert(map, {1, 3, 3, 1})
	table.insert(map, {1, 3, 3, 2})
	table.insert(map, {1, 3, 3, 3})
	table.insert(map, {1, 3, 3, 4})
	table.insert(map, {1, 3, 3, 5})
	table.insert(map, {1, 3, 2, 1})
	table.insert(map, {1, 2, 3, 1})
end

--[[function drawMap()
	revMap = {}
	for i, v in ipairs (map) do
		revMap[v] = i
	end
--	for columnIndex,column in ipairs(revMap) do
	for columnIndex,column in ipairs(map) do
		revCol = {}
		for i, v in ipairs (column) do
			revCol[v] = i
		end
--		for rowIndex,cell in ipairs(revCol) do
		for rowIndex,cell in ipairs(column) do
			number = cell[1]
			local x,y = (columnIndex-1)*tileW, (rowIndex-1)*tileH
			local drawX = cenX + (x/2) - (y/2)
			local drawY = cenY - (x/2) - (y/2)
			love.graphics.drawq(tileset, quads[number], drawX, drawY)
--			love.graphics.drawq(tileset, quads[number], x, y)
		end
	end
end
--]]

function drawMap()
	for i, z in ipairs(zMap) do
		for index, object in ipairs(map) do
			if object[4] == z then
				local tileID = object[1]
				local x = (object[2] * tileW)
				local y = object[3] * tileH
				local z = object[4] * tileH
				local drawX = cenX + (x/2) - (y/2)
				local drawY = cenY - (x/2) - (y/2) + z
				love.graphics.draw(tileset, quads[tileID], drawX, drawY)
--				love.graphics.draw(tileset, quads[tileID], x, y)
			end
		end
	end
end

function genZMap()
	zMap = {}
	for i, object in ipairs(map) do
		table.insert(zMap, object[4])
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

function listContents(arr, x)
	x = x or 0
	for i, e in ipairs(arr) do
		love.graphics.print(tostring(e), x*10, i*10)
	end
end