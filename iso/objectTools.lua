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

function addObject(x, y, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
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
	local oBehaviours = oBehaviours or {}
	local oStates = oStates or {}
	local depth = x + y + (z*0.5) - oHeight
	table.insert(objects, {tileID = tileID, curX = x, curY = y, curZ = z, oType = oType, behaviours = oBehaviours, depth = depth, height = oHeight, xWidth = xWidth, yWidth = yWidth, states = oStates})
end

function buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	local x1 = x1 or 0
	local y1 = y1 or 0
	local x2 = x2 or 16
	local y2 = y2 or 16
	local z = z or 0
	local tileID = tileID or 2
	local oType = oType or "floor"
	local oBehaviours = oBehaviours or {}
	local oStates = oStates or {}
	local oHeight = oHeight
	local xWidth = xWidth
	local yWidth = yWidth
	for x = x1, x2 do
		for y = y1, y2 do
			addObject(x, y, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
		end
	end
end

function buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	for z = z1, z2 do
		buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	end
end

function debugObjectDetails(objectIndex, xPos)
	object = objects[objectIndex]
	local xPos = xPos or 0
	love.graphics.print("objectIndex = "..tostring(objectIndex), 0, 30)
	love.graphics.print("       curX = "..tostring(object.curX), 0, 40)
	love.graphics.print("       curY = "..tostring(object.curY), 0, 50)
	love.graphics.print("       curZ = "..tostring(object.curZ), 0, 60)
	love.graphics.print("     xWidth = "..tostring(object.xWidth), 0, 70)
	love.graphics.print("     yWidth = "..tostring(object.yWidth), 0, 80)
	love.graphics.print("     height = "..tostring(object.height), 0, 90)
	love.graphics.print("     tileID = "..tostring(object.tileID), 0, 100)
	love.graphics.print("      oType = "..tostring(object.oType), 0, 110)
	local yPos = 140
	love.graphics.print("Behaviours attached:", 0, yPos - 10)
	for behaviourIndex, behaviour in ipairs(object.behaviours) do
		love.graphics.print(tostring(behaviour.bName), 0, yPos)
		yPos = yPos + 10
	end
	yPos = yPos + 20
	love.graphics.print("States attached:", 0, yPos - 10)
	for stateIndex, state in ipairs(object.states) do
		love.graphics.print(tostring(state.bName), 0, yPos)
		yPos = yPos + 10
	end
end
