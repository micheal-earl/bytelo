Enemy = GameObject:extend()

function Enemy:new(area, x, y, opts)
  Enemy.super.new(self, area, x, y, opts)
  self.speed = opts[1] or 1
  self.width = opts[2] or 40
  self.height = opts[3] or 40

  self.vx, self.vy = 20, 20
  self.goalX, self.goalY = self.x, self.y

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Enemy:update(dt)
  Enemy.super.update(self, dt)
  self:moveEnemy(dt)
end

function Enemy:draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(1, 0, 0, 0.2)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, self.width - 1, self.height - 1)
  love.graphics.setColor(1, 1, 1)
end

function Enemy:destroy()
  Enemy.super.destroy(self)
end

-- **TODO** Figure out the clusterfuck that is collision
function Enemy:moveEnemy(dt)
  if self.target_player then
    if self.target_player.x + 10 > self.x + offsetX then
      self.goalX = self.goalX + self.speed
    elseif self.target_player.x + 10 < self.x + offsetX then
      self.goalX = self.goalX - self.speed
    end
    if self.target_player.y + 10 > self.y + offsetY then
      self.goalY = self.goalY + self.speed
    elseif self.target_player.y + 10 < self.y + offsetY then
      self.goalY = self.goalY - self.speed
    end
  end

  local function filter(item, other)
    if other.class == "player_bullet" then return "cross" end
    if other.class == "Upgrade" then return "cross" end
    return "slide"
  end

  if not self.dead and self.target_player then
    local actualX, actualY, cols, len = self.area.world:move(
      self.collider, 
      self.goalX, 
      self.goalY,
      filter
    )
    self.x, self.y = actualX, actualY

    for i = 1, len do
      obj = cols[i].other
      if obj.class == "player_bullet" then 
        self:destroy()
      end
      if obj.class == "Player" then 
        obj:destroy()
      end
    end
  end
end