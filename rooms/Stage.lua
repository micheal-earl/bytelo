local Object = require '../lib/classic/classic'
local Input = require '../lib/input/Input'
local Timer = require '../lib/hump/timer'
require '../objects/Area'

Stage = Object:extend()

function Stage:new()
  self.input = Input()
  self.area = Area(self)
  self.area:addGameObject('Player', window_width/2, window_height/2)
end

function Stage:update(dt)

end

function Stage:draw()
  self.area:draw()
end