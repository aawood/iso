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
	depthCalc(object)
end

function checkCollision(object, direction, speed)
	local collision = 0
	-- Need a tiny buffer to stop adjacent-but-not-overlapping objects from colliding.
	local cx = object.curX + 0.01
	local cxWidth = object.xWidth - 0.02
	local cy = object.curY + 0.01
	local cyWidth = object.yWidth - 0.02
	local cz = object.curZ + 0.01
	local czHeight = object.height - 0.02
	local cTemp = 0
	if direction == "down" then
		cTemp = cz + (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping x/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curY + altObject.yWidth >= cy and altObject.curY <= cy + cyWidth and altObject.curZ - altObject.height >= cz and altObject.curZ - altObject.height <= cTemp then
					collision = 1
				end
			end
		end
	elseif direction == "east" then
		cTemp = cz + (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping z/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curY + altObject.yWidth >= cy and altObject.curY <= cy + cyWidth and altObject.curZ - altObject.height >= cz and altObject.curZ - altObject.height <= cTemp then
					collision = 1
				end
			end
		end
	elseif direction == "west" then
		cTemp = cz - (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping z/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curY + altObject.yWidth >= cy and altObject.curY <= cy + cyWidth and altObject.curZ - altObject.height >= cz and altObject.curZ - altObject.height <= cTemp then
					collision = 1
				end
			end
		end
	elseif direction == "north" then
		cTemp = cz + (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping x/z co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curY + altObject.yWidth >= cy and altObject.curY <= cy + cyWidth and altObject.curZ - altObject.height >= cz and altObject.curZ - altObject.height <= cTemp then
					collision = 1
				end
			end
		end
	elseif direction == "south" then
		cTemp = cy - (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping x/z co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curZ + altObject.height >= cz and altObject.curZ <= cz + czHeight and altObject.curY <= cy and altObject.curY + altObject.yWidth >= cTemp then
					collision = 1
				end
			end
		end
	elseif direction == "up" then
		cTemp = cz + (speed * timeElapsed)
		for objectIndex, altObject in ipairs(objects) do
			-- Make sure we're not colliding with ourself
			if altObject ~= object then
				-- If we're on overlapping x/y co-ordinates, check if increasing Z would put us into alt object. If so, it's a collision.
				if altObject.curX + altObject.xWidth >= cx and altObject.curX <= cx + cxWidth and altObject.curY + altObject.yWidth >= cy and altObject.curY <= cy + cyWidth and altObject.curZ - altObject.height >= cz and altObject.curZ - altObject.height <= cTemp then
					collision = 1
				end
			end
		end
	end
	return collision
end

function depthCalc(object)
	object.depth = object.curX + object.curY + (object.curZ * 0.5) - object.height
end
