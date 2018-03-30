local Object = require 'lib/classic/classic'
local Input = require 'lib/input/Input'
local Timer = require 'lib/hump/timer'
local Camera = require 'lib/hump/camera'
local Bump = require 'lib/bump/bump'
local Moses = require 'lib/moses/moses'
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
  moses = Moses
  input = Input()
  
  -- set up our keybindings
  input:bind('f1'    ,     'f1')
  input:bind('f4'    ,     'f4')
  input:bind('mouse1', 'mouse1')
  input:bind('mouse2', 'mouse2')
  input:bind('u'     ,      'u')
  input:bind('up'    ,     'up')
  input:bind('down'  ,   'down')
  input:bind('left'  ,   'left')
  input:bind('right' ,  'right')
  input:bind('w'     ,     'up')
  input:bind('a'     ,   'left')
  input:bind('s'     ,   'down')
  input:bind('d'     ,  'right')
  input:bind('r'     ,      'r')
  
  cursor = love.mouse.newCursor('/resources/crosshair.png', 8, 8)
  love.mouse.setCursor(cursor)

  default_font = love.graphics.newFont(12)

  -- initialize our current room to nil
  current_room = nil
  gotoRoom('Stage')
  timer:every(0.8, function() print(math.ceil(random(9)) .. " -------------") end)
end

function love.update(dt)
  timer:update(dt)
  if current_room then current_room:update(dt) end

  if current_room.player.dead == true then gotoRoom('Stage') end
  --[[
  if input:pressed('r') then
    gotoRoom('Stage')
  end
  --]]

  if input:pressed('f1') then
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
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end


-- **TODO** remove this code that checks memory usage
-- Memory --
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