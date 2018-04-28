Wall = GameObject:extend()

function Wall:new(area, x, y, opts)
  Wall.super.new(self, area, x, y, opts)

  self.w = opts.w
  self.h = opts.h

  self.area.world:add(self, self.x, self.y, self.w, self.h)

end

function Wall:update(dt)
  Wall.super.update(self, dt)

end

function Wall:draw()
  love.graphics.setColor(0.6, 0.6, 0.6)
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
