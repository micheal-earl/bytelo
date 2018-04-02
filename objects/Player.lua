local Object = require '../lib/classic/classic'

Player = GameObject:extend()

function Player:new(area, x, y, opts)
  Player.super.new(self, area, x, y, opts)

  -- physics
  self.collider = self.area.world:add(self, self.x, self.y, 20, 20)

  -- shape
  self.width = 20
  self.height = 20

  -- movement stuff
  self.vx, self.vy = 0, 0
  self.speed = 300
  self.decay = 60

  -- gun stuff
  self.bullet_amt = 1
  self.fire_rate = 0.4
  self.ups = 0

  -- test stuff
  offsetX = self.width/2
  offsetY = self.height/2

  -- maybe handle this in stage, idk
  self.score = 0
end

function Player:update(dt)
  Player.super.update(self, dt)
  if not self.dead then self:handleInput(dt) end
end

function Player:draw()
  love.graphics.setColor(0, 255, 255)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  --love.graphics.line(self.x, self.y, self.x + 20, self.y + 20)
  love.graphics.setColor(255, 255, 255, 25)
  self:drawGun()
  -- draw inside
  love.graphics.setColor(0, 255, 255, 50)
  love.graphics.rectangle('fill', self.x + 1, self.y + 1, 
                          self.width - 1, self.height - 1)
  love.graphics.setColor(255, 255, 255)
end

function Player:drawGun()
  local x, y = love.mouse.getPosition()
  local angle = math.atan2((x - self.x), (y - self.y))
  love.graphics.line(self.x + 10, self.y + 10, x, y)
  --self.dx = self.bullet_speed * math.sin(self.angle)
  --self.dy = self.bullet_speed * math.cos(self.angle)

  --self.x = self.x + self.width/2 + math.sin(self.angle) * 25
  --self.y = self.y + self.height/2 + math.cos(self.angle) * 25
end

-----------------------------------------------------
function Player:handleInput(dt)

  local function filter(item, other)
    if     other.class == 'Upgrade' then
      return 'cross'
    elseif other.class == 'Enemy'   then 
      return 'cross'
    elseif other.class == 'Bullet'  then 
      return 'cross'
    --elseif other.isSpring then return 'bounce'
    end
    --return "cross"
  end

  local goalX, goalY = self.x + self.vx * dt, self.y + self.vy * dt
  local actualX, actualY, cols, len = self.area.world:move(self, goalX, goalY, filter)
  self.x, self.y = actualX, actualY

  -- **TODO** Fix fire rate bug
  if input:down('mouse1', self.fire_rate)  then
    local x, y = love.mouse.getPosition()
    print(self.fire_rate)
    -- this if statement removes super saiyan cheese
    if(distance(x, y, self.x + offsetX, self.y + offsetY)) > 30 then
      for i = 1, self.bullet_amt do
        self.area:addGameObject('Bullet', self.x + 5, self.y + 5, 
        {6, 6, x, y, 650}, 'player_bullet')
      end
    end
  end

	if input:down('up') then 
		self.vy = -self.speed
	elseif input:down('down') then 
		self.vy = self.speed
	elseif(self.vy < 0) then
		self.vy = self.vy + self.decay
	elseif(self.vy > 0) then
		self.vy = self.vy - self.decay
	end

	if input:down('left') then 
		self.vx = -self.speed
	elseif input:down('right') then 
		self.vx = self.speed
	elseif(self.vx < 0) then
		self.vx = self.vx + self.decay
	elseif(self.vx > 0) then
		self.vx = self.vx - self.decay
  end

  -- **TODO** handle collision in it's own function?
  for i = 1, len do
    print('collide ' .. tostring(cols[i].other.class))
    obj = cols[i].other
    if obj.class == "Enemy" then self.dead = true end
    if obj.class == "Upgrade" then self:upgrade(obj) end
  end
end

function Player:upgrade(upgrade_object)
  upgrade_object.dead = true
  self.ups = self.ups - 1
  self.score = self.score + 10
  if self.fire_rate > 0.06 then 
    self.fire_rate = self.fire_rate - 0.05 
    self.area:addGameObject('Notify', self.x - 100, self.y - 50, {"Fire rate up!", 30})
  else
    self.area:addGameObject('Notify', self.x - 100, self.y - 50, {"Max fire rate!", 30})
  end
  self.area:addGameObject('Notify', self.x - 50, self.y - 20, {"+10", 20, 5, 0.4})
end

function Player:outOfBounds()
  if self.y > window_height or self.y < 0 then
    return true
  elseif self.x > window_width or self.x < 0 then
    return true
  else
    return false
  end
end