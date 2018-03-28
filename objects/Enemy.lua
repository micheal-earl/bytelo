local Object = require '../lib/classic/classic'

Enemy = GameObject:extend()

function Enemy:new(area, x, y, opts)
  Enemy.super.new(self, area, x, y, opts)
  self.speed = 2

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Enemy:update(dt)
  Enemy.super.update(self, dt)
  --self.area.world:update(self.collider, self.x, self.y)

  -- call pathfinding function
  self:findPlayer(player.dead)

  if #self.area:queryCircleArea(self.x, self.y, 40, {'player_bullet'}) > 0 then
    self.dead = true
    player.score = player.score + 1
  end

  -- **TODO** remove fake collision code and use real code instead
  if #self.area:queryCircleArea(self.x, self.y, 40, {'Player'}) > 0 then
    player.dead = true
  end
end

function Enemy:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle('fill', self.x, self.y, 20)
  love.graphics.setColor(255, 255, 255)
end

-- **TODO** Fix this to make is more fluid, maybe use vector math
function Enemy:findPlayer(player_dead)
  if not player_dead then
    if self.target_player then
      if self.target_player.x > self.x then
        self.x = self.x + self.speed
      elseif self.target_player.x < self.x then
        self.x = self.x - self.speed
      end
      if self.target_player.y > self.y then
        self.y = self.y + self.speed
      elseif self.target_player.y < self. y then
        self.y = self.y - self.speed
      end
    end
  end
end
