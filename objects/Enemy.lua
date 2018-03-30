local Object = require '../lib/classic/classic'

Enemy = GameObject:extend()

function Enemy:new(area, x, y, opts)
  Enemy.super.new(self, area, x, y, opts)
  self.speed = opts[1] or 1
  self.width = opts[2] or 34
  self.height = opts[3] or 34

  self.vx, self.vy = 20, 20
  self.goalX, self.goalY = self.x, self.y

  -- test stuffdw

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Enemy:update(dt)
  Enemy.super.update(self, dt)

  -- pathfinding
  self:moveEnemy(self.target_player.dead, dt)
end

function Enemy:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(255, 0, 0, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end

-- **TODO** Figure out the clusterfuck that is collision
function Enemy:moveEnemy(player_dead, dt)
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

  if not self.dead then
    local actualX, actualY, cols, len = self.area.world:move(
      self.collider, 
      self.goalX, 
      self.goalY,
      filter
    )
    self.x, self.y = actualX, actualY

    for i = 1, len do
      print('enemy collide ' .. tostring(cols[i].other.class))
      obj = cols[i].other
      if obj.class == "player_bullet" then 
        self.dead = true 
        self.target_player.score = self.target_player.score + 1
        self.area:addGameObject('Notify', self.x - 100, self.y - 50, {"+1", 20, 5, 0.4})
      end
      if obj.class == "Player" then obj.dead = true end
    end
  end
end
