local Object = require '../lib/classic/classic'

Rect = GameObject:extend()

function Rect:new(area, x, y, opts, width, height)
  Rect.super.new(self, area, x, y, opts)
  self.opts = opts or {100, 100}
  self.width = width or opts[1]
  self.height = height or opts[2]
end

function Rect:update(dt)

end

function Rect:draw()
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
