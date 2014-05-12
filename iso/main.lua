function love.load()
	require("renderTools")
	require("objectTools")
	require("behaviours")
	require("controls")
	screenX = love.graphics.getWidth()
	screenY = love.graphics.getHeight()
	cenX = screenX/2
	cenY = screenY/2
	xLimit = cenX/1.5
	yLimit = cenY/1.5
	xOffset = 0
	yOffset = 136
	love.window.setMode(screenX, screenY)
	timeElapsed = 0
	globalGravity = 5
	map = {}
	objects = {}
	debugText = "Test"
	colNo = 0
	colYes = 0
	testObject = 1

	loadTileset()
	genMap()
end

function love.update(dt)
	timeElapsed = dt
	checkControls()
	runBehaviours()
end

function love.draw()
	genDepthMaps()
	drawObjects()
--	love.graphics.print(tostring(timeElapsed), 100, 0)
--	love.graphics.print(tostring(colNo), 0, 10)
--	love.graphics.print(tostring(colYes), 50, 10)
	love.graphics.print(debugText, 0, 0)
	debugObjectDetails(testObject)
end

function genMap()
--[[	
	syntax
	addObject(x, y, z, tileID, oType, oBehaviour, height, xWidth, yWidth)
	buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviour, height, xWidth, yWidth)
	buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviour, height, xWidth, yWidth)
--]]
	
	addObject(8.1, 8.1, 2, 2, "object", {{bName = "player"}, {bName = "sMove", direction = "down", speed = "3"}, {bName = "solid"}, {bName = "facing", direction = "south"}}, 0.8, 0.8, 0.8)
	addObject(8, 8, 8, 1, "object", {{bName = "sMove", direction = "south", speed = "3"}})
--	addObject(8, 8, 8, 1, "object", {})
	buildFlat(0, 0, 0, 16, 8, 5, "frontWall")
	buildFlat(8, 0, 8, 0, 8, 7, "frontWall", {}, 1.5, 1, 0)
	buildFlat(0, 17, 16, 17, 8, 7, "backWall")
	buildFlat(17, 0, 17, 16, 8, 5, "backWall")
	buildFlat(0, 0, 16, 16, 8, 3, "floor")
	buildBlock(0, 0, 6, 3, 3, 8, 1, "object")
	addObject(9, 8, 8, 1, "object", {}, 1, 1, 1)
	addObject(9, 9, 8, 1, "object", {}, 1, 1, 1)
	addObject(8, 9, 8, 1, "object", {}, 1, 1, 1)
	addObject(9, 8, 9, 1, "object", {}, 1, 1, 1)
	addObject(9, 9, 7, 1, "object", {}, 1, 1, 1)
end