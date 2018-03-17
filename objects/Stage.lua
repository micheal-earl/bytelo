Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

Stage = Object:extend()

function Stage:new()
  area = Area(self)
  area:addGameObject('Circle', 400, 300, 50)
  area:addGameObject('Circle', 100, 100, 30)
  area:addGameObject('Circle', 700, 500, 30)
  
end

function Stage:update(dt)
  area:update(dt)
end

function Stage:draw()
  area:draw()
end