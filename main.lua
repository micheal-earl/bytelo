local Object = require 'lib/classic/classic'
local Input = require 'lib/input/input'
local Timer = require 'lib/hump/timer'
local Camera = require 'lib/hump/camera'
local Bump = require 'lib/bump/bump'

require "init"

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
  input:bind('up', 'upkey')
  input:bind('down', 'downkey')
  input:bind('left', 'leftkey')
  input:bind('right', 'rightkey')
  
  -- initialize our current room to nil
  current_room = nil
  gotoRoom('Stage')
end

function love.update(dt)
  timer:update(dt)
  if current_room then current_room:update(dt) end
end

function love.draw()
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end
