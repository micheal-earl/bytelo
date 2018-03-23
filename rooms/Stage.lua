Object = require '../lib/classic/classic'

Stage = Object:extend()

function Stage:new()
  --self.input = Input()
  --self.input:bind('f', 'fkey')
  self.area = Area(self)
  player = self.area:addGameObject('Player', window_width/2, window_height/2)

end

function Stage:update(dt)
  self.area:update()
  if input:pressed('f4') then
    self.area.game_objects[#self.area.game_objects].dead = true
  end
  if player:outOfBounds() then
    player.x = window_width/2
    player.y = window_height/2
  end
end

function Stage:draw()
  self.area:draw()
  love.graphics.print("WASD or arrow keys to move", 10, 10)
  love.graphics.print("Double tap key to dash", 10, 25)
end