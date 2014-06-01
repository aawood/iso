function checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object, objectIndex, xSpeed, ySpeed, zSpeed)
	local collision = false

	-- Need a tiny buffer to stop adjacent-but-not-overlapping objects from colliding.
	local xMin = xMin + 0.01
	local xMax = xMax - 0.01
	local yMin = yMin + 0.01
	local yMax = yMax - 0.01
	local zMin = zMin + 0.01
	local zMax = zMax - 0.01
  local xSpeed = xSpeed or 0
  local ySpeed = ySpeed or 0
  local zSpeed = zSpeed or 0

  if xMin < 0 or xMax > 16 or yMin < 0 or yMax > 16 or zMin < 0 or zMax > 16 then
    collision = true
  else
    for altObjectIndex, altObject in ipairs(objects) do
    -- Make sure we're not colliding with ourself
      if altObject ~= object then
        if altObject.curX + altObject.xWidth >= xMin and altObject.curX <= xMax and altObject.curY + altObject.yWidth >= yMin and altObject.curY <= yMax and altObject.curZ >= zMin and altObject.curZ - altObject.height <= zMax then
          collision = true
          collisionBetween(objectIndex, altObjectIndex, xSpeed, ySpeed, zSpeed)
        end
      end
    end
	end

	return collision
end

function collisionBetween(objectAIndex, objectBIndex, xSpeed, ySpeed, zSpeed)
  objectA = objects[objectAIndex]
  objectB = objects[objectBIndex]
--  addDebug("ObjectA ID - " .. tostring(objectAIndex) .. " | ObjectB ID - " .. tostring(objectBIndex))

-- If a moving object with Friction has on object on top, move object on top
  if stateExists(objectA, "supporting") == true then
    moveTo(objectB, objectBIndex, xSpeed, ySpeed, zSpeed)
  end

-- If an object moves into another that isn't immobile, move it.
  if stateExists(objectB, "immobile") == false then
    moveTo(objectB, objectBIndex, xSpeed, ySpeed, zSpeed)
  end
end
