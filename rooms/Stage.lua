Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
  self.area:addPhysicsWorld()

  -- spawn our self.player and set him to a variable for easy access
  self.player = self.area:addGameObject('Player', window_width/2, window_height/2)
end

function Stage:update(dt)
  -- call the update function from our area
  self.area:update(dt)

  -- delete the last object added to the stage
  if input:pressed('f4') then
    self.area.game_objects[#self.area.game_objects].dead = true
  end

  -- manually spawn an enemy with mouse2
  if input:pressed('mouse2') then
    local x, y = love.mouse.getPosition()
    self.area:addGameObject('Enemy', x, y)
  end

  -- make sure self.player stays within the screens dimensions
  if self.player:isOutOfBounds() then
    self.player.x = window_width/2
    self.player.y = window_height/2
  end
end

function Stage:draw()
  self.area:draw()
  love.graphics.setColor(1, 1, 1, 0.8)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 1300, 10)
end

function Stage:destroy()
  self.area:destroy()
  self.area = nil
end