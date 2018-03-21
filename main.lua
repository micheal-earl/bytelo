local Object = require 'lib/classic/classic'
local Input = require 'lib/input/Input'
local Timer = require 'lib/hump/timer'
local Camera = require 'lib/hump/camera'
local Bump = require 'lib/bump/bump'
require 'lib/utils'

require 'objects/GameObject'
require 'objects/Player'
require 'objects/Area'
require 'objects/Circle'
require 'objects/Rect'

require 'rooms/CircleRoom'
require 'rooms/PolyRoom'
require 'rooms/RectRoom'
require 'rooms/Stage'

function love.load(arg) -- take arg for debug
  -- this line enables debugging in zbs
  if arg[#arg] == "-debug" then require("mobdebug").start() end

  -- Randomize our seed so that random functions
  -- Are different every time the game is run
  love.math.setRandomSeed(os.time())
  
  -- instantiate timer lib into variable`
  timer = Timer()
  
  -- instantiate input lib into variable
  input = Input()
  input:bind('f1', 'f1key') -- define our inputs map key -> name
  input:bind('f2', 'f2key')
  input:bind('f3', 'f3key')
  input:bind('f4', 'f4key')
  input:bind('d' ,  'dkey')

  input:bind('up', 'upkey')
  input:bind('down', 'downkey')
  input:bind('left', 'leftkey')
  input:bind('right', 'rightkey')
  
  -- initialize our current room to nil
  current_room = nil
end

function love.update(dt)
  timer:update(dt)
  
  if current_room then current_room:update(dt) end
  
  -- change our current room depengin on f key pressed
  if input:pressed('f1key') then gotoRoom('RectRoom')   end
  if input:pressed('f2key') then gotoRoom('PolyRoom')   end
  if input:pressed('f3key') then gotoRoom('CircleRoom') end
  if input:pressed('f4key') then gotoRoom('Stage')      end

  if input:pressed('dkey') then 
    current_room.area.game_objects[#current_room.area.game_objects].dead = true 
  end
end

function love.draw()
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end