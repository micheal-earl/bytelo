Object = require '../lib/classic/classic'

UpgradeRoom = Object:extend()

function UpgradeRoom:new()
  self.buttons = {
    button1 = Button(
      "speed", 
      1366/2, 
      200, 
      function()
        g_speed = g_speed + 50
        print("New speed " .. g_speed)
      end
    ),
    button2 = Button(
      "bullet speed", 
      1366/2, 
      400, 
      function()
        g_bullet_speed = g_bullet_speed + 50
        print("New bullet speed " .. g_bullet_speed)
      end
    ),
    button3 = Button(
      "reflex", 
      1366/2, 
      600, 
      function()
        g_decay = g_decay + 5
        print("New decay " .. g_decay)
      end
    )
  }
end

function UpgradeRoom:update(dt)
  --[[
  for _, button in ipairs(self.buttons) do
    button:update(dt)
    print("wtf")
  end
  --]]
  self.buttons.button1:update()
  self.buttons.button2:update()
  self.buttons.button3:update()
end

function UpgradeRoom:draw()
  --[[
  for _, button in ipairs(self.buttons) do
    button:draw()
  end
  -]]
  self.buttons.button1:draw()
  self.buttons.button2:draw()
  self.buttons.button3:draw()
end