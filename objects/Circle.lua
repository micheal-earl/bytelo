Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/GameObject'

Circle = GameObject:extend()

function Circle:new(area, x, y, radius, opts)
  Circle.super.new(self, area, x, y, opts)
  self.radius = radius or 100
  self.creation_time = 0
end

function Circle:update(dt)
  
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end