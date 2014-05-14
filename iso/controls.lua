jumpKey = " "
turnRightKey = "d"
turnLeftKey = "a"
forwardKey = "w"
backwardsKey = "s"
inventoryKey = "e"
pauseKey = "p"

function checkControls()
	if love.keyboard.isDown(jumpKey) then
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
				local direction = object.facing
				if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 1 then
					if behaviourExists(object, "gJump") == 0 then
						addBehaviour(objectIndex, {bName = "gJump", ascentRate = 3.4, forwardRate = 1, direction = direction})
					end
				end
			end
		end
	end
end
