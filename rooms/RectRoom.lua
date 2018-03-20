Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
require '../objects/Area'
require '../objects/Circle'

RectRoom = Object:extend()

function RectRoom:new()
  self.timer = Timer()
  self.area = Area(self)

  self:addObjects()
end

function RectRoom:update(dt)
  self.timer:update(dt)
  self.area:update(dt)
  if #self.area.game_objects < 1 then
    self:addObjects()
  end
end

function RectRoom:draw()
  self.area:draw()
end

function RectRoom:addObjects()
  for i = 1, 10 do
    self.area:addGameObject('Rect', 
                            love.math.random(800), 
                            love.math.random(600), 
                            love.math.random(600), 
                            love.math.random(600))
  end
end