local Object = require '../lib/classic/classic'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)
  self.collider = self.area.world:add(self, self.x, self.y, 13, 13)
end

function Player:update(dt)
  Player.super.update(self, dt)
  self:handleInput(dt)
  self.area.world:update(self.collider, self.x, self.y)
end

function Player:draw()
  love.graphics.circle('fill', self.x, self.y, 15)
end

function Player:handleInput(dt)
  local spd = 4
  local dash_spd = 0.1

  if input:down('mouse1', 1) then
    local x, y = love.mouse.getPosition()
    print(x.." "..y)

    --self.area:addGameObject('Bullet', self.x, self.y, {3, x, y, 500})
    for i = 1, 8 do
      self.area:addGameObject('Bullet', self.x, self.y, {2, x + random(-20, 20), y + random(-20, 20), random(400, 450)})
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
  if input:sequence('up', 0.5, 'up') then
    local t = self.y
    timer:tween(dash_spd, self, {y = t - 140})
  end
  if input:sequence('down', 0.5, 'down') then
    local t = self.y
    timer:tween(dash_spd, self, {y = t + 140})
  end
  if input:sequence('left', 0.5, 'left') then
    local t = self.x
    timer:tween(dash_spd, self, {x = t - 140})
  end
  if input:sequence('right', 0.5, 'right') then
    local t = self.x
    timer:tween(dash_spd, self, {x = t + 140})
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