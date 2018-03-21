local Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer'
require '../objects/GameObject'

Rect = GameObject:extend()

function Rect:new(area, x, y, width, height, opts)
  Rect.super.new(self, area, x, y, opts)
  self.width = width or 100
  self.height = height or 100
  self.creation_time = 0
end

function Rect:update(dt)
  Rect.super.update(self, dt)
end

function Rect:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end