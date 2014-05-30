function love.load()
	require("renderTools")
	require("objectTools")
	require("behaviours")
	require("controls")
	require("states")
  require("myDebug")
  require("collisions")
  require("levelGen")
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
