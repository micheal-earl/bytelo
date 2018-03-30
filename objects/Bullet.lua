local Object = require '../lib/classic/classic'

Bullet = GameObject:extend()

function Bullet:new(area, x, y, opts)
  Bullet.super.new(self, area, x, y, opts)
  self.opts = opts or {100, 0, 0, 0}


  self.width = opts[1] or 8
  self.height = opts[2] or 8

  -- vector math
  self.goalX = opts[3] or 0
  self.goalY = opts[4] or 0

  self.bullet_speed = opts[5] or 100

  self.angle = math.atan2((self.goalX - self.x), (self.goalY - self.y))
  self.dx = self.bullet_speed * math.sin(self.angle)
  self.dy = self.bullet_speed * math.cos(self.angle)

  self.x = self.x + self.width/2 + math.sin(self.angle) * 25
  self.y = self.y + self.height/2 + math.cos(self.angle) * 25

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

end

function Bullet:update(dt)
  Bullet.super.update(self, dt)
  
  if((self.x > 1366 or self.x < 0) or (self.y > 768 or self.y < 0)) then
    self.dead = true
  end

  local function filter(item, other)
    --if other.class == "Bullet" then return "cross" end
    return "cross"
  end

  if not self.dead then
    local actualX, actualY, cols, len = self.area.world:move(
      self.collider, 
      self.x + self.dx * dt, 
      self.y + self.dy * dt,
      filter
    )
    self.x = actualX
    self.y = actualY
  end

  --[[
  self.x = self.x + (self.dx * dt)
  self.y = self.y + (self.dy * dt)
  --]]
end

function Bullet:draw()
  --if self.class == 'player_bullet' then love.graphics.setColor(0, 255, 0) end
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(255, 255, 255, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end