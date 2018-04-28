Bullet = GameObject:extend()

function Bullet:new(area, x, y, opts)
  -- **TODO** Fix bullet centering bug, make bullets perform math on center of rectangle instead of on top left corner
  Bullet.super.new(self, area, x, y, opts)

  self.width = opts[1] or 8
  self.height = opts[2] or 8

  -- math
  self.goalX = opts[3] or 0
  self.goalY = opts[4] or 0

  self.bullet_speed = opts[5] or 100

  -- change our angle in radians
  self.angle_modifier = opts[6] or 0

  -- **TODO** bytepath exercise 88, middle bullet originates further ahead needs fix
  self.offset = opts[7] or 0

  self.angle = math.atan2((self.goalX - self.x), (self.goalY - self.y))
  self.angle = self.angle + self.angle_modifier
  self.dx = self.bullet_speed * math.sin(self.angle)
  self.dy = self.bullet_speed * math.cos(self.angle)

  -- the * 28 is the offset from our player. This makes bullets
  -- spawn outside the player object instead of center of player
  self.x = self.x + math.sin(self.angle + self.offset) * 28
  self.y = self.y + math.cos(self.angle + self.offset) * 28

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

  -- destory bullet object after 5 seconds
  self.timer:after(2, function() self:destroy() end)
end

function Bullet:update(dt)
  Bullet.super.update(self, dt)
  
  -- **TODO** destor bullet upon hitting wall or non-enemy
  if((self.x > 1366 or self.x < 0) or (self.y > 768 or self.y < 0)) then
    --self.dead = true
  end

  local function filter(item, other)
    if other.class == "Upgrade" then return "cross" end
    if other.class == "Player" then return "cross" end
    if other.class == "player_bullet" then return "cross" end
    return "touch"
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

    for i = 1, len do
      obj = cols[i].other
      if obj.class == "Enemy" then 
        --self.area:addGameObject('ShootEffect', self.x + 4, self.y + 4)
        self:destroy()
        obj:destroy()
      elseif obj.class == "Wall" then
        self:destroy()
      end
    end
  end
end

function Bullet:draw()
  love.graphics.setColor(0, 1, 1)
  --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.circle('fill', self.x, self.y, self.width - 3)

  love.graphics.setColor(0, 1, 1, 0.2)
  love.graphics.circle('line', self.x, self.y, self.width - 1)
  --love.graphics.rectangle('fill', self.x, self.y, self.width - 1, self.height - 1)


  love.graphics.setColor(1, 1, 1)
end

function Bullet:destroy()
  self.area:addGameObject(
    'ShootEffect', 
    self.x + 4, 
    self.y - 28,
    {self.x, self.y, 16}
  )
  Bullet.super.destroy(self)
end