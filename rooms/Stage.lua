Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
  self.area:addPhysicsWorld()

  self.area:addGameObject('Wall', -500, -800, {w=2400,h=1000})
  self.area:addGameObject('Wall', -500, 0, {w=1000,h=1400})
  self.area:addGameObject('Wall', -500, 1200, {w=2600,h=1000})
  self.area:addGameObject('Wall', 2000, -800, {w=1400,h=2600})

  -- spawn our self.player and set him to a variable for easy access
  self.player = self.area:addGameObject('Player', window_width/2, window_height/2)

  self.camera = Camera(self.player.x, self.player.y)
end

function Stage:update(dt)
  -- call the update function from our area
  self.area:update(dt)

  -- **TODO** fix coordinate system
  local dx, dy = self.player.x - self.camera.x, self.player.y - self.camera.y
  self.camera:move(dx/2, dy/2) -- /3 determines camera "stickiness"
  --print(self.camera.x.." "..self.camera.y)

  -- delete the last object added to the stage
  if input:pressed('f4') then
    self.player:destroy()
    --self.area.game_objects[#self.area.game_objects].dead = true
  end

  -- manually spawn an enemy with mouse2
  if input:pressed('mouse2') then
    local x, y = self.camera:mousePosition()
    self.area:addGameObject('Enemy', x, y)
  end

  -- **TODO** remove or repurpose out of bounds code
  -- make sure self.player stays within the screens dimensions
  if self.player:isOutOfBounds() then
    --print("oob")
    --self.player.x = window_width/2
    --self.player.y = window_height/2
  end

  self:spawnEnemy()
end

function Stage:draw()
  self.camera:attach() -- camera attach/detach must be in draw function
  self.area:draw()
  love.graphics.setColor(1, 0, 1)
  --love.graphics.print("FPS: " .. love.timer.getFPS(), self.camera:worldCoords(1366/2, 20))
  love.graphics.setColor(0.6, 0.6, 0.6)
  self.camera:detach()
end

function Stage:destroy()
  self.area:destroy()
  self.area = nil
end

function Stage:spawnEnemy()
  local rand = love.math.random(400)
  if rand == 1 then
    self.area:addGameObject(
      'Enemy', 
      self.player.x + random(200, 450), 
      self.player.y + random(250, 350)
    )
  elseif rand == 2 then
    self.area:addGameObject(
      'Enemy', 
      self.player.x + random(-200, -450), 
      self.player.y + random(-250, -350)
    )
  elseif rand == 3 then
    self.area:addGameObject(
      'Enemy', 
      self.player.x + random(-200, -450), 
      self.player.y + random(250, 350)
    )
  elseif rand == 4 then
    self.area:addGameObject(
      'Enemy', 
      self.player.x + random(200, 450), 
      self.player.y + random(-250, -350)
    )
  end

end
