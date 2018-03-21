local Object = require '../lib/classic/classic'
local Timer = require '../lib/hump/timer'
require '../lib/utils'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)
end

function Player:update(dt)
  Player.super.update(self, dt)
end

function Player:draw()
  love.graphics.circle('line', self.x, self.y, 25)
end