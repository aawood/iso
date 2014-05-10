function love.load()
	require("renderTools")
	require("objectTools")
	require("behaviours")
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
	grav = 0
	map = {}
	objects = {}

	loadTileset()
	genMap()
end

function love.update(dt)
	timeElapsed = dt
	runBehaviours()
end

function love.draw()
	genDepthMaps()
	drawObjects()
end

function genMap()
--[[	
	syntax
	addObject(x, y, z, tileID, oType, oBehaviour)
	buildFlat(x1, y1, x2, y2, z, tileID, oType, oBehaviour)
	buildBlock(x1, y1, z1, x2, y2, z2, tileID, oType, oBehaviour)
--]]
	buildFlat(0, 0, 0, 16, 8, 5, "frontWall")
	buildFlat(0, 0, 16, 0, 8, 7, "frontWall")
	buildFlat(0, 17, 16, 17, 8, 7, "backWall")
	buildFlat(17, 0, 17, 16, 8, 5, "backWall")
--	buildFlat(0, 0, 16, 16, 8, 3, "floor")
	buildBlock(0, 0, 6, 3, 3, 8, 1, "object")
	addObject(8, 8, 3, 2, "object", {{bName = "player"}, {bName = "sMove", direction = "down", speed = "5"}, bName = "solid"})
	addObject(8, 8, 8)
	addObject(9, 8, 8)
	addObject(9, 9, 8)
	addObject(8, 9, 8)
	addObject(9, 8, 9)
	addObject(9, 9, 7)
end