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
	local direction = direction or "down"
	local speed = speed or 0
	local xMin = object.curX
	local xMax = object.curX + object.xWidth
	local yMin = object.curY
	local yMax = object.curY + object.yWidth
	local zMin = object.curZ - object.height 
	local zMax = object.curZ
	if direction == "down" then
		zMin = zMin + (speed * timeElapsed)
		zMax = zMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = object.curZ + (speed * timeElapsed)
		end
	elseif direction == "east" then
		xMin = xMin + (speed * timeElapsed)
		xMax = xMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curX = object.curX + (speed * timeElapsed)
		end
	elseif direction == "west" then
		xMin = xMin - (speed * timeElapsed)
		xMax = xMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curX = object.curX - (speed * timeElapsed)
		end
	elseif direction == "north" then
		yMin = yMin + (speed * timeElapsed)
		yMax = yMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curY = object.curY + (speed * timeElapsed)
		end
	elseif direction == "south" then
		yMin = yMin - (speed * timeElapsed)
		yMax = yMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curY = object.curY - (speed * timeElapsed)
		end
	elseif direction == "up" then
		zMin = zMin - (speed * timeElapsed)
		zMax = zMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = object.curZ - (speed * timeElapsed)
		end
	end
	depthCalc(object)
end

function checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object)
	local collision = 0

	-- Need a tiny buffer to stop adjacent-but-not-overlapping objects from colliding.
	local xMin = xMin + 0.01
	local xMax = xMax - 0.01
	local yMin = yMin + 0.01
	local yMax = yMax - 0.01
	local zMin = zMin + 0.01
	local zMax = zMax - 0.01

	for objectIndex, altObject in ipairs(objects) do
	-- Make sure we're not colliding with ourself
		if altObject ~= object then
			-- If we're on overlapping x/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
			if altObject.curX + altObject.xWidth >= xMin and altObject.curX <= xMax and altObject.curY + altObject.yWidth >= yMin and altObject.curY <= yMax and altObject.curZ >= zMin and altObject.curZ - altObject.height <= zMax then
				debugText = "xMin - "..tostring(xMin).."xMax - "..tostring(xMax).." yMin - "..tostring(yMin).." yMax - "..tostring(yMax).." zMin - "..tostring(zMin).." zMax - "..tostring(zMax)
				collision = 1
			end
		end
	end
	if collision == 0 then colNo = colNo + 1 end
	if collision == 1 then colYes = colYes + 1 end	
	return collision
end

function depthCalc(object)
	object.depth = object.curX + object.curY + (object.curZ * 0.5) - object.height
end
