Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'

PolyRoom = Object:extend()

function PolyRoom:new(x, y, vertices)
  self.x = x or 400
  self.y = y or 300
  self.vertices = vertices or {300, 300, 400, 300, 350, 400}
end

function PolyRoom:update(dt)
  
end

function PolyRoom:draw()
  love.graphics.polygon("fill", self.vertices)
end