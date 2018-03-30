local Object = require '../lib/classic/classic'

Enemy = GameObject:extend()

function Enemy:new(area, x, y, opts)
  Enemy.super.new(self, area, x, y, opts)
  self.width = opts[1] or 34
  self.height = opts[2] or 34

  self.vx, self.vy = 20, 20

  -- test stuff
  offsetX = self.width/2
  offsetY = self.height/2

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Enemy:update(dt)
  Enemy.super.update(self, dt)

  if not self.dead and #self.area:queryCircleArea(self.x + offsetX, self.y + offsetY, 40, {'player_bullet'}) > 0 then
    --self.area.world:remove(self.collider)
    self.dead = true
    player.score = player.score + 1
  end

  -- **TODO** remove fake collision code and use real code instead
  --
  if not self.dead and  #self.area:queryCircleArea(self.x, self.y, 40, {'Player'}) > 0 then
    player.dead = true
  end
  --]]

  -- pathfinding
  self:moveEnemy(player.dead, dt)
end

function Enemy:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(255, 0, 0, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end

-- **TODO** Fix this to make is more fluid, maybe use vector math
function Enemy:moveEnemy(player_dead, dt)
  --[[
  local goalX, goalY = self.target_player.x + self.vx * dt, self.target_player.y + self.vy * dt
  local actualX, actualY, cols, len = self.area.world:move(self.collider, goalX, goalY)
  self.x, self.y = actualX, actualY
  --]]


  if not player_dead and not self.dead then
    if self.target_player then
      if self.target_player.x + 10 > self.x + offsetX then
        local actualX, actualY, cols, len = self.area.world:move(self.collider, self.x + 1, self.y)
        self.x = actualX
      elseif self.target_player.x + 10 < self.x + offsetX then
        local actualX, actualY, cols, len = self.area.world:move(self.collider, self.x - 1, self.y)
        self.x = actualX
      end
      if self.target_player.y + 10 > self.y + offsetY then
        local actualX, actualY, cols, len = self.area.world:move(self.collider, self.x, self.y + 1)
        self.y = actualY
      elseif self.target_player.y + 10 < self.y + offsetY then
        local actualX, actualY, cols, len = self.area.world:move(self.collider, self.x, self.y - 1)
        self.y = actualY
      end
    end
  end
end
