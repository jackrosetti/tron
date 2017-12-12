local tilesize = 20
local widthRange = (love.graphics.getWidth() / tilesize) - 1
local heightRange = (love.graphics.getHeight() / tilesize) - 1

local player1 = {
	x = widthRange,
	y = heightRange,
	dir = "up",
	trail = {}
}

local player2 = {
	x = 0,
	y = 0,
	dir = "s",
	trail = {}
}

function updateBikes()
	if player1.dir == "right" then
		player1.x = player1.x + 1
	elseif player1.dir == "left" then
		player1.x = player1.x - 1
	elseif player1.dir == "up" then
		player1.y = player1.y - 1
	elseif player1.dir == "down" then
		player1.y = player1.y + 1
	end

	if player2.dir == "d" then
		player2.x = player2.x + 1
	elseif player2.dir == "a" then
		player2.x = player2.x - 1
	elseif player2.dir == "w" then
		player2.y = player2.y - 1
	elseif player2.dir == "s" then
		player2.y = player2.y + 1
	end
end

local timerMax = .11
local timer = timerMax

function love.update(dt)
	if timer > 0 then
		timer = timer - dt
	else
		timer = timerMax
		player1.trail[#player1.trail+1] = {x = player1.x, y = player1.y}
		player2.trail[#player2.trail+1] = {x = player2.x, y = player2.y}
		updateBikes()
	end
	if player2.x == player1.x and player2.y == player1.y then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Game over!", 0, 0)
		love.timer.sleep(1)
		love.event.quit("restart")
	end
	
	for i = 1, #player2.trail do
		local j = player2.trail[i]
		if j.x == player1.x and j.y == player1.y then
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Game over!", 0, 0)
			love.timer.sleep(1)
			love.event.quit('restart')
		end
		if j.x == player2.x and j.y == player2.y then
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Game over!", 0, 0)
			love.timer.sleep(1)
			love.event.quit('restart')
		end
	end

	for i = 1, #player1.trail do
		local p = player1.trail[i]
		if p.x == player2.x and p.y == player2.y then
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Game over!", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
			love.timer.sleep(1)
			love.event.quit('restart')
		end
		if p.x == player1.x and p.y == player1.y then
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Game over!", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
			love.timer.sleep(1)
			love.event.quit('restart') 
		end
	end

	if player1.x < 0 or player2.x < 0 or player2.y < 0 or player1.y < 0 then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Game over!", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
		love.timer.sleep(1)
		love.event.quit("restart")
	end
	if player2.y > heightRange or player1.y > heightRange or player1.x > widthRange or player2.x > widthRange then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("Game over!", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
		love.timer.sleep(1)
		love.event.quit("restart")	end
end

function love.draw()
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", player1.x * tilesize, player1.y * tilesize, tilesize, tilesize)
	for i = 1, #player1.trail do
		local b = player1.trail[i]
		love.graphics.rectangle("line", b.x * tilesize, b.y * tilesize, tilesize, tilesize)
	end
	
	love.graphics.setColor(255, 0, 0)
	for i = 1, #player2.trail do
		local c = player2.trail[i]
		love.graphics.rectangle("line", c.x * tilesize, c.y * tilesize, tilesize, tilesize)
	end
	
	love.graphics.rectangle("fill", player2.x *tilesize, player2.y * tilesize, tilesize, tilesize)
end

function love.keypressed(key)
	if key == "right" or key == "left" or key == "down" or key == "up" then
		player1.dir = key
	end
	if key == "w" or key =="a" or key == "s" or key =="d" then
		player2.dir = key
	end
end
