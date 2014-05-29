jumpKey = " "
turnRightKey = "d"
turnLeftKey = "a"
forwardKey = "w"
backwardsKey = "s"
inventoryKey = "e"
pauseKey = "p"

playerJumpStrength = 4.7
playerJumpSpeed = 1.6
playerRunSpeed = 3

function checkControls()
	if love.keyboard.isDown(jumpKey) then
		for objectIndex, object in ipairs(objects) do
			if stateExists(object, "player") == true then
				local xMin = object.curX
				local xMax = object.curX + object.xWidth
				local yMin = object.curY
				local yMax = object.curY + object.yWidth
				local zMin = object.curZ - object.height
				local zMax = object.curZ
				zMin = zMin + 0.1
				zMax = zMax + 0.1
				local direction = object.states.facing
				if onGround(object, objectIndex) == true then
					if behaviourExists(object, "jump") == false then
						addBehaviour(objectIndex, {bName = "jump", ascentRate = playerJumpStrength, forwardRate = playerJumpSpeed, direction = direction})
					end
				end
			end
		end
	end
	if love.keyboard.isDown(turnRightKey) then
--    addDebug("Right key pressed")
		for objectIndex, object in ipairs(objects) do
			if stateExists(object, "player") == true then
        if stateExists(object, "turnedRight") == false then
          addBehaviour(objectIndex, {bName = "turnRight"})
        end
			end
		end
	else
		for objectIndex, object in ipairs(objects) do
			if stateExists(object, "player") == true then
				if stateExists(object, "turnedRight") == true then
					removeState(object, "turnedRight")
				end
			end
		end
	end
	if love.keyboard.isDown(turnLeftKey) then
--    addDebug("Left Key Pressed")
    for objectIndex, object in ipairs(objects) do
			if stateExists(object, "player") == true then
        if stateExists(object, "turnedLeft") == false then
          addBehaviour(objectIndex, {bName = "turnLeft"})
        end
			end
		end
	else
		for objectIndex, object in ipairs(objects) do
			if stateExists(object, "player") == true then
				if stateExists(object, "turnedLeft") == true then
					removeState(object, "turnedLeft")
				end
			end
		end
	end
  if love.keyboard.isDown(forwardKey) then
    for objectIndex, object in ipairs(objects) do
      if stateExists(object, "player") == true then
        if onGround(object, objectIndex) == true then
          addBehaviour(objectIndex, {bName = "moveForward", speed = playerRunSpeed})
        end
      end
    end
  end
  if love.keyboard.isDown(backwardsKey) then
    for objectIndex, object in ipairs(objects) do
      if stateExists(object, "player") == true then
        if onGround(object, objectIndex) == true then
          addBehaviour(objectIndex, {bName = "moveForward", speed = -playerRunSpeed})
        end
      end
    end
  end
end
