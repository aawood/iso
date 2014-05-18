jumpKey = " "
turnRightKey = "d"
turnLeftKey = "a"
forwardKey = "w"
backwardsKey = "s"
inventoryKey = "e"
pauseKey = "p"

function checkControls()
	debugtext = "Controls"
	if love.keyboard.isDown(jumpKey) then
		debugtext = jumpKey
		for objectIndex, object in ipairs(objects) do
			if behaviourExists(object, "player") == 1 then
				local xMin = object.curX
				local xMax = object.curX + object.xWidth
				local yMin = object.curY
				local yMax = object.curY + object.yWidth
				local zMin = object.curZ - object.height 
				local zMax = object.curZ
				zMin = zMin + 0.1
				zMax = zMax + 0.1
				local direction = object.states.facing
				if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 1 then
					if behaviourExists(object, "gJump") == false then
						addBehaviour(objectIndex, {bName = "gJump", ascentRate = 3.4, forwardRate = 1, direction = direction})
					end
				end
			end
		end
	end
--[[	if love.keyboard.isDown(turnRightKey) then
		debugtext = turnRightKey
		for objectIndex, object in ipairs(objects) do
			if behaviourExists(object, "player") == 1 then
				if behaviourExists(object, "turnRight") == false then
					if stateExists("turnedRight") == false then
						addBehaviour(objectIndex, {bName = "turnRight"})
					end
				end
			end
		end		
	else
		for objectIndex, object in ipairs(objects) do
			if behaviourExists(object, "player") == true then
				if stateExists("turnedRight") == true then
					removeState(object, "turnedRight")
				end
			end
		end
	end
	if love.keyboard.isDown(turnLeftKey) then
		debugText = turnLeftKey
		for objectIndex, object in ipairs(objects) do
			if behaviourExists(object, "player") == true then
				if behaviourExists(object, "turnLeft") == false then
					if stateExists("turnedLeft") == false then
						addBehaviour(objectIndex, {bName = "turnLeft"})
					end
				end
			end
		end
	else
		for objectIndex, object in ipairs(objects) do
			if behaviourExists(object, "player") == true then
				if stateExists("turnedLeft") == true then
					removeState(object, "turnedLeft")
				end
			end
		end
	end
--]]end
