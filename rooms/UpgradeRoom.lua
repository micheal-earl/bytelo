Object = require '../lib/classic/classic'

UpgradeRoom = Object:extend()

function UpgradeRoom:new()
  self.name = "UpgradeRoom"
  timer:after(0.6, function() 
    self.buttons = {
      button1 = Button(
        "speed", 
        1366/2, 
        150, 
        function()
          g_speed = g_speed + 100
          print("New speed " .. g_speed)
          gotoRoom('Stage')
        end,
        40
      ),
      button2 = Button(
        "bullet speed", 
        1366/2, 
        300, 
        function()
          g_bullet_speed = g_bullet_speed + 100
          print("New bullet speed " .. g_bullet_speed)
          gotoRoom('Stage')
        end,
        40
      ),
      button3 = Button(
        "reflex", 
        1366/2, 
        450, 
        function()
          g_decay = g_decay + 10
          print("New decay " .. g_decay)
          gotoRoom('Stage')
        end,
        40
      ),
      button4 = Button(
        "score multiplier", 
        1366/2, 
        600, 
        function()
          g_score_multiplier = g_score_multiplier + 1
          print("New multiplier " .. g_score_multiplier)
          gotoRoom('Stage')
        end,
        40
      )
    }
  end)
end

function UpgradeRoom:update(dt)
  --[[
  for _, button in ipairs(self.buttons) do
    button:update(dt)
    print("wtf")
  end
  --]]
  if self.buttons then
    self.buttons.button1:update()
    self.buttons.button2:update()
    self.buttons.button3:update()
    self.buttons.button4:update()
  end
end

function UpgradeRoom:draw()
  --[[
  for _, button in ipairs(self.buttons) do
    button:draw()
  end
  -]]
  if self.buttons then
    self.buttons.button1:draw()
    self.buttons.button2:draw()
    self.buttons.button3:draw()
    self.buttons.button4:draw()
  end
end