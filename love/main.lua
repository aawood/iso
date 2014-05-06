function love.load()
	screenx = 1200
	screeny = 600
	love.graphics.setMode(screenx, screeny, false, true, 0)
	x = 10
	dir1 = 100
	y = 60
	dir2 = 100
	maxx = love.graphics.getWidth()
	maxy = love.graphics.getHeight()
end

function love.draw()
	love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", x, y, maxx-2*x, maxy-2*y)
	love.graphics.setColor(0, 128, 0)
    love.graphics.print(x, 0, 0)
    love.graphics.print(y, 0, 16)
    love.graphics.print(dir1, 64, 0)
    love.graphics.print(dir2, 64, 16)
    love.graphics.print(maxx, 128, 0)
    love.graphics.print(maxy, 128, 16)
end

function love.update(dt)
	if (x >= 110 and dir1 == 100) then dir1 = -100 end
	if (x <= 10 and dir1 == -100) then dir1 = 100 end
	if (y >= 110 and dir2 == 100) then dir2 = -100 end
	if (y <= 10 and dir2 == -100) then dir2 = 100 end
	x = x + dt*dir1
	y = y + dt*dir2
	
end