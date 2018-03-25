local Object = require '../lib/classic/classic'

Upgrade = GameObject:extend()

function Upgrade:new(area, x, y, opts, radius)
  Upgrade.super.new(self, area, x, y, opts)
  self.opts = opts or {}
  self.radius = radius or opts[1] or 12

end

function Upgrade:update(dt)
  Upgrade.super.update(self, dt)

end

function Upgrade:draw()
  love.graphics.setColor(255, 223, 0)
  love.graphics.circle('fill', self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255)
end
