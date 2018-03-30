local Object = require '../lib/classic/classic'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, 20, 20)

  -- shape
  self.width = 20
  self.height = 20

  -- movement stuff
  self.vx, self.vy = 0, 0
  self.speed = 300
  self.decay = 60

  -- gun stuff
  self.bullet_amt = 1
  self.fire_rate = 0.4
  self.ups = 0

  -- test stuff
  offsetX = self.width/2
  offsetY = self.height/2

  -- maybe handle this in stage, idk
  self.score = 0
end

function Player:update(dt)
  Player.super.update(self, dt)
  if not self.dead then self:handleInput(dt) end
end

function Player:draw()
  love.graphics.setColor(0, 255, 255)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  -- draw inside
  love.graphics.setColor(0, 255, 255, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end

-----------------------------------------------------
function Player:handleInput(dt)
  local goalX, goalY = self.x + self.vx * dt, self.y + self.vy * dt
  local actualX, actualY, cols, len = self.area.world:move(self, goalX, goalY)
  self.x, self.y = actualX, actualY

  if input:down('mouse1', self.fire_rate) then
    --if self.fire_rate < 0.05 then self.fire_rate = 0.05 end
    local x, y = love.mouse.getPosition()
    print(self.fire_rate)
    -- this if statement makes sure we cannot just hold mouse1
    -- in the middle of the player object and spray the entire
    -- screen with bullets.
    if(distance(x, y, self.x + offsetX, self.y + offsetY)) > 30 then
      for i = 1, self.bullet_amt do
        self.area:addGameObject('Bullet', self.x + 5, self.y + 5, 
        {6, 6, x, y, 800}, 'player_bullet')
      end
    end
  end

	if input:down('up') then 
		self.vy = -self.speed
	elseif input:down('down') then 
		self.vy = self.speed
	elseif(self.vy < 0) then
		self.vy = self.vy + self.decay
	elseif(self.vy > 0) then
		self.vy = self.vy - self.decay
	end

	if input:down('left') then 
		self.vx = -self.speed
	elseif input:down('right') then 
		self.vx = self.speed
	elseif(self.vx < 0) then
		self.vx = self.vx + self.decay
	elseif(self.vx > 0) then
		self.vx = self.vx - self.decay
  end

  for i = 1, len do
		print('collide ' .. tostring(cols[i].other))
	end
end

function Player:outOfBounds()
  if self.y > window_height or self.y < 0 then
    return true
  elseif self.x > window_width or self.x < 0 then
    return true
  else
    return false
  end
end

function Player:killPlayer()
  print("wow")
  self.x = 5000
  self.y = 5000
  timer:after(3, function() 
    self.x = window_width/2
    self.y = window_height/2
  end)
end
