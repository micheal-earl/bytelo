local Object = require '../lib/classic/classic'

Upgrade = GameObject:extend()

function Upgrade:new(area, x, y, opts, radius)
  Upgrade.super.new(self, area, x, y, opts)
  self.opts = opts or {}
  self.radius = radius or opts[1] or 12

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Upgrade:update(dt)
  Upgrade.super.update(self, dt)

  if #self.area:queryCircleArea(self.x, self.y, 30, {'Player'}) > 0 then
    print("player present")
    self.target_player.ups = self.target_player.ups - 1
    self.target_player.bullet_amt = self.target_player.bullet_amt + 1
    if self.target_player.fire_rate > 0.1 then 
      self.target_player.fire_rate = self.target_player.fire_rate - 0.025 
    end
    self.dead = true
  end
end

function Upgrade:draw()
  love.graphics.setColor(255, 223, 0)
  love.graphics.circle('fill', self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255)
end
