Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

Stage = Object:extend()

function Stage:new()
  area = Area()
  circle = Circle()
  
end

function Stage:update(dt)
  
end

function Stage:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end