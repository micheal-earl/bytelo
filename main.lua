Object = require 'lib/classic/classic'
Input = require 'lib/input/Input'
require 'objects/Circle'

function love.load()
  input = Input()
  input:bind('mouse1', 'mouse1')
  input:bind('mouse2', 'mouse1')
  sum = 0
  --circle = Circle(150, 100, 50)
  --hyperCircle = HyperCircle(400, 300, 50, 120, 10)
  
  --[[
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)
  ]]--
  
end

function love.update(dt)
  if input:down('mouse1', 0.5) then 
    sum = sum + 1
    print(sum)  
  end
  --if input:released('mouse1') then print('released') end
  --if input:down('mouse1', 0.5)     then print('down')     end
end

function love.draw()
  --circle:draw()
  --hyperCircle:draw()
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