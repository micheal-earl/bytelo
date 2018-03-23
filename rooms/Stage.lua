local Object = require '../lib/classic/classic'
local Timer = require '../lib/hump/timer'
local Input = require '../lib/input/Input'
require '../objects/Area'

Stage = Object:extend()

function Stage:new()
  self.input = Input()
  self.input:bind('f', 'fkey')
  self.area = Area(self)
  self.area:addGameObject('Player', window_width/2, window_height/2)

end

function Stage:update(dt)
  self.area:update()
  if self.input:pressed('fkey') then
    self.area.game_objects[1].dead = true
  end
end

function Stage:draw()
  self.area:draw()
end