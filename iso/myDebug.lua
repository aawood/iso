debug = true
testObject = 218

function addDebug(string)
    debugLines = debugLines or {}
    maxLines = math.floor(screenY / 10)
    table.insert(debugLines, {epochTime, string})
    if #debugLines > maxLines then
        table.remove(debugLines, 1)
    end
end

function printDebug()
    if debug == true then
        debugLines = debugLines or {}
        for index, line in ipairs(debugLines) do
            love.graphics.print(line[1].." - "..line[2], screenX - 280, index * 10)
        end
    end
end

function debugObjectDetails(objectIndex, xPos)
	object = objects[objectIndex]
	local xPos = xPos or 0
	love.graphics.print("objectIndex = "..tostring(objectIndex), xPos, 30)
	love.graphics.print("       curX = "..tostring(object.curX), xPos, 40)
	love.graphics.print("       curY = "..tostring(object.curY), xPos, 50)
	love.graphics.print("       curZ = "..tostring(object.curZ), xPos, 60)
	love.graphics.print("     xWidth = "..tostring(object.xWidth), xPos, 70)
	love.graphics.print("     yWidth = "..tostring(object.yWidth), xPos, 80)
	love.graphics.print("     height = "..tostring(object.height), xPos, 90)
	love.graphics.print("     tileID = "..tostring(object.tileID), xPos, 100)
	love.graphics.print("      oType = "..tostring(object.oType), xPos, 110)
	local yPos = 150
	love.graphics.print("Behaviours attached:", xPos, yPos - 10)
	for behaviourIndex, behaviour in ipairs(object.behaviours) do
		love.graphics.print(tostring(behaviour.bName), xPos, yPos)
		yPos = yPos + 10
	end
	yPos = yPos + 20

  love.graphics.print("Known states:", xPos, yPos - 10)
--[[
	love.graphics.print("     facing = " .. tostring(object.states.facing), xPos, yPos)
  yPos = yPos + 10
  if stateExists(object, "player") == true then
    love.graphics.print("  Is Player = " .. tostring(object.states.player), xPos, yPos)
  end
  yPos = yPos + 10
  if stateExists(object, "gravity") == true then
    love.graphics.print("  gravity = " .. tostring(object.states.gravity), xPos, yPos)
  end
  if stateExists(object, "immobile") == true then
    love.graphics.print(" immobile = " .. tostring(object.states.immobile), xPos, yPos)
  end
--]]
  for stateName, stateValue in pairs(object.states) do
    love.graphics.print(stateName .. " = " .. tostring(stateValue) , xPos, yPos)
    yPos = yPos + 10
  end
end
