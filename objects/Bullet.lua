local Object = require '../lib/classic/classic'

Bullet = GameObject:extend()

function Bullet:new(area, x, y, opts, radius, bullet_speed)
  Bullet.super.new(self, area, x, y, opts)
  self.opts = opts or {100, 0, 0, 0}
  self.radius = radius or opts[1]

  self.tx = opts[2] or 0
  self.ty = opts[3] or 0

  self.bullet_speed = bullet_speed or opts[4]

  self.angle = math.atan2((self.tx - self.x), (self.ty - self.y))
  self.dx = self.bullet_speed * math.sin(self.angle)
  self.dy = self.bullet_speed * math.cos(self.angle)
end

function Bullet:update(dt)
  Bullet.super.update(self, dt)
  if((self.x > 1366 or self.x < 0) or (self.y > 768 or self.y < 0)) then
    self.dead = true
  end

  self.x = self.x + (self.dx * dt)
  self.y = self.y + (self.dy * dt)

  -- **TODO** remove this fake collision code
  if self.class == 'Bullet' or self.class == 'Bullet2' then
    if #self.area:queryCircleArea(self.x, self.y, 30, {'Bullet'}) > 0 then
      if self.class ~= 'Bullet' then
        print("what~~~~!!!!!!!")
        self.dead = true
      end
    else
      print("no~~~~~~")
    end
    if #self.area:queryCircleArea(self.x, self.y, 30, {'Bullet2'}) > 0 then
      if self.class ~= 'Bullet2' then
        print("what~~~~!!!!!!!")
        self.dead = true
      end
    else
      print("no~~~~~~")
    end
  end

  if self.class == 'Bullet2' then
    local rand = math.ceil(random(500))
    if rand == 1 then
      self.area:addGameObject('Bullet', self.x, self.y, {6, random(1366), random(768), 150}, 'Bullet3')
    end
  end
end

function Bullet:draw()
  if self.class == 'Bullet' then love.graphics.setColor(0, 255, 0) end
  if self.class == 'Bullet2' then love.graphics.setColor(255, 0, 0) end
  if self.class == 'Bullet3' then love.graphics.setColor(255, 100, 0) end
  love.graphics.circle('fill', self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255)
end
