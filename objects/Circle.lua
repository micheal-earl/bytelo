Object = require '../lib/classic/classic'

Circle = Object:extend()

function Circle:new(x, y, radius, creation_time)
  self.x = x or 0
  self.y = y or 0
  self.radius = radius or 10
  self.creation_time = creation_time or 0
end

function Circle:update(dt)
  
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end
