ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
  ShootEffect.super.new(self, area, x, y, opts)

  self.goalX = opts[1] or self.x
  self.goalY = opts[2] or self.y
  self.w = opts.w or 6
  self.time = opts.time or 0.15

  self.angle = math.atan2((self.goalX - self.x), (self.goalY - self.y))
  self.x = self.x + math.sin(self.angle) * 28
  self.y = self.y + math.cos(self.angle) * 28

  self.timer:tween(
    self.time, 
    self, 
    {w = 0}, 
    'in-out-cubic', 
    function() 
      self.dead = true 
    end
  )
end

function ShootEffect:update(dt)
  ShootEffect.super.update(self, dt)

end

function ShootEffect:draw()
  love.graphics.setColor(0, 1, 1)
  --pushRotate(self.x, self.y, self.angle)
  love.graphics.circle('fill', self.x, self.y, self.w)--, self.w)
  --love.graphics.pop()
end
