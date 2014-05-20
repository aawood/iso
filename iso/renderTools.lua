renderOrder = {"backWall", "backDoor", "floor", "object"}

function genDepthMaps()
	depthMap = {}
	-- Populate tables with Z and XY values of all objects
	for i, object in ipairs(objects) do
		table.insert(depthMap, object.depth)
	end

	-- Generate table with unique depth values, then sort, then reverse
	local depthHash = {}
	local depthRes = {}
	for _, v in ipairs(depthMap) do
		if (not depthHash[v]) then
			depthRes[#depthRes+1] = v
			depthHash[v] = true
		end
	end

	table.sort(depthRes)
	local size = #depthRes+1
	depthMap = {}
	for i, v in ipairs(depthRes) do
		depthMap[size-i] = v
	end
end

function drawObjects()
	for depthIndex, depth in ipairs(depthMap) do
		for typeIndex, rType in ipairs(renderOrder) do
			for objectIndex, object in ipairs(objects) do
				if object.depth == depth and object.oType == rType then
					local tileID = object.tileID
					local x = object.curX * tileW
					local y = object.curY * tileH
					local z = object.curZ * tileH
					local drawX = (cenX + (x/2) - (y/2)) + xOffset
					local drawY = ((cenY - (x/2) - (y/2) + z) / 2) + yOffset
					love.graphics.draw(tileset, quads[tileID], drawX-(tileW/2), drawY-(tileH/2))
				end
			end
		end
	end

	for depthIndex, depth in ipairs(depthMap) do
		for objectIndex, object in ipairs(objects) do
			if object.depth == depth and object.oType == "frontWall" then
				local tileID = object.tileID
				local x = object.curX * tileW
				local y = object.curY * tileH
				local z = object.curZ * tileH
				local drawX = (cenX + (x/2) - (y/2)) + xOffset
				local drawY = ((cenY - (x/2) - (y/2) + z) / 2) + yOffset
				love.graphics.draw(tileset, quads[tileID], drawX-(tileW/2), drawY-(tileH/2))
			end
		end
	end

	for depthIndex, depth in ipairs(depthMap) do
		for objectIndex, object in ipairs(objects) do
			if object.depth == depth and object.oType == "frontDoor" then
				local tileID = object.tileID
				local x = object.curX * tileW
				local y = object.curY * tileH
				local z = object.curZ * tileH
				local drawX = (cenX + (x/2) - (y/2)) + xOffset
				local drawY = ((cenY - (x/2) - (y/2) + z) / 2) + yOffset
				love.graphics.draw(tileset, quads[tileID], drawX-(tileW/2), drawY-(tileH/2))
			end
		end
	end
end

function debugTiles()
	for i, tile in ipairs(quads) do
		love.graphics.draw(tileset, quads[i], 32*i, 0)
		love.graphics.print(tostring(i), (32*i)+16, 38)
	end
end

function debugType()
	for i, rType in ipairs(renderOrder) do
		love.graphics.print(tostring(i), 0, 10*i)
	end
end
