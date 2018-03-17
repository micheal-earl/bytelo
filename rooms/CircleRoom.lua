Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'

CircleRoom = Object:extend()

function CircleRoom:new(x, y, radius)
  self.x = x or 400
  self.y = y or 300
  self.radius = radius or 100
  self.creation_time = 0
end

function CircleRoom:update(dt)
  
end

function CircleRoom:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end