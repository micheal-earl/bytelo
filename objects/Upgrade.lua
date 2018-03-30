local Object = require '../lib/classic/classic'

Upgrade = GameObject:extend()

function Upgrade:new(area, x, y, opts)
  Upgrade.super.new(self, area, x, y, opts)
  self.opts = opts or {}
  self.width = opts[1] or 16
  self.height = opts[2] or 16

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, self.width, self.height)

  -- test stuff
  offsetX = self.width/2
  offsetY = self.height/2

  -- **TODO** find a better way to reference player
  self.target_player = self.area:getClosestObject(1366/2, 768/2, 2000, {'Player'})
end

function Upgrade:update(dt)
  Upgrade.super.update(self, dt)

  --[[
  if not self.dead and #self.area:queryCircleArea(self.x, self.y, 20, {'Player'}) > 0 then
    self.target_player.ups = self.target_player.ups - 1
    self.target_player.score = self.target_player.score + 10
    --self.target_player.bullet_amt = self.target_player.bullet_amt + 1
    if self.target_player.fire_rate > 0.06 then 
      self.target_player.fire_rate = self.target_player.fire_rate - 0.05
      self.area:addGameObject('Notify', self.x - 100, self.y - 50, {"Fire rate up!", 30})
    else
      self.area:addGameObject('Notify', self.x - 100, self.y - 50, {"Max fire rate!", 30})
    end
    self.area:addGameObject('Notify', self.x - 50, self.y - 20, {"+10", 20, 5, 0.4})--, 3, "left", 1})
    self.dead = true
  end
  --]]
end

function Upgrade:draw()
  love.graphics.setColor(0, 223, 0)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  love.graphics.setColor(0, 223, 0, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end
