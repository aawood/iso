function runBehaviours()
	for objectIndex, object in ipairs(objects) do
		if object.oType == "object" then
			for behaviourIndex, behaviour in ipairs(object.behaviour) do
				if behaviour.bName == "sMove" then
					sMove(object, objectIndex, behaviourIndex, behaviour.direction, behaviour.speed)
				elseif behaviour.bName == "gJump" then
					gJump(object, behaviourIndex, behaviour.direction, behaviour.ascentRate, behaviour.forwardRate)
				end
			end
		end
	end
end

function gJump(object, objectIndex, behaviourIndex, direction, ascentRate, forwardRate)
	local direction = direction or "south"
	local xMin = object.curX
	local xMax = object.curX + object.xWidth
	local yMin = object.curY
	local yMax = object.curY + object.yWidth
	local zMin = object.curZ - object.height 
	local zMax = object.curZ
	local ascentRate = ascentRate or 1
	local forwardRate = forwardRate or 1
	local curAscend = ascentRate * timeElapsed
	local curForward = forwardRate * timeElapsed
	local hitObstacle = 0
	zMin = zMin - curAscend
	zMax = zMax - curAscend
	if direction == "south" then
		yMin = yMin - curForward
		yMax = yMax - curForward
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = zMax
			object.curY = yMin
		else
			hitObstacle = 1
		end
	elseif direction == "north" then
		yMin = yMin + curForward
		yMax = yMax + curForward
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = zMax
			object.curY = yMin
		else
			hitObstacle = 1
		end
	elseif direction == "east" then
		xMin = xMin + curForward
		xMax = xMax + curForward
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = zMax
			object.curX = xMin
		else
			hitObstacle = 1
		end
	elseif direction == "west" then
		xMin = xMin - curForward
		xMax = xMax - curForward
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = zMax
			object.curX = xMin
		else
			hitObstacle = 1
		end
	end
	depthCalc(object)
	if hitObstacle == 1 then
		object.behaviour[behaviourIndex].ascentRate = ascentRate - (timeElapsed * globalGravity)
		removeBehaviour(object, behaviourIndex)
		addBehaviour(objectIndex, {bName = "sMove", direction = "down", speed = "3"})
	end
end

function sMove(object, objectIndex, behaviourIndex, direction, speed)
	local direction = direction or "down"
	local speed = speed or 0
	local xMin = object.curX
	local xMax = object.curX + object.xWidth
	local yMin = object.curY
	local yMax = object.curY + object.yWidth
	local zMin = object.curZ - object.height 
	local zMax = object.curZ
	local hitObstacle = 1
	if direction == "down" then
		zMin = zMin + (speed * timeElapsed)
		zMax = zMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = object.curZ + (speed * timeElapsed)
			hitObstacle = 0
		end
	elseif direction == "east" then
		xMin = xMin + (speed * timeElapsed)
		xMax = xMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curX = object.curX + (speed * timeElapsed)
			hitObstacle = 0
		end
	elseif direction == "west" then
		xMin = xMin - (speed * timeElapsed)
		xMax = xMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curX = object.curX - (speed * timeElapsed)
			hitObstacle = 0
		end
	elseif direction == "north" then
		yMin = yMin + (speed * timeElapsed)
		yMax = yMax + (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curY = object.curY + (speed * timeElapsed)
			hitObstacle = 0
		end
	elseif direction == "south" then
		yMin = yMin - (speed * timeElapsed)
		yMax = yMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curY = object.curY - (speed * timeElapsed)
			hitObstacle = 0
		end
	elseif direction == "up" then
		zMin = zMin - (speed * timeElapsed)
		zMax = zMax - (speed * timeElapsed)
		if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
			object.curZ = object.curZ - (speed * timeElapsed)
			hitObstacle = 0
		end
	end
	depthCalc(object)
	if hitObstacle == 1 then
		removeBehaviour(object, behaviourIndex)
	end
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
				collision = 1
			end
		end
	end
	if collision == 0 then colNo = colNo + 1 end
	if collision == 1 then colYes = colYes + 1 end	
	return collision
end

function addBehaviour(objectIndex, newBehaviour)
	table.insert(objects[objectIndex].behaviour, newBehaviour)
end

function removeBehaviour(object, behaviourIndex)
	table.remove(object.behaviour, behaviourIndex)
end

function behaviourExists(object, behaviourName)
	debugText = behaviourName
	exists = 0
	for behaviourIndex, behaviourItem in ipairs(object.behaviour) do
		if behaviourItem.bName == behaviourName then
			exists = 1
		end
	end
	return exists
end

function depthCalc(object)
	object.depth = object.curX + object.curY + (object.curZ * 0.5) - object.height
end
