local Object = require '../lib/classic/classic'

Notify = GameObject:extend()

function Notify:new(area, x, y, opts)
  Notify.super.new(self, area, x, y, opts)
  self.notify_text = notify_text or "placeholder"
  self.opts = opts or {"placeholer", 100, 3}
  self.notify_text = opts[1]
  self.font_size = opts[2]
  self.yDecay = opts[3] or 3
  self.time_to_live = opts[4] or 2
  self.align = opts[5] or "left"
  self.alphaDecay = 6
  self.dead = false

  self.alpha = 255

  self.font = love.graphics.newFont(self.font_size)

  timer:after(self.time_to_live, function() self.dead = true end)
end

function Notify:update(dt)
  self.y = self.y - self.yDecay
  self.alpha = self.alpha - self.alphaDecay
end

function Notify:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(255, 255, 255, self.alpha)
  love.graphics.printf(self.notify_text, self.x, self.y, 1300, self.align)
  love.graphics.setFont(default_font)
end
