Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

RectRoom = Object:extend()

function RectRoom:new()
  timer = Timer()
  area = Area(self)
  
  for i = 1, 10 do
    area:addGameObject('Rect', 
                       love.math.random(800), 
                       love.math.random(600), 
                       love.math.random(400), 
                       love.math.random(400))
  end

end

function RectRoom:update(dt)
  timer:update(dt)
  area:update(dt)
--[[
  if input:pressed('dkey') then 
    --area.gameObjects[#gameObjects].dead = true 
  end]]
end

function RectRoom:draw()
  area:draw()
end