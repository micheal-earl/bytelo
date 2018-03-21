Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer'
require '../lib/utils'

GameObject = Object:extend()

function GameObject:new(area, x, y, opts)
  local opts = opts or {}
  
  -- Add everything in opts (optional args) to our object as a table
  if opts then for k, v in pairs(opts) do self[k] = v end end
  
  self.area = area
  self.x, self.y = x, y
  self.id = UUID()
  self.dead = false
  self.Timer = Timer()
end

function GameObject:update(dt)
  if self.timer then self.timer:update(dt) end
end

function GameObject:draw()

end