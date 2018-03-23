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

  -- instantiate libs into variables
  timer = Timer()
  camera = Camera()
  physics = Bump
  input = Input()

  -- set up our keybindings
  input:bind('f4'    ,   'f4')
  input:bind('up'   ,    'up')
  input:bind('down' ,  'down')
  input:bind('left' ,  'left')
  input:bind('right', 'right')
  input:bind('w'    ,    'up')
  input:bind('a'    ,  'left')
  input:bind('s'    ,  'down')
  input:bind('d'    , 'right')
  
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
