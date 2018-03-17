Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

Stage = Object:extend()

function Stage:new()
  timer = Timer();
  area = Area(self)
  area:addGameObject('Circle', 400, 300, 50)
  
  timer:after(0, function(f)
    area.game_objects[1].dead = true
    area:addGameObject('Circle', love.math.random(0, 650), 
                                 love.math.random(0, 450), 50)
    timer:after(love.math.random(4), f) -- recursively call the anonymous function
  end)
end

function Stage:update(dt)
  timer:update(dt)
  area:update(dt)
end

function Stage:draw()
  area:draw()
end