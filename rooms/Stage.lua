Object = require '../lib/classic/classic'

Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
  self.area:addPhysicsWorld()

  -- spawn our player and set him to a variable for easy access
  player = self.area:addGameObject('Player', window_width/2, window_height/2)
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

  -- manually spawn an upgrade with u
  if input:pressed('u') then
    local x, y = love.mouse.getPosition()
    self.area:addGameObject('Upgrade', x, y)
  end

  -- make sure player stays within the screens dimensions
  if player:outOfBounds() then
    player.x = window_width/2
    player.y = window_height/2
  end

  -- spawn an enemy
  if math.ceil(random(100)) == 101 then
    self.area:addGameObject('Enemy', random(1366), random(768))
  end

  -- spawn an upgrade
  if player.ups < 1 then
    player.ups = player.ups + 1
    self.area:addGameObject('Upgrade', random(100, 1266), random(100, 668))
  end

  local rand = math.ceil(random(100))
  if rand == 1 then
    self.area:addGameObject('Enemy', player.x + random(200, 450), player.y + random(150, 250))
  elseif rand == 2 then
    self.area:addGameObject('Enemy', player.x + random(-200, -450), player.y + random(-150, -250))
  elseif rand == 3 then
    self.area:addGameObject('Enemy', player.x + random(-200, -450), player.y + random(150, 250))
  elseif rand == 4 then
    self.area:addGameObject('Enemy', player.x + random(200, 450), player.y + random(-150, -250))
  end
  --]]
end

function Stage:draw()
  self.area:draw()
  love.graphics.print("WASD or arrow keys to move", 10, 10)
  love.graphics.print("Double tap key to dash", 10, 25)
  love.graphics.print("Mouse1 to shoot", 10, 40)
end