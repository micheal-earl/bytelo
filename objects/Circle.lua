Object = require '../lib/classic/classic'

-- Circle class defines circle properties and draws circle
Circle = Object:extend()

function Circle:new(x, y, radius)
  self.x = x or 0
  self.y = y or 0
  self.radius = radius or 10
  self.creation_time = 0
end

function Circle:update(dt)
  
end

function Circle:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

-- HyperCircle class extends Circle
HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, outer_radius, line_width)
  HyperCircle.super.new(self, x, y, radius)
  self.line_width = line_width
  self.outer_radius = outer_radius
end

function HyperCircle:draw()
  love.graphics.setLineWidth(self.line_width)
  love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.circle("line", self.x, self.y, self.outer_radius)
end

