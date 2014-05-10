function runBehaviours()
	for objectIndex, object in ipairs(objects) do
		if object.oType == "object" then
			for behaviourIndex, behaviour in ipairs(object.behaviour) do
				love.graphics.print(tostring(behaviour), objectIndex, behaviourIndex)
				if behaviour.bName == "sMove" then
					sMove(object, behaviour.direction, behaviour.speed)
				end
			end
		end
	end
end

function sMove(object, direction, speed)
	love.graphics.print(direction, 1, 1)
	local direction = direction or "down"
	if direction == "down" then
		if checkCollision(object, direction, speed) == 0 then
			object.curZ = object.curZ + (speed * timeElapsed)
		end
	elseif direction == "east" then
		if checkCollision(object, direction, speed) == 0 then
			object.curX = object.curX + (speed * timeElapsed)
		end
	elseif direction == "west" then
		if checkCollision(object, direction, speed) == 0 then
			object.curX = object.curX - (speed * timeElapsed)
		end
	elseif direction == "north" then
		if checkCollision(object, direction, speed) == 0 then
			object.curY = object.curY + (speed * timeElapsed)
		end
	elseif direction == "south" then
		if checkCollision(object, direction, speed) == 0 then
			object.curY = object.curY - (speed * timeElapsed)
		end
	elseif direction == "up" then
		if checkCollision(object, direction, speed) == 0 then
			object.curZ = object.curZ - (speed * timeElapsed)
		end
	end
end

function checkCollision(object, direction, speed)
	local collision = 0
	local cx = object.curX
	local cy = object.curY
	local cz = object.curZ + 0.9
	local cTemp = 0
	if direction == "down" then
		cTemp = cz + (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			if altObject ~= object then
				if altObject.curX >= math.floor(cx) and altObject.curX <= math.ceil(cx) and altObject.curY >= math.floor(cy) and altObject.curY <= math.ceil(cy) and altObject.curZ >= cz and altObject.curZ <= cTemp then
					collision = 1
				end
			end
		end
	end
	return collision
end
