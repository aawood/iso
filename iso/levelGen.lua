function genMap()
--[[
	syntax
	addObject(x, y, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
--]]

	addObject(8.1, 8.1, 2, 2, "object", {}, 0.8, 0.8, 0.8, {solid = true, facing = "east", gravity = 1, heavy = true, player = true})
	addObject(9, 9, 7, 1, "object", {{bName = "bounce", direction = "west", speed = 3}}, 1, 1, 1, {solid = true, friction = true})
	addObject(8, 8, 8, 1, "object", {{bName = "travel", direction = "west", speed = 3}}, 1, 1, 1, {solid = true, friction = true})
	buildFlat(0, 0, 0, 16, 8, 5, "frontWall", {}, 1.5, 0, 1)
	buildFlat(8, 0, 8, 0, 8, 7, "frontWall", {}, 1.5, 1, 0)
	buildFlat(0, 0, 0, 16, 6.5, 5, "frontWall", {}, 1.5, 0, 1)
	buildFlat(8, 0, 8, 0, 6.5, 7, "frontWall", {}, 1.5, 1, 0)
	buildFlat(0, 17, 16, 17, 8, 7, "backWall")
	buildFlat(17, 0, 17, 16, 8, 5, "backWall")
	buildFlat(0, 0, 16, 16, 8, 3, "floor")
	buildBlock(0, 0, 6, 3, 3, 8, 1, "object")
	addObject(9, 8, 8, 1, "object", {}, 1, 1, 1)
	addObject(9, 9, 8, 1, "object", {}, 1, 1, 1)
	addObject(8, 9, 8, 1, "object", {}, 1, 1, 1)
	addObject(9, 8, 9, 1, "object", {}, 1, 1, 1)
end
