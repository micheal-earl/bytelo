Object = require '../lib/classic/classic'
Timer = require '../lib/hump/timer/timer'
moses = require '../lib/moses/moses'

Area = Object:extend()

function Area:new(room)
  self.room = room
  self.game_objects = {}
end

function Area:update(dt)
  --for _, game_object in ipairs(self.game_objects) do game_object:update(dt) end
  
  for i = #self.game_objects, 1, -1 do
      local game_object = self.game_objects[i]
      game_object:update(dt)
      if game_object.dead then 
        table.remove(self.game_objects, i) 
      end
  end

  self:queryCircleArea(0, 0, 0, {'Circle', 'Rect', 'Meme'})
end

function Area:draw()
  for _, game_object in ipairs(self.game_objects) do game_object:draw(dt) end
end

function Area:addGameObject(game_object_type, x, y, opts)
  local opts = opts or {}
  local game_object = _G[game_object_type](self, x or 0, y or 0, opts)

  game_object.class = game_object_type

  table.insert(self.game_objects, game_object)
  return game_object
end

function Area:queryCircleArea(x, y, radius, object_types)
  for _, game_object in ipairs(self.game_objects) do
    if moses.any(object_types, game_object.class) then
      print(game_object.class)
    end
  end
end