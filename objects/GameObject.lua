GameObject = Object:extend()

function GameObject:new(area, x, y, opts)
  local opts = opts or {}
  
  -- Add everything in opts (optional args) to our object as a table
  if opts then for k, v in pairs(opts) do self[k] = v end end
  
  self.area = area
  self.x, self.y = x, y
  self.id = UUID()
  self.creation_time = love.timer.getTime()
  self.timer = Timer()
  self.dead = false
end

function GameObject:update(dt)
  if self.timer then self.timer:update(dt) end
end

function GameObject:draw()

end

function GameObject:destroy()
  self.timer = nil
  if self.collider then self.area.world:remove(self) end
  self.collider = nil
  self.dead = true
end