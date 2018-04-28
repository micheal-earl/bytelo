ExplodeParticle = GameObject:extend()

function ExplodeParticle:new(area, x, y, opts)
  ExplodeParticle.super.new(self, area, x, y, opts)

  self.x = self.x + random(-12, 12)
  self.y = self.y + random(-12, 12)
  self.color = opts.color or {1, 1, 1}
  self.r = random(0, 2*math.pi)
  self.s = opts.s or random(1, 3)
  self.v = opts.v or random(50, 200)
  self.line_width = 3
  self.timer:tween(
    opts.d or random(0.1, 0.5), 
    self, 
    {x = self.x + random(-30, 30), y = self.y + random(-30, 30), s = 0, v = self.v+1, line_width = 0}, 
    'linear',
    function() 
      self.dead = true 
    end
  )
end

function ExplodeParticle:update(dt)
  ExplodeParticle.super.update(self, dt)

end

function ExplodeParticle:draw()
  pushRotate(self.x, self.y, self.r)
  love.graphics.setLineWidth(self.line_width)
  love.graphics.setColor(self.color)
  love.graphics.line(self.x - self.s, self.y, self.x + self.s, self.y)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(1)
  love.graphics.pop()
end
