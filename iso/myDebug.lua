function addDebug(string)
    debugLines = debugLines or {}
    maxLines = math.floor(screenY / 10)
    table.insert(debugLines, {timeElapsed, string})
    if #debugLines > maxLines then
        table.remove(debugLines, 1)
    end
end

function printDebug()
    if debug == true then
        debugLines = debugLines or {}
        for index, line in ipairs(debugLines) do
            love.graphics.print(line[1].." - "..line[2], screenX - 300, index * 10)
        end
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
	local yPos = 150
	love.graphics.print("Behaviours attached:", 0, yPos - 10)
	for behaviourIndex, behaviour in ipairs(object.behaviours) do
		love.graphics.print(tostring(behaviour.bName), 0, yPos)
		yPos = yPos + 10
	end
	yPos = yPos + 20

	love.graphics.print("Known states:", 0, yPos - 10)
	love.graphics.print("     facing = " .. object.states.facing, 0, 120)
end
