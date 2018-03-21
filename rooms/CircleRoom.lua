local Object = require '../lib/classic/classic'
local Timer = require '../lib/hump/timer'
require '../objects/Area'
require '../objects/Circle'

CircleRoom = Object:extend()

function CircleRoom:new()
  self.timer = Timer();
  self.area = Area(self)
  
  self.timer:after(0, function(f)
    --self.area.game_objects[1].dead = true
    self.area:addGameObject('Circle', love.math.random(window_width), 
                                      love.math.random(window_height), 
                                      50)
    self.timer:after(random(0, 4), f) -- recursively call the anonymous function
  end)
end

function CircleRoom:update(dt)
  self.timer:update(dt)
  self.area:update(dt)
end

function CircleRoom:draw()
  self.area:draw()
end