function checkControls()
	if love.keyboard.isDown(" ") then
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
						addBehaviour(objectIndex, {bName = "gJump", ascentRate = 5, forwardRate = 2, direction = direction})
					end
				end
			end
		end
	end
end
