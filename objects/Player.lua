local Object = require '../lib/classic/classic'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)
  self.collider = self.area.world:add(self, self.x, self.y, 13, 13)
  self.bullet_amt = 1
  self.fire_rate = 0.3
  self.ups = 0
end

function Player:update(dt)
  Player.super.update(self, dt)
  self:handleInput(dt)
  self.area.world:update(self.collider, self.x, self.y)

  -- **TODO** remove this fake collision code
  if #self.area:queryCircleArea(self.x, self.y, 30, {'Bullet2', 'Bullet3'}) > 0 then
    print("wow")
    self.x = 5000
    self.y = 5000
    timer:after(3, function() 
      self.x = window_width/2
      self.y = window_height/2
    end)
  else
    print("no")
  end
  if #self.area:queryCircleArea(self.x, self.y, 30, {'Upgrade'}) > 0 then
    self.ups = self.ups - 1
    self.bullet_amt = self.bullet_amt + 1
    self.fire_rate = self.fire_rate - 0.05
    for _, game_object in ipairs(self.area.game_objects) do
      if game_object.class == 'Upgrade' then
        game_object.dead = true
      end
    end
  end
  self.area:queryCircleArea(self.x, self.y, 30, {'Upgrade'}).dead = true

  -- **TODO** remove this test code
  -- stuff like this should be handled by Stage, not player
  local rand = math.ceil(random(80))
  if rand == 1 then
    self.area:addGameObject('Bullet', self.x + random(200, 450), self.y + random(150, 250), {20, self.x, self.y, 100}, 'Bullet2')
  elseif rand == 25 then
    self.area:addGameObject('Bullet', self.x + random(-200, -450), self.y + random(-150, -250), {20, self.x, self.y, 100}, 'Bullet2')
  elseif rand == 50 then
    self.area:addGameObject('Bullet', self.x + random(-200, -450), self.y + random(150, 250), {20, self.x, self.y, 100}, 'Bullet2')
  elseif rand == 75 then
    self.area:addGameObject('Bullet', self.x + random(200, 450), self.y + random(-150, -250), {20, self.x, self.y, 100}, 'Bullet2')
  end

  if math.ceil(random(200)) == 1 and self.ups < 1 then
    self.ups = self.ups + 1
    self.area:addGameObject('Upgrade', random(1200), random(700), {12})
  end
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
    print(x.." "..y)
    --self.area:addGameObject('Bullet', self.x, self.y, {3, x, y, 750})
    for i = 1, self.bullet_amt do
      self.area:addGameObject('Bullet', self.x, self.y, {4, x + random(-10, 10), y + random(-10, 10), random(600, 800)})
    end
  end

  if input:pressed('mouse2') then
    local x, y = love.mouse.getPosition()
    self.area:addGameObject('Bullet', x, y, {25, self.x, self.y, 100}, 'Bullet2')
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
  --
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
  -- hacky code
  if self.y >= 4000 then
    return false
  end

  if self.y > window_height or self.y < 0 then
    return true
  elseif self.x > window_width or self.x < 0 then
    return true
  else
    return false
  end
end