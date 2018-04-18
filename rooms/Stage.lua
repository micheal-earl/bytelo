Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
  self.area:addPhysicsWorld()

  -- spawn our self.player and set him to a variable for easy access
  self.player = self.area:addGameObject('Player', window_width/2, window_height/2)

  self.camera = Camera(self.player.x, self.player.y)
  --self.camera:attach()
end

function Stage:update(dt)
  -- call the update function from our area
  self.area:update(dt)

  -- **TODO** fix coordinate system
  local dx, dy = self.player.x - self.camera.x, self.player.y - self.camera.y
  self.camera:move(dx/2, dy/2)
  --print(self.camera.x.." "..self.camera.y)

  -- delete the last object added to the stage
  if input:pressed('f4') then
    self.area.game_objects[#self.area.game_objects].dead = true
  end

  -- manually spawn an enemy with mouse2
  if input:pressed('mouse2') then
    local x, y = self.camera:mousePosition()
    self.area:addGameObject('Enemy', x, y)
  end

  -- make sure self.player stays within the screens dimensions
  if self.player:isOutOfBounds() then
    --print("oob")
    --self.player.x = window_width/2
    --self.player.y = window_height/2
  end
end

function Stage:draw()
  self.camera:attach() -- camera attach/detach must be in draw function
  self.area:draw()
  love.graphics.setColor(1, 1, 1, 0.8)
  love.graphics.print("FPS: " .. love.timer.getFPS(), self.camera:worldCoords(1300, 10))
  love.graphics.print("ANCHOR", 1366/2, 768/2)
  self.camera:detach()
end

function Stage:destroy()
  self.area:destroy()
  self.area = nil
end