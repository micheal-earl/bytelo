Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

Stage = Object:extend()

function Stage:new()
  self.timer = Timer();
  self.area = Area(self)
  
  self.timer:after(0, function(f)
    --self.area.game_objects[1].dead = true
    self.area:addGameObject('Circle', love.math.random(0, 650), 
                                 love.math.random(0, 450), 50)
    self.timer:after(random(0, 4), f) -- recursively call the anonymous function
  end)
end

function Stage:update(dt)
  self.timer:update(dt)
  self.area:update(dt)
end

function Stage:draw()
  self.area:draw()
end