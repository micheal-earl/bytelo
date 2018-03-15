Object = require 'lib/classic/classic'
Input = require 'lib/input/Input'
Timer = require 'lib/hump/timer/timer'
require 'lib/utils'
require 'objects/GameObject'
require 'objects/Area'
require 'objects/Stage'
require 'objects/Circle'
require 'objects/CircleRoom'
require 'objects/PolyRoom'
require 'objects/RectRoom'

function love.load()
  -- Randomize our seed so that random functions
  -- Are different every time the game is run
  love.math.random(os.time())
  
  timer = Timer()
  
  input = Input()
  input:bind('f1', 'f1')
  input:bind('f2', 'f2')
  input:bind('f3', 'f3')
  
  --circle_object = Circle(400, 300, 100)
  room = Stage()
  area = Area(room)
  

  area:addGameObject('Circle', 400, 300, 50)
  timer:after(2, function() area.game_objects[1].dead = true end)
  timer:after(2, function() print(area.game_objects[1].dead) end)
  
  
  current_room = nil
  
end

function love.update(dt)
  timer:update(dt)
  if current_room then current_room:update(dt) end
  
  if input:pressed('f1') then gotoRoom('RectRoom')   end
  if input:pressed('f2') then gotoRoom('PolyRoom')   end
  if input:pressed('f3') then gotoRoom('CircleRoom') end
end

function love.draw()
  if current_room then current_room:draw() end
  area:draw()
  
  --circle_object:draw()
end

function gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end
