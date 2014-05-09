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
	yOffset = 120
--	love.window.setMode(screenX, screenY, {fullscreen=false, vsync=true, fsaa=0})
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
end

function love.draw()
	genDepthMaps()
	drawObjects()
	testThis()
	love.graphics.print(tostring(timeElapsed), 1, 1)
end

function testThis()
end

function genMap()
	addObject(0, 0, 0)
	addObject(16, 0, 0)
	addObject(0, 16, 0)
	addObject(16, 16, 0)
	addObject(0, 0, 16)
	addObject(16, 0, 16)
	addObject(0, 16, 16)
	addObject(16, 16, 16)
	addObject(8, 8, 8)
	addObject(9, 8, 8)
	addObject(9, 9, 8)
	addObject(8, 9, 8)
end