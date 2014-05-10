renderOrder = {"backWall", "backDoor", "floor", "object"}

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
	for zIndex, z in ipairs(zMap) do
		for typeIndex, rType in ipairs(renderOrder) do
			for xyIndex, xy in ipairs (xyMap) do
				for objectIndex, object in ipairs(objects) do
					if object.curZ == z and object.curXY == xy and object.oType == rType then
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
	end
	
	for zIndex, z in ipairs(zMap) do
		for xyIndex, xy in ipairs (xyMap) do
			for objectIndex, object in ipairs(objects) do
				if object.curZ == z and object.curXY == xy and object.oType == "frontWall" then
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
	
	for zIndex, z in ipairs(zMap) do
		for xyIndex, xy in ipairs (xyMap) do
			for objectIndex, object in ipairs(objects) do
				if object.curZ == z and object.curXY == xy and object.oType == "frontDoor" then
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
