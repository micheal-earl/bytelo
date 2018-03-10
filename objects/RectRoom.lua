Object = require '../lib/classic/classic'

RectRoom = Object:extend()

function RectRoom:new(x, y, width, height)
  self.x = x or 400
  self.y = y or 300
  self.width = width or 150
  self.height = height or 150
  self.creation_time = 0
end

function RectRoom:update(dt)
  
end

function RectRoom:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end