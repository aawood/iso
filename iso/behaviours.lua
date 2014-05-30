function runBehaviours()
	for objectIndex, object in ipairs(objects) do
		if object.oType == "object" then
      if object.states.heavy == true then
        if moveTo(object, objectIndex, 0, 0, object.states.gravity * globalGravity * timeElapsed) == true then
          object.states.gravity = object.states.gravity + timeElapsed
        else
          if object.states.gravity > 0.02 then
            object.states.gravity = object.states.gravity / 3
          else
            object.states.gravity = 0
          end
          if behaviourExists(object, "jump") == true then
            removeBehaviour(object, findBehaviourIndex(object, "jump"))
          end
        end
      end

			for behaviourIndex, behaviour in ipairs(object.behaviours) do
				if behaviour.bName == "gJump" then
					gJump(object, objectIndex, behaviourIndex, behaviour.direction, behaviour.ascentRate, behaviour.forwardRate)
        end
      end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
			  if behaviour.bName == "jump" then
					jump(object, objectIndex, behaviourIndex, behaviour.direction, behaviour.ascentRate, behaviour.forwardRate)
			  end
      end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
				if behaviour.bName == "turnRight" then
					turnRight(object, objectIndex, behaviourIndex)
			  end
      end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
				if behaviour.bName == "turnLeft" then
					turnLeft(object, objectIndex, behaviourIndex)
        end
      end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
			  if behaviour.bName == "moveForward" then
          moveForward(object, objectIndex, behaviour.speed)
          removeBehaviour(object, behaviourIndex)
				end
			end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
        if behaviour.bName == "travel" then
          travel(object, objectIndex, behaviour.speed, behaviour.direction)
        end
      end
      for behaviourIndex, behaviour in ipairs(object.behaviours) do
        if behaviour.bName == "bounce" then
          bounce(object, objectIndex, behaviour.speed, behaviour.direction, behaviourIndex)
        end
      end
		end
	end
end

function turnRight(object, objectIndex, behaviourIndex)
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
  removeBehaviour(object, findBehaviourIndex(object, "turnRight"))
end

function turnLeft(object, objectIndex, behaviourIndex)
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
  removeBehaviour(object, findBehaviourIndex(object, "turnLeft"))
end

function jump(object, objectIndex, behaviourIndex, direction, ascentRate, forwardRate)
  moveForward(object, objectIndex, forwardRate, direction)
  if moveTo(object, objectIndex, 0, 0, -ascentRate * timeElapsed) == false then
    ascentRate = 0
  end
end

function moveForward(object, objectIndex, speed, direction)
  local direction = direction or object.states.facing
  local speed = speed * timeElapsed
  if direction == "north" then
    return moveTo(object, objectIndex, 0, speed, 0)
  elseif direction == "east" then
    return moveTo(object, objectIndex, speed, 0, 0)
  elseif direction == "south" then
    return moveTo(object, objectIndex, 0, -speed, 0)
  elseif direction == "west" then
    return moveTo(object, objectIndex, -speed, 0, 0)
  elseif direction == "up" then
    return moveTo(object, objectIndex, 0, 0, -speed)
  elseif direction == "down" then
    return moveTo(object, objectIndex, 0, 0, speed)
  end
end

function travel(object, objectIndex, speed, direction)
  return moveForward(object, objectIndex, speed, direction)
end

function bounce(object, objectIndex, speed, direction, behaviourIndex)
  if moveForward(object, objectIndex, speed, direction) == false then
    if object.behaviours[behaviourIndex].direction == "north" then
      object.behaviours[behaviourIndex].direction = "south"
    elseif object.behaviours[behaviourIndex].direction == "south" then
      object.behaviours[behaviourIndex].direction = "north"
    elseif object.behaviours[behaviourIndex].direction == "east" then
      object.behaviours[behaviourIndex].direction = "west"
    elseif object.behaviours[behaviourIndex].direction == "west" then
      object.behaviours[behaviourIndex].direction = "east"
    elseif object.behaviours[behaviourIndex].direction == "down" then
      object.behaviours[behaviourIndex].direction = "up"
    elseif object.behaviours[behaviourIndex].direction == "up" then
      object.behaviours[behaviourIndex].direction = "down"
    end
  end
end

function moveTo(object, objectIndex, addX, addY, addZ)
  local xMin = object.curX + addX
	local xMax = object.curX + object.xWidth + addX
	local yMin = object.curY + addY
	local yMax = object.curY + object.yWidth + addY
	local zMin = object.curZ - object.height + addZ
	local zMax = object.curZ + addZ
  if checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object, objectIndex, addX, addY, addZ) == false then
    object.curX = xMin
    object.curY = yMin
    object.curZ = zMax
    depthCalc(object)
    return true
  else
    return false
  end
end

function onGround(object, objectIndex)
  local xMin = object.curX
	local xMax = object.curX + object.xWidth
	local yMin = object.curY
	local yMax = object.curY + object.yWidth
	local zMin = object.curZ - object.height
	local zMax = object.curZ
  zMin = zMin + 0.02
  zMax = zMax + 0.02
  return checkCollision(xMin, xMax, yMin, yMax, zMin, zMax, object, objectIndex)
end

function addBehaviour(objectIndex, newBehaviour)
  addDebug("Adding Behaviour "..newBehaviour.bName)
	table.insert(objects[objectIndex].behaviours, newBehaviour)
end

function removeBehaviour(object, behaviourIndex)
  addDebug("Removing Behaviour ".. object.behaviours[behaviourIndex].bName)
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
	object.depth = object.curX + object.curY + ((object.curZ - 1) * 0.5) - object.height
end
