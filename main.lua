-- these libs are initialized as "objects"
Input   = require 'lib/input/Input'
Timer   = require 'lib/hump/timer'
Camera  = require 'lib/hump/camera'

-- these libs are tables
Object  = require 'lib/classic/classic'
vector  = require 'lib/hump/vector-light'
physics = require 'lib/bump/bump'
moses   = require 'lib/moses/moses'

require "init"
require 'utils'

function love.load()
  -- randomize our starting seed to make every run unique
  love.math.setRandomSeed(os.time())

  -- global vars for the libs
  timer  = Timer()
  camera = Camera()
  input  = Input()
  
  -- set up the keybindings
  input:bind('f1'    ,     'f1')
  input:bind('f2'    ,     'f2')
  input:bind('f3'    ,     'f3')
  input:bind('f4'    ,     'f4')
  input:bind('mouse1', 'mouse1')
  input:bind('mouse2', 'mouse2')
  input:bind('up'    ,     'up')
  input:bind('down'  ,   'down')
  input:bind('left'  ,   'left')
  input:bind('right' ,  'right')
  input:bind('w'     ,     'up')
  input:bind('a'     ,   'left')
  input:bind('s'     ,   'down')
  input:bind('d'     ,  'right')
  input:bind('f'     ,      'f')
  
  -- change the cursor to a small white crosshair
  cursor = love.mouse.newCursor('/resources/crosshair.png', 8, 8)
  love.mouse.setCursor(cursor)

  -- define the commonly used fonts
  default_font = love.graphics.newFont(12)
  big_font     = love.graphics.newFont(36)

  -- initialize the current room to nil
  current_room = nil

  -- starting room
  gotoRoom('Stage')

  -- change the background color of the canvas
  love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

  -- garbage collection toggle flag
  mem_flag = false
end

function love.update(dt)
  -- update the timer lib
  timer:update(dt)

  -- if we are in a room, draw it
  if current_room then current_room:update(dt) end

  if input:pressed('f3') then
    current_room:destroy()
    gotoRoom('Stage')
  end

  -- garbage collection code
  if input:pressed('f1') then mem_flag = true end
  if input:pressed('f2') then mem_flag = false end
  if mem_flag == true then
    print("Before collection: " .. collectgarbage("count")/1024)
    collectgarbage()
    print("After collection: " .. collectgarbage("count")/1024)
    print("Object count: ")
    local counts = type_count()
    for k, v in pairs(counts) do print(k, v) end
    print("-------------------------------------")
  end
end

function love.draw()
  -- **TODO** Fix drawing layering system (make stuff not draw on top of the wrong things), this is probably going to take a while
  -- if we are in a room, update it
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end

-- **TODO** remove this code that checks memory usage before production
-- **TODO** change this code to make it more readable
function count_all(f)
  local seen = {}
local count_table
count_table = function(t)
  if seen[t] then return end
  f(t)
  seen[t] = true
  for k,v in pairs(t) do
    if type(v) == "table" then
      count_table(v)
    elseif type(v) == "userdata" then
      f(v)
    end
  end
end
count_table(_G)
end

function type_count()
  local counts = {}
  local enumerate = function (o)
    local t = type_name(o)
    counts[t] = (counts[t] or 0) + 1
  end
  count_all(enumerate)
  return counts
end

global_type_table = nil
function type_name(o)
	if global_type_table == nil then
		global_type_table = {}
		for k,v in pairs(_G) do
			global_type_table[v] = k
		end
		global_type_table[0] = "table"
	end
	return global_type_table[getmetatable(o) or 0] or "Unknown"
end