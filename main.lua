Object = require 'lib/classic/classic'
Input = require 'lib/input/Input'
Timer = require 'lib/hump/timer/timer'
require 'objects/Circle'

function love.load()
  input = Input()
  input:bind('right', 'rArrow')
  input:bind('left', 'lArrow')
  input:bind('up', 'uArrow')
  input:bind('down', 'dArrow')
  
  circle = Circle(50, 50, 25)
  --hyperCircle = HyperCircle(400, 300, 50, 120, 10)
  
  --[[
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)
  ]]--
  
end

function love.update(dt)
  if input:pressed('rArrow') then circle.x = circle.x + 50 end
  if input:pressed('lArrow') then circle.x = circle.x - 50 end
  if input:pressed('uArrow') then circle.y = circle.y - 50 end
  if input:pressed('dArrow') then circle.y = circle.y + 50 end
  --if input:released('mouse1') then print('released') end
  --if input:down('mouse1', 0.5)     then print('down')     end
  
  
end

function love.draw()
  circle:draw()
end

--[[
function love.update(dt)
  
end

function love.draw()
  love.graphics.draw(image, 400, 100)
end
--]]

--[[
function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end
--]]