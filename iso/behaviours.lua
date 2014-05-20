function runBehaviours()
	for objectIndex, object in ipairs(objects) do
		if object.oType == "object" then
      if object.states.heavy == true then
        if moveTo(object, objectIndex, 0, 0, object.states.gravity * globalGravity * timeElapsed) == true then
          object.states.gravity = object.states.gravity + timeElapsed
        else
          object.states.gravity = 0
          if behaviourExists(object, "jump") == true then
            removeBehaviour(object, findBehaviourIndex(object, "jump"))
          end
        end
      end

			for behaviourIndex, behaviour in ipairs(object.behaviours) do
				if behaviour.bName == "gJump" then
					gJump(object, objectIndex, behaviourIndex, behaviour.direction, behaviour.ascentRate, behaviour.forwardRate)
				elseif behaviour.bName == "jump" then
					jump(object, objectIndex, behaviourIndex, behaviour.direction, behaviour.ascentRate, behaviour.forwardRate)
				elseif behaviour.bName == "turnRight" then
					turnRight(object, behaviourIndex)
				elseif behaviour.bName == "turnLeft" then
					turnLeft(object, behaviourIndex)
        elseif behaviour.bName == "moveForward" then
          moveForward(object, objectIndex, behaviour.speed, behaviourIndex)
          removeBehaviour(object, behaviourIndex)
				end
			end
		end
	end
end

function turnRight(object, behaviourIndex)
	if object.states.facing == "north" then
		object.states.facing = "east"
	elseif object.states.facing == "east" then
		object.states.facing = "south"
	elseif object.states.facing == "south" then
		object.states.facing = "west"
	elseif object.states.facing == "west" then
		object.states.facing = "north"
	end
	addState(object, "turnedRight")
	removeBehaviour(object, behaviourIndex)
end

function turnLeft(object, behaviourIndex)
	if object.states.facing == "north" then
		object.states.facing = "west"
	elseif object.states.facing == "west" then
		object.states.facing = "south"
	elseif object.states.facing == "south" then
		object.states.facing = "east"
	elseif object.states.facing == "east" then
		object.states.facing = "north"
	end
	addState(object, "turnedLeft")
	removeBehaviour(object, behaviourIndex)
end

function jump(object, objectIndex, behaviourIndex, direction, ascentRate, forwardRate)
--  addDebug("Jumping")
  moveForward(object, objectIndex, forwardRate, behaviourIndex, direction)
--  addDebug("Attempting to ascend by" .. tostring(-ascentRate * timeElapsed))
  if moveTo(object, objectIndex, 0, 0, -ascentRate * timeElapsed) == false then
--    addDebug("Collided, removing jump")
    ascentRate = 0
  end
end

function moveForward(object, objectIndex, speed, behaviourIndex, direction)
  local direction = direction or object.states.facing
  local collided
  local speed = speed * timeElapsed
  if direction == "north" then
    collided = moveTo(object, objectIndex, 0, speed, 0)
  elseif direction == "east" then
    collided = moveTo (object, objectIndex, speed, 0, 0)
  elseif direction == "south" then
    collided = moveTo (object, objectIndex, 0, -speed, 0)
  elseif direction == "west" then
    collided = moveTo (object, objectIndex, -speed, 0, 0)
  end
--  removeBehaviour(object, behaviourIndex)
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
	return collision
end

function onCollision(collidedObjects)
end

function moveTo(object, objectIndex, addX, addY, addZ)
  local xMin = object.curX + addX
	local xMax = object.curX + object.xWidth + addX
	local yMin = object.curY + addY
	local yMax = object.curY + object.yWidth + addY
	local zMin = object.curZ - object.height + addZ
	local zMax = object.curZ + addZ
  if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 0 then
    object.curX = xMin
    object.curY = yMin
    object.curZ = zMax
    depthCalc(object)
    return true
  else
    return false
  end
end

function onGround(object)
  local xMin = object.curX
	local xMax = object.curX + object.xWidth
	local yMin = object.curY
	local yMax = object.curY + object.yWidth
	local zMin = object.curZ - object.height
	local zMax = object.curZ
  zMin = zMin + 0.02
  zMax = zMax + 0.02
  if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object) == 1 then
    return true
  else
    return false
  end
end

function addBehaviour(objectIndex, newBehaviour)
	table.insert(objects[objectIndex].behaviours, newBehaviour)
end

function removeBehaviour(object, behaviourIndex)
--  addDebug("Removing Behaviour")
	table.remove(object.behaviours, behaviourIndex)
end

function behaviourExists(object, behaviourName)
	exists = false
	for behaviourIndex, behaviour in ipairs(object.behaviours) do
		if behaviour.bName == behaviourName then
			exists = true
		end
	end
	return exists
end

function findBehaviourIndex(object, behaviourName)
  for behaviourIndex, behaviour in ipairs(object.behaviours) do
    if behaviour.bName == behaviourName then
      return behaviourIndex
    end
  end
  return false
end

function depthCalc(object)
	object.depth = object.curX + object.curY + (object.curZ * 0.5) - object.height
end
