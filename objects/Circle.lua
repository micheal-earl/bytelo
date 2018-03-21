Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/GameObject'

Circle = GameObject:extend()

function Circle:new(area, x, y, radius, opts)
  Circle.super.new(self, area, x, y, opts)
  self.radius = radius or 100
  self.creation_time = 0

  self.timer = Timer()

  self.timer:after(random(2, 4), function() self.dead = true end)
end

function Circle:update(dt)
  Circle.super.update(self, dt)
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end