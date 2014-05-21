function checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object, objectIndex)
	local collision = false

	-- Need a tiny buffer to stop adjacent-but-not-overlapping objects from colliding.
	local xMin = xMin + 0.01
	local xMax = xMax - 0.01
	local yMin = yMin + 0.01
	local yMax = yMax - 0.01
	local zMin = zMin + 0.01
	local zMax = zMax - 0.01

	for altObjectIndex, altObject in ipairs(objects) do
	-- Make sure we're not colliding with ourself
		if altObject ~= object then
			-- If we're on overlapping x/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
			if altObject.curX + altObject.xWidth >= xMin and altObject.curX <= xMax and altObject.curY + altObject.yWidth >= yMin and altObject.curY <= yMax and altObject.curZ >= zMin and altObject.curZ - altObject.height <= zMax then
				collision = true
        collisionBetween(objectIndex, altObjectIndex)
			end
		end
	end
	return collision
end

function collisionBetween(objectAIndex, objectBIndex)
  objectA = objects[objectAIndex]
  objectB = objects[objectBIndex]
end
