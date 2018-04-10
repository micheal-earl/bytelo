Object = require '../lib/classic/classic'

Menu = Object:extend()

function Menu:new()
  self.stage_achieved = g_stage_achieved
  g_stage_achieved = 0

  self.scoreFont = love.graphics.newFont(25)

  self.font = love.graphics.newFont(50)
  self.playButton = love.graphics.newText(self.font, "Click here to play")
  self.buttonW, self.buttonH = self.playButton:getDimensions()
  self.buttonX, self.buttonY = 1366/2, 768/2

  self.buttonX, self.buttonY = self.buttonX - self.buttonW/2, self.buttonY - self.buttonH/2
end

function Menu:update(dt)
  if input:pressed('mouse1') then
    local x, y = love.mouse.getPosition()
    if (x > self.buttonX and x < self.buttonX + self.buttonW) and (y > self.buttonY and y < self.buttonY + self.buttonH) then
      gotoRoom('Stage')
    end
  end
end

function Menu:draw()
  love.graphics.setColor(1, 1, 1, 0.8)
  love.graphics.rectangle(
    'fill', 
    self.buttonX - 5, 
    self.buttonY - 5, 
    self.buttonW + 10, 
    self.buttonH + 10
  )
  love.graphics.setColor(0.1, 0.1, 0.1)
  love.graphics.draw(self.playButton, self.buttonX, self.buttonY)
  if g_score > 0 then
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setFont(self.scoreFont)
    love.graphics.printf(
      "Highest Stage Achieved: " .. self.stage_achieved, 
      self.buttonX - 7, 
      self.buttonY + 70, 
      1000, 
      "left"
    )
  end
  love.graphics.setFont(default_font)
  --[[
  if self.highest_score > 0 then
    love.graphics.printf(self.highest_score, 0, 150, 1000, "center")
  end
  --]]
end

--[[
function Menu:gotoRoom(room_type, ...)
  -- Access the global table and set current room to our
  -- global room name + ... which is a number of arguments
  current_room = _G[room_type](...)
end
--]]