Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'

Stage = Object:extend()

function Stage:new()
  self.area = Area(self)
end

function Stage:update(dt)

end

function Stage:draw()
  love.graphics.circle('line', window_width/2, window_height/2, 50)
  self.area:draw()
end