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

	loadTileset()
	genMap()
end

function love.update(dt)
	timeElapsed = dt
end

function love.draw()
	genZMap()
	drawMap()
	testThis()
end

function testThis()
end

function genMap()
	addObjectToMap(0, 0, 0)
	addObjectToMap(16, 0, 0)
	addObjectToMap(0, 16, 0)
	addObjectToMap(16, 16, 0)
	addObjectToMap(0, 0, 16)
	addObjectToMap(16, 0, 16)
	addObjectToMap(0, 16, 16)
	addObjectToMap(16, 16, 16)
	addObjectToMap(8, 8, 8)
	addObjectToMap(9, 8, 8)
	addObjectToMap(9, 9, 8)
	addObjectToMap(8, 9, 8)
end