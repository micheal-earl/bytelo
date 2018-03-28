local Object = require '../lib/classic/classic'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)
  self.collider = self.area.world:add(self, self.x, self.y, 13, 13)
  self.bullet_amt = 1
  self.fire_rate = 0.3
  self.ups = 0
  self.score = 0
end

function Player:update(dt)
  Player.super.update(self, dt)
  self:handleInput(dt)
  self.area.world:update(self.collider, self.x, self.y)
end

function Player:draw()
  love.graphics.setColor(0, 255, 255)
  love.graphics.circle('fill', self.x, self.y, 15)
  love.graphics.setColor(255, 255, 255)
end

function Player:handleInput(dt)
  local spd = 4
  local dash_spd = 0.1

  if input:down('mouse1', self.fire_rate) then
    local x, y = love.mouse.getPosition()
    print(self.fire_rate)

    -- this if statement makes sure we cannot just hold mouse1
    -- in the middle of the player object and spray the entire
    -- screen with bullets.
    if(distance(x, y, self.x, self.y)) > 30 then
      for i = 1, self.bullet_amt do
        self.area:addGameObject('Bullet', self.x, self.y, 
        {4, x + random(-10, 10), y + random(-10, 10), random(600, 800)}, 'player_bullet')
      end
    end
  end

  if input:down('up') then 
    self.y = self.y - spd
  end
  if input:down('down') then 
    self.y = self.y + spd 
  end
  if input:down('left') then 
    self.x = self.x - spd 
  end
  if input:down('right') then 
    self.x = self.x + spd 
  end

  -- There is something wrong with the input libs sequence function
  --[[
  if input:sequence('up', 0.3, 'up') then
    local t = self.y
    timer:tween(dash_spd, self, {y = t - 100})
  end
  if input:sequence('down', 0.3, 'down') then
    local t = self.y
    timer:tween(dash_spd, self, {y = t + 100})
  end
  if input:sequence('left', 0.3, 'left') then
    local t = self.x
    timer:tween(dash_spd, self, {x = t - 100})
  end
  if input:sequence('right', 0.3, 'right') then
    local t = self.x
    timer:tween(dash_spd, self, {x = t + 100})
  end
  --]]
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
