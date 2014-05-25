function love.load()
	require("renderTools")
	require("objectTools")
	require("behaviours")
	require("controls")
	require("states")
  require("myDebug")
  require("collisions")
	screenX = love.graphics.getWidth()
	screenY = love.graphics.getHeight()
	cenX = screenX/2
	cenY = screenY/2
	xLimit = cenX/1.5
	yLimit = cenY/1.5
	xOffset = -130
	yOffset = 136
	love.window.setMode(screenX, screenY)
	timeElapsed = 0
	globalGravity = 10
	map = {}
	objects = {}

  epochTime = 0

	loadTileset()
	genMap()
end

function love.update(dt)
	timeElapsed = dt
  epochTime = epochTime + 1
	checkControls()
--  addDebug("Controls checked")
	runBehaviours()
end

function love.draw()
	genDepthMaps()
	drawObjects()
--	love.graphics.print(tostring(timeElapsed), 100, 0)
--	love.graphics.print(tostring(colNo), 0, 10)
--	love.graphics.print(tostring(colYes), 50, 10)
	debugObjectDetails(testObject)
  printDebug()
end

function genMap()
--[[
	syntax
	addObject(x, y, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
	buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviours, oHeight, xWidth, yWidth, oStates)
--]]

	addObject(8.1, 8.1, 2, 2, "object", {}, 0.8, 0.8, 0.8, {solid = true, facing = "east", gravity = 1, heavy = true, player = true})
	addObject(8, 8, 8, 1, "object", {{bName = "travel", direction = "west", speed = 3}})
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
	addObject(9, 9, 7, 1, "object", {{bName = "bounce", direction = "west", speed = 3}}, 1, 1, 1)
end
