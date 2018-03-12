Object = require 'lib/classic/classic'
Input = require 'lib/input/Input'
Timer = require 'lib/hump/timer/timer'
require 'objects/CircleRoom'
require 'objects/PolyRoom'
require 'objects/RectRoom'

function love.load()
  -- Randomize our seed so that random functions
  -- Are different every time the game is run
  love.math.randomSeed(os.time())
  
  input = Input()
  input:bind('f1', 'f1')
  input:bind('f2', 'f2')
  input:bind('f3', 'f3')
  
  current_room = nil
  
end

function love.update(dt)
  if current_room then current_room:update(dt) end
  
  if input:pressed('f1') then gotoRoom('RectRoom')   end
  if input:pressed('f2') then gotoRoom('PolyRoom')   end
  if input:pressed('f3') then gotoRoom('CircleRoom') end
end

function love.draw()
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end
