Object = require '../lib/classic/classic'

Button = Object:extend()

function Button:new(text, buttonX, buttonY, func, fontsize)
  self.font = love.graphics.newFont(fontsize)
  self.button = love.graphics.newText(self.font, text)
  self.buttonW, self.buttonH = self.button:getDimensions()
  self.buttonX, self.buttonY = buttonX, buttonY
  self.buttonX, self.buttonY = self.buttonX - self.buttonW/2, self.buttonY - self.buttonH/2
  self.func = func
end

function Button:update(dt)
  if input:pressed('mouse1') then
    local x, y = love.mouse.getPosition()
    if (x > self.buttonX and x < self.buttonX + self.buttonW) and (y > self.buttonY and y < self.buttonY + self.buttonH) then
      self.func()
    end
  end
end

function Button:draw()
  love.graphics.setColor(255, 255, 255, 200)
  love.graphics.rectangle(
    'fill', 
    self.buttonX - 5, 
    self.buttonY - 5, 
    self.buttonW + 10, 
    self.buttonH + 10
  )
  love.graphics.setColor(20, 20, 20)
  love.graphics.draw(self.button, self.buttonX, self.buttonY)
  love.graphics.setFont(default_font)
end